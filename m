Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349651C47B3
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2020 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgEDULu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 May 2020 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDULt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 May 2020 16:11:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEACC061A0E
        for <linux-pwm@vger.kernel.org>; Mon,  4 May 2020 13:11:49 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jVhR6-0002Pb-1u; Mon, 04 May 2020 22:11:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jVhR5-0007po-DD; Mon, 04 May 2020 22:11:31 +0200
Date:   Mon, 4 May 2020 22:11:31 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, robh+dt@kernel.org, jonathanh@nvidia.com,
        bbasu@nvidia.com, ldewangan@nvidia.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Message-ID: <20200504201131.l5ofxem3owrl5siv@pengutronix.de>
References: <1587398043-18767-1-git-send-email-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587398043-18767-1-git-send-email-spatra@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Apr 20, 2020 at 09:24:03PM +0530, Sandipan Patra wrote:
> Added support for dynamic clock freq configuration in pwm kernel driver.
> Earlier the pwm driver used to cache boot time clock rate by pwm clock
> parent during probe. Hence dynamically changing pwm frequency was not
> possible for all the possible ranges. With this change, dynamic calculation
> is enabled and it is able to set the requested period from sysfs knob
> provided the value is supported by clock source.
> 
> Changes mainly have 2 parts:
>   - T186 and later chips [1]
>   - T210 and prior chips [2]
> 
> For [1] - Changes implemented to set pwm period dynamically and
>           also checks added to allow only if requested period(ns) is
>           below or equals to higher range.
> 
> For [2] - Only checks if the requested period(ns) is below or equals
>           to higher range defined by max clock limit. The limitation
>           in T210 or prior chips are due to the reason of having only
>           one pwm-controller supporting multiple channels. But later
>           chips have multiple pwm controller instances each having
> 	  single channel support.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> V2:
> 1. Min period_ns calculation is moved to probe.
> 2. Added descriptioins for PWM register bits and regarding behaviour
>    of the controller when new configuration is applied or pwm is disabled.
> 3. Setting period with possible value when supplied period is below limit.
> 4. Corrected the earlier code comment:
>    plus 1 instead of minus 1 during pwm calculation
> 
>  drivers/pwm/pwm-tegra.c | 110 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index d26ed8f..7a36325 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -4,8 +4,39 @@
>   *
>   * Tegra pulse-width-modulation controller driver
>   *
> - * Copyright (c) 2010, NVIDIA Corporation.
> - * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
> + * Copyright (c) 2010-2020, NVIDIA Corporation.
> + *
> + * Overview of Tegra Pulse Width Modulator Register:
> + * 1. 13-bit: Frequency division (SCALE)
> + * 2. 8-bit : Puls division (DUTY)
> + * 3. 1-bit : Enable bit
> + *
> + * The PWM clock frequency is divided by 256 before subdividing it based
> + * on the programmable frequency division value to generate the required
> + * frequency for PWM output. The maximum output frequency that can be
> + * achieved is (max rate of source clock) / 256.
> + * i.e. if source clock rate is 408 MHz, maximum output frequency cab be:

s/i.e./e.g./, s/cab/can/

> + * 408 MHz/256 = 1.6 MHz.
> + * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
> + *
> + * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
> + * To achieve 100% duty cycle, program Bit [24] of this register to
> + * 1’b1. In which case the other bits [23:16] are set to don't care.
> + *
> + * Limitations and known facts:

Please use "Limitations:" here to make this easier greppable.

> + * -	When PWM is disabled, the output is driven to 0.

0 or inactive?

> + * -	It does not allow the current PWM period to complete and
> + *	stops abruptly.
> + *
> + * -	If the register is reconfigured while pwm is running,

s/pwm/PWM/

> + *	It does not let the currently running period to complete.

s/It/it/; s/let/complete/; s/ to complete//

> + *
> + * -	Pulse width of the pwm can never be out of bound.

I don't understand that one.

> + *	It's taken care at HW and SW
> + * -	If the user input duty is below limit, then driver sets it to
> + *	minimum possible value.

that is 0? Do you mean "input period"? If so, better refuse the request.

> + * -	If anything else goes wrong for setting duty or period,
> + *	-EINVAL is returned.

I wouldn't state this, too trivial. Instead the following are
interesting:

 - The driver doesn't implement the right rounding rules
 - The driver needs updating to the atomic API

>   */
>  
>  #include <linux/clk.h>
> @@ -41,6 +72,7 @@ struct tegra_pwm_chip {
>  	struct reset_control*rst;
>  
>  	unsigned long clk_rate;
> +	unsigned long min_period_ns;
>  
>  	void __iomem *regs;
>  
> @@ -67,8 +99,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    int duty_ns, int period_ns)
>  {
>  	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
> -	unsigned long long c = duty_ns, hz;
> -	unsigned long rate;
> +	unsigned long long p_width = duty_ns, period_hz;
> +	unsigned long rate, required_clk_rate;
> +	unsigned long pfm; /* Frequency divider */
>  	u32 val = 0;
>  	int err;
>  
> @@ -77,37 +110,77 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
>  	 * nearest integer during division.
>  	 */
> -	c *= (1 << PWM_DUTY_WIDTH);
> -	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
> +	p_width *= (1 << PWM_DUTY_WIDTH);
> +	p_width = DIV_ROUND_CLOSEST_ULL(p_width, period_ns);
>  
> -	val = (u32)c << PWM_DUTY_SHIFT;
> +	val = (u32)p_width << PWM_DUTY_SHIFT;
> +
> +	/*
> +	 *  Period in nano second has to be <= highest allowed period
> +	 *  based on max clock rate of the pwm controller.
> +	 *
> +	 *  higher limit = max clock limit >> PWM_DUTY_WIDTH
> +	 *  lower limit = min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDTH
> +	 */
> +	if (period_ns < pc->min_period_ns) {
> +		period_ns = pc->min_period_ns;
> +		pr_warn("Period is adjusted to allowed value (%d ns)\n",
> +				period_ns);

That pr_warn is a bad idea as it spams the kernel log when the
configuration is changed frequently. Wouldn't it be easier to calculate
the frequency that is needed to achieve period_ns and check that against
max_frequency?

> +	}
>  
>  	/*
>  	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
>  	 */
> -	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
> +	if (pc->soc->num_channels == 1) {

required_clk_rate could be defined here, which is better as it narrows
its scope.

> +		/*
> +		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
> +		 * with the hieghest applicable rate that the controller can

s/hieghest/highest/

> +		 * provide. Any further lower value can be derived by setting
> +		 * PFM bits[0:12].
> +		 * Higher mark is taken since BPMP has round-up mechanism
> +		 * implemented.

I don't understand the part with the round-up mechanism.

> +		 */
> +		required_clk_rate =
> +			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
> +
> +		err = clk_set_rate(pc->clk, required_clk_rate);
> +		if (err < 0)
> +			return -EINVAL;

What happens if clk_set_rate configures a higher rate than requested?

> +
> +		rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
> +	} else {
> +		/*
> +		 * This is the case for SoCs who support multiple channels:

s/who/that/

> +		 *
> +		 * clk_set_rate() can not be called again in config because
> +		 * T210 or any prior chip supports one pwm-controller and
> +		 * multiple channels. Hence in this case cached clock rate
> +		 * will be considered which was stored during probe.
> +		 */
> +		rate = pc->clk_rate >> PWM_DUTY_WIDTH;
> +	}
>  
>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> -	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> -	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> +	period_hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> +	pfm = DIV_ROUND_CLOSEST_ULL(100ULL * rate, period_hz);
>  
>  	/*
>  	 * Since the actual PWM divider is the register's frequency divider
> -	 * field minus 1, we need to decrement to get the correct value to
> +	 * field plus 1, we need to decrement to get the correct value to
>  	 * write to the register.
>  	 */
> -	if (rate > 0)
> -		rate--;
> +	if (pfm > 0)
> +		pfm--;
>  
>  	/*
> -	 * Make sure that the rate will fit in the register's frequency
> +	 * Make sure that pfm will fit in the register's frequency
>  	 * divider field.
>  	 */
> -	if (rate >> PWM_SCALE_WIDTH)
> +	if (pfm >> PWM_SCALE_WIDTH)
>  		return -EINVAL;
>  
> -	val |= rate << PWM_SCALE_SHIFT;
> +	val |= pfm << PWM_SCALE_SHIFT;
>  
>  	/*
>  	 * If the PWM channel is disabled, make sure to turn on the clock
> @@ -205,6 +278,10 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>  	 */
>  	pwm->clk_rate = clk_get_rate(pwm->clk);
>  
> +	/* Set minimum limit of PWM period for the IP */
> +	pwm->min_period_ns =
> +	    (NSEC_PER_SEC / (pwm->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;

With my suggestion above, you can drop the min_period_ns field.

> +
>  	pwm->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
>  	if (IS_ERR(pwm->rst)) {
>  		ret = PTR_ERR(pwm->rst);
> @@ -313,4 +390,5 @@ module_platform_driver(tegra_pwm_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("NVIDIA Corporation");
> +MODULE_AUTHOR("Sandipan Patra <spatra@nvidia.com>");
>  MODULE_ALIAS("platform:tegra-pwm");

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
