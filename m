Return-Path: <linux-pwm+bounces-4745-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84EDA1D658
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2779A3A7572
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05EA1FF1BC;
	Mon, 27 Jan 2025 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXQ3XFwx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB414D28C;
	Mon, 27 Jan 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983266; cv=none; b=KSHQVlmYQEMwwIqaUuVsGJ47/skESa33dAy+QP+VAVpwp3TQiMmI6c/E9pavyAlW3u9V0MfT+LzcjGGRLkO0GXXZIBINUGpwNNby3y7Y/YiyRntUxZffNczyy4W8gwyhSd4EkUSyXAjFVtkir6iqEDYufigvSTGiyzaNKolhfbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983266; c=relaxed/simple;
	bh=kThb7PZEEYxM8oThc709Ts2hrldglchXKP1Y0Glm364=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfVEF6u5CPfGjYynTxNNMbLAsJZXZPPAiLxaAwQUzxF550OfZyeEgq6eGk53iihGC5XfoLbIDNrfdtx/XR5H0NbcL53MJt1qtjIcEp2Btr0EjWso0LGHjmyNfUiqnBnd8y1ed5LEhZrkzESe/zyl+bhE4YKiPmdQICsSZLTgYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXQ3XFwx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737983264; x=1769519264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kThb7PZEEYxM8oThc709Ts2hrldglchXKP1Y0Glm364=;
  b=VXQ3XFwxii/+buq53lcbqxuHpLDL0PZHeHgG0sQoRrOkCPVvJOcm6t1n
   SH2eqF10inR/4M3wxFOBP9GXE8DzJOi+cMKg1EiWI7ls2V5sSYLs85GPR
   dM3gZHCxLVTbRWhQene//nPZBZIi09FcvOYDdhgpFSxUU0b5GYu4mxiqj
   PzjkG8rCuxlx4ZoCGzRVlRLXutWH7A8ArZ3fu+wAwT2zYSX565NnMaI3h
   +ssbPWdh5ZNrskpxIQ7j4cvsDQGMhwh7JP37AuAk7mr5fZxNeBiAzzmA2
   Yl7mQ2R8K15lVTApIUGh57tfY6AL6fJfpXFNObKca9tZ5a5lc8rPV+3a1
   w==;
X-CSE-ConnectionGUID: /w8/hjL9TI+r0+Ibj62cQA==
X-CSE-MsgGUID: xJuBkXGyQ9CK0uErC5RRGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42102975"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="42102975"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 05:07:43 -0800
X-CSE-ConnectionGUID: uTZEPRmTRIGzk50tHgCOGA==
X-CSE-MsgGUID: 4uzBL39xQeql3eA+juWwtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139282442"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 05:07:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tcOq0-00000005jRl-3up0;
	Mon, 27 Jan 2025 15:07:36 +0200
Date: Mon, 27 Jan 2025 15:07:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z5eFGJspoGOINcG6@smile.fi.intel.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.

...

> +	depends on OF_GPIO

This is wrong. You don't use it.

...

> +#include <linux/of.h>

Shouldn't be here. Instead it should be linux/property.h.

...

> +	/* MAX7360 generates interrupts but does not report which pins changed:
> +	 * compare the pin value with the value they had in previous interrupt
> +	 * and report interrupt if the change match the set IRQ type.
> +	 */

/*
 * Wrong multi-line comment style. Consider using
 * this one as an example. This applies to all the comments
 * in the entire series.
 */

> +	pending = val ^ max7360_gpio->in_values;
> +	for_each_set_bit(irqn, &pending, max7360_gpio->chip.ngpio) {
> +		type = max7360_gpio->irq_types[irqn];
> +		if (max7360_gpio->masked_interrupts & BIT(irqn))
> +			continue;
> +		if ((val & BIT(irqn)) && type == IRQ_TYPE_EDGE_FALLING)
> +			continue;
> +		if (!(val & BIT(irqn)) && type == IRQ_TYPE_EDGE_RISING)
> +			continue;
> +		gpio_irq = irq_find_mapping(max7360_gpio->chip.irq.domain, irqn);
> +		handle_nested_irq(gpio_irq);
> +		count++;

You can also look how gpio-pca953x.c does this. It uses bitmaps all over the
place. But with the gpio-regmap.c in use this should be much more simpler.

> +	}

> +	max7360_gpio->in_values = val;

> +	if (count == 0)

count is redundant, Checking pending against 0 is enough (or in case of
bitmaps, if it's longer than unsigned long, bitmap_empty() is what is here).

> +		return IRQ_NONE;
> +
> +	return IRQ_HANDLED;

...

> +static int max7360_gpio_probe(struct platform_device *pdev)
> +{
> +	struct max7360_gpio *max7360_gpio;
> +	struct platform_device *parent;
> +	unsigned int ngpios;
> +	unsigned int outconf;
> +	struct gpio_irq_chip *girq;
> +	unsigned long flags;
> +	int irq;
> +	int ret;

> +	if (!pdev->dev.parent) {
> +		dev_err(&pdev->dev, "no parent device\n");
> +		return -ENODEV;
> +	}

Probably redundant as one of the calls below may fail if parent is absent (see
below for more).

> +	parent = to_platform_device(pdev->dev.parent);

Why do you need this? Can't the fwnode be propagated to the children and then
the respective APIs to be used?

> +	max7360_gpio = devm_kzalloc(&pdev->dev, sizeof(*max7360_gpio),
> +				    GFP_KERNEL);

With

	struct device *dev = &pdev->dev;

at the beginning of the function this and other lines will become neater and
shorter, in particular this becomes one line even for the strict 80 characters
limit (however we have it being relaxed to 100 nowadays).

> +	if (!max7360_gpio)
> +		return -ENOMEM;

> +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> +		return -ENODEV;
> +	}

This is not needed, it is already done in GPIOLIB core.

> +	max7360_gpio->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_gpio->regmap) {
> +		dev_err(&pdev->dev, "could not get parent regmap\n");
> +		return -ENODEV;

Here and everywhere in the ->probe() and related use

	return dev_err_probe(...);

And drop unneeded curly braces.

> +	}

> +	max7360_gpio->dev = &pdev->dev;

So, why do you need this dup? You can easily get it via GPIO chip, no?

> +	max7360_gpio->chip = max7360_gpio_chip;
> +	max7360_gpio->chip.ngpio = ngpios;
> +	max7360_gpio->chip.parent = &pdev->dev;
> +	max7360_gpio->chip.base = -1;
> +	max7360_gpio->gpio_function = (uintptr_t)device_get_match_data(&pdev->dev);
> +
> +	dev_dbg(&pdev->dev, "gpio count: %d\n", max7360_gpio->chip.ngpio);
> +
> +	if (max7360_gpio->gpio_function == MAX7360_GPIO_PORT) {
> +		/* Port GPIOs: set output mode configuration (constant-current
> +		 * or not).
> +		 * This property is optional.
> +		 */
> +		outconf = 0;
> +		ret = of_property_read_u32(pdev->dev.of_node,
> +					   "maxim,constant-current-disable",
> +					   &outconf);

device_property_read_u32()

> +		if (ret && (ret != -EINVAL)) {
> +			dev_err(&pdev->dev,
> +				"Failed to read maxim,constant-current-disable OF property\n");
> +			return -ENODEV;
> +		}
> +
> +	    regmap_write(max7360_gpio->regmap, MAX7360_REG_GPIOOUTM, outconf);
> +	}
> +
> +	if (max7360_gpio->gpio_function == MAX7360_GPIO_PORT &&
> +	    of_property_read_bool(pdev->dev.of_node, "interrupt-controller")) {
> +		/* Port GPIOs: declare IRQ chip, if configuration was provided.
> +		 */

> +		irq = platform_get_irq_byname(parent, "inti");

fwnode_irq_get_byname() with the propagated firmware node will give you
the same result.

> +		if (irq < 0)
> +			return dev_err_probe(&pdev->dev, irq,
> +					     "Failed to get IRQ\n");
> +
> +		flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						max7360_gpio_irq, flags,
> +						"max7360-gpio", max7360_gpio);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to register interrupt\n");
> +
> +		girq = &max7360_gpio->chip.irq;
> +		gpio_irq_chip_set_chip(girq, &max7360_gpio_irqchip);
> +		girq->parent_handler = NULL;
> +		girq->num_parents = 0;
> +		girq->parents = NULL;
> +		girq->threaded = true;
> +		girq->default_type = IRQ_TYPE_NONE;
> +		girq->handler = handle_simple_irq;
> +	}
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, &max7360_gpio->chip, max7360_gpio);
> +	if (ret) {
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "unable to add gpiochip\n");
> +	}
> +
> +	return 0;
> +}

...

> +static struct platform_driver max7360_gpio_driver = {
> +	.driver = {
> +		.name	= MAX7360_DRVNAME_GPIO,

> +		.of_match_table = of_match_ptr(max7360_gpio_of_match),

No of_match_ptr() or ACPI_PTR() in new code, please. It appears to be more
harmful than helpful.

> +	},
> +	.probe		= max7360_gpio_probe,
> +};
> +module_platform_driver(max7360_gpio_driver);

...

> +MODULE_ALIAS("platform:" MAX7360_DRVNAME_GPIO);

Why? It doesn't look like it can be instantiated via board files.

...

Overall seems many of my comments are applicable to your entire series (all
patches), please address and feel free to Cc me on v4 for review.

-- 
With Best Regards,
Andy Shevchenko



