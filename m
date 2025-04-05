Return-Path: <linux-pwm+bounces-5344-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F50BA7CC1B
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Apr 2025 00:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3753B7010
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7801B4121;
	Sat,  5 Apr 2025 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrKCwQhv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F452F88;
	Sat,  5 Apr 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891370; cv=none; b=G2wpx4ReEOnE4gL5VcMKTsNdAGI2TdUIAlZXPCOMQNU2vWC98RWMLwWfmsGVUPxsYYzbTd+dFfMYKREBth3j3Aw2qUjQc/9CavKUn10bhodl4qIFq6Sz5mx9CDplqjdp/WiILaCiRqxJOUYZJx0aCx1GMSc6HzDLobarYNcogQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891370; c=relaxed/simple;
	bh=xXUS4GgMNiPbO1jwMYGA+GWr2ekyWvBCCBz0RyIJHDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unT1p3zvZaf+AMjCcisO/+RrIkQd5r46ja8qmUKkkQhV9RLc8R68jcvYk+7XVIcG2DkpB3qlzLAGp8rBuow2R3K2DB4CCT8KM+AKTefIMNLp/eQZ4yjC1NksH96/9XydXWz9Avl9SQx3RFnvFncSuf9sO+vJ60nkecWQVcPRsWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrKCwQhv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743891367; x=1775427367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xXUS4GgMNiPbO1jwMYGA+GWr2ekyWvBCCBz0RyIJHDM=;
  b=lrKCwQhvpTnMwSii3OI/oBUwnxNR9Swv5WbZ1an/oLFTObx9unTEQcpy
   93VMz/6JUMeIdUTuacWXuomvzPSpkafR5Ur5rFoD+XW5xmpEM372rDijT
   nkjogkzqGLVle/Rodbmf6HjWPqwsVTGznc3vquiBkpAsk4ELRMWPGIMo1
   FECpaPYTBedIBE7t2HADvHG5YS9ks77gv2D8bTRPCpY38dcAondk9wnIF
   d24tuuXTzehLp8as6qaQMbnpZlKL4N/lbqh2ESnIaMFswsm1/TL+WrPHH
   TYXMGc9eO+h82+UbeG5pb28JHw0IOAekJuFm5CY35r5QyijsObWRrM9uU
   A==;
X-CSE-ConnectionGUID: 8mYkUIeRQT+OWBoiUeYaAQ==
X-CSE-MsgGUID: ehCe5JSSQFe1ubzyC0l+WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="48018097"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="48018097"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 15:16:06 -0700
X-CSE-ConnectionGUID: g4MEpJ50TTiUgcuNLPmOSw==
X-CSE-MsgGUID: C0wrrevxTpKJWYkd9AmLDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="128116775"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2025 15:16:04 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1Bo2-0002Jz-06;
	Sat, 05 Apr 2025 22:16:02 +0000
Date: Sun, 6 Apr 2025 06:15:44 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] pwm: stm32: Emit debug output also for corner cases
 of the rounding callbacks
Message-ID: <202504060517.dHXuUANs-lkp@intel.com>
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
config: arm-randconfig-004-20250406 (https://download.01.org/0day-ci/archive/20250406/202504060517.dHXuUANs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504060517.dHXuUANs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504060517.dHXuUANs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from include/linux/mfd/stm32-timers.h:11,
                    from drivers/pwm/pwm-stm32.c:12:
   drivers/pwm/pwm-stm32.c: In function 'stm32_pwm_round_waveform_fromhw':
>> drivers/pwm/pwm-stm32.c:246:60: error: 'rate' undeclared (first use in this function)
     246 |   pwm->hwpwm, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr, rate,
         |                                                            ^~~~
   include/linux/dev_printk.h:139:35: note: in definition of macro 'dev_no_printk'
     139 |    _dev_printk(level, dev, fmt, ##__VA_ARGS__); \
         |                                   ^~~~~~~~~~~
   drivers/pwm/pwm-stm32.c:245:2: note: in expansion of macro 'dev_dbg'
     245 |  dev_dbg(&chip->dev, "pwm#%u: CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x @%lu -> %lld/%lld [+%lld]\n",
         |  ^~~~~~~
   drivers/pwm/pwm-stm32.c:246:60: note: each undeclared identifier is reported only once for each function it appears in
     246 |   pwm->hwpwm, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr, rate,
         |                                                            ^~~~
   include/linux/dev_printk.h:139:35: note: in definition of macro 'dev_no_printk'
     139 |    _dev_printk(level, dev, fmt, ##__VA_ARGS__); \
         |                                   ^~~~~~~~~~~
   drivers/pwm/pwm-stm32.c:245:2: note: in expansion of macro 'dev_dbg'
     245 |  dev_dbg(&chip->dev, "pwm#%u: CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x @%lu -> %lld/%lld [+%lld]\n",
         |  ^~~~~~~


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

