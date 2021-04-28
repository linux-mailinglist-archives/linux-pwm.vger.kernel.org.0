Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E71E36D476
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhD1JGf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1JGP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 05:06:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8DC06138B
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 02:05:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbg8P-0004xf-A7; Wed, 28 Apr 2021 11:05:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbg8O-0006Ez-7j; Wed, 28 Apr 2021 11:05:28 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 3/3] pwm: spear: Implement .apply() callback
Date:   Wed, 28 Apr 2021 11:05:26 +0200
Message-Id: <20210428090526.29016-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210428090526.29016-1-u.kleine-koenig@pengutronix.de>
References: <20210428090526.29016-1-u.kleine-koenig@pengutronix.de>
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

Just using the previous callbacks to implment a similar procedure as the
legacy handling in the core.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-spear.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 05a19e70d570..48c31dac2f32 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -75,7 +75,7 @@ static inline void spear_pwm_writel(struct spear_pwm_chip *chip,
 }
 
 static int spear_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+			    u64 duty_ns, u64 period_ns)
 {
 	struct spear_pwm_chip *pc = to_spear_pwm_chip(chip);
 	u64 val, div, clk_rate;
@@ -163,10 +163,35 @@ static void spear_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable(pc->clk);
 }
 
+static int spear_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			spear_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		err = spear_pwm_config(chip, pwm, state->duty_cycle, state->period);
+		if (err)
+			return err;
+	}
+
+	if (!pwm->state.enabled)
+		return spear_pwm_enable(chip, pwm);
+
+	return 0;
+}
+
 static const struct pwm_ops spear_pwm_ops = {
-	.config = spear_pwm_config,
-	.enable = spear_pwm_enable,
-	.disable = spear_pwm_disable,
+	.apply = spear_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.30.2

