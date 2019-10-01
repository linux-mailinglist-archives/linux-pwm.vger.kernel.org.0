Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A03C30A3
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2019 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfJAJv2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Oct 2019 05:51:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAJv2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Oct 2019 05:51:28 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iFEoT-0003zO-DF; Tue, 01 Oct 2019 11:51:21 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iFEoR-0003uQ-P8; Tue, 01 Oct 2019 11:51:19 +0200
Date:   Tue, 1 Oct 2019 11:51:19 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, benjamin.gaignard@st.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] pwm: stm32: add power management support
Message-ID: <20191001095119.ws36f7liwgvbokem@pengutronix.de>
References: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
 <1569857951-20007-3-git-send-email-fabrice.gasnier@st.com>
 <20191001070450.4zogfryzo7a5ssbd@pengutronix.de>
 <3c6e551b-98a2-a418-c4ee-002077e46f31@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c6e551b-98a2-a418-c4ee-002077e46f31@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Fabrice,

On Tue, Oct 01, 2019 at 10:18:31AM +0200, Fabrice Gasnier wrote:
> On 10/1/19 9:04 AM, Uwe Kleine-K�nig wrote:
> > On Mon, Sep 30, 2019 at 05:39:11PM +0200, Fabrice Gasnier wrote:
> >> Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
> >> channel isn't active. Let the PWM consumers disable it during their own
> >> suspend sequence, see [1]. So, perform a check here, and handle the
> >> pinctrl states. Also restore the break inputs upon resume, as registers
> >> content may be lost when going to low power mode.
> >>
> >> [1] https://lkml.org/lkml/2019/2/5/770
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >>  drivers/pwm/pwm-stm32.c | 82 +++++++++++++++++++++++++++++++++++++------------
> >>  1 file changed, 62 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> >> index 740e2de..9bcd73a 100644
> >> --- a/drivers/pwm/pwm-stm32.c
> >> +++ b/drivers/pwm/pwm-stm32.c
> >> @@ -12,6 +12,7 @@
> >>  #include <linux/mfd/stm32-timers.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >> +#include <linux/pinctrl/consumer.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pwm.h>
> >>  
> >> @@ -19,6 +20,12 @@
> >>  #define CCMR_CHANNEL_MASK  0xFF
> >>  #define MAX_BREAKINPUT 2
> >>  
> >> +struct stm32_breakinput {
> >> +	u32 index;
> >> +	u32 level;
> >> +	u32 filter;
> >> +};
> >> +
> >>  struct stm32_pwm {
> >>  	struct pwm_chip chip;
> >>  	struct mutex lock; /* protect pwm config/enable */
> >> @@ -26,15 +33,11 @@ struct stm32_pwm {
> >>  	struct regmap *regmap;
> >>  	u32 max_arr;
> >>  	bool have_complementary_output;
> >> +	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
> >> +	unsigned int nbreakinput;
> >>  	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
> >>  };
> >>  
> >> -struct stm32_breakinput {
> >> -	u32 index;
> >> -	u32 level;
> >> -	u32 filter;
> >> -};
> >> -
> >>  static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
> >>  {
> >>  	return container_of(chip, struct stm32_pwm, chip);
> >> @@ -512,15 +515,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >>  	return (bdtr & bke) ? 0 : -EINVAL;
> >>  }
> >>  
> >> -static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
> >> +static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
> >> +{
> >> +	int i, ret = 0;
> >> +
> >> +	for (i = 0; i < priv->nbreakinput && !ret; i++) {
> >> +		ret = stm32_pwm_set_breakinput(priv,
> >> +					       priv->breakinput[i].index,
> >> +					       priv->breakinput[i].level,
> >> +					       priv->breakinput[i].filter);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> > 
> > Can you explain what the effect of this function is? This is something
> > that is lost during suspend?
> 
> Yes, that's what I explain in the commit message: ...registers content
> may be lost when going to low power mode.
> Do you think I need to rephrase ?

Ah, right I missed it in the commit log. It might be worth adding that
to a code comment. Also having the purpose of this function described
would be great. Does it configure some electrical characteristics? Or
has it to do with pinmuxing? Why is an input relevant for a PWM?

> > I wonder why the patch is so big. There are some rearrangements that
> > should have no effect and I think it would be beneficial for
> > reviewability to split this patch in a patch that only does the
> > restructuring and than on top of that add the PM stuff.
> 
> I can split this to ease the review.
> > 
> >> +
> >> +static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
> >>  				       struct device_node *np)
> >>  {
> >> -	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
> >> -	int nb, ret, i, array_size;
> >> +	int nb, ret, array_size;
> >>  
> >>  	nb = of_property_count_elems_of_size(np, "st,breakinput",
> >>  					     sizeof(struct stm32_breakinput));
> >> -
> >>  	/*
> >>  	 * Because "st,breakinput" parameter is optional do not make probe
> >>  	 * failed if it doesn't exist.
> >> @@ -531,20 +546,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
> >>  	if (nb > MAX_BREAKINPUT)
> >>  		return -EINVAL;
> >>  
> >> +	priv->nbreakinput = nb;
> >>  	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
> >>  	ret = of_property_read_u32_array(np, "st,breakinput",
> >> -					 (u32 *)breakinput, array_size);
> >> +					 (u32 *)priv->breakinput, array_size);
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	for (i = 0; i < nb && !ret; i++) {
> >> -		ret = stm32_pwm_set_breakinput(priv,
> >> -					       breakinput[i].index,
> >> -					       breakinput[i].level,
> >> -					       breakinput[i].filter);
> >> -	}
> >> -
> >> -	return ret;
> >> +	return stm32_pwm_apply_breakinputs(priv);
> >>  }
> >>  
> >>  static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
> >> @@ -614,7 +623,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
> >>  	if (!priv->regmap || !priv->clk)
> >>  		return -EINVAL;
> >>  
> >> -	ret = stm32_pwm_apply_breakinputs(priv, np);
> >> +	ret = stm32_pwm_probe_breakinputs(priv, np);
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> @@ -647,6 +656,38 @@ static int stm32_pwm_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> +static int __maybe_unused stm32_pwm_suspend(struct device *dev)
> >> +{
> >> +	struct stm32_pwm *priv = dev_get_drvdata(dev);
> >> +	struct pwm_state state;
> >> +	unsigned int i;
> >> +
> >> +	for (i = 0; i < priv->chip.npwm; i++) {
> >> +		pwm_get_state(&priv->chip.pwms[i], &state);
> > 
> > pwm_get_state is a function designed to be used by PWM consumers. I
> > would prefer to check the hardware registers here instead.
> 
> It's also useful for PWM provider: This PWM driver is part of a MFD that

I don't doubt "useful". But still you should only call it if you called
pwm_get (or a similar function) to get a PWM handle.

> also take care of IIO trigger (can be used simultaneously). Simply
> reading a register doesn't tell us that the timer is used/configured as
> a PWM here. That's the reason to use this helper to read pwm->state.

How can the pwm driver be bound and the hardware not be used a PWM?

> Do you wish I add a comment to clarify this here ?

No, I wish you inspect the hardware to determine what you need to know :-)

> > What if there is no consumer and the PWM just happens to be enabled by
> > the bootloader? Or is this too minor an issue to be worth consideration?
> 
> That's the purpose of returning -EBUSY: "PWM should not stop if the PWM
> user didn't call pwm_disable()" ... "to avoid situation where the PWM is
> actually suspended before the user". This has been enforced in later
> series with the device_link_add(). See our previous discussions here:
> https://lkml.org/lkml/2019/2/5/770
> So, I guess this would point exactly a lack for a PWM user to manage it
> after the boot stage, in the kernel.
> 
> Could you please clarify, provide an example here ?

This is something different than I asked for. Not having a consumer
isn't an error. Still the pwm might be running (for a good reason or
not). (This is more a question that affects how a driver should behave
in general, it is not specific to the stm32 driver here.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
