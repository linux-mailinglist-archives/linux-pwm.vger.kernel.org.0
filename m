Return-Path: <linux-pwm+bounces-3363-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB25598602C
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 16:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDE21C26343
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE60189BA4;
	Wed, 25 Sep 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4Dpmm5v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147A189BA5;
	Wed, 25 Sep 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268142; cv=none; b=qGUPv6klZ9Ap5E8KvkeDeuZyVECkqdBfs67P0ZHuAYmEAPFA08om96fS1LDJsJjQzL4AcejP3lMBnsu5EAuq7W9Nt5kRa4K60ZgMw6op0uRWH8IzS/rHZbBYi/7axsGuqns2HD+HVcehDqLAVq8c3xtEqAQRJ5ougk7pEcLnJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268142; c=relaxed/simple;
	bh=WXAQYtZyqCVW4wBSXVV7iEu+jmbm65WGzIo4hviMllI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0QGZ0vDqsw20I+xPk9fq1GnbstyPabArTlrlEkVq8sRSADtx3ojWa04ZbdT7WGoP/myrvVJdT2VIMQLCtsQQB/PWrZfxiQQJv9Ytj2p8NxaC36KSpVckPom99ErQXb/Oj/1qrkS6Rk/hpRV/xCY1ROEKsSUO/QpVl+BYowG/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4Dpmm5v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727268140; x=1758804140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WXAQYtZyqCVW4wBSXVV7iEu+jmbm65WGzIo4hviMllI=;
  b=S4Dpmm5vMVfO8gF1Dr5GTZ+0j6JI535td0TiJHuxJpM/i3PT9swnTHc1
   KPvaJtIuc2Wqf5ZjUBeZsbz48J6cztfs+HDLoEU6XOX+/2xB0c2DygxgA
   Sp9sBXBQi8B3KYmdzrbuRUOVUADbEvUXVG/7bGtcgtsmeK6e/g7RYvonY
   t2BargIdjBsXSv9A7Fghceg3JfgcnIIydzucFB2Ov1Wo7s38ic/pA2Szb
   sPYRVuYCMrcISgJkuICxNYzs5mB+0xPHKpVD8loUjCItm0yG8JsOi/kG6
   6z4KBXpVVAy+pqAVb48iEmnNQQYvIu02ioQJ1p3wzdhB3bJAuKi2Dhgbf
   g==;
X-CSE-ConnectionGUID: cJc+V9J4S3eCfHZesrtEow==
X-CSE-MsgGUID: 3ur+eU46TiCKgAsCXDzfPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26176194"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26176194"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 05:42:20 -0700
X-CSE-ConnectionGUID: NUqdowHsSfCR8WZAZzCtfg==
X-CSE-MsgGUID: /B3t6mycQySzKBvhQktK+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71419940"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Sep 2024 05:42:18 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stRLT-000JXz-2K;
	Wed, 25 Sep 2024 12:42:15 +0000
Date: Wed, 25 Sep 2024 20:41:27 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting
 driver data from a chip
Message-ID: <202409252009.ZbXikiQJ-lkp@intel.com>
References: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 62f92d634458a1e308bb699986b9147a6d670457]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/pwm-axi-pwmgen-Create-a-dedicated-function-for-getting-driver-data-from-a-chip/20240923-205606
base:   62f92d634458a1e308bb699986b9147a6d670457
patch link:    https://lore.kernel.org/r/20240923125418.16558-2-u.kleine-koenig%40baylibre.com
patch subject: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting driver data from a chip
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240925/202409252009.ZbXikiQJ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409252009.ZbXikiQJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409252009.ZbXikiQJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pwm/pwm-axi-pwmgen.c:25:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/pwm/pwm-axi-pwmgen.c:25:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/pwm/pwm-axi-pwmgen.c:25:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/pwm/pwm-axi-pwmgen.c:26:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pwm/pwm-axi-pwmgen.c:58:9: error: returning 'void *' from a function with incompatible result type 'struct axi_pwmgen_ddata'
      58 |         return pwmchip_get_drvdata(chip);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pwm/pwm-axi-pwmgen.c:64:27: error: initializing 'struct axi_pwmgen_ddata *' with an expression of incompatible type 'struct axi_pwmgen_ddata'
      64 |         struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
         |                                  ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-axi-pwmgen.c:108:27: error: initializing 'struct axi_pwmgen_ddata *' with an expression of incompatible type 'struct axi_pwmgen_ddata'
     108 |         struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
         |                                  ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 warnings and 3 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [m]:
   - TI_K3_M4_REMOTEPROC [=m] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])


vim +58 drivers/pwm/pwm-axi-pwmgen.c

    55	
    56	static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct pwm_chip *chip)
    57	{
  > 58		return pwmchip_get_drvdata(chip);
    59	}
    60	
    61	static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
    62				    const struct pwm_state *state)
    63	{
  > 64		struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
    65		unsigned int ch = pwm->hwpwm;
    66		struct regmap *regmap = ddata->regmap;
    67		u64 period_cnt, duty_cnt;
    68		int ret;
    69	
    70		if (state->polarity != PWM_POLARITY_NORMAL)
    71			return -EINVAL;
    72	
    73		if (state->enabled) {
    74			period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
    75			if (period_cnt > UINT_MAX)
    76				period_cnt = UINT_MAX;
    77	
    78			if (period_cnt == 0)
    79				return -EINVAL;
    80	
    81			ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
    82			if (ret)
    83				return ret;
    84	
    85			duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
    86			if (duty_cnt > UINT_MAX)
    87				duty_cnt = UINT_MAX;
    88	
    89			ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
    90			if (ret)
    91				return ret;
    92		} else {
    93			ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
    94			if (ret)
    95				return ret;
    96	
    97			ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
    98			if (ret)
    99				return ret;
   100		}
   101	
   102		return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

