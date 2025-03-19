Return-Path: <linux-pwm+bounces-5241-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD77A68BE7
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4DE3A226F
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF0254871;
	Wed, 19 Mar 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJ48NFhf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0D17A311;
	Wed, 19 Mar 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384137; cv=none; b=t7zePYAybvDZ9J3qIIzQKSmaVK7m6PVk6KQstajZXk4Ix/WfBqTYjQE5av4hjY8tTHHytoqSM5hCCo8Z9Dlli7zLjw3z+cuvaZ7nSxyC4Hust2iV4FdkzZXPpDCttMxaPBGRSqO9HcjmHG0etn1Z0Ayt3PgN+HFJbq8nAT4L774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384137; c=relaxed/simple;
	bh=t9WbloeqpX2M7p+2+znpSFKG3d7NaMQ0lIBQX4TJ7WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp7hCtry3d9W3o9+PkS/3u4WNsB1Gq8S505bwVePq6u5o5jm9bfuivqOfmK2bELazCUTGL0jWPGy/cR8B1cxjHb0qjfc3EEe8iR0EnTWUoHgDmaX2Od+XhuLgomITaMg5UdQDbfjFcJRS9QqNy+FSZAKtpbPngtMjxAKbB1RyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJ48NFhf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742384136; x=1773920136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t9WbloeqpX2M7p+2+znpSFKG3d7NaMQ0lIBQX4TJ7WQ=;
  b=UJ48NFhfl7kMAQrlVh7rmOP3J1+3XcP6BnjtmQ1yTUAPjj8yZiy/XkvK
   q7NsWZUN5YWH4RrVrB/4bR7GOJsQPxGCOiNmInjV8VwmgT2V9fasINEZd
   kyV23Fvc8qqZA0J0bXvgkeAqty7gTHcYBJbpJLexkvD4pqSXm4cEH+DZg
   aYSiIOzq5CjLllwCw0n9SM5bpPgU55a3Pp8BENEAe7oS2XarMygiNjUB6
   OfNEjYpQq25lbTJVgmNDo8EMbhpR/0lXAr1cNUkOeA3s42OcuQrJNZ8G3
   bGMuiNWspH4YdYCE29dN5RnoOvq+9xRESRDAJbuB+CdihdANZ6HRtSXk2
   Q==;
X-CSE-ConnectionGUID: vG42kR4QT/KL0CSNLFC+4w==
X-CSE-MsgGUID: t0sGjSY8Tketn53oD3YG8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53782909"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53782909"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:35:28 -0700
X-CSE-ConnectionGUID: 4hM+CznuQbWgLF+sorQSZA==
X-CSE-MsgGUID: ezVEggxZQRqc4onjQbUEgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127656585"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:35:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1turhf-00000003u7j-2ByO;
	Wed, 19 Mar 2025 13:35:19 +0200
Date: Wed, 19 Mar 2025 13:35:19 +0200
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
Subject: Re: [PATCH v5 03/11] pinctrl: Add MAX7360 pinctrl driver
Message-ID: <Z9qr92KyjFyYwMq5@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-3-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318-mdb-max7360-support-v5-3-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:19PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
> can be used either for GPIO, PWM or rotary encoder functionalities.

...

> +	help
> +	  Say Y here to enable Pin control support for Maxim MAX7360 keypad

s/Pin/pin/

> +	  controller.
> +	  This keypad controller has 8 GPIO pins that work as GPIO as well as

"...that may work as GPIO, or PWM, or..."

> +	  PWM or rotary encoder alternate modes.

...

+ array_size.h
+ dev_printk.h
+ device/devres.h // currently only in Linux Next
+ err.h

> +#include <linux/init.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinmux.h>

We usually move this group of inclusions...

> +#include <linux/regmap.h>
> +#include <linux/slab.h>

...to somewhere here.

> +#include "core.h"
> +#include "pinmux.h"

...

> +static const struct pingroup max7360_groups[] = {
> +	PINCTRL_PINGROUP("PORT0", port0_pins, ARRAY_SIZE(port0_pins)),
> +	PINCTRL_PINGROUP("PORT1", port1_pins, ARRAY_SIZE(port1_pins)),
> +	PINCTRL_PINGROUP("PORT2", port2_pins, ARRAY_SIZE(port2_pins)),
> +	PINCTRL_PINGROUP("PORT3", port3_pins, ARRAY_SIZE(port3_pins)),
> +	PINCTRL_PINGROUP("PORT4", port4_pins, ARRAY_SIZE(port4_pins)),
> +	PINCTRL_PINGROUP("PORT5", port5_pins, ARRAY_SIZE(port5_pins)),
> +	PINCTRL_PINGROUP("PORT6", port6_pins, ARRAY_SIZE(port6_pins)),
> +	PINCTRL_PINGROUP("PORT7", port7_pins, ARRAY_SIZE(port7_pins)),
> +	PINCTRL_PINGROUP("ROTARY", rotary_pins, ARRAY_SIZE(rotary_pins))

Leave trailing comma. Helps in the future in case of expansion.

> +};

...

> +static const char * const simple_groups[] = {"PORT0", "PORT1", "PORT2", "PORT3",
> +					     "PORT4", "PORT5", "PORT6", "PORT7"};

It's better to read when split as

static const char * const simple_groups[] = {
	"PORT0", "PORT1", "PORT2", "PORT3",
	"PORT4", "PORT5", "PORT6", "PORT7",
};

(also note the trailing comma).

…

> +static const char * const rotary_groups[] = {"ROTARY"};

Add spaces inside {}.

...

> +#define MAX7360_PINCTRL_FN_ROTARY	2
> +static const struct pinfunction max7360_functions[] = {
> +	PINCTRL_PINFUNCTION("gpio", simple_groups, ARRAY_SIZE(simple_groups)),
> +	PINCTRL_PINFUNCTION("pwm", simple_groups, ARRAY_SIZE(simple_groups)),
> +	[MAX7360_PINCTRL_FN_ROTARY] = PINCTRL_PINFUNCTION("rotary", rotary_groups,
> +							  ARRAY_SIZE(rotary_groups)),

Please make them all look the same, if indexed, than add indices to all.

> +};

...

> +static int max7360_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
> +			   unsigned int group)
> +{
> +	struct regmap *regmap;

> +	int ret = 0;

Variable is not needed, just return directly.

> +	int val;
> +
> +	/*
> +	 * GPIO and PWM functions are the same: we only need to handle the
> +	 * rotary encoder function, on pins 6 and 7.
> +	 */
> +	if (max7360_groups[group].pins[0] >= 6) {
> +		if (selector == MAX7360_PINCTRL_FN_ROTARY)
> +			val = MAX7360_GPIO_CFG_RTR_EN;
> +		else
> +			val = 0;
> +
> +		regmap = dev_get_regmap(pctldev->dev, NULL);
> +		ret = regmap_write_bits(regmap, MAX7360_REG_GPIOCFG, MAX7360_GPIO_CFG_RTR_EN, val);
> +	}
> +
> +	return ret;
> +}

...

> +static int max7360_pinctrl_probe(struct platform_device *pdev)
> +{

With

	struct device *dev = &pdev->dev;

the below will look better.

> +	struct regmap *regmap;
> +	struct pinctrl_desc *pd;
> +	struct max7360_pinctrl *chip;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		dev_err_probe(&pdev->dev, -ENODEV, "Could not get parent regmap\n");

Make it first check, in such a case you don't even need to allocate memory for
peanuts.

> +	pd = &chip->pinctrl_desc;
> +
> +	pd->pctlops = &max7360_pinctrl_ops;
> +	pd->pmxops = &max7360_pmxops;
> +	pd->name = dev_name(&pdev->dev);
> +	pd->pins = max7360_pins;
> +	pd->npins = MAX7360_MAX_GPIO;
> +	pd->owner = THIS_MODULE;
> +
> +	chip->pctldev = devm_pinctrl_register(pdev->dev.parent, pd, chip);
> +	if (IS_ERR(chip->pctldev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->pctldev),
> +			"can't register controller\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



