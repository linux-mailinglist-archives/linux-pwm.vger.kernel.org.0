Return-Path: <linux-pwm+bounces-4172-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA79DEC24
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39D5281791
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF119F12D;
	Fri, 29 Nov 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQ+iM3oU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63951154C04;
	Fri, 29 Nov 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732905644; cv=none; b=aRP1KSEleWlc3HhbUU4g3wEnyhuEeMQF3dNjeUS6Rc6pOdkPwgTesJgupR1WRsgMf2NtMUSsIo5q7BJMEqA55A4huQcWkCPk9ufPwNIQua9wgD7R+MsxFhqlEvLFtyGQxsKEGbQ29UFP44DfsyiZNttzPKRPyT0dCdSHPfY3mu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732905644; c=relaxed/simple;
	bh=Qsng7FU1DeYTg+48WQ34KtK/cEVfuDBd81zp+Xy/Ueg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZdodjuGHCUtrf9ihkbQAE3wkf7KQns39a+9/od5XmZldZIeIjFDkRZpvaT1hgAOGuwtoplnX/LCUTBesCYdNLDUqRBZ4KJuUwI9Lukihi4S2+gIX6nOummHgMFrqhLADoIHze8okTr6WbUa77Yc0HnOFJSOeBKfu+ujknSB7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQ+iM3oU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732905643; x=1764441643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qsng7FU1DeYTg+48WQ34KtK/cEVfuDBd81zp+Xy/Ueg=;
  b=hQ+iM3oUe/A0bzXIj0J9qAJHewoLkohcbO4sW52yXARGDpQmjYs65NhM
   d960PwU5VheP15IctWdmIuPwQGuGfD1Df/sZl08siNllzN05JA4XDlYGK
   4Go8DwpWlka7A+eiHM17R4t4+9v462RFq1Uvwubrnpn8KF8tKAL97HF8+
   7Onjve9NtdL3A8GVFKtzEzjAEdgIoR52NRHGhmnnagJ4KtAVSq/JkzpQq
   jWy0uJrv782uDX32IFSeTkueE9uUYlROEeHHr9/0UxqW3Gzl4Ri6iortW
   bU1gLy1mua2qrCtVseqd8/AtfKmeUc+ae8x4mb25m9clTN5q3zA000N1K
   w==;
X-CSE-ConnectionGUID: EH+6R2IpT76ZVunV2/4qbg==
X-CSE-MsgGUID: FooSXVokQV++89OP5dlb/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36928712"
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="36928712"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:40:42 -0800
X-CSE-ConnectionGUID: eLNBb6bSR9KN6PQ0nY+wtA==
X-CSE-MsgGUID: Sz3wLXyKRxuGfEj0PedYZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97587111"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Nov 2024 10:40:40 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tH5uw-0000cb-01;
	Fri, 29 Nov 2024 18:40:38 +0000
Date: Sat, 30 Nov 2024 02:40:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, ukleinek@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: Re: [PATCH] pwm: tiehrpwm: ensures that state.enabled is
 synchronized during .probe()
Message-ID: <202411300250.wkH4Isc0-lkp@intel.com>
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
[cannot apply to thierry-reding-pwm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-V-Volkmer/pwm-tiehrpwm-ensures-that-state-enabled-is-synchronized-during-probe/20241129-114649
base:   linus/master
patch link:    https://lore.kernel.org/r/20241129034334.27203-1-rafael.v.volkmer%40gmail.com
patch subject: [PATCH] pwm: tiehrpwm: ensures that state.enabled is synchronized during .probe()
config: x86_64-buildonly-randconfig-002-20241129 (https://download.01.org/0day-ci/archive/20241130/202411300250.wkH4Isc0-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411300250.wkH4Isc0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411300250.wkH4Isc0-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-tiehrpwm.c:537:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     537 |         return ret;
         |                ^~~
   drivers/pwm/pwm-tiehrpwm.c:525:9: note: initialize the variable 'ret' to silence this warning
     525 |         int ret;
         |                ^
         |                 = 0
>> drivers/pwm/pwm-tiehrpwm.c:642:27: error: no member named 'chip' in 'struct ehrpwm_pwm_chip'
     642 |         ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
         |                              ~~  ^
   drivers/pwm/pwm-tiehrpwm.c:642:38: error: no member named 'chip' in 'struct ehrpwm_pwm_chip'
     642 |         ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
         |                                         ~~  ^
>> drivers/pwm/pwm-tiehrpwm.c:642:53: error: use of undeclared identifier 'state'; did you mean 'stac'?
     642 |         ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
         |                                                            ^~~~~
         |                                                            stac
   arch/x86/include/asm/smap.h:36:29: note: 'stac' declared here
      36 | static __always_inline void stac(void)
         |                             ^
   drivers/pwm/pwm-tiehrpwm.c:644:5: error: use of undeclared identifier 'state'
     644 |         if(state.enabled == true) {
         |            ^
   drivers/pwm/pwm-tiehrpwm.c:664:22: error: no member named 'chip' in 'struct ehrpwm_pwm_chip'
     664 |         pwmchip_remove(&pc->chip);
         |                         ~~  ^
   1 warning and 5 errors generated.


vim +642 drivers/pwm/pwm-tiehrpwm.c

   521	
   522	static int ehrpwm_get_hw_state(struct pwm_chip *chip, struct pwm_device *pwm, 
   523									struct pwm_state *state)
   524	{
   525		int ret;
   526	
   527		if(chip == NULL || pwm == NULL || state == NULL){
   528			return -EINVAL;
   529		}
   530	
   531		state->enabled = ehrpwm_is_enabled(chip);
   532	
   533		state->period = ehrpwm_read_period(chip);
   534	    state->duty_cycle = ehrpwm_read_duty_cycle(chip);
   535	    state->polarity = ehrpwm_read_polarity(chip);
   536	
 > 537		return ret;
   538	}
   539	
   540	static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   541				    const struct pwm_state *state)
   542	{
   543		int err;
   544		bool enabled = pwm->state.enabled;
   545	
   546		if (state->polarity != pwm->state.polarity) {
   547			if (enabled) {
   548				ehrpwm_pwm_disable(chip, pwm);
   549				enabled = false;
   550			}
   551	
   552			err = ehrpwm_pwm_set_polarity(chip, pwm, state->polarity);
   553			if (err)
   554				return err;
   555		}
   556	
   557		if (!state->enabled) {
   558			if (enabled)
   559				ehrpwm_pwm_disable(chip, pwm);
   560			return 0;
   561		}
   562	
   563		err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period);
   564		if (err)
   565			return err;
   566	
   567		if (!enabled)
   568			err = ehrpwm_pwm_enable(chip, pwm);
   569	
   570		return err;
   571	}
   572	
   573	static const struct pwm_ops ehrpwm_pwm_ops = {
   574		.free = ehrpwm_pwm_free,
   575		.apply = ehrpwm_pwm_apply,
   576	};
   577	
   578	static const struct of_device_id ehrpwm_of_match[] = {
   579		{ .compatible = "ti,am3352-ehrpwm" },
   580		{ .compatible = "ti,am33xx-ehrpwm" },
   581		{},
   582	};
   583	MODULE_DEVICE_TABLE(of, ehrpwm_of_match);
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

