Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323CC774AFE
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjHHUjO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjHHUis (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:38:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BE7175DD6
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-0006o8-9c; Tue, 08 Aug 2023 19:19:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-00223H-L7; Tue, 08 Aug 2023 19:19:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMw-00BTAT-FV; Tue, 08 Aug 2023 19:19:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 005/101] pwm: atmel: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:17:55 +0200
Message-Id: <20230808171931.944154-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3617; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+jVVPp3P9ZLlwuWxBcIjFE5FEC7elXox1UtMengYrEY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni1AlnKBvEkhfYxVcsxM1ncftT9HePKxJKEL /1sPxQGihmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4tQAKCRCPgPtYfRL+ TiSBB/9rBSEnSnHeD2QOI5uYtPTTYfLxUB7Q6efkWmOfBQZLje11CDNkq1GV+zdzV+ApqLIMFQ6 gxkMFoE3KmpcRC5R2pi/USRS5grz0e+lZ1shxbot4FXQU5JxMCbky3xqgPA1xELP1Sq9JJ4TKoS BtOoS08mjdDPxw76mZQvq3B9HMRfAK53Vt5/C8clGeT2w4IOSmTPxVnG1KlLhaJPUPVjx9X2wJa NGM6dv4sGJpPNQSsHZteMocIOX2Qf3I9iHAtzEMyhi2GEC/VegJUM74k8gdh/JEJsJnVEWoZr12 Rua4M0+LUqA06s9UrwMA7oP4hJ+gKMdS6n/L8zqNpQptDago
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

This prepares the pwm-atmel driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 591f4b0493a7..48b79b8488a4 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -77,7 +77,6 @@ struct atmel_pwm_data {
 };
 
 struct atmel_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	const struct atmel_pwm_data *data;
@@ -99,7 +98,7 @@ struct atmel_pwm_chip {
 
 static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 atmel_pwm_readl(struct atmel_pwm_chip *chip,
@@ -456,8 +455,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
+static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 {
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int i, cnt = 0;
 	unsigned long sr;
 	int ret = 0;
@@ -466,7 +466,7 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 	if (!sr)
 		return 0;
 
-	cnt = bitmap_weight(&sr, atmel_pwm->chip.npwm);
+	cnt = bitmap_weight(&sr, chip->npwm);
 
 	if (!on)
 		goto disable_clk;
@@ -474,9 +474,8 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err(atmel_pwm->chip.dev,
-				"failed to enable clock for pwm %pe\n",
-				ERR_PTR(ret));
+			dev_err_probe(chip->dev, ret,
+				"failed to enable clock for pwm\n");
 
 			cnt = i;
 			goto disable_clk;
@@ -494,12 +493,14 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct atmel_pwm_chip *atmel_pwm;
 	int ret;
 
-	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
-	if (!atmel_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*atmel_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	atmel_pwm = to_atmel_pwm_chip(chip);
 
 	atmel_pwm->data = of_device_get_match_data(&pdev->dev);
 
@@ -515,15 +516,13 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
 				     "failed to get prepared PWM clock\n");
 
-	atmel_pwm->chip.dev = &pdev->dev;
-	atmel_pwm->chip.ops = &atmel_pwm_ops;
-	atmel_pwm->chip.npwm = 4;
+	chip->ops = &atmel_pwm_ops;
 
-	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
+	ret = atmel_pwm_enable_clk_if_on(chip, true);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_pwmchip_add(&pdev->dev, &atmel_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 		goto disable_clk;
@@ -532,7 +531,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
+	atmel_pwm_enable_clk_if_on(chip, false);
 
 	return ret;
 }
-- 
2.40.1

