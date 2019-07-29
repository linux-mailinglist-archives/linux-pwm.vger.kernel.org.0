Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF579092
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfG2QRA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jul 2019 12:17:00 -0400
Received: from mailoutvs18.siol.net ([185.57.226.209]:60067 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727408AbfG2QRA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 12:17:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CB4C9522935;
        Mon, 29 Jul 2019 18:16:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pA7Ggt9CdWmA; Mon, 29 Jul 2019 18:16:56 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4B0915225A6;
        Mon, 29 Jul 2019 18:16:56 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id C909752294C;
        Mon, 29 Jul 2019 18:16:55 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/6] pwm: sun4i: Add support to output source clock directly
Date:   Mon, 29 Jul 2019 18:16:55 +0200
Message-ID: <2499807.IN78SsLMYo@jernej-laptop>
In-Reply-To: <20190729070605.vlu7kgzn362ph2q3@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-6-jernej.skrabec@siol.net> <20190729070605.vlu7kgzn362ph2q3@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Dne ponedeljek, 29. julij 2019 ob 09:06:05 CEST je Uwe Kleine-König 
napisal(a):
> On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> > PWM core has an option to bypass whole logic and output unchanged source
> > clock as PWM output. This is achieved by enabling bypass bit.
> > 
> > Note that when bypass is enabled, no other setting has any meaning, not
> > even enable bit.
> > 
> > This mode of operation is needed to achieve high enough frequency to
> > serve as clock source for AC200 chip, which is integrated into same
> > package as H6 SoC.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/pwm/pwm-sun4i.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 9e0eca79ff88..848cff26f385 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -120,6 +120,19 @@ static void sun4i_pwm_get_state(struct pwm_chip
> > *chip,
> > 
> >  	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > 
> > +	/*
> > +	 * PWM chapter in H6 manual has a diagram which explains that if 
bypass
> > +	 * bit is set, no other setting has any meaning. Even more, 
experiment
> > +	 * proved that also enable bit is ignored in this case.
> > +	 */
> > +	if (val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) {
> > +		state->period = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, 
clk_rate);
> > +		state->duty_cycle = state->period / 2;
> > +		state->polarity = PWM_POLARITY_NORMAL;
> > +		state->enabled = true;
> > +		return;
> > +	}
> > +
> > 
> >  	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
> >  	
> >  	    sun4i_pwm->data->has_prescaler_bypass)
> >  		
> >  		prescaler = 1;
> > 
> > @@ -211,7 +224,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,> 
> >  {
> >  
> >  	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> >  	struct pwm_state cstate;
> > 
> > -	u32 ctrl;
> > +	u32 ctrl, clk_rate;
> > +	bool bypass;
> > 
> >  	int ret;
> >  	unsigned int delay_us;
> >  	unsigned long now;
> > 
> > @@ -226,6 +240,16 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,> 
> >  		}
> >  	
> >  	}
> > 
> > +	/*
> > +	 * Although it would make much more sense to check for bypass in
> > +	 * sun4i_pwm_calculate(), value of bypass bit also depends on 
"enabled".
> > +	 * Period is allowed to be rounded up or down.
> > +	 */
> 
> Every driver seems to implement rounding the way its driver considers it
> sensible. @Thierry: This is another patch where it would be good to have
> a global directive about how rounding is supposed to work to provide the
> users an reliable and uniform way to work with PWMs.
> 
> > +	clk_rate = clk_get_rate(sun4i_pwm->clk);
> > +	bypass = (state->period == NSEC_PER_SEC / clk_rate ||
> > +		 state->period == DIV_ROUND_UP(NSEC_PER_SEC, clk_rate)) 
&&
> > +		 state->enabled;
> 
> Not sure if the compiler is clever enough to notice the obvious
> optimisation with this code construct, but you can write this test in a
> more clever way which has zero instead of up to two divisions. Something
> like:
> 
> bypass = ((state->period * clk_rate >= NSEC_PER_SEC &&
> 	   state->period * clk_rate < NSEC_PER_SEC + clk_rate) &&
> 	  state->enabled);
> 
> In the commit log you write the motivation for using bypass is that it
> allows to implement higher frequency then with the "normal" operation.
> As you don't skip calculating the normal parameters requesting such a
> high-frequency setting either errors out or doesn't catch the impossible
> request. In both cases there is something to fix.

It's the latter, otherwise it wouldn't work for my case. I'll fix the check and 
skip additional logic.

> 
> > +
> > 
> >  	spin_lock(&sun4i_pwm->ctrl_lock);
> >  	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > 
> > @@ -273,6 +297,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,> 
> >  		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> >  	
> >  	}
> > 
> > +	if (bypass)
> > +		ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +	else
> > +		ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +
> 
> Does switching on (or off) the bypass bit complete the currently running
> period?

I don't really know. If I understand correctly, it just bypasses PWM logic 
completely, so I would say it doesn't complete the currently running period.

Take a look at chapter 3.9.2 http://linux-sunxi.org/
File:Allwinner_H6_V200_User_Manual_V1.1.pdf

Best regards,
Jernej

> 
> >  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> >  	
> >  	spin_unlock(&sun4i_pwm->ctrl_lock);
> 
> Best regards
> Uwe




