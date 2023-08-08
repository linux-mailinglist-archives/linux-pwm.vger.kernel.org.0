Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB317743FF
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjHHSOm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjHHSON (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7D48CAE
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-0007P1-4M; Tue, 08 Aug 2023 19:19:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-00227O-F4; Tue, 08 Aug 2023 19:19:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-00BTDv-RH; Tue, 08 Aug 2023 19:19:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 059/101] pwm: tiecap: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:49 +0200
Message-Id: <20230808171931.944154-60-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GTCrxFNsHaSARxCWSRlWgiRI8Xn/FNnjlDYQjVq2vcI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njz+lZddyw4ik3wzUEaWT0yws66+sKTPSaZI vfjaiUhWtKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ48wAKCRCPgPtYfRL+ TtADB/9dxMsc4YqxD6EP2BJeE2DgqUWSrcEv8A6Krv6rk8WXxvwLTAV30pWT6od5eZXtqLzA947 fkNxnZQuU+UNBhZ4Op8Nbw8XzPbpjldGZ8kN/3Xoue88qQOU6t5GJrE2dpPudjbe3QXKo2rk1GW KexxKwQVlKnY88kdw9nP0cbopy5cTL9L6qG4T0AGVUj2VdSPBzGV1bUTRmIIpBLvlIY50g4PFLV cSYJTGirMr2/nTCqML40JL82uEvrXlf8DlDgbL8Oo2uBCb4qs3nWXdmax4sFOekHQxdt9otV/3x lOrvND1x92iVyTlj1EnYS42gkJfxuUE7P59YbuPeVgBPQXah
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

This prepares the pwm-tiecap driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 55 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 11e3549cf103..9ff9a6de8be2 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -32,7 +32,6 @@ struct ecap_context {
 };
 
 struct ecap_pwm_chip {
-	struct pwm_chip chip;
 	unsigned int clk_rate;
 	void __iomem *mmio_base;
 	struct ecap_context ctx;
@@ -40,7 +39,7 @@ struct ecap_pwm_chip {
 
 static inline struct ecap_pwm_chip *to_ecap_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ecap_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -70,7 +69,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_cycles = (u32)c;
 	}
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(chip->dev);
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -100,7 +99,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writew(value, pc->mmio_base + ECCTL2);
 	}
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 
 	return 0;
 }
@@ -111,7 +110,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u16 value;
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(chip->dev);
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -124,7 +123,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(value, pc->mmio_base + ECCTL2);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 
 	return 0;
 }
@@ -135,7 +134,7 @@ static int ecap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u16 value;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(chip->dev);
 
 	/*
 	 * Enable 'Free run Time stamp counter mode' to start counter
@@ -162,7 +161,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	writew(value, pc->mmio_base + ECCTL2);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 }
 
 static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -217,13 +216,15 @@ MODULE_DEVICE_TABLE(of, ecap_of_match);
 static int ecap_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct ecap_pwm_chip *pc;
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_ecap_pwm_chip(chip);
 
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
@@ -244,21 +245,19 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &ecap_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->ops = &ecap_pwm_ops;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
@@ -270,17 +269,21 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
+static void ecap_pwm_save_context(struct pwm_chip *chip)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
+
+	pm_runtime_get_sync(chip->dev);
 	pc->ctx.ecctl2 = readw(pc->mmio_base + ECCTL2);
 	pc->ctx.cap4 = readl(pc->mmio_base + CAP4);
 	pc->ctx.cap3 = readl(pc->mmio_base + CAP3);
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 }
 
-static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
+static void ecap_pwm_restore_context(struct pwm_chip *chip)
 {
+	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
+
 	writel(pc->ctx.cap3, pc->mmio_base + CAP3);
 	writel(pc->ctx.cap4, pc->mmio_base + CAP4);
 	writew(pc->ctx.ecctl2, pc->mmio_base + ECCTL2);
@@ -288,10 +291,10 @@ static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
 
 static int ecap_pwm_suspend(struct device *dev)
 {
-	struct ecap_pwm_chip *pc = dev_get_drvdata(dev);
-	struct pwm_device *pwm = pc->chip.pwms;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct pwm_device *pwm = chip->pwms;
 
-	ecap_pwm_save_context(pc);
+	ecap_pwm_save_context(chip);
 
 	/* Disable explicitly if PWM is running */
 	if (pwm_is_enabled(pwm))
@@ -302,14 +305,14 @@ static int ecap_pwm_suspend(struct device *dev)
 
 static int ecap_pwm_resume(struct device *dev)
 {
-	struct ecap_pwm_chip *pc = dev_get_drvdata(dev);
-	struct pwm_device *pwm = pc->chip.pwms;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct pwm_device *pwm = chip->pwms;
 
 	/* Enable explicitly if PWM was running */
 	if (pwm_is_enabled(pwm))
 		pm_runtime_get_sync(dev);
 
-	ecap_pwm_restore_context(pc);
+	ecap_pwm_restore_context(chip);
 	return 0;
 }
 #endif
-- 
2.40.1

