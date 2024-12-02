Return-Path: <linux-pwm+bounces-4181-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5639E00EF
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B12F162138
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 11:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871911FE457;
	Mon,  2 Dec 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBftX+RP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108061FDE0B;
	Mon,  2 Dec 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140263; cv=none; b=PWWrmYBYo6tgkyE4cyYzqN7UH7MO7+PdRHnWwzbMVnUYiJgZtfeOVY2T7DMYw2SmNTCY6bH8NWfhYZXYxLyiV1VMSzdd3DQ68lkbV7aTWuKnl9DyHJW1Q1o7UBoQTpzW3pOjjgOfdCHBgQwJTHu1M/QML6TCXe+KmxzRp9GSxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140263; c=relaxed/simple;
	bh=6s+NoKimPKemUsivQ2UQfp09dpUvkW+1d2SOJ8lE8Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1R/LAkKz+HX7kVE6SjtqAHn2fm4r9sv/9bw0URwZ+KF9qbyqvMpId/F0k0d7g76W7fgdHZl/NtnvrWJ2Xhd2FohvdrAS2ty9v0wHgN8fb9DJpJ2vH3DyQKheCLfJNdgJqcYE98iPG+1zMj+2x+TPMn3OCqhyFOkWRJsDEPROso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBftX+RP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733140261; x=1764676261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6s+NoKimPKemUsivQ2UQfp09dpUvkW+1d2SOJ8lE8Ts=;
  b=mBftX+RPASQON6ykWFjqdbeeRraYXXkOuC4Wg/cpFcX2yKddo1JDwbS4
   ilFwVZmHvgd/O3R6H7PgPX9Z/pm3KDoyg9zfbqbn/FZoNTQAAX3gaWIDq
   UUkzOZUb4SS1ddjNrCmUlSQIC567vafr/KGOySHReac4qZHCrIsSWTwzU
   UTPoKzGHgZnQ1OQfzW4rcPNT4fny7hxHT2pVdqVrgEdOzktATb68G+E43
   M+Kxav5Oaa9qCRIH/H9KySEAoQIgRXWqWmELmnyhgz3T1onhw7Jse5ofm
   32sEVaYSKxCdTaKDBr038Iz2Y/SBVtXAbvvCcTeM2kBiTtrJgiWa6B2v3
   Q==;
X-CSE-ConnectionGUID: KA6uCkhtRPG07d0meB7+qg==
X-CSE-MsgGUID: B7PmB1v0Sy+IkRe/FN5iJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43915758"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="43915758"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 03:51:00 -0800
X-CSE-ConnectionGUID: twTOEWXkQZG/Kp2jTLzKIg==
X-CSE-MsgGUID: D07UsJe3T1OBrjeWggGlWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98117906"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 02 Dec 2024 03:50:58 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI4x5-0002NM-2S;
	Mon, 02 Dec 2024 11:50:55 +0000
Date: Mon, 2 Dec 2024 19:50:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Zong-You Xie <ben717@andestech.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ukleinek@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	Ben Zong-You Xie <ben717@andestech.com>
Subject: Re: [PATCH v2 2/2] pwm: atcpit100: add Andes PWM driver support
Message-ID: <202412021900.oCRrT3PV-lkp@intel.com>
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20241202/202412021900.oCRrT3PV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412021900.oCRrT3PV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412021900.oCRrT3PV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/jiffies.h:7,
                    from include/linux/ktime.h:25,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:21,
                    from include/linux/notifier.h:16,
                    from include/linux/clk.h:14,
                    from drivers/pwm/pwm-atcpit100.c:18:
   drivers/pwm/pwm-atcpit100.c: In function 'atcpit100_pwm_config':
>> drivers/pwm/pwm-atcpit100.c:123:59: warning: integer overflow in expression of type 'long int' results in '94030336' [-Woverflow]
     123 |                                 (ATCPIT100_CYCLE_MAX + 1) * NSEC_PER_SEC,
         |                                                           ^
   include/linux/math64.h:298:39: note: in definition of macro 'DIV64_U64_ROUND_UP'
     298 |         ({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
         |                                       ^~

Kconfig warnings: (for reference only)
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

