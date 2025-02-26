Return-Path: <linux-pwm+bounces-4997-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37123A4614F
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FDE189B7F5
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE5F21D5B6;
	Wed, 26 Feb 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgWYYnD3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FC1F8908;
	Wed, 26 Feb 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577939; cv=none; b=mrm4+56qCyb6yyW8//jQ3B5iNsl4U1kGi56pOMt1UVzH2ZTxiGy3aG5EJne6AKggYU4lyX5IVh/rGDDV/y7Svx51K8IOYV70mmUyJpniNncQwdkCAVdpqBHakwVi5TUBy1c/mP8upel+swZJIK2K2H3Q1L5zFazkz38dLiCgM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577939; c=relaxed/simple;
	bh=5Z4E6ng1tNXYID7Liza4dEBXbcEx4WGsS4h66Z54u8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5fEN8HiHm+bnjATafluG7kkPSdTW/PVrHi9q62LrDGVShfLo/Pc0hIQJhJIrfaizezHSk5cnP6AK14qqX05gn0dBfo5D9XW/vRzbMzN1/ugThG8Jyjx66/MSfnwp+9/x4u2NGmESah72uHypkKgcd3VJrvQNsgB1UY3kncJHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgWYYnD3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740577938; x=1772113938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Z4E6ng1tNXYID7Liza4dEBXbcEx4WGsS4h66Z54u8E=;
  b=hgWYYnD3ipGsoFL74dnsh720jOJMToRxazvHJyoYY+ZO3lqSAQ2ZyDJB
   cQN4ykoKmzITBdW1jEHCV+4YkbM9Dema8lJqFi7qXaYhgS6FCvfU+rFiA
   PVmGQlkVgOnzqTwHPRTWRqU3dlmD84ssMcNENwVwQ+flIoAfZFfxvbgyX
   o+Ei4odE5arwEbCHFhlk8kiS1k2degZK7/D7BIy5umwmp8Uxss8Wza8G0
   BPMTZrsSNSuuPVSiSM6WUPrquMJIkvHSF3RiFPn0A8ZR00YrGSBvtgEzm
   JaGEwFTCBI5f2uISFPS/mBAROqI5QT0cijVeRGQt9sw8kioUXUfaKlsOq
   w==;
X-CSE-ConnectionGUID: nyEbAfKwTPi/5npFNabbpQ==
X-CSE-MsgGUID: UjhTCPTET9CS3+Zf/Itvdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="66794088"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="66794088"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:52:17 -0800
X-CSE-ConnectionGUID: wZ+mC6ZCRI+N9nRsDy+ybw==
X-CSE-MsgGUID: glZ3Ut2tTcmzHLEetw8ZQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116521095"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:52:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tnHpZ-0000000FL5W-2COf;
	Wed, 26 Feb 2025 15:52:09 +0200
Date: Wed, 26 Feb 2025 15:52:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 06/10] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <Z78ciWeu_e7_04Yb@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-6-8a35c6dbb966@bootlin.com>
 <Z69eue2dV37vw61v@smile.fi.intel.com>
 <ef7b9c80-88f9-4985-814e-e58cd44a3611@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7b9c80-88f9-4985-814e-e58cd44a3611@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 01:18:16PM +0000, Mark Brown wrote:
> On Fri, Feb 14, 2025 at 05:18:17PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 14, 2025 at 12:49:56PM +0100, Mathieu Dubois-Briand wrote:
> 
> > > +	int ret, i;
> 
> > 	unsigned int i;
> > ?
> 
> If it's just an iterator it's idiomatic to use signed ints.  IIRC if it
> makes a difference to the code generation it's likely to be positive.

It depends on the subsystem, V4L2, for example, is strict to unsigned types
when they are unsigned. It also helps to catch some strange conditionals at
some point when one checks for negative value in the (incrementing) counter.

But I'm not insisting as you may notice by question mark used.

-- 
With Best Regards,
Andy Shevchenko



