Return-Path: <linux-pwm+bounces-1126-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F33841ED7
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jan 2024 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3FD2823B3
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jan 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CCF58AA1;
	Tue, 30 Jan 2024 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="M7aXIJfb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A085813B;
	Tue, 30 Jan 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605738; cv=none; b=j/m5UwLJXoW8tJMYLTCRGjMwWas7VZ1uhSF1nKbjnkhUUz/m+8zq09F3tRQEXP/Z23fXTgdBUkrrwYzjrU4SwB3cc7dr0MlSuB49rU1bxSVLp1YomI8x0kwhfW/mp7rgCYxp6Si8bAVblIZV0qHD+h5UGXdPWF/hGYMonFZwwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605738; c=relaxed/simple;
	bh=oideb+asFMxZR4g5QDgCYuxrKgMZ8LK09qQfP2a79vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufbVIME7PZ1aqfSEIVhgxZhzxFZ/b/m7zPjpOXvaenr+kTMT0EqCXqmZx2qCmQplxUkz5uUU/w660VyZDnWGaXvVALFY+eTf9RY5ARteg/BjTwRzvyC/5qszoqTC4tg0ha2K5NoM4Zk8mSOVKwF0N+oMvNxWXeuA4EFtD08y3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=M7aXIJfb; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1706605733; bh=oideb+asFMxZR4g5QDgCYuxrKgMZ8LK09qQfP2a79vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7aXIJfbl0uZESqNJY+RV4ofmXt0GAO+aWvgqU2zDaEynhaAZHTaCL0BoaBswE/NP
	 YMa+whXzVy0ftnpBI8+HHdBALw4RANkmYzD3s0pIh3WY2nIjU9c76vtZ89kdd1OfJn
	 bxG+iaxpEDXGDTi79FzvCvpq3vddkIc+4Q+rCeaI4ASXGd9C7iFP5l9BPk4FZAeWUR
	 SR0nqhTkKcQ88qyroNlrDgmJL7AR3OG75sfMo0YmpDhugxyb7WKQbC+vrhV/xzywGX
	 O4l6bnYLX7YDGIUbyTxHs0tRPCN0/418zuLLxjDZdWvo1aEfk8nfuqOSBPPw5KcQsM
	 qVfn91LY0VYIA==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 182C01000FA; Tue, 30 Jan 2024 09:08:53 +0000 (GMT)
Date: Tue, 30 Jan 2024 09:08:53 +0000
From: Sean Young <sean@mess.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH V3 2/2] pwm: Add GPIO PWM driver
Message-ID: <Zbi8pbT7N0vKUgmx@gofer.mess.org>
References: <20240128163630.104725-1-wahrenst@gmx.net>
 <20240128163630.104725-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128163630.104725-3-wahrenst@gmx.net>

On Sun, Jan 28, 2024 at 05:36:30PM +0100, Stefan Wahren wrote:
> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Add a software PWM which toggles a GPIO from a high-resolution timer.
> 
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
> 
> Since high-resolution timers are used, sleeping gpio chips are not
> supported and are rejected in the probe function.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/pwm/Kconfig    |  11 ++
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-gpio.c | 221 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 drivers/pwm/pwm-gpio.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..7cfda2cde130 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -227,6 +227,17 @@ config PWM_FSL_FTM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-fsl-ftm.
> 
> +config PWM_GPIO
> +	tristate "GPIO PWM support"
> +	depends on GPIOLIB
> +	depends on HIGH_RES_TIMERS
> +	help
> +	  Generic PWM framework driver for a software PWM toggling a GPIO pin
> +	  from kernel high-resolution timers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-gpio.
> +
>  config PWM_HIBVT
>  	tristate "HiSilicon BVT PWM support"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..59d1a46bb1af 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
>  obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
>  obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
> +obj-$(CONFIG_PWM_GPIO)		+= pwm-gpio.o
>  obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
>  obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
> diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
> new file mode 100644
> index 000000000000..14637abe465b
> --- /dev/null
> +++ b/drivers/pwm/pwm-gpio.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic software PWM for modulating GPIOs
> + *
> + * Copyright (C) 2020 Axis Communications AB
> + * Copyright (C) 2020 Nicola Di Lieto
> + * Copyright (C) 2024 Stefan Wahren
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/hrtimer.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +
> +struct pwm_gpio {
> +	struct pwm_chip chip;
> +	struct hrtimer gpio_timer;
> +	struct gpio_desc *gpio;
> +	struct pwm_state state;
> +	struct pwm_state next_state;
> +
> +	/* Protect internal state between pwm_ops and hrtimer */
> +	spinlock_t lock;
> +
> +	bool changing;
> +	bool running;
> +	bool level;
> +};
> +
> +static unsigned long pwm_gpio_toggle(struct pwm_gpio *gpwm, bool level)
> +{
> +	const struct pwm_state *state = &gpwm->state;
> +	bool invert = state->polarity == PWM_POLARITY_INVERSED;
> +
> +	gpwm->level = level;
> +	gpiod_set_value(gpwm->gpio, gpwm->level ^ invert);
> +
> +	if (!state->duty_cycle || state->duty_cycle == state->period) {
> +		gpwm->running = false;
> +		return 0;
> +	}
> +
> +	gpwm->running = true;
> +	return level ? state->duty_cycle : state->period - state->duty_cycle;
> +}
> +
> +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *gpio_timer)
> +{
> +	struct pwm_gpio *gpwm = container_of(gpio_timer, struct pwm_gpio,
> +					     gpio_timer);
> +	unsigned long next_toggle;
> +	unsigned long flags;
> +	bool new_level;
> +
> +	spin_lock_irqsave(&gpwm->lock, flags);
> +
> +	/* Apply new state at end of current period */
> +	if (!gpwm->level && gpwm->changing) {
> +		gpwm->changing = false;
> +		gpwm->state = gpwm->next_state;
> +		new_level = !!gpwm->state.duty_cycle;
> +	} else {
> +		new_level = !gpwm->level;
> +	}
> +
> +	next_toggle = pwm_gpio_toggle(gpwm, new_level);
> +	if (next_toggle) {
> +		hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_timer),
> +				ns_to_ktime(next_toggle));
> +	}
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
> +}
> +
> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
> +	bool invert = state->polarity == PWM_POLARITY_INVERSED;
> +	unsigned long flags;

Not sure this is necessary but how about:

	if (state->duty_cycle < hrtimer_resolution ||
	    state->period - state->duty_cycle < hrtimer_resolution)
		return -EINVAL;

> +
> +	if (!state->enabled) {
> +		hrtimer_cancel(&gpwm->gpio_timer);
> +	} else if (!gpwm->running) {
> +		/*
> +		 * This just enables the output, but pwm_gpio_toggle()
> +		 * really starts the duty cycle.
> +		 */
> +		int ret = gpiod_direction_output(gpwm->gpio, invert);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	spin_lock_irqsave(&gpwm->lock, flags);
> +
> +	if (!state->enabled) {
> +		gpwm->state = *state;
> +		gpwm->running = false;
> +		gpwm->changing = false;
> +
> +		gpiod_set_value(gpwm->gpio, invert);
> +	} else if (gpwm->running) {
> +		gpwm->next_state = *state;
> +		gpwm->changing = true;
> +	} else {
> +		unsigned long next_toggle;
> +
> +		gpwm->state = *state;
> +		gpwm->changing = false;
> +
> +		next_toggle = pwm_gpio_toggle(gpwm, !!state->duty_cycle);
> +		if (next_toggle) {
> +			hrtimer_start(&gpwm->gpio_timer, next_toggle,
> +				      HRTIMER_MODE_REL);
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpwm->lock, flags);
> +
> +	if (gpwm->changing)
> +		*state = gpwm->next_state;
> +	else
> +		*state = gpwm->state;
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_gpio_ops = {
> +	.apply = pwm_gpio_apply,
> +	.get_state = pwm_gpio_get_state,
> +};
> +
> +static int pwm_gpio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pwm_gpio *gpwm;
> +	int ret;
> +
> +	gpwm = devm_kzalloc(dev, sizeof(*gpwm), GFP_KERNEL);
> +	if (!gpwm)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&gpwm->lock);
> +
> +	gpwm->gpio = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> +	if (IS_ERR(gpwm->gpio)) {
> +		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
> +				     "could not get gpio\n");
> +	}
> +
> +	if (gpiod_cansleep(gpwm->gpio)) {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "sleeping GPIO %d not supported\n",
> +				     desc_to_gpio(gpwm->gpio));
> +	}
> +
> +	gpwm->chip.dev = dev;
> +	gpwm->chip.ops = &pwm_gpio_ops;
> +	gpwm->chip.npwm = 1;

	gpwm->chip.atomic = true; ?

> +
> +	hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	gpwm->gpio_timer.function = pwm_gpio_timer;
> +
> +	ret = pwmchip_add(&gpwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "could not add pwmchip\n");
> +
> +	platform_set_drvdata(pdev, gpwm);
> +
> +	return 0;
> +}
> +
> +static void pwm_gpio_remove(struct platform_device *pdev)
> +{
> +	struct pwm_gpio *gpwm = platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&gpwm->chip);
> +	hrtimer_cancel(&gpwm->gpio_timer);
> +}
> +
> +static const struct of_device_id pwm_gpio_dt_ids[] = {
> +	{ .compatible = "pwm-gpio" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_gpio_dt_ids);
> +
> +static struct platform_driver pwm_gpio_driver = {
> +	.driver = {
> +		.name = "pwm-gpio",
> +		.of_match_table = pwm_gpio_dt_ids,
> +	},
> +	.probe = pwm_gpio_probe,
> +	.remove_new = pwm_gpio_remove,
> +};
> +module_platform_driver(pwm_gpio_driver);
> +
> +MODULE_DESCRIPTION("PWM GPIO driver");
> +MODULE_ALIAS("platform:pwm-gpio");
> +MODULE_AUTHOR("Vincent Whitchurch");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
> 

