Return-Path: <linux-pwm+bounces-3368-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF723986415
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F3428C7FD
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37BC199A2;
	Wed, 25 Sep 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ks0IV4MH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5712B8B;
	Wed, 25 Sep 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279315; cv=none; b=R4wGFgAwhf1MhiG9SQd8KZ+iECdwCvl29Re+aVGFpBnanwCHhK05CCRohsLQXil3iJmKdsw3ZlkeFUG5ygoK0vaGvPSos1FX6et3qum1eKAsNtxwDSfFTZiU09jzmSPl7egbl5O88zD56EveV82mBWJXxRVRM6YPjKXUu6xFFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279315; c=relaxed/simple;
	bh=wWKdhuaFqeg1OGQPpJT1FdZiD0N4gWpXyG9Ve1H5Rrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA4HnFn8MAll62Ex65DqMbObPuOUB+YgsGx6syCO5XLZ79lQVynMts52nk78PPiOVur+4Cc+kXQqkbMNKbVRWMwd9KAUhNmQDSU7+czXY1OA2Y5swJVNrKAVGFUISNdK3zRz4qnGQ3lAOoLE9RIA4viG3QpCvo6a5A8IUkEknmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ks0IV4MH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727279314; x=1758815314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wWKdhuaFqeg1OGQPpJT1FdZiD0N4gWpXyG9Ve1H5Rrs=;
  b=Ks0IV4MHf7EaqURqAYVDDEV3UCarLt3m1ZOedIuDYj3+Kcry51s6LLLo
   M66Rigxw6OJCd0MWbqcetsyUF61DfbQIhuWOGPsZftLCN7xLhbK+5ej8d
   DdVYTYTVZXk5cwdsrc8eq+c83ReCzCOurOm/Xn9q+TrV7zZyMBCYQi0X1
   A/KNaJz178WTb/NDVc3jXQHqJXwfR0PlP4MMe8NqHzpOTx+PbZziQg/EH
   hf4NxvCxeXdvZiiwkOdO1ZFuOxCXntUm6negHRSxqw+1gVynxuvnfC54b
   fPOBy3U0NgjhLJjogcOw3/qfZu9HaUsIbSQSynjf20N6h+TVw2fscjfIf
   g==;
X-CSE-ConnectionGUID: 3Df66lmyQMegaDSzikDn5w==
X-CSE-MsgGUID: 8LiIPrpUSdaJyPDkVVtCcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="13961728"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="13961728"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:48:25 -0700
X-CSE-ConnectionGUID: XP6UHyFzQki/KQRJiIUfuQ==
X-CSE-MsgGUID: gm6fk4vVTyOM96+LVeO2tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="72131552"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Sep 2024 08:48:23 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stUFY-000Jf1-1q;
	Wed, 25 Sep 2024 15:48:20 +0000
Date: Wed, 25 Sep 2024 23:47:56 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting
 driver data from a chip
Message-ID: <202409252352.YzA5pFp7-lkp@intel.com>
References: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 62f92d634458a1e308bb699986b9147a6d670457]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/pwm-axi-pwmgen-Create-a-dedicated-function-for-getting-driver-data-from-a-chip/20240923-205606
base:   62f92d634458a1e308bb699986b9147a6d670457
patch link:    https://lore.kernel.org/r/20240923125418.16558-2-u.kleine-koenig%40baylibre.com
patch subject: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting driver data from a chip
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240925/202409252352.YzA5pFp7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409252352.YzA5pFp7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409252352.YzA5pFp7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pwm/pwm-axi-pwmgen.c: In function 'axi_pwmgen_ddata_from_chip':
>> drivers/pwm/pwm-axi-pwmgen.c:58:16: error: incompatible types when returning type 'void *' but 'struct axi_pwmgen_ddata' was expected
      58 |         return pwmchip_get_drvdata(chip);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-axi-pwmgen.c: In function 'axi_pwmgen_apply':
>> drivers/pwm/pwm-axi-pwmgen.c:64:42: error: incompatible types when initializing type 'struct axi_pwmgen_ddata *' using type 'struct axi_pwmgen_ddata'
      64 |         struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-axi-pwmgen.c: In function 'axi_pwmgen_get_state':
   drivers/pwm/pwm-axi-pwmgen.c:108:42: error: incompatible types when initializing type 'struct axi_pwmgen_ddata *' using type 'struct axi_pwmgen_ddata'
     108 |         struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [y]:
   - TI_K3_M4_REMOTEPROC [=y] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])


vim +58 drivers/pwm/pwm-axi-pwmgen.c

    55	
    56	static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct pwm_chip *chip)
    57	{
  > 58		return pwmchip_get_drvdata(chip);
    59	}
    60	
    61	static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
    62				    const struct pwm_state *state)
    63	{
  > 64		struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
    65		unsigned int ch = pwm->hwpwm;
    66		struct regmap *regmap = ddata->regmap;
    67		u64 period_cnt, duty_cnt;
    68		int ret;
    69	
    70		if (state->polarity != PWM_POLARITY_NORMAL)
    71			return -EINVAL;
    72	
    73		if (state->enabled) {
    74			period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
    75			if (period_cnt > UINT_MAX)
    76				period_cnt = UINT_MAX;
    77	
    78			if (period_cnt == 0)
    79				return -EINVAL;
    80	
    81			ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
    82			if (ret)
    83				return ret;
    84	
    85			duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
    86			if (duty_cnt > UINT_MAX)
    87				duty_cnt = UINT_MAX;
    88	
    89			ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
    90			if (ret)
    91				return ret;
    92		} else {
    93			ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
    94			if (ret)
    95				return ret;
    96	
    97			ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
    98			if (ret)
    99				return ret;
   100		}
   101	
   102		return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

