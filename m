Return-Path: <linux-pwm+bounces-4158-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ADF9DC2E6
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B3A164243
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5741C1991B4;
	Fri, 29 Nov 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dL+KHex5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F9199E9D;
	Fri, 29 Nov 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879916; cv=none; b=AWxTvq+dsab8YE1BoYVZTRJBfjRUImDbJzzBRmOq6Mc99IxwNJ8SCiegKgX9Ll8mvGfuiWdu+v65owZ5Ya8A4yhYoPmGQ0o1gLWiqkjF1FmZh4k+gYDmHWfCLzUrjt4ks36tHSM/hLNtuOq3P93s4Dcp+5+nxYCrLI9fCCJensY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879916; c=relaxed/simple;
	bh=2Q69KjoKyUKQhijTfAc96BDtSwh1D4Q/pd/gQDhr2nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9PiIOLLUidLaWOPeXvcHL/31Si5QptGCi1RkygTD6Vc3bgs1bwwqTTAn+jHXzCmZ/T7Qg+6QQpqlSBRlOT3lhkPSaP9dD7ZZZI+hLwmgd1iw2VJ603UhFRzweMYHshjs4S9lNYMzen6i8H46OW6XS0w/iqNaZIdC4lcv93UZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dL+KHex5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732879914; x=1764415914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Q69KjoKyUKQhijTfAc96BDtSwh1D4Q/pd/gQDhr2nQ=;
  b=dL+KHex51isiEzXzZx3nNmtmfYvSdEVwo81Xv8mQ/CRiumWRGoDAc+TP
   GMxLkT9QhOHb9b4SuI0vmQi0sPgB3/hxHYoUjufbc4OkpJxL/ejBtLNNr
   3xKmt+RWLeD0Ovr9Boizu9b7/TT4eZYJw/RNtSuIyQ227VIc9u3T/uimp
   BaRd+X9rgOXshHC4ZFIV+ryu1u2WyuzFJ+Q18mtfkTSmAoAlmzmMJ3wJc
   olemOfWn+VNc+tDlCAcThjrIPzbQ99WaaQ0rpzsPPNwp7KqodJewXQfU1
   Eqt9aCEr+piKz1GVqQodOhwYt4cVk6brh+yYU2B4yLHMqPDc4ZIbNYK9N
   A==;
X-CSE-ConnectionGUID: kyIHl2hNTsezfIpdzAdctQ==
X-CSE-MsgGUID: LN7tLvKESTOfoIlqgHI3uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33267840"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="33267840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 03:31:54 -0800
X-CSE-ConnectionGUID: zLmB6YFMR4aEoVgPstZQ6w==
X-CSE-MsgGUID: HqFn2Wi+TniN1CJupXSvgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97508882"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Nov 2024 03:31:52 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGzDx-0000HP-2F;
	Fri, 29 Nov 2024 11:31:49 +0000
Date: Fri, 29 Nov 2024 19:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, ukleinek@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rafael.v.volkmer@gmail.com
Subject: Re: [PATCH] pwm: tiehrpwm: ensures that state.enabled is
 synchronized during .probe()
Message-ID: <202411291940.6T4OMy3k-lkp@intel.com>
References: <20241129034334.27203-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129034334.27203-1-rafael.v.volkmer@gmail.com>

Hi Rafael,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-V-Volkmer/pwm-tiehrpwm-ensures-that-state-enabled-is-synchronized-during-probe/20241129-114649
base:   linus/master
patch link:    https://lore.kernel.org/r/20241129034334.27203-1-rafael.v.volkmer%40gmail.com
patch subject: [PATCH] pwm: tiehrpwm: ensures that state.enabled is synchronized during .probe()
config: alpha-randconfig-r053-20241129 (https://download.01.org/0day-ci/archive/20241129/202411291940.6T4OMy3k-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411291940.6T4OMy3k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291940.6T4OMy3k-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pwm/pwm-tiehrpwm.c: In function 'ehrpwm_pwm_probe':
>> drivers/pwm/pwm-tiehrpwm.c:642:32: error: 'struct ehrpwm_pwm_chip' has no member named 'chip'
     642 |         ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
         |                                ^~
   drivers/pwm/pwm-tiehrpwm.c:642:43: error: 'struct ehrpwm_pwm_chip' has no member named 'chip'
     642 |         ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
         |                                           ^~
>> drivers/pwm/pwm-tiehrpwm.c:642:60: error: 'state' undeclared (first use in this function); did you mean 'statx'?
     642 |         ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
         |                                                            ^~~~~
         |                                                            statx
   drivers/pwm/pwm-tiehrpwm.c:642:60: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pwm/pwm-tiehrpwm.c:664:27: error: 'struct ehrpwm_pwm_chip' has no member named 'chip'
     664 |         pwmchip_remove(&pc->chip);
         |                           ^~


vim +642 drivers/pwm/pwm-tiehrpwm.c

   584	
   585	static int ehrpwm_pwm_probe(struct platform_device *pdev)
   586	{
   587		struct device_node *np = pdev->dev.of_node;
   588		struct ehrpwm_pwm_chip *pc;
   589		struct pwm_chip *chip;
   590		bool tbclk_enabled;
   591		struct clk *clk;
   592		int ret;
   593	
   594		chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
   595		if (IS_ERR(chip))
   596			return PTR_ERR(chip);
   597		pc = to_ehrpwm_pwm_chip(chip);
   598	
   599		clk = devm_clk_get(&pdev->dev, "fck");
   600		if (IS_ERR(clk)) {
   601			if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
   602				dev_warn(&pdev->dev, "Binding is obsolete.\n");
   603				clk = devm_clk_get(pdev->dev.parent, "fck");
   604			}
   605		}
   606	
   607		if (IS_ERR(clk))
   608			return dev_err_probe(&pdev->dev, PTR_ERR(clk), "Failed to get fck\n");
   609	
   610		pc->clk_rate = clk_get_rate(clk);
   611		if (!pc->clk_rate) {
   612			dev_err(&pdev->dev, "failed to get clock rate\n");
   613			return -EINVAL;
   614		}
   615	
   616		chip->ops = &ehrpwm_pwm_ops;
   617	
   618		pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
   619		if (IS_ERR(pc->mmio_base))
   620			return PTR_ERR(pc->mmio_base);
   621	
   622		/* Acquire tbclk for Time Base EHRPWM submodule */
   623		pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
   624		if (IS_ERR(pc->tbclk))
   625			return dev_err_probe(&pdev->dev, PTR_ERR(pc->tbclk), "Failed to get tbclk\n");
   626	
   627		ret = clk_prepare(pc->tbclk);
   628		if (ret < 0) {
   629			dev_err(&pdev->dev, "clk_prepare() failed: %d\n", ret);
   630			return ret;
   631		}
   632	
   633		ret = pwmchip_add(chip);
   634		if (ret < 0) {
   635			dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
   636			goto err_clk_unprepare;
   637		}
   638	
   639		platform_set_drvdata(pdev, chip);
   640		pm_runtime_enable(&pdev->dev);
   641	
 > 642		ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
   643	
   644		if(state.enabled == true) {
   645			ret = clk_prepare_enable(pc->tbclk);
   646			if (ret) {	
   647				dev_err(&pdev->dev, "clk_prepare_enable() failed: %d\n", ret);
   648				goto err_pwmchip_remove;
   649			}
   650			
   651			tbclk_enabled = true;
   652	
   653			ret = pm_runtime_get_sync(&pdev->dev);
   654			if(ret < 0) {
   655				dev_err(&pdev->dev, "pm_runtime_get_sync() failed: %d\n", ret);
   656				clk_disable_unprepare(pc->tbclk);
   657				goto err_pwmchip_remove;
   658			}
   659		}
   660	
   661		return 0;
   662	
   663	err_pwmchip_remove:
   664		pwmchip_remove(&pc->chip);
   665	err_clk_unprepare:
   666		if(tbclk_enabled)
   667			clk_unprepare(pc->tbclk);
   668	
   669		return ret;
   670	}
   671	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

