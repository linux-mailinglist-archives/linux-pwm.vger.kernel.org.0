Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204AB52AC76
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiEQUHW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiEQUHT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 16:07:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732349F2A
        for <linux-pwm@vger.kernel.org>; Tue, 17 May 2022 13:07:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr3TP-0002WL-Sf; Tue, 17 May 2022 22:07:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr3TQ-002wTM-Hk; Tue, 17 May 2022 22:07:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nr3TO-00ANrM-Dq; Tue, 17 May 2022 22:07:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: twl-led: Implement .apply() callback
Date:   Tue, 17 May 2022 22:07:09 +0200
Message-Id: <20220517200709.418666-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384; h=from:subject; bh=xBv/YKr4+keWbL6P9+MZE3/dOqwB83TilXvoUuKLFGk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBihABqJn4a9mZz/zBHKc1XwFdY62/QlTcvM7kbBEW+ v/Q82YGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYoQAagAKCRDB/BR4rcrsCdxSB/ 97Fq0cmUi+3z1ZBZR+CE/24sos1wo3IFKGyu7WwSKh84yZGDoi0SLRRBA60eNPRTjOUty2yWDWnPn0 a3zivHZQLCnWQelTQvZycQVuZ6pivZaSVmi445TzCEAQR87rlx4Z0ZVRt47O+OjuFwhM8d7fkHNICJ Mvk4YliyrHhPN99n7B5JhYTJKrRO5AWPtPyd6l2i13FfLrzEcs5Be7jU/l0MYNMu+IGJ9vx332M+oh uiDP/NhKrS8doBBTkl1GvZBd5UQJGboEKReOyBlwST/o3UwWJ0rzsaBYl8umnyBfg2DZMGXVjkxkOG hNydKsKbR5o45etuzEy6MD46CkXKgP
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
This just pushed a variant of pwm_apply_legacy() into the driver that was
slightly simplified because the driver doesn't provide a .set_polarity()
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl-led.c | 76 +++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 49d9f7a78012..ed0b63dd38f1 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -137,6 +137,45 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 	mutex_unlock(&twl->mutex);
 }
 
+static int twl4030_pwmled_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			twl4030_pwmled_disable(chip, pwm);
+
+		return 0;
+	}
+
+	/*
+	 * We cannot skip calling ->config even if state->period ==
+	 * pwm->state.period && state->duty_cycle == pwm->state.duty_cycle
+	 * because we might have exited early in the last call to
+	 * pwm_apply_state because of !state->enabled and so the two values in
+	 * pwm->state might not be configured in hardware.
+	 */
+	ret = twl4030_pwmled_config(pwm->chip, pwm,
+				    state->duty_cycle, state->period);
+	if (ret)
+		return ret;
+
+	if (!pwm->state.enabled)
+		ret = twl4030_pwmled_enable(chip, pwm);
+
+	return ret;
+}
+
+
+static const struct pwm_ops twl4030_pwmled_ops = {
+	.apply = twl4030_pwmled_apply,
+	.owner = THIS_MODULE,
+};
+
 static int twl6030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
@@ -206,6 +245,32 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 	mutex_unlock(&twl->mutex);
 }
 
+static int twl6030_pwmled_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != pwm->state.polarity)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			twl6030_pwmled_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = twl6030_pwmled_config(pwm->chip, pwm,
+				    state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = twl6030_pwmled_enable(chip, pwm);
+
+	return err;
+}
+
 static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct twl_pwmled_chip *twl = to_twl(chip);
@@ -257,17 +322,8 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&twl->mutex);
 }
 
-static const struct pwm_ops twl4030_pwmled_ops = {
-	.enable = twl4030_pwmled_enable,
-	.disable = twl4030_pwmled_disable,
-	.config = twl4030_pwmled_config,
-	.owner = THIS_MODULE,
-};
-
 static const struct pwm_ops twl6030_pwmled_ops = {
-	.enable = twl6030_pwmled_enable,
-	.disable = twl6030_pwmled_disable,
-	.config = twl6030_pwmled_config,
+	.apply = twl6030_pwmled_apply,
 	.request = twl6030_pwmled_request,
 	.free = twl6030_pwmled_free,
 	.owner = THIS_MODULE,

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

