Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3812B1E012A
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2020 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbgEXRfd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 May 2020 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXRfd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 13:35:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A52C061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 10:35:32 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcuX2-0008V7-F0; Sun, 24 May 2020 19:35:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcuX1-0002Rf-8g; Sun, 24 May 2020 19:35:27 +0200
Date:   Sun, 24 May 2020 19:35:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: jz4740: Make PWM start with the active part
Message-ID: <20200524173527.xlie3iycszvtugam@pengutronix.de>
References: <20200413121445.72996-1-paul@crapouillou.net>
 <20200413121445.72996-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200413121445.72996-2-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 13, 2020 at 02:14:44PM +0200, Paul Cercueil wrote:
> The PWM would previously always start with the inactive part.
> To counter that, the common trick is to use an inverted duty as the
> real duty (as in, 'period - duty'), and invert the polarity when the
> PWM is enabled.
> 
> However, for some reason the driver was already configuring the hardware
> for an inverted duty, so inverting it again means we do configure the
> hardware with the actual duty value.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 3cd5c054ad9a..f566f9d248d6 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -6,7 +6,6 @@
>   * Limitations:
>   * - The .apply callback doesn't complete the currently running period before
>   *   reconfiguring the hardware.
> - * - Each period starts with the inactive part.
>   */
>  
>  #include <linux/clk.h>
> @@ -163,7 +162,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,

Side note: in the calculation above the driver is loosing precision as
the calculation for the duty counter uses the (already rounded) stuff
for the period counter.

The currently used calculation is (somewhat simplified syntax):

	period = (rate * requested_period) // NSEC_PER_SEC;
	duty = (period * requested_duty) // requested_period

The output then is an actual period of

	period * NSEC_PER_SEC / rate

and the duty cycle is

	duty * NSEC_PER_SEC / rate

.

Consider the following:

	rate = 23856100
	requested_period = 20959
	requested_duty = 16000

With the currently implemented algorithm we get:

	period = 499
	duty = 380

yielding a real period of 20917.08 ns (ok) and a duty cycle of 15928.84
ns. With duty = 381 we'd get 15970.758 ns which is better.

To reach that we'd need:

	/* Calculate duty value */
	tmp = (unsigned long long)rate * state->duty_cycle;
	do_div(tmp, NSEC_PER_SEC);
	duty = tmp

>  	/* Calculate duty value */
>  	tmp = (unsigned long long)period * state->duty_cycle;
>  	do_div(tmp, state->period);
> -	duty = period - tmp;
> +	duty = (unsigned long)tmp;

That cast is unnecessary.

>  
>  	if (duty >= period)
>  		duty = period - 1;
> @@ -190,17 +189,13 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
>  
>  	/* Set polarity */
> -	switch (state->polarity) {
> -	case PWM_POLARITY_NORMAL:
> +	if ((state->polarity != PWM_POLARITY_INVERSED) ^ state->enabled)

This needs to be more complicated than before as a disabled PWM needs
the other setting to yield its inactive level?

Maybe worth a comment?

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

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
