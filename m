Return-Path: <linux-pwm+bounces-5243-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F4A68C4C
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD77189BBB2
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E318A255229;
	Wed, 19 Mar 2025 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzLoQbXx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9336208993;
	Wed, 19 Mar 2025 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385783; cv=none; b=lis1ur1NRydNgAeEjuwApdXAqMSf25zOkkUwwbi3WAQCfRJKLeyDIIjUgRNSKR+e+K+kJCy1JNNrD1qSsgBA93eAuMfBJkp8n6JVTJBYzqx0mvpoy9aygWzrsGCvYgJvq6EwGJiM4ztRJupzFb8zWJSaQv+089gXEC5q/01WkNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385783; c=relaxed/simple;
	bh=Lyg+JvU44nV7dr6VtqgEkvsFIxAtalvdEDoWyTj0yGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMo6Ro+opt7taWZuYNvhSXw8WYgTHZwSyOf37twCcOEuT9kofNMVAwFnmCCb+K6wpufJ43Cl8lzFMCGkCuZtDFBCUCet5ejgbLtVQzOFuGYABCCi+twbD6jZjOanj8Y3LBYhS/wmoxK890KgF8BEWIVJcSDaLyzyALDMisLcXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzLoQbXx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742385782; x=1773921782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lyg+JvU44nV7dr6VtqgEkvsFIxAtalvdEDoWyTj0yGo=;
  b=YzLoQbXx0Ohl+ZayB0Wg9QTAU9VRWZq81oW32aSEKdDQYdz2uda127J4
   3JExdaHW4ZSO4b1GVOv+koz7Q1mYvV3j0es3R8NXoB2RjpxjGsu2edGz2
   KvAudTdXSjkkDeOomAggMYrL5/7G5BgH35fJ1I9EdIBEppuWmfpJ8Ct3O
   ICTjRmPQk4oFgLaIIyjmF3JceVyiEonfUfnM+PxytU4EsUtr6zrB7ykrU
   0XvtpUlkjXPdKt9TnETKtt4h/qlQyI37fRMIftLtD4HfXyUr6Ao9Eo2y9
   L9SopsUjNzBEI8a7fyMEF/v0UW/diLXRrzb/2KkkYloqOhAb3Rfpto03u
   Q==;
X-CSE-ConnectionGUID: rQG7zEnaTYKWqtJBqOTCOA==
X-CSE-MsgGUID: iD21vHuYT3GwZgB2/m1Zsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43671919"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43671919"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:03:02 -0700
X-CSE-ConnectionGUID: E3XqgjQmQjSbMfpxp+ueSQ==
X-CSE-MsgGUID: COxBXaxpS8GUACUBOKEoyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122767054"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:02:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tus8L-00000003uR3-3oGn;
	Wed, 19 Mar 2025 14:02:53 +0200
Date: Wed, 19 Mar 2025 14:02:53 +0200
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
Subject: Re: [PATCH v5 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <Z9qybcY7VyQBvZMv@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-9-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-9-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:25PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 keypad controller, providing
> support for up to 64 keys, with a matrix of 8 columns and 8 rows.

...

> +	help
> +	  If you say yes here you get support for the keypad controller on the
> +	  Maxim MAX7360 I/O Expander.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called max7360_keypad.

One paragraph is wrapped way too late or too early, can you make them approx.
the same in terms of a line width?

...

+ bitfield.h
+ bitops.h
+ dev_printk.h
+ device/devres.h
+ err.h

> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max7360.h>

+ mod_devicetable.h

> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>

> +#include <linux/slab.h>

IS it used? I think it's device/devres.h that covers it.


...

> +static int max7360_keypad_open(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	int ret;
> +
> +	/*
> +	 * Somebody is using the device: get out of sleep.
> +	 */
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
> +				MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
> +	if (ret) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 configuration\n");

> +		return ret;
> +	}
> +
> +	return 0;

Just

	return ret;

?

> +}

...

> +	/*
> +	 * Nobody is using the device anymore: go to sleep.
> +	 */

The comment message can take only a line.

> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG, MAX7360_CFG_SLEEP, 0);
> +	if (ret)
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 configuration\n");
> +}

...

> +static int max7360_keypad_parse_dt(struct platform_device *pdev,

s/dt/fw

> +				   struct max7360_keypad *max7360_keypad,
> +				   bool *autorepeat)
> +{

	struct device *dev = &pdev>dev;

but why not supply struct device to begin with? How is the platform part used here?

> +	int ret;
> +
> +	ret = matrix_keypad_parse_properties(pdev->dev.parent, &max7360_keypad->rows,
> +					     &max7360_keypad->cols);
> +	if (ret)
> +		return ret;
> +
> +	if (!max7360_keypad->rows || !max7360_keypad->cols ||
> +	    max7360_keypad->rows > MAX7360_MAX_KEY_ROWS ||
> +	    max7360_keypad->cols > MAX7360_MAX_KEY_COLS) {

See also below comment.

> +		dev_err(&pdev->dev,
> +			"Invalid number of columns or rows (%ux%u)\n",
> +			max7360_keypad->cols, max7360_keypad->rows);
> +		return -EINVAL;
> +	}
> +
> +	*autorepeat = device_property_read_bool(pdev->dev.parent, "autorepeat");
> +
> +	max7360_keypad->debounce_ms = MAX7360_DEBOUNCE_MIN;
> +	ret = device_property_read_u32(pdev->dev.parent, "keypad-debounce-delay-ms",
> +				       &max7360_keypad->debounce_ms);
> +	if (ret == -EINVAL) {
> +		dev_info(&pdev->dev, "Using default keypad-debounce-delay-ms: %u\n",
> +			 max7360_keypad->debounce_ms);
> +	} else if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Failed to read keypad-debounce-delay-ms property\n");
> +		return ret;

> +	} else if (max7360_keypad->debounce_ms < MAX7360_DEBOUNCE_MIN ||

Redundant 'else'.

> +		   max7360_keypad->debounce_ms > MAX7360_DEBOUNCE_MAX) {

Maybe in_range()? But up to you, it takes start:len and not start:end.

> +		dev_err(&pdev->dev,
> +			"Invalid keypad-debounce-delay-ms: %u, should be between %u and %u.\n",
> +			max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN, MAX7360_DEBOUNCE_MAX);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...

> +static int max7360_keypad_probe(struct platform_device *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad;

	struct device *dev = &pdev>dev;

> +	struct input_dev *input;
> +	bool autorepeat;
> +	int ret;
> +	int irq;

> +	if (!pdev->dev.parent)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");

Just do like in the rest, i.e. local variable for regmap and its validness will
be the one that indicates the wrong enumeration path.

> +	irq = platform_get_irq_byname(to_platform_device(pdev->dev.parent), "intk");
> +	if (irq < 0)
> +		return irq;
> +
> +	max7360_keypad = devm_kzalloc(&pdev->dev, sizeof(*max7360_keypad), GFP_KERNEL);
> +	if (!max7360_keypad)
> +		return -ENOMEM;
> +
> +	max7360_keypad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_keypad->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Could not get parent regmap\n");
> +
> +	ret = max7360_keypad_parse_dt(pdev, max7360_keypad, &autorepeat);
> +	if (ret)
> +		return ret;
> +
> +	input = devm_input_allocate_device(pdev->dev.parent);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	max7360_keypad->input = input;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +	input->open = max7360_keypad_open;
> +	input->close = max7360_keypad_close;
> +
> +	ret = matrix_keypad_build_keymap(NULL, NULL, MAX7360_MAX_KEY_ROWS, MAX7360_MAX_KEY_COLS,
> +					 max7360_keypad->keycodes, input);
> +	if (ret)

> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to build keymap\n");

One line.

> +
> +	input_set_capability(input, EV_MSC, MSC_SCAN);
> +	if (autorepeat)
> +		__set_bit(EV_REP, input->evbit);
> +
> +	input_set_drvdata(input, max7360_keypad);
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, max7360_keypad_irq,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,

What's wrong with the interrupt flags provided by firmware description?

> +					"max7360-keypad", max7360_keypad);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register interrupt\n");
> +
> +	ret = input_register_device(input);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Could not register input device\n");

> +	platform_set_drvdata(pdev, max7360_keypad);

Is it used?

> +	ret = max7360_keypad_hw_init(max7360_keypad);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to initialize max7360 keypad\n");
> +
> +	device_init_wakeup(&pdev->dev, true);
> +	ret = dev_pm_set_wake_irq(&pdev->dev, irq);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n", ret);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



