Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AC7C72D3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379608AbjJLQbZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbjJLQbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB8D3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaV-0005Hl-55; Thu, 12 Oct 2023 18:31:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-001C8S-5M; Thu, 12 Oct 2023 18:31:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-00F5PY-SQ; Thu, 12 Oct 2023 18:31:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 051/109] pwm: crc: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:19 +0200
Message-ID: <20231012162827.1002444-162-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=asN3OQZ6Hhkc4vNJgvfexJV8KxWJpq068DbL7i11wpA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7omzTTKcVQAE6+0QpWN23xXVP7JpN1GUb1a 3TaSPQfApaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge6AAKCRCPgPtYfRL+ Tm/LCACLXwibw9eX0IzdIacXO0ye6YJMqRICtsStUZfqcnF5kPKhf5X78XV0N89Vx+qQjCby5Vm adSuy3U79aUYXU8zKgS3CzVw/2/lD+598KzOTQAAZ+6IZqoFapDwC4hp9/HwozLqwP9cNw/3avg AGeFyexsZICa+rTRSky05Zvr5VMbpaORw2lmCxSh0DGjk+iJMvQ3iNTnMeX6GTI9oPAJ5pOL+48 0FkbD1GhYcm3QJ4X/LlcPp3Bscr7jWSk8sFDskERXW+EPzuo5Vtoh3ogjPekSMy+jkIwgBVX/nh WZhX92XC12jWnJ3ijIOBJoE/IKQtCmGwAtlC52LVOV0jyfQO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-crc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index d08c3112aaba..27cde9be90b3 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -26,17 +26,15 @@
 
 /**
  * struct crystalcove_pwm - Crystal Cove PWM controller
- * @chip: the abstract pwm_chip structure.
  * @regmap: the regmap from the parent device.
  */
 struct crystalcove_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 };
 
 static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct crystalcove_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int crc_pwm_calc_clk_div(int period_ns)
@@ -160,22 +158,22 @@ static const struct pwm_ops crc_pwm_ops = {
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
 {
-	struct crystalcove_pwm *pwm;
+	struct pwm_chip *chip;
+	struct crystalcove_pwm *crc_pwm;
 	struct device *dev = pdev->dev.parent;
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*crc_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	crc_pwm = to_crc_pwm(chip);
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &crc_pwm_ops;
-	pwm->chip.npwm = 1;
+	chip->ops = &crc_pwm_ops;
 
 	/* get the PMIC regmap */
-	pwm->regmap = pmic->regmap;
+	crc_pwm->regmap = pmic->regmap;
 
-	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {
-- 
2.42.0

