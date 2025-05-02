Return-Path: <linux-pwm+bounces-5802-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC56DAA6F27
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898DA1BC46A7
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DB0231849;
	Fri,  2 May 2025 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0AIXthV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60177227E96;
	Fri,  2 May 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180918; cv=none; b=n3WNhPg+3/NlkQRqdoLC14624ArWerl+0fSk4mTKH51icYW4EHVjLv9dJknRyO5FjEG8tbFPozCMy5CL2Gq1R1mXSY6HdZhsrVoMCbNbBQcU7Hb49fg+W90+h/krcMylvCn9aZ2E7LGdK30RgIMzzKTtEX370knTr+6BLVgOttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180918; c=relaxed/simple;
	bh=fML3RdU0/3C8b9eeo8fTm+7OW1jR7eALOGHJP2ObctU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYXbLGdGYn9P13ULjrEasLwL+jUIR1sMGb/qU0FCyn5Xq7Tx+pL0mWsgCb5vBdTFO86hg3tfm2oxl+WdY9S5Ttqjq6WtVxYnEGjqBS5nJoC69/uegb5Q99tnNNPw6/kBEqlvAn64wymu2vZ3tTVj5tvHqJb2/kKiG4mgo3CDA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0AIXthV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746180916; x=1777716916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fML3RdU0/3C8b9eeo8fTm+7OW1jR7eALOGHJP2ObctU=;
  b=i0AIXthVsaJ6ugwOggIvfDiw2AwpZdpUViMK/mzdnhzldMLJXTT1ISz5
   9/We1XhqQiXnPUYMm57XFI5AVC/3SbMKu/ayPDp7MooxIW+97Nb5qUjC5
   sesCm66MDNtP8NHS+BaDLEW0M+RL5IyzlU0E3ZN2ed7ReJOfzFXE0KxON
   oShN6B5t0RTXMfHjEpiyzSDHIKP7qzq9ONr5ngCSBYn/7adBUdhEq/cUB
   +fxSIx8shUGPW82AhrILkDq7NoZLsTIPn/nYw29d64q3qrJsfhymCwu2T
   9OIkHSHKyEh1C7nSbXygHFz7NG46n+FtxofBVzYQbiRicOJgP1p91S1Xw
   A==;
X-CSE-ConnectionGUID: SzGeOeAWSbevSn6sNf/Wgg==
X-CSE-MsgGUID: j6qzbZcqQaqajqcoeU4hhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47750183"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="47750183"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:15:15 -0700
X-CSE-ConnectionGUID: +x65xRrlTlKjfpCXWCIyZg==
X-CSE-MsgGUID: 7parAngqThKBuIxq46GmnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="157839775"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:15:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAnQC-000000029mm-0PII;
	Fri, 02 May 2025 13:15:08 +0300
Date: Fri, 2 May 2025 13:15:07 +0300
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
Subject: Re: [PATCH v7 03/11] pinctrl: Add MAX7360 pinctrl driver
Message-ID: <aBSbKwmao-K-e1k8@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-3-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-3-4e0608d0a7ff@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 01:57:21PM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
> can be used either for GPIO, PWM or rotary encoder functionalities.

...

> +#include <linux/array_size.h>

> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/device/devres.h>

Since device.h is included the other two are not strictly needed, but it's fine
to leave them explicitly included.

> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

> +#include <linux/slab.h>

Is it used?

...

> +struct max7360_pinctrl {
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_desc pinctrl_desc;

Does`pahole` agree with your choice of layout?

> +};

...

> +static int max7360_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
> +			   unsigned int group)
> +{
> +	struct regmap *regmap;
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

> +		regmap = dev_get_regmap(pctldev->dev->parent, NULL);

This assignment can be unified with the definition above.

> +		return regmap_write_bits(regmap, MAX7360_REG_GPIOCFG, MAX7360_GPIO_CFG_RTR_EN, val);
> +	}
> +
> +	return 0;
> +}

...

> +static int max7360_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	struct pinctrl_desc *pd;
> +	struct max7360_pinctrl *chip;
> +	struct device *dev = &pdev->dev;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");

Missing 'return'. Or...?

> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	pd = &chip->pinctrl_desc;
> +
> +	pd->pctlops = &max7360_pinctrl_ops;
> +	pd->pmxops = &max7360_pmxops;
> +	pd->name = dev_name(dev);
> +	pd->pins = max7360_pins;
> +	pd->npins = MAX7360_MAX_GPIO;
> +	pd->owner = THIS_MODULE;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);

I don't like this, but I have no better idea right now. Perhaps add a comment
on top to explain this call?

> +	chip->pctldev = devm_pinctrl_register(dev, pd, chip);
> +	if (IS_ERR(chip->pctldev))
> +		return dev_err_probe(dev, PTR_ERR(chip->pctldev), "can't register controller\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



