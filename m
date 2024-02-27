Return-Path: <linux-pwm+bounces-1646-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8892E869A74
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 16:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A1BB24C54
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821E14533A;
	Tue, 27 Feb 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ0YvUKx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B213A89E;
	Tue, 27 Feb 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047981; cv=none; b=o+sg13D1/waHs4eJ2vRSmqIrwOz5YlC+e+FCruFyEHSmfibo11Pn+MzuABorb8qTfaxzOfpkcHnM4Nn073XTNtad9eZQ8pErjxnvUnPvIxYXuOU1LTkZbTqUPrbdiF/R0QOE+US2tIQ8Vufyxw7hI/JV9C38E3dkAwx39fVNJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047981; c=relaxed/simple;
	bh=T4j8xfqw+zwHLE/uUZt6NV8Iqspz2dNbcwLvHsIhPsc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSDa/7Rgi+OnMYGgGe+IIGGnPTPlqCKjlR24F4k7UQO+brTJKII4t37oCilGHBFvEBTnnL2v1ue8mhiEwjabfkrMHmaHAfy8Nuq25XuRnlAcQaKpLJr+T/XoUf2Y6b4FDoTZVFtUID3gpneHxdGD76Zc7HmP5wNPFafSjX00xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ0YvUKx; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c19937913fso2448706b6e.3;
        Tue, 27 Feb 2024 07:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709047979; x=1709652779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl6JaZXqKyU5LHyUlDo+U8J8lU9YJxtct56VSY1/70I=;
        b=eZ0YvUKxb06n3Ded53v60tLTHhjUGOk3LNO4xhiWYf/p8XCb6R24ZU09DcAdfOm6H2
         xeSii60Kk0JkwLhTwYctZFYvf4AekGP0Fkuw2ShnPIQEwSinGoSCYl52nkTh2ROr4uZF
         YIaqnESFobs38ijReYYG3yMohMJpPbk2rNrNx6IjPHpjxmthcMMVzw2CeCzHo0vpRnpC
         yU8qeeFuhE7/GKV7+W3492nMqvi0evtpNkonH/SkRczS2gcfh5tyTxuFw6aj0DWl1m79
         C2JB9GgpoS6bDiooOo8n2pOKAi3KCtNRu38Zcv3Bta92riUNjHDk/asgKMKAyHXMN7ht
         w5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047979; x=1709652779;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl6JaZXqKyU5LHyUlDo+U8J8lU9YJxtct56VSY1/70I=;
        b=SNuybdOLjSNQ0KeOPobMCJY07cA+Buw4D6Z5heU5f5vj5weWxKXOLQ7HFcUGypCCIB
         SL6D9J+0dtSMG996ZyeonohmGdEd3OrvvuIeVldsE7oJVWYjN1lrd/G8/E2A5sMYe8gW
         seB8IsXRgYnJ5sQudDn8bpb3J+phZlw6vTuAYdQVEJrVTRcIPt7+7t1t7Hr9rbT48t4a
         QBpVrHaf5boYTPWxx2yaQJ7pyWVqH4O5jL4Fd7Yns17XNHN7xg55KOoA4bQXPpj9dzYH
         Arjk/oxh22ujJA6ix+/rYfMS0As8KpFghqt4QfRkK2KVWAt7tbqg27kS/DLCAx3HyZZr
         4gZg==
X-Forwarded-Encrypted: i=1; AJvYcCVXdNDAOeWErq70iEQFkpYrBnxFWFaPbLcXZXMWDieu4OK9E112okxu0hJ3DiFSkM3NyTq8vm08fcTdJQC3/VqimuiRi1vBv5U/i4FWjBvsmOMrj4z+kmd6RU9lZvu2nhr9qiRMH7PRYuY4CevVcVDuSzw9ecpvtHvGdWVMvcSzoXE=
X-Gm-Message-State: AOJu0Yx6TxERxjXU0r5ZlRWIYZ+NkMOTLAT0h8Vr/oDtfDs+FjWh44Qh
	YiOnYyPWGnRogW9dk1mz6uB2wfvlGMMkShsTOKJn+F+tX2IZwL+I
X-Google-Smtp-Source: AGHT+IH9bDXhSqDoPR+g2PorBmQZm2q/zIIpODkOLUwEpA7jfBXUAwEPEOGibiufDKOoWrKKTEBqIg==
X-Received: by 2002:a05:6808:1292:b0:3c1:340d:30b2 with SMTP id a18-20020a056808129200b003c1340d30b2mr2960755oiw.47.1709047978826;
        Tue, 27 Feb 2024 07:32:58 -0800 (PST)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 3-20020a544183000000b003c17fd0ed2bsm1464347oiy.47.2024.02.27.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:32:58 -0800 (PST)
Message-ID: <65de00aa.540a0220.f1081.6933@mx.google.com>
X-Google-Original-Message-ID: <Zd4AqT3EriAKVfji@neuromancer.>
Date: Tue, 27 Feb 2024 09:32:57 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204220851.4783-3-wahrenst@gmx.net>

On Sun, Feb 04, 2024 at 11:08:51PM +0100, Stefan Wahren wrote:
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
>  drivers/pwm/pwm-gpio.c | 228 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 240 insertions(+)
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
> index 000000000000..4435f275f509
> --- /dev/null
> +++ b/drivers/pwm/pwm-gpio.c
> @@ -0,0 +1,228 @@
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
> +
> +	if (state->duty_cycle && state->duty_cycle < hrtimer_resolution)
> +		return -EINVAL;
> +
> +	if (state->duty_cycle != state->period &&
> +	    (state->period - state->duty_cycle < hrtimer_resolution))
> +		return -EINVAL;
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
> +	gpwm->chip.atomic = true;
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
> +MODULE_AUTHOR("Vincent Whitchurch");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
> 

I have a series of devices with GPIO controlled force feedback that
this driver helps us control better. So I'm looking forward to this,
thank you.

Note that when I set the resolution too low (I got confused and set
the period to 255) my device locked up hard and only a forced
power cycle could bring it back.

Tested-by: Chris Morgan <macromorgan@hotmail.com>

