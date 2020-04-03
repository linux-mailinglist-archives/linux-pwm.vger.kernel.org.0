Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D3019D9CD
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbgDCPLE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 11:11:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49331 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404135AbgDCPLD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 11:11:03 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jKNy7-0005GW-Ki; Fri, 03 Apr 2020 17:10:51 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jKNy7-0007wC-2O; Fri, 03 Apr 2020 17:10:51 +0200
Date:   Fri, 3 Apr 2020 17:10:51 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, robh+dt@kernel.org, jonathanh@nvidia.com,
        bbasu@nvidia.com, ldewangan@nvidia.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Message-ID: <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
References: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 03, 2020 at 06:05:03PM +0530, Sandipan Patra wrote:
> Added support for dynamic clock freq configuration in pwm kernel driver.
> Earlier the pwm driver used to cache boot time clock rate by pwm clock
> parent during probe. Hence dynamically changing pwm frequency was not
> possible for all the possible ranges. With this change, dynamic calculation
> is enabled and it is able to set the requested period from sysfs knob
> provided the value is supported by clock source.

Without having looked closely at the patch (yet), just for my
understanding: If the PWM is running and the frequency changes, the
output changes, too, right? If so, do we need a notifier that prevents a
frequency change when the PWM is running?

And slightly orthogonal to this patch: The tegra driver needs some love
to make it use the atomic callback .apply() instead of
.config()/.enable()/.disable() and a .get_state() implementation.

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
>  drivers/pwm/pwm-tegra.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index aa12fb3..d3ba33c 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -4,7 +4,7 @@
>   *
>   * Tegra pulse-width-modulation controller driver
>   *
> - * Copyright (c) 2010, NVIDIA Corporation.
> + * Copyright (c) 2010-2020, NVIDIA Corporation.
>   * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
>   */
>  
> @@ -83,10 +83,51 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	val = (u32)c << PWM_DUTY_SHIFT;
>  
>  	/*
> +	 * Its okay to ignore the fraction part since we will be trying to set
> +	 * slightly lower value to rate than the actual required rate

s/actual/actually/

You round down the rate, that results in rounding up period and
duty_cycle, right? If so, that's wrong. (Note that if the driver would
use the atomic callbacks, the just introduced debug checks would tell
you this.)

> +	 */
> +	rate = NSEC_PER_SEC/period_ns;

space around / please.

> +
> +	/*
> +	 *  Period in nano second has to be <= highest allowed period
> +	 *  based on the max clock rate of the pwm controller.
> +	 *
> +	 *  higher limit = max clock limit >> PWM_DUTY_WIDTH
> +	 */
> +	if (rate > (pc->soc->max_frequency >> PWM_DUTY_WIDTH))
> +		return -EINVAL;

Related to my question above: What happens if the rate increases after
this check?

Also the division above is just done to compare the requested period
value with the allowed range.

Your check is:

	NSEC_PER_SEC / period_ns > (max_frequency >> PWM_DUTY_WIDTH)

This is equivalent to

	period_ns <= NSEC_PER_SEC / (max_frequency >> PWM_DUTY_WIDTH)

where the right side is constant per PWM type. (Rounding might need
addressing.)

> +
> +	/*
>  	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
>  	 */
> -	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
> +	if (pc->soc->num_channels == 1) {
> +		/*
> +		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
> +		 * with the hieghest applicable rate that the controller can

typo: s/hieghest/highest/

> +		 * provide. Any further lower value can be derived by setting
> +		 * PFM bits[0:12].
> +		 * Higher mark is taken since BPMP has round-up mechanism
> +		 * implemented.
> +		 */
> +		rate = rate << PWM_DUTY_WIDTH;
> +
> +		err = clk_set_rate(pc->clk, rate);
> +		if (err < 0)
> +			return -EINVAL;
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

I don't understand that. If 
> +		 */
> +		rate = pc->clk_rate >> PWM_DUTY_WIDTH;
> +	}
>  
>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
>  	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);

I took a deeper look into the driver now. Just to ensure, I understood
the PWMs behaviour right:

There is an ENABLE bit (with obvious semantics), a 13-bit SCALE value
and an 8-bit DUTY value. There is an internal counter incrementing by
one each (SCALE + 1) clock cycles and resets at 256. The counter going
from 0 to 256 defines the period length. On counter reset the output
gets active and on reaching DUTY the output gets inactive.

So we have:

	.period = 256 * (SCALE + 1) / clkrate
	.duty_cycle = DUTY * (SCALE + 1) / clkrate

Right?

There are a few things that could be improved in the driver:

 - .config() does quite some divisions. This could be reduced which
   probably even reduces rounding effects.

 - When .duty_ns == .period the assignment of DUTY overflows.
   (Can the PWM provide 100% duty cycle at all?)

 - The comment "Since the actual PWM divider is the register's frequency
   divider field minus 1, we need to decrement to get the correct value
   to write to the register." seems wrong. If I understand correctly, we
   need to do s/minus/plus/. If the register holds a 0, the divider
   isn't -1 for sure?!

How does the PWM behave when it gets disabled? Does it complete the
currently running period? Does the output stop at the inactive level, or
where it just happens to be? How does a running PWM behave when the
register is updated? Does it complete the currently running period?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
