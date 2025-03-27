Return-Path: <linux-pwm+bounces-5297-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F0A73CBE
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F7D189BF01
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF01219304;
	Thu, 27 Mar 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EC2KeTe0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271191A3150;
	Thu, 27 Mar 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097868; cv=none; b=Pgr3iveEk6Z3sgGBbmtDHwaOAQzCGUi+xgNhuCaCWtntLBEmT6REHfjIK7huH5AQZjuiQcWYNRIM574PpcN9Ck6bfdalJygoqly8Fxb9Q+WWYSdDNDpFpb4jAVenmW4HEgPOUHe/AneBHt1gYAh/xysYtR83H1DmqZrVALvxdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097868; c=relaxed/simple;
	bh=f2PsRAgdzR4JHXJadph0vjKwCZrGPH88BSO8haCZOm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTRRK/4dPZKz0EIGZKdj4vTNccwzFMIYAn0+EYKfXfVNmvstQGD6ep6czYrrj0UuL3CbUyothnUJYBOYFGD/fn9AMBv4X/H1lxKsW8RIAGEVOk3/vEGnRFMp3uwK+0GktWZuKygNaiFwCuCciWsRslAi9sUdDylSF+THwmJTb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EC2KeTe0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743097868; x=1774633868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f2PsRAgdzR4JHXJadph0vjKwCZrGPH88BSO8haCZOm8=;
  b=EC2KeTe0nN/ndqsBKUn1sP78TAlxXr50KEby2tECphTNu821K8UF+Tho
   KEP+KxwBGo/Cu2JYnKnEq6RHKD/xddWy+1HkMoDMS1/2FN9UBbsSbnkHX
   gAV9RRa+Cbs7JF6iDb4pJi3ORZkkrGGm//LdiNFtC44l2QL4vDalG5P5j
   jQAd37AcV6Mz+IIz3be0+exwvmstbi7yDkwW++y2uzSFOf5GvWZ+64mBO
   sF+Z8/DatEzsyUKKMfVvLIlyLyBDQ/R1dzobR39z8qUaim3wthKxd0YWO
   U7sYD4NLsg5n5aAH+MFknW22wwXEd05wEzX78dAZ4VKkKXD1xuch8UTrd
   A==;
X-CSE-ConnectionGUID: IlT8AxtLQ/ier2m6X3PZfw==
X-CSE-MsgGUID: /76LZRX1T+C57QHrX2vdfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55444925"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="55444925"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:51:05 -0700
X-CSE-ConnectionGUID: echudXxiQ+Glm9yuJflnIw==
X-CSE-MsgGUID: HIk6hO+DSACJcm0po8nPew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="125125538"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:50:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1txrNY-00000006VIQ-2ow1;
	Thu, 27 Mar 2025 19:50:56 +0200
Date: Thu, 27 Mar 2025 19:50:56 +0200
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
Message-ID: <Z-WQAC8Fc90C1Ax6@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
 <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
 <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
 <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
 <D8R4B2PKIWSU.2LWTN50YP7SMX@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8R4B2PKIWSU.2LWTN50YP7SMX@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 27, 2025 at 03:28:08PM +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 26, 2025 at 4:49 PM CET, Andy Shevchenko wrote:

> > The use of this API is inappropriate here AFAICT. It drops the parent refcount
> > and on the second call to it you will have a warning from refcount library.
> >
> > It should be as simple as device_set_node().
> >
> > >         }
> >
> > With that, the conditional becomes
> >
> > 	} else if (is_of_node(fwnode)) {
> > 		device_set_node(&pdev->dev, fwnode);
> > 	}
> >
> > where fwnode is something like
> >
> > 	struct fwnode_handle *fwnode = dev_fwnode(parent);
> 
> I tried to use device_set_node(), but then I got some other issue: as we
> now have several devices with the same firmware node, they all share the
> same properties. In particular, if we do use pinctrl- properties to
> apply some pinmmuxing, all devices will try to apply this pinmuxing and
> of course all but one will fail.
> 
> And this makes me think again about the whole thing, maybe copying the
> fwnode or of_node from the parent is not the way to go.
> 
> So today we rely on the parent node for four drivers:
> - keypad and rotary, just to ease a bit the parsing of some properties,
>   such as the keymap with matrix_keypad_build_keymap(). I can easily do
>   it another way.
> - PWM and pinctrl drivers, are a bit more complicated, as in both case
>   the device tree node associated with the device is used internally. In
>   one case to find the correct PWM device for PWM clients listed in the
>   device tree, in the other case to find the pinctrl device when
>   applying pinctrl described in the device tree.
> 
> So maybe I have to find a better way for have this association. One way
> would be to modify the device tree bindings to add a PWM and a pinctrl
> node, with their own compatible, so they are associated to the
> corresponding device. But maybe there is a better way to do it.

Okay, so the main question now, why do the device share their properties
to begin with? It can be done via fwnode graph or similar APIs (in case
it is _really_ needed).

-- 
With Best Regards,
Andy Shevchenko



