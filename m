Return-Path: <linux-pwm+bounces-5426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85162A82CC4
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8621519E3BD6
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20A26FD99;
	Wed,  9 Apr 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBQnK7mI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76521B6CE4;
	Wed,  9 Apr 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217153; cv=none; b=iYalrhBD4rBZQVeyCaDYMnRVkL6Wyqus62HXviEgjgLdvxkx+MIjC3oCPRrXvbiOWbvev1iQAl+Qd1Xr++EMEn4JVT1ghrP/PnNNAUsXXA0Y9VR30B4KN7w5GJB5NuSwzZbiZeyRKaafdlqZuvAIXQKfkqFCIRXjphYr1fZHJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217153; c=relaxed/simple;
	bh=K9WyzzagnEdcl+3DhOzX2KAFo60shCila3x7+THI/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+209xxHfcP1LaBtWmYxaaMsOMQpPYDcaoEBP/CP051GsKl2l83NYbzbo1gOcZBQrVxxcVCA0MeDMBj3dhNeGl0YzmfkMwvIQR+r+FBFvh//FbxzQ1BXsJkY73X84Mb2ywGg7VUvTXwjs/LRWo3Uc2nBMC78BSNTrxCmyKmHJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBQnK7mI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744217152; x=1775753152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K9WyzzagnEdcl+3DhOzX2KAFo60shCila3x7+THI/NE=;
  b=XBQnK7mILkikqZ36OPMg24i1yUmjPhBCPGdz4mGfRTdUjbmpVeKg9n5g
   9r4pJBBwFl1/FL8hZpSJhjRSymDSkMNOwl5eURnQtN+bLJWJg7NLgLvvF
   91AuNW2KoAmhRzrZ9ZqGP76iOnY8wHaI86puN4Tl8toKDXBlO9sZpN882
   xR1gaoJieVsTcE4T7C5lO5iuwfB3uzJHSJCR8So+sgnOS36Xq7kkLDd2t
   GVYJw0daFGBUy7l6arq202TvA5qOwfZQxtKmOBE2nXfyL/SkOMuazV5uz
   nojkorID4OK22OkyzVkBqW9eHSTspycZ8zaln6S6Yd4mkI91hTmfEg0ku
   Q==;
X-CSE-ConnectionGUID: hUimHb0wRK+r+G/Ofo/B5Q==
X-CSE-MsgGUID: 0nkleIDbT0Cr2XxVia2YYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56339704"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56339704"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:45:50 -0700
X-CSE-ConnectionGUID: HrnI8cC/QxClvv8SqBAUiw==
X-CSE-MsgGUID: MMc2hgPWSBmMQ7y+zMvtgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128377391"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:45:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2YYY-0000000AnZS-2PMy;
	Wed, 09 Apr 2025 19:45:42 +0300
Date: Wed, 9 Apr 2025 19:45:42 +0300
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
Message-ID: <Z_akNogB_TkXcS37@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
 <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
 <7126e672-a829-489e-a0c0-8d6d64a8b2f4@sirena.org.uk>
 <Z_aZmJxPwIBgcwhG@smile.fi.intel.com>
 <28982424-d425-47c3-b910-58c787e13510@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28982424-d425-47c3-b910-58c787e13510@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 05:32:55PM +0100, Mark Brown wrote:
> On Wed, Apr 09, 2025 at 07:00:24PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 09, 2025 at 04:46:04PM +0100, Mark Brown wrote:
> 
> > > unreachable() just annotates things, AFAICT it doesn't actually
> > > guarantee to do anything in particular if the annotation turns out to be
> > > incorrect.
> 
> > I;m not sure I follow. unreachable is a wrapper on top of
> > __builtin_unreachable() which is intrinsic of the compiler.
> 
> > https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005funreachable
> 
> That just says that the program is undefined if we get to the
> __builtin_undefined() and documents some behaviour around warnings.  One
> example of undefined behaviour would be doing nothing.

Theoretically yes, practically return after a BUG() makes no sense. Note,
that compiler effectively removes 'goto exit;' here (that's also mentioned
in the documentation independently on the control flow behaviour), so
I don't know what you expect from it.

-- 
With Best Regards,
Andy Shevchenko



