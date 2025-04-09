Return-Path: <linux-pwm+bounces-5421-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2878A82BC1
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE1A4A13E8
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA7268FE5;
	Wed,  9 Apr 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az88w5tV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CB4C9D;
	Wed,  9 Apr 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214177; cv=none; b=CrKTotFEU/ZIEJ5L81FhIh8osGeb6Fse9THOiZcPniDKwO7J5xDjPT5Iq4XfMpuzsoTCEHr+RY/xOIWRW7ZnKz2ciT8BoUdx5T0gBmut3qlUQhZZbmwhkvXuuoi0EOX65wjZAWBRHQBcZVzidDpedDFcy3XSPQATDK4c8o2K6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214177; c=relaxed/simple;
	bh=Zs0jaTexTm2u6cUXt75+V1sMJtA/LRlBeeMT1No2U7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0BT3W9fY6KldHYqHdISh9FK7cAxgSCcRPQd5xOQPn2CDcmfnY6lJ6O3cAJ3pRVQUKk8IA5OnSTcRmb7sMR3QY+QYoNtlAc9cjfjgbBqpuBB7/s+pJR/JhCfn0nrHWKiCtej3D69iA5ztg0DehNqJHVCljB8vTj5quKfH2SfKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az88w5tV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744214175; x=1775750175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zs0jaTexTm2u6cUXt75+V1sMJtA/LRlBeeMT1No2U7o=;
  b=az88w5tVUbHieg1JukNOmRmK77rwzjl3kSHiWWLGuskPrwc9mC5nqI19
   q7BxJBdIOg8YlfyoCgudg3UlEsnaGDLg4/9iAjB/5NDcocHzsModV6/U2
   r+JBuH+bBwaiBI+VYHhXGfiHVqOOt0k67/oqgRmzgsTJYwI8XRdNZTkHT
   eCWjarvwMU/wk9Ces5oVuPQe1ejUUj7ksOQzxt0iujqSLWV3RiZ1XPnTe
   zolMYt0tc1JjaN6j7+G/25Z9ccItisnjMWKsse8TrS+ds2HBSIZJAoW7m
   xwUqEHQHHNUcjDjT3TDwEo3+XzAlkq33HSRPc1MG53P7ePjbBPUw3R21R
   Q==;
X-CSE-ConnectionGUID: O345ttWnTT+2GpEc1Y2zUg==
X-CSE-MsgGUID: 5RMYws5vRAmsLgx2ML88Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="44841472"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="44841472"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:56:14 -0700
X-CSE-ConnectionGUID: VvEk0XIxRtePac4orJ/hLQ==
X-CSE-MsgGUID: dLuw43uiR5SApZ5FV+Y8cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="159595494"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:56:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2XmY-0000000Amkj-3Ozw;
	Wed, 09 Apr 2025 18:56:06 +0300
Date: Wed, 9 Apr 2025 18:56:06 +0300
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
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <Z_aYlrjWE6-fdltT@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
 <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 06:38:33PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:19:27PM +0100, Mark Brown wrote:
> > On Wed, Apr 09, 2025 at 04:55:52PM +0200, Mathieu Dubois-Briand wrote:
> > > BUG() never returns, so code after it is unreachable: remove it.
> > 
> > BUG() can be compiled out, CONFIG_BUG.
> 
> Yes, and it's still has unreachable() there. So, this change is correct.
> See include/asm-generic/bug.h for the details of the implementation.
> And yes, if we have an architecture that does not do this way, it has to
> be fixed.

FWIW, I just have briefly checked the architectures and all of them include
asm-generic/bug.h independently on the configuration option, some of them
even define BUG() despite the configuration option (e.g. arc).

-- 
With Best Regards,
Andy Shevchenko



