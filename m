Return-Path: <linux-pwm+bounces-5806-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76795AA7005
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3214466331
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8723507E;
	Fri,  2 May 2025 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MF3u5I+b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E222B5B5;
	Fri,  2 May 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182805; cv=none; b=oJf9lHO+omRJl4ta+A+W1jCMstR9ZVPmrKurmP2IDj5aWoX2+O1QnUraj983PXyUMTFgyRr80ZyWjTLB8e0cuBLdGq/It5ftj+OSYN/vs4O1utEcoF0mT6V0pCjgJrgSaLXHfAuhAPASMNylBvwyNMzKB7PTPumBpnyxLsH7Oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182805; c=relaxed/simple;
	bh=+uWLx+L+tZ7/VsicxvUcq5ge94vHmBIsuYivGRIzZEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox2tI7MDdBxX5lYY3SFgVnyo+K+ZarUf5mbqfqhDt4ISvb1gHbSsliqK6zpiiPcE640WXUPKGh5y59BnFK+JZ62c99ASQEjvRO6/YG+N4TTPqaH8mu9VuaFtY0j8kerZiLeyEj25fR71KzxQCC+I8MkkSHr1JRqxkWItdGxd888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MF3u5I+b; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746182804; x=1777718804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uWLx+L+tZ7/VsicxvUcq5ge94vHmBIsuYivGRIzZEg=;
  b=MF3u5I+bW86jYt7Nh8ZKj/OMAiNXZigccnGMYKOiskEzxAdH/2XkkvGR
   tUEu33Mjj6l6U1922VWRMNX+bBeODWfVjI0bJjyGQ1ZCUAp1boM4vicv/
   rmOlBRVfZwsRy3XLILYL/s6b8IOEnEwVChi83J+6cF2uKjAyPrdJntkea
   H0PeIg9gxmA3lPlWLepzrbKTq3oKTtgGM0kbzQh9QZ9rPINtJ2xJYVwLf
   eZaSWKLvsiD8c9rsG3vn1EwZbEZKCRYFzBCxGKOZzu2SRlYV30dx5foQ6
   p/XGgv1Gp7JAHiqR/TKQ9D6PvCRtjOQRfoZu6vjwfI4HOkyEfw6hd5IZp
   g==;
X-CSE-ConnectionGUID: UQueTEEJSv24T9dSpAc7lA==
X-CSE-MsgGUID: 7QOYQPMbSgiUXCxDoVKsUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="70365611"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="70365611"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:46:43 -0700
X-CSE-ConnectionGUID: cEGxtrhmTRe0iAKHb4/5aQ==
X-CSE-MsgGUID: 5C6HuZYeS4WDy06Q9OKjxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="135140047"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:46:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAnud-00000002ASM-1J0X;
	Fri, 02 May 2025 13:46:35 +0300
Date: Fri, 2 May 2025 13:46:35 +0300
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
Subject: Re: [PATCH v7 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <aBSii0rHox72GM5Y@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-9-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-9-4e0608d0a7ff@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 01:57:27PM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 keypad controller, providing
> support for up to 64 keys, with a matrix of 8 columns and 8 rows.

...

> +static irqreturn_t max7360_keypad_irq(int irq, void *data)
> +{
> +	struct max7360_keypad *max7360_keypad = data;
> +	struct device *dev = max7360_keypad->input->dev.parent;
> +	unsigned int val;
> +	unsigned int row, col;
> +	unsigned int release;
> +	unsigned int code;
> +	int error;
> +
> +	do {
> +		error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
> +		if (error) {
> +			dev_err(dev, "Failed to read max7360 FIFO");
> +			return IRQ_NONE;
> +		}
> +
> +		/* FIFO overflow: ignore it and get next event. */
> +		if (val == MAX7360_FIFO_OVERFLOW)
> +			dev_warn(dev, "max7360 FIFO overflow");

If many events are missing this will flood the logs, perhaps _ratelimited() ?

> +	} while (val == MAX7360_FIFO_OVERFLOW);

regmap_read_poll_timeout() ?

> +	if (val == MAX7360_FIFO_EMPTY) {
> +		dev_dbg(dev, "Got a spurious interrupt");
> +
> +		return IRQ_NONE;
> +	}
> +
> +	row = FIELD_GET(MAX7360_FIFO_ROW, val);
> +	col = FIELD_GET(MAX7360_FIFO_COL, val);
> +	release = val & MAX7360_FIFO_RELEASE;
> +
> +	code = MATRIX_SCAN_CODE(row, col, MAX7360_ROW_SHIFT);
> +
> +	dev_dbg(dev, "key[%d:%d] %s\n", row, col, release ? "release" : "press");
> +
> +	input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
> +	input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code], !release);
> +	input_sync(max7360_keypad->input);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int max7360_keypad_open(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	struct device *dev = max7360_keypad->input->dev.parent;
> +	int error;
> +
> +	/* Somebody is using the device: get out of sleep. */
> +	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
> +				  MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
> +	if (error) {
> +		dev_err(dev, "Failed to write max7360 configuration: %d\n", error);

> +		return error;
> +	}
> +
> +	return 0;

Just

	return error;

should work instead of those 4 lines.

> +}

...

> +	size = device_property_count_u32(dev, propname);
> +	if (size <= 0) {
> +		dev_err(dev, "missing or malformed property %s: %d\n", propname, size);
> +		return size < 0 ? size : -EINVAL;
> +	}

Wouldn't be better to split these two?

...

> +	error = matrix_keypad_build_keymap(&keymap_data, NULL,
> +					   max7360_keypad->rows, max7360_keypad->cols,
> +					   max7360_keypad->keycodes, max7360_keypad->input);
> +
> +	return error;

	return matrix_...(...);

...

> +	device_init_wakeup(dev, true);
> +	error = dev_pm_set_wake_irq(dev, irq);
> +	if (error)
> +		dev_warn(dev, "Failed to set up wakeup irq: %d\n", error);

...

> +static void max7360_keypad_remove(struct platform_device *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);

Shouldn't

	device_init_wakeup(false);

be called here?

-- 
With Best Regards,
Andy Shevchenko



