Return-Path: <linux-pwm+bounces-3000-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF5D94DE45
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6371C20FAF
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B43813B2B4;
	Sat, 10 Aug 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcLn/oEj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0B4644E;
	Sat, 10 Aug 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723318536; cv=none; b=Fd9jxCc3XEq3oZXY6f3Uf0XxTmwZy7B54xzmMQR6R4YztVyrCobGvN1+Z0PYLID++GS1hnw11tcQHnPn0nLgQZ+xiI/W3prSIgfYqwnasP65rLCeDJ19fkDiBliRf/09a9z9X2E1VqrcCSQTODAxRjYoWVzD31eptHLQC8bhPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723318536; c=relaxed/simple;
	bh=fmMxhi+z6NFHOIB4h0MwZ2Ve9LUiK/yOWltAGZz8rT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgFo6qrydtZ0taaXDfk7tL5ItdWw5rLRQ4kyW6OBH3EzBlH2UGyZB3a4us/1c87Uqu/nFilvKcukBavTGDsVsvVXzqEMVpBNXjL1xOBe5xtepxXtcCfKGhoq2x36zWmlnP6KURkh+goYpZVWSa9CAtGUuV3S1Nn8vInu1HQMRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcLn/oEj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723318534; x=1754854534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmMxhi+z6NFHOIB4h0MwZ2Ve9LUiK/yOWltAGZz8rT4=;
  b=KcLn/oEj/mSwzCPniH17+D9moRIBV6+F4dI6Ovz0phEEXTnqbB4u5Uxe
   tVTagfimb2/Yh73zR0PWXrj78vcLc4r+3AYX7n2oTovX5IHDa90OIGK65
   +DmH5QNMJ8ztsNu4hYNOlvAbLqSJMSssaPPlGuAXoK3j96s3xUaEaN2RA
   gwZ+UA8AmcONg/EmHbnNZ0nDsoRpSqGPXixcbIYw01UNmXSQaibSdcGUl
   COIhsuhKBTy2+zyZIiKe428f+HyXGui+vGzuTH4h1irING9ZklNmVnLlH
   G8BYVht8aEEG0Lml9/QWQwVEd3RNARNoZdE5aoEuR3xLTLeUAuznsAmxj
   g==;
X-CSE-ConnectionGUID: Oe6Ji2ZwTGy5RK8MtpxTtA==
X-CSE-MsgGUID: e3tG0NnvSBOFznKC4Pmwkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="38980277"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="38980277"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 12:35:33 -0700
X-CSE-ConnectionGUID: q4SieW/JSlK1h+VMBK2AkA==
X-CSE-MsgGUID: RfvKKc1TQJ2Gp/chTcHlsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="62708524"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2024 12:35:30 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scrs7-000AEV-2K;
	Sat, 10 Aug 2024 19:35:27 +0000
Date: Sun, 11 Aug 2024 03:35:18 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com, krzk+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202408110329.6YGwCzoM-lkp@intel.com>
References: <a03f5ea9291e39eab303696eb03fdd44cf04e8d9.1723264979.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a03f5ea9291e39eab303696eb03fdd44cf04e8d9.1723264979.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc2 next-20240809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-pwm-Document-Airoha-EN7581-PWM/20240810-143716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/a03f5ea9291e39eab303696eb03fdd44cf04e8d9.1723264979.git.lorenzo%40kernel.org
patch subject: [PATCH 2/2] pwm: airoha: Add support for EN7581 SoC
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240811/202408110329.6YGwCzoM-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408110329.6YGwCzoM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408110329.6YGwCzoM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pwm/pwm-airoha.c: In function 'airoha_pwm_config_waveform':
>> drivers/pwm/pwm-airoha.c:239:26: error: implicit declaration of function '__bf_shf' [-Werror=implicit-function-declaration]
     239 |         val = (period << __bf_shf(mask)) & mask;
         |                          ^~~~~~~~
   cc1: some warnings being treated as errors


vim +/__bf_shf +239 drivers/pwm/pwm-airoha.c

   231	
   232	static void airoha_pwm_config_waveform(struct airoha_pwm *pc, int index,
   233					       u32 duty, u32 period)
   234	{
   235		u32 mask, val;
   236	
   237		/* Configure frequency divisor */
   238		mask = WAVE_GEN_CYCLE_MASK(index % 4);
 > 239		val = (period << __bf_shf(mask)) & mask;
   240		airoha_pwm_cycle_rmw(pc, REG_CYCLE_CFG_VALUE(index / 4), mask, val);
   241	
   242		/* Configure duty cycle */
   243		duty = ((DUTY_FULL - duty) << 8) | duty;
   244		mask = GPIO_FLASH_PRD_MASK(index % 2);
   245		val = (duty << __bf_shf(mask)) & mask;
   246		airoha_pwm_flash_rmw(pc, REG_GPIO_FLASH_PRD_SET(index / 2), mask, val);
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

