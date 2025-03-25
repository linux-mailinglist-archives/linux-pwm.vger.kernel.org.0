Return-Path: <linux-pwm+bounces-5284-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02694A70730
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BFE16D78D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2E25DCFA;
	Tue, 25 Mar 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeeD7cF3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451B19F13B;
	Tue, 25 Mar 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920841; cv=none; b=c8z+nT3MHzljx34PWdlq6gS/BD20DeJXPMyOb2/PSk/X+VmDgTSaw19rQZUThhqEGjM9y6IaA3UiDK6daXhoGSNJl2IZqgnwpb936UDzkhpgQlh704gQK2V2WhSDBsNOYNvuJfz4HBdnYZDoyBr53C5anCUF0EYwWLhIVGc9r6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920841; c=relaxed/simple;
	bh=YiWxemzCPcXInFipmbbXjiiIgfgNIEo4XpOPG15maUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDKgbx9rR0+dLRYd/AvTy7rCHS+niLETGzoX9FI7h3ovzGWzQ/NozDg92XWb2N3KqpjE30R5fxSvvSXLZv5GLcDd5GY+zXW/fiMpmG18sGidOKkEo6zFvz3gwDGyddonGLVh/b9iJKmRq8FoKSV6VwBVwBJHA6h8SKQkhqqe1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeeD7cF3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742920840; x=1774456840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YiWxemzCPcXInFipmbbXjiiIgfgNIEo4XpOPG15maUw=;
  b=YeeD7cF37TvuTRVwgG7PRRo6kXvr7Qyj9tLp0PBPMmnHbjbMogn+EUpR
   DtSeozVjIfXOAv9kcotD1sbDXeX8L3nkrwuq701gAd89e6gQHAscX5oWM
   eqt62l12ATmLcDLV3+AJpr25kF2sywOpObouJu4SWwuFR8axwJtiCkeTG
   3svGCx4suiMYosjiPHFM03W1KH48HlQ68gWbVD8UjPN5Nz9XDUNC137B9
   dILN+L93iRIST5bHi+OnsAxbkf1cnP83KmN5jMk6He2ttyRbG2eL/kN6K
   ZwAQPNgxAWmp+0xICMXSSH6FFb70tcjIXKRDMyOnDXSlyiBEy/UYqApyK
   Q==;
X-CSE-ConnectionGUID: jWdd0O1SROih+hy86e51yQ==
X-CSE-MsgGUID: tM9ehbTqQbyOddy7KyZ6aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61571901"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="61571901"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:40:39 -0700
X-CSE-ConnectionGUID: aQj/cUsCSYO8/doZAHqAZg==
X-CSE-MsgGUID: STQWoa1xQLWDZBx8Y3Ektg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="129618481"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:40:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tx7KJ-00000005nye-09u0;
	Tue, 25 Mar 2025 18:40:31 +0200
Date: Tue, 25 Mar 2025 18:40:30 +0200
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
Subject: Re: [PATCH v5 02/11] mfd: Add max7360 support
Message-ID: <Z-Lcfm6eXMm1QzEl@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-2-fb20baf97da0@bootlin.com>
 <Z9qmDkwSpZHxwuQj@smile.fi.intel.com>
 <D8PHKDVTYTQ5.1HT80KX538PRQ@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8PHKDVTYTQ5.1HT80KX538PRQ@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 05:26:12PM +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 19, 2025 at 12:10 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:18PM +0100, mathieu.dubois-briand@bootlin.com wrote:
> > > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > +	ret = max7360_mask_irqs(regmap);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Could not mask interrupts\n");
> >
> > Hmm... As far as I can read this masks GPIO interrups. Does it do anything
> > else? If it's covered by the GPIO/pin control drivers, one want probably to
> > see that to be done there in the respective callback (init_hw_irq or alike,
> > I don't remember the name by heart).
> 
> Hum, I'm not sure I can do that.
> 
> So the "inti" interrupt line is shared across the GPIO and the rotary
> encoder functionalities.
> 
> On reset, GPIO interrupts are not masked. This means, if we do the
> masking in the GPIO driver and the GPIO driver is not loaded but the
> rotary encoder driver is, the rotary encoder driver might get a lot of
> spurious interrupts.
> 
> So I believe it makes sense to mask the interrupts here, setting the
> chip in a sane configuration, whatever child drivers are present.
> 
> Any thought about that?

Okay, this makes sense. I forgot if you have any comment in the code
(probably not if I asked the question), but in any case the above can
be added on top of the function explaining this.

-- 
With Best Regards,
Andy Shevchenko



