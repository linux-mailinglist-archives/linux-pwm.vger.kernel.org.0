Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60D6785CF
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfG2HGN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 03:06:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34145 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfG2HGN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 03:06:13 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzjT-0001ht-6J; Mon, 29 Jul 2019 09:06:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzjR-0004RR-Ql; Mon, 29 Jul 2019 09:06:05 +0200
Date:   Mon, 29 Jul 2019 09:06:05 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/6] pwm: sun4i: Add support to output source clock
 directly
Message-ID: <20190729070605.vlu7kgzn362ph2q3@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726184045.14669-6-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> PWM core has an option to bypass whole logic and output unchanged source
> clock as PWM output. This is achieved by enabling bypass bit.
> 
> Note that when bypass is enabled, no other setting has any meaning, not
> even enable bit.
> 
> This mode of operation is needed to achieve high enough frequency to
> serve as clock source for AC200 chip, which is integrated into same
> package as H6 SoC.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/pwm/pwm-sun4i.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 9e0eca79ff88..848cff26f385 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -120,6 +120,19 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
>  
>  	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  
> +	/*
> +	 * PWM chapter in H6 manual has a diagram which explains that if bypass
> +	 * bit is set, no other setting has any meaning. Even more, experiment
> +	 * proved that also enable bit is ignored in this case.
> +	 */
> +	if (val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) {
> +		state->period = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, clk_rate);
> +		state->duty_cycle = state->period / 2;
> +		state->polarity = PWM_POLARITY_NORMAL;
> +		state->enabled = true;
> +		return;
> +	}
> +
>  	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
>  	    sun4i_pwm->data->has_prescaler_bypass)
>  		prescaler = 1;
> @@ -211,7 +224,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
>  	struct pwm_state cstate;
> -	u32 ctrl;
> +	u32 ctrl, clk_rate;
> +	bool bypass;
>  	int ret;
>  	unsigned int delay_us;
>  	unsigned long now;
> @@ -226,6 +240,16 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		}
>  	}
>  
> +	/*
> +	 * Although it would make much more sense to check for bypass in
> +	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
> +	 * Period is allowed to be rounded up or down.
> +	 */

Every driver seems to implement rounding the way its driver considers it
sensible. @Thierry: This is another patch where it would be good to have
a global directive about how rounding is supposed to work to provide the
users an reliable and uniform way to work with PWMs.

> +	clk_rate = clk_get_rate(sun4i_pwm->clk);
> +	bypass = (state->period == NSEC_PER_SEC / clk_rate ||
> +		 state->period == DIV_ROUND_UP(NSEC_PER_SEC, clk_rate)) &&
> +		 state->enabled;

Not sure if the compiler is clever enough to notice the obvious
optimisation with this code construct, but you can write this test in a
more clever way which has zero instead of up to two divisions. Something
like:

bypass = ((state->period * clk_rate >= NSEC_PER_SEC &&
	   state->period * clk_rate < NSEC_PER_SEC + clk_rate) &&
	  state->enabled);

In the commit log you write the motivation for using bypass is that it
allows to implement higher frequency then with the "normal" operation.
As you don't skip calculating the normal parameters requesting such a
high-frequency setting either errors out or doesn't catch the impossible
request. In both cases there is something to fix.

> +
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  
> @@ -273,6 +297,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>  	}
>  
> +	if (bypass)
> +		ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
> +	else
> +		ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> +

Does switching on (or off) the bypass bit complete the currently running
period?

>  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  
>  	spin_unlock(&sun4i_pwm->ctrl_lock);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
