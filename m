Return-Path: <linux-pwm+bounces-7851-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91574CF529E
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 19:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2173C302FCF1
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378032C943;
	Mon,  5 Jan 2026 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLRK8SXB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AF3246E4;
	Mon,  5 Jan 2026 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636435; cv=none; b=kAnpQYdz99asBymJZqeclFBdKTHDyyv9yvFg/NlvDMn8HV5zaunxt6bv3zsvKZl0m0DEs/LlKQ7KTxjvdAl23dt+cb81FHaGRqXyj+AzezdFvP6LwdGiuj8ywIBmZ4HoXIyRhvMbvfP6pl/iLVRH67IIKrvtKt4VQ+1xqQ5cnDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636435; c=relaxed/simple;
	bh=2Yd0U4QLroIAEUZF76pg3bSoONnirZrVb/TJ2EsEa04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tunw0LFOZTinVNyC3RSMG9frFmTWkvju+bpl/WS9oi2ULOUQVPE2RW7+o/g49S9iMB8I/NGuC8c0RyoHjBPowzN18HL+SKJORvj0GFVPrH5Qzszhpz9YuuBVD6KexvC9wejp15RScXYiu+mSgTcNokEBiDLZ0m8Mdm+ExMVfo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLRK8SXB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767636434; x=1799172434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Yd0U4QLroIAEUZF76pg3bSoONnirZrVb/TJ2EsEa04=;
  b=hLRK8SXB7IsdjGFgXXcH9THhbjbySzT0k2gc3h8nPxykAAkk/e1o2ZUI
   tpVhxPzFHeOkVx5sqxrcP5pApuv0tTWBLXWsrOaD4gHeO99j35bgM4RXB
   mNE9bwQwzJjLxOfmbFnR7YKoirpIhmrmMXCqmPRlwLkM3qhS/vJ5azXeE
   0rLPa3Spmq7E77+h83FksoMd1TArFWCrjw48c32lJCRkrvw91ZJ0husav
   RzLMhh4wrHgbZLZUfokzvTo08n0vmPjBN36oIFW5SHJ824Ur8h9OwwpI4
   Vt96AfNaNtKuG+tZsNms1apjtIXhXlUk160twRI5gNC8noBw33lMTy2Hm
   Q==;
X-CSE-ConnectionGUID: 03mHBy+zRUO28Gnrrf0k0w==
X-CSE-MsgGUID: 4wh7w8j8SEyqFLSGlbcuXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="91657351"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="91657351"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:07:12 -0800
X-CSE-ConnectionGUID: LwJsBZqbQv6o0BFQ9MpsVQ==
X-CSE-MsgGUID: iXkIrSOLQGGcJEwAm+a6wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="207003793"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:07:10 -0800
Date: Mon, 5 Jan 2026 20:07:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: ukleinek@kernel.org, heikki.krogerus@linux.intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: Use size macro
Message-ID: <aVv9y8RuA_LLm7GZ@smile.fi.intel.com>
References: <20260105091737.17280-1-raag.jadav@intel.com>
 <aVvpzK1fXqwms6Ct@smile.fi.intel.com>
 <aVvsFsLvNHuBWvUv@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVvsFsLvNHuBWvUv@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 05, 2026 at 05:51:34PM +0100, Raag Jadav wrote:
> On Mon, Jan 05, 2026 at 06:41:48PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 05, 2026 at 02:47:37PM +0530, Raag Jadav wrote:
> > > Use SZ_4K from size.h instead of hardcoding constant.
> > 
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you.
> 
> > OTOH, not sure if it's just an unneeded churn. What was the motivation to
> > create this patch?

> Your hard work[1] continues to motivate me :)

Ha-ha, but that one has a principal difference, i.e. there was _a custom macro_
*already*, which was replaced with a generic one. From the code perspective
it's not a churn as it kills the unneeded custom macro. Here the situation is
different, i.e. the explicit number 0x1000 is changed to SZ_4K. Just a line to
change, the added header inclusion and no other changes, so as a standalone one
it sounds to me like a churn.

> [1] https://lore.kernel.org/r/20250825163545.39303-3-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



