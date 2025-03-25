Return-Path: <linux-pwm+bounces-5282-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FBA70652
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A818976FE
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC025D202;
	Tue, 25 Mar 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WN6t+BOI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712061DF72C;
	Tue, 25 Mar 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919097; cv=none; b=A0r4X17s0GScrJLcTtfdXZ4k29O1DeDVsJt2U54Tu2YhLNUB7qaZulDUcyakkhfSCaOPVaToD5N2DYh3QAtyMmACBZGAE+x2Qw/isgTVAS42uRmjfDbtZmd+cQbGnkt8VWDvj2/x8A2qr9Agke3MBjceQh91xYnu/cU10RWZ8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919097; c=relaxed/simple;
	bh=jyHGvmbnbdeWa7XIMdLa87iQlVfILdAjrFO/D3rTsrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2ZRd+MQK1sqeRMam5BlEaqXlBcoPbwPDNIEZFH4bU8l5dzS+rHtZYIn2KeOKwwvuU7rwRjYLixohkr3Wg0aKFtEKb89NJVGjtgfurUQ9J5BRaaS8C8UzvTCs+9T4LRwTX/c7jOXaNV98GYuZFW89OMvig1grAz4vdWJ3FmuCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WN6t+BOI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742919096; x=1774455096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jyHGvmbnbdeWa7XIMdLa87iQlVfILdAjrFO/D3rTsrc=;
  b=WN6t+BOI2ILhJi6g21x9bvapC6L7LHFFVgp1ERUNZqBBG31UH7CM7Cna
   nXVwhTAlH/H121NjLL0zxE4pGl6KZu052JmGkq6rNkiF7/ioOrkCqQylK
   2yM8SXDP03wUT8X/8nRFahSuG3aqcFuG2M0AijJ2uIoY3BfewBWCCqCKg
   IBng2AnBWsd39EgwKwcUFjeCPLSrIfAPZj8vkTvoKKBpBV3aeTbHsiYM6
   8Sbwd3GoyVz9koUeuHHXvGcQ4WCC2D927HGrENFfLBrZI+fcjI7cAFQYw
   jhwa42MK/jHxB06S5mfKjgJJHmNaG8+mhnLCfSV0HnN3YN4OL7xgjTpym
   w==;
X-CSE-ConnectionGUID: pSXzvV05Qn2zyXvPpkPkqQ==
X-CSE-MsgGUID: rFG9trlRRsSNTCZuSToYdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61700132"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="61700132"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:11:33 -0700
X-CSE-ConnectionGUID: PhWCsTrISQKn7IZdH+GpnA==
X-CSE-MsgGUID: 3rwQhTSyRQ+NR+krREQSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124891739"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:11:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tx6sA-00000005nW6-0GLN;
	Tue, 25 Mar 2025 18:11:26 +0200
Date: Tue, 25 Mar 2025 18:11:25 +0200
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
Subject: Re: [PATCH v5 10/11] input: misc: Add support for MAX7360 rotary
Message-ID: <Z-LVrdvKCBI5x2wy@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>
 <Z9q0eaxhecN0kGKI@smile.fi.intel.com>
 <D8PGXIKGXXK9.244NSFST6C0YD@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8PGXIKGXXK9.244NSFST6C0YD@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 04:56:20PM +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 19, 2025 at 1:11 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:26PM +0100, Mathieu Dubois-Briand wrote:

...

> > > +	int val;

Btw, this has to be unsigned to match the API.

> > > +	int ret;
> > > +
> > > +	ret = regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
> > > +	if (ret < 0) {
> > > +		dev_err(&max7360_rotary->input->dev,
> > > +			"Failed to read rotary counter\n");
> > > +		return IRQ_NONE;
> > > +	}

> > > +	input_report_rel(max7360_rotary->input, max7360_rotary->axis,
> > > +			 (int8_t)val);
> >
> > This is strange:
> > 1) why casting to begin with?
> > 2) why to C type and not kernel (s8) type?
> 
> I believe the cast is needed, as, while the value read with
> regmap_read() is stored in an int, the underlying value is indeed a
> signed 8 bits integer.
> 
> Without cast negative values will not be correct: -1 (0xFF) -> will be
> interpreted as 255 (0x000000FF).

With the above fix it makes sense, but it's not clear for the reader still.
What you want is most likely to call sign_extend32().

-- 
With Best Regards,
Andy Shevchenko



