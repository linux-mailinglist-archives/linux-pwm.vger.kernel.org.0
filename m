Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D264ACA58
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiBGU0b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 15:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiBGUX6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 15:23:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DAC0401DA
        for <linux-pwm@vger.kernel.org>; Mon,  7 Feb 2022 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644265437; x=1675801437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WX/QWphywdX4X9SXBJw5KgJQb2HOEeFXMw5MNbnu9eA=;
  b=FosN/GgcKr8JtklP1Uu0X/2fIuexT8zVD4uywguUkeQjXgcKcykociF0
   UKskSiTrTm2Oi7ngeAaX6ZYqzDK38z1Di1RrzjqQ8O6WlvGMRCljs9EjG
   vmvjFbAGBpBvrrhOeyicBMunVwBLveHS6XWmsfb16cVrIU6G/Af4TtcDt
   8b/tIApBO25BkF6x4zIL38BdKIUebBLDp1teDKJ9igPqF63SUrcT1OmVt
   qy9CJ0ztYQ3AVdRcG+fughlas8Z5Iq1y8rF6yA1O/YbZllgE7YPr1j7Hr
   C6JHse58PcvWlmBeQ+HlNftfINITnLZrh1rttZhwHUB9DIl7buxH+oO0Z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="273325529"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="273325529"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 12:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="632597119"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2022 12:23:53 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHAYC-0000w4-Um; Mon, 07 Feb 2022 20:23:52 +0000
Date:   Tue, 8 Feb 2022 04:22:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baruch Siach <baruch@tkos.co.il>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Baruch Siach <baruch.siach@siklu.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <202202080410.R0qwqtXx-lkp@intel.com>
References: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Baruch,

I love your patch! Perhaps something to improve:

[auto build test WARNING on thierry-reding-pwm/for-next]
[also build test WARNING on robh/for-next v5.17-rc3 next-20220207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Baruch-Siach/pwm-driver-for-qualcomm-ipq6018-pwm-block/20220207-175605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220208/202202080410.R0qwqtXx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0d8850ae2cae85d49bea6ae0799fa41c7202c05c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/71e449eb6d19b141b4527caae529e16c52bcfeea
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Baruch-Siach/pwm-driver-for-qualcomm-ipq6018-pwm-block/20220207-175605
        git checkout 71e449eb6d19b141b4527caae529e16c52bcfeea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-ipq.c:122:11: warning: result of comparison of constant 16000000000 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
           if (rate > 16ULL * GIGA)
               ~~~~ ^ ~~~~~~~~~~~~
   1 warning generated.


vim +122 drivers/pwm/pwm-ipq.c

    99	
   100	static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   101				 const struct pwm_state *state)
   102	{
   103		struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
   104		unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
   105		unsigned long rate = clk_get_rate(ipq_chip->clk);
   106		u64 period_ns, duty_ns, period_rate;
   107		u64 min_diff;
   108	
   109		if (state->polarity != PWM_POLARITY_NORMAL)
   110			return -EINVAL;
   111	
   112		if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
   113			return -ERANGE;
   114	
   115		period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
   116		duty_ns = min(state->duty_cycle, period_ns);
   117	
   118		/*
   119		 * period_ns is 1G or less. As long as rate is less than 16 GHz,
   120		 * period_rate does not overflow. Make that explicit.
   121		 */
 > 122		if (rate > 16ULL * GIGA)
   123			return -EINVAL;
   124		period_rate = period_ns * rate;
   125		best_pre_div = IPQ_PWM_MAX_DIV;
   126		best_pwm_div = IPQ_PWM_MAX_DIV;
   127		/*
   128		 * We don't need to consider pre_div values smaller than
   129		 *
   130		 *                              period_rate
   131		 *  pre_div_min := ------------------------------------
   132		 *                 NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1)
   133		 *
   134		 * because pre_div = pre_div_min results in a better
   135		 * approximation.
   136		 */
   137		pre_div = div64_u64(period_rate,
   138				(u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
   139		min_diff = period_rate;
   140	
   141		for (; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
   142			u64 remainder;
   143	
   144			pwm_div = div64_u64_rem(period_rate,
   145					(u64)NSEC_PER_SEC * (pre_div + 1), &remainder);
   146			/* pwm_div is unsigned; the check below catches underflow */
   147			pwm_div--;
   148	
   149			/*
   150			 * Swapping values for pre_div and pwm_div produces the same
   151			 * period length. So we can skip all settings with pre_div >
   152			 * pwm_div which results in bigger constraints for selecting
   153			 * the duty_cycle than with the two values swapped.
   154			 */
   155			if (pre_div > pwm_div)
   156				break;
   157	
   158			/*
   159			 * Make sure we can do 100% duty cycle where
   160			 * hi_dur == pwm_div + 1
   161			 */
   162			if (pwm_div > IPQ_PWM_MAX_DIV - 1)
   163				continue;
   164	
   165			if (remainder < min_diff) {
   166				best_pre_div = pre_div;
   167				best_pwm_div = pwm_div;
   168				min_diff = remainder;
   169	
   170				if (min_diff == 0) /* bingo */
   171					break;
   172			}
   173		}
   174	
   175		/* config divider values for the closest possible frequency */
   176		config_div_and_duty(pwm, best_pre_div, best_pwm_div,
   177				    rate, duty_ns, state->enabled);
   178	
   179		return 0;
   180	}
   181	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
