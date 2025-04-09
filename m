Return-Path: <linux-pwm+bounces-5422-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD78A82BDB
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5A1177DD2
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BE1C3F0C;
	Wed,  9 Apr 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUU/TICQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94E1AF0AF;
	Wed,  9 Apr 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214435; cv=none; b=t3XvN61gNdhPCXzuQQMMMa+43vspzKdf9bqtxK7QQqBD2XjC739D7k/sbMPCuUiH9cna+z82c0ZokxZ155k2Hjp/WHeTfIa+gwq3pt8TFfK5qoZS5iqMD3fo1A/FCfB3QISNKpL9YoShlZnhiaZsxEZLY5QQFfp6m4bYhlvt7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214435; c=relaxed/simple;
	bh=uMKu+jFYPg96rqO8KN7gZyvKhno3jI10KclYtsC1aKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAy9G6fzq6Eljxhurc9bHWSetH1skvy2Pt4W26577Ge5vgkI1gebPKiPHZTfqth66ItoGezVxfgr4oj147s4q4DKLfMuvHTivL2LS4pXLMBtpRsb7rBIL3qLcmHKMlu6YdD6HLTAhkrKoAPdTDmRei90B1SMmO2B8bfjfiuNXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUU/TICQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744214433; x=1775750433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMKu+jFYPg96rqO8KN7gZyvKhno3jI10KclYtsC1aKQ=;
  b=bUU/TICQJOcEGKRV/B0u2vAEJn45Wl7Ii03Woj7Era/9dUHAj80QTG/6
   vAKO6mrL/0+mnSk+MX+tbqXBoMn3G+IVWIEh7jeAvlss8rDZ3fu2yrjbY
   Ge7Wh/yyEDFzobFzNwbXGf1LPK1frEE61bJjG4HprKbrtymgDA5IEKJ3Q
   Y0LS53wceGGkP7yXfG0BR1YpQJol9wVoJm4wCe+xPrANw9Bf80f1tcI07
   9DiEQbyaQZvcbPl1e22h2byvILVFZXlGcjUQ0ef1oFexY0jP617FIk5Or
   LhbSSlMqhguoEB0WqMUB4uAFNntqAkMnakH9rUvYNxYdN9v4kvHAxQeqv
   Q==;
X-CSE-ConnectionGUID: d4g4DevrTi6nITvsL5mFEA==
X-CSE-MsgGUID: KMdxu9A4SyKSiWkQq126xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57069910"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="57069910"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:00:32 -0700
X-CSE-ConnectionGUID: M6haKlFeT6mLpHo/o0g4oQ==
X-CSE-MsgGUID: YEcl2JY6RJ+PfT5TKRRWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="159614553"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:00:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2Xqi-0000000Amra-49ph;
	Wed, 09 Apr 2025 19:00:24 +0300
Date: Wed, 9 Apr 2025 19:00:24 +0300
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
Message-ID: <Z_aZmJxPwIBgcwhG@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
 <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
 <7126e672-a829-489e-a0c0-8d6d64a8b2f4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7126e672-a829-489e-a0c0-8d6d64a8b2f4@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:46:04PM +0100, Mark Brown wrote:
> On Wed, Apr 09, 2025 at 06:38:32PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 09, 2025 at 04:19:27PM +0100, Mark Brown wrote:
> 
> > > BUG() can be compiled out, CONFIG_BUG.
> 
> > Yes, and it's still has unreachable() there. So, this change is correct.
> > See include/asm-generic/bug.h for the details of the implementation.
> > And yes, if we have an architecture that does not do this way, it has to
> > be fixed.
> 
> unreachable() just annotates things, AFAICT it doesn't actually
> guarantee to do anything in particular if the annotation turns out to be
> incorrect.

I;m not sure I follow. unreachable is a wrapper on top of
__builtin_unreachable() which is intrinsic of the compiler.

https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005funreachable

-- 
With Best Regards,
Andy Shevchenko



