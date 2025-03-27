Return-Path: <linux-pwm+bounces-5294-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A539A72C73
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 10:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734CC7A3BD8
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2B20D4EB;
	Thu, 27 Mar 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8bNwlQ8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB920CCC8;
	Thu, 27 Mar 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067867; cv=none; b=YFUsoVv/q58y7DpCqLXwsa30kxpTCaRyIblbQv6n25yM0MGYpAcN3O5X3YRNjWmssTFgBuJFWtjsEL20PgNFD5/QZev7HK3W6s5Arspo5nQJEV+yk5I2aW3I6rTojeaguFIyExrTFdPXeeV1wGUgTc/N1BNEaw89aIjLoZGZIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067867; c=relaxed/simple;
	bh=w+BMijukpB/O0GOdtIB+1reFKhvkbTf4TM5DXbHnt7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGqrqAQ4PadxXpmHJ81FrlKD6h4mMNM6YSfkLvG5v2UPBnHAEm+H23tdVEMelhQqN+HzwAjaDkqkt6ou5E+HkCYmRXinblrY3Zhcl42tXc8eK5RsxuDJp8c3sV1xeGomVCSO8nJ+LgGM/Y9KRG+2i5xlTjMpldC1Uk6vTkOw7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8bNwlQ8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743067865; x=1774603865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w+BMijukpB/O0GOdtIB+1reFKhvkbTf4TM5DXbHnt7s=;
  b=L8bNwlQ8akLPiMCPV9O45CUCsjSZVeablxs8kk7CcIPNygjoToQeBGHw
   K491Ow17e0cH953TqHFThqscHwT1yNZtGAi6qwG/i+biE0BWYAH/NdYdy
   R+9STvnI4kVQs5m25LmrG5oKPHu4wtUUK/W7AbXtpqVVNMjv9a9CcPvrZ
   6AnVFlbI0ZDRTgZ6QxAc9W4kA7wt6K0PoVvY5qq4V0gyUkhxVB/VfcLgq
   s14xSDDtH4ZRcNZP+Rr9jE2eDDBsrzKhs5POFtFNOT69/zLIRShAMXNjh
   deFcXLb4Mqp8tzwLThDariUo53UUWODxWR/j2iz0H3t4iRClZNsVcxWK5
   w==;
X-CSE-ConnectionGUID: L7QrxDHiTc2pyCd6JW/1XA==
X-CSE-MsgGUID: hLFavyLwRFCJzbW3lNAA8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55390666"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="55390666"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 02:31:04 -0700
X-CSE-ConnectionGUID: phccHWzfRbOow7iFdRYJyg==
X-CSE-MsgGUID: FN8WInPYTKizyJtu/QBexw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="148279106"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 02:31:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1txjZg-00000006LJT-3b0n;
	Thu, 27 Mar 2025 11:30:56 +0200
Date: Thu, 27 Mar 2025 11:30:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
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
Message-ID: <Z-Ua0Id99m5c1-up@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
 <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
 <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
 <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
 <b5los4qt7atc75phmurtswymgyeh4tojpu4nctmq6tcd45an6n@rjm3n53z3imx>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5los4qt7atc75phmurtswymgyeh4tojpu4nctmq6tcd45an6n@rjm3n53z3imx>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 06:46:41PM +0100, Uwe Kleine-König wrote:
> On Wed, Mar 26, 2025 at 05:49:07PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 26, 2025 at 03:44:28PM +0100, Mathieu Dubois-Briand wrote:
> > > On Tue Mar 25, 2025 at 4:56 PM CET, Andy Shevchenko wrote:
> > > > On Tue, Mar 25, 2025 at 03:37:29PM +0100, Mathieu Dubois-Briand wrote:
> > > > > On Thu Mar 20, 2025 at 11:48 AM CET, Andy Shevchenko wrote:
> > > > > > On Thu, Mar 20, 2025 at 08:50:00AM +0100, Uwe Kleine-König wrote:
> > > > > > > On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> > > > > > > > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.com wrote:

...

> > > > > > > > > +	chip = devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
> > > > > > > > 
> > > > > > > > This is quite worrying. The devm_ to parent makes a lot of assumptions that may
> > > > > > > > not be realised. If you really need this, it has to have a very good comment
> > > > > > > > explaining why and object lifetimes.
> > > > > > > 
> > > > > > > Pretty sure this is broken. This results for example in the device link
> > > > > > > being created on the parent. So if the pwm devices goes away a consumer
> > > > > > > might not notice (at least in the usual way). I guess this was done to
> > > > > > > ensure that #pwm-cells is parsed from the right dt node? If so, that
> > > > > > > needs a different adaption. That will probably involve calling
> > > > > > > device_set_of_node_from_dev().
> > > > > >
> > > > > > It's an MFD based driver, and MFD core cares about propagating fwnode by
> > > > > > default. I believe it should just work if we drop that '->parent' part.
> > > > > 
> > > > > Are you sure about that?
> > > >
> > > > Yes and no. If your DT looks like (pseudo code as I don't know
> > > > DTS syntax by heart):
> > > >
> > > > 	device: {
> > > > 		parent-property = value;
> > > > 		child0:
> > > > 			...
> > > > 		child1:
> > > > 			...
> > > > 	}
> > > >
> > > > the parent-property value is automatically accessible via fwnode API,
> > > > but I don't know what will happen to the cases when each of the children
> > > > has its own compatible string. This might be your case, but again,
> > > > I'm not an expert in DT.
> > > >
> > > 
> > > On my side:
> > > - Some MFD child do have a child node in the device tree, with an
> > >   associated compatible value. No problem for these, they do get correct
> > >   of_node/fwnode values pointing on the child device tree node.
> > > - Some MFD child do not have any node in the device tree, and for these,
> > >   they have to use properties from the parent (MFD) device tree node.
> > >   And here we do have some problems.
> > > 
> > > > > On my side it does not work if I just drop the '->parent', this is why I
> > > > > ended whit this (bad) pattern.
> > > >
> > > > > Now it does work if I do call device_set_of_node_from_dev() manually,
> > > >
> > > > AFAICT, this is wrong API to be called in the children. Are you talking about
> > > > parent code?
> > > >
> > > 
> > > I believe I cannot do it in the parent code, as I would need to do it
> > > after the call to devm_mfd_add_devices(), and so it might happen after
> > > the probe. I still tried to see how it behaved, and it looks like PWM
> > > core really did not expect to get an of_node assigned to the device
> > > after adding the PWM device.
> > > 
> > > So either I can do something in MFD core or in sub devices probe(), or I
> > > need to come with a different way to do things.
> > > 
> > > > > so it's definitely better. But I believe the MFD core is not propagating
> > > > > OF data, and I did not find where it would do that in the code. Yet it
> > > > > does something like this for ACPI in mfd_acpi_add_device(). Or maybe we
> > > > > do something bad in our MFD driver?
> > > >
> > > > ...or MFD needs something to have... Dunno.
> > > 
> > > I have something working with a very simple change in mfd-core.c, but
> > > I'm really not confident it won't break anything else. I wish I could
> > > get some insights from an MFD expert.
> > > 
> > > @@ -210,6 +210,8 @@ static int mfd_add_device(struct device *parent, int id,
> > >                 if (!pdev->dev.of_node)
> > >                         pr_warn("%s: Failed to locate of_node [id: %d]\n",
> > >                                 cell->name, platform_id);
> > > +       } else if (IS_ENABLED(CONFIG_OF) && parent->of_node) {
> > > +               device_set_of_node_from_dev(&pdev->dev, parent);
> > 
> > The use of this API is inappropriate here AFAICT. It drops the parent refcount
> > and on the second call to it you will have a warning from refcount library.
> 
> device_set_of_node_from_dev() does:
> 
> 	of_node_put(pdev->dev->of_node);
> 	pdev->dev->of_node = of_node_get(parent->of_node);
> 	pdev->dev->of_node_reused = true;
> 
> Note that pdev isn't the platform device associated with the parent
> device but the just allocated one representing the subdevice so
> pdev->dev->of_node is NULL and the parent refcount isn't dropped.

Ah, I stand corrected, thanks! Okay, so what it does basically, it drops
a reference for the child, and propagates the parent's node at the same time
bumping its reference count. Sounds legit, but this should be done equally for
DT, ACPI and software node cases.

> But I'm unsure if this is the right place to call it or if
> device_set_node() is indeed enough

This all about node reference counting. Whatever the correct choice for DT.
Anyway this sounds right to do for any of the system, but also note, that
this API is good when device node is not backed by the struct device,
otherwise, the struct device reference count covers the device node AFAIU.

TL;DR: What are the object lifetimes for struct device and struct device_node
(struct fwnode_handle)?

> (also I wonder if
> device_set_of_node_from_dev() should care for fwnode).
> I'll keep that question for someone else.

-- 
With Best Regards,
Andy Shevchenko



