Return-Path: <linux-pwm+bounces-4941-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D7A3986C
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Feb 2025 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E5D172B39
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Feb 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885772376E0;
	Tue, 18 Feb 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQ4W974U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72863237193;
	Tue, 18 Feb 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873393; cv=none; b=ekplXN6zvwDnoUFX+9psGSxcRFAtq20WyEkvBD/8G6qfzXUvchW8hqOL6flWLMWYu7vZI1/siYY36cVmZEoelOcn89uIV6Y+42TUOpZqOEHxOB5GSeow9aalhV6h9EkWvo+aonnWG9u7afvc6yMXwEFgn5HvqFY3Hdxc5c1Uivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873393; c=relaxed/simple;
	bh=Nt+r2U4lRQb0wBBJSIqF6I1c5UIQTs60Mq/IwlHvIi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jht4YVv5ybQiaA6jZJLHMvOVOwtck8io0lJAPXd9XGKTODXv1p81gvYS3AjYGtlxkYPSY5/TrM61Yk8Jp20k47XaDOyVex0Jxp2SUDqITKJxk7LXMUe6KdX+EHLF3VYA9QttY/kbBFxjNL7ycEflwM22eaWWBdk36r7u6AmLfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQ4W974U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739873392; x=1771409392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nt+r2U4lRQb0wBBJSIqF6I1c5UIQTs60Mq/IwlHvIi8=;
  b=UQ4W974U88pX96lQHwaE33b2bZQzpvjw17InvJuHlfZODEQPNYNPz8YW
   TrtbuunWD3cFlPOGlYsYUG+/D4VSJu3lr5+XhoFPGbGmrczvBEDogHYG6
   BM3grKbzxvOklWT5Spge8mPzgsTiQEtYIKvg37PZ5LOJDIJhP7UEbhaHB
   i4gtU7pIdrqRyi/X6VYDt8CYag3kQ/JN9X5wNUhEZAGgU9ljP2zfS0KAL
   HHXUbqV/mvwXIxbSO73JSiWjr4TiRhNOFsFFFOn/1ONvdeZyHDr00q0zK
   Sm/KHJYAAFuaw8AZvr6hJk+iMG7k1+D4/G+DPSMWgokYWaroWTZr4ZYXM
   A==;
X-CSE-ConnectionGUID: x6RD3Wd+RYaeFEE0NJKA+A==
X-CSE-MsgGUID: 8VmDmWMcROOq2iYiemPTjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63038654"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="63038654"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 02:09:51 -0800
X-CSE-ConnectionGUID: PKQbFVlRSzWvGhgZQffbeQ==
X-CSE-MsgGUID: n5z72ZWARnuJNXFaz7NP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145256230"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 02:09:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tkKXu-0000000CgaK-41Xm;
	Tue, 18 Feb 2025 12:09:42 +0200
Date: Tue, 18 Feb 2025 12:09:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mathieu.dubois-briand@bootlin.com
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
Subject: Re: [PATCH v4 02/10] mfd: Add max7360 support
Message-ID: <Z7RcZi8tIfxrG6_1@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-2-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-2-8a35c6dbb966@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 12:49:52PM +0100, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, gpio, pwm, gpo and rotary encoder submodules.

GPIO, PWM, GPO

...

> +/*
> + * Maxim MAX7360 Core Driver
> + *
> + * Copyright (C) 2024 Kamel Bouhara

Shouldn't you add yours / switch to 2025?

> + * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
> + */

...

+ bits.h

> +#include <linux/delay.h>

+ device.h // devm_kzalloc(), etc.

> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/module.h>

+ mod_devicetable.h // OF device ID table and so on...

> +#include <linux/of.h>

Is this being used? How?

> +#include <linux/regmap.h>

+ types.h // bool and so on...

...

> +struct max7360 {
> +	struct device *dev;

Same as dev in regmap?

> +	struct regmap *regmap;
> +	unsigned int requested_ports;
> +};

...

> +	}, {
> +		.range_min = 0x48,
> +		.range_max = 0x4a,

Hmm... No self-explanatory names for these addresses?

> +	},

> +static const struct regmap_config max7360_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,

> +	.max_register = 0xff,

Is it for real? I mean does the chip have 256 defined registers?

> +	.volatile_table = &max7360_volatile_table,
> +	.cache_type = REGCACHE_MAPLE,
> +};

...

> +int max7360_port_pin_request(struct device *dev, unsigned int pin, bool request)
> +{
> +	struct i2c_client *client;
> +	struct max7360 *max7360;

> +	unsigned long flags;
> +	int ret = 0;

Unneeded (see below)

> +	client = to_i2c_client(dev);
> +	max7360 = i2c_get_clientdata(client);

What's wrong with dev_get_drvdata()?
And this can be done in the block definition above.

> +	spin_lock_irqsave(&request_lock, flags);

Consider use guard()() / scoped_guard(). This will make ret and flags unneeded
besides better and robust code. You will need to include cleanup.h.

> +	if (request) {
> +		if (max7360->requested_ports & BIT(pin))
> +			ret = -EBUSY;
> +		else
> +			max7360->requested_ports |= BIT(pin);
> +	} else {
> +		max7360->requested_ports &= ~BIT(pin);
> +	}
> +	spin_unlock_irqrestore(&request_lock, flags);
> +
> +	return ret;
> +}

...

> +EXPORT_SYMBOL_GPL(max7360_port_pin_request);

No namespace?

...

> +	for (int i = 0; i < MAX7360_PORT_PWM_COUNT; i++) {

Why signed?

> +		ret = regmap_write_bits(max7360->regmap, MAX7360_REG_PWMCFG(i),
> +					MAX7360_PORT_CFG_INTERRUPT_MASK,
> +					MAX7360_PORT_CFG_INTERRUPT_MASK);
> +		if (ret) {
> +			dev_err(max7360->dev, "Failed to write max7360 port configuration");
> +			return ret;
> +		}
> +	}

...

> +	/* Read GPIO in register, to ACK any pending IRQ. */
> +	ret = regmap_read(max7360->regmap, MAX7360_REG_GPIOIN, &val);
> +	if (ret) {
> +		dev_err(max7360->dev, "Failed to read gpio values: %d\n", ret);

> +		return ret;
> +	}
> +
> +	return 0;

	return ret;

instead of 4 LoCs.

> +}

...

> +static int max7360_reset(struct max7360 *max7360)
> +{
> +	int err;

Please, be consistent with the variable naming with the same semantics.

> +	err = regmap_write(max7360->regmap, MAX7360_REG_GPIOCFG,
> +			   MAX7360_GPIO_CFG_GPIO_RST);
> +	if (err) {
> +		dev_err(max7360->dev, "Failed to reset GPIO configuration: %x\n", err);
> +		return err;
> +	}
> +
> +	err = regcache_drop_region(max7360->regmap, MAX7360_REG_GPIOCFG,
> +				   MAX7360_REG_GPIO_LAST);
> +	if (err) {
> +		dev_err(max7360->dev, "Failed to drop regmap cache: %x\n", err);
> +		return err;
> +	}
> +
> +	err = regmap_write(max7360->regmap, MAX7360_REG_SLEEP, 0);
> +	if (err) {
> +		dev_err(max7360->dev, "Failed to reset autosleep configuration: %x\n", err);
> +		return err;
> +	}
> +
> +	err = regmap_write(max7360->regmap, MAX7360_REG_DEBOUNCE, 0);
> +	if (err) {
> +		dev_err(max7360->dev, "Failed to reset GPO port count: %x\n", err);

> +		return err;
> +	}
> +
> +	return 0;

	return ret;

> +}

...

> +static int max7360_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +	struct max7360 *max7360;

> +	int err;

A bit of consistency, please.

> +}

...

> +static const struct of_device_id max7360_dt_match[] = {
> +	{ .compatible = "maxim,max7360" },
> +	{},

No comma for the terminator entry.

> +};

...

> +#ifndef __LINUX_MFD_MAX7360_H
> +#define __LINUX_MFD_MAX7360_H

> +#include <linux/bitfield.h>
> +#include <linux/device.h>

None of these are in use AFACS. Missing

bits.h
types.h

struct device;

> +#define MAX7360_MAX_KEY_ROWS	8
> +#define MAX7360_MAX_KEY_COLS	8
> +#define MAX7360_MAX_KEY_NUM	(MAX7360_MAX_KEY_ROWS * MAX7360_MAX_KEY_COLS)
> +#define MAX7360_ROW_SHIFT	3
> +
> +#define MAX7360_MAX_GPIO 8
> +#define MAX7360_MAX_GPO 6
> +#define MAX7360_PORT_PWM_COUNT	8
> +#define MAX7360_PORT_RTR_PIN	(MAX7360_PORT_PWM_COUNT - 1)
> +
> +/*
> + * MAX7360 registers
> + */
> +#define MAX7360_REG_KEYFIFO	0x00
> +#define MAX7360_REG_CONFIG	0x01
> +#define MAX7360_REG_DEBOUNCE	0x02
> +#define MAX7360_REG_INTERRUPT	0x03
> +#define MAX7360_REG_PORTS	0x04
> +#define MAX7360_REG_KEYREP	0x05
> +#define MAX7360_REG_SLEEP	0x06
> +
> +/*
> + * MAX7360 GPIO registers
> + *
> + * All these registers are reset together when writing bit 3 of
> + * MAX7360_REG_GPIOCFG.
> + */
> +#define MAX7360_REG_GPIOCFG	0x40
> +#define MAX7360_REG_GPIOCTRL	0x41
> +#define MAX7360_REG_GPIODEB	0x42
> +#define MAX7360_REG_GPIOCURR	0x43
> +#define MAX7360_REG_GPIOOUTM	0x44
> +#define MAX7360_REG_PWMCOM	0x45
> +#define MAX7360_REG_RTRCFG	0x46
> +#define MAX7360_REG_GPIOIN	0x49
> +#define MAX7360_REG_RTR_CNT	0x4A
> +#define MAX7360_REG_PWMBASE	0x50
> +#define MAX7360_REG_PWMCFGBASE	0x58
> +
> +#define MAX7360_REG_GPIO_LAST	0x5F
> +
> +#define MAX7360_REG_PWM(x)	(MAX7360_REG_PWMBASE + (x))
> +#define MAX7360_REG_PWMCFG(x)	(MAX7360_REG_PWMCFGBASE + (x))
> +
> +/*
> + * Configuration register bits
> + */
> +#define MAX7360_FIFO_EMPTY	0x3f
> +#define MAX7360_FIFO_OVERFLOW	0x7f
> +#define MAX7360_FIFO_RELEASE	BIT(6)
> +#define MAX7360_FIFO_COL	GENMASK(5, 3)
> +#define MAX7360_FIFO_ROW	GENMASK(2, 0)
> +
> +#define MAX7360_CFG_SLEEP	BIT(7)
> +#define MAX7360_CFG_INTERRUPT	BIT(5)
> +#define MAX7360_CFG_KEY_RELEASE	BIT(3)
> +#define MAX7360_CFG_WAKEUP	BIT(1)
> +#define MAX7360_CFG_TIMEOUT	BIT(0)
> +
> +#define MAX7360_DEBOUNCE	GENMASK(4, 0)
> +#define MAX7360_DEBOUNCE_MIN	9
> +#define MAX7360_DEBOUNCE_MAX	40
> +#define MAX7360_PORTS		GENMASK(8, 5)
> +
> +#define MAX7360_INTERRUPT_TIME_MASK GENMASK(4, 0)
> +#define MAX7360_INTERRUPT_FIFO_MASK GENMASK(7, 5)
> +
> +#define MAX7360_PORT_CFG_INTERRUPT_MASK BIT(7)
> +#define MAX7360_PORT_CFG_INTERRUPT_EDGES BIT(6)
> +
> +#define MAX7360_REG_GPIOCURR_FIXED 0xC0
> +
> +/*
> + * Autosleep register values (ms)

Instead of this ' (ms)' part, add a unit suffix, or where do the units apply?
To the number in the name? If so, extend comment to explain this.

> + */
> +#define MAX7360_AUTOSLEEP_8192	0x01
> +#define MAX7360_AUTOSLEEP_4096	0x02
> +#define MAX7360_AUTOSLEEP_2048	0x03
> +#define MAX7360_AUTOSLEEP_1024	0x04
> +#define MAX7360_AUTOSLEEP_512	0x05
> +#define MAX7360_AUTOSLEEP_256	0x06
> +
> +#define MAX7360_GPIO_CFG_RTR_EN		BIT(7)
> +#define MAX7360_GPIO_CFG_GPIO_EN	BIT(4)
> +#define MAX7360_GPIO_CFG_GPIO_RST	BIT(3)
> +
> +#define MAX7360_ROT_DEBOUNCE	GENMASK(3, 0)
> +#define MAX7360_ROT_DEBOUNCE_MIN 0
> +#define MAX7360_ROT_DEBOUNCE_MAX 15
> +#define MAX7360_ROT_INTCNT	GENMASK(6, 4)
> +#define MAX7360_ROT_INTCNT_DLY	BIT(7)
> +
> +#define MAX7360_INT_INTI	0
> +#define MAX7360_INT_INTK	1
> +
> +#define MAX7360_INT_GPIO   0
> +#define MAX7360_INT_KEYPAD 1
> +#define MAX7360_INT_ROTARY 2
> +
> +#define MAX7360_NR_INTERNAL_IRQS	3
> +
> +int max7360_port_pin_request(struct device *dev, unsigned int pin, bool request);
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko



