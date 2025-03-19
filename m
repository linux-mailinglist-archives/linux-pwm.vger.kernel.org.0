Return-Path: <linux-pwm+bounces-5240-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D71EA68B39
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB1B7A6641
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ABA254844;
	Wed, 19 Mar 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwV25WfF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579F22F19;
	Wed, 19 Mar 2025 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383141; cv=none; b=fwt1MIckbfXGcbS9mfTjfu1QoajB1MWp26A91+lHK9mXxFsNY77AvV6t+3CWdbUrnUJN3f4ibNOT146EV475YiCawXH8RaM6SYbUIYhfvxBTUFjjzSQRlGQbnH8i2DMnY/92H5VLt1GZu/OK9AVh3An7cTUPLGRfA7PxHyg8pQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383141; c=relaxed/simple;
	bh=be9QOWEBZuaCJDZwefTcleUq/fxaw1SZCizaMoJDlvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm7XtLPHSfGXby1AZmbK9uYwIPbHKjhUN6tSOHi766JEoULa3eeRituCm584NmGUsTMiOgCvWhf6R3iB8z5tItxRsdp2Ohr8DrhW3/hPYPPNCpudZeJgr41yNIl9KOH4qNmtgATFZ9pg5NTVfnzwDCwZODasWORdJuwPmNm8aeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwV25WfF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742383140; x=1773919140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=be9QOWEBZuaCJDZwefTcleUq/fxaw1SZCizaMoJDlvs=;
  b=ZwV25WfFgGvtdLh4OvhdHXYjfqgNu6tcRntvqI8DxNRtPoJM2tpahpBu
   llQ67UXsBpnuNOlYDghcUNqrqA2Y8BmOWL9LBi2PFBqpnrI/aYFXajzmd
   NQO2HXjLF+9rymf8sFxE2GyWYKH/5CTyTVuyIX1RrDhV0V+MspV/1Vo8+
   Ya2zY1AoNPxK+DNVXiaOMTvCh3xzT0o0I+7U4Tkt7lKkTwlRZRpJf5/Tm
   +a8zgo4oF+TPSIs1j3MmSWj0oUs0TIZcBg9Z0kDZdeCoA8rVtqRhrU+AL
   gNdgtK8bkm/5ye+VmniQuSQV1UD8+I8XKk/fONl5Wzs2/a3K01pLXTYB4
   w==;
X-CSE-ConnectionGUID: t827X9z4T+6vkCfqtbPfgg==
X-CSE-MsgGUID: uM7WPrlsSui1qgxqKMeILg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53781337"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53781337"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:18:59 -0700
X-CSE-ConnectionGUID: pF67o22TRT24gXG55lGszg==
X-CSE-MsgGUID: p6aAjr08TMSgzNNe2SxAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127648477"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:18:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1turRj-00000003tty-03tM;
	Wed, 19 Mar 2025 13:18:51 +0200
Date: Wed, 19 Mar 2025 13:18:50 +0200
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
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.

...

> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>

...

> +static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct regmap *regmap;
> +	struct device *dev;
> +
> +	regmap = pwmchip_get_drvdata(chip);
> +	dev = regmap_get_device(regmap);

Huh?!

> +}

...

> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)

I would expect other way around, i.e. naming with leading underscore(s) to be
private / local. Ditto for all similar cases.

...

> +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	const struct max7360_pwm_waveform *wfhw = _wfhw;
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	regmap = pwmchip_get_drvdata(chip);
> +	val = (wfhw->enabled) ? BIT(pwm->hwpwm) : 0;

Redundant parentheses.

> +	ret = regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpwm), val);
> +	if (ret)
> +		return ret;
> +
> +	if (wfhw->duty_steps)
> +		return regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_steps);
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
> +
> +	regmap = pwmchip_get_drvdata(chip);
> +
> +	ret = regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & BIT(pwm->hwpwm)) {
> +		wfhw->enabled = true;

Also can be (but up to you)

	wfhw->enabled = val & BIT(pwm->hwpwm);
	if (wfhw->enabled) {

And also see below. Perhaps it is not a good suggestion after all.

> +		ret = regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);
> +		wfhw->duty_steps = val;

Set to a garbage in case of error, why?

> +	} else {
> +		wfhw->enabled = false;
> +		wfhw->duty_steps = 0;
> +	}
> +
> +	return ret;
> +}

...

> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	if (!dev->parent)
> +		return dev_err_probe(dev, -ENODEV, "no parent device\n");

Why? Code most likely will fail on the regmap retrieval. Just do that first.

> +	chip = devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);

This is quite worrying. The devm_ to parent makes a lot of assumptions that may
not be realised. If you really need this, it has to have a very good comment
explaining why and object lifetimes.

> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops = &max7360_pwm_ops;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
> +
> +	pwmchip_set_drvdata(chip, regmap);
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



