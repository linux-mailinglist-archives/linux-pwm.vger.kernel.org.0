Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711A4104CAF
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 08:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUHg4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 02:36:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42871 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUHg4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 02:36:56 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iXh1E-0000NT-Go; Thu, 21 Nov 2019 08:36:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iXh1D-0002Ow-69; Thu, 21 Nov 2019 08:36:47 +0100
Date:   Thu, 21 Nov 2019 08:36:47 +0100
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de
Subject: Re: [PATCH v7 5/8] pwm: sun4i: Add support to output source clock
 directly
Message-ID: <20191121073647.phutknyb3tzp44ye@pengutronix.de>
References: <20191119175319.16561-1-peron.clem@gmail.com>
 <20191119175319.16561-6-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119175319.16561-6-peron.clem@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Clément,

On Tue, Nov 19, 2019 at 06:53:16PM +0100, Clément Péron wrote:
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
>  drivers/pwm/pwm-sun4i.c | 92 ++++++++++++++++++++++++++++-------------
>  1 file changed, 64 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index ce83d479ba0e..a1d8851b18f0 100644
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
> +		state->duty_cycle = DIV_ROUND_UP_ULL(state->period, 2);
> +		state->polarity = PWM_POLARITY_NORMAL;
> +		state->enabled = true;
> +		return;
> +	}
> +
>  	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
>  	    sun4i_pwm->data->has_prescaler_bypass)
>  		prescaler = 1;
> @@ -149,13 +168,23 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
>  
>  static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
>  			       const struct pwm_state *state,
> -			       u32 *dty, u32 *prd, unsigned int *prsclr)
> +			       u32 *dty, u32 *prd, unsigned int *prsclr,
> +			       bool *bypass)
>  {
>  	u64 clk_rate, div = 0;
>  	unsigned int pval, prescaler = 0;
>  
>  	clk_rate = clk_get_rate(sun4i_pwm->clk);
>  
> +	*bypass = state->enabled &&
> +		  (state->period * clk_rate >= NSEC_PER_SEC) &&
> +		  (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> +		  (state->duty_cycle * clk_rate * 2 >= NSEC_PER_SEC);
> +
> +	/* Skip calculation of other parameters if we bypass them */
> +	if (*bypass && sun4i_pwm->data->has_direct_mod_clk_output)
> +		return 0;
> +

Hmm, so if my PWM doesn't support the bypass bit *bypass might still be
true on return of sun4i_pwm_calculate. It doesn't hurt because the value
is only used after another check of has_direct_mod_clk_output, but still
this is a bit confusing.

>  	if (sun4i_pwm->data->has_prescaler_bypass) {
>  		/* First, test without any prescaler when available */
>  		prescaler = PWM_PRESCAL_MASK;
> @@ -202,10 +231,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
>  	struct pwm_state cstate;
> -	u32 ctrl;
> +	u32 ctrl, period, duty, val;
>  	int ret;
> -	unsigned int delay_us;
> +	unsigned int delay_us, prescaler;
>  	unsigned long now;
> +	bool bypass;
>  
>  	pwm_get_state(pwm, &cstate);
>  
> @@ -220,43 +250,48 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  
> -	if ((cstate.period != state->period) ||
> -	    (cstate.duty_cycle != state->duty_cycle)) {
> -		u32 period, duty, val;
> -		unsigned int prescaler;
> +	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
> +				  &bypass);
> +	if (ret) {
> +		dev_err(chip->dev, "period exceeds the maximum value\n");
> +		spin_unlock(&sun4i_pwm->ctrl_lock);
> +		if (!cstate.enabled)
> +			clk_disable_unprepare(sun4i_pwm->clk);
> +		return ret;
> +	}
>  
> -		ret = sun4i_pwm_calculate(sun4i_pwm, state,
> -					  &duty, &period, &prescaler);
> -		if (ret) {
> -			dev_err(chip->dev, "period exceeds the maximum value\n");
> -			spin_unlock(&sun4i_pwm->ctrl_lock);
> -			if (!cstate.enabled)
> -				clk_disable_unprepare(sun4i_pwm->clk);
> -			return ret;

This would be a bit easier to review if this commit was split into two
patches. One that drops the check for cstate.period != state->period etc
(which otherwise is nearly empty when ignoring whitespace changes), and
a second that then adds bypass support.


> +	if (sun4i_pwm->data->has_direct_mod_clk_output) {
> +		if (bypass) {
> +			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
> +			/* We can skip apply of other parameters */
> +			goto bypass_mode;

I would prefer to use goto only for error handling. Not sure if there is
a nice way to do that.

> +		} else {
> +			ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
>  		}
> +	}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
