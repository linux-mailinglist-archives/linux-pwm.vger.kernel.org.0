Return-Path: <linux-pwm+bounces-4880-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB03A34EA0
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 20:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D97B16B045
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA524BBF7;
	Thu, 13 Feb 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHj0ALv5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D624BBE5;
	Thu, 13 Feb 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476083; cv=none; b=ZiiWdRH4F8TKOPDZz8uNZHWc7N8rRoULOf0IkQ3KcA6oWi0MxI+UmoXTNh1TFfT1TnDQQhDmHhgTU2MFoeHj3zTJQrTM84VKzsuWJFG3MuLWjAP+Ig4NwvRxdpj4m3tcGxOmr8UUuTMZce5V68rwLkw823Sj2xBdduqsn5jZuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476083; c=relaxed/simple;
	bh=RCUD+Q9T9tcD1uSXvocm0zwGRO1RWvGUFdHiL4dQOtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN/REiUZteAcC4EDicJumMUFvIJTVj8tGFdmDUMdspDE8MAkcpKJKN0fOn/q/HkMui6h16vd+bX5Z3Jeo8M2kMu5GXJnJIdzPCJipv4OCYSdzk5RoeLbGNrrJDTt4PTzUVp8Cmg5Uv8N5RQcb5NijGJQJ0Ec9uH59UJP1raHoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHj0ALv5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739476082; x=1771012082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCUD+Q9T9tcD1uSXvocm0zwGRO1RWvGUFdHiL4dQOtw=;
  b=hHj0ALv5YM9MPWoXhiJ7tERGl5SP11aY6ahkplExBhRfgReEqPLit35c
   8nb6rbLt1kTbGGdt1lmlOG4VfC8pGtydd3MY41dirfQcZPkHINiHx45+X
   n8TEbdG1GU/f3yIE2vKLoJUQyFKnbTvMunrr8z4IbTSGtcwrapMKBe0c5
   ozPfcned92slVHM/M9wQsszEKA2JdRzAjqU1bp2pLjtp5KHDLERBvX1e+
   l9gDLij4e8Sxaj/AVDHghKKZWyuhTd5bFQ2lFVYLXatkms0gZ3aLwEvcv
   Q5qBJMVkC3KkLFF31dkmmeHIMxRXeP4CSPeUIiDnuLY2k0M7yWmX5GPB0
   Q==;
X-CSE-ConnectionGUID: QRZ7lgnrTmm+rZvpEeOucw==
X-CSE-MsgGUID: ipDMYyOqSzqVMUg38r9nrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43037510"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43037510"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:48:01 -0800
X-CSE-ConnectionGUID: /5BcnfffQV61TtZZHcZjHQ==
X-CSE-MsgGUID: NwVPGn8aSIu+j1udnKdOIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113424310"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:47:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tifBi-0000000BGlw-1cYv;
	Thu, 13 Feb 2025 21:47:54 +0200
Date: Thu, 13 Feb 2025 21:47:54 +0200
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
Message-ID: <Z65MalVYafUvR7LH@smile.fi.intel.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <Z5eFGJspoGOINcG6@smile.fi.intel.com>
 <D7QHGB7D0VSG.X255SDU7DFOF@bootlin.com>
 <Z6y65SnrprvnpKEa@smile.fi.intel.com>
 <D7QLITNTXRUJ.3NA44E6PQMAUX@bootlin.com>
 <Z6zJljphfTuEhBTP@smile.fi.intel.com>
 <D7R9KGN6EMDM.1DCDL4P5RC23B@bootlin.com>
 <D7RD3K56C2CQ.1WGUSI809P246@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7RD3K56C2CQ.1WGUSI809P246@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 02:45:31PM +0100, Mathieu Dubois-Briand wrote:
> On Thu Feb 13, 2025 at 11:59 AM CET, Mathieu Dubois-Briand wrote:
> > On Wed Feb 12, 2025 at 5:17 PM CET, Andy Shevchenko wrote:
> > > On Wed, Feb 12, 2025 at 05:08:56PM +0100, Mathieu Dubois-Briand wrote:
> > > > On Wed Feb 12, 2025 at 4:14 PM CET, Andy Shevchenko wrote:
> > > > > On Wed, Feb 12, 2025 at 01:57:34PM +0100, Mathieu Dubois-Briand wrote:
> > > > > > On Mon Jan 27, 2025 at 2:07 PM CET, Andy Shevchenko wrote:
> > > > > > > On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Briand wrote:

...

> > > > > > > > +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> > > > > > > > +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> > > > > > > > +		return -ENODEV;
> > > > > > > > +	}
> > > > > > >
> > > > > > > This is not needed, it is already done in GPIOLIB core.
> > > > > > 
> > > > > > I believe this is still needed:
> > > > > > - For gpos, we need the gpio count to correctly set the partition
> > > > > >   between gpo and keypad columns in max7360_set_gpos_count().
> > > > >
> > > > > Shouldn't be that done somewhere in the GPIO valid mask initialisation?
> > > > >
> > > > > > - For gpios, we need the gpio count to setup the IRQs.
> > > > >
> > > > > Doesn't GPIOLIB parse the property before initializing the IRQ valid mask
> > > > > and other init callbacks?
> > > > 
> > > > No, I believe I have to register the IRQ before registering the GPIO, so
> > > > I can get the IRQ domain.
> > > > 
> > > > Right now I have something like:
> > > > 
> > > > irq_chip->num_irqs = ngpios;
> > > > devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), max7360_gpio->regmap,
> > > > irq, flags, 0, irq_chip, &irq_chip_data);
> > > > gpio_config.irq_domain = regmap_irq_get_domain(irq_chip_data);
> > > > devm_gpio_regmap_register(dev, &gpio_config);
> > > > 
> > > > Also, gpiolib will store ngpios in the gpio_chip structure, but while
> > > > using gpio-regmap, this structure is masked behind the opaque
> > > > gpio_regmap structure. So I believe there is no easy way to retrieve its
> > > > value.

Would it be needed in your driver ->probe() after all? (See also below)

> > > > This part of the code changed a lot, maybe it would be easier if I push
> > > > a new version of the series and we continue the discussion there?
> > >
> > > So, what seems need to be added is some flag to GPIO regmap configuration
> > > data structure and a code that is called after gpiochip_add_data() in
> > > gpio_regmap_register() to create a domain. This will solve the above issue
> > > and helps other drivers to get rid of potential duplication of
> > > devm_regmap_add_irq_chip_fwnode() calls.
> > >
> > > Have you researched this path?
> >
> > OK, so looking at the code, I believe it would need to:
> > - Add some flag in gpio_regmap_config structure, so
> >   gpio_regmap_register() creates a new IRQ domain.

Easy.

> > - Add a function allowing to retrieve this domain out of the gpio_regmap
> >   structure.

Easy, as there is an API available for regmaps, so it looks like one-liner.

> > - Allow to pass a domain in the regmap_irq_chip structure, so
> >   regmap_add_irq_chip_fwnode() use this domain instead of calling
> >   regmap_irq_create_domain().

You need this because of...? (Please, remind me what the obstacle is there
that requires this to be done)

> > - Make sure this domain is still populated with the IRQ data: number of
> >   IRQs, IRQ base but also a pointer on the regmap_irq_chip_data
> >   structure in .host_data. I believe this will be a bit tricky.

Hmm... But wouldn't gpio-regmap internals have all this information available?

> > - Add a function allowing to retrieve ngpio out of the
> >   gpio_regmap.gpio_chip structure, so it can be used for IRQ setup and
> >   other places of the driver.

I'm not sure where it can be needed.

> > I'm sorry, but I feel like this is a lot of changes to solve this point.
> > I've been thinking about it, and I can suggest a different solution.
> >
> > For gpios, I will remove the ngpios property of the device tree and use
> > a fixed value:
> > - For the today version of the chip, this is always 8.
> > - I a chip variant or a similar chip ever arise later with a different
> >   number of gpios, the fixed value can be set according to the
> >   "compatible" value.
> > - This removes any issue with the IRQ setup.
> >
> > For gpos, we have to keep ngpios, as it depends of the implementation on
> > the board. That means ngpios will be used:
> > - For the gpio chip configuration: we let gpiolib retrieve it from the
> >   device tree.
> > - In gpio-regmap reg_mask_xlate callback: I can add a function allowing
> >   to retrieve it from gpio_regmap.gpio_chip, as suggested above.
> > - In max7360_set_gpos_count() to validate the coherency between
> >   requested gpios and keypad columns and set the correct configuration
> >   on the chip:
> >   - I can also retrieve the value from gpio_regmap.gpio_chip, but that
> >     means the check is made after the call to
> >     devm_gpio_regmap_register().
> >   - Or I will still need to retrieve it using device_property_read_u32()
> >     here.
> >
> > How do you feel about this solution?
> 
> Actually there is an additional issue: today, relying on gpiolib to
> parse the "ngpios" property does not work with gpio-regmap.
> 
> The gpiochip_get_ngpios() function in gpiolib is called in
> gpiochip_add_data_with_key(), but when using gpio_regmap_register(),
> we first ensure ngpio is set correctly before calling anything.
> 
> Yet I believe this check can safely be removed, allowing the magic in
> gpiolib happen as expected.

Not really. I'm about to send a series to address this issue.
Please, test.

...

P.S.
Maybe it's time to send a new version based on this discussion even
if not finished / working, so we can see the exact issues we still have
and target them.

-- 
With Best Regards,
Andy Shevchenko



