Return-Path: <linux-pwm+bounces-5262-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F13A6A41B
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 11:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E409F8A5215
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033B224258;
	Thu, 20 Mar 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2muV/RL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82343224248;
	Thu, 20 Mar 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467857; cv=none; b=mtDUaCUwruBp/bN1OIqu7NLyyS4yJ9oeO6W0Stimq6msrN7ffE5FQep/SJUz4SQF5UM6gGih3Kevm13AZEu7DLlrJpY7TCK/aebDYYzOMKLW1xEQ7MRxEGWfaP0+J2LkIzl7WC7t9DNjiMGJ80Wm7+ZKeP9+frFmUkGC1EJ+Mvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467857; c=relaxed/simple;
	bh=QvytSsiWxD2MHJnfgrrzyAPdz+yE7OTqrKl1zNsvsvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgJoIM6jnCrp6K6waQIpksZya02qGBgsBAL7djayn2y+UEKbkjeKMagBveUHqK9cHFtFUNlG1FrFEonYKdcFYfLjcEwuL2gGTRUvxbuRxaXNK/N76DgRtdBCoc9s+2uwQ4Y9Irls3PeDKlxaAzJn6gF2DcyYYO18GAnpiqJT0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2muV/RL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742467855; x=1774003855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QvytSsiWxD2MHJnfgrrzyAPdz+yE7OTqrKl1zNsvsvE=;
  b=O2muV/RLu2VJkaOsvu2mj4KSkezAQeh6wpv8b5Tala6GORz/IS/bU7c7
   4fbnOS0aRA5GyFp9us2BugqZYYIfcimhcIGMyoydY6/XocirwKJT4p6D4
   CuqblyJybpatItzujEfzeODNK8J9fBeh0PMgyNTpc2uXaZ23girpAoT9P
   FxOtoAE5Xxxub7pO4E5XU4tmCYk+9oJF3d8HqSKpuYoWorUJlwz3FsF7u
   YoSUm11bx8cR1EYSorErS2hUYWAmZTF9qvGyqGeFZYLK3bb+9tpGrnZlx
   NSNidJMZKJOfXiSEumwje+ip4JpPASVZSv/cXacsYq9XqAzDZTZD8nQT7
   w==;
X-CSE-ConnectionGUID: opiOJB1qTqu5PwnzGRTxyA==
X-CSE-MsgGUID: rV/NpvPoRfOPQ6648QpWrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43859934"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43859934"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:50:55 -0700
X-CSE-ConnectionGUID: 1dZVKx1+R8qNbY/9mGwiAg==
X-CSE-MsgGUID: mJoXdVb0THyqfxpb796QOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123069318"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:50:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tvDU7-00000004CNR-0DE8;
	Thu, 20 Mar 2025 12:50:47 +0200
Date: Thu, 20 Mar 2025 12:50:46 +0200
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
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <Z9vzBkyuzdAFCdg9@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
 <Z9mksuMAlNCa447h@smile.fi.intel.com>
 <D8KXKZ53OKGH.4LG4L2LRY9XS@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8KXKZ53OKGH.4LG4L2LRY9XS@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 08:55:57AM +0100, Mathieu Dubois-Briand wrote:
> On Tue Mar 18, 2025 at 5:52 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:22PM +0100, Mathieu Dubois-Briand wrote:

...

> > > +#ifdef CONFIG_GPIOLIB_IRQCHIP
> > > +	struct regmap_irq_chip *regmap_irq_chip;
> > > +	struct regmap_irq_chip_data **regmap_irq_chip_data;
> >
> > But why double pointer?
> 
> I believe this has to be a double pointer, as it is going to be assigned
> a pointer value: data buffer is allocated inside of
> devm_regmap_add_irq_chip_fwnode().

Yes, but it doesn't need to be a double one in the data structrure, right?

> But as you said, it's better to remove it and add it later if there is
> an use case.

This would be even better for now, thanks!

-- 
With Best Regards,
Andy Shevchenko



