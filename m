Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469F8564C4
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 10:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfFZInr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 04:43:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:49037
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfFZInr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 04:43:47 -0400
X-IronPort-AV: E=Sophos;i="5.63,419,1557180000"; 
   d="scan'208";a="311457712"
Received: from wifi-eduroam-0-109.u-strasbg.fr (HELO hadrien) ([130.79.0.109])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:43:43 +0200
Date:   Wed, 26 Jun 2019 10:43:43 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Patrick Havelange <patrick.havelange@essensium.com>
cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kbuild-all@01.org
Subject: [pwm:for-next 36/37] drivers/pwm/pwm-fsl-ftm.c:324:3-9: preceding
 lock on line 305 (fwd)
Message-ID: <alpine.DEB.2.21.1906261042400.2523@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

It seems like there may be missing unlocks on lines 324 and 328.

julia

---------- Forwarded message ----------
Date: Wed, 26 Jun 2019 12:23:38 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pwm:for-next 36/37] drivers/pwm/pwm-fsl-ftm.c:324:3-9: preceding lock
    on line 305

CC: kbuild-all@01.org
CC: linux-pwm@vger.kernel.org
TO: Patrick Havelange <patrick.havelange@essensium.com>
CC: Thierry Reding <thierry.reding@gmail.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
head:   cb8338e4fe3a8278cee91f666d2155a0ce1dd82f
commit: c9aad8a921c23054dc10e783829fe6ee86826101 [36/37] pwm: fsl-ftm: More relaxed permissions for updating period
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/pwm/pwm-fsl-ftm.c:324:3-9: preceding lock on line 305
   drivers/pwm/pwm-fsl-ftm.c:328:3-9: preceding lock on line 305

# https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git/commit/?id=c9aad8a921c23054dc10e783829fe6ee86826101
git remote add pwm https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
git remote update pwm
git checkout c9aad8a921c23054dc10e783829fe6ee86826101
vim +324 drivers/pwm/pwm-fsl-ftm.c

b505183b Xiubo Li          2014-02-27  288
c9aad8a9 Patrick Havelange 2019-06-12  289  static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
c9aad8a9 Patrick Havelange 2019-06-12  290  			 struct pwm_state *newstate)
b505183b Xiubo Li          2014-02-27  291  {
b505183b Xiubo Li          2014-02-27  292  	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
c9aad8a9 Patrick Havelange 2019-06-12  293  	struct pwm_state *oldstate = &pwm->state;
c9aad8a9 Patrick Havelange 2019-06-12  294  	int ret = 0;
b505183b Xiubo Li          2014-02-27  295
c9aad8a9 Patrick Havelange 2019-06-12  296  	/*
c9aad8a9 Patrick Havelange 2019-06-12  297  	 * oldstate to newstate : action
c9aad8a9 Patrick Havelange 2019-06-12  298  	 *
c9aad8a9 Patrick Havelange 2019-06-12  299  	 * disabled to disabled : ignore
c9aad8a9 Patrick Havelange 2019-06-12  300  	 * enabled to disabled : disable
c9aad8a9 Patrick Havelange 2019-06-12  301  	 * enabled to enabled : update settings
c9aad8a9 Patrick Havelange 2019-06-12  302  	 * disabled to enabled : update settings + enable
c9aad8a9 Patrick Havelange 2019-06-12  303  	 */
b505183b Xiubo Li          2014-02-27  304
c9aad8a9 Patrick Havelange 2019-06-12 @305  	mutex_lock(&fpc->lock);
b505183b Xiubo Li          2014-02-27  306
c9aad8a9 Patrick Havelange 2019-06-12  307  	if (!newstate->enabled) {
c9aad8a9 Patrick Havelange 2019-06-12  308  		if (oldstate->enabled) {
c9aad8a9 Patrick Havelange 2019-06-12  309  			regmap_update_bits(fpc->regmap, FTM_OUTMASK,
c9aad8a9 Patrick Havelange 2019-06-12  310  					   BIT(pwm->hwpwm), BIT(pwm->hwpwm));
c9aad8a9 Patrick Havelange 2019-06-12  311  			clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
c9aad8a9 Patrick Havelange 2019-06-12  312  			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
c9aad8a9 Patrick Havelange 2019-06-12  313  		}
c9aad8a9 Patrick Havelange 2019-06-12  314  		goto end_mutex;
b505183b Xiubo Li          2014-02-27  315  	}
b505183b Xiubo Li          2014-02-27  316
c9aad8a9 Patrick Havelange 2019-06-12  317  	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
c9aad8a9 Patrick Havelange 2019-06-12  318  	if (ret)
c9aad8a9 Patrick Havelange 2019-06-12  319  		goto end_mutex;
c9aad8a9 Patrick Havelange 2019-06-12  320  	/* check if need to enable */
c9aad8a9 Patrick Havelange 2019-06-12  321  	if (!oldstate->enabled) {
c9aad8a9 Patrick Havelange 2019-06-12  322  		ret = clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
b505183b Xiubo Li          2014-02-27  323  		if (ret)
b505183b Xiubo Li          2014-02-27 @324  			return ret;
b505183b Xiubo Li          2014-02-27  325  		ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
b505183b Xiubo Li          2014-02-27  326  		if (ret) {
c9aad8a9 Patrick Havelange 2019-06-12  327  			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
b505183b Xiubo Li          2014-02-27  328  			return ret;
b505183b Xiubo Li          2014-02-27  329  		}
c9aad8a9 Patrick Havelange 2019-06-12  330  		regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm),
c9aad8a9 Patrick Havelange 2019-06-12  331  				   0);
b505183b Xiubo Li          2014-02-27  332  	}
b505183b Xiubo Li          2014-02-27  333
c9aad8a9 Patrick Havelange 2019-06-12  334  end_mutex:
b505183b Xiubo Li          2014-02-27  335  	mutex_unlock(&fpc->lock);
b505183b Xiubo Li          2014-02-27  336  	return ret;
b505183b Xiubo Li          2014-02-27  337  }
b505183b Xiubo Li          2014-02-27  338

:::::: The code at line 324 was first introduced by commit
:::::: b505183b5117ce149c65ae62f8c00e889acafa69 pwm: Add Freescale FTM PWM driver support

:::::: TO: Xiubo Li <Li.Xiubo@freescale.com>
:::::: CC: Thierry Reding <thierry.reding@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
