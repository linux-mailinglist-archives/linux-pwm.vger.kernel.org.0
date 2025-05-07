Return-Path: <linux-pwm+bounces-5845-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A194AAAEC20
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964469E3A48
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7528E565;
	Wed,  7 May 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fb6uFtKA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E228DEF7;
	Wed,  7 May 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645849; cv=none; b=LUwRNcIdi0cjiCaoHAzQKXiERJxkWj6OnqNadaXfFJCdWt1Bci+SrJxHHGPCOmeNAJvOmqgslHSFTqebyw8Yf30X3BlIch7kfvvGA2+88AVE5acYz27d8v+Xo9GH/lHUwV9/rOgYOPyAue9jyIJ8A1b8YIPgq31dn+qUI+X/uac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645849; c=relaxed/simple;
	bh=k7TU0yCd41PZirj6SFO+AJ5zKgUUEUjKl0PjUEVrBsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an9FjJcuW/DGFAiHFcAAjJ5R6HBKG3ZrXGz2NNLqal5XxDIg/83btvt9BTYC9lxz3N4kHx3usmjpK+UF34Sx3YNrJmzmrF4wA2yiXCDsOb92eB0gLXA3Kvhiao4tvEmvPEw8bBEuybV9vQKukhIq9srFNlmvbgPRqcTVc7G8+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fb6uFtKA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746645848; x=1778181848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k7TU0yCd41PZirj6SFO+AJ5zKgUUEUjKl0PjUEVrBsA=;
  b=Fb6uFtKApJvdJluNPwROaiBjysjOVLekm6R9xtAJZHkW2SPxgRzsSriv
   ynFjFnfRrQ2jprAogZkljVr9v7H6MThKl2Rxac/S85LYwpMVkQ2F7M7BE
   xwr5qXwD6AMfDVuZADGPc9FHo/FRGWFBwMHIHtnuFFcV6wc3x04XfkjBF
   LLmGm7WVjjopoHhUgzeQ36WK5EU0EMN9XYIgvU9x0PHKAJt5yfO5QXwkc
   SMoj7SfSRdMX5OaIIGtSWAb7RTn/1u5QX68SAdKOFJJc2GjKZwE5vAugP
   EjzNDXnMrFdLSTE7Hz7xqwhq9PhsdVQUTrB2niB50/N15RHzdYMAMs+jw
   w==;
X-CSE-ConnectionGUID: vuKIGn5mTAy7BUvY0NOjgg==
X-CSE-MsgGUID: dD6CkbxHSeWiyg54VcNRBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59795613"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="59795613"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:24:07 -0700
X-CSE-ConnectionGUID: wNGSX0kmQeWclpeNzUJwIA==
X-CSE-MsgGUID: Fyu05ThLSzOn/rC/l8/nrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="136448656"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 May 2025 12:24:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCkN7-0008z9-1t;
	Wed, 07 May 2025 19:24:01 +0000
Date: Thu, 8 May 2025 03:23:02 +0800
From: kernel test robot <lkp@intel.com>
To: Nylon Chen <nylon.chen@sifive.com>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v13 4/5] pwm: sifive: Fix rounding issues in apply and
 get_state functions
Message-ID: <202505080303.dBfU5YMS-lkp@intel.com>
References: <20250423090446.294846-5-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423090446.294846-5-nylon.chen@sifive.com>

Hi Nylon,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nylon-Chen/riscv-dts-sifive-unleashed-unmatched-Remove-PWM-controlled-LED-s-active-low-properties/20250423-165906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250423090446.294846-5-nylon.chen%40sifive.com
patch subject: [PATCH v13 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250508/202505080303.dBfU5YMS-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505080303.dBfU5YMS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505080303.dBfU5YMS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-sifive.c:161:2: warning: comparison of distinct pointer types ('typeof ((frac)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     161 |         do_div(frac, state->period);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:183:28: note: expanded from macro 'do_div'
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> drivers/pwm/pwm-sifive.c:161:2: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     161 |         do_div(frac, state->period);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:199:22: note: expanded from macro 'do_div'
     199 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:174:38: note: passing argument to parameter 'dividend' here
     174 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
>> drivers/pwm/pwm-sifive.c:161:2: warning: shift count >= width of type [-Wshift-count-overflow]
     161 |         do_div(frac, state->period);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:195:25: note: expanded from macro 'do_div'
     195 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   2 warnings and 1 error generated.


vim +161 drivers/pwm/pwm-sifive.c

   131	
   132	static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   133				    const struct pwm_state *state)
   134	{
   135		struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
   136		struct pwm_state cur_state;
   137		unsigned int duty_cycle;
   138		unsigned long long num;
   139		bool enabled;
   140		int ret = 0;
   141		u32 frac, inactive;
   142	
   143		if (state->polarity != PWM_POLARITY_NORMAL)
   144			return -EINVAL;
   145	
   146		cur_state = pwm->state;
   147		enabled = cur_state.enabled;
   148	
   149		duty_cycle = state->duty_cycle;
   150		if (!state->enabled)
   151			duty_cycle = 0;
   152	
   153		/*
   154		 * The problem of output producing mixed setting as mentioned at top,
   155		 * occurs here. To minimize the window for this problem, we are
   156		 * calculating the register values first and then writing them
   157		 * consecutively
   158		 */
   159		num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
   160		frac = num;
 > 161		do_div(frac, state->period);
   162		/* The hardware cannot generate a 0% duty cycle */
   163		frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
   164		inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
   165	
   166		mutex_lock(&ddata->lock);
   167		if (state->period != ddata->approx_period) {
   168			/*
   169			 * Don't let a 2nd user change the period underneath the 1st user.
   170			 * However if ddate->approx_period == 0 this is the first time we set
   171			 * any period, so let whoever gets here first set the period so other
   172			 * users who agree on the period won't fail.
   173			 */
   174			if (ddata->user_count != 1 && ddata->approx_period) {
   175				mutex_unlock(&ddata->lock);
   176				return -EBUSY;
   177			}
   178			ddata->approx_period = state->period;
   179			pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
   180		}
   181		mutex_unlock(&ddata->lock);
   182	
   183		/*
   184		 * If the PWM is enabled the clk is already on. So only enable it
   185		 * conditionally to have it on exactly once afterwards independent of
   186		 * the PWM state.
   187		 */
   188		if (!enabled) {
   189			ret = clk_enable(ddata->clk);
   190			if (ret) {
   191				dev_err(pwmchip_parent(chip), "Enable clk failed\n");
   192				return ret;
   193			}
   194		}
   195	
   196		writel(inactive, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
   197	
   198		if (!state->enabled)
   199			clk_disable(ddata->clk);
   200	
   201		return 0;
   202	}
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

