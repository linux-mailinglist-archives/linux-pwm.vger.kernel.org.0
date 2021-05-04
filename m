Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC9372AED
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEDN0k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 09:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhEDN0i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 09:26:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05136C061761
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 06:25:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldv3W-0001tN-Dg; Tue, 04 May 2021 15:25:42 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldv3V-0008SL-P8; Tue, 04 May 2021 15:25:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Thomas Hebb <tommyhebb@gmail.com>,
        Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 3/4] pwm: berlin: Implement .apply() callback
Date:   Tue,  4 May 2021 15:25:36 +0200
Message-Id: <20210504132537.62072-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
References: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-berlin.c | 43 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 894ea5869d42..4e838a973c97 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -73,7 +73,7 @@ static inline void berlin_pwm_writel(struct berlin_pwm_chip *bpc,
 }
 
 static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+			     u64 duty_ns, u64 period_ns)
 {
 	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	bool prescale_4096 = false;
@@ -152,11 +152,44 @@ static void berlin_pwm_disable(struct pwm_chip *chip,
 	berlin_pwm_writel(bpc, pwm->hwpwm, value, BERLIN_PWM_EN);
 }
 
+static int berlin_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			berlin_pwm_disable(chip, pwm);
+			enabled = false;
+		}
+
+		err = berlin_pwm_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			berlin_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		err = berlin_pwm_config(chip, pwm, state->duty_cycle, state->period);
+		if (err)
+			return err;
+	}
+
+	if (!enabled)
+		return berlin_pwm_enable(chip, pwm);
+
+	return 0;
+}
+
 static const struct pwm_ops berlin_pwm_ops = {
-	.config = berlin_pwm_config,
-	.set_polarity = berlin_pwm_set_polarity,
-	.enable = berlin_pwm_enable,
-	.disable = berlin_pwm_disable,
+	.apply = berlin_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.30.2

