Return-Path: <linux-pwm+bounces-4173-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD19DF014
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Nov 2024 12:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650B9B2183E
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Nov 2024 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC08161935;
	Sat, 30 Nov 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6oE0eaJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234B1531E6;
	Sat, 30 Nov 2024 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732965571; cv=none; b=ScktOlvL5nhLMMJdr70w3SDOkjcLYbuACOGw/ilDr0aITHQDnmCVmvJayZqL/VTBM5mYyD+R43iZ9QKkYZiIjD8G9EWFyQ0ftIrwlS4ztLiKXs3Ux8tF6XlTaO2tQ1yERCW/vmv90JDo90FDpaNqHKltDMJLgRADIlJjcwZDFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732965571; c=relaxed/simple;
	bh=vV0CrhY5ERivvorl59Qose3xGU8M3PP6bHFHeC//1Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/j0efylhOYdBefcFwuoGP6bV66Rb3QP65GQuJ11Jqihc0c3cLXU/qKV6K/kOByMOUgLw5Kkx7DOh5eTIajY/mPUDTXimALmr4jwYpJ/ky95ex4Rea7x64mghk02z6o9MRKfwEtwaslIo2IK4t05QNLTyYWEYMSpuCoZbvUljV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6oE0eaJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732965570; x=1764501570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vV0CrhY5ERivvorl59Qose3xGU8M3PP6bHFHeC//1Hk=;
  b=f6oE0eaJ0TZLNbo1sIvhdhgcybzdl62f3veYHRHDfwf4INTZi2XKTrhg
   2Rina09VQijHmlkst3/gGiIRHbPsbUIM4MGFgHO6QbyCMnlErjMJ+uN5F
   YY5dEKRT6NfdrA3RXkTHkzCCQvKZpc6BJe4V7oh2g9L0cu7EHMT1I8ZGJ
   6L8Kkf//c8BwtQVq0ZEzc8EUi2ma4d8IjuUgK8xoJ6k3ei/gSFo1OgeLo
   hK4oE/sKan6vcfnY3U9eewylv/WkeDgUo4v0+v6F3nIgtTl/oBRGmbRWE
   Z/R6rR68lyPBSpP2MorJuTgzok82xHupxTSzJuVrIpQ5bxcUWtdG2d0xo
   A==;
X-CSE-ConnectionGUID: uPmm5Mp4SaC+J+AiE7PZ7Q==
X-CSE-MsgGUID: /nC+mQCqT8GnULZnBAc+Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36957647"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="36957647"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 03:19:29 -0800
X-CSE-ConnectionGUID: S8wNgLXNTRijomJzQXxaPw==
X-CSE-MsgGUID: yltgvo2jTCuoUfZ/24htxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="123541833"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 30 Nov 2024 03:19:26 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHLVT-0000bj-2x;
	Sat, 30 Nov 2024 11:19:23 +0000
Date: Sat, 30 Nov 2024 19:19:12 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <202411301859.sT9xRNb1-lkp@intel.com>
References: <20241129153546.63584-9-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129153546.63584-9-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-backend-add-API-for-interface-get/20241129-233931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241129153546.63584-9-antoniu.miclaus%40analog.com
patch subject: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20241130/202411301859.sT9xRNb1-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411301859.sT9xRNb1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411301859.sT9xRNb1-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad4851.c:963:35: warning: 'ad4858_channels' defined but not used [-Wunused-const-variable=]
     963 | static const struct iio_chan_spec ad4858_channels[] = {
         |                                   ^~~~~~~~~~~~~~~
>> drivers/iio/adc/ad4851.c:889:35: warning: 'ad4851_scan_type_16' defined but not used [-Wunused-const-variable=]
     889 | static const struct iio_scan_type ad4851_scan_type_16 = {
         |                                   ^~~~~~~~~~~~~~~~~~~
--
   arch/openrisc/kernel/head.o: in function `_dispatch_do_ipage_fault':
>> (.text+0x900): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   (.text+0xa00): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_dtranslation':
>> (.head.text+0x21bc): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_itranslation':
   (.head.text+0x2264): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   init/main.o: in function `trace_event_raw_event_initcall_level':
   main.c:(.text+0x28c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strlen' defined in .text section in lib/string.o
   init/main.o: in function `initcall_blacklisted':
   main.c:(.text+0x6f4): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strcmp' defined in .text section in lib/string.o
   init/main.o: in function `trace_initcall_finish_cb':
   main.c:(.text+0x814): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x864): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x894): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x8d0): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x934): additional relocation overflows omitted from the output


vim +/ad4858_channels +963 drivers/iio/adc/ad4851.c

   888	
 > 889	static const struct iio_scan_type ad4851_scan_type_16 = {
   890		.sign = 's',
   891		.realbits = 16,
   892		.storagebits = 16,
   893	};
   894	
   895	static const struct iio_scan_type ad4851_scan_type_20_0[] = {
   896		[AD4851_SCAN_TYPE_NORMAL] = {
   897			.sign = 'u',
   898			.realbits = 20,
   899			.storagebits = 32,
   900		},
   901		[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
   902			.sign = 'u',
   903			.realbits = 24,
   904			.storagebits = 32,
   905		},
   906	};
   907	
   908	static const struct iio_scan_type ad4851_scan_type_20_1[] = {
   909		[AD4851_SCAN_TYPE_NORMAL] = {
   910			.sign = 's',
   911			.realbits = 20,
   912			.storagebits = 32,
   913		},
   914		[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
   915			.sign = 's',
   916			.realbits = 24,
   917			.storagebits = 32,
   918		},
   919	};
   920	
   921	static int ad4851_get_current_scan_type(const struct iio_dev *indio_dev,
   922						const struct iio_chan_spec *chan)
   923	{
   924		struct ad4851_state *st = iio_priv(indio_dev);
   925	
   926		return st->resolution_boost_enabled ? AD4851_SCAN_TYPE_RESOLUTION_BOOST
   927						    : AD4851_SCAN_TYPE_NORMAL;
   928	}
   929	
   930	#define AD4851_IIO_CHANNEL(index, ch, diff)					\
   931		.type = IIO_VOLTAGE,							\
   932		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
   933			BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
   934			BIT(IIO_CHAN_INFO_SCALE),					\
   935		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
   936			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
   937		.info_mask_shared_by_all_available =					\
   938			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
   939		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\
   940		.indexed = 1,								\
   941		.differential = diff,							\
   942		.channel = ch,								\
   943		.channel2 = ch + (diff * 8),						\
   944		.scan_index = index,							\
   945	
   946	#define AD4858_IIO_CHANNEL(index, ch, diff, bits)				\
   947	{										\
   948		AD4851_IIO_CHANNEL(index, ch, diff)					\
   949		.ext_scan_type = ad4851_scan_type_##bits##_##diff,			\
   950		.num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_##bits##_##diff),	\
   951	}
   952	
   953	#define AD4857_IIO_CHANNEL(index, ch, diff, bits)				\
   954	{										\
   955		AD4851_IIO_CHANNEL(index, ch, diff)					\
   956		.scan_type = {								\
   957			.sign = 's',							\
   958			.realbits = bits,						\
   959			.storagebits = bits,						\
   960		},									\
   961	}
   962	
 > 963	static const struct iio_chan_spec ad4858_channels[] = {
   964		AD4858_IIO_CHANNEL(0, 0, 0, 20),
   965		AD4858_IIO_CHANNEL(1, 0, 1, 20),
   966		AD4858_IIO_CHANNEL(2, 1, 0, 20),
   967		AD4858_IIO_CHANNEL(3, 1, 1, 20),
   968		AD4858_IIO_CHANNEL(4, 2, 0, 20),
   969		AD4858_IIO_CHANNEL(5, 2, 1, 20),
   970		AD4858_IIO_CHANNEL(6, 3, 0, 20),
   971		AD4858_IIO_CHANNEL(7, 3, 1, 20),
   972		AD4858_IIO_CHANNEL(8, 4, 0, 20),
   973		AD4858_IIO_CHANNEL(9, 4, 1, 20),
   974		AD4858_IIO_CHANNEL(10, 5, 0, 20),
   975		AD4858_IIO_CHANNEL(11, 5, 1, 20),
   976		AD4858_IIO_CHANNEL(12, 6, 0, 20),
   977		AD4858_IIO_CHANNEL(13, 6, 1, 20),
   978		AD4858_IIO_CHANNEL(14, 7, 0, 20),
   979		AD4858_IIO_CHANNEL(15, 7, 1, 20),
   980	};
   981	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

