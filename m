Return-Path: <linux-pwm+bounces-5418-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF78A82B2D
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D8D9A76A5
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC4267B15;
	Wed,  9 Apr 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/kv3dM2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C9266B75;
	Wed,  9 Apr 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213130; cv=none; b=roHiE0M/0xOFzbeYZAKjVrLesNwWhW9GxpWdpErJ6LXhnK8YCTZIzxFJJAmnqByD7dGTtq523ONcUqDqPhqI2/aYNHkv2ryZHlU4w4vHY0PbIcjUDoNNYWgIrdkz3DtBZYLlHk6H/uOGq0Gk4odhx/BQPOiMzPA0RVR3ik3bY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213130; c=relaxed/simple;
	bh=OEqCSD/gc5UtOAlfiRZbCa1UqqIVnrd98DSDCQ//xB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP7w9LglgbIt7Rc1KWIrvu1BaqjYoIge0Dth3Fbcc4ufQGiii9JOzxA+evyWhsru528RClTFFYQ0sDQmQdsFEmz2unMF18wLCXcpix/2nqVewd1NepDcNfg9FjsTstD16h5NQIlUzncmWDgR/MtsXryHoz66MPHb2BTbDbwuaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/kv3dM2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744213129; x=1775749129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OEqCSD/gc5UtOAlfiRZbCa1UqqIVnrd98DSDCQ//xB4=;
  b=T/kv3dM20LFQrITOgh/gUO54DgZ326jy/HcXmTK9e6LG/IncUQD6qBXR
   7XvPWt2SeKp9bBL6HR0E66gyN5bn/43OJZva6OOX8SyF2mRVYLRBdNxqp
   Q23AO54BRZ710YAhDSncYu4v7nmy37wulNlyVrWrO6YSOplktLSU+yVqN
   J8RUt4sPkjnXv6r+6kRfbd5zrvBF/neF1f24IPxbE7jMX7JWirvK3a1ot
   YBJEpcUjojuPnLPRJ67Beabf/nvOM/ohCdfptsm5Cb98wWy9GLbXcEE4e
   GR4ayOkTZVXBRSg8sXF65dCfqrOb3R3pUImaWPryIKaKzfHbhTwwMl/5Z
   Q==;
X-CSE-ConnectionGUID: fvwFb7B2RreH46XY7FEpGg==
X-CSE-MsgGUID: wLAs7RwcQX6HqbNPsKoZ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="44839439"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="44839439"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:38:40 -0700
X-CSE-ConnectionGUID: gLBW+jaZSQecDrdh4mWKPg==
X-CSE-MsgGUID: rUyAvPFlSZ2S4wzx6W5/Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="159593984"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:38:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2XVZ-0000000AmTG-0DAb;
	Wed, 09 Apr 2025 18:38:33 +0300
Date: Wed, 9 Apr 2025 18:38:32 +0300
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
Message-ID: <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:19:27PM +0100, Mark Brown wrote:
> On Wed, Apr 09, 2025 at 04:55:52PM +0200, Mathieu Dubois-Briand wrote:
> > BUG() never returns, so code after it is unreachable: remove it.
> 
> BUG() can be compiled out, CONFIG_BUG.

Yes, and it's still has unreachable() there. So, this change is correct.
See include/asm-generic/bug.h for the details of the implementation.
And yes, if we have an architecture that does not do this way, it has to
be fixed.

-- 
With Best Regards,
Andy Shevchenko



