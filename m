Return-Path: <linux-pwm+bounces-3669-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45B99FE74
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 03:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826DB1C2472F
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1BF13E02D;
	Wed, 16 Oct 2024 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+vIragI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DF69D2B;
	Wed, 16 Oct 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043411; cv=none; b=PoJRrTj3JVdVU9VLd26TC8pMUrNSI5hTayMjX++aCHBnREiqttXdDS9wKmRbXXcIzoi4UqjLByVnrTeCeqMgQtyXiR40Tx3EXY2aTeVeRY5grELa9CkWnTVQZarETkQHBhZ9SJ9VPceUfns9w8HKsmfhHyPi+/tlrdfGWHU10jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043411; c=relaxed/simple;
	bh=ogJRD7lo4S6s+KuznmGPgcg7uHGMRwprMLi5z+gZn+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD1fAeHwvcnJpEpzCImxi05nwkOdusBq/twudc9colAt07/cyHRUJR+NFcS/ySU2sQhjMO7zKeN6hbkYlfZS+B2o5rhRyGTIJ1Co9tkq1kJAjfRIUv3MdoA2La7XD2zVjO3Lp7RAjxe5KVPOlQyO9iZDHtkZQE1EpKWRcgSOZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+vIragI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729043410; x=1760579410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogJRD7lo4S6s+KuznmGPgcg7uHGMRwprMLi5z+gZn+8=;
  b=H+vIragIqWwfMCbXDNVNNQ57z/boEQsZcM0LoJC7XI43odNca74wV7TZ
   QFz8trIu8+n7J0So1X212BU/Q5JOcyXctJL5TAUVPtXyXncsS0xCMiQmR
   QpGQnog1/1qtgo+RltWRzAYhDf6+5n/WAt8gBCTIUzNVeBXeA3shoKwWH
   K/7RkdyCwWPQnj5qeUPWKTBDdkcId8+lpFuAhO2VyYuBeowhUkKu3ER57
   9Xq7PSZFYo85OhBFShmiiQZoMi5ak57ZtVp02KcuLnPk1zlXJCcxXG/5n
   Ciey3jJzcECxMTpwUI+wVCJJKNEAqqAGGLDMogAb3sFiGX1rwT8lNipYk
   g==;
X-CSE-ConnectionGUID: GgaoyiIdSJGakgDzxazKmg==
X-CSE-MsgGUID: kXIg5UanQBmQOj1sku+Uhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28568958"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28568958"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 18:50:10 -0700
X-CSE-ConnectionGUID: ooHWMSH5QEWTfsT6B5/V8A==
X-CSE-MsgGUID: nQ632r7fQSCDFT/zHroR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78028952"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Oct 2024 18:50:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0tAo-000K9V-2K;
	Wed, 16 Oct 2024 01:50:02 +0000
Date: Wed, 16 Oct 2024 09:49:40 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 5/6] pinctrl: airoha: Add support for EN7581 SoC
Message-ID: <202410160957.YN6r1XvO-lkp@intel.com>
References: <20241013-en7581-pinctrl-v6-5-2048e2d099c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-en7581-pinctrl-v6-5-2048e2d099c2@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6dbd1577b7dc10263d515045ef6460e80d6c9afa]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-arm-airoha-Add-the-chip-scu-node-for-EN7581-SoC/20241013-060857
base:   6dbd1577b7dc10263d515045ef6460e80d6c9afa
patch link:    https://lore.kernel.org/r/20241013-en7581-pinctrl-v6-5-2048e2d099c2%40kernel.org
patch subject: [PATCH v6 5/6] pinctrl: airoha: Add support for EN7581 SoC
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241016/202410160957.YN6r1XvO-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410160957.YN6r1XvO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410160957.YN6r1XvO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/mediatek/pinctrl-airoha.c:2884:35: warning: unused variable 'regmap_config' [-Wunused-const-variable]
    2884 | static const struct regmap_config regmap_config = {
         |                                   ^~~~~~~~~~~~~
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +/regmap_config +2884 drivers/pinctrl/mediatek/pinctrl-airoha.c

  2883	
> 2884	static const struct regmap_config regmap_config = {
  2885		.reg_bits		= 32,
  2886		.val_bits		= 32,
  2887		.reg_stride		= 4,
  2888	};
  2889	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

