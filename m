Return-Path: <linux-pwm+bounces-5803-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0D2AA6F55
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E201BC2B2D
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5E23AE83;
	Fri,  2 May 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RM/i6iQ8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E71DB546;
	Fri,  2 May 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181156; cv=none; b=RR4FjsjoYLN/8J1BHDjzN/DuWHYZDjS6UTOycn2Y1wJWb5vwSN9ZylASMvTug48ppxIRct9dfBPV/U2loQg28LKbaezdOs46tVtCuOgZHj7F8ODPzUIeN5kcUOEp7TPUMDN6rCokCP4fEY+/FB4Aae1XIuX871Z4hp/3soNnc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181156; c=relaxed/simple;
	bh=R633Na5R4s5yhCwdwY1f1baIFFBHLB81YaoEibp5XiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAI2OctIcSUdy3vdF6QVlYGwrByLUSk2cFv4CwNDpY4Ut1AfW4OPnHuv6aBsy+8tugi9JMLmXCLbgLR68pDlI3Q8H1l1KoOF/rPYp8KiZaN5lcVW8GYSXs+oWVfEQcSoqWFqht8RcoijDoYI6yXD9qwQPsW9Ejm8EcuFt3K9Oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RM/i6iQ8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746181155; x=1777717155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R633Na5R4s5yhCwdwY1f1baIFFBHLB81YaoEibp5XiA=;
  b=RM/i6iQ8+buRn2eMKkRk8rW0ZngqT7KqBH4N0nNVFhhybq9Faaf1X7DL
   jVWlEGZmjPWdP2q9YLHZj5B3RhzeHnISBeqq3jDt1xy5HRtnY/xJYXDhQ
   Gx7ShZhueqRbN39gQGXrWvJSZPeFkCUefLUep9Uw2XzQ9Ds3oD5CVPYFn
   y8esRdAM3hfTVbVJlVPmXzPy4kxo1DVA1vmN/xQV1psdXKSO5rMMyjm01
   oYR48CHEAtDSMG81BsaFFlKj2QrATEj94aErRWr3uTXV/lF6/PwEggSxZ
   pjBYJcV+2hbFHB+offVSAjFCCBhLCRTvmKVYwrta1PAJegOH6gfZhvnP0
   A==;
X-CSE-ConnectionGUID: qHMe44IiQOObguc8JpyHDw==
X-CSE-MsgGUID: V0kQep/GQq+fO4ijEWjv3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="65271825"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="65271825"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:19:14 -0700
X-CSE-ConnectionGUID: QJy49UihQwmmaA9ja7uM4g==
X-CSE-MsgGUID: JMI4AkmhTz6pZCy9N8NdHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139787684"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:19:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAnU2-000000029q3-0MJH;
	Fri, 02 May 2025 13:19:06 +0300
Date: Fri, 2 May 2025 13:19:05 +0300
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
Subject: Re: [PATCH v7 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <aBScGRN-1C81gtC5@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-4-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-4-4e0608d0a7ff@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 01:57:22PM +0200, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.

...

> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct regmap *regmap;
> +	int ret;

> +	regmap = pwmchip_get_drvdata(chip);

Just unify this assignment with the definition. Will save you 1 LoC.

> +	ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
> +				MAX7360_PORT_CFG_COMMON_PWM, 0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write_bits(regmap, MAX7360_REG_PORTS, BIT(pwm->hwpwm), BIT(pwm->hwpwm));
> +}

...

> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
> +					     const void *_wfhw, struct pwm_waveform *wf)
> +{
> +	const struct max7360_pwm_waveform *wfhw = _wfhw;
> +
> +	wf->period_length_ns = wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
> +	wf->duty_offset_ns = 0;
> +	wf->duty_length_ns = DIV64_U64_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERIOD_NS,

Does the numerator have already 64-bit type? Otherwise (u)int*(u)int will be
just an (u)int.

> +						MAX7360_PWM_MAX_RES);
> +
> +	return 0;
> +}

...

> +static int max7360_pwm_read_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw = _wfhw;
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;

> +	regmap = pwmchip_get_drvdata(chip);
> +

Save 2 LoCs.

> +	ret = regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & BIT(pwm->hwpwm)) {
> +		wfhw->enabled = true;
> +		ret = regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);
> +		if (ret)
> +			return ret;
> +
> +		wfhw->duty_steps = val;
> +	} else {
> +		wfhw->enabled = false;
> +		wfhw->duty_steps = 0;
> +	}
> +
> +	return 0;
> +}

...

> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");

> +	device_set_of_node_from_dev(dev, dev->parent);

Probably same comment as per pin control driver case?

> +	chip = devm_pwmchip_alloc(dev, MAX7360_NUM_PWMS, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops = &max7360_pwm_ops;

> +	pwmchip_set_drvdata(chip, regmap);

> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



