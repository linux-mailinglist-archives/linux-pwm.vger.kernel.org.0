Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA25113A27B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2020 09:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgANIIl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jan 2020 03:08:41 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34027 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgANIIk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jan 2020 03:08:40 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1irHFV-0003lE-Oj; Tue, 14 Jan 2020 09:08:29 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1irHFU-0000FI-J4; Tue, 14 Jan 2020 09:08:28 +0100
Date:   Tue, 14 Jan 2020 09:08:28 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20200114080828.vv7ilksklt27ysh3@pengutronix.de>
References: <1578271620-2159-1-git-send-email-jeff@labundy.com>
 <1578271620-2159-5-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578271620-2159-5-git-send-email-jeff@labundy.com>
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

On Mon, Jan 06, 2020 at 12:48:02AM +0000, Jeff LaBundy wrote:
> This patch adds support for the Azoteq IQS620A, capable of generating
> a 1-kHz PWM output with duty cycle between ~0.4% and 100% (inclusive).

Overall a very nice driver, some minor issues below.

> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
> Changes in v3:
>   - Updated the commit message to say "~0.4%" instead of "0.4%"
>   - Clarified the effect of duty cycle and state changes in the 'Limitations'
>     section and added a restriction regarding 0% duty cycle
>   - Added a comment in iqs620_pwm_apply to explain how duty cycle is derived
>   - Updated iqs620_pwm_apply to disable the output first and enable it last to
>     prevent temporarily driving a stale duty cycle
>   - Rounded the calculation for duty cycle up and down in iqs620_pwm_get_state
>     and iqs620_pwm_apply, respectively
>   - Added a comment in iqs620_pwm_get_state to explain what it reports follow-
>     ing requests to set duty cycle to 0%
>   - Added a lock to prevent back-to-back access of IQS620_PWR_SETTINGS_PWM_OUT
>     and IQS620_PWM_DUTY_CYCLE from being interrupted
>   - Updated iqs620_pwm_notifier to reference pwm->state directly as opposed to
>     calling pwm_get_state
>   - Moved notifier unregistration back to a device-managed action
>   - Added a completion to prevent iqs620_pwm_notifier from referencing the
>     pwm_chip structure until it has been initialized by pwmchip_add
> 
> Changes in v2:
>   - Merged 'Copyright' and 'Author' lines into one in introductory comments
>   - Added 'Limitations' section to introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Added const qualifier to state argument of iqs620_pwm_apply and removed all
>     modifications to the variable's contents
>   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the requested
>     polarity is inverted or the requested period is below 1 ms, respectively
>   - Updated iqs620_pwm_apply to disable the PWM output if duty cycle is zero
>   - Added iqs620_pwm_get_state
>   - Eliminated tabbed alignment of pwm_ops and platform_driver struct members
>   - Moved notifier unregistration to already present iqs620_pwm_remove, which
>     eliminated the need for a device-managed action and ready flag
>   - Added a comment in iqs620_pwm_probe to explain the order of operations
>   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> 
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-iqs620a.c | 254 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/pwm/pwm-iqs620a.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index bd21655..60bcf6c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -222,6 +222,16 @@ config PWM_IMX_TPM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx-tpm.
> 
> +config PWM_IQS620A
> +	tristate "Azoteq IQS620A PWM support"
> +	depends on MFD_IQS62X || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for the Azoteq IQS620A multi-function
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called pwm-iqs620a.
> +
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9a47507..a59c710 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
>  obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
> +obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> new file mode 100644
> index 0000000..ee5d8b5
> --- /dev/null
> +++ b/drivers/pwm/pwm-iqs620a.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS620A PWM Generator
> + *
> + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> + *
> + * Limitations:
> + * - The period is fixed to 1 ms and is generated continuously despite changes
> + *   to the duty cycle or enable/disable state.
> + * - Changes to the duty cycle or enable/disable state take effect immediately
> + *   and may result in a glitch during the period in which the change is made.
> + * - The device cannot generate a 0% duty cycle. For duty cycles below 1 / 256
> + *   ms, the output is disabled and relies upon an external pull-down resistor
> + *   to hold the GPIO3/LTX pin low.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/iqs62x.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define IQS620_PWR_SETTINGS			0xD2
> +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> +
> +#define IQS620_PWM_DUTY_CYCLE			0xD8
> +
> +#define IQS620_PWM_PERIOD_NS			1000000
> +
> +struct iqs620_pwm_private {
> +	struct iqs62x_core *iqs62x;
> +	struct pwm_chip chip;
> +	struct notifier_block notifier;
> +	struct completion chip_ready;
> +	struct mutex lock;
> +};
> +
> +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct iqs620_pwm_private *iqs620_pwm;
> +	struct iqs62x_core *iqs62x;
> +	int duty_scale, ret;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -ENOTSUPP;
> +
> +	if (state->period < IQS620_PWM_PERIOD_NS)
> +		return -EINVAL;
> +
> +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> +	iqs62x = iqs620_pwm->iqs62x;
> +
> +	mutex_lock(&iqs620_pwm->lock);
> +
> +	/*
> +	 * The duty cycle generated by the device is calculated as follows:
> +	 *
> +	 * duty_cycle = (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> +	 *
> +	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 255
> +	 * (inclusive). Therefore the lowest duty cycle the device can generate
> +	 * while the output is enabled is 1 / 256 ms.
> +	 *
> +	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
> +	 * allow an on-board pull-down resistor to hold the GPIO3/LTX pin low.
> +	 */
> +	duty_scale = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;

minor optimisation: You could do the division before grabbing the lock.
(But unsure if this actually gives a better result or the compiler is
clever enough to do this.)

> +
> +	if (!state->enabled || !duty_scale) {
> +		ret = regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> +					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> +		if (ret)
> +			goto err_mutex;
> +	}
> +
> +	if (duty_scale) {
> +		ret = regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> +				   min(duty_scale - 1, 0xFF));
> +		if (ret)
> +			goto err_mutex;
> +	}
> +
> +	if (state->enabled && duty_scale)
> +		ret = regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> +					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
> +
> +err_mutex:
> +	mutex_unlock(&iqs620_pwm->lock);
> +
> +	return ret;
> +}
> +
> +static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct iqs620_pwm_private *iqs620_pwm;
> +	struct iqs62x_core *iqs62x;
> +	unsigned int val;
> +	int ret;
> +
> +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> +	iqs62x = iqs620_pwm->iqs62x;
> +
> +	mutex_lock(&iqs620_pwm->lock);
> +
> +	/*
> +	 * Since the device cannot generate a 0% duty cycle, requests to do so
> +	 * cause subsequent calls to iqs620_pwm_get_state to report the output
> +	 * as disabled with duty cycle equal to that which was in use prior to
> +	 * the request. This is not ideal, but is the best compromise based on
> +	 * the capabilities of the device.
> +	 */
> +	ret = regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
> +	if (ret)
> +		goto err_mutex;
> +	state->enabled = val & IQS620_PWR_SETTINGS_PWM_OUT;
> +
> +	ret = regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
> +	if (ret)
> +		goto err_mutex;
> +	state->duty_cycle = DIV_ROUND_UP((val + 1) * IQS620_PWM_PERIOD_NS, 256);
> +	state->period = IQS620_PWM_PERIOD_NS;
> +
> +err_mutex:
> +	mutex_unlock(&iqs620_pwm->lock);
> +
> +	if (ret)
> +		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
> +}
> +

I thought we dicussed having a comment here, saying something like:

	The device might reset when [...] and as a result looses it's
	configuration. So the registers must be rewritten when this
	happens to restore the expected operation.

Is it worth to issue a warning when this happens?

> +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> +			       unsigned long event_flags, void *context)
> +{
> +	struct iqs620_pwm_private *iqs620_pwm;
> +	int ret;
> +
> +	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
> +				  notifier);
> +
> +	if (!completion_done(&iqs620_pwm->chip_ready) ||
> +	    !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> +		return NOTIFY_DONE;

Is here a (relevant?) race?  Consider the notifier triggers just when
pwmchip_add returned, (maybe even a consumer configured the device) and
before complete_all() is called. With my limited knowledge about
notifiers I'd say waiting for the completion here might be reasonable
and safe.

> +	ret = iqs620_pwm_apply(&iqs620_pwm->chip, &iqs620_pwm->chip.pwms[0],
> +			       &iqs620_pwm->chip.pwms[0].state);
> +	if (ret) {
> +		dev_err(iqs620_pwm->chip.dev,
> +			"Failed to re-initialize device: %d\n", ret);
> +		return NOTIFY_BAD;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static const struct pwm_ops iqs620_pwm_ops = {
> +	.apply = iqs620_pwm_apply,
> +	.get_state = iqs620_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static void iqs620_pwm_notifier_unregister(void *context)
> +{
> +	struct iqs620_pwm_private *iqs620_pwm = context;
> +	int ret;
> +
> +	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
> +						 &iqs620_pwm->notifier);
> +	if (ret)
> +		dev_err(iqs620_pwm->chip.dev,
> +			"Failed to unregister notifier: %d\n", ret);

	dev_err(iqs620_pwm->chip.dev,
		"Failed to unregister notifier: %pe\n", ERR_PTR(ret));

gives a nicer output. (Also applies to other error messages of course.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
