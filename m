Return-Path: <linux-pwm+bounces-5184-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7BA60CE2
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 10:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D419C3498
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5F1EB9F4;
	Fri, 14 Mar 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y59P9Oee"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FB1E5213;
	Fri, 14 Mar 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943611; cv=none; b=uhdJQbF7W/8SF+KsbzRFEp+CibS8/OQhIli7+zf7rNI+/2QSUH+2UmPNk2TU4VA4DGu50cvP+RyBlyHqBt8IMozDBtZawFBvVZ22XVM9L9fXdQiYyDEZ/O03ZsBB8nP5yc27m4fQEM1WuC3K4yoPu8oFZiLxfbZJ9gOj+PQHTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943611; c=relaxed/simple;
	bh=B+lIDOUrEmw8+yDgcBsS2DxP5sklwK8Yq2ha/32ny+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nta8ikvTMm2d1zd7Zzj36TLeXxCie+d8/yEbKwP13ZhYTW63erQJcSIph2dns01yOe2cf/I5/fE6mf3ucV9Vu317c0LdpKToQFW5+EMY+TwBikskRk1oGFnjti8cQbKs75W4X1Oh69dloUtRXKYeBNCrwd2wHCLjXOezHUKTpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y59P9Oee; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741943609; x=1773479609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B+lIDOUrEmw8+yDgcBsS2DxP5sklwK8Yq2ha/32ny+s=;
  b=Y59P9OeeX4uuFdKHg18oowP0QoEBC64TLCJDJr7PmrExwglXDeOCSzKt
   c1KE1VgTU5OES43M+yyFmv7qZyF8nAVWRkWhsWFV7D+tk90KcweR6cvz6
   RumYFwFhsCDLjlWhlZE7Dpt30pQsdUf5kciYAqD9H7fo2ztYWDegEYX2q
   5w2VltA8pRyDrFWPDn42AThh/wAy/iTS8/7Yyh7Vx7Ajzr1kZaAlWMgOZ
   fcZvKcuP/c/4gk1ovGlB7e8V12N1P/shlNpGwPgiGmArSQWrYZygDynMO
   t+Davu/ZCUa5cNQwG3P5PDcGWmvq8kElXgk+L1IqjI82Gs5WCqXVzWtYP
   A==;
X-CSE-ConnectionGUID: DiCvfk9DQpGyESjZ/0vdmg==
X-CSE-MsgGUID: bwZcrNyhTXyeQGP+96aQVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53295868"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53295868"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 02:13:14 -0700
X-CSE-ConnectionGUID: pmJvSxPIRoWMgPEXA1D+Kw==
X-CSE-MsgGUID: prycXBQwR+GYrxpp0oldTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125398010"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 14 Mar 2025 02:13:09 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt16J-000AHE-13;
	Fri, 14 Mar 2025 09:13:07 +0000
Date: Fri, 14 Mar 2025 17:12:16 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 06/18] mfd: adp5585: add support for adp5589
Message-ID: <202503141607.g4arza1A-lkp@intel.com>
References: <20250313-dev-adp5589-fw-v1-6-20e80d4bd4ea@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dev-adp5589-fw-v1-6-20e80d4bd4ea@analog.com>

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4d395cb071a343196ca524d3694790f06978fe91]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-S-via-B4-Relay/dt-bindings-mfd-adp5585-ease-on-the-required-properties/20250313-222511
base:   4d395cb071a343196ca524d3694790f06978fe91
patch link:    https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-6-20e80d4bd4ea%40analog.com
patch subject: [PATCH 06/18] mfd: adp5585: add support for adp5589
config: riscv-randconfig-001-20250314 (https://download.01.org/0day-ci/archive/20250314/202503141607.g4arza1A-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141607.g4arza1A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141607.g4arza1A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/adp5585.c:48:41: warning: unused variable 'adp5589_volatile_regs' [-Wunused-const-variable]
      48 | static const struct regmap_access_table adp5589_volatile_regs = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~
>> drivers/mfd/adp5585.c:229:34: warning: unused variable 'adp5585_info' [-Wunused-const-variable]
     229 | static const struct adp5585_info adp5585_info = {
         |                                  ^~~~~~~~~~~~
>> drivers/mfd/adp5585.c:239:34: warning: unused variable 'adp5585_01_info' [-Wunused-const-variable]
     239 | static const struct adp5585_info adp5585_01_info = {
         |                                  ^~~~~~~~~~~~~~~
>> drivers/mfd/adp5585.c:249:34: warning: unused variable 'adp5585_02_info' [-Wunused-const-variable]
     249 | static const struct adp5585_info adp5585_02_info = {
         |                                  ^~~~~~~~~~~~~~~
   4 warnings generated.


vim +/adp5589_volatile_regs +48 drivers/mfd/adp5585.c

    47	
  > 48	static const struct regmap_access_table adp5589_volatile_regs = {
    49		.yes_ranges = adp5589_volatile_ranges,
    50		.n_yes_ranges = ARRAY_SIZE(adp5589_volatile_ranges),
    51	};
    52	
    53	/*
    54	 * Chip variants differ in the default configuration of pull-up and pull-down
    55	 * resistors, and therefore have different default register values:
    56	 *
    57	 * - The -00, -01 and -03 variants (collectively referred to as
    58	 *   ADP5585_REGMAP_00) have pull-up on all GPIO pins by default.
    59	 * - The -02 variant has no default pull-up or pull-down resistors.
    60	 * - The -04 variant has default pull-down resistors on all GPIO pins.
    61	 */
    62	
    63	static const u8 adp5585_regmap_defaults_00[ADP5585_MAX_REG + 1] = {
    64		/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    65		/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    66		/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    67		/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    68		/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    69		/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    70		/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    71		/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
    72	};
    73	
    74	static const u8 adp5585_regmap_defaults_02[ADP5585_MAX_REG + 1] = {
    75		/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    76		/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    77		/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc3,
    78		/* 0x18 */ 0x03, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00,
    79		/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    80		/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    81		/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    82		/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
    83	};
    84	
    85	static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
    86		/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    87		/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    88		/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55,
    89		/* 0x18 */ 0x05, 0x55, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
    90		/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    91		/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    92		/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    93		/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
    94	};
    95	
    96	static const u8 adp5589_regmap_defaults_00[ADP5589_MAX_REG + 1] = {
    97		/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    98		/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    99		/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   100		/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   101		/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   102		/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   103		/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   104		/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   105		/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   106		/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   107	};
   108	
   109	static const u8 adp5589_regmap_defaults_01[ADP5589_MAX_REG + 1] = {
   110		/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   111		/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   112		/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   113		/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   114		/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   115		/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   116		/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   117		/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
   118		/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   119		/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
   120	};
   121	
   122	static const u8 adp5589_regmap_defaults_02[ADP5589_MAX_REG + 1] = {
   123		/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   124		/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   125		/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   126		/* 0x18 */ 0x00, 0x41, 0x01, 0x00, 0x11, 0x04, 0x00, 0x00,
   127		/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   128		/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   129		/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   130		/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   131		/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   132		/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   133	};
   134	
   135	enum adp5585_regmap_type {
   136		ADP5585_REGMAP_00,
   137		ADP5585_REGMAP_02,
   138		ADP5585_REGMAP_04,
   139		ADP5589_REGMAP_00,
   140		ADP5589_REGMAP_01,
   141		ADP5589_REGMAP_02,
   142	};
   143	
   144	static const struct regmap_config adp5585_regmap_configs[] = {
   145		[ADP5585_REGMAP_00] = {
   146			.reg_bits = 8,
   147			.val_bits = 8,
   148			.max_register = ADP5585_MAX_REG,
   149			.volatile_table = &adp5585_volatile_regs,
   150			.cache_type = REGCACHE_MAPLE,
   151			.reg_defaults_raw = adp5585_regmap_defaults_00,
   152			.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_00),
   153		},
   154		[ADP5585_REGMAP_02] = {
   155			.reg_bits = 8,
   156			.val_bits = 8,
   157			.max_register = ADP5585_MAX_REG,
   158			.volatile_table = &adp5585_volatile_regs,
   159			.cache_type = REGCACHE_MAPLE,
   160			.reg_defaults_raw = adp5585_regmap_defaults_02,
   161			.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_02),
   162		},
   163		[ADP5585_REGMAP_04] = {
   164			.reg_bits = 8,
   165			.val_bits = 8,
   166			.max_register = ADP5585_MAX_REG,
   167			.volatile_table = &adp5585_volatile_regs,
   168			.cache_type = REGCACHE_MAPLE,
   169			.reg_defaults_raw = adp5585_regmap_defaults_04,
   170			.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
   171		},
   172		[ADP5589_REGMAP_00] = {
   173			.reg_bits = 8,
   174			.val_bits = 8,
   175			.max_register = ADP5589_MAX_REG,
   176			.volatile_table = &adp5585_volatile_regs,
   177			.cache_type = REGCACHE_MAPLE,
   178			.reg_defaults_raw = adp5589_regmap_defaults_00,
   179			.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_00),
   180		},
   181		[ADP5589_REGMAP_01] = {
   182			.reg_bits = 8,
   183			.val_bits = 8,
   184			.max_register = ADP5589_MAX_REG,
   185			.volatile_table = &adp5585_volatile_regs,
   186			.cache_type = REGCACHE_MAPLE,
   187			.reg_defaults_raw = adp5589_regmap_defaults_01,
   188			.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_01),
   189		},
   190		[ADP5589_REGMAP_02] = {
   191			.reg_bits = 8,
   192			.val_bits = 8,
   193			.max_register = ADP5589_MAX_REG,
   194			.volatile_table = &adp5585_volatile_regs,
   195			.cache_type = REGCACHE_MAPLE,
   196			.reg_defaults_raw = adp5589_regmap_defaults_02,
   197			.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_02),
   198		},
   199	};
   200	
   201	static const struct adp5585_regs adp5585_regs = {
   202		.debounce_dis_a = ADP5585_DEBOUNCE_DIS_A,
   203		.rpull_cfg_a = ADP5585_RPULL_CONFIG_A,
   204		.gpo_data_a = ADP5585_GPO_DATA_OUT_A,
   205		.gpo_out_a = ADP5585_GPO_OUT_MODE_A,
   206		.gpio_dir_a = ADP5585_GPIO_DIRECTION_A,
   207		.gpi_stat_a = ADP5585_GPI_STATUS_A,
   208		.pwm_cfg = ADP5585_PWM_CFG,
   209		.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
   210		.pwm_ont_low = ADP5585_PWM_ONT_LOW,
   211		.gen_cfg = ADP5585_GENERAL_CFG,
   212		.ext_cfg = ADP5585_PIN_CONFIG_C,
   213	};
   214	
   215	static const struct adp5585_regs adp5589_regs = {
   216		.debounce_dis_a = ADP5589_DEBOUNCE_DIS_A,
   217		.rpull_cfg_a = ADP5589_RPULL_CONFIG_A,
   218		.gpo_data_a = ADP5589_GPO_DATA_OUT_A,
   219		.gpo_out_a = ADP5589_GPO_OUT_MODE_A,
   220		.gpio_dir_a = ADP5589_GPIO_DIRECTION_A,
   221		.gpi_stat_a = ADP5589_GPI_STATUS_A,
   222		.pwm_cfg = ADP5589_PWM_CFG,
   223		.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
   224		.pwm_ont_low = ADP5589_PWM_ONT_LOW,
   225		.gen_cfg = ADP5589_GENERAL_CFG,
   226		.ext_cfg = ADP5589_PIN_CONFIG_D,
   227	};
   228	
 > 229	static const struct adp5585_info adp5585_info = {
   230		.adp5585_devs = adp5585_devs,
   231		.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_00],
   232		.n_devs = ARRAY_SIZE(adp5585_devs),
   233		.id = ADP5585_MAN_ID_VALUE,
   234		.regs = &adp5585_regs,
   235		.max_rows = ADP5585_MAX_ROW_NUM,
   236		.max_cols = ADP5585_MAX_COL_NUM,
   237	};
   238	
 > 239	static const struct adp5585_info adp5585_01_info = {
   240		.adp5585_devs = adp5585_devs,
   241		.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_00],
   242		.n_devs = ARRAY_SIZE(adp5585_devs),
   243		.id = ADP5585_MAN_ID_VALUE,
   244		.regs = &adp5585_regs,
   245		.max_rows = ADP5585_MAX_ROW_NUM,
   246		.max_cols = ADP5585_MAX_COL_NUM,
   247	};
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

