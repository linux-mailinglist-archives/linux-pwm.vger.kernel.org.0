Return-Path: <linux-pwm+bounces-5346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB41AA7CCD2
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Apr 2025 06:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473F53B328D
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Apr 2025 04:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D055145355;
	Sun,  6 Apr 2025 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTaPSuT0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675D13A418;
	Sun,  6 Apr 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743915579; cv=none; b=uK1tVzBMNoeJ9U4XkMTV4/rdqmiNmIIgcArwZfzgZwxmdc7GzBiALF0+DgotpbsD9eigiFzlnf/RH7oKDDOlSwm2yKapcRqMejWsjN+g13wYOwrni5mOx/DGHAFB6naj/pue4N1oANi8puJFK5cs5zRu2bBiLFf6mbMFscGnkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743915579; c=relaxed/simple;
	bh=jZis5iEY4tCqO7K5vNNJgbuHf7Bs+RX9cH+CAloWBw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcoaxuCUVMP1Lo2+pQ/FvKTdvKMsWfp3MzRdXLPjC6jK5iSa+NKgNnFaX3CbunEtdXg1PR1j0cmr3fESVeoP0gBQW4C4Tg6W4nVw5n/fVzC5y1P7NNgh42/fnqeO0uZoDsjVY8zoK4dr5ah17E9sEbgVqS67dJeiMfL9dptavNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTaPSuT0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743915577; x=1775451577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jZis5iEY4tCqO7K5vNNJgbuHf7Bs+RX9cH+CAloWBw4=;
  b=NTaPSuT0dyGol3XtiHPwuVUYEplf1PXZVd/X0KhwKvVR0zGdoY1ex2vu
   wkHDeivGRlPwQ0dVDUz8YLaQTXV26qBOuR9SKXPaPlE18yLt3gAJ9brjy
   ILSY0tAxR6nHbfNKsqzvB2v/4dF9vcHKPNfg47r30n5bHqqZ2prvyqvL2
   BmMnMMOZ9RVCb/CfcmnUeaH0n4HY05kFy7p6MNvJjGLRBGnMQp1vruKuM
   jIYHvE6OiFy3+3ItamJX1cYIyeKuwPLVTkoQ34u/ZY4i/0cR+T4ijuCaj
   sFBb/3cl9whKAoOvPbPa7Zah6BgqwUXFVTuJuqs40n7MDlPpMnV1yMkQf
   w==;
X-CSE-ConnectionGUID: HLIWCZQBQaOt4wuu2J4sjQ==
X-CSE-MsgGUID: Or57z67TTXSZ7TpEmAl++A==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="32920571"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="32920571"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 21:59:36 -0700
X-CSE-ConnectionGUID: XcWY63J2Sva7cCOgaeGbMg==
X-CSE-MsgGUID: 6LxQWgP9QB2dhRy8soqyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="127630024"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Apr 2025 21:59:34 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1I6W-0002Rr-06;
	Sun, 06 Apr 2025 04:59:32 +0000
Date: Sun, 6 Apr 2025 12:58:43 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-pwm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] pwm: stm32: Emit debug output also for corner cases
 of the rounding callbacks
Message-ID: <202504061207.97zbNPvV-lkp@intel.com>
References: <fe154e79319da5ff4159cdc71201a9d3b395e491.1743844730.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe154e79319da5ff4159cdc71201a9d3b395e491.1743844730.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build errors:

[auto build test ERROR on e48e99b6edf41c69c5528aa7ffb2daf3c59ee105]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/pwm-Let-pwm_set_waveform-succeed-even-if-lowlevel-driver-rounded-up/20250405-173024
base:   e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
patch link:    https://lore.kernel.org/r/fe154e79319da5ff4159cdc71201a9d3b395e491.1743844730.git.u.kleine-koenig%40baylibre.com
patch subject: [PATCH 4/6] pwm: stm32: Emit debug output also for corner cases of the rounding callbacks
config: x86_64-buildonly-randconfig-001-20250406 (https://download.01.org/0day-ci/archive/20250406/202504061207.97zbNPvV-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504061207.97zbNPvV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504061207.97zbNPvV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pwm/pwm-stm32.c:246:60: error: use of undeclared identifier 'rate'
     246 |                 pwm->hwpwm, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr, rate,
         |                                                                          ^
   1 error generated.


vim +/rate +246 drivers/pwm/pwm-stm32.c

   208	
   209	static int stm32_pwm_round_waveform_fromhw(struct pwm_chip *chip,
   210						   struct pwm_device *pwm,
   211						   const void *_wfhw,
   212						   struct pwm_waveform *wf)
   213	{
   214		const struct stm32_pwm_waveform *wfhw = _wfhw;
   215		struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
   216		unsigned int ch = pwm->hwpwm;
   217	
   218		if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
   219			unsigned long rate = clk_get_rate(priv->clk);
   220			u64 ccr_ns;
   221	
   222			/* The result doesn't overflow for rate >= 15259 */
   223			wf->period_length_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1),
   224										     NSEC_PER_SEC, rate);
   225	
   226			ccr_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * wfhw->ccr,
   227								       NSEC_PER_SEC, rate);
   228	
   229			if (wfhw->ccer & TIM_CCER_CCxP(ch + 1)) {
   230				wf->duty_length_ns =
   231					stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1 - wfhw->ccr),
   232									      NSEC_PER_SEC, rate);
   233	
   234				wf->duty_offset_ns = ccr_ns;
   235			} else {
   236				wf->duty_length_ns = ccr_ns;
   237				wf->duty_offset_ns = 0;
   238			}
   239		} else {
   240			*wf = (struct pwm_waveform){
   241				.period_length_ns = 0,
   242			};
   243		}
   244	
   245		dev_dbg(&chip->dev, "pwm#%u: CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x @%lu -> %lld/%lld [+%lld]\n",
 > 246			pwm->hwpwm, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr, rate,
   247			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
   248	
   249		return 0;
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

