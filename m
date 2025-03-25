Return-Path: <linux-pwm+bounces-5280-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269AAA705BA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AC4188E1DA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55E2561DF;
	Tue, 25 Mar 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOiqOI5i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A3255E32;
	Tue, 25 Mar 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918234; cv=none; b=B5to76oGedb/hvEcyvWqCmrq2/oztTvyrPVGZhqnyg3fc+LhFRivkJv/0R0PQFjD5x9esjzh8r21/YKqZK9Gg+y6cTGtbqiMg5JDFXjM/g/HwKZhKY8hZm3GmbMzdD2boq8atIW52e2lvTnBnPtdIWUiH4lnUVPZDdWJ43AOJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918234; c=relaxed/simple;
	bh=Ieg0O1UliTfBkQFmqf9idM/b2XHLPdbmep+cn3VQ98A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N57ct10OC9a2e1ihCp8KR+AMaTThrvQ01TJUuQnSmfJXCPZjsn1yBQFh8L+m6MBrgszSyfIQqn7BWSk+7ohZPVmgQyD3DQ3IHp1YsZBajQV6Eb6dQQtM1MRrU4Vdgi9HIow52DjBADp6aRTguxW+X9ZZQTeV0i0vbhVAVPWAAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOiqOI5i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742918233; x=1774454233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ieg0O1UliTfBkQFmqf9idM/b2XHLPdbmep+cn3VQ98A=;
  b=WOiqOI5izcmpBptBGAIGXL3RCf5nlO0+R0wuAz0/96ELxSvXl77NZqjD
   sGbQ3nJh5Vsv+hcjJCAu2m6K5OMic+b191Kq0MjGylcSlR1Zz/tRj2WIl
   8PaHQgYx5ZFT4Zg3F2K33OzGZ7bjuo03vLjqdnDqBn6OT3klGfcdZSy/t
   fjDa8GUO1l0sH8+HFiGJgncqtbVxjE+ESkULKyYY6HvIfAQ0/+lLBK0jr
   u62VPpXSDqsfDLy33JRemupJKP77PF76VDL8I8HaoD/76xnKNIwGAw18i
   wXCvEjQ3emyIF3mjiKLlVm5ZRKrf9FnOU6BkQqeMKtfJRL/9cGZ0sd989
   A==;
X-CSE-ConnectionGUID: m0etwx+dRae7dibPLYUrsg==
X-CSE-MsgGUID: zodyqjKzTPiNmAsHPKu0lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44296262"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="44296262"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:57:11 -0700
X-CSE-ConnectionGUID: io6D8B0XRuCIqbvgsaotbw==
X-CSE-MsgGUID: d5KwaRjiSOW1Fd4Ralo1Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="129534324"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:57:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tx6eC-00000005nIJ-45YA;
	Tue, 25 Mar 2025 17:57:00 +0200
Date: Tue, 25 Mar 2025 17:57:00 +0200
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
Subject: Re: [PATCH v5 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z-LSTM48_u3FJLNZ@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-8-fb20baf97da0@bootlin.com>
 <Z9qviF1VeSYNvcPJ@smile.fi.intel.com>
 <D8PFFWYR3ASD.YEZIXPNVZS4I@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8PFFWYR3ASD.YEZIXPNVZS4I@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 03:46:20PM +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 19, 2025 at 12:50 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:24PM +0100, Mathieu Dubois-Briand wrote:

...

> > > +		/*
> > > +		 * Port GPIOs with interrupt-controller property: add IRQ
> > > +		 * controller.
> > > +		 */
> > > +		gpio_config.regmap_irq_flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
> >
> > But why is this being overridden? The DT or another firmware description has to
> > provide the correct settings, no?
> 
> Ok, thinking about it, yes, IRQF_TRIGGER_LOW shoud come from firmware
> description. But IRQF_ONESHOT and IRQF_SHARED should still come from
> here, no?

This is my view as well.

-- 
With Best Regards,
Andy Shevchenko



