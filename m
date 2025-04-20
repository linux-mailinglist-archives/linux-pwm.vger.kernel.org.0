Return-Path: <linux-pwm+bounces-5588-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61ABA946C1
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 07:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABAA1893379
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 05:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E119ADBF;
	Sun, 20 Apr 2025 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPsoiXAJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B218A6CF;
	Sun, 20 Apr 2025 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745126287; cv=none; b=JU7vJHAcGiDLLlPbyfIGExt9u8lJ21gCLhDRiGlRhpbpEavMkuwd/rqZ6C8NoXBUHxVtXEx7b5TpCC+5kr60y9QgJ2nw0i+UfCL8iloopwAW4Dha+eyYw+LBzyC4OoJ3zZmJe2nxU53xaQxXgtxMBHBBOkOm6QYOUUfYAz2Y1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745126287; c=relaxed/simple;
	bh=eb5MS92w01Wn4bIj5DxBtSQ/xzcRrFMjXnejgx6Ul88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlSKz4/XJs3ht4yOXU/P83vXa4xAq3HrTdB9SvSbGpCwAVZurYCdAJPYUH2GQpNOWSyWa2SpnTTbwrT09m1XlIaypBt9HDteN6TKkKNpLLkFNDwVPzT0pq9UgjF6mS+6obUNfDwq4v07qrkSqRt+730WbzeaR8/Obtff78OM2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPsoiXAJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745126286; x=1776662286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eb5MS92w01Wn4bIj5DxBtSQ/xzcRrFMjXnejgx6Ul88=;
  b=EPsoiXAJjiUkXDDCpV/BFZlgQPT09pWN60ItAGpLoUp9SUHdbo7pTIwF
   +PeZk6wDyvTTJAiJT4hPbC+CBGWQhLonDlZT2qnr15wN4sDMeVuMwE+nH
   Mn3Jc7SRmCKDkJWRlUsGaRN8Ni5uFP5NHN/1ZrNmJT2c0DnRoDcYsfJy2
   OJF6zNqcuDM2a9ThKkASHZi0hTD0z/vdLKcqfukxMcGLEZ8oOwYv/XS1L
   Evm1ALzwTsC1tpJptj1y3Gx5biYJWfloMqNXnYaVQ/Veia1ULB1jgwjT5
   RM4hhpnoM6v9titHi9XFyZzls4EP1K5dKTA1e/HYQPYuldQqhTI7bmKDB
   w==;
X-CSE-ConnectionGUID: J00K3TGkQ0mbFe8pNZDAEQ==
X-CSE-MsgGUID: OfxvqO17Rt+cSB+HIc4aGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46587382"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46587382"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 22:18:05 -0700
X-CSE-ConnectionGUID: G7CwwnahTrOaK9IDptIeQg==
X-CSE-MsgGUID: Lu5gSQxHTzSmdGRy7OT2Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="136298994"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Apr 2025 22:18:03 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6N44-0004RX-0r;
	Sun, 20 Apr 2025 05:18:00 +0000
Date: Sun, 20 Apr 2025 13:17:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: Re: [PATCH v2 1/1] pwm: tiehrpwm: ensures that state.enabled is
 synchronized in .probe()
Message-ID: <202504201347.OiWigSUq-lkp@intel.com>
References: <20250206031852.64853-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206031852.64853-1-rafael.v.volkmer@gmail.com>

Hi Rafael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.15-rc2 next-20250417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-V-Volkmer/pwm-tiehrpwm-ensures-that-state-enabled-is-synchronized-in-probe/20250420-075200
base:   linus/master
patch link:    https://lore.kernel.org/r/20250206031852.64853-1-rafael.v.volkmer%40gmail.com
patch subject: [PATCH v2 1/1] pwm: tiehrpwm: ensures that state.enabled is synchronized in .probe()
config: um-randconfig-002-20250420 (https://download.01.org/0day-ci/archive/20250420/202504201347.OiWigSUq-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250420/202504201347.OiWigSUq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504201347.OiWigSUq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pwm/pwm-tiehrpwm.c:11:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-tiehrpwm.c:11:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-tiehrpwm.c:11:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/pwm/pwm-tiehrpwm.c:675:7: warning: variable 'tbclk_enabled' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     675 |                 if (ret) {
         |                     ^~~
   drivers/pwm/pwm-tiehrpwm.c:706:6: note: uninitialized use occurs here
     706 |         if (tbclk_enabled)
         |             ^~~~~~~~~~~~~
   drivers/pwm/pwm-tiehrpwm.c:675:3: note: remove the 'if' if its condition is always false
     675 |                 if (ret) {
         |                 ^~~~~~~~~~
     676 |                         dev_err_probe(&pdev->dev, ret, "clk_prepare_enable() failed");
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     677 |                         goto err_pwmchip_remove;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~
     678 |                 }
         |                 ~
   drivers/pwm/pwm-tiehrpwm.c:629:20: note: initialize the variable 'tbclk_enabled' to silence this warning
     629 |         bool tbclk_enabled;
         |                           ^
         |                            = 0
   13 warnings generated.


vim +675 drivers/pwm/pwm-tiehrpwm.c

   621	
   622	static int ehrpwm_pwm_probe(struct platform_device *pdev)
   623	{
   624		struct device_node *np = pdev->dev.of_node;
   625		struct ehrpwm_pwm_chip *pc;
   626		struct pwm_state state;
   627		struct pwm_chip *chip;
   628		struct clk *clk;
   629		bool tbclk_enabled;
   630		int ret;
   631	
   632		chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
   633		if (IS_ERR(chip))
   634			return PTR_ERR(chip);
   635		pc = to_ehrpwm_pwm_chip(chip);
   636	
   637		clk = devm_clk_get(&pdev->dev, "fck");
   638		if (IS_ERR(clk)) {
   639			if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
   640				dev_warn(&pdev->dev, "Binding is obsolete.\n");
   641				clk = devm_clk_get(pdev->dev.parent, "fck");
   642			}
   643		}
   644	
   645		if (IS_ERR(clk))
   646			return dev_err_probe(&pdev->dev, PTR_ERR(clk), "Failed to get fck\n");
   647	
   648		pc->clk_rate = clk_get_rate(clk);
   649		if (!pc->clk_rate) {
   650			dev_err(&pdev->dev, "failed to get clock rate\n");
   651			return -EINVAL;
   652		}
   653	
   654		chip->ops = &ehrpwm_pwm_ops;
   655	
   656		pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
   657		if (IS_ERR(pc->mmio_base))
   658			return PTR_ERR(pc->mmio_base);
   659	
   660		/* Acquire tbclk for Time Base EHRPWM submodule */
   661		pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
   662		if (IS_ERR(pc->tbclk))
   663			return dev_err_probe(&pdev->dev, PTR_ERR(pc->tbclk), "Failed to get tbclk\n");
   664	
   665		ret = clk_prepare(pc->tbclk);
   666		if (ret < 0) {
   667			dev_err(&pdev->dev, "clk_prepare() failed: %d\n", ret);
   668			return ret;
   669		}
   670	
   671		ehrpwm_get_state(chip, &chip->pwms[0], &state);
   672	
   673		if (state.enabled == true) {
   674			ret = clk_prepare_enable(pc->tbclk);
 > 675			if (ret) {
   676				dev_err_probe(&pdev->dev, ret, "clk_prepare_enable() failed");
   677				goto err_pwmchip_remove;
   678			}
   679	
   680			tbclk_enabled = true;
   681		}
   682	
   683		ret = pwmchip_add(chip);
   684		if (ret < 0) {
   685			dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
   686			goto err_clk_unprepare;
   687		}
   688	
   689		platform_set_drvdata(pdev, chip);
   690		pm_runtime_enable(&pdev->dev);
   691	
   692		if (state.enabled == true) {
   693			ret = pm_runtime_get_sync(&pdev->dev);
   694			if (ret < 0) {
   695				dev_err_probe(&pdev->dev, ret, "pm_runtime_get_sync() failed");
   696				clk_disable_unprepare(pc->tbclk);
   697				goto err_pwmchip_remove;
   698			}
   699		}
   700	
   701		return 0;
   702	
   703	err_pwmchip_remove:
   704		pwmchip_remove(chip);
   705	err_clk_unprepare:
   706		if (tbclk_enabled)
   707			clk_unprepare(pc->tbclk);
   708	
   709		return ret;
   710	}
   711	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

