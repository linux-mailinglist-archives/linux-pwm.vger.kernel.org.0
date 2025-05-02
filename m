Return-Path: <linux-pwm+bounces-5807-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D941AA7018
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DF61BA0F68
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73F23ED56;
	Fri,  2 May 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMVcObY1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C622FACE;
	Fri,  2 May 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183189; cv=none; b=a80naCnuuT+uTLPtYU3JHLyu5hxp8l0Tg4ss2fAIDpIMAn3Hb75OpRUa0u+9tIOhVpjaSqegYqaBDCMOgm7GWV4OcWMbaw4mLJiX/JQw5SOH2wbS2kXbpG7frQVW9J7MY3xCcpn+bgInlfRwNeGHntEzhBPdsrI84UYO9C9LLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183189; c=relaxed/simple;
	bh=Z2s8QaH0F2vgbOHJjHMKjTTqJC0m5rpm77idrTTwn+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3um+veR1MMknN1vBk2x75tLquFrVvrqytDA2mUyGK2xVlQU9jmWICtYnPTUTr+mUCG96PNGoDTlCe8Zlhj3Mo2WBCuRr1j+BbNM0OI3l/9WAoir38QNI9KZkoMjIo9iSLfpN4oX/pYq0SU7Z/E4oim7cVYk6QklfYuOKLOUZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMVcObY1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746183188; x=1777719188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2s8QaH0F2vgbOHJjHMKjTTqJC0m5rpm77idrTTwn+g=;
  b=AMVcObY1HY1Za7YWQIZ0aGrFX/yz40YheCRuXqhkqcAT0/NLW59o5sq5
   rN/bj38weCHCx/X+ST9uDrRTQ7b5MbWnz3zNxOvImCKu3SuKOlct+Scm9
   XJHkhkizkEZTNmXDycAxeTfpAVQDfHvMf3fIa6sDLHNuWD0wQ+OvsJGx/
   h3+mmaQ6uAMV+NOmWEmTIf9HkmvvlZ/R3NI/nCJ/O9rPcVMaw+1I32iZ2
   mge51vzStwaKa3qEhQFoMWGzBeB0fqeYEJ+3ZSYayCIieO74cuv7W/nBS
   OH4XfP/BovCDpmvqb0iv2n7kPWOIJTDhRg36D51QfhsNx13g6NgIwV5Xk
   Q==;
X-CSE-ConnectionGUID: qDiCO7M+R6SQpU9TMU65Vg==
X-CSE-MsgGUID: HYXT+nqSSbqJulH/pLaSfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="65394013"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="65394013"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:53:07 -0700
X-CSE-ConnectionGUID: ODbTATNuQgac6ODPon0HoA==
X-CSE-MsgGUID: N87L86c3RACx04gImxSM/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="157850440"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:53:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAo0o-00000002AYP-35Q0;
	Fri, 02 May 2025 13:52:58 +0300
Date: Fri, 2 May 2025 13:52:58 +0300
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
Subject: Re: [PATCH v7 10/11] input: misc: Add support for MAX7360 rotary
Message-ID: <aBSkCsw3GJ6RHeJV@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-10-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-10-4e0608d0a7ff@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 01:57:28PM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 rotary encoder controller,
> supporting a single rotary switch.

...

> +struct max7360_rotary {
> +	struct input_dev *input;
> +	unsigned int debounce_ms;
> +	struct regmap *regmap;
> +
> +	u32 steps;
> +	u32 axis;
> +	bool relative_axis;
> +	bool rollover;
> +
> +	unsigned int pos;
> +};

I believe `pahole` can recommend better layout (look for the better position
of debounce_ms).

...

> +static void max7360_rotaty_report_event(struct max7360_rotary *max7360_rotary, int steps)
> +{
> +	if (max7360_rotary->relative_axis) {
> +		input_report_rel(max7360_rotary->input, max7360_rotary->axis, steps);
> +	} else {
> +		unsigned int pos = max7360_rotary->pos;
> +
> +		if (steps < 0) {
> +			/* turning counter-clockwise */
> +			if (max7360_rotary->rollover)
> +				pos += max7360_rotary->steps + steps;
> +			else

> +				pos = max(0, (int)pos + steps);

Please, no castings for min()/max()/clamp(). It diminishes the use of those
macros.

> +		} else {
> +			/* turning clockwise */
> +			if (max7360_rotary->rollover)
> +				pos += steps;
> +			else
> +				pos = min(max7360_rotary->steps, pos + steps);
> +		}
> +
> +		if (max7360_rotary->rollover)
> +			pos %= max7360_rotary->steps;
> +
> +		max7360_rotary->pos = pos;
> +		input_report_abs(max7360_rotary->input, max7360_rotary->axis, max7360_rotary->pos);
> +	}
> +
> +	input_sync(max7360_rotary->input);
> +}

...

> +static irqreturn_t max7360_rotary_irq(int irq, void *data)
> +{
> +	struct max7360_rotary *max7360_rotary = data;
> +	struct device *dev = max7360_rotary->input->dev.parent;
> +	unsigned int val;
> +	int error;
> +
> +	error = regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
> +	if (error < 0) {
> +		dev_err(dev, "Failed to read rotary counter\n");
> +		return IRQ_NONE;
> +	}
> +
> +	if (val == 0) {

> +		dev_dbg(dev, "Got a spurious interrupt\n");

This contradicts with the IRQF_SHARED. Drop one of them.

> +		return IRQ_NONE;
> +	}
> +
> +	max7360_rotaty_report_event(max7360_rotary, sign_extend32(val, 7));
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int max7360_rotary_hw_init(struct max7360_rotary *max7360_rotary)
> +{
> +	struct device *dev = max7360_rotary->input->dev.parent;
> +	int val;
> +	int error;
> +
> +	val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
> +		FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;

Indentation is incorrect.

> +	error = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
> +	if (error)
> +		dev_err(dev, "Failed to set max7360 rotary encoder configuration\n");
> +
> +	return error;
> +}

...

> +static int max7360_rotary_probe(struct platform_device *pdev)
> +{
> +	struct max7360_rotary *max7360_rotary;
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input;
> +	struct regmap *regmap;
> +	int irq;
> +	int error;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");

Missing return. Copy'n'paste error over all drivers?

> +	irq = fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> +
> +	max7360_rotary = devm_kzalloc(dev, sizeof(*max7360_rotary), GFP_KERNEL);
> +	if (!max7360_rotary)
> +		return -ENOMEM;
> +
> +	max7360_rotary->regmap = regmap;
> +
> +	device_property_read_u32(dev->parent, "linux,axis", &max7360_rotary->axis);
> +	max7360_rotary->rollover = device_property_read_bool(dev->parent,
> +							     "rotary-encoder,rollover");
> +	max7360_rotary->relative_axis =
> +		device_property_read_bool(dev->parent, "rotary-encoder,relative-axis");
> +
> +	error = device_property_read_u32(dev->parent, "rotary-encoder,steps",
> +					 &max7360_rotary->steps);
> +	if (error)
> +		max7360_rotary->steps = MAX7360_ROTARY_DEFAULT_STEPS;
> +
> +	device_property_read_u32(dev->parent, "rotary-debounce-delay-ms",
> +				 &max7360_rotary->debounce_ms);
> +	if (max7360_rotary->debounce_ms > MAX7360_ROT_DEBOUNCE_MAX)
> +		return dev_err_probe(dev, -EINVAL, "Invalid debounce timing: %u\n",
> +				     max7360_rotary->debounce_ms);
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	max7360_rotary->input = input;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +
> +	if (max7360_rotary->relative_axis)
> +		input_set_capability(input, EV_REL, max7360_rotary->axis);
> +	else
> +		input_set_abs_params(input, max7360_rotary->axis, 0, max7360_rotary->steps, 0, 1);
> +
> +	error = devm_request_threaded_irq(dev, irq, NULL, max7360_rotary_irq,
> +					  IRQF_ONESHOT | IRQF_SHARED,
> +					  "max7360-rotary", max7360_rotary);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed to register interrupt\n");
> +
> +	error = input_register_device(input);
> +	if (error)
> +		return dev_err_probe(dev, error, "Could not register input device\n");
> +
> +	error = max7360_rotary_hw_init(max7360_rotary);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed to initialize max7360 rotary\n");
> +
> +	device_init_wakeup(dev, true);
> +	error = dev_pm_set_wake_irq(dev, irq);
> +	if (error)
> +		dev_warn(dev, "Failed to set up wakeup irq: %d\n", error);
> +
> +	return 0;
> +}
> +
> +static void max7360_rotary_remove(struct platform_device *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);

Shouldn't be here

	device_init_wakeup(dev, false);

?

> +}

-- 
With Best Regards,
Andy Shevchenko



