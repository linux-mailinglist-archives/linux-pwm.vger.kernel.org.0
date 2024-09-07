Return-Path: <linux-pwm+bounces-3148-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57652970378
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Sep 2024 19:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA35B21049
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Sep 2024 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF21649CC;
	Sat,  7 Sep 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HU+k8Ci4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479415A843;
	Sat,  7 Sep 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725731954; cv=none; b=dKBEfb+YssILcVGDpq/Rmw/PrW2WtNs1QdgwiT94xk7pGWWfO+9BNtvmus7wlVcbefhTT5/G6/I7gyDQTVtB8KDqlCQht8X85zuVbRrF4pDp0pKqZaEoLTpgwsrUe7eB2Y3BCkm0FIw9o4svDL1UKVP/JwDli8bdyde0GVbl5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725731954; c=relaxed/simple;
	bh=7W+Y2WI2P8yRIyWHBY18RxuM3cQNL1ZRi9/hscrP9ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpzjtZ18onq10YAuuDa2/Tz1+5VaexELsJ4DwNv0CGr+AYNlx1qi0pRqKcKBvhp1oZl0VHgaoIhBuPj4QsGZzI964rFoYVGaweczq7Ppw7n77xdJ0qjSkh/p93Bd1qOZkhm2J+9ztHX0aW418Giq+XxGg7zM1kTn/jseuHCEqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HU+k8Ci4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725731952; x=1757267952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7W+Y2WI2P8yRIyWHBY18RxuM3cQNL1ZRi9/hscrP9ew=;
  b=HU+k8Ci4PmdmW9tKa/2QAX73BHncSHCMYiB7JiJ3MlKrZ8rah/SegcuS
   hGP+yLfgPYAoAjj1eR8G26ykysDkzwLxouwkh4/yP1fbqiRJLjfGpc6Wq
   Q8wI2g1hmqUpBoFOl8DhAFywya8thJV4nrx/tvv8SU8aD04eJDtY4cTb+
   QgCaktjhUuoCA9IOlOpLazLjj5tGFPoLyxtYNJWNnUaAPlCKmfbwtB4cQ
   qwEeM/06m6+B30p8e+3oYxUV3wcj8HkUToZsOsfz+xh1OM/7j16n9DF13
   Fi5JuBbWh6rcJ0CPx077iOZX96SRYhDoPs2iA1o3hOoHoMx98qZlCzsAM
   Q==;
X-CSE-ConnectionGUID: 1bGfKg9QR5yJgj8BZeyU1w==
X-CSE-MsgGUID: p/zcejw5TACjKtvmqN3xhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="49882567"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="49882567"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 10:59:11 -0700
X-CSE-ConnectionGUID: l8Vfll+VRQ+MA6fVyOu7BA==
X-CSE-MsgGUID: 6UhShR+JQPmdIVXJXH/Kjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="66041591"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Sep 2024 10:59:08 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smziD-000Cot-1z;
	Sat, 07 Sep 2024 17:59:05 +0000
Date: Sun, 8 Sep 2024 01:58:18 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Wang <unicornxw@gmail.com>, ukleinek@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, unicorn_wang@outlook.com,
	inochiama@outlook.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <202409080100.h6lX5Asm-lkp@intel.com>
References: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 431c1646e1f86b949fa3685efc50b660a364c2b6]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-pwm-sophgo-add-bindings-for-sg2042/20240905-201303
base:   431c1646e1f86b949fa3685efc50b660a364c2b6
patch link:    https://lore.kernel.org/r/3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang%40outlook.com
patch subject: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
config: m68k-randconfig-r133-20240907 (https://download.01.org/0day-ci/archive/20240908/202409080100.h6lX5Asm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240908/202409080100.h6lX5Asm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080100.h6lX5Asm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-sophgo-sg2042.c:99:34: warning: 'sg2042_pwm_match' defined but not used [-Wunused-const-variable=]
      99 | static const struct of_device_id sg2042_pwm_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/sg2042_pwm_match +99 drivers/pwm/pwm-sophgo-sg2042.c

    98	
  > 99	static const struct of_device_id sg2042_pwm_match[] = {
   100		{ .compatible = "sophgo,sg2042-pwm" },
   101		{ },
   102	};
   103	MODULE_DEVICE_TABLE(of, sg2042_pwm_match);
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

