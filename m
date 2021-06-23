Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E133B1BEF
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jun 2021 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhFWOFJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Jun 2021 10:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhFWOFJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jun 2021 10:05:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C121BC061756
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 07:02:51 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lw3Sq-0001lH-2L; Wed, 23 Jun 2021 16:02:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lw3So-0005pF-Gv; Wed, 23 Jun 2021 16:02:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matthieu Crapet <mcrapet@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: ep93xx: unfold legacy callbacks into ep93xx_pwm_apply()
Date:   Wed, 23 Jun 2021 16:02:40 +0200
Message-Id: <20210623140240.170706-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623140240.170706-1-u.kleine-koenig@pengutronix.de>
References: <20210623140240.170706-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This just puts the implementation of ep93xx_pwm_disable(),
ep93xx_pwm_enable() and ep93xx_pwm_config() into their only caller.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 177 ++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 106 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 3ef4b41bfd66..3354b734f28f 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -58,138 +58,103 @@ static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	ep93xx_pwm_release_gpio(pdev);
 }
 
-static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
-{
-	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
-	void __iomem *base = ep93xx_pwm->base;
-	unsigned long long c;
-	unsigned long period_cycles;
-	unsigned long duty_cycles;
-	unsigned long term;
-	int ret = 0;
-
-	/*
-	 * The clock needs to be enabled to access the PWM registers.
-	 * Configuration can be changed at any time.
-	 */
-	if (!pwm_is_enabled(pwm)) {
-		ret = clk_enable(ep93xx_pwm->clk);
-		if (ret)
-			return ret;
-	}
-
-	c = clk_get_rate(ep93xx_pwm->clk);
-	c *= period_ns;
-	do_div(c, 1000000000);
-	period_cycles = c;
-
-	c = period_cycles;
-	c *= duty_ns;
-	do_div(c, period_ns);
-	duty_cycles = c;
-
-	if (period_cycles < 0x10000 && duty_cycles < 0x10000) {
-		term = readw(base + EP93XX_PWMx_TERM_COUNT);
-
-		/* Order is important if PWM is running */
-		if (period_cycles > term) {
-			writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
-			writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
-		} else {
-			writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
-			writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
-		}
-	} else {
-		ret = -EINVAL;
-	}
-
-	if (!pwm_is_enabled(pwm))
-		clk_disable(ep93xx_pwm->clk);
-
-	return ret;
-}
-
-static int ep93xx_pwm_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-			       enum pwm_polarity polarity)
-{
-	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
-	int ret;
-
-	/*
-	 * The clock needs to be enabled to access the PWM registers.
-	 * Polarity can only be changed when the PWM is disabled.
-	 */
-	ret = clk_enable(ep93xx_pwm->clk);
-	if (ret)
-		return ret;
-
-	if (polarity == PWM_POLARITY_INVERSED)
-		writew(0x1, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
-	else
-		writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
-
-	clk_disable(ep93xx_pwm->clk);
-
-	return 0;
-}
-
-static int ep93xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
-	int ret;
-
-	ret = clk_enable(ep93xx_pwm->clk);
-	if (ret)
-		return ret;
-
-	writew(0x1, ep93xx_pwm->base + EP93XX_PWMx_ENABLE);
-
-	return 0;
-}
-
-static void ep93xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
-
-	writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_ENABLE);
-	clk_disable(ep93xx_pwm->clk);
-}
-
 static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	int ret;
+	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 	bool enabled = state->enabled;
 
 	if (state->polarity != pwm->state.polarity) {
 		if (enabled) {
-			ep93xx_pwm_disable(chip, pwm);
+			writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_ENABLE);
+			clk_disable(ep93xx_pwm->clk);
 			enabled = false;
 		}
 
-		ret = ep93xx_pwm_polarity(chip, pwm, state->polarity);
+		/*
+		 * The clock needs to be enabled to access the PWM registers.
+		 * Polarity can only be changed when the PWM is disabled.
+		 */
+		ret = clk_enable(ep93xx_pwm->clk);
 		if (ret)
 			return ret;
+
+		if (state->polarity == PWM_POLARITY_INVERSED)
+			writew(0x1, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
+		else
+			writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
+
+		clk_disable(ep93xx_pwm->clk);
 	}
 
 	if (!state->enabled) {
-		if (enabled)
-			ep93xx_pwm_disable(chip, pwm);
+		if (enabled) {
+			writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_ENABLE);
+			clk_disable(ep93xx_pwm->clk);
+		}
 
 		return 0;
 	}
 
 	if (state->period != pwm->state.period ||
 	    state->duty_cycle != pwm->state.duty_cycle) {
-		ret = ep93xx_pwm_config(chip, pwm, (int)state->duty_cycle,
-					(int)state->period);
+		struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
+		void __iomem *base = ep93xx_pwm->base;
+		unsigned long long c;
+		unsigned long period_cycles;
+		unsigned long duty_cycles;
+		unsigned long term;
+
+		/*
+		 * The clock needs to be enabled to access the PWM registers.
+		 * Configuration can be changed at any time.
+		 */
+		if (!pwm_is_enabled(pwm)) {
+			ret = clk_enable(ep93xx_pwm->clk);
+			if (ret)
+				return ret;
+		}
+
+		c = clk_get_rate(ep93xx_pwm->clk);
+		c *= state->period;
+		do_div(c, 1000000000);
+		period_cycles = c;
+
+		c = period_cycles;
+		c *= state->duty_cycle;
+		do_div(c, state->period);
+		duty_cycles = c;
+
+		if (period_cycles < 0x10000 && duty_cycles < 0x10000) {
+			term = readw(base + EP93XX_PWMx_TERM_COUNT);
+
+			/* Order is important if PWM is running */
+			if (period_cycles > term) {
+				writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
+				writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
+			} else {
+				writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
+				writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
+			}
+		} else {
+			ret = -EINVAL;
+		}
+
+		if (!pwm_is_enabled(pwm))
+			clk_disable(ep93xx_pwm->clk);
+
 		if (ret)
 			return ret;
 	}
 
-	if (!enabled)
-		return ep93xx_pwm_enable(chip, pwm);
+	if (!enabled) {
+		ret = clk_enable(ep93xx_pwm->clk);
+		if (ret)
+			return ret;
+
+		writew(0x1, ep93xx_pwm->base + EP93XX_PWMx_ENABLE);
+	}
 
 	return 0;
 }
-- 
2.30.2

