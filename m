Return-Path: <linux-pwm+bounces-5476-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92228A87DB1
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6597A320A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898B266568;
	Mon, 14 Apr 2025 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyLabfru"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FF33997;
	Mon, 14 Apr 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626590; cv=none; b=lQLZb7aFB6bbpe2I/U+gQaBg1Ut+r0Hdrssjv0c727gJU1usaOdr4QMYgw4fPX9Qi5qqqXkRGB0AqSrEg/TWmPyl49lSny/IzmiTBiJmSaYjZI2lMk0dxGJTSV5OY6Upia50OdCuA/btcWzcLvt7boPXSktYvlfsXDjn9cDKrjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626590; c=relaxed/simple;
	bh=WXgwEdzSaX+Y4rUWpW9RwNeaypZtrXrH4OUahsqCvQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp5/NmfnhTg5fkMERIOORHtJFKXxkyAy3Eky6tEW71RlSMOM6NE09Q6Mt1dcaFSe4TPA5UG4k8UUVvg8DNraiRxLTRDIcau/8qGo8O9BPgU51RAiq0nJ4+X31z+1iX2KAhD7f7ieXM0f2M8G1eyEMSfB0SSnMxs8M65vjscj7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyLabfru; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744626588; x=1776162588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WXgwEdzSaX+Y4rUWpW9RwNeaypZtrXrH4OUahsqCvQs=;
  b=CyLabfrufKaHrDiROU2pLM72MTWusrwRhxbKf5vraf42z5gIpaCjtj3L
   vmFhksXiTG8iRBAwH+GpSBXYBSAm/vtLajkbKsuXBmUe2XzE0EA3chF+9
   hgYDRBFnMMQ8byIbBLFyo0Nm9uqBs4T2SNfu3agd9tC4/kO12m3tZPm04
   MwMiOGepSs5ucLdq9pcIGeQOW9XiEJUN7gFemrqXCsrBVPF8JBJnKLa71
   zY7dHouHvR3tXbKwxqINy9kJbErLsrXATIFDGTrurkF9eByI8LVPvalg5
   /p6m8dbapP0j888odLyuo8szltuEBuwz7gk1DpNwmo/6Q+Fm75GanUGNE
   Q==;
X-CSE-ConnectionGUID: fIkSATCiRwWXgC+MOO9jgg==
X-CSE-MsgGUID: /wjse7vhTXi2V6G7JK8XaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="33701338"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="33701338"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:29:47 -0700
X-CSE-ConnectionGUID: Q1oHgF+hQ42aTWXeZ5VwYg==
X-CSE-MsgGUID: CF7aM6O+QrSUlhJBHKpxtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134755301"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:29:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4H4N-0000000CCxF-0A55;
	Mon, 14 Apr 2025 13:29:39 +0300
Date: Mon, 14 Apr 2025 13:29:38 +0300
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
Subject: Re: [PATCH v6 07/12] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <Z_zjki8ShybzpWDk@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-7-7a2535876e39@bootlin.com>
 <Z_aiubEgXLaDpsoq@smile.fi.intel.com>
 <D92U6CMH9WWM.3JLM1KLZF4WF8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D92U6CMH9WWM.3JLM1KLZF4WF8@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 10, 2025 at 11:03:46AM +0200, Mathieu Dubois-Briand wrote:
> On Wed Apr 9, 2025 at 6:39 PM CEST, Andy Shevchenko wrote:
> > On Wed, Apr 09, 2025 at 04:55:54PM +0200, Mathieu Dubois-Briand wrote:

...

> >> +#ifdef CONFIG_REGMAP_IRQ
> >> +	if (config->regmap_irq_chip) {
> >> +		struct regmap_irq_chip_data *irq_chip_data;
> >> +
> >> +		ret = devm_regmap_add_irq_chip_fwnode(config->parent, dev_fwnode(config->parent),
> >> +						      config->regmap, config->regmap_irq_irqno,
> >> +						      config->regmap_irq_flags, 0,
> >> +						      config->regmap_irq_chip, &irq_chip_data);
> >> +		if (ret)
> >> +			goto err_free_gpio;
> >> +
> >> +		irq_domain = regmap_irq_get_domain(irq_chip_data);
> >> +	} else
> >> +#endif
> >> +	irq_domain = config->irq_domain;
> >
> >> +
> >
> > This is blank line is not needed, but I not mind either way.
> 
> I can remove it, but as the line above is potentially part of the
> "else", I have a small preference for keeping it.

Yes, but it's still coupled with the flow. But okay to leave as is.

> >> +	if (irq_domain) {
> >> +		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
> >>  		if (ret)
> >>  			goto err_remove_gpiochip;
> >>  	}

-- 
With Best Regards,
Andy Shevchenko



