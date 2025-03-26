Return-Path: <linux-pwm+bounces-5290-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24325A71B09
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 16:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7568F16EFEC
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98331F4177;
	Wed, 26 Mar 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnLMm6aX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501D1E5218;
	Wed, 26 Mar 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004157; cv=none; b=ULD51/PApv+frwDl22E5+7/cTxZpHwdIyN2xB6nw9IIMUEPLggFtFCce3gT9n5oOoust9XxmeYwqI9vA6LGj9tFJDKruXG4jxLEZ4DKD/rcouCXTSjpX6NqyeIXOfRw6GLZosVk2rl1VePm3/z7oul7Sd8QpZ9lCH8F+ofg2pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004157; c=relaxed/simple;
	bh=4SiJKCGFVk/RgiIHAT0ZRcmzlDQVoYeyJE7nNH3ZfAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlmTO4fXu6oPmkRaD/MQ6gg7GsgF1AaAIUvMzxM/j+5T9Qr2oSH/E1JEo0NToQZ8H9v9e9UGCTUhXW3m4AjvxBXu1eFOKM1KriIZKTAXDF73qgDvZiBaFdz5kqWeWdkV8QeV9RPD+8eTlAxza6/Z7vXbZf2gIn1CinXlX1dE/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnLMm6aX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743004156; x=1774540156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4SiJKCGFVk/RgiIHAT0ZRcmzlDQVoYeyJE7nNH3ZfAY=;
  b=hnLMm6aX5dLGGCWzIjgKcOWyK7D1nJzkotgPb9toUL3sxuQlWp7BqPXi
   iuulnRM+jzihnqRqImwjMDSXmXrcVMgoP0RuRmMimc3t16kZbG7k5DrpY
   w7Fgq9oAGWMudFGI/JWa32bvhPsazbP33qM7PG0qYbiDHAmT3+zTZc7rx
   VP4L6BGeJSho8llIO44bc0lc3K983vLjq5DprBgxhIVSgHq7WU9GL72tz
   2tWMHvP+ZSC+nwjnK9CT6D3dstX4yKqzRnBliBcIrwKCmMEV5SF9sEn87
   GzvFGAhbq+sXdvCbhvb7UrDTYDUBlXsMsixL9AguSzw/DZDtZqye/Skse
   Q==;
X-CSE-ConnectionGUID: QUf+AjSQQ7e4F5VtNMMsIg==
X-CSE-MsgGUID: KRrNWFnlTn+R6l9HDFLajw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="31907559"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="31907559"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:49:15 -0700
X-CSE-ConnectionGUID: N0GZ6pBfQsSv9luc5yjGjQ==
X-CSE-MsgGUID: W5mgZRriTMe9FFedmg8r6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124613665"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:49:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1txT07-000000067d1-1VGB;
	Wed, 26 Mar 2025 17:49:07 +0200
Date: Wed, 26 Mar 2025 17:49:07 +0200
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
Message-ID: <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
 <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
 <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 03:44:28PM +0100, Mathieu Dubois-Briand wrote:
> On Tue Mar 25, 2025 at 4:56 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 25, 2025 at 03:37:29PM +0100, Mathieu Dubois-Briand wrote:
> > > On Thu Mar 20, 2025 at 11:48 AM CET, Andy Shevchenko wrote:
> > > > On Thu, Mar 20, 2025 at 08:50:00AM +0100, Uwe Kleine-König wrote:
> > > > > On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> > > > > > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.com wrote:

...

> > > > > > > +	chip = devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
> > > > > > 
> > > > > > This is quite worrying. The devm_ to parent makes a lot of assumptions that may
> > > > > > not be realised. If you really need this, it has to have a very good comment
> > > > > > explaining why and object lifetimes.
> > > > > 
> > > > > Pretty sure this is broken. This results for example in the device link
> > > > > being created on the parent. So if the pwm devices goes away a consumer
> > > > > might not notice (at least in the usual way). I guess this was done to
> > > > > ensure that #pwm-cells is parsed from the right dt node? If so, that
> > > > > needs a different adaption. That will probably involve calling
> > > > > device_set_of_node_from_dev().
> > > >
> > > > It's an MFD based driver, and MFD core cares about propagating fwnode by
> > > > default. I believe it should just work if we drop that '->parent' part.
> > > 
> > > Are you sure about that?
> >
> > Yes and no. If your DT looks like (pseudo code as I don't know
> > DTS syntax by heart):
> >
> > 	device: {
> > 		parent-property = value;
> > 		child0:
> > 			...
> > 		child1:
> > 			...
> > 	}
> >
> > the parent-property value is automatically accessible via fwnode API,
> > but I don't know what will happen to the cases when each of the children
> > has its own compatible string. This might be your case, but again,
> > I'm not an expert in DT.
> >
> 
> On my side:
> - Some MFD child do have a child node in the device tree, with an
>   associated compatible value. No problem for these, they do get correct
>   of_node/fwnode values pointing on the child device tree node.
> - Some MFD child do not have any node in the device tree, and for these,
>   they have to use properties from the parent (MFD) device tree node.
>   And here we do have some problems.
> 
> > > On my side it does not work if I just drop the '->parent', this is why I
> > > ended whit this (bad) pattern.
> >
> > > Now it does work if I do call device_set_of_node_from_dev() manually,
> >
> > AFAICT, this is wrong API to be called in the children. Are you talking about
> > parent code?
> >
> 
> I believe I cannot do it in the parent code, as I would need to do it
> after the call to devm_mfd_add_devices(), and so it might happen after
> the probe. I still tried to see how it behaved, and it looks like PWM
> core really did not expect to get an of_node assigned to the device
> after adding the PWM device.
> 
> So either I can do something in MFD core or in sub devices probe(), or I
> need to come with a different way to do things.
> 
> > > so it's definitely better. But I believe the MFD core is not propagating
> > > OF data, and I did not find where it would do that in the code. Yet it
> > > does something like this for ACPI in mfd_acpi_add_device(). Or maybe we
> > > do something bad in our MFD driver?
> >
> > ...or MFD needs something to have... Dunno.
> 
> I have something working with a very simple change in mfd-core.c, but
> I'm really not confident it won't break anything else. I wish I could
> get some insights from an MFD expert.
> 
> @@ -210,6 +210,8 @@ static int mfd_add_device(struct device *parent, int id,
>                 if (!pdev->dev.of_node)
>                         pr_warn("%s: Failed to locate of_node [id: %d]\n",
>                                 cell->name, platform_id);
> +       } else if (IS_ENABLED(CONFIG_OF) && parent->of_node) {
> +               device_set_of_node_from_dev(&pdev->dev, parent);

The use of this API is inappropriate here AFAICT. It drops the parent refcount
and on the second call to it you will have a warning from refcount library.

It should be as simple as device_set_node().

>         }

With that, the conditional becomes

	} else if (is_of_node(fwnode)) {
		device_set_node(&pdev->dev, fwnode);
	}

where fwnode is something like

	struct fwnode_handle *fwnode = dev_fwnode(parent);

-- 
With Best Regards,
Andy Shevchenko



