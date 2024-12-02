Return-Path: <linux-pwm+bounces-4182-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1619E0383
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 14:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804A51610BE
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8282010E3;
	Mon,  2 Dec 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brYUzhj5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCF1FF7A0;
	Mon,  2 Dec 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146349; cv=none; b=c6EplLAwHKtdjIvSuw74PSZjNn9LPMDfaY6Mxat+6m5SmbFdLMZRopdC/If+QCNmYN98+chWHFstwkslZQXMB8Tp8FiUqdLwpflpdMPyw15LMQZkz/Do0O1pCeVHhL0pkZqVpodhs3NWpLSwCOXE85X2OkJZ93vHIPK4M1igS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146349; c=relaxed/simple;
	bh=CDxQ76K29ySxjy69TWob7M9xTmGbQtEA07UobbD25nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go47Ozf3zJ8bpaM7llVcU6fTu/EACvqwIDGcsqRjdFPAKTGJ5FCLXISCxOMiGqxLQ/cgxFKFfW7+4qOpZR4k1zN8yJz/SY/QZTEcb1DzmwP2zm5x5Vie/gr5Mb64ZUCsSX9JOkFm9qfVkGwi8xJErkXGD/irC0qpDfEKHjHCCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brYUzhj5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733146347; x=1764682347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CDxQ76K29ySxjy69TWob7M9xTmGbQtEA07UobbD25nc=;
  b=brYUzhj5QGfPRW0bCNR+iRfZpDrVYvGj0/8DIU52y7YDIWc2QgdvV2jq
   aYhneN5LZuyS9UknKFxVB5X8t5NeY82zbX+qQid12x99tdUbzD2HYZYGe
   rPVDS509Uo8silQG948M0OWOj4pMEWvZpl6rZTi7I6tsHplgqT33pNrJy
   IZLPGL3y9sR2SDJQMb+ty9lYK68ade7MlBVMzD3vjQMnMyZkp4Q68BCNN
   J2odFxRSHa77Mity6wIWPET0l8wbUFfTH4rmLhcy/xSqdgokCJIE6aJVu
   gt6ED8Kk+2Uq3TMkSFifhYqV4pioHsjRnNEQOGTh4NvYs/inGQbJudBrg
   A==;
X-CSE-ConnectionGUID: qUSqv1vBSdu5znv9C6iZvw==
X-CSE-MsgGUID: VqhuWQFhTkqu1d08/dPD7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33463825"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33463825"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 05:32:26 -0800
X-CSE-ConnectionGUID: KLNh7abMQDOTikbp6hpLrw==
X-CSE-MsgGUID: x7hnWGAKTL+U3JJDutLRDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93006245"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Dec 2024 05:32:23 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI6XE-0002S1-1h;
	Mon, 02 Dec 2024 13:32:20 +0000
Date: Mon, 2 Dec 2024 21:32:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Zong-You Xie <ben717@andestech.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ben Zong-You Xie <ben717@andestech.com>
Subject: Re: [PATCH v2 2/2] pwm: atcpit100: add Andes PWM driver support
Message-ID: <202412022109.FiMppwWS-lkp@intel.com>
References: <20241202060147.1271264-3-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202060147.1271264-3-ben717@andestech.com>

Hi Ben,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master thierry-reding-pwm/for-next v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Zong-You-Xie/dt-bindings-pwm-add-atcpit100-pwm/20241202-140437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241202060147.1271264-3-ben717%40andestech.com
patch subject: [PATCH v2 2/2] pwm: atcpit100: add Andes PWM driver support
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20241202/202412022109.FiMppwWS-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412022109.FiMppwWS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412022109.FiMppwWS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pwm/pwm-atcpit100.c:25:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-atcpit100.c:25:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-atcpit100.c:25:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/pwm/pwm-atcpit100.c:123:31: warning: overflow in expression; result is 94'030'336 with type 'long' [-Winteger-overflow]
     122 |                         DIV64_U64_ROUND_UP(
         |                         ~~~~~~~~~~~~~~~~~~~
     123 |                                 (ATCPIT100_CYCLE_MAX + 1) * NSEC_PER_SEC,
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
     124 |                                 rate[clk]) - 1;
         |                                 ~~~~~~~~~~
   include/linux/math64.h:298:32: note: expanded from macro 'DIV64_U64_ROUND_UP'
     298 |         ({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
         |                                       ^~
>> drivers/pwm/pwm-atcpit100.c:173:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     173 |         if (ret)
         |             ^~~
   drivers/pwm/pwm-atcpit100.c:159:9: note: initialize the variable 'ret' to silence this warning
     159 |         int ret;
         |                ^
         |                 = 0
   8 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +123 drivers/pwm/pwm-atcpit100.c

    76	
    77	static int atcpit100_pwm_config(struct pwm_chip *chip, unsigned int channel,
    78					const struct pwm_state *state)
    79	{
    80		int clk;
    81		int ret;
    82		unsigned int reload_val;
    83		unsigned long rate[NUM_ATCPIT100_CLK];
    84		u64 max_period;
    85		u64 min_period;
    86		u64 high_cycle;
    87		u64 low_cycle;
    88		struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
    89		unsigned int ctrl_val = ATCPIT100_CHANNEL_CTRL_MODE_PWM;
    90		u64 high_period = state->duty_cycle;
    91		u64 low_period = state->period - high_period;
    92	
    93		rate[ATCPIT100_CLK_EXT] = clk_get_rate(ap->ext_clk);
    94		rate[ATCPIT100_CLK_APB] = clk_get_rate(ap->apb_clk);
    95	
    96		/*
    97		 * Reload register for PWM mode:
    98		 *
    99		 *		31 : 16    15 : 0
   100		 *		PWM16_Hi | PWM16_Lo
   101		 *
   102		 * In the PWM mode, the high period is (PWM16_Hi + 1) cycles, and the
   103		 * low period is (PWM16_Lo + 1) cycles. Since we need to write
   104		 * "numcycles - 1" to the register, the valid range of numcycles will
   105		 * be between 1 to 0x10000. Calculate the possible periods that satisfy
   106		 * the above restriction:
   107		 *
   108		 *	Let m = 1, M = 0x10000,
   109		 *	m <= floor(cycle) <= M
   110		 * <=>	m <= floor(rate * period / NSEC_PER_SEC) <= M
   111		 * <=>	m <= rate * period / NSEC_PER_SEC < M + 1
   112		 * <=>	m * NSEC_PER_SEC / rate <= period < (M + 1) * NSEC_PER_SEC / rate
   113		 * <=>	ceil(m * NSEC_PER_SEC / rate) <= period <= ceil((M + 1) * NSEC_PER_SEC / rate) - 1
   114		 *
   115		 * Since there are two clock sources for ATCPIT100, if the period is not
   116		 * valid for the first clock source, then the second clock source will
   117		 * be checked. Reject the request when both clock sources are not valid
   118		 * for the settings.
   119		 */
   120		for (clk = ATCPIT100_CLK_EXT; clk < NUM_ATCPIT100_CLK; clk++) {
   121			max_period =
   122				DIV64_U64_ROUND_UP(
 > 123					(ATCPIT100_CYCLE_MAX + 1) * NSEC_PER_SEC,
   124					rate[clk]) - 1;
   125			min_period =
   126				DIV64_U64_ROUND_UP(ATCPIT100_CYCLE_MIN * NSEC_PER_SEC,
   127						   rate[clk]);
   128	
   129			if (ATCPIT100_IS_VALID_PERIOD(high_period) &&
   130			    ATCPIT100_IS_VALID_PERIOD(low_period))
   131				break;
   132		}
   133	
   134		if (clk == NUM_ATCPIT100_CLK)
   135			return -EINVAL;
   136	
   137		/*
   138		 * Once changing the clock source here, the output will be neither the
   139		 * old one nor the new one until writing to the reload register.
   140		 */
   141		ctrl_val |= clk ? ATCPIT100_CHANNEL_CTRL_CLK : 0;
   142		ret = regmap_update_bits(ap->regmap, ATCPIT100_CHANNEL_CTRL(channel),
   143					 ATCPIT100_CHANNEL_CTRL_MASK, ctrl_val);
   144		if (ret)
   145			return ret;
   146	
   147		high_cycle = mul_u64_u64_div_u64(rate[clk], high_period, NSEC_PER_SEC);
   148		low_cycle = mul_u64_u64_div_u64(rate[clk], low_period, NSEC_PER_SEC);
   149		reload_val = FIELD_PREP(ATCPIT100_CHANNEL_RELOAD_HIGH, high_cycle - 1) |
   150			     FIELD_PREP(ATCPIT100_CHANNEL_RELOAD_LOW, low_cycle - 1);
   151	
   152		return regmap_write(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
   153				    reload_val);
   154	}
   155	
   156	static int atcpit100_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   157				       const struct pwm_state *state)
   158	{
   159		int ret;
   160		unsigned int channel = pwm->hwpwm;
   161	
   162		/* ATCPIT100 PWM driver now only supports normal polarity. */
   163		if (state->polarity != PWM_POLARITY_NORMAL)
   164			return -EINVAL;
   165	
   166		if (!state->enabled) {
   167			if (pwm->state.enabled)
   168				return atcpit100_pwm_enable(chip, channel, false);
   169	
   170			return 0;
   171		}
   172	
 > 173		if (ret)
   174			return ret;
   175	
   176		ret = atcpit100_pwm_config(chip, channel, state);
   177		if (ret)
   178			return ret;
   179	
   180		return atcpit100_pwm_enable(chip, channel, true);
   181	}
   182	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

