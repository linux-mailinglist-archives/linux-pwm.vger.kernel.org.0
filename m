Return-Path: <linux-pwm+bounces-5815-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C137AA7484
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E020017BA42
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED41255F5E;
	Fri,  2 May 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMPXCZKV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B370830;
	Fri,  2 May 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195009; cv=none; b=GDGx2lGt/gJ699sFNaY+MthEsPCMciLfdv1L4r236WZTx86+LS/153l0KwJsogocHB7PQkePUYHyuzrIb04IIO5f6SwoHSTwpkYXiLwco+Rgu+YgLy8NT5bcpKJ+c/ZebBrNrsZaytkq0JLZcU3lutb4wk3nGFkjXRswr9Xh+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195009; c=relaxed/simple;
	bh=UE+HTAX8L03rDUiOBDCz+RRsBQJY1YMYvIyhl6gQwdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+U3Y+zVzXkcTWbLPTnsdJ0+m7sS6JfKlJoBsW4FEM4QUTBQxVSXEP0/7AASVWMpYST/zMtbxM2QXcnDTobHM4+VPuYbzMfGfzaLC2XyML3fhosYTCwswE52aLkjXMk4ON6BCt5yTpuqkcqsiMugU4qUecXtKSSHml+ObkYwtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMPXCZKV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746195007; x=1777731007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UE+HTAX8L03rDUiOBDCz+RRsBQJY1YMYvIyhl6gQwdo=;
  b=DMPXCZKVeviF2TeBpBd+ymtNSWBWjyZmsiLA17hQ1YRolwTSCM42v7t1
   cZQ0zTBz70u+gIgyJdu/F9RrDtjaUKGsy8j4hBaHtft3CtIiFLlJe2yrp
   BAiSBu4uK5VBJJ9HxLXF1flLFtP3SnQUqIenrgFX41EFyub97I3qR35Yi
   IMU7DC5zJC+ZAz7UHVmYtPXIhXjI+pnfdZyVbVsyEbtl3Sy3jneWKa4/B
   8wIcS2e2v1wTejSQYb1I8T+/WVmEByEo0kdxEORhB33iNnplxmlIBxzOp
   +Sc8z4m9kjTtwuZLhLAkIUpO8Sz/WfsXC25gKMZfGZVChNv/o64jvb2B2
   w==;
X-CSE-ConnectionGUID: +k7bcu7mR2KwE9WEbvTW2A==
X-CSE-MsgGUID: eX9HYA7YQFGfrv/TrEOnrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48015749"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48015749"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 07:10:06 -0700
X-CSE-ConnectionGUID: nfmX4pclRTa5g4djy3denA==
X-CSE-MsgGUID: dUCN4HZxQXOLbMFp1P4M1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134396166"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 07:10:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAr5S-00000002Dgq-2DDQ;
	Fri, 02 May 2025 17:09:58 +0300
Date: Fri, 2 May 2025 17:09:58 +0300
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
Subject: Re: [PATCH v7 10/11] input: misc: Add support for MAX7360 rotary
Message-ID: <aBTSNsCupbpAscwA@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-10-4e0608d0a7ff@bootlin.com>
 <aBSkCsw3GJ6RHeJV@smile.fi.intel.com>
 <D9LQ7NV1LJM9.F2GF0YEEDFEY@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9LQ7NV1LJM9.F2GF0YEEDFEY@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 02, 2025 at 03:58:04PM +0200, Mathieu Dubois-Briand wrote:
> On Fri May 2, 2025 at 12:52 PM CEST, Andy Shevchenko wrote:
> > On Mon, Apr 28, 2025 at 01:57:28PM +0200, Mathieu Dubois-Briand wrote:

...

> >> +				pos = max(0, (int)pos + steps);
> >
> > Please, no castings for min()/max()/clamp(). It diminishes the use of those
> > macros.
> 
> Sorry, I'm not sure to get the point. Should I use MIN_T() instead?

Are the second argument is compile-time constant? I don't think so. Hence no
use for MIN*()/MAX*(). First of all, try to answer to the Q: Why is the explicit
casting being used? The second Q: How can it be easily fixed without using _t()
variants of the macros?

-- 
With Best Regards,
Andy Shevchenko



