Return-Path: <linux-pwm+bounces-5662-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF221A97DB9
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 06:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1433A9165
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D28264FB2;
	Wed, 23 Apr 2025 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAHotNKn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4A1F09A1;
	Wed, 23 Apr 2025 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745381386; cv=none; b=KrTah9FGfD5zKqmVOSGVF4FESJibkQ6IgeuU5v6tY0jMDyY9NIQmhgPe/lOcB3SVPwCGg6Zdb8hM5y+u51qexncFDz4HCz0e2aBlrwTtbp4p3DABTx6nKVYQuTqzr0VjkZpa0AVE0/vaU7PeBEhMOzvGqI8LM4EESTXc8dkCpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745381386; c=relaxed/simple;
	bh=KISXD0ltBB9Z0bhlbMH9MxL/r8xahZ8DX/KFQwdLNi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZk6zznhVO+wWXqf3r9sFLT4ggEKf8KS9R+lLWMqoPDCakBCJrkSQCr7n6O8QvekOQVYRJ7X6/Crws1GYjaT4eF4bGiCba2EtWugdK0UHXf1N0A2+grZaFfrv1PO8pCaKwY7qbylMdfcvNVCK1fWAUpoBv0HXaN10njkgQnb+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAHotNKn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745381385; x=1776917385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KISXD0ltBB9Z0bhlbMH9MxL/r8xahZ8DX/KFQwdLNi4=;
  b=YAHotNKn2abv+LhZ1NRIk2+IXb/SMUUEGnG+7DqSz2PSE57UWt7hv2AW
   pX8qn4QlEEj8DZrClItFXlMvvPB4ibKINx632YGKvPEr3xNnk5mLKfpQH
   PnnORTF182DLSNsc+1S+q35h84pxXDckeNcqRzIOK5YatHjGhG5BgeR/z
   fJB8do723m4XTDUZKXpZ1bAsynPLo+TajO7cz4JmLzsYmB1QkgOeriD14
   rZ0Dj7JTW8LEI77iU5CvtKvDDVXmUF/HiODy+JUjYfotj5lAaPw+Rf8D0
   5Nvd8/IMEn4RTzdG6sAtPia35hVMVjot4/cAFNUehBbSKYH6LUV0TWggd
   Q==;
X-CSE-ConnectionGUID: s4liCc67SySyOmi3hvtV1w==
X-CSE-MsgGUID: mJJkFqskTY2JKvGthJM2Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="72342466"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="72342466"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 21:09:44 -0700
X-CSE-ConnectionGUID: veazpDj7QZmxOlZWUAIC5Q==
X-CSE-MsgGUID: BGgUw+7bSPiwYlKCWUgOXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133076123"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 22 Apr 2025 21:09:40 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7RQY-0001aF-0q;
	Wed, 23 Apr 2025 04:09:38 +0000
Date: Wed, 23 Apr 2025 12:08:40 +0800
From: kernel test robot <lkp@intel.com>
To: Nylon Chen <nylon.chen@sifive.com>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v12 4/5] pwm: sifive: Fix rounding issues in apply and
 get_state functions
Message-ID: <202504231136.Cr4O6Zg5-lkp@intel.com>
References: <20250422085312.812877-5-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422085312.812877-5-nylon.chen@sifive.com>

Hi Nylon,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.15-rc3 next-20250422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nylon-Chen/riscv-dts-sifive-unleashed-unmatched-Remove-PWM-controlled-LED-s-active-low-properties/20250422-165644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250422085312.812877-5-nylon.chen%40sifive.com
patch subject: [PATCH v12 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
config: arm-randconfig-004-20250423 (https://download.01.org/0day-ci/archive/20250423/202504231136.Cr4O6Zg5-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250423/202504231136.Cr4O6Zg5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504231136.Cr4O6Zg5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pwm/pwm-sifive.c:161:2: error: unterminated function-like macro invocation
     161 |         do_div(frac, state->period;
         |         ^
   include/asm-generic/div64.h:180:10: note: macro 'do_div' defined here
     180 | # define do_div(n,base) ({                              \
         |          ^
>> drivers/pwm/pwm-sifive.c:351:26: error: expected '}'
     351 | MODULE_LICENSE("GPL v2");
         |                          ^
   drivers/pwm/pwm-sifive.c:134:1: note: to match this '{'
     134 | {
         | ^
   2 errors generated.


vim +161 drivers/pwm/pwm-sifive.c

   131	
   132	static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   133				    const struct pwm_state *state)
   134	{
   135		struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
   136		struct pwm_state cur_state;
   137		unsigned int duty_cycle;
   138		unsigned long long num;
   139		bool enabled;
   140		int ret = 0;
   141		u32 frac, inactive;
   142	
   143		if (state->polarity != PWM_POLARITY_NORMAL)
   144			return -EINVAL;
   145	
   146		cur_state = pwm->state;
   147		enabled = cur_state.enabled;
   148	
   149		duty_cycle = state->duty_cycle;
   150		if (!state->enabled)
   151			duty_cycle = 0;
   152	
   153		/*
   154		 * The problem of output producing mixed setting as mentioned at top,
   155		 * occurs here. To minimize the window for this problem, we are
   156		 * calculating the register values first and then writing them
   157		 * consecutively
   158		 */
   159		num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
   160		frac = num;
 > 161		do_div(frac, state->period;
   162		/* The hardware cannot generate a 0% duty cycle */
   163		frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
   164		inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
   165	
   166		mutex_lock(&ddata->lock);
   167		if (state->period != ddata->approx_period) {
   168			/*
   169			 * Don't let a 2nd user change the period underneath the 1st user.
   170			 * However if ddate->approx_period == 0 this is the first time we set
   171			 * any period, so let whoever gets here first set the period so other
   172			 * users who agree on the period won't fail.
   173			 */
   174			if (ddata->user_count != 1 && ddata->approx_period) {
   175				mutex_unlock(&ddata->lock);
   176				return -EBUSY;
   177			}
   178			ddata->approx_period = state->period;
   179			pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
   180		}
   181		mutex_unlock(&ddata->lock);
   182	
   183		/*
   184		 * If the PWM is enabled the clk is already on. So only enable it
   185		 * conditionally to have it on exactly once afterwards independent of
   186		 * the PWM state.
   187		 */
   188		if (!enabled) {
   189			ret = clk_enable(ddata->clk);
   190			if (ret) {
   191				dev_err(pwmchip_parent(chip), "Enable clk failed\n");
   192				return ret;
   193			}
   194		}
   195	
   196		writel(inactive, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
   197	
   198		if (!state->enabled)
   199			clk_disable(ddata->clk);
   200	
   201		return 0;
   202	}
   203	
   204	static const struct pwm_ops pwm_sifive_ops = {
   205		.request = pwm_sifive_request,
   206		.free = pwm_sifive_free,
   207		.get_state = pwm_sifive_get_state,
   208		.apply = pwm_sifive_apply,
   209	};
   210	
   211	static int pwm_sifive_clock_notifier(struct notifier_block *nb,
   212					     unsigned long event, void *data)
   213	{
   214		struct clk_notifier_data *ndata = data;
   215		struct pwm_sifive_ddata *ddata =
   216			container_of(nb, struct pwm_sifive_ddata, notifier);
   217	
   218		if (event == POST_RATE_CHANGE) {
   219			mutex_lock(&ddata->lock);
   220			pwm_sifive_update_clock(ddata, ndata->new_rate);
   221			mutex_unlock(&ddata->lock);
   222		}
   223	
   224		return NOTIFY_OK;
   225	}
   226	
   227	static int pwm_sifive_probe(struct platform_device *pdev)
   228	{
   229		struct device *dev = &pdev->dev;
   230		struct pwm_sifive_ddata *ddata;
   231		struct pwm_chip *chip;
   232		int ret;
   233		u32 val;
   234		unsigned int enabled_pwms = 0, enabled_clks = 1;
   235	
   236		chip = devm_pwmchip_alloc(dev, 4, sizeof(*ddata));
   237		if (IS_ERR(chip))
   238			return PTR_ERR(chip);
   239	
   240		ddata = pwm_sifive_chip_to_ddata(chip);
   241		ddata->parent = dev;
   242		mutex_init(&ddata->lock);
   243		chip->ops = &pwm_sifive_ops;
   244	
   245		ddata->regs = devm_platform_ioremap_resource(pdev, 0);
   246		if (IS_ERR(ddata->regs))
   247			return PTR_ERR(ddata->regs);
   248	
   249		ddata->clk = devm_clk_get_prepared(dev, NULL);
   250		if (IS_ERR(ddata->clk))
   251			return dev_err_probe(dev, PTR_ERR(ddata->clk),
   252					     "Unable to find controller clock\n");
   253	
   254		ret = clk_enable(ddata->clk);
   255		if (ret) {
   256			dev_err(dev, "failed to enable clock for pwm: %d\n", ret);
   257			return ret;
   258		}
   259	
   260		val = readl(ddata->regs + PWM_SIFIVE_PWMCFG);
   261		if (val & PWM_SIFIVE_PWMCFG_EN_ALWAYS) {
   262			unsigned int i;
   263	
   264			for (i = 0; i < chip->npwm; ++i) {
   265				val = readl(ddata->regs + PWM_SIFIVE_PWMCMP(i));
   266				if (val > 0)
   267					++enabled_pwms;
   268			}
   269		}
   270	
   271		/* The clk should be on once for each running PWM. */
   272		if (enabled_pwms) {
   273			while (enabled_clks < enabled_pwms) {
   274				/* This is not expected to fail as the clk is already on */
   275				ret = clk_enable(ddata->clk);
   276				if (unlikely(ret)) {
   277					dev_err_probe(dev, ret, "Failed to enable clk\n");
   278					goto disable_clk;
   279				}
   280				++enabled_clks;
   281			}
   282		} else {
   283			clk_disable(ddata->clk);
   284			enabled_clks = 0;
   285		}
   286	
   287		/* Watch for changes to underlying clock frequency */
   288		ddata->notifier.notifier_call = pwm_sifive_clock_notifier;
   289		ret = clk_notifier_register(ddata->clk, &ddata->notifier);
   290		if (ret) {
   291			dev_err(dev, "failed to register clock notifier: %d\n", ret);
   292			goto disable_clk;
   293		}
   294	
   295		ret = pwmchip_add(chip);
   296		if (ret < 0) {
   297			dev_err(dev, "cannot register PWM: %d\n", ret);
   298			goto unregister_clk;
   299		}
   300	
   301		platform_set_drvdata(pdev, chip);
   302		dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
   303	
   304		return 0;
   305	
   306	unregister_clk:
   307		clk_notifier_unregister(ddata->clk, &ddata->notifier);
   308	disable_clk:
   309		while (enabled_clks) {
   310			clk_disable(ddata->clk);
   311			--enabled_clks;
   312		}
   313	
   314		return ret;
   315	}
   316	
   317	static void pwm_sifive_remove(struct platform_device *dev)
   318	{
   319		struct pwm_chip *chip = platform_get_drvdata(dev);
   320		struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
   321		struct pwm_device *pwm;
   322		int ch;
   323	
   324		pwmchip_remove(chip);
   325		clk_notifier_unregister(ddata->clk, &ddata->notifier);
   326	
   327		for (ch = 0; ch < chip->npwm; ch++) {
   328			pwm = &chip->pwms[ch];
   329			if (pwm->state.enabled)
   330				clk_disable(ddata->clk);
   331		}
   332	}
   333	
   334	static const struct of_device_id pwm_sifive_of_match[] = {
   335		{ .compatible = "sifive,pwm0" },
   336		{},
   337	};
   338	MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
   339	
   340	static struct platform_driver pwm_sifive_driver = {
   341		.probe = pwm_sifive_probe,
   342		.remove = pwm_sifive_remove,
   343		.driver = {
   344			.name = "pwm-sifive",
   345			.of_match_table = pwm_sifive_of_match,
   346		},
   347	};
   348	module_platform_driver(pwm_sifive_driver);
   349	
   350	MODULE_DESCRIPTION("SiFive PWM driver");
 > 351	MODULE_LICENSE("GPL v2");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

