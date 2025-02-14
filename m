Return-Path: <linux-pwm+bounces-4907-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B2A3611A
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09E71895AE5
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6663266B4D;
	Fri, 14 Feb 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq4KpSyL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728E26659A;
	Fri, 14 Feb 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545825; cv=none; b=EPiEs52aQLJQwBPETT+lmLb92TlH5Mgiy2mwXw8LCvTZFjyecofaZBNxIui+IkdrWRJZUu/SNL5ZgfqS2UUhs4xks+F3iIsPoOckMtTKRLglyXM0/Ffr67CAueze5LoNo1VtUbP4ZyhcauCO7U9P+HKNDVHxnPoS9vtG/iIqJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545825; c=relaxed/simple;
	bh=D+uHq0k343FqJFRy9KVkDXZiYD6MshK/nRMVZIrXXp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8QQtBAd2uZpaR3wuVq7Mp7CSQBpkUyY5iWt+WX9AFak3tnICskAHFlAfPGexhebtse0AxJMVqj54RyP1aR8a1J1A6mJ6weZbd29DBe9DEJpHRA+/pSWpl/opH4FcU7Vv0hI4F7Qm8eyIkGWArk/gyoXDGBv9aSWzdrCxwv6iWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq4KpSyL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739545824; x=1771081824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D+uHq0k343FqJFRy9KVkDXZiYD6MshK/nRMVZIrXXp0=;
  b=Eq4KpSyLTmr6CDKFavQHb0blNVwY316Z8T1WMBKnNUg5Ty2jn8La6/k1
   LCoJe4mS/gyX+g+KkzD7cZFLw1FoG3vrS+iEn3auHmFQluxaEnM7ayzEv
   X+OHHAY5Y91p1skPpP5PI2OVpsWZRer8QARorgmjZKx03nzvgZjGCZ7Re
   TyPy/+VXPaM9P23M8ZQ/MhrofpAYu/yhWWimchziUTVdW7nE/NZVnVpbi
   ugZ6NPpapoBEGrS5LsBLAOfKY8hCUIWspoKosO5PCEutWy2bfi7X5JmPq
   V9gsw8Isx73vaZtCXJYprL954AlRz6AIYV9I/SFWPdNFblVgGC/AIFJ7g
   A==;
X-CSE-ConnectionGUID: 9BgsUX/dRXOoaCI7slF53Q==
X-CSE-MsgGUID: KsHhVcguSSWuGoDzCp5rOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50510459"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50510459"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:10:23 -0800
X-CSE-ConnectionGUID: 2wKz+ewVQo66/w6hC1ftIw==
X-CSE-MsgGUID: K+awIMD6TmCr9xRtkbSDsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118410858"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:10:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tixKW-0000000BWep-3HVY;
	Fri, 14 Feb 2025 17:10:12 +0200
Date: Fri, 14 Feb 2025 17:10:12 +0200
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
Subject: Re: [PATCH v4 03/10] pwm: max7360: Add MAX7360 PWM support
Message-ID: <Z69c1BQHmlbmwUYf@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-3-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-3-8a35c6dbb966@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 12:49:53PM +0100, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.

...

+ bits.h

+ dev_printk.h

> +#include <linux/err.h>


> +#include <linux/math.h>

Other way around, id est you need math64.h (see below).

> +#include <linux/mfd/max7360.h>

+ minmax.h

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

Is this used? Cargo cult?

> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>

+ types.h

...

> +#define MAX7360_PWM_PERIOD_NS			2000000 /* 500 Hz */

Comment is superfluous, if you need HZ units, define the respective one.
Also you can use something like (2 * NSEC_PER_MSEC) which will immediately
gives a hint of how long this is and reduces potential 0:s miscalculations.
This will need time.h

...

> +#define MAX7360_PWM_CTRL_ENABLE(n)		BIT(n)
> +#define MAX7360_PWM_PORT(n)			BIT(n)

Personally I find these macros overkill. The value of them much shorter and
equally readable.

...

> +struct max7360_pwm {

> +	struct device *parent;

Is it not the same as you can derive from regmap?

> +	struct regmap *regmap;

Btw, have you checked the code generation if you place regmap the first in the
structure? It might affect it.

> +};

...

> +	/*
> +	 * Ignore user provided values for period_length_ns and duty_offset_ns:
> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of

> +	 * 0.

Easy to read with 0 be on previous line.

> +	 */

> +

No need for this blank line.

> +	duty_steps = mul_u64_u64_div_u64(wf->duty_length_ns, MAX7360_PWM_MAX_RES,
> +					 MAX7360_PWM_PERIOD_NS);

This comes from math64.h

> +
> +	wfhw->duty_steps = min(MAX7360_PWM_MAX_RES, duty_steps);

...

> +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	const struct max7360_pwm_waveform *wfhw = _wfhw;
> +	struct max7360_pwm *max7360_pwm;
> +	unsigned int val;
> +	int ret;
> +
> +	max7360_pwm = max7360_pwm_from_chip(chip);
> +
> +	val = (wfhw->duty_steps == 0) ? 0 : MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm);
> +	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
> +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm), val);

> +
> +	if (!ret && wfhw->duty_steps != 0) {
> +		ret = regmap_write(max7360_pwm->regmap, MAX7360_REG_PWM(pwm->hwpwm),
> +				   wfhw->duty_steps);
> +	}
> +
> +	return ret;

Please, improve readability by rewriting like this:

	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm), val);
	if (ret)
		return ret;

	if (wfhw->duty_steps)
		return regmap_write(max7360_pwm->regmap, MAX7360_REG_PWM(pwm->hwpwm),
				    wfhw->duty_steps);

	return 0;

> +}

...

> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{

With

	struct device *dev = &pdev->dev;

all below will look shorter and nicer.

> +	struct max7360_pwm *max7360_pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "no parent device\n");
> +
> +	chip = devm_pwmchip_alloc(pdev->dev.parent, MAX7360_NUM_PWMS,
> +				  sizeof(*max7360_pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops = &max7360_pwm_ops;
> +
> +	max7360_pwm = max7360_pwm_from_chip(chip);
> +	max7360_pwm->parent = pdev->dev.parent;
> +
> +	max7360_pwm->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_pwm->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "could not get parent regmap\n");

Will become one line (with the above suggestion).

> +	ret = devm_pwmchip_add(&pdev->dev, chip);

> +	if (ret != 0)

Please, be consistent with the style, and moreover this style is unusual.

> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to add PWM chip\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



