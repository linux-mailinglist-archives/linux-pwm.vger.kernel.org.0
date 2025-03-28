Return-Path: <linux-pwm+bounces-5302-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9AA749D8
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 13:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E2F171B2B
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13423214;
	Fri, 28 Mar 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNFq2f+k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A410FD;
	Fri, 28 Mar 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743165351; cv=none; b=Xv4gQ51A/VTrxZGD67gz3CwrEpHSJ+TX1J5Dy8I0x/7E2i1vHrCKq0vtHQBib8ZhS46dO+8JSyANqVxix7C2gqsgT7PvQDqHwYmfHGlQoXqupBjk7FSD1cekRJQxXc2QJj8CMbwTIjyezXSMblhn5/jWX5fsaWcGwbmf+mVjJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743165351; c=relaxed/simple;
	bh=kkYelAsLE09zWGPafoFLVzLQ6mWjrr5Yv4raVwT1e4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIP6Z7Ty6/tRdGGF7qDTzaK2YTULbg7SzJBk5FHHCaSulyaZ5hYBrpbER6WC+qK6ZXnD9NCv+y1a7JakCGm3Dq0inBNlyeXSZp9/I8PAHxDCFqHBhsTnnvHjTBT6QSh0rgvzDFw84a1N1lPod/ydH19I9eD/l8Hom+ejk0bdaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNFq2f+k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743165351; x=1774701351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kkYelAsLE09zWGPafoFLVzLQ6mWjrr5Yv4raVwT1e4w=;
  b=FNFq2f+k1jdb5HrJnFV/3FkXx0WbrEt0GD9qjZRRp9BLIbBJRLh4icX9
   eU6y8TA79q0DiwyVI4aRIc8kou5/sbF8d1fL/I5WDz8K3gAvp+igVcQri
   AQfXAQ1UC5na7ByhgjteS1zBdo9vzUxdiyDqffbTxv6WpJDLwOiubz0Mj
   8PFkVzX9L+FGvhCsEILKCtJn6ZQp2gdmiwxc2fcGQ2kcGNIqsvqvy4v/d
   LlQRll4xE9yiWUiHdUlmJEdpsgZbKk0EJSqZyQDe614OExjlWzhiQh7LB
   PG8TlCtHQwQkn7Lp21eZKF83d61KYA1gv8lJNLnBMwlSIpA7GXrdhtm7W
   w==;
X-CSE-ConnectionGUID: APqkOAVFStKn8qCFmX0Nig==
X-CSE-MsgGUID: aSEdZufRSVyg0JM0PEILwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44688454"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="44688454"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 05:35:50 -0700
X-CSE-ConnectionGUID: yX5I6lH4TxmyN5fRoWAAPA==
X-CSE-MsgGUID: MCHoUNYmRgW0SGW/R988RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="130488530"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 05:35:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ty8w0-00000006jqO-3YOp;
	Fri, 28 Mar 2025 14:35:40 +0200
Date: Fri, 28 Mar 2025 14:35:40 +0200
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
Message-ID: <Z-aXnHig0HgVOLK2@smile.fi.intel.com>
References: <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
 <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
 <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
 <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
 <D8R4B2PKIWSU.2LWTN50YP7SMX@bootlin.com>
 <Z-WQAC8Fc90C1Ax6@smile.fi.intel.com>
 <D8RQYJXP0KMK.3L8A8YVZKID89@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8RQYJXP0KMK.3L8A8YVZKID89@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 28, 2025 at 09:13:12AM +0100, Mathieu Dubois-Briand wrote:
> On Thu Mar 27, 2025 at 6:50 PM CET, Andy Shevchenko wrote:
> > On Thu, Mar 27, 2025 at 03:28:08PM +0100, Mathieu Dubois-Briand wrote:
> > > On Wed Mar 26, 2025 at 4:49 PM CET, Andy Shevchenko wrote:

...

> > > > The use of this API is inappropriate here AFAICT. It drops the parent refcount
> > > > and on the second call to it you will have a warning from refcount library.
> > > >
> > > > It should be as simple as device_set_node().
> > > >
> > > > >         }
> > > >
> > > > With that, the conditional becomes
> > > >
> > > > 	} else if (is_of_node(fwnode)) {
> > > > 		device_set_node(&pdev->dev, fwnode);
> > > > 	}
> > > >
> > > > where fwnode is something like
> > > >
> > > > 	struct fwnode_handle *fwnode = dev_fwnode(parent);
> > > 
> > > I tried to use device_set_node(), but then I got some other issue: as we
> > > now have several devices with the same firmware node, they all share the
> > > same properties. In particular, if we do use pinctrl- properties to
> > > apply some pinmmuxing, all devices will try to apply this pinmuxing and
> > > of course all but one will fail.
> > > 
> > > And this makes me think again about the whole thing, maybe copying the
> > > fwnode or of_node from the parent is not the way to go.
> > > 
> > > So today we rely on the parent node for four drivers:
> > > - keypad and rotary, just to ease a bit the parsing of some properties,
> > >   such as the keymap with matrix_keypad_build_keymap(). I can easily do
> > >   it another way.
> > > - PWM and pinctrl drivers, are a bit more complicated, as in both case
> > >   the device tree node associated with the device is used internally. In
> > >   one case to find the correct PWM device for PWM clients listed in the
> > >   device tree, in the other case to find the pinctrl device when
> > >   applying pinctrl described in the device tree.
> > > 
> > > So maybe I have to find a better way for have this association. One way
> > > would be to modify the device tree bindings to add a PWM and a pinctrl
> > > node, with their own compatible, so they are associated to the
> > > corresponding device. But maybe there is a better way to do it.
> >
> > Okay, so the main question now, why do the device share their properties
> > to begin with? It can be done via fwnode graph or similar APIs (in case
> > it is _really_ needed).
> 
> I wouldn't say the properties are shared: we have a single node in the
> device tree as this is just one device. But as we create several
> (software) devices in the MFD driver, we now have several devices linked
> with a single device tree node.
> 
> One solution would be to create more subnodes in the device tree, one
> for pinctrl and one for PWM, but this feels a bit like describing our
> software implementation in the device tree instead of describing the
> hardware.

I see. From my point of view the above is the correct approach, but
you need to ask DT experts, I'm not one of them.

-- 
With Best Regards,
Andy Shevchenko



