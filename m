Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67D8774AE8
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjHHUiZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjHHUiP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:38:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD931DD5B
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-0007OQ-KF; Tue, 08 Aug 2023 19:19:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-002277-0j; Tue, 08 Aug 2023 19:19:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-00BTDf-Sf; Tue, 08 Aug 2023 19:19:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 055/101] pwm: stmpe: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:45 +0200
Message-Id: <20230808171931.944154-56-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2448; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NOHE85wOtUgdkzORs0ajc7ZvPmFMQojhvqWe8PWeqIo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njuVJT25413JFJ25MDnEm44e7maKrGyBiHNe FdlXIs6RRmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ47gAKCRCPgPtYfRL+ TlYiB/47oN5qgcxAsQZNPx6w9tDQiTGaaOXlxIJbYtHujxGV14Pp4m9BXJ4bmgANIeafJ3kMdYi ZrGEP7Q/KGppfj8DrOKyrpc/3zfOLyvfBQdnaB6VxfgYQknyF7M7lb3bYo+jiDsg8firerKz2jH 8wg5PREniKv4Rpulkd6HdJTE6a1SEZOAzTHTUoinPbxiVIr1g1q1X2gWeMI8HeP6T4+2a1SXxtz kQl3FjFWukoNGpofNX1+VEUIMY42fHI5ZRJXIknJYamrivZiYHldJZdXsmh0XGcbYVxrzDXuXTG cMM7csbpOVUzgSuuCVoC4plGkgiw9kmD1JdRuKoZCCU0WNHQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-stmpe driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index a46f5b4dd816..9c0f96b77c42 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -27,13 +27,12 @@
 
 struct stmpe_pwm {
 	struct stmpe *stmpe;
-	struct pwm_chip chip;
 	u8 last_duty;
 };
 
 static inline struct stmpe_pwm *to_stmpe_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stmpe_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -292,33 +291,36 @@ static const struct pwm_ops stmpe_24xx_pwm_ops = {
 static int __init stmpe_pwm_probe(struct platform_device *pdev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct stmpe_pwm *stmpe_pwm;
 	int ret;
 
-	stmpe_pwm = devm_kzalloc(&pdev->dev, sizeof(*stmpe_pwm), GFP_KERNEL);
-	if (!stmpe_pwm)
-		return -ENOMEM;
+	switch (stmpe->partnum) {
+	case STMPE2401:
+	case STMPE2403:
+		break;
+	case STMPE1601:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "STMPE1601 not yet supported\n");
+	default:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Unknown STMPE PWM\n");
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 3, sizeof(*stmpe_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	stmpe_pwm = to_stmpe_pwm(chip);
 
 	stmpe_pwm->stmpe = stmpe;
-	stmpe_pwm->chip.dev = &pdev->dev;
 
-	if (stmpe->partnum == STMPE2401 || stmpe->partnum == STMPE2403) {
-		stmpe_pwm->chip.ops = &stmpe_24xx_pwm_ops;
-		stmpe_pwm->chip.npwm = 3;
-	} else {
-		if (stmpe->partnum == STMPE1601)
-			dev_err(&pdev->dev, "STMPE1601 not yet supported\n");
-		else
-			dev_err(&pdev->dev, "Unknown STMPE PWM\n");
-
-		return -ENODEV;
-	}
+	chip->ops = &stmpe_24xx_pwm_ops;
 
 	ret = stmpe_enable(stmpe, STMPE_BLOCK_PWM);
 	if (ret)
 		return ret;
 
-	ret = pwmchip_add(&stmpe_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret) {
 		stmpe_disable(stmpe, STMPE_BLOCK_PWM);
 		return ret;
-- 
2.40.1

