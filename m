Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2117746A0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjHHS66 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjHHS6l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCACF175DDB
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-0006tu-To; Tue, 08 Aug 2023 19:19:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-00223s-5t; Tue, 08 Aug 2023 19:19:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00BTB2-BY; Tue, 08 Aug 2023 19:19:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 014/101] pwm: crc: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:04 +0200
Message-Id: <20230808171931.944154-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CSMX0vvzdX+H8cYsOkJHBXwNXT0wRjlE97BEPuAo+tk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njA072rjV80nZLnj56ltzSiOa+m5qR2sbiuA W/Qz6Hb4U2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4wAAKCRCPgPtYfRL+ ThcyCAC4eACAzCAbKC2ZBoPq7vosqJYa1q/AZbm0IAKAJXv3/fVDpUnecJshTFfg0iqn3SlQfpC HxCDELI6VmDFlLIgNnXG28RMuLaTXVNz44GXpnJX7jwJSeHTq0t2vR0KLy4Z6uk7fLJ6U3nV5nS lvIVLP9Gqo1piqG9bTma6NT8/EXPpB9+1IKseBkD35fNkUOuqhiYhhtkbgtvEg0Iy4aHtB7EySy kR0eYg5SVHnBdRL2xRTStP4Xxx9S+G4IZyjYlfyhBtWREyDI5K7xaQQbkMjKnJpBBhO1sx67rv6 m5XOktA5jK05gb0zabqFsc+mS5agv7AS4wLzgptVpzGJapBW
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

This prepares the pwm-crc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index b9f063dc6b5f..5f8651b87880 100644
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
@@ -160,22 +158,23 @@ static const struct pwm_ops crc_pwm_ops = {
 
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
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	crc_pwm = to_crc_pwm(chip);
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &crc_pwm_ops;
-	pwm->chip.npwm = 1;
+	chip->ops = &crc_pwm_ops;
+	chip->npwm = 1;
 
 	/* get the PMIC regmap */
-	pwm->regmap = pmic->regmap;
+	crc_pwm->regmap = pmic->regmap;
 
-	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {
-- 
2.40.1

