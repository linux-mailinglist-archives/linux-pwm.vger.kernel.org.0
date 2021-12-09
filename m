Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71C46F279
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Dec 2021 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhLIRyc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Dec 2021 12:54:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:47736 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhLIRyc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Dec 2021 12:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639072259; x=1670608259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8cIYI40neCADt4aUb3nQ9Z2alLV3URHJWcUBWC8I5Vw=;
  b=c/k20EXcnl77o8JzxnU10X5h3FlPCXBkUK0JgVoiPCqilac81LDxwPzq
   6zyFVJBAGaMKeDZ+zJgJa0J8Uw97+G9RWVygqhDkKJs204b6w6myxEIsO
   ssBKrOuN3cvSKMT5ulekqV7AVFpOLdLkCzKyX0sp4w60pNyQoETQ1PZc2
   aF1XTRYM8Zc8RwZFV5PZSBlxN2VtGHBU9YQEV0SE5zT8RJwEaJf9e5LXc
   ELGxMs6mAmHtPRncBuwGN+hOkRiLmU71ZKQCF7LQ+V8bGEkDw+znuGP3w
   alZ/fbht+eb7DR3osl6w5gqZJO3xFZXsquEu3xG+8EIIiZ+2Id99tMfUD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225033132"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="225033132"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="462229703"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2021 09:50:36 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvNYx-0002EE-3Q; Thu, 09 Dec 2021 17:50:35 +0000
Date:   Fri, 10 Dec 2021 01:49:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Clark Wang <xiaoning.wang@nxp.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     kbuild-all@lists.01.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <202112100135.Qng8J561-lkp@intel.com>
References: <20211208085407.780844-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208085407.780844-1-xiaoning.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Clark,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on thierry-reding-pwm/for-next]
[also build test WARNING on v5.16-rc4 next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Clark-Wang/pwm-imx27-workaround-of-the-pwm-output-bug-when-decrease-the-duty-cycle/20211208-165523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: riscv-randconfig-s031-20211209 (https://download.01.org/0day-ci/archive/20211210/202112100135.Qng8J561-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e56186a9b8501a89d138d2072cc63d107fb303a0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Clark-Wang/pwm-imx27-workaround-of-the-pwm-output-bug-when-decrease-the-duty-cycle/20211208-165523
        git checkout e56186a9b8501a89d138d2072cc63d107fb303a0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pwm/pwm-imx27.c:301:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sar_last @@     got restricted __le32 [usertype] @@
   drivers/pwm/pwm-imx27.c:301:26: sparse:     expected unsigned int [usertype] sar_last
   drivers/pwm/pwm-imx27.c:301:26: sparse:     got restricted __le32 [usertype]
>> drivers/pwm/pwm-imx27.c:302:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sar_current @@     got restricted __le32 [usertype] @@
   drivers/pwm/pwm-imx27.c:302:29: sparse:     expected unsigned int [usertype] sar_current
   drivers/pwm/pwm-imx27.c:302:29: sparse:     got restricted __le32 [usertype]

vim +301 drivers/pwm/pwm-imx27.c

   217	
   218	static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   219				   const struct pwm_state *state)
   220	{
   221		unsigned long period_cycles, duty_cycles, prescale, counter_check, flags;
   222		struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
   223		void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
   224		__force u32 sar_last, sar_current;
   225		struct pwm_state cstate;
   226		unsigned long long c;
   227		unsigned long long clkrate;
   228		int ret;
   229		u32 cr, timeout = 1000;
   230	
   231		pwm_get_state(pwm, &cstate);
   232	
   233		clkrate = clk_get_rate(imx->clk_per);
   234		c = clkrate * state->period;
   235	
   236		do_div(c, NSEC_PER_SEC);
   237		period_cycles = c;
   238	
   239		prescale = period_cycles / 0x10000 + 1;
   240	
   241		period_cycles /= prescale;
   242		c = clkrate * state->duty_cycle;
   243		do_div(c, NSEC_PER_SEC);
   244		duty_cycles = c;
   245		duty_cycles /= prescale;
   246	
   247		/*
   248		 * according to imx pwm RM, the real period value should be PERIOD
   249		 * value in PWMPR plus 2.
   250		 */
   251		if (period_cycles > 2)
   252			period_cycles -= 2;
   253		else
   254			period_cycles = 0;
   255	
   256		/*
   257		 * Wait for a free FIFO slot if the PWM is already enabled, and flush
   258		 * the FIFO if the PWM was disabled and is about to be enabled.
   259		 */
   260		if (cstate.enabled) {
   261			pwm_imx27_wait_fifo_slot(chip, pwm);
   262		} else {
   263			ret = pwm_imx27_clk_prepare_enable(imx);
   264			if (ret)
   265				return ret;
   266	
   267			pwm_imx27_sw_reset(chip);
   268		}
   269	
   270		/*
   271		 * This is a limited workaround. When the SAR FIFO is empty, the new
   272		 * write value will be directly applied to SAR even the current period
   273		 * is not over.
   274		 * If the new SAR value is less than the old one, and the counter is
   275		 * greater than the new SAR value, the current period will not filp
   276		 * the level. This will result in a pulse with a duty cycle of 100%.
   277		 * So, writing the current value of the SAR to SAR here before updating
   278		 * the new SAR value can avoid this issue.
   279		 *
   280		 * Add a spin lock and turn off the interrupt to ensure that the
   281		 * real-time performance can be guaranteed as much as possible when
   282		 * operating the following operations.
   283		 *
   284		 * 1. Add a threshold of 1.5us. If the time T between the read current
   285		 * count value CNR and the end of the cycle is less than 1.5us, wait
   286		 * for T to be longer than 1.5us before updating the SAR register.
   287		 * This is to avoid the situation that when the first SAR is written,
   288		 * the current cycle just ends and the SAR FIFO that just be written
   289		 * is emptied again.
   290		 *
   291		 * 2. Use __raw_writel() to minimize the interval between two writes to
   292		 * the SAR register to increase the fastest pwm frequency supported.
   293		 *
   294		 * When the PWM period is longer than 2us(or <500KHz), this workaround
   295		 * can solve this problem.
   296		 */
   297		if (duty_cycles < imx->duty_cycle) {
   298			c = clkrate * 1500;
   299			do_div(c, NSEC_PER_SEC);
   300			counter_check = c;
 > 301			sar_last = cpu_to_le32(imx->duty_cycle);
 > 302			sar_current = cpu_to_le32(duty_cycles);
   303	
   304			spin_lock_irqsave(&imx->lock, flags);
   305			if (state->period >= 2000) {
   306				while ((period_cycles -
   307					readl_relaxed(imx->mmio_base + MX3_PWMCNR))
   308					< counter_check) {
   309					if (!--timeout)
   310						break;
   311				};
   312			}
   313			if (!(MX3_PWMSR_FIFOAV &
   314			      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
   315				__raw_writel(sar_last, reg_sar);
   316			__raw_writel(sar_current, reg_sar);
   317			spin_unlock_irqrestore(&imx->lock, flags);
   318		} else
   319			writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
   320	
   321		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
   322	
   323		/*
   324		 * Store the duty cycle for future reference in cases where the
   325		 * MX3_PWMSAR register can't be read (i.e. when the PWM is disabled).
   326		 */
   327		imx->duty_cycle = duty_cycles;
   328	
   329		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
   330		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
   331		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
   332		     MX3_PWMCR_DBGEN;
   333	
   334		if (state->polarity == PWM_POLARITY_INVERSED)
   335			cr |= FIELD_PREP(MX3_PWMCR_POUTC,
   336					MX3_PWMCR_POUTC_INVERTED);
   337	
   338		if (state->enabled)
   339			cr |= MX3_PWMCR_EN;
   340	
   341		writel(cr, imx->mmio_base + MX3_PWMCR);
   342	
   343		if (!state->enabled)
   344			pwm_imx27_clk_disable_unprepare(imx);
   345	
   346		return 0;
   347	}
   348	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
