Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214BA51ECAB
	for <lists+linux-pwm@lfdr.de>; Sun,  8 May 2022 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiEHJxh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 May 2022 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiEHJoe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 May 2022 05:44:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA78DFBA
        for <linux-pwm@vger.kernel.org>; Sun,  8 May 2022 02:40:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nndP6-0001qE-9n; Sun, 08 May 2022 11:40:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nndP6-0014PZ-1g; Sun, 08 May 2022 11:40:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nndP3-008LQk-PA; Sun, 08 May 2022 11:40:37 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: lpc18xx: Implement .apply() callback
Date:   Sun,  8 May 2022 11:40:32 +0200
Message-Id: <20220508094032.206141-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310; h=from:subject; bh=g3FGW5yov/fKMMV/wxpj7a4/ke+oE7R883xfOnmKa6k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBid5AMgx2+T/LWT898YxyL/ehfY0NqE7lpBk+Nuxlb UrO5Xr6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYneQDAAKCRDB/BR4rcrsCQD+CA CCYqd6TOO7z1MjJdBVy+HFh5AXUKK5ix2T0hFStBp+GChWXTZo3amfYPIkQz432BBDKduFvWHCl/7r kFzA4tbZMEdktRR90doRIGLdmbLUBCvnOBubdO3n5qUdFv2NTDTmSeI1wbP2Gb4dmY0nKPB/epOVR3 s4iZXayPJ7DfXXICMAWybEbaoogq+cqOIou75pkOZjWQ4qlyKoNlotz77adO++/gsWmCtaylxz4RT+ C32T6w07Lto6C5xpObnaCwel9J0ATwvPCOXJqG8PbszFhJuRwjfjihtoun0dbzneJtozidhtMIyuB8 6pjV1yKUnl0Qh3ZUMpaGpnxHjsAmoE
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
This pushes a variant of pwm_apply_legacy into the driver that was slightly
simplified because the .set_polarity callback was a noop.

There is no change in behavior.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 43 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

Hello,

note the driver behave as expected when pwm_apply is called with a
polarity change and .enabled = false, because the polarity change is
only implemented in lpc18xx_pwm_enable(). I think this is a theoretic
concern though, because a) this probably never happens and b) because
the behaviour for a disabled PWM isn't formalized anyhow. This problem
exists with and without this patch.

Best regards
Uwe

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index b909096dba2f..272e0b5d01b8 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -226,14 +226,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int lpc18xx_pwm_set_polarity(struct pwm_chip *chip,
-				    struct pwm_device *pwm,
-				    enum pwm_polarity polarity)
-{
-	return 0;
-}
-
-static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm, enum pwm_polarity polarity)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 	struct lpc18xx_pwm_data *lpc18xx_data = &lpc18xx_pwm->channeldata[pwm->hwpwm];
@@ -249,7 +242,7 @@ static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 			   LPC18XX_PWM_EVSTATEMSK(lpc18xx_data->duty_event),
 			   LPC18XX_PWM_EVSTATEMSK_ALL);
 
-	if (pwm_get_polarity(pwm) == PWM_POLARITY_NORMAL) {
+	if (polarity == PWM_POLARITY_NORMAL) {
 		set_event = lpc18xx_pwm->period_event;
 		clear_event = lpc18xx_data->duty_event;
 		res_action = LPC18XX_PWM_RES_SET;
@@ -308,11 +301,35 @@ static void lpc18xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clear_bit(lpc18xx_data->duty_event, &lpc18xx_pwm->event_map);
 }
 
+static int lpc18xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity && pwm->state.enabled) {
+		lpc18xx_pwm_disable(chip, pwm);
+		enabled = false;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			lpc18xx_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = lpc18xx_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!enabled)
+		err = lpc18xx_pwm_enable(chip, pwm, state->polarity);
+
+	return err;
+}
 static const struct pwm_ops lpc18xx_pwm_ops = {
-	.config = lpc18xx_pwm_config,
-	.set_polarity = lpc18xx_pwm_set_polarity,
-	.enable = lpc18xx_pwm_enable,
-	.disable = lpc18xx_pwm_disable,
+	.apply = lpc18xx_pwm_apply,
 	.request = lpc18xx_pwm_request,
 	.free = lpc18xx_pwm_free,
 	.owner = THIS_MODULE,

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

