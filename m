Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33C4880F3
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437256AbfHIRLC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 13:11:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51995 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437252AbfHIRLC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 13:11:02 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw8Pq-0007mJ-Pz; Fri, 09 Aug 2019 19:10:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw8Pq-0005n4-6q; Fri, 09 Aug 2019 19:10:58 +0200
Date:   Fri, 9 Aug 2019 19:10:58 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
Message-ID: <20190809171058.gothydohec6qx7hu@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190809123031.24219-7-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 09, 2019 at 02:30:30PM +0200, Paul Cercueil wrote:
> The PWM will always start with the inactive part. To counter that,
> when PWM is enabled we switch the configured polarity, and use
> 'period - duty + 1' as the real duty.

Where does the + 1 come from? This looks wrong. (So if duty=0 is
requested you use duty = period + 1?)

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 85e2110aae4f..8df898429d47 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -121,6 +121,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		   *parent_clk = clk_get_parent(clk);
>  	unsigned long rate, parent_rate, period, duty;
>  	unsigned long long tmp;
> +	bool polarity_inversed;
>  	int ret;
>  
>  	parent_rate = clk_get_rate(parent_clk);
> @@ -183,24 +184,27 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	/* Reset counter to 0 */
>  	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
>  
> -	/* Set duty */
> -	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
> -
>  	/* Set period */
>  	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
>  
> +	/*
> +	 * The PWM will always start with the inactive part. To counter that,
> +	 * when PWM is enabled we switch the configured polarity, and use
> +	 * 'period - duty + 1' as the real duty.
> +	 */
> +
> +	/* Set duty */
> +	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), period - duty + 1);
> +

Before you set duty first, then period, now you do it the other way
round. Is there a good reason?

>  	/* Set polarity */
> -	switch (state->polarity) {
> -	case PWM_POLARITY_NORMAL:
> +	polarity_inversed = state->polarity == PWM_POLARITY_INVERSED;
> +	if (!polarity_inversed ^ state->enabled)

Why does state->enabled suddenly matter here?

>  		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>  				   TCU_TCSR_PWM_INITL_HIGH, 0);
> -		break;
> -	case PWM_POLARITY_INVERSED:
> +	else
>  		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>  				   TCU_TCSR_PWM_INITL_HIGH,
>  				   TCU_TCSR_PWM_INITL_HIGH);
> -		break;
> -	}
>  
>  	if (state->enabled)
>  		jz4740_pwm_enable(chip, pwm);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
