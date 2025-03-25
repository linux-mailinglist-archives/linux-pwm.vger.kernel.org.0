Return-Path: <linux-pwm+bounces-5278-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37FA705A4
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6571889B00
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EFB252913;
	Tue, 25 Mar 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQn0rqHA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B348215060;
	Tue, 25 Mar 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918184; cv=none; b=Tsh1lUbHSIjvxZN8bQQ7GfBY4nIobgNqcVcklPQscXYlS3f8VGBU8TzXjw1c08nlSctshoYE1OO3k2C8gAecbYHIF/O541ppLcZtEfDiX81EE00yG5BGK8cBwlPiRuJQOTzRVv17ZkepPIaJQfW2GiMke/ljUo59Yzh0uF3C7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918184; c=relaxed/simple;
	bh=fXWs6n+J6WhM+JVMEFBdTgcvtroZq2tZB59/dDpatt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSv+3Jp0fbUKMwPqNnLsYlY030G07SDgbDA3nUVrD5G1HgrwxcskzqJsSJIbbkun7ELHEPXXGFw/qWbXvFI/Zbk2o5ih45TnQplVrtOC/q/u3aCt5v1a9+JLrdratMb7TsAlEjfmS2rXp6uiqOA9lKdxQ6U7T5l4wKH/guBipfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQn0rqHA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742918183; x=1774454183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fXWs6n+J6WhM+JVMEFBdTgcvtroZq2tZB59/dDpatt0=;
  b=VQn0rqHA56ra+4IJmTbYH4pHyk8YjGh00oSnghZR5ftEHljxYWm6dO6i
   uHWq/fmj1whR7pfU+Er6tCZyixCPSMN/nDVi4LWBot0XPlvbtuhI2NYV7
   r/YwQKY+yPb8m4jbjCJD2D44oep75c6LlG2Ss7GspoU7SebFEamey7+Zc
   6NEJyTuSfJ8ZbzYpSImq7yjAgy+5vuw6PvSBnkykyCx7845avodRunsrJ
   3i6ax3mAb1HI9x9sZhezQhq8xi5fghD2lbqU9gvlxjGJ6qgEbd0QttKoF
   hc4F6hv/rLEzcwFQted7fvpMCUfWZwZWgt+iU4lJij3kOa2svAbZF0Fb8
   g==;
X-CSE-ConnectionGUID: hW+OFlD+QnKu2o90fJfJzg==
X-CSE-MsgGUID: 8GHDJEr8TuaE78/Eo/Rm4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43407856"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="43407856"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:56:22 -0700
X-CSE-ConnectionGUID: I5gy14TFTDizsQEE6IvdHQ==
X-CSE-MsgGUID: Zz9g0aBXQiuZtGEEADADsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124937649"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:56:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tx6dS-00000005nHe-3PVn;
	Tue, 25 Mar 2025 17:56:14 +0200
Date: Tue, 25 Mar 2025 17:56:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 03:37:29PM +0100, Mathieu Dubois-Briand wrote:
> On Thu Mar 20, 2025 at 11:48 AM CET, Andy Shevchenko wrote:
> > On Thu, Mar 20, 2025 at 08:50:00AM +0100, Uwe Kleine-König wrote:
> > > On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.com wrote:

...

> > > > > +	chip = devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
> > > > 
> > > > This is quite worrying. The devm_ to parent makes a lot of assumptions that may
> > > > not be realised. If you really need this, it has to have a very good comment
> > > > explaining why and object lifetimes.
> > > 
> > > Pretty sure this is broken. This results for example in the device link
> > > being created on the parent. So if the pwm devices goes away a consumer
> > > might not notice (at least in the usual way). I guess this was done to
> > > ensure that #pwm-cells is parsed from the right dt node? If so, that
> > > needs a different adaption. That will probably involve calling
> > > device_set_of_node_from_dev().
> >
> > It's an MFD based driver, and MFD core cares about propagating fwnode by
> > default. I believe it should just work if we drop that '->parent' part.
> 
> Are you sure about that?

Yes and no. If your DT looks like (pseudo code as I don't know
DTS syntax by heart):

	device: {
		parent-property = value;
		child0:
			...
		child1:
			...
	}

the parent-property value is automatically accessible via fwnode API,
but I don't know what will happen to the cases when each of the children
has its own compatible string. This might be your case, but again,
I'm not an expert in DT.

> On my side it does not work if I just drop the '->parent', this is why I
> ended whit this (bad) pattern.

> Now it does work if I do call device_set_of_node_from_dev() manually,

AFAICT, this is wrong API to be called in the children. Are you talking about
parent code?

> so it's definitely better. But I believe the MFD core is not propagating
> OF data, and I did not find where it would do that in the code. Yet it
> does something like this for ACPI in mfd_acpi_add_device(). Or maybe we
> do something bad in our MFD driver?

...or MFD needs something to have... Dunno.

-- 
With Best Regards,
Andy Shevchenko



