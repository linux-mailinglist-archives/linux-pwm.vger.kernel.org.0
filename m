Return-Path: <linux-pwm+bounces-5185-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79530A60D2B
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 10:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3926189353D
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD491EDA0F;
	Fri, 14 Mar 2025 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDUH0PQg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CA1E5B73;
	Fri, 14 Mar 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944240; cv=none; b=iCD6asE0raxyhlIhj3dwTz+5xB0HckfyzWfiuNlNOPb2E0HSxW+IhVd4mjCG0wQmKyssJu3UCMcE8P0YQaJ6/L8+1jYJBJWWgpTeHCgWH/75TabfdQvnoUQrrV9tvJbQybrEo+Ge/tVtVfPyq0yDZ16eYafFpYs1k+1C1kiBqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944240; c=relaxed/simple;
	bh=48IAOov5hjZKGZDRw8V0ThFKbqHV+R34MZ20kxpwXOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOl8IakZXQL+YNF95rDhklKlj3zxjbzV1CBixLg5ELLCT7cACdr7xgWIT1jd2dnspLFJa28CUX+Yw9+1O4fW0/34XVT5MGGJwpZTPHIU2fkfSG6uYr/IgL3+94b/+k8m/Loe4FoXK1u13YDNDsza+OSHND9hrRWWwpXaWvcRz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDUH0PQg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741944238; x=1773480238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=48IAOov5hjZKGZDRw8V0ThFKbqHV+R34MZ20kxpwXOA=;
  b=TDUH0PQgOzSxiKPC3uNuqtQJF0hsNODn+4Q1rmLfoE5SAR8i1rFMp9xU
   YbCLAB69BXQGUrZxxjc9pbrH/MdkgzBITSq5MN99QkfVlZM3ZkhZztODW
   MhUljlqBasWZsgYQcg30ZyXIgObzGAozQPpU5yx7g0DCkQfkdNe5RBWkk
   rqLSH6KgBg1825MRbbERWcVoTpMnMBbMIUPKfR6vvIH6kvaxiIOXu9DPW
   wPImRdothHI41RfxBCoDKFJFx3+CYT9nFUlJV2NvtzDyJGKOYz28Z8aqo
   OHxxXqJeTFHC/r/AVPVpoqiEhKb7lGNavyaGPPftXuqugeJLQ5xHw8gHK
   A==;
X-CSE-ConnectionGUID: wmEcML8OQaifiUF5C1NhxA==
X-CSE-MsgGUID: tHMS/wcmSgaIiHowZJHerw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="65547244"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="65547244"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 02:23:58 -0700
X-CSE-ConnectionGUID: m+wFRj4lQki1FPbqsMgWkg==
X-CSE-MsgGUID: q/MJVMwNRgeLRspQj1sr4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152071743"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Mar 2025 02:23:53 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt1Gh-000AI8-1s;
	Fri, 14 Mar 2025 09:23:51 +0000
Date: Fri, 14 Mar 2025 17:23:05 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 06/18] mfd: adp5585: add support for adp5589
Message-ID: <202503141715.1e4xyKyq-lkp@intel.com>
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
config: s390-randconfig-001-20250314 (https://download.01.org/0day-ci/archive/20250314/202503141715.1e4xyKyq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141715.1e4xyKyq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141715.1e4xyKyq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/adp5585.c:249:34: warning: 'adp5585_02_info' defined but not used [-Wunused-const-variable=]
     249 | static const struct adp5585_info adp5585_02_info = {
         |                                  ^~~~~~~~~~~~~~~
>> drivers/mfd/adp5585.c:239:34: warning: 'adp5585_01_info' defined but not used [-Wunused-const-variable=]
     239 | static const struct adp5585_info adp5585_01_info = {
         |                                  ^~~~~~~~~~~~~~~
>> drivers/mfd/adp5585.c:229:34: warning: 'adp5585_info' defined but not used [-Wunused-const-variable=]
     229 | static const struct adp5585_info adp5585_info = {
         |                                  ^~~~~~~~~~~~
>> drivers/mfd/adp5585.c:48:41: warning: 'adp5589_volatile_regs' defined but not used [-Wunused-const-variable=]
      48 | static const struct regmap_access_table adp5589_volatile_regs = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~


vim +/adp5585_02_info +249 drivers/mfd/adp5585.c

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
 > 249	static const struct adp5585_info adp5585_02_info = {
   250		.adp5585_devs = adp5585_devs,
   251		.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_02],
   252		.n_devs = ARRAY_SIZE(adp5585_devs),
   253		.id = ADP5585_MAN_ID_VALUE,
   254		.regs = &adp5585_regs,
   255		.max_rows = ADP5585_MAX_ROW_NUM,
   256		.max_cols = ADP5585_MAX_COL_NUM,
   257	};
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

