Return-Path: <linux-pwm+bounces-6528-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3DAE80CE
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E731889D8B
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646229E0E3;
	Wed, 25 Jun 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTKHHN38"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C12820D5;
	Wed, 25 Jun 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850325; cv=none; b=GEAWKy4If6zwSiQBPO5dtkbcZXefk5HndFFsLGRPBgZI204QIlRcJP7bWHYouO7H7ye7MT8J5WqUX4vjbM8ub/UyPRZtqRNkP4FFlHTU5KZXrIe0Ydt8ijU0S7CFLtmPCJqAVY87ZIi27JUBcAge+mxr/LXq4j2YQ9tfLRALHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850325; c=relaxed/simple;
	bh=2cn7y+Ptn7dugIKl4xG4EpXViME5U8PgqEVu9KF4wXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buC2S0dQx+KCIECSPdS9tX8tJcGuYTYzra3g7VZz9RkTVeWUa3idWwSVveZ182F7H6sDoqJ4T3gHWeVPlNpQfWKquEgcctiIu5G7JTKaumeJPV/1bRBjUX4xfu4F6pIbZ0flqEF4Eq3qmPNUBDekGiolbk6G8Po8hrZGjBdPvmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTKHHN38; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750850324; x=1782386324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2cn7y+Ptn7dugIKl4xG4EpXViME5U8PgqEVu9KF4wXc=;
  b=CTKHHN38/EcPDEC8w8miE2J+JNC6TuJq20m73V100Mh5TH7S/u2o20sC
   shcC1brHbP10wjLtyU8NCGcH4NA+HnbAptwXGEZH0FxCCs6tgi9c4xATk
   34+8XxMxr1uIGzc9owhUYL7MdssN5DfPIe4scQdVYl4geUpEE3S9dZzr1
   lbyIz7CXq9k8/KiX/xJCxOweQ0yz5Hc2UksgMJxjbplBhON5+FjQp4n3t
   IY8UwPrOXTHKCGyXphfi3Q6zD4UyVMYifi8ev50A+T9oSGOkOwGwVR/YP
   Li8fBqRIm+QaMUwmxPe3DelkjXjMa+JmpRjqOat4v1deNe1cMKrxp+nCF
   g==;
X-CSE-ConnectionGUID: O77rTMtCSz+BoGJNwiOExg==
X-CSE-MsgGUID: 9yRZ2otxSHmDmHLKZP0ExQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="78541952"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="78541952"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:18:43 -0700
X-CSE-ConnectionGUID: yGMeqNnjSqihUerMqeyvrA==
X-CSE-MsgGUID: XY4GYARRTOWK1VunocbUDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156221613"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:18:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uUO9G-00000009kfx-1Hy9;
	Wed, 25 Jun 2025 14:18:38 +0300
Date: Wed, 25 Jun 2025 14:18:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aFvbDdVdoroASlM6@smile.fi.intel.com>
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
 <20250625000059.20040-2-ansuelsmth@gmail.com>
 <dehsalp2za4i6jgod6ej6gqhestljo7qost66jzmql52n2zecp@imtgipg24lv5>
 <685ba7d9.df0a0220.e1b22.e6c2@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <685ba7d9.df0a0220.e1b22.e6c2@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 09:40:07AM +0200, Christian Marangi wrote:
> On Wed, Jun 25, 2025 at 09:24:33AM +0200, Uwe Kleine-König wrote:
> > On Wed, Jun 25, 2025 at 02:00:39AM +0200, Christian Marangi wrote:

...

> > > +	/*
> > > +	 * Period goes at 4ns step, normalize it to check if we can
> > > +	 * share a generator.
> > > +	 */
> > > +	period_ns = rounddown_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > 
> > I don't understand why you need that. If you clamp to
> > AIROHA_PWM_PERIOD_MAX_NS first, you don't need the (expensive) 64-bit
> > operation. If you compare using ticks instead of ns you don't even need
> > to round down, but just do the division that you end up doing anyhow.
> 
> Correct me if I'm wrong but 
> 
> #define NSEC_PER_SEC	1000000000L
> #define AIROHA_PWM_PERIOD_MAX_NS       (1 * NSEC_PER_SEC)
> 
> doesn't fit u32 so an u64 is needed.

I'm not sure what was the exact question, but u32 can hold up to 4*10^9,
this is just 1*10^9.

-- 
With Best Regards,
Andy Shevchenko



