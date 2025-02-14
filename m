Return-Path: <linux-pwm+bounces-4911-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4120A3627F
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 17:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21627A3AB9
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89145267393;
	Fri, 14 Feb 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7WITPGB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A227245002;
	Fri, 14 Feb 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548790; cv=none; b=a9t8W7D3lBn+fr4+YieVpwTr9K4rS4MXkOHgvn7/6Q+j00BgSBk//XEfVtK5rjZoKq3jKECJ49g5RolkBk5UeO2g1/AIpLxSnB+g7fyFuFua+ohs3JUjS0vdYxe3AD9CqWad0Tl7apW9oFpfVLxGSd/2BIpDFg4M7dEZs3Ff7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548790; c=relaxed/simple;
	bh=rYjbSCDp4YfP2IYLu0YJT234xz5JIba6elGHU319qY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdaTaMdnDfmHS1w+tfgbNAGVuIVj1Jj01eCsS7rqE6dgeifQ61UNsC169xGcuT0PHPpndtsh9ds2VQFMX0CALE4CNYju9dUc5agFLmj7JwlVRkWOF0sAmxNH7iJaoM7/HivgjScnDyzAcgHAH0QMHJVEpDwhhR3Ko4OAZhOyQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7WITPGB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739548789; x=1771084789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rYjbSCDp4YfP2IYLu0YJT234xz5JIba6elGHU319qY8=;
  b=a7WITPGBeJS4DbfCpaFYiGErfhteEv7fTywQLihwG9NSbOsUc/Wztr/2
   S6t+d6Xm4cvB3LkAvIFIPb2Dm8ltc2fIJXpcUbHLaAovolrJfnsYV2wqL
   bcPEf/iLPkqp7y1HWK/TVeI1wIPGiDluUVa2Yzfe6K0LdT6+LyFznVDmk
   QgDV4vVoTgcYTz1/I9bfbjcUpAY5l3TdWYsY/q51p8GSyrrcO6H9hgHOa
   taK4BnxV7tgpVnAo9xz0Ondq2Ic2OVmF0MQ+aqpHck4VE5mAnH04aJqn3
   nKXfyZVd7OQ/VTrLXex1u/W42CG1Dfzct5adF1DGQ/ENqxNBMfU9q5Vih
   Q==;
X-CSE-ConnectionGUID: lMAxPSBHQ6aa1kstOnN/gQ==
X-CSE-MsgGUID: WLR0pQaxT6qcdX/hQo4uCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43139953"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43139953"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:59:48 -0800
X-CSE-ConnectionGUID: m5hwZGR3TryWlvX97j+8PQ==
X-CSE-MsgGUID: 1yNmNXg1QBWHBkRB3rqZzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144345048"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:59:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiy6O-0000000BXPT-0ATR;
	Fri, 14 Feb 2025 17:59:40 +0200
Date: Fri, 14 Feb 2025 17:59:39 +0200
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
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z69oa8_LKFxUacbj@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 12:49:57PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.

...

> +static int max7360_gpo_reg_mask_xlate(struct gpio_regmap *gpio,
> +				      unsigned int base, unsigned int offset,
> +				      unsigned int *reg, unsigned int *mask)
> +{
> +	u16 ngpios = gpio_regmap_get_ngpio(gpio);
> +
> +	*reg = base;
> +	*mask = BIT(MAX7360_MAX_KEY_COLS - (ngpios - offset));
> +
> +	return 0;

Does this GPIO controller only capable of servicing keypads?
I think no, hence I'm not sure why this split is needed to be
here and not in the input driver.

Or you mean that there output only GPIO lines in HW after all?
Is there a link to the datasheet?

> +}
> +
> +static int max7360_gpio_request(struct gpio_chip *gc, unsigned int pin)
> +{
> +	/*
> +	 * GPIOs on PORT pins are shared with the PWM and rotary encoder
> +	 * drivers: they have to be requested from the MFD driver.
> +	 */

So, this sounds to me like a pin control approach is needed here.
This looks like an attempt to hack it in an "easy" way.

> +	return max7360_port_pin_request(gc->parent->parent, pin, true);
> +}
> +
> +static void max7360_gpio_free(struct gpio_chip *gc, unsigned int pin)
> +{
> +	max7360_port_pin_request(gc->parent->parent, pin, false);
> +}
> +
> +static int max7360_set_gpos_count(struct device *dev, struct regmap *regmap)
> +{
> +	/*
> +	 * MAX7360 COL0 to COL7 pins can be used either as keypad columns,
> +	 * general purpose output or a mix of both.
> +	 */
> +	unsigned int val;
> +	u32 columns;
> +	u32 ngpios;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "ngpios", &ngpios);
> +	if (ret < 0) {
> +		dev_err(dev, "Missing ngpios OF property\n");

Clean messages from OF, "device property" is established term.

> +		return ret;
> +	}
> +
> +	/*
> +	 * Get the number of pins requested by the keypad and ensure our own pin
> +	 * count is compatible with it.
> +	 */
> +	ret = device_property_read_u32(dev->parent, "keypad,num-columns", &columns);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read columns count\n");
> +		return ret;
> +	}
> +
> +	if (ngpios > MAX7360_MAX_GPO ||
> +	    (ngpios + columns > MAX7360_MAX_KEY_COLS)) {
> +		dev_err(dev, "Incompatible gpos and columns count (%u, %u)\n",
> +			ngpios, columns);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad debounce
> +	 * timings and gpos/keypad columns repartition. Only the later is
> +	 * modified here.
> +	 */
> +	val = FIELD_PREP(MAX7360_PORTS, ngpios);
> +	ret = regmap_write_bits(regmap, MAX7360_REG_DEBOUNCE, MAX7360_PORTS, val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write max7360 columns/gpos configuration");
> +		return ret;
> +	}

Shouldn't this be configured via ->set_config() callback?

> +	return 0;
> +}

...

> +static int max7360_handle_mask_sync(const int index,
> +				    const unsigned int mask_buf_def,
> +				    const unsigned int mask_buf,
> +				    void *const irq_drv_data)
> +{
> +	struct regmap *regmap = irq_drv_data;
> +	unsigned int val;
> +
> +	for (unsigned int i = 0; i < MAX7360_MAX_GPIO; ++i) {
> +		val = (mask_buf & 1 << i) ? MAX7360_PORT_CFG_INTERRUPT_MASK : 0;

(mask_buf & BIT(i)) ?

> +		regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +				  MAX7360_PORT_CFG_INTERRUPT_MASK, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_gpio_probe(struct platform_device *pdev)
> +{
> +	struct regmap_irq_chip *irq_chip;
> +	struct regmap_irq_chip_data *irq_chip_data;
> +	struct gpio_regmap_config gpio_config = { };
> +	struct device *dev = &pdev->dev;
> +	unsigned long gpio_function;
> +	struct regmap *regmap;
> +	unsigned int outconf;
> +	unsigned long flags;
> +	int irq;
> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
> +
> +	gpio_function = (uintptr_t)device_get_match_data(dev);
> +
> +	if (gpio_function == MAX7360_GPIO_PORT &&
> +	    (device_property_read_bool(dev, "interrupt-controller"))) {
> +		/*
> +		 * Port GPIOs with interrupt-controller property: add IRQ
> +		 * controller.
> +		 */
> +		irq = fwnode_irq_get_byname(dev->parent->fwnode, "inti");

Use dev_fwnode() to get fwnode from struct device pointer.

> +		if (irq < 0)
> +			return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> +
> +		irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
> +		if (!irq_chip)
> +			return -ENOMEM;
> +
> +		irq_chip->name = dev_name(dev);
> +		irq_chip->status_base = MAX7360_REG_GPIOIN;
> +		irq_chip->num_regs = 1;
> +		irq_chip->num_irqs = MAX7360_MAX_GPIO;
> +		irq_chip->irqs = max7360_regmap_irqs;
> +		irq_chip->handle_mask_sync = max7360_handle_mask_sync;
> +		irq_chip->status_is_level = true;
> +		irq_chip->irq_drv_data = regmap;
> +
> +		for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
> +			regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +					  MAX7360_PORT_CFG_INTERRUPT_EDGES,
> +					  MAX7360_PORT_CFG_INTERRUPT_EDGES);
> +		}
> +
> +		flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
> +		ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), regmap, irq, flags, 0,
> +						      irq_chip, &irq_chip_data);

Right.

What I mean in previous discussion is to update gpio-regmap to call this from inside.
You need to add irq_chip pointer and irq_chip_data pointer to the regmap configuration
and if they are set (or the first one, I dunno if this is supported by IRQ chip core)
call this function and assign domain. This should be called after GPIO chip is
added, but before IRQ domain attachment.

> +		if (ret)
> +			return dev_err_probe(dev, ret, "IRQ registration failed\n");
> +
> +		gpio_config.irq_domain = regmap_irq_get_domain(irq_chip_data);
> +	}
> +
> +	if (gpio_function == MAX7360_GPIO_PORT) {
> +		/*
> +		 * Port GPIOs: set output mode configuration (constant-current or not).
> +		 * This property is optional.
> +		 */
> +		outconf = 0;
> +		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
> +		if (ret && (ret != -EINVAL))
> +			return dev_err_probe(dev, -ENODEV,

Why shadowing the real error code?

> +					     "Failed to read maxim,constant-current-disable OF property\n");

It may be not only OF :-)

> +
> +		regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
> +	}
> +
> +	/* Add gpio device. */
> +	gpio_config.parent = dev;
> +	gpio_config.regmap = regmap;

> +	if (gpio_function == MAX7360_GPIO_PORT) {
> +		gpio_config.ngpio = MAX7360_MAX_GPIO;

Why this case can't be managed also via ngpios property? Maybe at the end of
the day you rather need to have another property to tell where the split is?

This will help a lot and removes unneeded sharing of ngpios here and there.

What I read from this code is like you are trying to put _two_in_one_ semantics
on the shoulders of "ngpios".

> +		gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOIN);
> +		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PWMBASE);
> +		gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOCTRL);
> +		gpio_config.ngpio_per_reg = MAX7360_MAX_GPIO;
> +		gpio_config.request = max7360_gpio_request;
> +		gpio_config.free = max7360_gpio_free;
> +	} else {
> +		u32 ngpios;
> +
> +		ret = device_property_read_u32(dev, "ngpios", &ngpios);
> +		if (ret < 0) {
> +			dev_err(dev, "Missing ngpios OF property\n");
> +			return ret;
> +		}
> +
> +		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PORTS);
> +		gpio_config.reg_mask_xlate = max7360_gpo_reg_mask_xlate;
> +		gpio_config.ngpio = ngpios;
> +
> +		ret = max7360_set_gpos_count(dev, regmap);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to set GPOS pin count\n");
> +	}
> +
> +	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
> +}

-- 
With Best Regards,
Andy Shevchenko



