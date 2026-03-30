Return-Path: <linux-pwm+bounces-8423-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JadAUePymlC+AUAu9opvQ
	(envelope-from <linux-pwm+bounces-8423-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 16:57:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328635D46E
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 16:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A86FE313089C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6252324B23;
	Mon, 30 Mar 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byu97nM0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536343242BD;
	Mon, 30 Mar 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882102; cv=none; b=hOPyN/o7zcFOyY2Z4Mcs0ncWb01Pqu+sd3tEKKdZo0pUUPNxgc6k0HlgKbxbzJ9QKwN/CmG46GJVYzpEPjp4LBAcOnHFx8X0hryT2xTgO3oZryPRl4shYvir1LlsLJVT9u+1yIaXA1881DuC7IsxQZE2jXiE2q0SDDJ18ugccRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882102; c=relaxed/simple;
	bh=xpBPUcul1mxy76GdOsZONkg8Sx2okkRC6m5zBbw2K2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCxVOK5gjduDy4+muLIKiqt2uUZJWntcAkhXGYGiybs/xMJTETLZWHi0jP5Kso9hastE1dD25DYl5s5bzpKzdsUHoltrdBtKAzBSIwu4gjyyxAWYMC8faHFrHuJopVuAeKGKSACCneQmMaT2bC3pTJTFbEBMm4i7rQpslpqZd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byu97nM0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774882101; x=1806418101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpBPUcul1mxy76GdOsZONkg8Sx2okkRC6m5zBbw2K2U=;
  b=byu97nM0kVK6sXPi2Ars2jrEyZxmWIFEbIssuepZBxVJKiQO8OCfzkUh
   Li17a95Y7r6c9HQ3LHnG4UKtGmWoa9txE43VXKHGfPCZeM3PO2FlnxcZS
   DB2OPSxpz6J+aj3tgizdWB8QZn5gzI1lN9TO2VI1vVAPPvR0nzPRN+Q9W
   UvIqpUA0E/tcHsD2pPvdjGJcoNOy+kuy99yQtYIhIS9zrCR5KsPLRxCM8
   9ZhJwhVJWhXPqUbvh8oGkUon3UVgIGlS8c7gJEQxGpEUtxE6OCN0mreUm
   PoDpYKpZ2ebRWdjfu2Qhtbj1OKgDae3mjDYsTbzMKkI2IVnYFrtTCCC6V
   g==;
X-CSE-ConnectionGUID: 5gdJG16QS9+WFOPeUskbCQ==
X-CSE-MsgGUID: MmyPapJrSK2AbhJZvZNL7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79779133"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="79779133"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 07:48:20 -0700
X-CSE-ConnectionGUID: GeCJocUATueDNdJ/3Bzb9Q==
X-CSE-MsgGUID: Uwruj5+6QpuBx/L3s5F1+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="222767787"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Mar 2026 07:48:17 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7DuY-000000001E5-1RHg;
	Mon, 30 Mar 2026 14:48:14 +0000
Date: Mon, 30 Mar 2026 22:47:32 +0800
From: kernel test robot <lkp@intel.com>
To: Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <202603302251.AFXspVqF-lkp@intel.com>
References: <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8423-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 5328635D46E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mikko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikko-Perttunen/dt-bindings-pwm-Document-Tegra194-and-Tegra264-controllers/20260329-233356
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260325-t264-pwm-v2-2-998d885984b3%40nvidia.com
patch subject: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
config: hexagon-randconfig-r113-20260330 (https://download.01.org/0day-ci/archive/20260330/202603302251.AFXspVqF-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 2cd67b8b69f78e3f95918204320c3075a74ba16c)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603302251.AFXspVqF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603302251.AFXspVqF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pwm/pwm-tegra.c:303:47: sparse: sparse: cast truncates bits from constant value (7fffffffffffffff becomes ffffffff)

vim +303 drivers/pwm/pwm-tegra.c

   266	
   267	static int tegra_pwm_probe(struct platform_device *pdev)
   268	{
   269		struct pwm_chip *chip;
   270		struct tegra_pwm_chip *pc;
   271		const struct tegra_pwm_soc *soc;
   272		int ret;
   273	
   274		soc = of_device_get_match_data(&pdev->dev);
   275	
   276		chip = devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
   277		if (IS_ERR(chip))
   278			return PTR_ERR(chip);
   279		pc = to_tegra_pwm_chip(chip);
   280	
   281		pc->soc = soc;
   282	
   283		pc->regs = devm_platform_ioremap_resource(pdev, 0);
   284		if (IS_ERR(pc->regs))
   285			return PTR_ERR(pc->regs);
   286	
   287		platform_set_drvdata(pdev, chip);
   288	
   289		pc->clk = devm_clk_get(&pdev->dev, NULL);
   290		if (IS_ERR(pc->clk))
   291			return PTR_ERR(pc->clk);
   292	
   293		ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
   294		if (ret)
   295			return ret;
   296	
   297		pm_runtime_enable(&pdev->dev);
   298		ret = pm_runtime_resume_and_get(&pdev->dev);
   299		if (ret)
   300			return ret;
   301	
   302		/* Set maximum frequency of the IP */
 > 303		ret = dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
   304		if (ret < 0) {
   305			dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
   306			goto put_pm;
   307		}
   308	
   309		/*
   310		 * The requested and configured frequency may differ due to
   311		 * clock register resolutions. Get the configured frequency
   312		 * so that PWM period can be calculated more accurately.
   313		 */
   314		pc->clk_rate = clk_get_rate(pc->clk);
   315	
   316		/* Set minimum limit of PWM period for the IP */
   317		pc->min_period_ns =
   318		    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
   319	
   320		pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
   321		if (IS_ERR(pc->rst)) {
   322			ret = PTR_ERR(pc->rst);
   323			dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
   324			goto put_pm;
   325		}
   326	
   327		reset_control_deassert(pc->rst);
   328	
   329		chip->ops = &tegra_pwm_ops;
   330	
   331		ret = pwmchip_add(chip);
   332		if (ret < 0) {
   333			dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
   334			reset_control_assert(pc->rst);
   335			goto put_pm;
   336		}
   337	
   338		pm_runtime_put(&pdev->dev);
   339	
   340		return 0;
   341	put_pm:
   342		pm_runtime_put_sync_suspend(&pdev->dev);
   343		pm_runtime_force_suspend(&pdev->dev);
   344		return ret;
   345	}
   346	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

