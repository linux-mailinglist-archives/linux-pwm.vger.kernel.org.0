Return-Path: <linux-pwm+bounces-6529-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79AAE818F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABA518849D3
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D7255E23;
	Wed, 25 Jun 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUgiRT1g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBA1917D6;
	Wed, 25 Jun 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851562; cv=none; b=igAtp2tGiTeptr25wFiWgisBMlv9KWOtttIanGdKEie898nkZwnUnO687xwsdj26TLhDBmJ16RS6bX7XzCj7IOF51rQQ1zF2YtJhetA7h5gb+Y56J/WGYuW428HAxt+MQVBpNuCG2R7CsrXk+vuqJRdko5ykODYB2QMFhUq6KYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851562; c=relaxed/simple;
	bh=eptLojQxQdUlXAUBOA63ivw2KKLIPdsNfg2GH6X+zq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXrSCEpL5vFTzHbDBgYA43/0R6ezx5fH+hh+00TXYCoeUIHtZ4SzsxzjalaUcyEUiwPxYCVBY/TuXTfbwfDpk2cjIAHnoOsTBBo2Ri9G5VZf2fNw05GMl7uA5Ga1uqxcAby1XB0np1E1nMrKjzmr1z5xCFeHBkz/aMDpK8lHKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUgiRT1g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750851561; x=1782387561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eptLojQxQdUlXAUBOA63ivw2KKLIPdsNfg2GH6X+zq8=;
  b=RUgiRT1ghCUzhIFGgatyiRmzDpCqNs1HfwJ3rUWdVTtmPkGbIqYHbIxv
   0kTNAWiVw/sEVixa8YB1Xyxh3sVAz7bnP4lqwTCTsI15y0DQJ3onVhH7I
   JqersncZoI7+XbM51IeW/+I2cOIDKl/h/6xS8JSykj+GOW2o57yLA59HI
   jeGhjld82r9trjnuu1fklhOiD67j/S7V7SBBoaBkD2A6IKuhtFT0pGnO9
   MkSd4bl29wN8lzYLu8vCMvgd3ifKmibJqBU3/XwQrJ3lndSX5oy2GATAD
   9tTCZrVFdqv1WXrb2faYrqiW+p0NMdFFEC5M/dn+3aP5dvW5BIUwzbCGm
   w==;
X-CSE-ConnectionGUID: zOBMBvrLTOSLzq11dB55yA==
X-CSE-MsgGUID: WgC5GiBkSL2/F7QTlaEGGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52233307"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52233307"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:39:18 -0700
X-CSE-ConnectionGUID: rY3v5lSSQQWMoiXvJGZ0oQ==
X-CSE-MsgGUID: DUCcOoA5RUGRChn8/fK7gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156590052"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:39:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uUOTB-00000009kwz-3YOd;
	Wed, 25 Jun 2025 14:39:13 +0300
Date: Wed, 25 Jun 2025 14:39:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v16 1/2] math64.h: provide rounddown_u64 variant for
 rounddown macro
Message-ID: <aFvf4c6Jp-cgBssA@smile.fi.intel.com>
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625000059.20040-1-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 02:00:38AM +0200, Christian Marangi wrote:
> There is currently a problem with the usage of rounddown() macro with
> u64 dividends. This causes compilation error on specific arch where
> 64-bit division is done on 32-bit system.
> 
> To be more specific GCC try to optimize the function and replace it
> with __umoddi3() but this is actually not compiled in the kernel.
> 
> Example:
> pwm-airoha.c:(.text+0x8f8): undefined reference to `__umoddi3'
> 
> To better handle this, introduce a variant of rounddown() macro,
> rounddown_u64() that can be used exactly for this scenario.
> 
> The new rounddown_u64() in math64.h uses do_div() to do the heavy work
> of handling internally all the magic for the 64-bit division on 32-bit
> (and indirectly fix the compilation error).

...

> static inline u64 roundup_u64(u64 x, u32 y)
>  {
>  	return DIV_U64_ROUND_UP(x, y) * y;
>  }

...

> +static inline u64 rounddown_u64(u64 x, u32 y)
> +{
> +	u64 tmp = x;
> +	return x - do_div(tmp, y);
> +}

Can it be implemented as above?

	return DIV_U64_ROUND_DOWN(x, y) * y;

(yes, it seems we are missing the DIV_U64_ROUND_DOWN() implementation).


-- 
With Best Regards,
Andy Shevchenko



