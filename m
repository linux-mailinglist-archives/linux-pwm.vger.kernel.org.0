Return-Path: <linux-pwm+bounces-5560-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78825A92682
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A51C188B474
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB992566ED;
	Thu, 17 Apr 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2+ypom3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0542561A2;
	Thu, 17 Apr 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913634; cv=none; b=BMZB0fNXoJmHN68VmBGeOgv+CU2ti1NWYy6Q6W8Oc05hPMLWDG2lk5L+25tL4+qPReRo+mPzclU5JNTwo6NT3apDaNIocJTI8asEuPsYFc9wGyQAvPTazYAI+0KD9mBH3MDGeGsKnaikEi9IThPON/cC+LY10EdVOAYsjwnMAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913634; c=relaxed/simple;
	bh=jhQcOuzugiusV1wCkewmVx873muTFqglAedGjPVY23w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGLyzrJMRtVVId+tUM0tAPBgwDNz+rdmEQ/kLOwtOZpXeIZMiAHB2hag2cNcmLMTsA2Li795ipPHmp/1EsCXcmKSZTw8aAhofW51S3+QmzQ1r5OnqwYJSA3sVEQ60Amr28BRomfbYbfqENsyhciUnpKa7L1ZCkc6rnTWoxrtiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2+ypom3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744913632; x=1776449632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhQcOuzugiusV1wCkewmVx873muTFqglAedGjPVY23w=;
  b=J2+ypom3ybiab0tmxYnB4lG08kK+Sls0tZXWPEKIzA/pXXQjp5gFeWRG
   3htAxfFt3Ql2uWW+7xjPgYeE0iE69HVOaW8EtHM+167pXwvMlbJc55dGO
   J4HE5x1b+WGCsLgLD6++joEb1yg3NHkMf9eG5c+FSNNK/15H3ot+vV/h1
   35OVMKVPUBwKLqjjvrspVIEGb6rQnNdD6vwX8BgFzl3QakrvLld/j9pUc
   3m9NEu5NT4MHufqZ6WaQkOmWa7DCdqDczfRyQPHEHKkLe6saM2SnLmjw1
   tRzlCF/Fu3DIal0g7XSvvDp3XWU9TY1Z+OzQ37SunEmb43agqed87ODGp
   A==;
X-CSE-ConnectionGUID: CwItz0+WRhiMj6vKMFjDjQ==
X-CSE-MsgGUID: j5ERu+XMSha7JZ0j/Kax6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57516499"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57516499"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:13:52 -0700
X-CSE-ConnectionGUID: 8G43IVxDQH25aqgxxkbV7w==
X-CSE-MsgGUID: QzEElvMvQuGTYcHTJLzjrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130843461"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:13:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u5Tk7-0000000DHFe-3Nus;
	Thu, 17 Apr 2025 21:13:43 +0300
Date: Thu, 17 Apr 2025 21:13:43 +0300
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
Subject: Re: [PATCH v6 09/12] gpio: max7360: Add MAX7360 gpio support
Message-ID: <aAFE18Yn5rtnuooc@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-9-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-9-7a2535876e39@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:55:56PM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.

...

> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

> +#include <linux/slab.h>

I don't think you use this header directly.

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

> +	gpio_function = (uintptr_t)device_get_match_data(dev);

Somebody pointed me out the Linus' rant on uintptr_t, so he prefers not to see
this in the entire kernel. He suggested to use (unsigned long), but ideally one
should operate with the info structures instead.

...

> +	if (gpio_function == MAX7360_GPIO_PORT) {
> +		if (device_property_read_bool(dev, "interrupt-controller")) {
> +			/*
> +			 * Port GPIOs with interrupt-controller property: add IRQ
> +			 * controller.
> +			 */
> +			gpio_config.regmap_irq_flags = IRQF_ONESHOT | IRQF_SHARED;
> +			gpio_config.regmap_irq_irqno =
> +				fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");
> +			if (gpio_config.regmap_irq_irqno < 0)
> +				return dev_err_probe(dev, gpio_config.regmap_irq_irqno,
> +						     "Failed to get IRQ\n");
> +
> +			irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
> +			gpio_config.regmap_irq_chip = irq_chip;
> +			if (!irq_chip)
> +				return -ENOMEM;
> +
> +			irq_chip->name = dev_name(dev);
> +			irq_chip->status_base = MAX7360_REG_GPIOIN;
> +			irq_chip->status_is_level = true;
> +			irq_chip->num_regs = 1;
> +			irq_chip->num_irqs = MAX7360_MAX_GPIO;
> +			irq_chip->irqs = max7360_regmap_irqs;
> +			irq_chip->handle_mask_sync = max7360_handle_mask_sync;
> +			irq_chip->irq_drv_data = regmap;
> +
> +			for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
> +				ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +							MAX7360_PORT_CFG_INTERRUPT_EDGES,
> +							MAX7360_PORT_CFG_INTERRUPT_EDGES);
> +				if (ret)
> +					return dev_err_probe(dev, ret,
> +							     "Failed to enable interrupts\n");
> +			}
> +		}
> +
> +		/*
> +		 * Port GPIOs: set output mode configuration (constant-current or not).
> +		 * This property is optional.
> +		 */
> +		outconf = 0;
> +		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
> +		if (!ret) {
> +			ret = regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to set constant-current configuration\n");
> +		}

This will look better as if-else:

		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
		if (ret) {
			outconf = 0;
		} else {
			ret = regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
			if (ret)
				return dev_err_probe(dev, ret,
						     "Failed to set constant-current configuration\n");
		}

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



