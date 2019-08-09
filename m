Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B760880C8
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437167AbfHIRF4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 13:05:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50393 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437068AbfHIRF4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 13:05:56 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw8Kv-0006sR-Jg; Fri, 09 Aug 2019 19:05:53 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw8Kt-0005f5-Fn; Fri, 09 Aug 2019 19:05:51 +0200
Date:   Fri, 9 Aug 2019 19:05:51 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
Message-ID: <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190809123031.24219-5-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil wrote:
> The previous algorithm hardcoded details about how the TCU clocks work.
> The new algorithm will use clk_round_rate to find the perfect clock rate
> for the PWM channel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/pwm/pwm-jz4740.c | 60 +++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 6ec8794d3b99..f20dc2e19240 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -110,24 +110,56 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
>  	struct clk *clk = pwm_get_chip_data(pwm),
>  		   *parent_clk = clk_get_parent(clk);
> -	unsigned long rate, period, duty;
> +	unsigned long rate, parent_rate, period, duty;
>  	unsigned long long tmp;
> -	unsigned int prescaler = 0;
> +	int ret;
>  
> -	rate = clk_get_rate(parent_clk);
> -	tmp = (unsigned long long)rate * state->period;
> -	do_div(tmp, 1000000000);
> -	period = tmp;
> +	parent_rate = clk_get_rate(parent_clk);
> +
> +	jz4740_pwm_disable(chip, pwm);
>  
> -	while (period > 0xffff && prescaler < 6) {
> -		period >>= 2;
> -		rate >>= 2;
> -		++prescaler;
> +	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
> +	ret = clk_set_max_rate(clk, parent_rate);

What is the purpose of this call? IIUC this limits the allowed range of
rates for clk. I assume the idea is to prevent other consumers to change
the rate in a way that makes it unsuitable for this pwm. But this only
makes sense if you had a notifier for clk changes, doesn't it? I'm
confused.

I think this doesn't match the commit log, you didn't even introduced a
call to clk_round_rate().

> +	if (ret) {
> +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
> +		return ret;
>  	}
>  
> -	if (prescaler == 6)
> -		return -EINVAL;
> +	ret = clk_set_rate(clk, parent_rate);
> +	if (ret) {
> +		dev_err(chip->dev, "Unable to reset to parent rate (%lu Hz)",
> +			parent_rate);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Limit the clock to a maximum rate that still gives us a period value
> +	 * which fits in 16 bits.
> +	 */
> +	tmp = 0xffffull * NSEC_PER_SEC;
> +	do_div(tmp, state->period);
>  
> +	ret = clk_set_max_rate(clk, tmp);

And now you change the maximal rate again?

> +	if (ret) {
> +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Read back the clock rate, as it may have been modified by
> +	 * clk_set_max_rate()
> +	 */
> +	rate = clk_get_rate(clk);
> +
> +	if (rate != parent_rate)
> +		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
> +
> +	/* Calculate period value */
> +	tmp = (unsigned long long)rate * state->period;
> +	do_div(tmp, NSEC_PER_SEC);
> +	period = (unsigned long)tmp;
> +
> +	/* Calculate duty value */
>  	tmp = (unsigned long long)period * state->duty_cycle;
>  	do_div(tmp, state->period);
>  	duty = period - tmp;
> @@ -135,14 +167,10 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (duty >= period)
>  		duty = period - 1;
>  
> -	jz4740_pwm_disable(chip, pwm);
> -
>  	/* Set abrupt shutdown */
>  	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>  			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
>  
> -	clk_set_rate(clk, rate);
> -

It's not obvious to me why removing these two lines belong in the
current patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
