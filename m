Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557C83707CA
	for <lists+linux-pwm@lfdr.de>; Sat,  1 May 2021 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhEAQCk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 May 2021 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhEAQCk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 May 2021 12:02:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB173C06174A
        for <linux-pwm@vger.kernel.org>; Sat,  1 May 2021 09:01:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcs3q-00027S-Hz; Sat, 01 May 2021 18:01:42 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcs3o-0007VP-De; Sat, 01 May 2021 18:01:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>,
        kernel@pengutronix.de
Subject: [PATCH] pwm: tiecap: Implement .apply() callback
Date:   Sat,  1 May 2021 18:01:39 +0200
Message-Id: <20210501160139.108266-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply(). This just pushes down a slightly
optimized variant of how legacy drivers are handled in the core.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch was created on top of my patch from Thursday "[PATCH] pwm:
tiecap: Drop .free() callback".

Best regards
Uwe

 drivers/pwm/pwm-tiecap.c | 55 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 134f0db28870..ce9a1f702051 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -48,16 +48,13 @@ static inline struct ecap_pwm_chip *to_ecap_pwm_chip(struct pwm_chip *chip)
  * duty_ns   = 10^9 * duty_cycles / PWM_CLK_RATE
  */
 static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-		int duty_ns, int period_ns)
+			   int duty_ns, int period_ns, int enabled)
 {
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u32 period_cycles, duty_cycles;
 	unsigned long long c;
 	u16 value;
 
-	if (period_ns > NSEC_PER_SEC)
-		return -ERANGE;
-
 	c = pc->clk_rate;
 	c = c * period_ns;
 	do_div(c, NSEC_PER_SEC);
@@ -82,7 +79,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(value, pc->mmio_base + ECCTL2);
 
-	if (!pwm_is_enabled(pwm)) {
+	if (!enabled) {
 		/* Update active registers if not running */
 		writel(duty_cycles, pc->mmio_base + CAP2);
 		writel(period_cycles, pc->mmio_base + CAP1);
@@ -96,7 +93,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel(period_cycles, pc->mmio_base + CAP3);
 	}
 
-	if (!pwm_is_enabled(pwm)) {
+	if (!enabled) {
 		value = readw(pc->mmio_base + ECCTL2);
 		/* Disable APWM mode to put APWM output Low */
 		value &= ~ECCTL2_APWM_MODE;
@@ -168,11 +165,49 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pm_runtime_put_sync(pc->chip.dev);
 }
 
+static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	int err;
+	int enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+
+		if (enabled) {
+			ecap_pwm_disable(chip, pwm);
+			enabled = false;
+		}
+
+		err = ecap_pwm_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			ecap_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		if (state->period > NSEC_PER_SEC)
+			return -ERANGE;
+
+		err = ecap_pwm_config(chip, pwm, state->duty_cycle,
+				      state->period, enabled);
+		if (err)
+			return err;
+	}
+
+	if (!enabled)
+		return ecap_pwm_enable(chip, pwm);
+
+	return 0;
+}
+
 static const struct pwm_ops ecap_pwm_ops = {
-	.config = ecap_pwm_config,
-	.set_polarity = ecap_pwm_set_polarity,
-	.enable = ecap_pwm_enable,
-	.disable = ecap_pwm_disable,
+	.apply = ecap_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: a6efb35019d00f483a0e5f188747723371d659fe
prerequisite-patch-id: 232146bd1c10d02f2f05c7380f2cb9af38e69893
-- 
2.30.2

