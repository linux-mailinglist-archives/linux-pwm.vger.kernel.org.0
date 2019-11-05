Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D1F0069
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfKEO5I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 09:57:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34201 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389183AbfKEO5I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 09:57:08 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iS0GS-0000O7-JN; Tue, 05 Nov 2019 15:57:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iS0GR-0001YE-Ba; Tue, 05 Nov 2019 15:56:59 +0100
Date:   Tue, 5 Nov 2019 15:56:59 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock
 directly
Message-ID: <20191105145659.ffezqntodsys4phn@pengutronix.de>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105131456.32400-5-peron.clem@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 02:14:53PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> PWM core has an option to bypass whole logic and output unchanged source
> clock as PWM output. This is achieved by enabling bypass bit.
> 
> Note that when bypass is enabled, no other setting has any meaning, not
> even enable bit.
> 
> This mode of operation is needed to achieve high enough frequency to
> serve as clock source for AC200 chip which is integrated into same
> package as H6 SoC.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 54e19fa56a4e..810abf47c261 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -3,6 +3,10 @@
>   * Driver for Allwinner sun4i Pulse Width Modulation Controller
>   *
>   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electrons.com>
> + *
> + * Limitations:
> + * - When outputing the source clock directly, the PWM logic will be bypassed
> + *   and the currently running period is not guaranteed to be completed
>   */
>  
>  #include <linux/bitops.h>
> @@ -73,6 +77,7 @@ static const u32 prescaler_table[] = {
>  
>  struct sun4i_pwm_data {
>  	bool has_prescaler_bypass;
> +	bool has_direct_mod_clk_output;
>  	unsigned int npwm;
>  };
>  
> @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
>  
>  	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  
> +	/*
> +	 * PWM chapter in H6 manual has a diagram which explains that if bypass
> +	 * bit is set, no other setting has any meaning. Even more, experiment
> +	 * proved that also enable bit is ignored in this case.
> +	 */
> +	if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> +	    sun4i_pwm->data->has_direct_mod_clk_output) {
> +		state->period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
> +		state->duty_cycle = state->period / 2;

Please round up here.

> +		state->polarity = PWM_POLARITY_NORMAL;
> +		state->enabled = true;
> +		return;
> +	}
> +
>  	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
>  	    sun4i_pwm->data->has_prescaler_bypass)
>  		prescaler = 1;
> @@ -203,7 +222,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
>  	struct pwm_state cstate;
> -	u32 ctrl;
> +	u32 ctrl, clk_rate;
> +	bool bypass;
>  	int ret;
>  	unsigned int delay_us;
>  	unsigned long now;
> @@ -218,6 +238,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		}
>  	}
>  
> +	/*
> +	 * Although it would make much more sense to check for bypass in
> +	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
> +	 */
> +	clk_rate = clk_get_rate(sun4i_pwm->clk);

clk_get_rate must not be called if the clk might be off.

> +	bypass = state->enabled &&
> +		 (state->period * clk_rate >= NSEC_PER_SEC) &&

This is too coarse. With state->period = 1000000 this is fulfilled
(unless the multiplication overflows).

> +		 (state->duty_cycle * 2 == state->period);

This is too strict. See my previous mail about how this should be done.

If bypass is true (and the hardware support it) you can skip the
calculation of the other parameters.

> +
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  
> @@ -265,6 +294,13 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>  	}
>  
> +	if (sun4i_pwm->data->has_direct_mod_clk_output) {
> +		if (bypass)
> +			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
> +		else
> +			ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> +	}
> +
>  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  
>  	spin_unlock(&sun4i_pwm->ctrl_lock);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
