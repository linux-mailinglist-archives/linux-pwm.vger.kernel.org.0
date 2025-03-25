Return-Path: <linux-pwm+bounces-5277-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86954A70558
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE663AF61F
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5C1AC891;
	Tue, 25 Mar 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiC0dqTQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A6191493;
	Tue, 25 Mar 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917293; cv=none; b=pNA9MPeeT5YdyFYbe+wE45sXW6MiYSdP2/NQ1aq94TrgcJsmo+WUpDIM/dC/VWrwyjCWoObJfwJCwTJsWYWzz+bGZVgHDR7bTiMDINsK7U7L5R48nvNUMTmCZ/zxIQQMw31aeCutT9WYF4x4BfQ62ZVRQHAYjTePMxoFG2y41SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917293; c=relaxed/simple;
	bh=0mbEID5ahHrKwR9jwh1G01FTCatcISBK/d1QAIR8hNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPxyDxa7OgjHgCDNF99GkSCEc2rckiasTbqvOtlCL9Llw1iGaK2wRgj6xwuolYyf/ixTo7y4tvBr/DmLAIihVDVckg2F/l6Y7ysz3jOd1vvKyHdSLeUH77/wQrOGB0DdcPXUPjFaf0IU3esTPmmtiTdPWbaZYCCPRdKl+DfJUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiC0dqTQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742917292; x=1774453292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0mbEID5ahHrKwR9jwh1G01FTCatcISBK/d1QAIR8hNI=;
  b=eiC0dqTQBAupSC8YqTR8+Kl6zYKKn0QbPRnKh/O4BTAqQQfhtqpL5CWj
   Jy+wUXq+j8yw47IDjeIeUUKsJF6wN8pL5xfwxRPPMDtxCvrNE9Xz1V8ss
   6Wav9u2rHN1QHIZlkZciBgG7BTu0F4TJdFUY/0FH/JESHQzfByUNL5SU1
   OGeAr1CRz0m37+CsU4OSmaJkOIVDKYv6w844W5BWaiY/QJc1aGerH5b6Q
   LysTjVBh5UENbSVfI70LAQTHziGFe092RmwkAUfm3bFKZsTLRzMC6CbNW
   DmyjGlW1efuo11FEdsIiFVn9RLI97nxExYXwK/889vYeGPmGfJDFtTUXL
   g==;
X-CSE-ConnectionGUID: yIRvxbfPT72FCGFBGrxhbQ==
X-CSE-MsgGUID: LMPQEY+8QI6SWXA/pTXNfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61563434"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="61563434"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:41:31 -0700
X-CSE-ConnectionGUID: eXX55xHSRGG72Mo/kqSWLQ==
X-CSE-MsgGUID: TiWJfMkNSAisIA4JV4fERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124885124"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:41:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tx6P4-00000005n4L-3k44;
	Tue, 25 Mar 2025 17:41:22 +0200
Date: Tue, 25 Mar 2025 17:41:22 +0200
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
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <Z-LOokj8h13IRSSo@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <D8PF2VNMJ0TC.396PL4OJTTBOU@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8PF2VNMJ0TC.396PL4OJTTBOU@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 03:29:18PM +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 19, 2025 at 12:18 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.com wrote:

...

> > > +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > > +					   struct pwm_device *pwm,
> > > +					   const struct pwm_waveform *wf,
> > > +					   void *_wfhw)
> >
> > I would expect other way around, i.e. naming with leading underscore(s) to be
> > private / local. Ditto for all similar cases.
> 
> I get the point, but the 2 existing drivers based on pwm_ops structure
> name it that way: drivers/pwm/pwm-axi-pwmgen.c and
> drivers/pwm/pwm-stm32.c.
> 
> Also, the parameter is mostly unusable as-is, as it is a void*, so I
> believe it also makes sense to have no underscore for the correctly
> casted one, that we will be using in the function body (wfhw).

It's all up to PWM maintainers, but I find this style a bit weird, sorry.
I only saw this in the macros, where it's kinda okay. In functions it's
something that needs an additional thinking and understanding the semantics
of the underscore.

...

> > > +static int max7360_pwm_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct pwm_chip *chip;
> > > +	struct regmap *regmap;
> > > +	int ret;
> > > +
> > > +	if (!dev->parent)
> > > +		return dev_err_probe(dev, -ENODEV, "no parent device\n");
> >
> > Why? Code most likely will fail on the regmap retrieval. Just do that first.
> >
> > > +	chip = devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
> >
> > This is quite worrying. The devm_ to parent makes a lot of assumptions that may
> > not be realised. If you really need this, it has to have a very good comment
> > explaining why and object lifetimes.
> 
> Thanks, I'm fixing this in this driver and similar code in keypad,
> rotary and pinctrl. More details in the child mail.

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko



