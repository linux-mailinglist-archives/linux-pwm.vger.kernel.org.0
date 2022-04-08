Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B74F994D
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Apr 2022 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiDHPYz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Apr 2022 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiDHPYx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Apr 2022 11:24:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608EFEF0A3
        for <linux-pwm@vger.kernel.org>; Fri,  8 Apr 2022 08:22:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqRi-0000Jj-Ai; Fri, 08 Apr 2022 17:22:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqRi-001pMJ-GI; Fri, 08 Apr 2022 17:22:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqRg-001zWy-Am; Fri, 08 Apr 2022 17:22:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Milo Kim <milo.kim@ti.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: lp3943: Implement .apply() callback
Date:   Fri,  8 Apr 2022 17:22:39 +0200
Message-Id: <20220408152239.164462-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408152239.164462-1-u.kleine-koenig@pengutronix.de>
References: <20220408152239.164462-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2741; h=from:subject; bh=Hq0WItNUVK8JvqHq+XGFUvFAAgpr4MsL1V0DpLRr4+8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiUFM7ab3N7JExwDFKJVdGLen1yBoq8+6bbLnjUwsr 9mQV8g6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlBTOwAKCRDB/BR4rcrsCcYMB/ 94unXcnYYBD3yRfUjiJvBiMlymNyjeAwdaepqJqPbGkb45LfiuhTYeTuihrcaoKqs9JsQLZJ4G0+32 yuVXep8iSDEAZ6bnO82QpO1JQn9pErt5ZgeOoL8MLHQHLSB3zCJUINTR70lBjDBlRVSJg9X3QQhmVb oSdHXdm7zhMCXR5vhz7Xk0lNVK9azLxNi5ejmB7662KQ5mGWtIFrqQVpiEpU/S1HZRfpCW9ZMT/Gkz G+asD05RatEuSK3wo3vBdwHgdyvGiWVJZGWMdBrC+tT8vLvmivKn+n/PV+++/LcVyL4hcbSNa863dn Wpt3KPQfDev+EDy5OZxb5Teml7kSpl
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
 drivers/pwm/pwm-lp3943.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 2bd04ecb508c..215ef9069114 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -93,7 +93,7 @@ static void lp3943_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int lp3943_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+			     u64 duty_ns, u64 period_ns)
 {
 	struct lp3943_pwm *lp3943_pwm = to_lp3943_pwm(chip);
 	struct lp3943 *lp3943 = lp3943_pwm->lp3943;
@@ -118,15 +118,20 @@ static int lp3943_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		reg_duty     = LP3943_REG_PWM1;
 	}
 
-	period_ns = clamp(period_ns, LP3943_MIN_PERIOD, LP3943_MAX_PERIOD);
-	val       = (u8)(period_ns / LP3943_MIN_PERIOD - 1);
+	/*
+	 * Note that after this clamping, period_ns fits into an int. This is
+	 * helpful because we can resort to integer division below instead of
+	 * the (more expensive) 64 bit division.
+	 */
+	period_ns = clamp(period_ns, (u64)LP3943_MIN_PERIOD, (u64)LP3943_MAX_PERIOD);
+	val       = (u8)((int)period_ns / LP3943_MIN_PERIOD - 1);
 
 	err = lp3943_write_byte(lp3943, reg_prescale, val);
 	if (err)
 		return err;
 
 	duty_ns = min(duty_ns, period_ns);
-	val = (u8)(duty_ns * LP3943_MAX_DUTY / period_ns);
+	val = (u8)((int)duty_ns * LP3943_MAX_DUTY / (int)period_ns);
 
 	return lp3943_write_byte(lp3943, reg_duty, val);
 }
@@ -183,12 +188,34 @@ static void lp3943_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	lp3943_pwm_set_mode(lp3943_pwm, pwm_map, LP3943_GPIO_OUT_HIGH);
 }
 
+static int lp3943_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			lp3943_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	err = lp3943_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = lp3943_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops lp3943_pwm_ops = {
 	.request	= lp3943_pwm_request,
 	.free		= lp3943_pwm_free,
-	.config		= lp3943_pwm_config,
-	.enable		= lp3943_pwm_enable,
-	.disable	= lp3943_pwm_disable,
+	.apply		= lp3943_pwm_apply,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.35.1

