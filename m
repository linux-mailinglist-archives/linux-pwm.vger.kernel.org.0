Return-Path: <linux-pwm+bounces-4395-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E179F6A9A
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 16:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB191722F8
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D61F130E;
	Wed, 18 Dec 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7xXtYrU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0311B0422;
	Wed, 18 Dec 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537546; cv=none; b=t/NqSigOrOH0juj2iFaf/kliE6+dFe8cmSnRIWVwpuPNE+f9s28xg4C545OzlFIQ/rk5qVWMAM0wM0eeGDWmRswBGMlstIKJn+kA4H/IJMuNEMDjX1/y8KzPDdgK1btnhYuJNpUHc9Kw2ZumALvzm7BGoZK2i2eIhiGESq2X2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537546; c=relaxed/simple;
	bh=lQ2pBIDXkcpmADWQH+UCwmI3ossBxR0vfJqtcZw6Y34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktzY40md1a43e+7dDTDjrbkL91DopW2crluxH5EuohCCeOhEG3NeS+6/1dYUmkXQsKuDNRoNqLTe3oDa3N4/2pRxmdn0nz/rnm+UHF6b6HCupucLZdUant55PGg/Ft0C9zUx6wjIeKzmVgZ3dB0VPymeZjNGeKn8E47DhaPb2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7xXtYrU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734537545; x=1766073545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQ2pBIDXkcpmADWQH+UCwmI3ossBxR0vfJqtcZw6Y34=;
  b=K7xXtYrUbcdQJFvvrOXQCfqXoYGQgLAZAeoBUneBsiguaFRKf98pKCfV
   UvLk3KryqAplD5G81PBxeY2swQ/igxiArLIn09YqE7Qu/fhFlp+wt35Dy
   DpYnLrCVv1MD/IAwR9AY1ekEQRhUg2P/paMOpIfa7raC6S1P/IdCgqTHR
   hrvtzABC+NJUzZUKxs6BlmkW7uIh4yQEySh9JetxCgK2QfxeMe+i+vcPa
   6lls0ITpGf4OSpQui1srme6wmCEa9r1pzinvLummBYsMvqJfe3e994w6j
   Io8j8xkZ6DDEWfl2XSjajlYAuL+mbQweK0Ap5ogQIm5TbJpqVnG9KPMIk
   w==;
X-CSE-ConnectionGUID: lIeg/cv1QAOjqMrtxVrnnA==
X-CSE-MsgGUID: mkcHFF5sRTS1ogaX2ucj3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45618296"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="45618296"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:59:04 -0800
X-CSE-ConnectionGUID: EsdysSHfTT6W2KXxS9uGxw==
X-CSE-MsgGUID: DShfojl1TnaaHgl4U/6j/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="102752984"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Dec 2024 07:59:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNwRv-000GSA-12;
	Wed, 18 Dec 2024 15:58:59 +0000
Date: Wed, 18 Dec 2024 23:58:18 +0800
From: kernel test robot <lkp@intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <202412182358.9wma1UUE-lkp@intel.com>
References: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>

Hi Biju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 483082d78a092a3c1f343a76a2edb196069b4092]

url:    https://github.com/intel-lab-lkp/linux/commits/Biju-Das/dt-bindings-pwm-Add-RZ-G2L-GPT-binding/20241217-213809
base:   483082d78a092a3c1f343a76a2edb196069b4092
patch link:    https://lore.kernel.org/r/20241217132921.169640-4-biju.das.jz%40bp.renesas.com
patch subject: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241218/202412182358.9wma1UUE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241218/202412182358.9wma1UUE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412182358.9wma1UUE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-rzg2l-gpt.c: In function 'rzg2l_gpt_probe':
>> drivers/pwm/pwm-rzg2l-gpt.c:374:13: warning: unused variable 'i' [-Wunused-variable]
     374 |         u32 i;
         |             ^


vim +/i +374 drivers/pwm/pwm-rzg2l-gpt.c

   364	
   365	static int rzg2l_gpt_probe(struct platform_device *pdev)
   366	{
   367		struct rzg2l_gpt_chip *rzg2l_gpt;
   368		struct device *dev = &pdev->dev;
   369		struct reset_control *rstc;
   370		struct pwm_chip *chip;
   371		unsigned long rate;
   372		struct clk *clk;
   373		int ret;
 > 374		u32 i;
   375	
   376		chip = devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rzg2l_gpt));
   377		if (IS_ERR(chip))
   378			return PTR_ERR(chip);
   379		rzg2l_gpt = to_rzg2l_gpt_chip(chip);
   380	
   381		rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
   382		if (IS_ERR(rzg2l_gpt->mmio))
   383			return PTR_ERR(rzg2l_gpt->mmio);
   384	
   385		rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
   386		if (IS_ERR(rstc))
   387			return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
   388	
   389		clk = devm_clk_get_enabled(dev, NULL);
   390		if (IS_ERR(clk))
   391			return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
   392	
   393		ret = devm_clk_rate_exclusive_get(dev, clk);
   394		if (ret)
   395			return ret;
   396	
   397		rate = clk_get_rate(clk);
   398		if (!rate)
   399			return dev_err_probe(dev, -EINVAL, "The gpt clk rate is 0");
   400	
   401		/*
   402		 * Refuse clk rates > 1 GHz to prevent overflow later for computing
   403		 * period and duty cycle.
   404		 */
   405		if (rate > NSEC_PER_SEC)
   406			return dev_err_probe(dev, -EINVAL, "The gpt clk rate is > 1GHz");
   407	
   408		/*
   409		 * Rate is in MHz and is always integer for peripheral clk
   410		 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
   411		 * So make sure rate is multiple of 1000.
   412		 */
   413		rzg2l_gpt->rate_khz = rate / KILO;
   414		if (rzg2l_gpt->rate_khz * KILO != rate)
   415			return dev_err_probe(dev, -EINVAL, "Rate is not multiple of 1000");
   416	
   417		mutex_init(&rzg2l_gpt->lock);
   418	
   419		chip->ops = &rzg2l_gpt_ops;
   420		ret = devm_pwmchip_add(dev, chip);
   421		if (ret)
   422			return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
   423	
   424		return 0;
   425	}
   426	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

