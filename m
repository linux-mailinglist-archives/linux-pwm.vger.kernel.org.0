Return-Path: <linux-pwm+bounces-5805-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9335AA6FF3
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866361C007AA
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F323C4F8;
	Fri,  2 May 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnU6Muju"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC519D07B;
	Fri,  2 May 2025 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182374; cv=none; b=HEJgUw5Qy0n1kLX8g2FY5ZSlkcg3Szo3KbYF4xK+msy0irjalfgT0w1bFplUkyK17Y54Ltx46cbkg6wvfFTS9Ztc5n2yyHX7KWE2S9WdiiOv1h5BLPK9WgcJzY5qf6IOi/ARvKXcsrglanIZRBtSRGdMj0KuDvWx5wWuLNSRqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182374; c=relaxed/simple;
	bh=k2HSV8/6jmFeiVY3Fl/ESqkYIy6+9gkufQuyLH4M/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oauvX0QA7bHe9/k8A7DKt01xoA+CSyI+hwP1/OsaVkou8OoO4I6k+tuyaLN6NRnkr7Vl82A9khCsTDiXCwTNCW14OfHsiLgXK1bZxNu5mEzZotv1CZX/wj+l2Pim4p40ZGYWiGvyEIevZ/C8O/RpA07iLAiH2R4u/k5mXT6A1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnU6Muju; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746182372; x=1777718372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2HSV8/6jmFeiVY3Fl/ESqkYIy6+9gkufQuyLH4M/AY=;
  b=EnU6MujuJ5qHoFxjj4DjHzH4aztd9UfKmyKSVbvPFB1MhnODr+CiPNyq
   D7zwbTJCPmMfqB4VYmXtC6dUj6vP2DKPZNf05fTXxecSKNvAMMH4yNT3Q
   5VGplZ7h1NbDdOHeXU99M1iwkogxiai1eK1+S4xxwYnj3UIDQ9ZBvFvHf
   adgn25tn1TKr/F4Zl0y9+LIegSGduJTtuh6LU8sIJtwjxj0NLycWmIgGK
   oCNKFrpy930XAj4rP01OL0aFsrtu/dD+/tAlMFTd66QCkQUolUvDqcdmc
   +e+iTNglbRNtevqNTzWxk2V1+7HlCpidIjsjrtEcwrFSi0G2VFIfu7b9+
   Q==;
X-CSE-ConnectionGUID: bTVzWRRjSrixP97S5o+9kA==
X-CSE-MsgGUID: osjM7BzhThKuVWwL4lV/Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="46972823"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="46972823"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:39:31 -0700
X-CSE-ConnectionGUID: RKK5Nb7GQdmA/sCFwHCfQQ==
X-CSE-MsgGUID: zbkvS9inQSmWpv7X68kAWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134362449"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:39:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAnnf-00000002AKs-0IXp;
	Fri, 02 May 2025 13:39:23 +0300
Date: Fri, 2 May 2025 13:39:22 +0300
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <aBSg2qwNhPqJJRxK@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-8-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-8-4e0608d0a7ff@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 01:57:26PM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.

...

> +#include <linux/bitmap.h>
> +#include <linux/err.h>

> +#include <linux/gpio/driver.h>

Is this still needed?

> +#include <linux/gpio/regmap.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max7360.h>

+ minmax.h

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

...

> +static int max7360_gpio_probe(struct platform_device *pdev)
> +{
> +	const struct max7360_gpio_plat_data *plat_data;
> +	struct gpio_regmap_config gpio_config = { };
> +	struct regmap_irq_chip *irq_chip;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	unsigned int outconf;
> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
> +
> +	plat_data = device_get_match_data(dev);
> +	if (plat_data->function == MAX7360_GPIO_PORT) {
> +		if (device_property_read_bool(dev, "interrupt-controller")) {
> +			/*
> +			 * Port GPIOs with interrupt-controller property: add IRQ
> +			 * controller.
> +			 */
> +			gpio_config.regmap_irq_flags = IRQF_ONESHOT | IRQF_SHARED;
> +			gpio_config.regmap_irq_line =
> +				fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");
> +			if (gpio_config.regmap_irq_line < 0)
> +				return dev_err_probe(dev, gpio_config.regmap_irq_line,
> +						     "Failed to get IRQ\n");

> +			irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);

Can this be made static const instead?

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
> +		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
> +		if (!ret) {
> +			ret = regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to set constant-current configuration\n");
> +		}
> +	}
> +
> +	/* Add gpio device. */
> +	gpio_config.parent = dev;
> +	gpio_config.regmap = regmap;
> +	if (plat_data->function == MAX7360_GPIO_PORT) {
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



