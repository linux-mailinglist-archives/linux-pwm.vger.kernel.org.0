Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631CDDFCC6
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 06:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfJVEgx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 00:36:53 -0400
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:60311
        "EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfJVEgx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 00:36:53 -0400
Received: from labundy.com ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id Mlubiw0WH8KZvMluciyblb; Mon, 21 Oct 2019 21:36:51 -0700
Date:   Mon, 21 Oct 2019 23:36:49 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20191022043649.GB2091@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-6-git-send-email-jeff@labundy.com>
 <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfJBHGfDqLx3HpmtvdttKAwGjT12Q/I+bffqXwO0P+7deexy/G9+m5AhBF/Ddm4vBI5TdFxKCU5N9KIaoWxZv/YyopGRe7IZFc8fnOtzAUBVn4f2c4gi+
 kF0leQHxxDgZQPk8JtYUMyQXtHwe0068Su8UZgXOUR2zA2ozavmmAqMDfo3uLLgaKZhjnnJ7KpeTMAAHXNJpIGNSH5WcNw2y+m8EK99GW+YAeqpo+yd9K4tw
 4rjSFRDoucMVO7mCuYsg6qsI47OBkdXw24zaPOeVGIXIYvn3F04ge1WaXjam3u+WBed7gMxwG9TTRG3JEFev41FwKUdKPCyWxxBgqPHZJEnB5+2Ha1K6axdw
 yI8d6sw2a5Jtk8odzMwTRnKelRp/G6CaMFZfyqWjaI1UkT9Uq9BpWuog/wtnsCDxMyms9gWP5nrbHWmiUxOkNc9nBIRoYxpqBaRhGLwV2jMJyA/m+6TH1/ei
 Q+jVK03FF58facTTjCd0GOlXFMLyPdMVVQPM5Rhr/ktr774r5vid3xRvfDYVCHloeXm/aGagx1U9bdM52KRZcvBHvdUHaCvysPoeInKfkgmc3JhwJFY8Pi+i
 svkpQ8XpSM4KlZYpH9xH+a2Y7y0aq/S9U4+Qm8iqPPmhU953PSfSFlmOqMMKzdXxAJ/1ydWORKjgeQ+xZ12DSAWxYaNvKpfsdZWc1AOLaTuiMhD0a7n/JeRQ
 pdD+rKPVQ/s=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your prompt review.

On Mon, Oct 21, 2019 at 09:34:19AM +0200, Uwe Kleine-König wrote:
> Hello Jeff,
> 
> On Sun, Oct 20, 2019 at 11:11:20PM -0500, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620A, capable of generating
> > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).
> > 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> >  drivers/pwm/Kconfig       |  10 +++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-iqs620a.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 178 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index e3a2518..712445e 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-imx-tpm.
> >  
> > +config PWM_IQS620A
> > +	tristate "Azoteq IQS620A PWM support"
> > +	depends on MFD_IQS62X
> 
> This is only a runtime dependency if I'm not mistaken, so it would be
> great to have
> 
> 	depends on MFD_IQS62X || COMPILE_TEST
> 	depends on REGMAP
> 
> here.
> 

Sure thing; will do. Actually, it seems I can add this to all but the input
driver, as that one relies on iqs62x_events exported from the MFD.

> > +	help
> > +	  Generic PWM framework driver for the Azoteq IQS620A multi-function
> > +	  sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called pwm-iqs620a.
> > +
> >  config PWM_JZ4740
> >  	tristate "Ingenic JZ47xx PWM support"
> >  	depends on MACH_INGENIC
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 26326ad..27c9bfa 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
> >  obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
> >  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
> >  obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
> > +obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
> >  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
> >  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
> >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > new file mode 100644
> > index 0000000..6451eb1
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A PWM Generator
> > + *
> > + * Copyright (C) 2019
> > + * Author: Jeff LaBundy <jeff@labundy.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define IQS620_PWR_SETTINGS			0xD2
> > +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> > +
> > +#define IQS620_PWM_DUTY_CYCLE			0xD8
> > +
> > +#define IQS620_PWM_PERIOD_NS			1000000
> > +
> > +struct iqs620_pwm_private {
> > +	struct iqs62x_core *iqs62x;
> > +	struct pwm_chip chip;
> > +	struct notifier_block notifier;
> > +	bool ready;
> 
> This is always true, so you can drop it.
> 

This is here because iqs620_pwm_notifier references chip.pwms, which is
not allocated until after the notifier is registered and pwmchip_add is
called. So it protects against this (albeit unlikely) race condition:

1. iqs620_pwm_notifier is registered
2. Device immediately suffers an asynchronous reset and notifier chain
   is called (more on that in a bit)
3. iqs620_pwm_notifier evaluates chips.pwms (NULL)

I felt this was simpler than calling pwmchip_add before registering the
notifier and adding an error/tear-down path in iqs620_pwm_probe in case
of failure. I would be happy to add a comment or two to explain the not-
so-obvious purpose of this flag.

> > +};
> > +
> > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    struct pwm_state *state)
> 
> Since
> 
> 	71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state argument")
> 
> this isn't the right prototype.
> 

Sure thing; I will add the 'const' qualifier and remove the two changes
to the state argument.

> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct iqs62x_core *iqs62x;
> > +	int error;
> > +	int duty_calc = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;
> > +	u8 duty_clamp = clamp(duty_calc, 0, 0xFF);
> > +
> > +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> > +	iqs62x = iqs620_pwm->iqs62x;
> > +
> > +	error = regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty_clamp);
> > +	if (error)
> > +		return error;
> > +
> > +	state->period = IQS620_PWM_PERIOD_NS;
> > +	state->duty_cycle = (duty_clamp + 1) * IQS620_PWM_PERIOD_NS / 256;
> 
> This suggests that if the value in the IQS620_PWM_DUTY_CYCLE is 0 the
> duty cycle is 1/256 ms with a period of 1 ms and the output cannot be
> constant inactive. If this is right please add a paragraph in the
> driver's comment at the top:
> 
> 	* Limitations:
> 	* - The hardware cannot generate a 0% duty cycle
> 
> (Please stick to this format, other drivers use it, too.)
> 

That's correct; the lowest duty cycle that can be achieved using only the
IQS620_PWM_DUTY_CYCLE register is 0.4%. We can, however, generate 0% duty
cycle by disabling the output altogether using a separate register. Would
that be better than flat-out saying it's impossible?

> How does the hardware behave on changes? For example you're first
> committing the duty cycle and then on/off. Can it happen that between
> 
> 	pwm_apply_state(pwm, { .duty_cycle = 3900, .period = 1000000, .enabled = true)
> 	...
> 	pwm_apply_state(pwm, { .duty_cycle = 1000000, .period = 1000000, .enabled = false)
> 
> the output is active for longer than 4 µs because the iqs620_pwm_apply
> function is preempted between the two register writes and so we already
> have .duty_cycle = 1000000 but still .enabled = true in the hardware?
> 

My results show that it is possible to generate up to two irregular periods
by changing the duty cycle while the output is active.

Depending on the ratio of old-to-new duty cycle and the position of the I2C
write relative to the asynchronous output, the device may produce one pulse
for which the width represents neither the old nor the new duty cycle.

> Does a change complete the currently running period? Does disabling
> complete the currently running period? If so, does regmap_update_bits
> block until the new setting is active?
> 

A quick test reveals the following:

* Duty cycle changes may interrupt a running period, i.e., the output may
  transition in the middle of the period to accommodate the new duty cycle.
* Disabling the output drives it to zero immediately, i.e., the period does
  does not run to completion.

I will add a 'Limitations' section at the top as other drivers do, and call
these points out specifically.

> The .apply function fails to check for .pwm_polarity. You want something
> like:
> 
> 	if (state->polarity != PWM_POLARITY_NORMAL)
> 		return -ENOTSUPP;
> 
> (That's what pwm-rcar and the core (in the absence of .set_polarity for
> old-style drivers) are using. @Thierry: It would be great to fix the
> vaule that should be returned in this case. pwm-lpss and sifive use
> -EINVAL.)
> 

Sure thing; I'll return -ENOTSUPP in this case.

> > +	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > +				  IQS620_PWR_SETTINGS_PWM_OUT,
> > +				  state->enabled ? 0xFF : 0);
> > +}
> > +
> > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > +			       unsigned long event_flags, void *context)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct pwm_state state;
> > +	int error;
> > +
> > +	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
> > +				  notifier);
> > +
> > +	if (!iqs620_pwm->ready || !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > +		return NOTIFY_DONE;
> > +
> > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > +
> > +	error = iqs620_pwm_apply(&iqs620_pwm->chip,
> > +				 &iqs620_pwm->chip.pwms[0], &state);
> > +	if (error) {
> > +		dev_err(iqs620_pwm->chip.dev,
> > +			"Failed to re-initialize device: %d\n", error);
> > +		return NOTIFY_BAD;
> > +	}
> > +
> > +	return NOTIFY_OK;
> 
> So the PWM can loose it's state sometimes? When does that happen?
> 

That's correct. The device performs an internal soft reset in the presence
of what it considers to be an I2C timeout error; in this case all registers
are restored to their default values.

The data sheet goes so far as to recommend monitoring for this interrupt and
restoring the device on-the-fly. I have added some comments in iqs62x_irq in
patch [2/8] which provides some further detail.

> > +}
> > +
> > +static void iqs620_pwm_notifier_unregister(void *context)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm = context;
> > +	int error;
> > +
> > +	error = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
> > +						   &iqs620_pwm->notifier);
> > +	if (error)
> > +		dev_err(iqs620_pwm->chip.dev,
> > +			"Failed to unregister notifier: %d\n", error);
> > +}
> > +
> > +static const struct pwm_ops iqs620_pwm_ops = {
> > +	.apply	= iqs620_pwm_apply,
> 
> Please implement a .get_state callback.
> 

Sure thing; will do.

> > +	.owner	= THIS_MODULE,
> > +};
> > +
> > +static int iqs620_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	int error;
> > +
> > +	iqs620_pwm = devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERNEL);
> > +	if (!iqs620_pwm)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, iqs620_pwm);
> > +	iqs620_pwm->iqs62x = dev_get_drvdata(pdev->dev.parent);
> > +
> > +	iqs620_pwm->chip.dev = &pdev->dev;
> > +	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
> > +	iqs620_pwm->chip.base = -1;
> > +	iqs620_pwm->chip.npwm = 1;
> > +
> > +	iqs620_pwm->notifier.notifier_call = iqs620_pwm_notifier;
> > +	error = blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
> > +						 &iqs620_pwm->notifier);
> > +	if (error) {
> > +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	error = devm_add_action_or_reset(&pdev->dev,
> > +					 iqs620_pwm_notifier_unregister,
> > +					 iqs620_pwm);
> 
> I wonder if this is safe. If in iqs620_pwm_notifier_unregister()
> unregistering of the notifier goes wrong (not sure when this can happen)
> the memory behind iqs620_pwm goes away. Then later iqs620_pwm_notifier
> might be called trying to use *iqs620_pwm ...

I think this is purely theoretical, as blocking_notifier_chain_unregister
only fails if the notifier is not found in the chain. If for some reason
blocking_notifier_chain_register fails (which currently cannot happen, as
it always returns zero), the driver will fail to probe before the action
could be added.

This of course means the error message in iqs620_pwm_notifier_unregister
is unnecessary; it is simply provided for debug/visibility.

> 
> > +	if (error) {
> > +		dev_err(&pdev->dev, "Failed to add action: %d\n", error);
> > +		return error;
> > [...]
> > 
> > +static struct platform_driver iqs620_pwm_platform_driver = {
> > +	.driver = {
> > +		.name	= IQS620_DRV_NAME_PWM,
> > +	},
> > +	.probe		= iqs620_pwm_probe,
> > +	.remove		= iqs620_pwm_remove,
> > +};
> 
> I'm not a big fan of aligning the = in struct initializers. The downside
> is that if you later add
> 
> 	.prevent_deferred_probe = true,
> 
> you either have to touch all (otherwise unrelated) lines to realign
> which adds churn, or the structure is only partially aligned which looks
> ugly. That's why I stick to a single space before the =.
> 

Sure thing; your argument is valid and I will reduce to a single space.

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 

Kind regards,
Jeff LaBundy

