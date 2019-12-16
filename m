Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02F51200D9
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2019 10:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLPJT0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 04:19:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47437 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfLPJTY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 04:19:24 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1igmX5-0006c2-5R; Mon, 16 Dec 2019 10:19:15 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1igmX2-0007h9-SI; Mon, 16 Dec 2019 10:19:12 +0100
Date:   Mon, 16 Dec 2019 10:19:12 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20191216091912.r4onikojbkbmguag@pengutronix.de>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191215203607.GA31390@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Jeff,

On Sun, Dec 15, 2019 at 08:36:12PM +0000, Jeff LaBundy wrote:
> On Tue, Dec 10, 2019 at 08:22:27AM +0100, Uwe Kleine-König wrote:
> > On Tue, Dec 10, 2019 at 12:03:02AM +0000, Jeff LaBundy wrote:
> > > On Mon, Dec 09, 2019 at 08:32:06AM +0100, Uwe Kleine-König wrote:
> > > > On Mon, Dec 09, 2019 at 12:38:36AM +0000, Jeff LaBundy wrote:
> > > > > This patch adds support for the Azoteq IQS620A, capable of generating
> > > > > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).
> > > > > 
> > > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > > ---
> > > > > Changes in v2:
> > > > >   - Merged 'Copyright' and 'Author' lines into one in introductory comments
> > > > >   - Added 'Limitations' section to introductory comments
> > > > >   - Replaced 'error' with 'ret' throughout
> > > > >   - Added const qualifier to state argument of iqs620_pwm_apply and removed all
> > > > >     modifications to the variable's contents
> > > > >   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the requested
> > > > >     polarity is inverted or the requested period is below 1 ms, respectively
> > > > >   - Updated iqs620_pwm_apply to disable the PWM output if duty cycle is zero
> > > > >   - Added iqs620_pwm_get_state
> > > > >   - Eliminated tabbed alignment of pwm_ops and platform_driver struct members
> > > > >   - Moved notifier unregistration to already present iqs620_pwm_remove, which
> > > > >     eliminated the need for a device-managed action and ready flag
> > > > >   - Added a comment in iqs620_pwm_probe to explain the order of operations
> > > > >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> > > > > 
> > > > >  drivers/pwm/Kconfig       |  10 +++
> > > > >  drivers/pwm/Makefile      |   1 +
> > > > >  drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 217 insertions(+)
> > > > >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> > > > > 
> > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > index bd21655..60bcf6c 100644
> > > > > --- a/drivers/pwm/Kconfig
> > > > > +++ b/drivers/pwm/Kconfig
> > > > > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> > > > >  	  To compile this driver as a module, choose M here: the module
> > > > >  	  will be called pwm-imx-tpm.
> > > > > 
> > > > > +config PWM_IQS620A
> > > > > +	tristate "Azoteq IQS620A PWM support"
> > > > > +	depends on MFD_IQS62X || COMPILE_TEST
> > > > > +	help
> > > > > +	  Generic PWM framework driver for the Azoteq IQS620A multi-function
> > > > > +	  sensor.
> > > > > +
> > > > > +	  To compile this driver as a module, choose M here: the module will
> > > > > +	  be called pwm-iqs620a.
> > > > > +
> > > > >  config PWM_JZ4740
> > > > >  	tristate "Ingenic JZ47xx PWM support"
> > > > >  	depends on MACH_INGENIC
> > > > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > > > index 9a47507..a59c710 100644
> > > > > --- a/drivers/pwm/Makefile
> > > > > +++ b/drivers/pwm/Makefile
> > > > > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
> > > > >  obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
> > > > >  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
> > > > >  obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
> > > > > +obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
> > > > >  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
> > > > >  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
> > > > >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> > > > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > > > > new file mode 100644
> > > > > index 0000000..1ea11b9
> > > > > --- /dev/null
> > > > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > > > @@ -0,0 +1,206 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Azoteq IQS620A PWM Generator
> > > > > + *
> > > > > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > > > > + *
> > > > > + * Limitations:
> > > > > + * - The period is not guaranteed to run to completion when the duty cycle is
> > > > > + *   changed or the output is disabled.
> > > > 
> > > > Do you know more details here? "not guaranteed" means that the new
> > > > period starts immediately when duty_cycle or the enabled bit is written?
> > > > 
> > > 
> > > Increasing the duty cycle on-the-fly (e.g. 25% to 75%) results in the
> > > following behavior (depending on where the I2C write falls):
> > > 
> > >                        I2C write
> > >    __        __        __  V_    ______    ______    ______    __
> > > __|  |______|  |______|  |_|x|__|      |__|      |__|      |__|
> > >   ^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^
> > > 
> > > The PWM continues to tick at 1 ms, but the currently running period suffers
> > > an extraneous pulse as the output is abruptly set high to "catch up" to the
> > > new duty cycle.
> > > 
> > > A similar behavior can occur if the duty cycle is decreased, meaning the
> > > output is abruptly set low if the I2C transaction completes in what has
> > > suddenly become the inactive region of the currently running period.
> > > 
> > > The PWM seems to be a simple counter that rolls over at a period of 1 ms.
> > > Both the counter and the IQS620_PWM_DUTY_CYCLE register effectively go to
> > > a comparator whose output is ANDed with IQS620_PWR_SETTINGS_PWM_OUT which
> > > then drives the PWM output.
> > > 
> > > As such, if either IQS620_PWM_DUTY_CYCLE or IQS620_PWR_SETTINGS_PWM_OUT
> > > change, so may the PWM output state depending on the counter's value at
> > > the time the I2C write is completed within the 1-ms continuous loop.
> > > 
> > > For v3 I will update the note as follows:
> > > 
> > > - Changes in duty cycle or enable/disable state are immediately reflected
> > >   by the PWM output and are not aligned to the start of any period.
> > 
> > I'd like to see a bit more information in the driver. Something about
> > the 1ms rhythm being unaffected by the duty_cycle and enable setting.
> > Maybe:
> > 
> >  - The periods run continuously with a fixed length of 1 ms which is
> >    unaffected by register updates. Writing duty cycle or enable
> >    registers gets active immediately which might result in glitches.
> > 
> > ?
> > 
> 
> I adjusted the wording a bit as per my preference and settled on the
> following:
> 
>   - The period is fixed to 1 ms and is generated continuously despite changes
>     to the duty cycle or enable/disable state.
>   - Changes to the duty cycle or enable/disable state take effect immediately
>     and may result in a glitch during the period in which the change is made.
> 
> I believe these capture the spirit of your message; please let me know if
> you have any concerns.

That's fine.

> Upon further experimentation, I found that disabling the output (which v2
> does so as to simulate a 0% duty cycle) does not actively drive zero, but
> rather places the output in a high-impedance state with only the device's
> own internal leakage eventually discharging the pin.

But maybe this is still the best you can do in this case. @Thierry, what
do you think?

> This is fundamentally different than actively driving the pin low to make
> a 0% duty cycle, which does not appear to be possible at all. Therefore I
> have removed the control of IQS620_PWR_SETTINGS_PWM_OUT based on the duty
> cycle requested by the user and reverted to the behavior of v1, where the
> duty cycle requested by the user is mapped only to IQS620_PWM_DUTY_CYCLE.
> 
> As such, I have also added a third bullet point similar to what you first
> suggested following v1:
> 
>   - The device cannot generate a 0% duty cycle.

Then this would be:

  - The device cannot actively drive a 0% duty cycle. The driver is
    disabled for small duty_cycles relying on a pull down on the board.

But maybe it would be more prudent to do this only if the board
configuration suggests this is save?!

> > > > > + * - The period is fixed to 1 ms.
> > > > > + */
> > > > > +
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/mfd/iqs62x.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/pwm.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <linux/slab.h>
> > > > > +
> > > > > +#define IQS620_PWR_SETTINGS			0xD2
> > > > > +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> > > > > +
> > > > > +#define IQS620_PWM_DUTY_CYCLE			0xD8
> > > > > +
> > > > > +#define IQS620_PWM_PERIOD_NS			1000000
> > > > > +
> > > > > +struct iqs620_pwm_private {
> > > > > +	struct iqs62x_core *iqs62x;
> > > > > +	struct pwm_chip chip;
> > > > > +	struct notifier_block notifier;
> > > > > +};
> > > > > +
> > > > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > > +			    const struct pwm_state *state)
> > > > > +{
> > > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > > +	struct iqs62x_core *iqs62x;
> > > > > +	unsigned int pwm_out = 0;
> > > > > +	int duty_scale, ret;
> > > > > +
> > > > > +	if (state->polarity != PWM_POLARITY_NORMAL)
> > > > > +		return -ENOTSUPP;
> > > > > +
> > > > > +	if (state->period < IQS620_PWM_PERIOD_NS)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> > > > > +	iqs62x = iqs620_pwm->iqs62x;
> > > > > +
> > > > > +	duty_scale = DIV_ROUND_CLOSEST(state->duty_cycle * 256,
> > > > > +				       IQS620_PWM_PERIOD_NS);
> > > > > +
> > > > > +	if (duty_scale) {
> > > > > +		ret = regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > > > > +				   min(duty_scale - 1, 0xFF));
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +
> > > > > +		if (state->enabled)
> > > > > +			pwm_out = IQS620_PWR_SETTINGS_PWM_OUT;
> > > > > +	}
> > > > > +
> > > > > +	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > > > > +				  IQS620_PWR_SETTINGS_PWM_OUT, pwm_out);
> > > > 
> > > > A comment explaining the semantic here would be good. I assume
> > > > IQS620_PWM_DUTY_CYCLE takes a value between 0 and 255 and the resulting
> > > > duty cycle is:
> > > > 
> > > > 	(IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> > > > 
> > > > .
> > > > 
> > > > If this is right, please use:
> > > > 
> > > > 	duty_scale = (state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS
> > > > 
> > > 
> > > Sure thing, will do. I'll add a comment and round down. Your assumption is
> > > correct as well.
> > > 
> > > > Also, when the hardware is running at
> > > > 
> > > > 	.enabled = 1, .duty_cycle = 1/256 ms, .period = 1ms
> > > > 
> > > > and you reconfigure to
> > > > 
> > > > 	.enabled = 0, .duty_cycle = 1ms, .period = 1ms
> > > > 
> > > > the output might be active for > 1/256 ms if the process is preempted
> > > > between writing IQS620_PWM_DUTY_CYCLE and IQS620_PWR_SETTINGS_PWM_OUT.
> > > > 
> > > 
> > > Good catch. I think we can solve this by writing IQS620_PWM_DUTY_CYCLE
> > > first followed by IQS620_PWR_SETTINGS_PWM_OUT when the PWM is going to
> > > be enabled, and the reverse when the PWM is going to be disabled (i.e.
> > > turn OFF to prevent a stale duty cycle from being temporarily driven).
> > 
> > Sounds like a plan. After disabling you even don't need to write the
> > duty cycle register. (But there might be a discussion ahead that
> > .get_state should return the duty cycle.)
> >  
> 
> For v3, I've opted to write IQS620_PWM_DUTY_CYCLE regardless of whether the PWM
> is enabled as a matter of principle (i.e. faithfully pass the entire state down
> to the hardware without making assumptions).
> 
> And since some consumers (e.g. leds-pwm, the primary use-case for this PWM) may
> pre-configure the duty cycle while the PWM is disabled, this method ensures the
> driver is already compliant in case 01ccf903edd6 returns.
> 
> Also, as mentioned above, I have dropped the automatic disabling of the PWM to
> simulate a 0% duty cycle if the requested duty cycle is < 1 / 256 ms since the
> device does not actively drive a zero with IQS620_PWR_SETTINGS_PWM_OUT = 0. In
> the interest of transparency, here is what I currently have for v3:
> 
> static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> 			    const struct pwm_state *state)
> {
> 	struct iqs620_pwm_private *iqs620_pwm;
> 	struct iqs62x_core *iqs62x;
> 	int duty_scale, ret;
> 
> 	if (state->polarity != PWM_POLARITY_NORMAL)
> 		return -ENOTSUPP;
> 
> 	if (state->period < IQS620_PWM_PERIOD_NS)
> 		return -EINVAL;
> 
> 	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> 	iqs62x = iqs620_pwm->iqs62x;
> 
> 	if (!state->enabled) {
> 		ret = regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> 					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	/*
> 	 * The duty cycle generated by the device is calculated as follows:
> 	 *
> 	 * duty_cycle = (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> 	 *
> 	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 255
> 	 * (inclusive). Therefore the lowest duty cycle the device can generate
> 	 * while the output is enabled is 1 / 256 ms.
> 	 */
> 	duty_scale = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;

Hmm, this is violating the policy to implement a value not bigger than
requested with state->duty_cycle == 0. I see this has downsides to not
simply cheat here, but only claiming to have implemented 0% can hurt,
too. pwm-rcar returns -EINVAL in this case.

> 	ret = regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> 			   clamp(duty_scale, 0, 0xFF));
> 	if (ret)
> 		return ret;

I understand your motivation to configure the duty cycle also when the
the request has enabled=false, but a strange side effect is that a
failure to configure the dutycycle with .enabled=false isn't really a
problem, is it?
(This is not a request to change anything, it's only expression of my
frustration that we cannot get away without strange effects.)

> 
> 	if (state->enabled)
> 		ret = regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> 					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
> 
> 	return ret;
> }
> 
> I believe this captures all of the discussion thus far; please let me know if you
> have any concerns.
> 
> > > > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > > > +			       unsigned long event_flags, void *context)
> > > > > +{
> > > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > > +	struct pwm_state state;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > > > +		return NOTIFY_DONE;
> > > > > +
> > > > > +	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
> > > > > +				  notifier);
> > > > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > > > 
> > > > Please don't call pwm API functions in callbacks. I assume you rely on
> > > > pwm_get_state returning the previously set state and that
> > > > iqs620_pwm_get_state isn't called. Please use pwm->state for that.
> > > > 
> > > 
> > > Sure thing, will do. Your assumption is correct. If pwm_get_state called
> > > chip->ops->get_state instead of return pwm->state as it does today, this
> > > function would break because it would restore the hardware using default
> > > register values (since this function follows a reset).
> > > 
> > > Just for my own understanding, are you saying the PWM framework reserves
> > > the right to update pwm_get_state to call chip->ops->get_state some time
> > > in the future? In any event I will refer to pwm->state as that is what I
> > > ultimately need here.
> > 
> > This already was the case for a short time before v5.4. See 01ccf903edd6
> > and 40a6b9a00930. (And note that the lazyness mentioned above about not
> > needing to write duty_cycle when the PWM is off is what made the
> > approach break however.) I don't know yet how to proceed here. Being
> > able to get the actually implemented setting would be nice, probably it
> > is prudent to do this with another API function.
> > 
> > Other than that I consider it a layer violation to call a function that
> > is designed for consumers in a lowlevel driver. I don't know if we need
> > locking at some time, but if the core holded a lock when .apply is
> > called, .apply calls pwm_get_state which wanted to grab the lock again
> > we get a dead-lock.
> 
> I think we may be imagining two different hazards (please correct me if I have
> misunderstood). Originally I thought you were warning that pwm_get_state (which
> simply returns pwm->state) may in the future call chip->ops->get_state instead,
> which here would have caused iqs620_pwm_notifier to call iqs620_pwm_apply with
> a reset-like state rather than the last state requested by the user (since this
> notifier is called after the device resets itself).
> 
> The short-lived change during the 5.4-rc phase, however, was to fill pwm->state
> in pwm_apply_state with the quantized state from the hardware instead of the raw
> state requested by the user. Whether pwm->state (accessed directly or by calling
> pwm_get_state) gives the raw state or the quantized output of get_state following
> the last call to pwm_apply_state does not change the outcome (for this particular
> driver) because iqs620_pwm_apply ultimately writes the same register values. Just
> to be safe, I've been testing with and without 01ccf903edd6 applied locally so as
> to validate the behavior in both scenarios.
> 
> What I missed originally is that pwm_get_state is intended for consumers only, in
> which case I agree it is fundamentally wrong to cannibalize it in the driver. For
> v3 I have changed iqs620_pwm_notifier to reference pwm->state directly since that
> is what is ultimately needed in the first place.
> 
> You're correct that a lock within the core would cause a deadlock; in this case I
> was proposing a lock around the pair of reads/writes to IQS620_PWM_DUTY_CYCLE and
> IQS620_PWR_SETTINGS_PWM_OUT since v2 introduced an implied relationship between
> the two. That would be safe since chip->ops->apply returns before pwm_apply_state
> calls chip->ops->get_state.
> 
> However, even that is no longer necessary since IQS620_PWR_SETTINGS_PWM_OUT is now
> written independently of IQS620_PWM_DUTY_CYCLE due to withdrawing support for a 0%
> duty cycle starting in v3. In short, I didn't end up adding any locks as there was
> no need.

That's fine. I'm not sure we actually need locks in the framework in the
long run because (other than clocks) a PWM always has at most a single
consumer and up to now it seems reasonable that this single consumer
doesn't race with itself.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
