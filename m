Return-Path: <linux-pwm+bounces-5244-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F277A68C7B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 13:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770B917D5CB
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC325525C;
	Wed, 19 Mar 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT4NErm5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE08253F31;
	Wed, 19 Mar 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386309; cv=none; b=qqzMQ0BU+el72FBZsjYHYLpAeC4dn6H9qYodjsJb7DJptXMvs/MPc2RDpcpK2+4/414ARh5FKTSALCX46Dw2B9vmW7np+oKHAs2JYoOYlS+tw8KkSQ5QTuPop088bzyCf7AbUFz36XQxt2D8iYVJMNxOz5TdG7pnsNGRNhlt6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386309; c=relaxed/simple;
	bh=vbSYLU2OPNUESfs4+HDv3w2ZZenuKOgY4pOqq8Z47pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZxYPU8+QQRhFKQJ3WLch5hLVo8fTdf9xtCjCTTzIeSyFKlIet0ncAGK5+JUugUO2QX+GG3qKbM+IG5SUNYVhQj1iJ9k8rN3BdQqMBw1TED/411CBFBHE1mxEIPEuolbd/KLTylnZvqeD6ZQBLSyi0v3Kk8+H/+U6yTAj7yOPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT4NErm5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742386308; x=1773922308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vbSYLU2OPNUESfs4+HDv3w2ZZenuKOgY4pOqq8Z47pg=;
  b=fT4NErm5d1GWTa6SnzTZKuPYzfN2+noOMVMrh3rZrQOD/y4obQ7x4D6F
   wlH1kkembdNG+LWr3wu0jLwPHgwsGYiowmprbWjfExRtDp/eHSMwfJAwd
   hqbEc/kT1kAvFrv/rWtMoq3eK7wZwVsLtoGOFFQzLjuikZXfxf8Hd76pK
   ha6tz/SC2xtyMGhsUzAEM4KYPW5gNDF5A1a5CkUV9jaTiEjwzfya5ZGji
   GQ1fn7rAmnWo8Oax64vJL8MD1x2kNdwEtdQj5+bNmtcH92GJCeW3EAdUR
   ErcSlKPASVuFJCODNtxmNDlpefApjU4Pyl63iY5cBFr+8dZn190JQWvhP
   w==;
X-CSE-ConnectionGUID: EMLQzgf0SmCAJaWFoZOO6A==
X-CSE-MsgGUID: 1Xgzi0N8TCW4kzjCKqWpkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53785951"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53785951"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:11:46 -0700
X-CSE-ConnectionGUID: sT/baEY5Q2CGIRBxKYWW8w==
X-CSE-MsgGUID: hlINGrzuQHWMW3AqnjQAtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123087585"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:11:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tusGo-00000003uXG-0z5x;
	Wed, 19 Mar 2025 14:11:38 +0200
Date: Wed, 19 Mar 2025 14:11:37 +0200
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
Subject: Re: [PATCH v5 10/11] input: misc: Add support for MAX7360 rotary
Message-ID: <Z9q0eaxhecN0kGKI@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:26PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 rotary encoder controller,
> supporting a single rotary switch.

...

> +	help
> +	  If you say yes here you get support for the rotary encoder on the
> +	  Maxim MAX7360 I/O Expander.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called max7360_rotary.

Seems all your patches have unaligned line widths in the help texts.

...

+ bitfield.h
+ device/devres.h
+ dev_printk.h

> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/property.h>

> +#include <linux/of.h>

Why?

> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>

> +#include <linux/slab.h>

Not needed.

+ types.h

...

> +static irqreturn_t max7360_rotary_irq(int irq, void *data)
> +{
> +	struct max7360_rotary *max7360_rotary = data;
> +	int val;
> +	int ret;
> +
> +	ret = regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
> +	if (ret < 0) {
> +		dev_err(&max7360_rotary->input->dev,
> +			"Failed to read rotary counter\n");
> +		return IRQ_NONE;
> +	}
> +
> +	if (val == 0) {
> +		dev_dbg(&max7360_rotary->input->dev,
> +			"Got a spurious interrupt\n");
> +
> +		return IRQ_NONE;
> +	}
> +
> +	input_report_rel(max7360_rotary->input, max7360_rotary->axis,
> +			 (int8_t)val);

This is strange:
1) why casting to begin with?
2) why to C type and not kernel (s8) type?

> +	input_sync(max7360_rotary->input);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int max7360_rotary_hw_init(struct max7360_rotary *max7360_rotary)
> +{
> +	int val;
> +	int ret;
> +
> +	val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
> +		FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;
> +	ret = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
> +	if (ret) {
> +		dev_err(&max7360_rotary->input->dev,
> +			"Failed to set max7360 rotary encoder configuration\n");

> +		return ret;
> +	}
> +
> +	return 0;

Just

	return ret;

?

> +}

...

> +static int max7360_rotary_probe(struct platform_device *pdev)
> +{
> +	struct max7360_rotary *max7360_rotary;

	struct device *dev = &pdev->dev;

> +	struct input_dev *input;
> +	int irq;
> +	int ret;

> +	if (!pdev->dev.parent)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");

Just check for regmap.

> +	irq = platform_get_irq_byname(to_platform_device(pdev->dev.parent),
> +				      "inti");

One line (and instead of that dance with container_of(), just use
fwnode_irq_get_byname().

> +	if (irq < 0)
> +		return irq;
> +
> +	max7360_rotary = devm_kzalloc(&pdev->dev, sizeof(*max7360_rotary),
> +				      GFP_KERNEL);

One line.

> +	if (!max7360_rotary)
> +		return -ENOMEM;
> +
> +	max7360_rotary->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_rotary->regmap)

> +		dev_err_probe(&pdev->dev, -ENODEV,
> +			      "Could not get parent regmap\n");

One line.

> +	device_property_read_u32(pdev->dev.parent, "linux,axis",
> +				 &max7360_rotary->axis);
> +	device_property_read_u32(pdev->dev.parent, "rotary-debounce-delay-ms",
> +				 &max7360_rotary->debounce_ms);

No, instead of parent, make sure that fwnode is propagated to the children (and
tadaam, it's done in MFD already).

> +	if (max7360_rotary->debounce_ms > MAX7360_ROT_DEBOUNCE_MAX)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "Invalid debounce timing: %u\n",
> +				     max7360_rotary->debounce_ms);
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	max7360_rotary->input = input;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +	input->dev.parent = &pdev->dev;
> +
> +	input_set_capability(input, EV_REL, max7360_rotary->axis);
> +	input_set_drvdata(input, max7360_rotary);
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					max7360_rotary_irq,

> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,

What's wrong with the firmware description of the interrupt?

> +					"max7360-rotary", max7360_rotary);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register interrupt\n");
> +
> +	ret = input_register_device(input);
> +	if (ret)

> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Could not register input device\n");

One line.

> +	platform_set_drvdata(pdev, max7360_rotary);

Is it used?

> +	device_init_wakeup(&pdev->dev, true);
> +	ret = dev_pm_set_wake_irq(&pdev->dev, irq);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n", ret);
> +
> +	ret = max7360_rotary_hw_init(max7360_rotary);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to initialize max7360 rotary\n");

In the other driver the HW initialisation and wake setup were swapped,
can you choose one way? Otherwise both cases need a comment to explain
the order of calls.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



