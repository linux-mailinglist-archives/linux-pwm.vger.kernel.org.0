Return-Path: <linux-pwm+bounces-6732-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1497AF9DF3
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 04:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23207B7D47
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 02:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AEE1C84B2;
	Sat,  5 Jul 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiB7FgMn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFA2E371A;
	Sat,  5 Jul 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751683995; cv=none; b=SiZemgxfeZwxRAhVTuXtiUMLQN4GSO6RxBZ2X0EXgVGk7/qpzXwMObTf2avy7hL5rK/XJneF3odLpouH/8pvtCy9ubKaSdKvBFpV0MJV3Q/DudwUuQo4JP8atdkj5VgRwpUQ+b4pNAL1t6dp9ixwKle3jlt6CJXYXmTri+Dj1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751683995; c=relaxed/simple;
	bh=fqGiaM9o+QYdL6+wAfim0xgE3WxaK8JpTfSDneJpGKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxEN4N1/B/cxAypRtAD/cJGfoSfKCFNKxCy0Looy6StHMhsrwIArJINmjMnobcyjlmK2SglQRxavQnuxi+4hQX2LoFk6Y4kwkh6lka7+Yor3rFbsK9Y3uNgTgapdADRS4FHke2bW7IxCIDrCpBfkn3/OQDkKV2zVG9CPsxBUI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiB7FgMn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751683992; x=1783219992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqGiaM9o+QYdL6+wAfim0xgE3WxaK8JpTfSDneJpGKg=;
  b=UiB7FgMnAFql/1kMdq/8k15tvPx/vjYijLpwX+yJeodiy87vWMBCiC7K
   64vis/myxVAOYxLKdCITWiRerkARECLHq8J9QZmxO/UNEiRhFFcJcHhow
   dkmilbf4lLOenlh0ppudhOzqUt2YmR0Np4nKj1HFGxH9ER+8xpc4oo1P/
   yYVpR7pYTWvzJ3PZjsNywCbJdE1QPzojp9chej3Gv1tqRdRnWOLv63CFi
   EhR7fQibHGvZmspqToPhPbC77o/VhgdCOyxnyPPaQ27B8uRNqICUTO7so
   E9hRxckr/7Q8OGnq7cVXDRHGAoDhAfnjzWQZTVvtDHOiGjTYrIlbd9BoU
   Q==;
X-CSE-ConnectionGUID: RBpiZNMyRS2gmVTO5wT5sA==
X-CSE-MsgGUID: evGzT7C7Q+m4K6Q4LzlJPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53130874"
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="53130874"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 19:53:11 -0700
X-CSE-ConnectionGUID: wRgFeQZbTcC/tbanYNmZXQ==
X-CSE-MsgGUID: laoi48pUTWGWrrFw5mPUBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="154172887"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Jul 2025 19:53:10 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXt1X-0004Dp-0n;
	Sat, 05 Jul 2025 02:53:07 +0000
Date: Sat, 5 Jul 2025 10:52:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v20] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202507051036.3dQ3k7rN-lkp@intel.com>
References: <20250704072807.9335-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704072807.9335-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/pwm-airoha-Add-support-for-EN7581-SoC/20250704-153259
base:   linus/master
patch link:    https://lore.kernel.org/r/20250704072807.9335-1-ansuelsmth%40gmail.com
patch subject: [PATCH v20] pwm: airoha: Add support for EN7581 SoC
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250705/202507051036.3dQ3k7rN-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507051036.3dQ3k7rN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507051036.3dQ3k7rN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/openrisc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from arch/openrisc/include/asm/pgalloc.h:20,
                    from arch/openrisc/include/asm/io.h:18,
                    from include/linux/io.h:12,
                    from drivers/pwm/pwm-airoha.c:20:
   drivers/pwm/pwm-airoha.c: In function 'airoha_pwm_apply_bucket_config':
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   drivers/pwm/pwm-airoha.c:270:17: note: in expansion of macro 'do_div'
     270 |         shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
         |                 ^~~~~~
   In file included from include/linux/array_size.h:5,
                    from drivers/pwm/pwm-airoha.c:16:
   include/asm-generic/div64.h:195:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     195 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/pwm/pwm-airoha.c:270:17: note: in expansion of macro 'do_div'
     270 |         shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
         |                 ^~~~~~
>> include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
     199 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    u32 * {aka unsigned int *}
   drivers/pwm/pwm-airoha.c:270:17: note: in expansion of macro 'do_div'
     270 |         shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
         |                 ^~~~~~
   include/asm-generic/div64.h:174:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
     174 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   drivers/pwm/pwm-airoha.c:282:17: note: in expansion of macro 'do_div'
     282 |         shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
         |                 ^~~~~~
   include/asm-generic/div64.h:195:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     195 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/pwm/pwm-airoha.c:282:17: note: in expansion of macro 'do_div'
     282 |         shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
         |                 ^~~~~~
>> include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
     199 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    u32 * {aka unsigned int *}
   drivers/pwm/pwm-airoha.c:282:17: note: in expansion of macro 'do_div'
     282 |         shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
         |                 ^~~~~~
   include/asm-generic/div64.h:174:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
     174 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~


vim +/__div64_32 +199 include/asm-generic/div64.h

^1da177e4c3f41 Linus Torvalds     2005-04-16  176  
^1da177e4c3f41 Linus Torvalds     2005-04-16  177  /* The unnecessary pointer compare is there
^1da177e4c3f41 Linus Torvalds     2005-04-16  178   * to check for type safety (n must be 64bit)
^1da177e4c3f41 Linus Torvalds     2005-04-16  179   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  180  # define do_div(n,base) ({				\
^1da177e4c3f41 Linus Torvalds     2005-04-16  181  	uint32_t __base = (base);			\
^1da177e4c3f41 Linus Torvalds     2005-04-16  182  	uint32_t __rem;					\
^1da177e4c3f41 Linus Torvalds     2005-04-16  183  	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  184  	if (__builtin_constant_p(__base) &&		\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  185  	    is_power_of_2(__base)) {			\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  186  		__rem = (n) & (__base - 1);		\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  187  		(n) >>= ilog2(__base);			\
c747ce4706190e Geert Uytterhoeven 2021-08-11  188  	} else if (__builtin_constant_p(__base) &&	\
461a5e51060c93 Nicolas Pitre      2015-10-30  189  		   __base != 0) {			\
461a5e51060c93 Nicolas Pitre      2015-10-30  190  		uint32_t __res_lo, __n_lo = (n);	\
461a5e51060c93 Nicolas Pitre      2015-10-30  191  		(n) = __div64_const32(n, __base);	\
461a5e51060c93 Nicolas Pitre      2015-10-30  192  		/* the remainder can be computed with 32-bit regs */ \
461a5e51060c93 Nicolas Pitre      2015-10-30  193  		__res_lo = (n);				\
461a5e51060c93 Nicolas Pitre      2015-10-30  194  		__rem = __n_lo - __res_lo * __base;	\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  195  	} else if (likely(((n) >> 32) == 0)) {		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  196  		__rem = (uint32_t)(n) % __base;		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  197  		(n) = (uint32_t)(n) / __base;		\
c747ce4706190e Geert Uytterhoeven 2021-08-11  198  	} else {					\
^1da177e4c3f41 Linus Torvalds     2005-04-16 @199  		__rem = __div64_32(&(n), __base);	\
c747ce4706190e Geert Uytterhoeven 2021-08-11  200  	}						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  201  	__rem;						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  202   })
^1da177e4c3f41 Linus Torvalds     2005-04-16  203  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

