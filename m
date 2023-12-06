Return-Path: <linux-pwm+bounces-395-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A96F806EC0
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7571F21554
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98771347B9;
	Wed,  6 Dec 2023 11:49:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD3B1BF
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-0007ch-3x; Wed, 06 Dec 2023 12:48:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00Dwxi-EJ; Wed, 06 Dec 2023 12:48:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00FR38-5L; Wed, 06 Dec 2023 12:48:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 100/115] pwm: tiecap: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:54 +0100
Message-ID:  <92f2bd9fb0f95c3c49ecba27db09d3974f801914.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9042; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sYTAVZBi6v5JgHCRnBYxAtu39OEznY8hMjsqX3FTP5s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF85OToaDkw2z6u2ijjKn+5gmg5CFzsmnqUIy 40y6AWnK7mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfOQAKCRCPgPtYfRL+ TljEB/96Yjk1KFiU8F3t2sfLTa0+EQbCWC9DNwzQeT5OAP1zR8++4O+P8VGIFuyYwy/ckrRTeVO exyAE6PyueIm5d7qAkMgflCsPiaJ5rpdhbN5ORi0sPWwnlMFiBofhqyW/3nrWw6LZdnVxGuAVc6 M3hDy6Jj/jPprvvLC2mL/rN+UtCB5T70h0Y8KD1A3UITPs9ByAwKLFy8pqR7Apq3rbIODivFh/z fyIO+XwRYL+KCi4RFDL95XHzcrmLt/NeSbIdx+9Ds6FP7ItvMwRBgWqw8QPPx/WY28FSE2AnzFA yqyvEaRscEYiI/c9aQkWfJUq9mlaEIL2ea9M4l8/OSQgBeDy
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-tegra driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c   | 43 ++++++++++++++++---------------
 drivers/pwm/pwm-tiehrpwm.c | 52 ++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 8c4f67774f24..e4c3ca4e74d9 100644
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
+	return pwmchip_get_drvdata(chip);
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
@@ -269,17 +268,21 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
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
@@ -287,10 +290,10 @@ static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
 
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
@@ -301,14 +304,14 @@ static int ecap_pwm_suspend(struct device *dev)
 
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
 
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 80e22e373bc5..219b51faaf60 100644
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
+	return pwmchip_get_drvdata(chip);
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
@@ -512,18 +511,21 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 static void ehrpwm_pwm_remove(struct platform_device *pdev)
 {
-	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->tbclk);
 
 	pm_runtime_disable(&pdev->dev);
 }
 
-static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
+static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 {
-	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -534,11 +536,13 @@ static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
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
@@ -551,13 +555,13 @@ static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
 
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
@@ -571,11 +575,11 @@ static int ehrpwm_pwm_suspend(struct device *dev)
 
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
@@ -584,7 +588,7 @@ static int ehrpwm_pwm_resume(struct device *dev)
 		pm_runtime_get_sync(dev);
 	}
 
-	ehrpwm_pwm_restore_context(pc);
+	ehrpwm_pwm_restore_context(chip);
 
 	return 0;
 }
-- 
2.42.0


