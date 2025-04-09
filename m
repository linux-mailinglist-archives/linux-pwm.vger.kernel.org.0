Return-Path: <linux-pwm+bounces-5423-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B556A82C7D
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E78117E9B8
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5862526FA5D;
	Wed,  9 Apr 2025 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RA9YVEII"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04431BF33F;
	Wed,  9 Apr 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216377; cv=none; b=A9YCH3TJ0ueyHHnnTfABdmtYg+Ge8N9+/G8ZHm1XdJGb5nMVPxl7z4UE2HrauUzJLXmyDs53luVy7LkB3OjW69daGrCXMPrZV2wqIsg5oUKUAdWcEgLtgnedLtEKFPhdHV5yU0iHGXhNfa6D49Sz1ArTFozSXiJf39BIApjw2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216377; c=relaxed/simple;
	bh=W8tY3tRUdknEFyz0MF0lywcl3+JpL/f7H+wWhJecHYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA8Vc1AYF11aFxlvTQd0u8tPrGBrIXg9Qk4cGZvd8rKLhj/tRPGRpHO09eUOTLiO6vR2bbMvfd/6JGneHJfH+cjX2RIy59LPPbG7aFGA0b/7a4PW8+ztOaoNPbnFxv7nvYCKHjdqWd+yi8hdZKzlZI9WJ85f8Ub2OYslN9j98tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RA9YVEII; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744216376; x=1775752376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W8tY3tRUdknEFyz0MF0lywcl3+JpL/f7H+wWhJecHYA=;
  b=RA9YVEII/Yy3hesdE8bku/rhSoGn1IQoytIDdviPdtP9MXlaypkOosKF
   3ikR2CSVHL3x9oCYwtc09WV0vS+qNPpnqx/GQyh2nIZdGdppIrg6d5oGC
   m6mBDc/YgiorqK90uPuMDzANCTChwkAVrF+ng1+8CCzxpELZ97EpEyKGD
   +uMwpZbkMtmkDNtc0GB7JHd5ATPfY0kaSyqhJGk7YQ/FGc5QarYO2NcS8
   a7BUGqK8/ObXp7aqCH1oQqN+3hEVPmQcSrlb3OqeF5pnvQHLjwhJS0NrP
   sCjfp5mQ8Ulm1T5XdyC9GnH3TlCU+oKHMk5/1UVanW27/zykfyUuM92Sv
   Q==;
X-CSE-ConnectionGUID: ASOlgxGbReOJ6ZGYM7YSDw==
X-CSE-MsgGUID: eJFZGyNGQU2HGvw3j/z2hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45596632"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45596632"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:32:55 -0700
X-CSE-ConnectionGUID: WCZJo/tuTKuWtelR0Dhl+g==
X-CSE-MsgGUID: qutLdoqjQLGAVwLSiWrRxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="165846281"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:32:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2YM2-0000000AnN8-1PJY;
	Wed, 09 Apr 2025 19:32:46 +0300
Date: Wed, 9 Apr 2025 19:32:46 +0300
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
Subject: Re: [PATCH v6 03/12] pinctrl: Add MAX7360 pinctrl driver
Message-ID: <Z_ahLqrMASFXbG5Q@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-3-7a2535876e39@bootlin.com>
 <D9276VFZ6GYJ.EO9D1V7C4JSI@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9276VFZ6GYJ.EO9D1V7C4JSI@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 05:03:02PM +0200, Mathieu Dubois-Briand wrote:
> On Wed Apr 9, 2025 at 4:55 PM CEST, Mathieu Dubois-Briand wrote:
> > Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
> > can be used either for GPIO, PWM or rotary encoder functionalities.

...

The all the rest of the driver LGTM, but the below.

> > +	device_set_of_node_from_dev(dev, dev->parent);
> 
> Ok, so this goes a bit against what I said I was going to do on my
> previous series, let me explain why. Same reasoning applies for both
> uses, in PWM and pinctrl drivers.
> 
> With my previous experiments, I came to the conclusion that:
> - Either we should use device_set_of_node_from_dev() as I do here.
> - Or we should add more subnodes in the device tree binding.

> - Also, copying the fwnode with device_set_node() was not possible, as
>   the kernel would then try to apply pinctrl on both the parent and
>   child device.

Hmm... I need to refresh my memory with the old discussions. Can you point out
to the problem statement with that approach?

> I previously said the second solution was probably the way to go, but I
> changed my mind for two reasons.
> 
> First having more subnodes in the device tree was already rejected in
> the past in the reviews of the dt-bindings patch. This do makes sense as
> it would be describing device internals (which should not be made in
> DT), just to ease one specific software implementation (which should
> also be avoided). So I believe this change would again be rejected.
> https://lore.kernel.org/lkml/58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.org/
> 
> But the the second reason is, doing
> 'git grep "device_set_of_node_from_dev.*parent"', I found several
> drivers using device_set_of_node_from_dev() for a similar need. Some of
> these uses are also for MFD child devices:
> - gpio-adp5585.c / pwm-adp5585.c,
> - pwm-ntxec.c,
> - max77620-regulator.c / max77620_thermal.c.
> 
> So, based on this, I believe using device_set_of_node_from_dev() in
> these two drivers is the way to go.

The problem with this solution is that, It's OF-centric. Which shouldn't be
done in a new code (and I don't see impediments to avoid it). Yes, it does
the right thing for the case, but only on OF systems. Note, fwnode is a list
of maximum of two entries (yeah, designed like that right now), can you utilise
that somehow?

-- 
With Best Regards,
Andy Shevchenko



