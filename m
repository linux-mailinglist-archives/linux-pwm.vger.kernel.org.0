Return-Path: <linux-pwm+bounces-5427-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559CA82D14
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45951B673D0
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FE1270EB4;
	Wed,  9 Apr 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7TqE1ra"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C01DFFC;
	Wed,  9 Apr 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218065; cv=none; b=bFtWngp/h2EVHsPT/jjOt4qo2jYsMCfI+TBSvXYru6iYQtj88MqwcphmTnDDzdoEkpgyFgAQjn7wOb1zig2Ve1ACApGVDdU1aRz5mqMtWizaOC+nCiNexYJHm2nYvIYdvjKuxrH2yFCnZegRQcBrzi3nZE7jSQiz0GijD5WwLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218065; c=relaxed/simple;
	bh=wogDHgQQKduA3qZtaPkJ54FXMez58xZgz/AyToZC7mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3dO/CcwxJX7Sou6HEUY79vY3nwOP+D9oz8GKZPZl6ECitFogFGP64OPsQatYvZoK1jH6KVfKxZXeo5KKLDZWKQMrQ2+gXp8biW4J+cLsn8aQU63iXK0EfWHtSb1dYL6KEtLobCGuI3csLpRvsC/tE8O83nuNr36k3hoL9ZV7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7TqE1ra; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744218064; x=1775754064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wogDHgQQKduA3qZtaPkJ54FXMez58xZgz/AyToZC7mo=;
  b=O7TqE1raCymOaV0EFY6DoOiNJBPySva1NPImAu0IPCpC3OVT6GzOhUXB
   dyKU7Tv87i4cbF/++ue5JkUWwrpLZFB9N27C0e8P19RfDcB1Wr5mEZMwK
   +FFA/K6GkcGRBSbp/52KAyDFkrZp59D1PB97ochQ1PBtBNKADaEsYZmFT
   cYLCHJ0+wxHik0Q36arGrqbl/IpijTJlZl3I3Jhe0lUysVu7Pd3S6bAFo
   WY26dLEPqATb59fEuOfUrDTzpYRvjuKVwACDznlp0tldRRVdn73/VTexH
   3B8TdI610BqxMR1xEIelPJKqBuvN9rDMYi+RrNOfY5ufaNOoMT/9iGc06
   w==;
X-CSE-ConnectionGUID: HOriUf3PQqCe6evbv/BQMg==
X-CSE-MsgGUID: 923/5lLjSj6f17lbMcCuXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45830025"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45830025"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:01:03 -0700
X-CSE-ConnectionGUID: aygTojG7RkipvjMsmhM9+g==
X-CSE-MsgGUID: vpwd06nyQEaKv5EpIAmF5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="132784321"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:00:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2YnH-0000000AnnR-1o0Y;
	Wed, 09 Apr 2025 20:00:55 +0300
Date: Wed, 9 Apr 2025 20:00:55 +0300
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
Subject: Re: [PATCH v6 04/12] pwm: max7360: Add MAX7360 PWM support
Message-ID: <Z_anx4eiPB9DJ97J@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-4-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-4-7a2535876e39@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:55:51PM +0200, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.

...

> +static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct regmap *regmap;
> +	struct device *dev;
> +
> +	regmap = pwmchip_get_drvdata(chip);
> +	dev = regmap_get_device(regmap);
> +}

This will produce compiler warnings. Why do you have this at all?

...

> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw = _wfhw;
> +	u64 duty_steps;
> +
> +	/*
> +	 * Ignore user provided values for period_length_ns and duty_offset_ns:
> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of 0.
> +	 */
> +	duty_steps = mul_u64_u64_div_u64(wf->duty_length_ns, MAX7360_PWM_MAX_RES,
> +					 MAX7360_PWM_PERIOD_NS);
> +
> +	wfhw->duty_steps = min(MAX7360_PWM_MAX_RES, duty_steps);

> +	wfhw->enabled = (wf->duty_length_ns != 0);

Can be written as

	wfhw->enabled = wf->duty_length_ns;

Or if you want really to be picky about rules,

	wfhw->enabled = !!wf->duty_length_ns;

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

Why not move this to the definition block above?

	struct regmap *regmap = pwmchip_get_drvdata(chip);


> +	ret = regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & BIT(pwm->hwpwm)) {
> +		wfhw->enabled = true;
> +		ret = regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);

		if (ret)
			return ret;

> +		if (!ret)
> +			wfhw->duty_steps = val;
> +	} else {
> +		wfhw->enabled = false;
> +		wfhw->duty_steps = 0;
> +	}
> +
> +	return ret;

	return 0;

> +}

...

> +	device_set_of_node_from_dev(dev, dev->parent);

This needs broader discussion.

-- 
With Best Regards,
Andy Shevchenko



