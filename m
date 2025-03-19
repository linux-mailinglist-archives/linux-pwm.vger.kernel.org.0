Return-Path: <linux-pwm+bounces-5242-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C10FA68C1F
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F46D3AD912
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3B4253F27;
	Wed, 19 Mar 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIyfWQAT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3920ADE9;
	Wed, 19 Mar 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385043; cv=none; b=XeLJgXTPmzec4BOLzsDACMssIrXwGCNm6NpWXcA9tR+rERnaFUkkr3eYj/rHPDcoGcFDAD0LHDrs7LtkYAOLttAZPKs/lc4Q+pboDsac9WfwL6U70eS8ilnL5vaE55w7qHRK2BzN/XIskCkCLJEtK71drnbTifDx2bcbA9fcGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385043; c=relaxed/simple;
	bh=OXvh+w7fFY4vwM4Wq0pk104cY1REpD3+vWmC1raHsk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTuOh28wSg6wdasj7GaSSP4WtzT7s512/Wd7k3fGqalX4ZZ9FQmNndHLCeLtbD7yDD5HxXd7oHcwvCnTd8ZaUsPQYVvBUUNVOKIFbaWVmcZ7s53//9v11EJznEOlDmKdNySt8Tu352kNaR4TjKYT8ffynXrB0XnhNrVTJb1Q7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIyfWQAT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742385041; x=1773921041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OXvh+w7fFY4vwM4Wq0pk104cY1REpD3+vWmC1raHsk0=;
  b=gIyfWQATIcI8iUyQSzuKkOKlZGOL3grhFUPQEIFWCs4HGq2k/UGEn062
   Ajjlzzhd83P+tGsM1ZkLncBDaaG1BJCMII5HyIYz3Z5t9ThwqUihh/+ud
   IR1Lm0/VUIj8RTVytc4xhd6cZ1B9Lzpp0Y2o9TJT8In7cKPohFI1Bccol
   K03MstU5hj452mxfupaM7/8wtMR010PjLpxILEzQL2LZbp2DgYYO6808+
   O+c9dylpmaM8xYBJsWgG3dvJGbxmQGki2fHGPQb+05wEMrAtCYL/c4wKJ
   lzex0pGINyMMuWr24xRyO5PJgmJIVT+Z9p+TyN8UFLfKPp9c0tp05Tef0
   Q==;
X-CSE-ConnectionGUID: RboImdTXQm6BDk8r6AooUA==
X-CSE-MsgGUID: cwXysiZBTEeMKssW24PfEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="31149401"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="31149401"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:50:40 -0700
X-CSE-ConnectionGUID: TqdOJaupQtuj3AxPrKAx/g==
X-CSE-MsgGUID: zN1iUCS1Q7qzRrLu3z8VPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="145775614"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:50:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1turwO-00000003uIh-3rIg;
	Wed, 19 Mar 2025 13:50:32 +0200
Date: Wed, 19 Mar 2025 13:50:32 +0200
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
Subject: Re: [PATCH v5 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z9qviF1VeSYNvcPJ@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-8-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-8-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:24PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.

...

+ bitfield.h

> +#include <linux/bitmap.h>

+ err.h

> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max7360.h>

+ mod_devicetable.h

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>

> +static int max7360_get_available_gpos(struct device *dev, unsigned int *available_gpios)
> +{
> +	u32 columns;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev->parent, "keypad,num-columns", &columns);
> +	if (ret < 0) {

' < 0' is redundant,

> +		dev_err(dev, "Failed to read columns count\n");
> +		return ret;
> +	}
> +
> +	*available_gpios = min(MAX7360_MAX_GPO, MAX7360_MAX_KEY_COLS - columns);
> +
> +	return 0;
> +}

...

> +static int max7360_set_gpos_count(struct device *dev, struct regmap *regmap)
> +{
> +	/*
> +	 * MAX7360 COL0 to COL7 pins can be used either as keypad columns,
> +	 * general purpose output or a mix of both.
> +	 * By default, all pins are used as keypad, here we update this
> +	 * configuration to allow to use some of them as GPIOs.
> +	 */
> +	unsigned int available_gpios;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = max7360_get_available_gpos(dev, &available_gpios);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure which GPIOs will be used for keypad.
> +	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad debounce
> +	 * timings and gpos/keypad columns repartition. Only the later is
> +	 * modified here.
> +	 */
> +	val = FIELD_PREP(MAX7360_PORTS, available_gpios);
> +	ret = regmap_write_bits(regmap, MAX7360_REG_DEBOUNCE, MAX7360_PORTS, val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write max7360 columns/gpos configuration");

> +		return ret;
> +	}
> +
> +	return 0;

Just

	return ret;

?

> +}

...

> +static int max7360_gpio_reg_mask_xlate(struct gpio_regmap *gpio,
> +				       unsigned int base, unsigned int offset,
> +				       unsigned int *reg, unsigned int *mask)
> +{
> +	if (base == MAX7360_REG_PWMBASE) {
> +		/*
> +		 * GPIO output is using PWM duty cycle registers: one register
> +		 * per line, with value being either 0 or 255.
> +		 */
> +		*reg = base + offset;
> +		*mask = 0xFF;

GENMASK() ?

> +	} else {
> +		*reg = base;
> +		*mask = BIT(offset);
> +	}
> +
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
> +		val = (mask_buf & BIT(i)) ? MAX7360_PORT_CFG_INTERRUPT_MASK : 0;
> +		regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +				  MAX7360_PORT_CFG_INTERRUPT_MASK, val);

Wondering if regmap_assign_bits() can be used here.

But in any case, no error checks? It seems you do elsewhere, but this driver...

> +	}
> +
> +	return 0;
> +}

...

> +static int max7360_gpio_probe(struct platform_device *pdev)
> +{
> +	struct regmap_irq_chip *irq_chip;
> +	struct gpio_regmap_config gpio_config = { };
> +	struct device *dev = &pdev->dev;
> +	unsigned long gpio_function;
> +	struct regmap *regmap;
> +	unsigned int outconf;
> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
> +
> +	gpio_function = (uintptr_t)device_get_match_data(dev);

> +

Redundant blank line.

> +	if (gpio_function == MAX7360_GPIO_PORT &&
> +	    (device_property_read_bool(dev, "interrupt-controller"))) {

Unneeded parentheses.

> +		/*
> +		 * Port GPIOs with interrupt-controller property: add IRQ
> +		 * controller.
> +		 */
> +		gpio_config.regmap_irq_flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;

But why is this being overridden? The DT or another firmware description has to
provide the correct settings, no?

> +		gpio_config.regmap_irq_irqno = fwnode_irq_get_byname(dev_fwnode(dev->parent),
> +								     "inti");

Better split is

		gpio_config.regmap_irq_irqno =
			fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");

You also can use the same trick elsewhere in the similar cases.

> +		if (gpio_config.regmap_irq_irqno < 0)
> +			return dev_err_probe(dev, gpio_config.regmap_irq_irqno,
> +					     "Failed to get IRQ\n");
> +
> +		irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
> +		gpio_config.regmap_irq_chip = irq_chip;
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

I would group this with status_base above. Easier to read and I think they are
kinda related.

> +		irq_chip->irq_drv_data = regmap;
> +
> +		for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
> +			regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +					  MAX7360_PORT_CFG_INTERRUPT_EDGES,
> +					  MAX7360_PORT_CFG_INTERRUPT_EDGES);

No error checks?

> +		}

> +	}
> +

Probably a comment why it's not 'else if' here?

> +	if (gpio_function == MAX7360_GPIO_PORT) {
> +		/*
> +		 * Port GPIOs: set output mode configuration (constant-current or not).
> +		 * This property is optional.
> +		 */
> +		outconf = 0;
> +		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);

> +		if (ret && (ret != -EINVAL))
> +			return dev_err_probe(dev, ret, "Failed to read %s device property\n",
> +					     "maxim,constant-current-disable");

This part is fragile, error codes are not _so_ stable inside the kernel,
and this may add an unneeded churn in case of pedantic cleanup.

Personally I would drop any messages and avoid failing the probe as to me it
does not sound like a critical issue.

> +		regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
> +	}
> +
> +	/* Add gpio device. */
> +	gpio_config.parent = dev;
> +	gpio_config.regmap = regmap;
> +	if (gpio_function == MAX7360_GPIO_PORT) {
> +		gpio_config.ngpio = MAX7360_MAX_GPIO;
> +		gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOIN);
> +		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PWMBASE);
> +		gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOCTRL);
> +		gpio_config.ngpio_per_reg = MAX7360_MAX_GPIO;
> +		gpio_config.reg_mask_xlate = max7360_gpio_reg_mask_xlate;
> +	} else {
> +		ret = max7360_set_gpos_count(dev, regmap);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to set GPOS pin count\n");
> +
> +		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PORTS);
> +		gpio_config.ngpio = MAX7360_MAX_KEY_COLS;
> +		gpio_config.init_valid_mask = max7360_gpo_init_valid_mask;
> +	}
> +
> +	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
> +}

-- 
With Best Regards,
Andy Shevchenko



