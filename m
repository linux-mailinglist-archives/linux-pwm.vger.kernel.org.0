Return-Path: <linux-pwm+bounces-4873-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63191A32B50
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 17:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063653A2E88
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE820B7F7;
	Wed, 12 Feb 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJI3DgFH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409C271838;
	Wed, 12 Feb 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377056; cv=none; b=W+2V1AG8dTS8Me6CfCbFBmFiKBAC/ENVkNoetLwAwt12OFZDERMJQeGi3OaikQcidet9JraoxXwXpQLc/F9GXyTS+gFzhYep/QuGq6QN3mMh0N8r7XR5/QDIFwaqLk2EMFCcL8F6dNX4/NnZtF5MyoJUlaw3Mo0oy0zlp2ERBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377056; c=relaxed/simple;
	bh=Sx0gjwQ2xWYVGUEXYQCDsZtlY6q7k8a71QG8sWV01LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn2UzZS2elVqNF47nQg7t8cOROA4xOghPSXz3154nL7Mtcy4rM9GyP59moJSGLqY4Ww3eRVn8sLqypPzls2lbaUMAPSipncm64SA+zUR/EwaSoBLXnzccn6i9njT5U7ou4SeoPCiO6FyqX4eQelPdTA12ycllH7B7oQw1/61rDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJI3DgFH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739377055; x=1770913055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sx0gjwQ2xWYVGUEXYQCDsZtlY6q7k8a71QG8sWV01LE=;
  b=TJI3DgFHWncYN37Bnt1RdspZwfQ/G/oBcFQ1gwzdcodFTcB9Mvn9V41N
   8SZ5t6VHASbKWVNSXX6H3o4bfZRuxx8veEOfbjn1B5Of39cqwOBVXbol2
   zwqXGeO5yMTeOGcD6jro1SVqCW3RoJuP7KKVSjXPGdnHEcS5Sq5Q9fYpg
   ZZXkDbR4XZU3NM3sDZ1IlH9bI3qRzGadukPJ8yE21LeBudWKJN5UBQ0AB
   KaJHdi9YItzD9Ij+fSC7qS+7I6EWJlX0PFNi+iVcttFM/tF7TxT/HagpE
   E9ZM+HNt3/V+3Fs0z9CISw8y2Wx76fRItZy0+x4yQS/dqQSDwJ0MlYuSv
   A==;
X-CSE-ConnectionGUID: q3GkO22OStWlwBuEPOQmbw==
X-CSE-MsgGUID: zHrETBkGSRy2gsO5VSU1Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="65401766"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="65401766"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:17:34 -0800
X-CSE-ConnectionGUID: kjQ8+wilTqiuJDRQQb1Ggg==
X-CSE-MsgGUID: s54xrSM0QgyEtfmNe8TMtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112851499"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:17:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiFQV-0000000At9E-0oX1;
	Wed, 12 Feb 2025 18:17:27 +0200
Date: Wed, 12 Feb 2025 18:17:26 +0200
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z6zJljphfTuEhBTP@smile.fi.intel.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <Z5eFGJspoGOINcG6@smile.fi.intel.com>
 <D7QHGB7D0VSG.X255SDU7DFOF@bootlin.com>
 <Z6y65SnrprvnpKEa@smile.fi.intel.com>
 <D7QLITNTXRUJ.3NA44E6PQMAUX@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7QLITNTXRUJ.3NA44E6PQMAUX@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 05:08:56PM +0100, Mathieu Dubois-Briand wrote:
> On Wed Feb 12, 2025 at 4:14 PM CET, Andy Shevchenko wrote:
> > On Wed, Feb 12, 2025 at 01:57:34PM +0100, Mathieu Dubois-Briand wrote:
> > > On Mon Jan 27, 2025 at 2:07 PM CET, Andy Shevchenko wrote:
> > > > On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Briand wrote:

...

> > > > > +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> > > > > +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> > > > > +		return -ENODEV;
> > > > > +	}
> > > >
> > > > This is not needed, it is already done in GPIOLIB core.
> > > 
> > > I believe this is still needed:
> > > - For gpos, we need the gpio count to correctly set the partition
> > >   between gpo and keypad columns in max7360_set_gpos_count().
> >
> > Shouldn't be that done somewhere in the GPIO valid mask initialisation?
> >
> > > - For gpios, we need the gpio count to setup the IRQs.
> >
> > Doesn't GPIOLIB parse the property before initializing the IRQ valid mask
> > and other init callbacks?
> 
> No, I believe I have to register the IRQ before registering the GPIO, so
> I can get the IRQ domain.
> 
> Right now I have something like:
> 
> irq_chip->num_irqs = ngpios;
> devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), max7360_gpio->regmap,
> irq, flags, 0, irq_chip, &irq_chip_data);
> gpio_config.irq_domain = regmap_irq_get_domain(irq_chip_data);
> devm_gpio_regmap_register(dev, &gpio_config);
> 
> Also, gpiolib will store ngpios in the gpio_chip structure, but while
> using gpio-regmap, this structure is masked behind the opaque
> gpio_regmap structure. So I believe there is no easy way to retrieve its
> value.
> 
> This part of the code changed a lot, maybe it would be easier if I push
> a new version of the series and we continue the discussion there?

So, what seems need to be added is some flag to GPIO regmap configuration
data structure and a code that is called after gpiochip_add_data() in
gpio_regmap_register() to create a domain. This will solve the above issue
and helps other drivers to get rid of potential duplication of
devm_regmap_add_irq_chip_fwnode() calls.

Have you researched this path?

-- 
With Best Regards,
Andy Shevchenko



