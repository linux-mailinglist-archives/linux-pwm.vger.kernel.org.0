Return-Path: <linux-pwm+bounces-4744-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9BA1D63E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 13:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E6E164039
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC271FF1DB;
	Mon, 27 Jan 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLfhTpD4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E71E868;
	Mon, 27 Jan 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982343; cv=none; b=ZxkRlIot5FVSZNWCt305wFpKe694ISTKL2uvejWJ/V/pT/JQs3duKbY2pztYlxLjHXfhlUE/XD6THzQyMhzV3TCdzcOGf81N4K6zznW+3Pd98P7GynPSwoMDCcXxD1ors93r3oF2y1x85R6kJw93zyVIuYKV2KHdqpoSgaOtIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982343; c=relaxed/simple;
	bh=VwEY5hofz3hPsMTdAq17aoEk6KmnInb9CnodmiEM7n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koy+9rjqC+UnNqvsHcS/ZMswGffWIY5lcHNDzJO9Ze4eQ+dh+dGBsK96wRmuyZBuK5lE2rXxTe4rFT1IzJKDo6SftWDcluoiKIqN7/mzdM5mCbn7Rqpd0ASA3TTLrWdNEEwugURzIReuGyCIChaI9d/OmjXF7z1Dst7fnxVPSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLfhTpD4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737982341; x=1769518341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VwEY5hofz3hPsMTdAq17aoEk6KmnInb9CnodmiEM7n8=;
  b=NLfhTpD46QHJ1V4/B02Zt5rFSe452yoLENcKad1Tm6fYdX/0fcLq9sTG
   /fNwMGEM2VwWxSe4WHuAMXP4A0xDB1zEfCZ/gTGCUTc7tpJREMFdeArKU
   FibQl6G/7xzfqPkqwj8CqixRlGTHhI3hrlIp4m7RudtOG76wUVjn358Ax
   WVPgC5pc20wuaxLa1mMEFhCOutBNhpXllMVQg4YTe9rlFiL+pALtUtfmW
   NiTPWoXv2y3v5XOQGDigUAwhx9rJjdcV8TO+qcv/pIUss4fTevfgHczDz
   YBKy80cX5rtRVoZ3E+3bMGbwLrXkyPSYqhMCB0d2Pa1F2ZHrbhdxzqrIK
   Q==;
X-CSE-ConnectionGUID: RqjR3WXFTpOouu/WB7/yXA==
X-CSE-MsgGUID: +01SxSZNShmrEcv4KLgN7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38542949"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38542949"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 04:52:16 -0800
X-CSE-ConnectionGUID: Zh6YqMVRToG7ucu5kOz5zA==
X-CSE-MsgGUID: mEr09hNiQXSkylplGZI0Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108868668"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 04:52:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tcOb2-00000005jDj-2cPu;
	Mon, 27 Jan 2025 14:52:08 +0200
Date: Mon, 27 Jan 2025 14:52:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z5eBeGhoBVVVUmDr@smile.fi.intel.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <CACRpkdb5rmUK06uW3M2Lsy4Wam8JvrjmGM83cJa-V3LZwTX9dg@mail.gmail.com>
 <D74G95A3DHG3.OD522T88GX83@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D74G95A3DHG3.OD522T88GX83@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 17, 2025 at 04:22:33PM +0100, Mathieu Dubois-Briand wrote:
> On Tue Jan 14, 2025 at 3:33 PM CET, Linus Walleij wrote:
> > On Mon, Jan 13, 2025 at 1:43 PM Mathieu Dubois-Briand
> > My most generic feedback is if you have looked at using
> > select GPIO_REGMAP for this driver?
> >
> > The regmap utility library is very helpful, look how other driver
> > selecting GPIO_REGMAP gets default implementations
> > from the library just git grep GPIO_REGMAP drivers/gpio/
> 
> I tried to switch to GPIO_REGMAP and I really like it overall, as it
> does simplify a lot the code. However, I identified two features that I
> was not able to port so far: the request()/free() callbacks and the
> interrupts.

You can easily extend the config to provide both if needed.
So, update gpio-regmap.c itself as a prerequisite.

> So for the request()/free() callbacks, I cannot add them anymore, as
> they are set on the gpio_chip structure, and this structure is hidden
> behind the gpio_regmap structure. I could easily modify the
> gpio_regmap_config structure and gpio_regmap_register() to allow to
> provide these callbacks, but is this acceptable? Or should I switch to a
> different way to prevent concurrent use of the same pin? I saw you
> mentioned the possibility of defining pin control.
> 
> On the IRQ side, before switching to GPIO_REGMAP, I was able to define
> the IRQ configuration using the irq member of the gpio_chip structure.
> This does create the IRQ domain for me in a quite straightforward way.
> Again, I will not be able to do that anymore, as the gpio_chip structure
> is hidden. 

Look how it's done in, e.g., drivers/gpio/gpio-104-idi-48.c.

It's pretty straightforward. You create and register an IRQ chip with
devm_regmap_add_irq_chip(). It creates a domain for you.

> I saw I can specify my own irq_domain in gpio_regmap_config, so that
> would be a way, but I was wondering if there is any way to have
> something as easy as previously.
> 
> I had a quick look at existing drivers using GPIO_REGMAP and providing
> IRQ support: I believe they are all using REGMAP_IRQ. And I believe I
> cannot use REGMAP_IRQ here, as if I understood correctly, I would need
> to have a register telling me exactly on which GPIO I have a pending
> interrupt and I don't have such a thing: all I know is there was an
> interrupt related to the GPIOs, and then I have to compare each GPIO
> with the previous known state to know which pin is affected.
> 
> Do you have any thought about this?

I briefly looked at the code of regmap IRQ and I don't see big impediments
for your case. So, you seems to have mask, unmask, and input registers.
What you most likely want to do is to use input as status (regmap IRQ
supports configuration without status registers).

What seems to be needed is the logic that uses previous state to handle a new
one. This is not only this chip that may need this type of handling, so it
will be beneficial for others that may be converted to use gpio-regmap.c.

So, I don't think we need full bypass of the GPIO IRQ chip through
gpio-regmap.c.

-- 
With Best Regards,
Andy Shevchenko



