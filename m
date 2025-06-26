Return-Path: <linux-pwm+bounces-6537-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38ECAEA76F
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jun 2025 21:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE9F4E3A34
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jun 2025 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC80243946;
	Thu, 26 Jun 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxH9KXMX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D0253F3D;
	Thu, 26 Jun 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967686; cv=none; b=iz0qzDZx0WM+evulfZrQbt/DMGYE3GADeV/pnOy5Fvxwpi42mckSYEu4M4ONfk1xkZHncEDCVjiNDBzdBqqW2+BAYb3EA23BvtWr7yt/9gFWDcRV/i7bSAeApG+0rSdZSnr/VzUldHtKSydKeLNRJsAZJTjh3FQXWBU/I/pXKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967686; c=relaxed/simple;
	bh=gn5nOzWo+pttQt2eJniHL54WGy8M+aBF6Uz5ZI6bmU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B++i5ERMKSuYylhsPhvC/3ugqXyEP8vF6BhglzXtPssh+qbepbhffr0G5YPnXr5uKwYaUadvbroyDl45GhVEGZQpRwpNKHPZz/bA5MDjq5fPoxQSgyIlRd/SYfpuGkPSUTh3S6xULnnTvB8Tjp6q+w8xfWsQP5oDqjxlQzWyk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxH9KXMX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750967684; x=1782503684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gn5nOzWo+pttQt2eJniHL54WGy8M+aBF6Uz5ZI6bmU0=;
  b=RxH9KXMXUF1+86s0SDflHyjRRxaiuKFjDoY2AMqyuOcjNx2tOwucVkq4
   sw2wg8qHTlFu8LwQYhhMtbyw7HBm1bnRh8SaiQJYFBaaBb04T+ma7AyOu
   5mr6YKqOJz2V/XFNUVHtBhaf3DReMWYoCAqCsbbkM17miDaJx6GzhvpNL
   yP0J4E3sIVTyN7UNuEnO51zDQvogAELxDo75vM3tXrDtBJCCNyGE8JbuN
   yocfkVX9t4/Kca4qPv342/7YsduPQ0Ph5gEp0flBnD4YT6/e3ZyjUs+r3
   iNGRCd5DRBHkTm9b1yw7MHBAwgOzdiCnBO+7Niar5keUkhMRndsYhWrcj
   w==;
X-CSE-ConnectionGUID: 80DO3NzjSlmWx/hJrW93fA==
X-CSE-MsgGUID: La04SnysRXy1NzCVm4Uwrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53149660"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53149660"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 12:54:43 -0700
X-CSE-ConnectionGUID: C3BdmoQfSdyGc+OqHqcbWw==
X-CSE-MsgGUID: RwyhP4apQXaKfopC3tG8Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="157178658"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2025 12:54:42 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUsgA-000VV0-1k;
	Thu, 26 Jun 2025 19:54:38 +0000
Date: Fri, 27 Jun 2025 03:54:20 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v17] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202506270344.Sx9MtDt4-lkp@intel.com>
References: <20250625194919.94214-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625194919.94214-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc3 next-20250626]
[cannot apply to thierry-reding-pwm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/pwm-airoha-Add-support-for-EN7581-SoC/20250626-035111
base:   linus/master
patch link:    https://lore.kernel.org/r/20250625194919.94214-1-ansuelsmth%40gmail.com
patch subject: [PATCH v17] pwm: airoha: Add support for EN7581 SoC
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250627/202506270344.Sx9MtDt4-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506270344.Sx9MtDt4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506270344.Sx9MtDt4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-airoha.c:498:6: warning: variable 'period_ns' is uninitialized when used here [-Wuninitialized]
     498 |         if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
         |             ^~~~~~~~~
   drivers/pwm/pwm-airoha.c:486:15: note: initialize the variable 'period_ns' to silence this warning
     486 |         u32 period_ns, duty_ns;
         |                      ^
         |                       = 0
   1 warning generated.


vim +/period_ns +498 drivers/pwm/pwm-airoha.c

   480	
   481	static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   482				    const struct pwm_state *state)
   483	{
   484		struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
   485		u32 period_ticks, duty_ticks;
   486		u32 period_ns, duty_ns;
   487	
   488		if (!state->enabled) {
   489			airoha_pwm_disable(pc, pwm);
   490			return 0;
   491		}
   492	
   493		/* Only normal polarity is supported */
   494		if (state->polarity == PWM_POLARITY_INVERSED)
   495			return -EINVAL;
   496	
   497		/* Exit early if period is less than minimum supported */
 > 498		if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
   499			return -EINVAL;
   500	
   501		/* Clamp period to MAX supported value */
   502		if (state->period > AIROHA_PWM_PERIOD_MAX_NS)
   503			period_ns = AIROHA_PWM_PERIOD_MAX_NS;
   504		else
   505			period_ns = state->period;
   506	
   507		/* Validate duty to configured period */
   508		if (state->duty_cycle > period_ns)
   509			duty_ns = period_ns;
   510		else
   511			duty_ns = state->duty_cycle;
   512	
   513		/*
   514		 * Period goes at 4ns step, normalize it to check if we can
   515		 * share a generator.
   516		 */
   517		period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
   518	
   519		/*
   520		 * Duty is divided in 255 segment, normalize it to check if we
   521		 * can share a generator.
   522		 */
   523		duty_ns = DIV_U64_ROUND_UP(duty_ns * AIROHA_PWM_DUTY_FULL,
   524					   AIROHA_PWM_DUTY_FULL);
   525	
   526		/* Convert ns to ticks */
   527		period_ticks = airoha_pwm_get_period_ticks_from_ns(period_ns);
   528		duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
   529	
   530		return airoha_pwm_config(pc, pwm, period_ticks, duty_ticks);
   531	}
   532	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

