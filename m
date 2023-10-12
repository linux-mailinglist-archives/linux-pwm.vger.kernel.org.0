Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7157C7301
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379645AbjJLQbr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347334AbjJLQbS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F6D8
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyae-0005ql-F4; Thu, 12 Oct 2023 18:31:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-001CBE-LR; Thu, 12 Oct 2023 18:31:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-00F5SY-CJ; Thu, 12 Oct 2023 18:31:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 095/109] pwm: tiecap: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:30:03 +0200
Message-ID: <20231012162827.1002444-206-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9095; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a7WNfRFUa7Xlzv96Zh47XkRrHEVwuMI1ZxYLGTp1OF8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNeZnzT5Za6fLoaz+OZrPYzcK1dMZ2Z6ub4Yv0NrAFv ci6W5zUyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBENkxm/yva92KXTxxfhNBa 348pgtWmX4JehPnZ1WcKK3Dt2qkXtns2T85bB32fSP3+3cWyajHhmi7qW547Xrf5LTfdY7ra9Jc Vrr+iPSz1Q4W37chaZ7TyzZwIlRZmzqS5LLPSPNYar26Kv+Eyf/quFj/FjbH7ArZ3y1oe+Vfrt1 l+13tBi3Udl6PfP9aP+TFx87ONjjHeGWGHWfjnztKT4OKfF8k775zMgoDw2W82ax0N47GbMtNPb MPFmGSWlXe2hWrNiXA3SvbzyCvzkgxmmHiOO7v/9NnH3HLhkVyHPlyJmLuqNUz/3dGyEL7GTkbF o1vmicx3Weyd9u73qsN8qhrpajF7sve9niD81pNVUEUbAA==
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

This prepares the pwm-tegra driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c   | 43 ++++++++++++++++---------------
 drivers/pwm/pwm-tiehrpwm.c | 52 ++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index d54b24c6b2ec..2f07cea726b2 100644
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
-	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
+	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
+
+	pm_runtime_get_sync(pwmchip_parent(chip));
 	pc->ctx.ecctl2 = readw(pc->mmio_base + ECCTL2);
 	pc->ctx.cap4 = readl(pc->mmio_base + CAP4);
 	pc->ctx.cap3 = readl(pc->mmio_base + CAP3);
-	pm_runtime_put_sync(pwmchip_parent(&pc->chip));
+	pm_runtime_put_sync(pwmchip_parent(chip));
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
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index b7021e05bc72..624fc3331da2 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -105,7 +105,6 @@ struct ehrpwm_context {
 };
 
 struct ehrpwm_pwm_chip {
-	struct pwm_chip chip;
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
@@ -116,7 +115,7 @@ struct ehrpwm_pwm_chip {
 
 static inline struct ehrpwm_pwm_chip *to_ehrpwm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ehrpwm_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u16 ehrpwm_read(void __iomem *base, unsigned int offset)
@@ -449,13 +448,15 @@ MODULE_DEVICE_TABLE(of, ehrpwm_of_match);
 static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct ehrpwm_pwm_chip *pc;
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_ehrpwm_pwm_chip(chip);
 
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
@@ -474,9 +475,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &ehrpwm_pwm_ops;
-	pc->chip.npwm = NUM_PWM_CHANNEL;
+	chip->ops = &ehrpwm_pwm_ops;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
@@ -493,13 +492,13 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		goto err_clk_unprepare;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
@@ -512,9 +511,10 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 static void ehrpwm_pwm_remove(struct platform_device *pdev)
 {
-	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->tbclk);
 
@@ -522,9 +522,11 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
+static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 {
-	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -535,11 +537,13 @@ static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
 	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
 
-	pm_runtime_put_sync(pwmchip_parent(&pc->chip));
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
-static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
+static void ehrpwm_pwm_restore_context(struct pwm_chip *chip)
 {
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
 	ehrpwm_write(pc->mmio_base, TBPRD, pc->ctx.tbprd);
 	ehrpwm_write(pc->mmio_base, CMPA, pc->ctx.cmpa);
 	ehrpwm_write(pc->mmio_base, CMPB, pc->ctx.cmpb);
@@ -552,13 +556,13 @@ static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
 
 static int ehrpwm_pwm_suspend(struct device *dev)
 {
-	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	unsigned int i;
 
-	ehrpwm_pwm_save_context(pc);
+	ehrpwm_pwm_save_context(chip);
 
-	for (i = 0; i < pc->chip.npwm; i++) {
-		struct pwm_device *pwm = &pc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -572,11 +576,11 @@ static int ehrpwm_pwm_suspend(struct device *dev)
 
 static int ehrpwm_pwm_resume(struct device *dev)
 {
-	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	unsigned int i;
 
-	for (i = 0; i < pc->chip.npwm; i++) {
-		struct pwm_device *pwm = &pc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -585,7 +589,7 @@ static int ehrpwm_pwm_resume(struct device *dev)
 		pm_runtime_get_sync(dev);
 	}
 
-	ehrpwm_pwm_restore_context(pc);
+	ehrpwm_pwm_restore_context(chip);
 
 	return 0;
 }
-- 
2.42.0

