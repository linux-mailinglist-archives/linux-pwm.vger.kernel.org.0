Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1E42885
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfFLONO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 10:13:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34343 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbfFLONN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 10:13:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26so26017056edt.1
        for <linux-pwm@vger.kernel.org>; Wed, 12 Jun 2019 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOEzD4x7sE+UJ4RALwDC2MOHD5L/STV945OEUN3p2f4=;
        b=CQzBzgu6YGFX42esIuWazQgRyZ8uHklWlawm+hYZ/bykcYJVFZyY5EmfQBTIjYQO8v
         HP92MI7JCZdSvP+zCQIzTBbJDouZiU13SDH16nazp3HdgJa8+7Ez2ibMw4q7PPjZW41L
         ChcRmT44PKsAfCjMCD0z/VTZRP7pLLxsgksExO9bm+RHuRMqLpGYjZL6A4DMRJ2dOAR7
         ZdNVXXyp6VOm+hJ+IHmPjIekML4d49BJdDznv8Luo+XOSVnmYiRs9JPgIudQouJCMMxO
         GJzJZOMAPujaKI2y12Iz+UHzc+KN4yCllLSqnBb12ZDr1ftRWefr7s7EUIf448uk0uQw
         f8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOEzD4x7sE+UJ4RALwDC2MOHD5L/STV945OEUN3p2f4=;
        b=QTWipWSoxZesPMlr3FsWfGdDWQHRkrswxTdbr2Q4JsH0//kIMF92yu/klySz/t8xrF
         5PYSmmcNSSQAB2hZPyoA34Lvu0jqZYU+JKokNtS+J0SA8Eh6ZB7Ewnqbf3p/kqsMenrD
         QYNxsQGiCy994hrvq++eGlYDNiydoRBbfYokf2KOesfGq8vQFBYA0QVQ3IWpg7dZW1Ep
         4033QDZcpLt95Vc7UOxIrf0aVRuVthbBKXwc2g1qWY3kVCxJhqtgNZ0GjhTNNWDkJMf1
         8eEZGJoREAT9HVOR4Vc++/J3MJwDKaHH1mRMVJo2NmIiH1SgYbwVo7EC3Eqy51A3iYt+
         Eejg==
X-Gm-Message-State: APjAAAXu0+bvAgYB+kNoiWWzUxMF8vtGXTK0xtH9qqSWqXsIZFTLVvr2
        Qop+uVya6VGJ2DLquzL672R63Q==
X-Google-Smtp-Source: APXvYqxJKsUdiei92McatgFMKlaRxsuyHJtcKKdnO80MfwGMUIenhza0Lj28k81ncdvv5wjAmNGrig==
X-Received: by 2002:a17:906:5007:: with SMTP id s7mr30990607ejj.81.1560348790471;
        Wed, 12 Jun 2019 07:13:10 -0700 (PDT)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id g2sm7095eja.23.2019.06.12.07.13.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:13:09 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <Li.Xiubo@freescale.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/2] pwm: pwm-fsl-ftm: more relaxed permissions for updating period
Date:   Wed, 12 Jun 2019 16:12:45 +0200
Message-Id: <20190612141246.7366-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Flextimer has only one period for several channels. The PWM
subsystem doesn't allow to model something like that. The current
implementation simply disallows changing the period once it has
been set, having as a side effect that you need to enable and
disable the PWM if you want to change the period.

The driver should allow as much freedom as possible for configuring
the period and duty cycle. Therefore, this patch reworks the code
to allow the following:

- period and duty_cycle can be set at will when the pwm is disabled;
- when enabling a pwm, verify that the period is either not set yet,
  or the same as the other already enabled pwm(s), and fail if not;
- allow to change the period on the fly when the pwm is the only one
  enabled.

It also allows to have different periods configured for different pwms.
Only one period can be used at a time, thus the first pwm to be enabled
will set that period, only other pwms with that same period can be
enabled at the same time. To use another pwm with another period, the
enabled pwms must be disabled first.

Example scenario :
echo 5000000 > pwm0/period	#OK
echo 1000000 > pwm0/duty_cycle	#OK
echo 1000000 > pwm1/period	#OK
echo 1000000 > pwm1/duty_cycle	#OK
echo 1 > pwm0/enable		#OK
echo 1 > pwm1/enable		#FAIL (pwm0/period != pwm1/period)
echo 0 > pwm0/enable		#OK
echo 1 > pwm1/enable		#OK
echo 1000000 > pwm0/period	#OK
echo 2000000 > pwm0/period	#OK
echo 1 > pwm0/enable		#FAIL (pwm0/period != pwm1/period)
echo 2000000 > pwm1/period	#OK (pwm1 still running, changed on the fly)
echo 1 > pwm0/enable		#OK (now pwm0/period == pwm1/period)
echo 3000000 > pwm1/period	#FAIL (other pwms running)
echo 0 > pwm0/enable		#OK
echo 3000000 > pwm1/period	#OK (only this pwm running)

Adapting the code to satisfy these constraints turned up a number of
additional issues with the current implementation:
- the prescaler value 0 was not used (when it could have been);
- when setting the period was not possible, the internal state was
  inconsistent;
- the maximal value for configuring the period was never used;

Since all of these interact with each other, rather than trying to fix
each individual issue, this patch reworks how the period and duty cycle are
set entirely, with the following additional improvements:
- implement the new apply() method instead of the individual methods;
- return the exact used period/duty_cycle values;
- more coherent argument types for period, duty_cycle;

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 364 +++++++++++++++++++-------------------
 1 file changed, 183 insertions(+), 181 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index a39b48839df7..cd5fe39ab95d 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -34,17 +34,19 @@ struct fsl_ftm_soc {
 	bool has_enable_bits;
 };
 
+struct fsl_pwm_periodcfg {
+	enum fsl_pwm_clk clk_select;
+	unsigned int clk_ps;
+	unsigned int mod_period;
+};
+
 struct fsl_pwm_chip {
 	struct pwm_chip chip;
-
 	struct mutex lock;
-
-	unsigned int cnt_select;
-	unsigned int clk_ps;
-
 	struct regmap *regmap;
 
-	int period_ns;
+	/* This value is valid iff a pwm is running */
+	struct fsl_pwm_periodcfg period;
 
 	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
@@ -57,6 +59,18 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 	return container_of(chip, struct fsl_pwm_chip, chip);
 }
 
+static bool fsl_pwm_periodcfg_are_equal(const struct fsl_pwm_periodcfg *a,
+					const struct fsl_pwm_periodcfg *b)
+{
+	if (a->clk_select != b->clk_select)
+		return false;
+	if (a->clk_ps != b->clk_ps)
+		return false;
+	if (a->mod_period != b->mod_period)
+		return false;
+	return true;
+}
+
 static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	int ret;
@@ -87,89 +101,58 @@ static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(fpc->ipg_clk);
 }
 
-static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
-					enum fsl_pwm_clk index)
+static unsigned int fsl_pwm_ticks_to_ns(struct fsl_pwm_chip *fpc,
+					  unsigned int ticks)
 {
-	unsigned long sys_rate, cnt_rate;
-	unsigned long long ratio;
-
-	sys_rate = clk_get_rate(fpc->clk[FSL_PWM_CLK_SYS]);
-	if (!sys_rate)
-		return -EINVAL;
-
-	cnt_rate = clk_get_rate(fpc->clk[fpc->cnt_select]);
-	if (!cnt_rate)
-		return -EINVAL;
-
-	switch (index) {
-	case FSL_PWM_CLK_SYS:
-		fpc->clk_ps = 1;
-		break;
-	case FSL_PWM_CLK_FIX:
-		ratio = 2 * cnt_rate - 1;
-		do_div(ratio, sys_rate);
-		fpc->clk_ps = ratio;
-		break;
-	case FSL_PWM_CLK_EXT:
-		ratio = 4 * cnt_rate - 1;
-		do_div(ratio, sys_rate);
-		fpc->clk_ps = ratio;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
+	unsigned long rate;
+	unsigned long long exval;
+
+	rate = clk_get_rate(fpc->clk[fpc->period.clk_select]);
+	exval = ticks;
+	exval *= 1000000000UL;
+	do_div(exval, rate >> fpc->period.clk_ps);
+	return exval;
 }
 
-static unsigned long fsl_pwm_calculate_cycles(struct fsl_pwm_chip *fpc,
-					      unsigned long period_ns)
+static bool fsl_pwm_calculate_period_clk(struct fsl_pwm_chip *fpc,
+					 unsigned int period_ns,
+					 enum fsl_pwm_clk index,
+					 struct fsl_pwm_periodcfg *periodcfg
+					 )
 {
-	unsigned long long c, c0;
+	unsigned long long c;
+	unsigned int ps;
 
-	c = clk_get_rate(fpc->clk[fpc->cnt_select]);
+	c = clk_get_rate(fpc->clk[index]);
 	c = c * period_ns;
 	do_div(c, 1000000000UL);
 
-	do {
-		c0 = c;
-		do_div(c0, (1 << fpc->clk_ps));
-		if (c0 <= 0xFFFF)
-			return (unsigned long)c0;
-	} while (++fpc->clk_ps < 8);
-
-	return 0;
-}
-
-static unsigned long fsl_pwm_calculate_period_cycles(struct fsl_pwm_chip *fpc,
-						     unsigned long period_ns,
-						     enum fsl_pwm_clk index)
-{
-	int ret;
+	if (c == 0)
+		return false;
 
-	ret = fsl_pwm_calculate_default_ps(fpc, index);
-	if (ret) {
-		dev_err(fpc->chip.dev,
-			"failed to calculate default prescaler: %d\n",
-			ret);
-		return 0;
+	for (ps = 0; ps < 8 ; ++ps, c >>= 1) {
+		if (c <= 0x10000) {
+			periodcfg->clk_select = index;
+			periodcfg->clk_ps = ps;
+			periodcfg->mod_period = c - 1;
+			return true;
+		}
 	}
-
-	return fsl_pwm_calculate_cycles(fpc, period_ns);
+	return false;
 }
 
-static unsigned long fsl_pwm_calculate_period(struct fsl_pwm_chip *fpc,
-					      unsigned long period_ns)
+static bool fsl_pwm_calculate_period(struct fsl_pwm_chip *fpc,
+				     unsigned int period_ns,
+				     struct fsl_pwm_periodcfg *periodcfg)
 {
 	enum fsl_pwm_clk m0, m1;
-	unsigned long fix_rate, ext_rate, cycles;
+	unsigned long fix_rate, ext_rate;
+	bool ret;
 
-	cycles = fsl_pwm_calculate_period_cycles(fpc, period_ns,
-			FSL_PWM_CLK_SYS);
-	if (cycles) {
-		fpc->cnt_select = FSL_PWM_CLK_SYS;
-		return cycles;
-	}
+	ret = fsl_pwm_calculate_period_clk(fpc, period_ns, FSL_PWM_CLK_SYS,
+					   periodcfg);
+	if (ret)
+		return true;
 
 	fix_rate = clk_get_rate(fpc->clk[FSL_PWM_CLK_FIX]);
 	ext_rate = clk_get_rate(fpc->clk[FSL_PWM_CLK_EXT]);
@@ -182,158 +165,177 @@ static unsigned long fsl_pwm_calculate_period(struct fsl_pwm_chip *fpc,
 		m1 = FSL_PWM_CLK_FIX;
 	}
 
-	cycles = fsl_pwm_calculate_period_cycles(fpc, period_ns, m0);
-	if (cycles) {
-		fpc->cnt_select = m0;
-		return cycles;
-	}
-
-	fpc->cnt_select = m1;
+	ret = fsl_pwm_calculate_period_clk(fpc, period_ns, m0, periodcfg);
+	if (ret)
+		return true;
 
-	return fsl_pwm_calculate_period_cycles(fpc, period_ns, m1);
+	return fsl_pwm_calculate_period_clk(fpc, period_ns, m1, periodcfg);
 }
 
-static unsigned long fsl_pwm_calculate_duty(struct fsl_pwm_chip *fpc,
-					    unsigned long period_ns,
-					    unsigned long duty_ns)
+static unsigned int fsl_pwm_calculate_duty(struct fsl_pwm_chip *fpc,
+					   unsigned int duty_ns)
 {
 	unsigned long long duty;
-	u32 val;
 
-	regmap_read(fpc->regmap, FTM_MOD, &val);
-	duty = (unsigned long long)duty_ns * (val + 1);
+	unsigned int period = fpc->period.mod_period + 1;
+	unsigned int period_ns = fsl_pwm_ticks_to_ns(fpc, period);
+
+	duty = (unsigned long long)duty_ns * period;
 	do_div(duty, period_ns);
 
-	return (unsigned long)duty;
+	return (unsigned int)duty;
 }
 
-static int fsl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			  int duty_ns, int period_ns)
+static bool fsl_pwm_is_any_pwm_enabled(struct fsl_pwm_chip *fpc,
+				       struct pwm_device *pwm)
 {
-	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
-	u32 period, duty;
+	u32 val;
 
-	mutex_lock(&fpc->lock);
+	regmap_read(fpc->regmap, FTM_OUTMASK, &val);
+	if (~val & 0xFF)
+		return true;
+	else
+		return false;
+}
+
+static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
+					 struct pwm_device *pwm)
+{
+	u32 val;
+
+	regmap_read(fpc->regmap, FTM_OUTMASK, &val);
+	if (~(val | BIT(pwm->hwpwm)) & 0xFF)
+		return true;
+	else
+		return false;
+}
+
+static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
+				struct pwm_device *pwm,
+				struct pwm_state *newstate)
+{
+	unsigned int duty;
+	u32 reg_polarity;
 
+	struct fsl_pwm_periodcfg periodcfg;
+	bool do_write_period = false;
+
+	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
+		dev_err(fpc->chip.dev, "failed to calculate new period\n");
+		return -EINVAL;
+	}
+
+	if (!fsl_pwm_is_any_pwm_enabled(fpc, pwm))
+		do_write_period = true;
 	/*
 	 * The Freescale FTM controller supports only a single period for
-	 * all PWM channels, therefore incompatible changes need to be
-	 * refused.
+	 * all PWM channels, therefore verify if the newly computed period
+	 * is different than the current period being used. In such case
+	 * we allow to change the period only if no other pwm is running.
 	 */
-	if (fpc->period_ns && fpc->period_ns != period_ns) {
-		dev_err(fpc->chip.dev,
-			"conflicting period requested for PWM %u\n",
-			pwm->hwpwm);
-		mutex_unlock(&fpc->lock);
-		return -EBUSY;
-	}
-
-	if (!fpc->period_ns && duty_ns) {
-		period = fsl_pwm_calculate_period(fpc, period_ns);
-		if (!period) {
-			dev_err(fpc->chip.dev, "failed to calculate period\n");
-			mutex_unlock(&fpc->lock);
-			return -EINVAL;
+	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
+		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
+			dev_err(fpc->chip.dev,
+				"Cannot change period for PWM %u, disable other PWMs first\n",
+				pwm->hwpwm);
+			return -EBUSY;
 		}
+		if (fpc->period.clk_select != periodcfg.clk_select) {
+			int ret;
+			enum fsl_pwm_clk oldclk = fpc->period.clk_select;
+			enum fsl_pwm_clk newclk = periodcfg.clk_select;
+
+			ret = clk_prepare_enable(fpc->clk[newclk]);
+			if (ret)
+				return ret;
+			clk_disable_unprepare(fpc->clk[oldclk]);
+		}
+		do_write_period = true;
+	}
 
+	if (do_write_period) {
+		regmap_update_bits(fpc->regmap, FTM_SC, FTM_SC_CLK_MASK,
+				   FTM_SC_CLK(periodcfg.clk_select));
 		regmap_update_bits(fpc->regmap, FTM_SC, FTM_SC_PS_MASK,
-				   fpc->clk_ps);
-		regmap_write(fpc->regmap, FTM_MOD, period - 1);
+				   periodcfg.clk_ps);
+		regmap_write(fpc->regmap, FTM_MOD, periodcfg.mod_period);
 
-		fpc->period_ns = period_ns;
+		fpc->period = periodcfg;
 	}
 
-	mutex_unlock(&fpc->lock);
-
-	duty = fsl_pwm_calculate_duty(fpc, period_ns, duty_ns);
+	duty = fsl_pwm_calculate_duty(fpc, newstate->duty_cycle);
 
 	regmap_write(fpc->regmap, FTM_CSC(pwm->hwpwm),
 		     FTM_CSC_MSB | FTM_CSC_ELSB);
 	regmap_write(fpc->regmap, FTM_CV(pwm->hwpwm), duty);
 
-	return 0;
-}
-
-static int fsl_pwm_set_polarity(struct pwm_chip *chip,
-				struct pwm_device *pwm,
-				enum pwm_polarity polarity)
-{
-	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
-	u32 val;
-
-	regmap_read(fpc->regmap, FTM_POL, &val);
-
-	if (polarity == PWM_POLARITY_INVERSED)
-		val |= BIT(pwm->hwpwm);
-	else
-		val &= ~BIT(pwm->hwpwm);
-
-	regmap_write(fpc->regmap, FTM_POL, val);
-
-	return 0;
-}
-
-static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
-{
-	int ret;
-
-	/* select counter clock source */
-	regmap_update_bits(fpc->regmap, FTM_SC, FTM_SC_CLK_MASK,
-			   FTM_SC_CLK(fpc->cnt_select));
+	reg_polarity = 0;
+	if (newstate->polarity == PWM_POLARITY_INVERSED)
+		reg_polarity = BIT(pwm->hwpwm);
 
-	ret = clk_prepare_enable(fpc->clk[fpc->cnt_select]);
-	if (ret)
-		return ret;
+	regmap_update_bits(fpc->regmap, FTM_POL, BIT(pwm->hwpwm), reg_polarity);
 
-	ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
-	if (ret) {
-		clk_disable_unprepare(fpc->clk[fpc->cnt_select]);
-		return ret;
-	}
+	newstate->period = fsl_pwm_ticks_to_ns(fpc,
+					       fpc->period.mod_period + 1);
+	newstate->duty_cycle = fsl_pwm_ticks_to_ns(fpc, duty);
 
 	return 0;
 }
 
-static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 struct pwm_state *newstate)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
-	int ret;
-
-	mutex_lock(&fpc->lock);
-	regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm), 0);
-
-	ret = fsl_counter_clock_enable(fpc);
-	mutex_unlock(&fpc->lock);
-
-	return ret;
-}
+	struct pwm_state *oldstate = &pwm->state;
+	int ret = 0;
 
-static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
-	u32 val;
+	/*
+	 * oldstate to newstate : action
+	 *
+	 * disabled to disabled : ignore
+	 * enabled to disabled : disable
+	 * enabled to enabled : update settings
+	 * disabled to enabled : update settings + enable
+	 */
 
 	mutex_lock(&fpc->lock);
-	regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm),
-			   BIT(pwm->hwpwm));
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
-	clk_disable_unprepare(fpc->clk[fpc->cnt_select]);
+	if (!newstate->enabled) {
+		if (oldstate->enabled) {
+			regmap_update_bits(fpc->regmap, FTM_OUTMASK,
+					   BIT(pwm->hwpwm), BIT(pwm->hwpwm));
+			clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
+			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
+		}
+		goto end_mutex;
+	}
 
-	regmap_read(fpc->regmap, FTM_OUTMASK, &val);
-	if ((val & 0xFF) == 0xFF)
-		fpc->period_ns = 0;
+	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
+	if (ret)
+		goto end_mutex;
+	/* check if need to enable */
+	if (!oldstate->enabled) {
+		ret = clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
+		if (ret)
+			return ret;
+		ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
+		if (ret) {
+			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
+			return ret;
+		}
+		regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm),
+				   0);
+	}
 
+end_mutex:
 	mutex_unlock(&fpc->lock);
+	return ret;
 }
 
 static const struct pwm_ops fsl_pwm_ops = {
 	.request = fsl_pwm_request,
 	.free = fsl_pwm_free,
-	.config = fsl_pwm_config,
-	.set_polarity = fsl_pwm_set_polarity,
-	.enable = fsl_pwm_enable,
-	.disable = fsl_pwm_disable,
+	.apply = fsl_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
@@ -474,7 +476,7 @@ static int fsl_pwm_suspend(struct device *dev)
 			continue;
 
 		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
-		clk_disable_unprepare(fpc->clk[fpc->cnt_select]);
+		clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
 	}
 
 	return 0;
@@ -496,7 +498,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!pwm_is_enabled(pwm))
 			continue;
 
-		clk_prepare_enable(fpc->clk[fpc->cnt_select]);
+		clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
 		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
 	}
 
-- 
2.19.1

