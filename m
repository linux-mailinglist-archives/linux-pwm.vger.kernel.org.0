Return-Path: <linux-pwm+bounces-5562-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9739A926D4
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FF08A689C
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C0255241;
	Thu, 17 Apr 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vl9HBA/H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C78462;
	Thu, 17 Apr 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913810; cv=none; b=n1w50VwbEEHDx2p0EXsTqrvRCWl0Ql/qH3Ulv1S6venfHJAHQ6axm4npuqIbkQINFpZrW/mEK4xjEpR4p7+aFzztJRElMcTHDtEXACbZ2d0seeEDv1Ane36H4aZ2KA8zsp7VwiA6AYKo2yGRjUyC/zUB5Rk8gVBoJ1WHR0APbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913810; c=relaxed/simple;
	bh=W03LBu3/5+jQeuXr+KXGcDhUEUqiIGxwXuLCyFLkwfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMSfirdVy+Lvr/vTW2UONi0BAdmnKs9dvtGIcwbuKqJ/wwMOWjeYmWJNReAelPHZ7PoVOSrsNGu9nBeUqLdjWSNWFaJKIqax7xnv6yU6ADAP4TWHb2FWrPexElgSdsV2XFT1yS7EA6hbP/IXtvb6M1GA311QjXZ1NCisASeiyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vl9HBA/H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744913809; x=1776449809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W03LBu3/5+jQeuXr+KXGcDhUEUqiIGxwXuLCyFLkwfk=;
  b=Vl9HBA/HOE0aK98NFb4iUS5Ogv9/5nMmBjzcsyKTZrIN71huX3c5hLKN
   hn8OMJnuWDbKKzsZ5/7sYnaNIc8IbvnU5Pb057sNlnbIIYwPD5dhIsIll
   TXb7Ns+dra5bJfOEDfqclIt8VhFPxZcqXmSC35O/DkMvkgMhxuehzfbJ1
   M+itpvu9KzyrvylelzlhKKY0QN1xtUP+Vbfo1pZESVKQzzVxhHJSjfPkr
   01/RPumpIMRDp/NPMMRQC56fU+LP7GozWd/0C0w6x2pa6ZC26LI+kzhiS
   73EmrkDvN7XW6uySSJgREfGstDCMFmF6GlXcbAhFiEWHAWoA5WkTmNotN
   g==;
X-CSE-ConnectionGUID: VeYbz9lcR4+ub0/LzcSgUw==
X-CSE-MsgGUID: tZ+KAqKySN+1dzKpNtsi+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46446792"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46446792"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:16:48 -0700
X-CSE-ConnectionGUID: fkOrqflVTFmaxBYFXnh3Lw==
X-CSE-MsgGUID: nzNi7pxLQ4u30DkyspUZsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131200286"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:16:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u5Tmy-0000000DHI5-0iqm;
	Thu, 17 Apr 2025 21:16:40 +0300
Date: Thu, 17 Apr 2025 21:16:39 +0300
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
Subject: Re: [PATCH v6 02/12] mfd: Add max7360 support
Message-ID: <aAFFh8dvgQDJMyOh@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-2-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-2-7a2535876e39@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:55:49PM +0200, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.

...

> +static int max7360_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &max7360_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to initialise regmap\n");

> +	i2c_set_clientdata(client, regmap);

Is it used somehow? In children?

> +	ret = max7360_reset(regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> +
> +	/* Get the device out of shutdown mode. */
> +	ret = regmap_write_bits(regmap, MAX7360_REG_GPIOCFG,
> +				MAX7360_GPIO_CFG_GPIO_EN,
> +				MAX7360_GPIO_CFG_GPIO_EN);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable GPIO and PWM module\n");
> +
> +	ret = max7360_mask_irqs(regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not mask interrupts\n");
> +
> +	ret =  devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				    max7360_cells, ARRAY_SIZE(max7360_cells),
> +				    NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register child devices\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



