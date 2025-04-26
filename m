Return-Path: <linux-pwm+bounces-5721-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D2A9D8EC
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 09:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C6C463389
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 07:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6D20371F;
	Sat, 26 Apr 2025 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5l3cfcv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1D2236FB;
	Sat, 26 Apr 2025 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650908; cv=none; b=LnJ0XXBgN9/FTwcBYBMtMxChjhEEzGEjGWf28bEWHW28G6SMxRyMdzIB6uKZDcNI8svzRXHX4KHbNvOODUmaMqXTj3JTO8bF0E2fh8I5SIfzfeObYdtusXMS+BxvUkrI7cRTcdlG7/vycyivmsC4sVpMIG0c700ZJH/w98lTvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650908; c=relaxed/simple;
	bh=GP0K1Rv9ZXdHQPB5bmi50oLNLtVvYZGG8O2PcVpf/mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Noel+yuhC+wBIouF5iNL9z73B4NscaGf6iwaiiLkHpuSUxT2GELHsLh+Pd+J7yaZTzRKQ7jYQT1jj3oS8RtKfsYvgIhVMGWZQOoAjZeGsea9RHoGtLK8fICEkaMMET0vX27sxACI5q3kgYCJzEugreHFeOHDuOzGP3vBnRocIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5l3cfcv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745650907; x=1777186907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GP0K1Rv9ZXdHQPB5bmi50oLNLtVvYZGG8O2PcVpf/mg=;
  b=k5l3cfcv7wiw2SitjxMFDLQjo2i0DD2CwW9exphdvNUPtVcDwc48m9jP
   045xiwMxp0rsypAKq2O1cv1ZG0T0K1dkxJKmsiez3dCZozWM7oM/b7Pxj
   kHXO4HqB5a2i121bXJsBB7i0de7HADzqkYprez/vrvIHH1cpAV8weAYd1
   y/PJcmoZpH7IdoHApHDSb1wpFyGZy2/xBnCp1Q96EqIXrQtelSOT2BrSR
   oDcb5mIjPfOUGZvVvIlsXvNdwjcq6CUQe0j0Y912CV/BPQQEJHKRsR2uN
   mopqmsQ8zjiM8cBkMto4ajo8ORpWi4Y2AUWzq9uwEUZkQ78DIQqOsQ/VG
   w==;
X-CSE-ConnectionGUID: J9iDnp3MTfaFlGK7t9A12g==
X-CSE-MsgGUID: Yn2vQo1DTeeQZ0tMZBtVJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="51112568"
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="51112568"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 00:01:46 -0700
X-CSE-ConnectionGUID: UB3CB3T6QZWK5LSf3Zj6Ag==
X-CSE-MsgGUID: ALlMkpTIRLKP8WKzX6udoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="138238692"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Apr 2025 00:01:40 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8ZXe-0005lJ-18;
	Sat, 26 Apr 2025 07:01:38 +0000
Date: Sat, 26 Apr 2025 15:01:29 +0800
From: kernel test robot <lkp@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, lee@kernel.org,
	alexandre.torgue@foss.st.com, daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ukleinek@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jic23@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com, fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v5 3/7] clocksource: stm32-lptimer: add support for
 stm32mp25
Message-ID: <202504261456.aCATBoYN-lkp@intel.com>
References: <20250425124755.166193-4-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425124755.166193-4-fabrice.gasnier@foss.st.com>

Hi Fabrice,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on lee-leds/for-leds-next linus/master v6.15-rc3 next-20250424]
[cannot apply to atorgue-stm32/stm32-next lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabrice-Gasnier/dt-bindings-mfd-stm32-lptimer-add-support-for-stm32mp25/20250425-210409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20250425124755.166193-4-fabrice.gasnier%40foss.st.com
patch subject: [PATCH v5 3/7] clocksource: stm32-lptimer: add support for stm32mp25
config: arm-randconfig-003-20250426 (https://download.01.org/0day-ci/archive/20250426/202504261456.aCATBoYN-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504261456.aCATBoYN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504261456.aCATBoYN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-stm32-lp.c:57:6: warning: logical not is only applied to the left hand side of this bitwise operator [-Wlogical-not-parentheses]
      57 |         if (!val & STM32_LPTIM_ENABLE) {
         |             ^    ~
   drivers/clocksource/timer-stm32-lp.c:57:6: note: add parentheses after the '!' to evaluate the bitwise operator first
      57 |         if (!val & STM32_LPTIM_ENABLE) {
         |             ^                        
         |              (                       )
   drivers/clocksource/timer-stm32-lp.c:57:6: note: add parentheses around left hand side expression to silence this warning
      57 |         if (!val & STM32_LPTIM_ENABLE) {
         |             ^
         |             (   )
   1 warning generated.


vim +57 drivers/clocksource/timer-stm32-lp.c

    50	
    51	static int stm32mp25_clkevent_lp_set_evt(struct stm32_lp_private *priv, unsigned long evt)
    52	{
    53		int ret;
    54		u32 val;
    55	
    56		regmap_read(priv->reg, STM32_LPTIM_CR, &val);
  > 57		if (!val & STM32_LPTIM_ENABLE) {
    58			/* Enable LPTIMER to be able to write into IER and ARR registers */
    59			regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
    60			/*
    61			 * After setting the ENABLE bit, a delay of two counter clock cycles is needed
    62			 * before the LPTIM is actually enabled. For 32KHz rate, this makes approximately
    63			 * 62.5 micro-seconds, round it up.
    64			 */
    65			udelay(63);
    66		}
    67		/* set next event counter */
    68		regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
    69		/* enable ARR interrupt */
    70		regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
    71	
    72		/* Poll DIEROK and ARROK to ensure register access has completed */
    73		ret = regmap_read_poll_timeout_atomic(priv->reg, STM32_LPTIM_ISR, val,
    74						      (val & STM32_LPTIM_DIEROK_ARROK) ==
    75						      STM32_LPTIM_DIEROK_ARROK,
    76						      10, 500);
    77		if (ret) {
    78			dev_err(priv->dev, "access to LPTIM timed out\n");
    79			/* Disable LPTIMER */
    80			regmap_write(priv->reg, STM32_LPTIM_CR, 0);
    81			return ret;
    82		}
    83		/* Clear DIEROK and ARROK flags */
    84		regmap_write(priv->reg, STM32_LPTIM_ICR, STM32_LPTIM_DIEROKCF_ARROKCF);
    85	
    86		return 0;
    87	}
    88	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

