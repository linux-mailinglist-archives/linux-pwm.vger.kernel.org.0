Return-Path: <linux-pwm+bounces-5800-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36CAA6DC9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 11:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD99167F84
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21990227E98;
	Fri,  2 May 2025 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGQfuY18"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8E1E0DDC;
	Fri,  2 May 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177192; cv=none; b=QxwcU8TU4Tp9DDmZmx+/1LAcC1X9OvHFh0da7ELleL4E1OxRi/eASr8pcZSL+Xd9+SmRo9lnW/DV57YVjY0GpeMu7/Nnqadwa2fFMpGpf6ERfbIBGdWpybCy1eFdT9YspQX//SCtfMU3O1Y0hiWERojHkBkzzimhUsSJGyrgNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177192; c=relaxed/simple;
	bh=k4K0SLDj35wju6CxDxtCOmwkGr1oR0IoArKcJ2bBLY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoZ0ntqgoIfSmEVCBsKX+z1pjv3Lbfl3YLuD0ZnizVFcFVYs7XxVUgEvjP5ipGJV+aHLaoP81Kxk9EtMikOWLKWG23c9LEfAyRvReaF9x5kJhLXDa9mpvaNJmJB3Fii4L+YaRvG/dUqSkaksJWawWwepW3zwAly5DFM2vuEfHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGQfuY18; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746177190; x=1777713190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k4K0SLDj35wju6CxDxtCOmwkGr1oR0IoArKcJ2bBLY8=;
  b=JGQfuY181SRFMSwz0QgeGvq+MApjpZt/FRlkZSNa6m/4dU6oj0JQp+ny
   8JI3Foy2hMN2ppcscIMi5p2TP9ZBTycO4uJklonXyAa1ESsr/aFDZw3kD
   t4zrfI12WYaY0cBjlr2PhKP1TXQBDgA7KMNnYHGCnO24APd0I6UikAMex
   r4MVc876DWWRg+dHhQG7QRUH6fQqoztTu/kx8uudu96JG8sCM8J9Z7u+y
   czWaQ/LfAcmB+PTNretnnfn3SJAMWRv4N9mRVqz+IL5hB309mX5cZOcqY
   RyGJdZ0q5Wj4VesSNF+6Q4ocwj+kKskRMhjmOsDbPoSBXkGDK3d+K/88s
   A==;
X-CSE-ConnectionGUID: on03tkPZQ3C58zDNCTV/EA==
X-CSE-MsgGUID: nY4Z/9AhRt2pGvpA5OBkRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47868105"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="47868105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:13:09 -0700
X-CSE-ConnectionGUID: yNL+bGqwT66ian8WSyMpIQ==
X-CSE-MsgGUID: axpGhANiQoW7paWcjs0CXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134898278"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:13:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAmS4-000000028s7-3v1u;
	Fri, 02 May 2025 12:13:00 +0300
Date: Fri, 2 May 2025 12:13:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: mathieu.dubois-briand@bootlin.com, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v7 02/11] mfd: Add max7360 support
Message-ID: <aBSMnNQiCbTTH_4a@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-2-4e0608d0a7ff@bootlin.com>
 <20250501125943.GN1567507@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501125943.GN1567507@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 01, 2025 at 01:59:43PM +0100, Lee Jones wrote:
> On Mon, 28 Apr 2025, mathieu.dubois-briand@bootlin.com wrote:
> > 
> > Add core driver to support MAX7360 i2c chip, multi function device
> > with keypad, GPIO, PWM, GPO and rotary encoder submodules.

...

> > +static int max7360_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &max7360_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to initialise regmap\n");
> 
> dev_err_ptr_probe()

Hmm... This one to return an error pointer casted to the needed type. I think
the given code is correct as is.

> > +	ret = max7360_reset(regmap);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> > +
> > +	/* Get the device out of shutdown mode. */
> > +	ret = regmap_write_bits(regmap, MAX7360_REG_GPIOCFG,
> > +				MAX7360_GPIO_CFG_GPIO_EN,
> > +				MAX7360_GPIO_CFG_GPIO_EN);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable GPIO and PWM module\n");
> > +
> > +	ret = max7360_mask_irqs(regmap);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Could not mask interrupts\n");
> > +
> > +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > +				   max7360_cells, ARRAY_SIZE(max7360_cells),
> > +				   NULL, 0, NULL);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to register child devices\n");
> > +
> > +	return 0;
> > +}


-- 
With Best Regards,
Andy Shevchenko



