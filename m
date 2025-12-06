Return-Path: <linux-pwm+bounces-7769-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8FCAA3D6
	for <lists+linux-pwm@lfdr.de>; Sat, 06 Dec 2025 11:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784C2316D3F8
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Dec 2025 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB72F25EF;
	Sat,  6 Dec 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLVUDwaa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C72E229F;
	Sat,  6 Dec 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765015857; cv=none; b=tp6jz2I1K0z39TVDOHN+Uda3pJGYaDjTmjGmojWQlq+ZBsEOYAnn4BIUW43nsDuhYs3ujegMzsOpZZJ4QAR+p6DVCbxv8D8LnkiTUmCYUV614cw8BtBFL6MjRrQwQbcZqqF2gfjTOeqk4WdhNxJSu5gGFm+1KsBRuoAvyXOTMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765015857; c=relaxed/simple;
	bh=x4LBu0tYO48O/Tw5dS2uZU4NXYDWzRICUMcCqyYY+Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oszalntYYZF/mdw9ztN5YLjIiKFXFpOIygmjGQkhcJ4hHun5OJnRr+ysfk/9PcxxvuEW3Wc2sUmdtLpHXsJ7zNOsh2dBw9KbTDukDAVCCze4jMm3MwsBonGVig+24KLL5Pg9mtId0IbWfnBf22cWprXwi7+7t3V1z6nmvTPbfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLVUDwaa; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765015856; x=1796551856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x4LBu0tYO48O/Tw5dS2uZU4NXYDWzRICUMcCqyYY+Dk=;
  b=LLVUDwaamvWwonIn+O4mbOsCA9QPPrT2ukskcwpw49tTnY6VntXQENJy
   WN5dmybh+vddoM+iORQsKJkAT+YC2ch8v02uCrndqKpbZhgynezS+Kz6F
   80yslJsKV1xuasxrRLkNQuqgHIJMS/1IvnmXCf3ZWBZs7Hw9q3TT+Zec+
   hZpyV4gew2O7FNJ1cdssNgv8vSdKMOV1qFb6qiDTAqpNtMg8atYZD6Eul
   gt1T2GCnKnGyBg0+CaXH9bf4JJGOm/mEd3ED95Zac/J6+5XKYF+YOi4Oa
   j/e4j1e+4J3WyW4tSHejVPD7BZrCjniUrMQfyKDIqCuwyeFu1sAbEKAyX
   Q==;
X-CSE-ConnectionGUID: e/kTevxaTEaArDVZU+NnqQ==
X-CSE-MsgGUID: ue91KKbTS1WYQeKYBUZSjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="89690827"
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="89690827"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 02:10:56 -0800
X-CSE-ConnectionGUID: woOwQDNxSwu5yms1MbLiDQ==
X-CSE-MsgGUID: LdZ8STCOT5qh+3sZ5KA2RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="199947346"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Dec 2025 02:10:51 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRpFZ-00000000G49-0VtD;
	Sat, 06 Dec 2025 10:10:49 +0000
Date: Sat, 6 Dec 2025 18:09:52 +0800
From: kernel test robot <lkp@intel.com>
To: dongxuyang@eswincomputing.com, ukleinek@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: Re: [PATCH 2/2] pwm: eswin: Add EIC7700 pwm driver
Message-ID: <202512061720.j31AsgM7-lkp@intel.com>
References: <20251205090509.1501-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205090509.1501-1-dongxuyang@eswincomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.18 next-20251205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dongxuyang-eswincomputing-com/dt-bindings-pwm-eswin-Add-EIC7700-pwm-controller/20251205-171328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251205090509.1501-1-dongxuyang%40eswincomputing.com
patch subject: [PATCH 2/2] pwm: eswin: Add EIC7700 pwm driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20251206/202512061720.j31AsgM7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251206/202512061720.j31AsgM7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512061720.j31AsgM7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-dwc-core.c: In function '__dwc_pwm_configure_timer':
>> drivers/pwm/pwm-dwc-core.c:54:43: warning: left shift count >= width of type [-Wshift-count-overflow]
      54 |                 if (tmp < 0 || tmp > (1UL << 32))
         |                                           ^~
   drivers/pwm/pwm-dwc-core.c:64:43: warning: left shift count >= width of type [-Wshift-count-overflow]
      64 |                 if (tmp < 0 || tmp > (1UL << 32))
         |                                           ^~


vim +54 drivers/pwm/pwm-dwc-core.c

    37	
    38	static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
    39					     struct pwm_device *pwm,
    40					     const struct pwm_state *state)
    41	{
    42		u64 tmp;
    43		u32 ctrl;
    44		u32 high;
    45		u32 low;
    46	
    47		if (dwc->pwm_0n100_enable) {
    48			/*
    49			 * Calculate width of low and high period in terms of input
    50			 * clock periods and check are the result within HW limits
    51			 * between 0 and 2^32 periods.
    52			 */
    53			tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
  > 54			if (tmp < 0 || tmp > (1UL << 32))
    55				return -ERANGE;
    56	
    57			if (pwm->args.polarity == PWM_POLARITY_INVERSED)
    58				high = tmp;
    59			else
    60				low = tmp;
    61	
    62			tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
    63						    dwc->clk_ns);
    64			if (tmp < 0 || tmp > (1UL << 32))
    65				return -ERANGE;
    66	
    67			if (pwm->args.polarity == PWM_POLARITY_INVERSED)
    68				low = tmp;
    69			else
    70				high = tmp;
    71		} else {
    72			/*
    73			 * Calculate width of low and high period in terms of input
    74			 * clock periods and check are the result within HW limits
    75			 * between 1 and 2^32 periods.
    76			 */
    77			tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
    78			if (tmp < 1 || tmp > (1ULL << 32))
    79				return -ERANGE;
    80			low = tmp - 1;
    81	
    82			tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
    83						    dwc->clk_ns);
    84			if (tmp < 1 || tmp > (1ULL << 32))
    85				return -ERANGE;
    86			high = tmp - 1;
    87		}
    88	
    89		/*
    90		 * Specification says timer usage flow is to disable timer, then
    91		 * program it followed by enable. It also says Load Count is loaded
    92		 * into timer after it is enabled - either after a disable or
    93		 * a reset. Based on measurements it happens also without disable
    94		 * whenever Load Count is updated. But follow the specification.
    95		 */
    96		__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
    97	
    98		/*
    99		 * Write Load Count and Load Count 2 registers. Former defines the
   100		 * width of low period and latter the width of high period in terms
   101		 * multiple of input clock periods:
   102		 * Width = ((Count + 1) * input clock period) or
   103		 * Width = (Count * input clock period) : supported 0% and 100%).
   104		 */
   105		dwc_pwm_writel(dwc, low, DWC_TIM_LD_CNT(pwm->hwpwm));
   106		dwc_pwm_writel(dwc, high, DWC_TIM_LD_CNT2(pwm->hwpwm));
   107	
   108		/*
   109		 * Set user-defined mode, timer reloads from Load Count registers
   110		 * when it counts down to 0.
   111		 * Set PWM mode, it makes output to toggle and width of low and high
   112		 * periods are set by Load Count registers.
   113		 */
   114		ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
   115		if (dwc->pwm_0n100_enable)
   116			ctrl |= DWC_TIM_CTRL_0N100PWM_EN;
   117	
   118		dwc_pwm_writel(dwc, ctrl, DWC_TIM_CTRL(pwm->hwpwm));
   119	
   120		/*
   121		 * Enable timer. Output starts from low period.
   122		 */
   123		__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
   124	
   125		return 0;
   126	}
   127	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

