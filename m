Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4714E51DA56
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442146AbiEFOTg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 10:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442209AbiEFOTe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 10:19:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63269296
        for <linux-pwm@vger.kernel.org>; Fri,  6 May 2022 07:15:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmykE-0000Ai-1W; Fri, 06 May 2022 16:15:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmykD-000ivN-BC; Fri, 06 May 2022 16:15:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmykB-007yBe-9K; Fri, 06 May 2022 16:15:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de
Subject: [PATCH] pwm: stmpe: Implement .apply() callback
Date:   Fri,  6 May 2022 16:15:35 +0200
Message-Id: <20220506141535.133179-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; h=from:subject; bh=FAOBqMIoOdc95FM7wSI4U3A+BzZmPhK2DrzIajwueWo=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSV6rYET/zZLTgh+1mLVJaAoM15iW7H5Bfcf3XqirZKzmjI +uvcyWjMwsDIxSArpshSV6QlNkFizX+7kiXcMINYmUCmMHBxCsBENm3lYOi6qXG9QX/OX70XWTyPZ5 x2q5+RnC4VcHZpeZhmYaNahuO7qAWCn03Ddflr0p+uXRzvHtBg42u9d+W0clYDtx0bfHse/NecFZz2 W+hu30abJcHH0xUVdU2k53fePM91rb0joc5wYvqfdeoOO3viXi2RyNq/wMZV4vOdI8vVp8fHNl2fsz 5Ug01Uzre79gTv8aILxhs+WG4+J9pqJHN8Wr0BQ1Pad6balw+fSa57XvCy+F2R6Km7f7hf9kmFZapq P31xvL20y7XIX9Zi6ZSiDQtrZ05oalw5JS0o8J3aJxHNmfwaXxYd27z61Fy1rVbza6I8d5d3m2+US9 y+q1Y2yWNjRIpbeLPlztbAXQ+0AA==
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
 drivers/pwm/pwm-stmpe.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index c4336d3bace3..5d4a4762ce0c 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -259,10 +259,33 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int stmpe_24xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			stmpe_24xx_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = stmpe_24xx_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = stmpe_24xx_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops stmpe_24xx_pwm_ops = {
-	.config = stmpe_24xx_pwm_config,
-	.enable = stmpe_24xx_pwm_enable,
-	.disable = stmpe_24xx_pwm_disable,
+	.apply = stmpe_24xx_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

