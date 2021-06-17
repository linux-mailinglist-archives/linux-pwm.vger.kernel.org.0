Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396733AB04D
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFQJyI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhFQJyH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 05:54:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34978C061574
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 02:52:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogo-0007QB-1J; Thu, 17 Jun 2021 11:51:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogn-0005OA-Ms; Thu, 17 Jun 2021 11:51:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v1 6/6] pwm: tegra: unfold legacy callbacks into tegra_pwm_apply()
Date:   Thu, 17 Jun 2021 11:51:45 +0200
Message-Id: <20210617095145.163694-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=B+FEiLrOZF+HfX0Z+BoLTDKTGG3xOZskrcrqCOOCTWc=; m=Nf0Ktx1vUXNMeabaMeMBKdbyIjLeqXcI9TTSOQJCj/A=; p=O4GfEl4CHw+MBaCJfUEWPsK+3fuouL2g4TZp+cyKI0I=; g=b429bf01b282b90bac2993e0ddec5a2563238ba9
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDLGwAACgkQwfwUeK3K7AlmsAf/SbE RaBWeSzv+53bXDNFwnwflHR5f1wbRVrYdX+/l7Y7/diGtoX+rk/gcl3oAV5saSD12xsW4y4LcPsJ9 K+6DXj+5ZF7sZL2cksTcyqCAXrHYfNCKquwt/G4cWDEtahRFpv16jX1ewkOqkTmpAQZb4G2C1P9D3 kHa2d2w5BWDPtpeGmt24IIWR5u1bmY24H7aqKyydxgLmgPkYATHmsSEVbtkSLXAh6sNmMRItnjjgz lPjtGHzjQZeGSJqnT/Cgxx2zuzcB3W/0kkP/sqFM490Jr8uPSsjDK91itpfnzDGgEKIn3wjwz6YH3 eACscG1d9hrrJjHHiq5YQhzJIvmw1zw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This just puts the implementation of tegra_pwm_disable(),
tegra_pwm_enable() and tegra_pwm_config() into their only caller.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 244 ++++++++++++++++++----------------------
 1 file changed, 108 insertions(+), 136 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 1161c6323e60..e57a43f1b1b2 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -92,166 +92,138 @@ static inline void pwm_writel(struct tegra_pwm_chip *chip, unsigned int num,
 	writel(val, chip->regs + (num << 4));
 }
 
-static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
 {
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
-	unsigned long long c = duty_ns, hz;
-	unsigned long rate, required_clk_rate;
-	u32 val = 0;
 	int err;
+	u32 val;
 
-	/*
-	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
-	 * nearest integer during division.
-	 */
-	c *= (1 << PWM_DUTY_WIDTH);
-	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
 
-	val = (u32)c << PWM_DUTY_SHIFT;
+	if (!state->enabled) {
+		if (pwm->state.enabled) {
+			val = pwm_readl(pc, pwm->hwpwm);
+			val &= ~PWM_ENABLE;
+			pwm_writel(pc, pwm->hwpwm, val);
+			clk_disable_unprepare(pc->clk);
+		}
+		return 0;
+	}
 
-	/*
-	 *  min period = max clock limit >> PWM_DUTY_WIDTH
-	 */
-	if (period_ns < pc->min_period_ns)
-		return -EINVAL;
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		int period_ns = state->period;
+		int duty_ns = state->duty_cycle;
+		unsigned long long c = duty_ns, hz;
+		unsigned long rate, required_clk_rate;
 
-	/*
-	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
-	 * cycles at the PWM clock rate will take period_ns nanoseconds.
-	 *
-	 * num_channels: If single instance of PWM controller has multiple
-	 * channels (e.g. Tegra210 or older) then it is not possible to
-	 * configure separate clock rates to each of the channels, in such
-	 * case the value stored during probe will be referred.
-	 *
-	 * If every PWM controller instance has one channel respectively, i.e.
-	 * nums_channels == 1 then only the clock rate can be modified
-	 * dynamically (e.g. Tegra186 or Tegra194).
-	 */
-	if (pc->soc->num_channels == 1) {
 		/*
-		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
-		 * with the maximum possible rate that the controller can
-		 * provide. Any further lower value can be derived by setting
-		 * PFM bits[0:12].
-		 *
-		 * required_clk_rate is a reference rate for source clock and
-		 * it is derived based on user requested period. By setting the
-		 * source clock rate as required_clk_rate, PWM controller will
-		 * be able to configure the requested period.
+		 * Convert from duty_ns / period_ns to a fixed number of duty ticks
+		 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
+		 * nearest integer during division.
 		 */
-		required_clk_rate =
-			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
+		c *= (1 << PWM_DUTY_WIDTH);
+		c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
-		err = clk_set_rate(pc->clk, required_clk_rate);
-		if (err < 0)
+		val = (u32)c << PWM_DUTY_SHIFT;
+
+		/*
+		 *  min period = max clock limit >> PWM_DUTY_WIDTH
+		 */
+		if (period_ns < pc->min_period_ns)
 			return -EINVAL;
 
-		/* Store the new rate for further references */
-		pc->clk_rate = clk_get_rate(pc->clk);
-	}
+		/*
+		 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
+		 * cycles at the PWM clock rate will take period_ns nanoseconds.
+		 *
+		 * num_channels: If single instance of PWM controller has multiple
+		 * channels (e.g. Tegra210 or older) then it is not possible to
+		 * configure separate clock rates to each of the channels, in such
+		 * case the value stored during probe will be referred.
+		 *
+		 * If every PWM controller instance has one channel respectively, i.e.
+		 * nums_channels == 1 then only the clock rate can be modified
+		 * dynamically (e.g. Tegra186 or Tegra194).
+		 */
+		if (pc->soc->num_channels == 1) {
+			/*
+			 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+			 * with the maximum possible rate that the controller can
+			 * provide. Any further lower value can be derived by setting
+			 * PFM bits[0:12].
+			 *
+			 * required_clk_rate is a reference rate for source clock and
+			 * it is derived based on user requested period. By setting the
+			 * source clock rate as required_clk_rate, PWM controller will
+			 * be able to configure the requested period.
+			 */
+			required_clk_rate =
+				(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
+
+			err = clk_set_rate(pc->clk, required_clk_rate);
+			if (err < 0)
+				return -EINVAL;
+
+			/* Store the new rate for further references */
+			pc->clk_rate = clk_get_rate(pc->clk);
+		}
+
+		rate = pc->clk_rate >> PWM_DUTY_WIDTH;
+
+		/* Consider precision in PWM_SCALE_WIDTH rate calculation */
+		hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
+		rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
 
-	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
+		/*
+		 * Since the actual PWM divider is the register's frequency divider
+		 * field plus 1, we need to decrement to get the correct value to
+		 * write to the register.
+		 */
+		if (rate > 0)
+			rate--;
 
-	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
-	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
-	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
+		/*
+		 * Make sure that the rate will fit in the register's frequency
+		 * divider field.
+		 */
+		if (rate >> PWM_SCALE_WIDTH)
+			return -EINVAL;
 
-	/*
-	 * Since the actual PWM divider is the register's frequency divider
-	 * field plus 1, we need to decrement to get the correct value to
-	 * write to the register.
-	 */
-	if (rate > 0)
-		rate--;
+		val |= rate << PWM_SCALE_SHIFT;
 
-	/*
-	 * Make sure that the rate will fit in the register's frequency
-	 * divider field.
-	 */
-	if (rate >> PWM_SCALE_WIDTH)
-		return -EINVAL;
+		/*
+		 * If the PWM channel is disabled, make sure to turn on the clock
+		 * before writing the register. Otherwise, keep it enabled.
+		 */
+		if (!pwm_is_enabled(pwm)) {
+			err = clk_prepare_enable(pc->clk);
+			if (err < 0)
+				return err;
+		} else
+			val |= PWM_ENABLE;
 
-	val |= rate << PWM_SCALE_SHIFT;
+		pwm_writel(pc, pwm->hwpwm, val);
 
-	/*
-	 * If the PWM channel is disabled, make sure to turn on the clock
-	 * before writing the register. Otherwise, keep it enabled.
-	 */
-	if (!pwm_is_enabled(pwm)) {
+		/*
+		 * If the PWM is not enabled, turn the clock off again to save power.
+		 */
+		if (!pwm_is_enabled(pwm))
+			clk_disable_unprepare(pc->clk);
+	}
+
+	if (!pwm->state.enabled) {
 		err = clk_prepare_enable(pc->clk);
 		if (err < 0)
 			return err;
-	} else
-		val |= PWM_ENABLE;
-
-	pwm_writel(pc, pwm->hwpwm, val);
-
-	/*
-	 * If the PWM is not enabled, turn the clock off again to save power.
-	 */
-	if (!pwm_is_enabled(pwm))
-		clk_disable_unprepare(pc->clk);
-
-	return 0;
-}
-
-static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
-	int rc = 0;
-	u32 val;
 
-	rc = clk_prepare_enable(pc->clk);
-	if (rc < 0)
-		return rc;
-
-	val = pwm_readl(pc, pwm->hwpwm);
-	val |= PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
-
-	return 0;
-}
-
-static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
-	u32 val;
-
-	val = pwm_readl(pc, pwm->hwpwm);
-	val &= ~PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
-
-	clk_disable_unprepare(pc->clk);
-}
-
-static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   const struct pwm_state *state)
-{
-	int err;
-
-	if (state->polarity != PWM_POLARITY_INVERSED)
-		return -EINVAL;
-
-	if (!state->enabled) {
-		if (pwm->state.enabled)
-			tegra_pwm_disable(chip, pwm);
-		return 0;
-	}
-
-	if (state->period != pwm->state.period ||
-	    state->duty_cycle != pwm->state.duty_cycle) {
-		err = tegra_pwm_config(pwm->chip, pwm, (int)state->duty_cycle,
-				       (int)state->period);
-		if (err)
-			return err;
+		val = pwm_readl(pc, pwm->hwpwm);
+		val |= PWM_ENABLE;
+		pwm_writel(pc, pwm->hwpwm, val);
 	}
 
-	if (!pwm->state.enabled)
-		return tegra_pwm_enable(chip, pwm);
-
 	return 0;
 }
 
-- 
2.30.2

