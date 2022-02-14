Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDED4B4402
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiBNIYL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBNIYK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:24:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA4D25C44
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:24:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeO-0007jx-DZ; Mon, 14 Feb 2022 09:24:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeN-00GVbW-6s; Mon, 14 Feb 2022 09:23:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeL-002szR-Ks; Mon, 14 Feb 2022 09:23:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: brcmstb: Implement .apply() callback
Date:   Mon, 14 Feb 2022 09:23:53 +0100
Message-Id: <20220214082354.295451-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; h=from:subject; bh=+hYagvgsATHxfvWSHPqyE6eWIrwoawbbR5NlejLmePU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiChGTmTWosjFsIuKTjucMy1OK4y6YEI0MN3o/1VYz DFiCLfiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYgoRkwAKCRDB/BR4rcrsCXstB/ 9mk5lyNg3vjccy4yA4k4iI6m6xK/BN3JjgoNqdZ0t8htrmEbUHTuMUBUCDAtCSjWLGHBwnOHWhSBEh mYChSNbz1+IKP4ARMJRMm65j+JKXv76dH8CnDL5jjPm2sg7FLDv9U81dV0cprFHwuO81hAO+64jTUI vqfVC7vxs+Yt6adg2/I+9mZbjCw9jV8nZn12bJ2rSaRZXU7nHzNzlBxIvQBkEbovD82DGWSgG4th60 jv1yON/xoqfI7LiKUtU8dInnwqUn9/RpXr7NJN0e6JK2roGZc6TI4k5DUSLkQLWT3LWXS7le93vb4d +TiZwRs3kS31ma2r8ZlRJCbus9mTwd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 45 +++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 3b529f82b97c..99974390aa38 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -95,7 +95,7 @@ static inline struct brcmstb_pwm *to_brcmstb_pwm(struct pwm_chip *chip)
  * "on" time, so this translates directly into our HW programming here.
  */
 static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			      int duty_ns, int period_ns)
+			      u64 duty_ns, u64 period_ns)
 {
 	struct brcmstb_pwm *p = to_brcmstb_pwm(chip);
 	unsigned long pc, dc, cword = CONST_VAR_F_MAX;
@@ -114,22 +114,17 @@ static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	while (1) {
-		u64 rate, tmp;
+		u64 rate;
 
 		/*
 		 * Calculate the base rate from base frequency and current
 		 * cword
 		 */
 		rate = (u64)clk_get_rate(p->clk) * (u64)cword;
-		do_div(rate, 1 << CWORD_BIT_SIZE);
+		rate >>= CWORD_BIT_SIZE;
 
-		tmp = period_ns * rate;
-		do_div(tmp, NSEC_PER_SEC);
-		pc = tmp;
-
-		tmp = (duty_ns + 1) * rate;
-		do_div(tmp, NSEC_PER_SEC);
-		dc = tmp;
+		pc = mul_u64_u64_div_u64(period_ns, rate, NSEC_PER_SEC);
+		dc = mul_u64_u64_div_u64(duty_ns + 1, rate, NSEC_PER_SEC);
 
 		/*
 		 * We can be called with separate duty and period updates,
@@ -202,26 +197,34 @@ static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm *p,
 	spin_unlock(&p->lock);
 }
 
-static int brcmstb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int brcmstb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
 {
 	struct brcmstb_pwm *p = to_brcmstb_pwm(chip);
+	int err;
 
-	brcmstb_pwm_enable_set(p, pwm->hwpwm, true);
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
 
-	return 0;
-}
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			brcmstb_pwm_enable_set(p, pwm->hwpwm, false);
 
-static void brcmstb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct brcmstb_pwm *p = to_brcmstb_pwm(chip);
+		return 0;
+	}
+
+	err = brcmstb_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
 
-	brcmstb_pwm_enable_set(p, pwm->hwpwm, false);
+	if (!pwm->state.enabled)
+		brcmstb_pwm_enable_set(p, pwm->hwpwm, true);
+
+	return 0;
 }
 
 static const struct pwm_ops brcmstb_pwm_ops = {
-	.config = brcmstb_pwm_config,
-	.enable = brcmstb_pwm_enable,
-	.disable = brcmstb_pwm_disable,
+	.apply = brcmstb_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.34.1

