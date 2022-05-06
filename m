Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AED51DA19
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442075AbiEFOOK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 10:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442082AbiEFOOI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 10:14:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F1674E9
        for <linux-pwm@vger.kernel.org>; Fri,  6 May 2022 07:10:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmyee-0007Ln-Jx; Fri, 06 May 2022 16:10:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmyee-000iua-S6; Fri, 06 May 2022 16:09:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmyec-007yAp-KO; Fri, 06 May 2022 16:09:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: sti: Implement .apply() callback
Date:   Fri,  6 May 2022 16:09:52 +0200
Message-Id: <20220506140952.130943-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; h=from:subject; bh=d4Do/UcCj+7f8HZgNFLvaS8gV+7PrRbYI+S/fgDUKJU=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSV6ujKxh6LnhBt0HyHIa35zS2pI8F1eYHFwl9Y7AIX9Orx W7t0MhqzMDByMciKKbLUFWmJTZBY89+uZAk3zCBWJpApDFycAjARpX0cDBN+9yfv1qzcNbn9UQfHp7 TlR3MUo5xU9V7X7jU6dSAoc0Utt7nWtg86MtFrfm2d6zEpI+fPKaEfGzRab+dfMusxPvn/fMTDgw/+ JD79tv7xt4hGC3vp6SZr+oI2r2x0MlKpWfGh4tf6zwxHpBaXZ+s4sfB/Eg/ra+E4y1RuZrG8v9JRrd r0gW5QkPadac/WRB4Ut8i+Vn1HtTT9VOaGPUoCUx8ZhuWrTVmipV2g3GWzuY+RbdLt8xx7NXInCeo/ YF+rrOjPoVWYMbsuVGZrpJ14eY6m1j3up3tt1ucpBGakXt42lyNBp+p2Vp68FuOHbiNf3qIf+k8Da9 PU2/c+yivmnft3Tdi6vBhz6UcA
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
 drivers/pwm/pwm-sti.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index f491d56254d7..44b1f93256b3 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -391,11 +391,34 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			sti_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = sti_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = sti_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops sti_pwm_ops = {
 	.capture = sti_pwm_capture,
-	.config = sti_pwm_config,
-	.enable = sti_pwm_enable,
-	.disable = sti_pwm_disable,
+	.apply = sti_pwm_apply,
 	.free = sti_pwm_free,
 	.owner = THIS_MODULE,
 };

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

