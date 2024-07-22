Return-Path: <linux-pwm+bounces-2883-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D89387B8
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 05:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63EE1C20D57
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7913FFC;
	Mon, 22 Jul 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3l+vZsf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AB14A90;
	Mon, 22 Jul 2024 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721619365; cv=none; b=aU+khf0IcBUH6vyTGKIT/FeFvEMDJj6ktmmZ3KxfOFSSnapTdJLJzwOb1FysTXiPhLcg5ean136PKaTuTdlGZwUBSV149NsNu4BYFg2ziX5+8otEg4KXfJEkvgxgoe0VD2RK1ezj7u0nU5NrdKCroUmCkuBKuaJ0XYBSwHGpr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721619365; c=relaxed/simple;
	bh=PwFT7B1VJB/UXjjpWDCkDoQ6sX7XM3WUzIPOQ+mIUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUnbhpQvBEvvHndHLy7PGaMRjyLU34NraJqjc/uIrEaXVbk+K1c3bl234G0QsjkqRnMbctgacBlI80WlVSSr7m1a5UEj7mIpteFwlOnbo9b/OKAEo9Pzp3GuqOdwxqbDT6ud0vnMaI+jZTuMM1pGfUXC6b0g5GJK0cvK2iPd/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3l+vZsf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721619364; x=1753155364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PwFT7B1VJB/UXjjpWDCkDoQ6sX7XM3WUzIPOQ+mIUNQ=;
  b=j3l+vZsfsp1gmgtJ+lY7VwH78P1NZ2M3NO0RUem4e0e8B6/yZcdrsxpG
   0bjznLkk8Yl0hANQjd0u7X6wx1EStvdkt8zTfT2kofTgEHUkzNgWe78rs
   Jz1bx/XMKNgiYTdL9EXnOFj9iuFXGz6Aybhd+tGayoP/UumrpXPZeLz8P
   lxUeaQeQ3Z448gYgrP6HNrVecCWDnH/rPkjt8UhzHRfs5FeUNGyyfA9ev
   I6I75KlW+q6BS2t6vTUQMqgMF/6GgL4qk4GIJD/sVqPSgc/+XAvGDcRTq
   tx8taBiruir16KdPPyT+EKElV46SOGXa8N+jFM58vYw8SMWwtLFoUpgea
   w==;
X-CSE-ConnectionGUID: 9fSXWEdnRU+N0QoaYAYTfw==
X-CSE-MsgGUID: omcauA4ySYGkoMbA144Q6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="30554900"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="30554900"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 20:36:03 -0700
X-CSE-ConnectionGUID: 2gtp3AbRQmGUQ2ZIJi9ldQ==
X-CSE-MsgGUID: tkEtpGauSueOyIL1HE3XIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="51460628"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Jul 2024 20:35:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVjq8-000kqK-3A;
	Mon, 22 Jul 2024 03:35:56 +0000
Date: Mon, 22 Jul 2024 11:35:55 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ukleinek@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v6 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
Message-ID: <202407221153.LJjYD5i7-lkp@intel.com>
References: <20240722005825.1800403-4-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722005825.1800403-4-chris.packham@alliedtelesis.co.nz>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.10 next-20240719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/dt-bindings-hwmon-Add-adt7475-fan-pwm-properties/20240722-091004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240722005825.1800403-4-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH v6 3/3] hwmon: (adt7475) Add support for configuring initial PWM state
config: arm-randconfig-002-20240722 (https://download.01.org/0day-ci/archive/20240722/202407221153.LJjYD5i7-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240722/202407221153.LJjYD5i7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407221153.LJjYD5i7-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/hwmon/adt7475.c:15:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/hwmon/adt7475.c:1683:2: warning: comparison of distinct pointer types ('typeof ((freq_hz)) *' (aka 'unsigned long *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
    1683 |         do_div(freq_hz, args[1]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> drivers/hwmon/adt7475.c:1683:2: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
    1683 |         do_div(freq_hz, args[1]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
      24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
         |                                             ^
>> drivers/hwmon/adt7475.c:1685:2: warning: comparison of distinct pointer types ('typeof ((duty)) *' (aka 'unsigned long *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
    1685 |         do_div(duty, args[1]);
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
   drivers/hwmon/adt7475.c:1685:2: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
    1685 |         do_div(duty, args[1]);
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
      24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
         |                                             ^
>> drivers/hwmon/adt7475.c:1683:2: warning: shift count >= width of type [-Wshift-count-overflow]
    1683 |         do_div(freq_hz, args[1]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/hwmon/adt7475.c:1685:2: warning: shift count >= width of type [-Wshift-count-overflow]
    1685 |         do_div(duty, args[1]);
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   5 warnings and 2 errors generated.


vim +1683 drivers/hwmon/adt7475.c

  1673	
  1674	static int _adt7475_pwm_properties_parse_args(u32 args[4], struct adt7475_pwm_config *cfg)
  1675	{
  1676		unsigned long freq_hz;
  1677		unsigned long duty;
  1678	
  1679		if (args[1] == 0)
  1680			return -EINVAL;
  1681	
  1682		freq_hz = 1000000000UL;
> 1683		do_div(freq_hz, args[1]);
  1684		duty = 255 * args[3];
> 1685		do_div(duty, args[1]);
  1686	
  1687		cfg->index = args[0];
  1688		cfg->freq = find_closest(freq_hz, pwmfreq_table, ARRAY_SIZE(pwmfreq_table));
  1689		cfg->flags = args[2];
  1690		cfg->duty = clamp_val(duty, 0, 0xFF);
  1691	
  1692		return 0;
  1693	}
  1694	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

