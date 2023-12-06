Return-Path: <linux-pwm+bounces-357-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A8806E9B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28331281B34
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373383589C;
	Wed,  6 Dec 2023 11:48:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6174410C7
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOG-0006mW-7I; Wed, 06 Dec 2023 12:48:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-00Dwv8-Hg; Wed, 06 Dec 2023 12:48:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-00FR0O-8m; Wed, 06 Dec 2023 12:48:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 060/115] pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:14 +0100
Message-ID:  <bd90dd96522a425ada8be9b999cf4d2eef62f58e.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4225; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pDaJRORQxJYOiE6jApKhGF+McwJZxgdA5vuRcmscHdM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF66cHOjnSoS415qExQktmDa3/uorCnB5AatC EsQh03Nx3KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeugAKCRCPgPtYfRL+ TpDGB/9+h/Z9NfrmugYTMHg8PYRxF4JRqw4mene6SK1TY71UmZ3XrY85eyD6Cu4Z2JErDdDsOPE 2+v/889y1lB0uwmn1irIS9mvpOtWtP/ElS6JOUE7fuFwkbJAwHbTpsD5+m0QAH2fk+4fgbS5FhW s15QM4dFCEW4GgwVjG3FKyiF7y3ri93nod51Jxk3VhRDeONH6Oh8Ypt9sepc6p5FTm0wYK638uN 3J+q/P1Fa4+af5dN2A0yj18dfSQNREZSYJ78EsUKOS+CRt6X44ueLWg0g9i2oKBvsVLrvTTpg5t uJUSPG9UxeNhg6UDMNTn/2HRBeWp0Y/i9L7fNFVWSXdXO65r
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-fsl-ftm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 47f1f5ac39cf..4e0706352050 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -40,7 +40,6 @@ struct fsl_pwm_periodcfg {
 };
 
 struct fsl_pwm_chip {
-	struct pwm_chip chip;
 	struct mutex lock;
 	struct regmap *regmap;
 
@@ -55,7 +54,7 @@ struct fsl_pwm_chip {
 
 static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct fsl_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void ftm_clear_write_protection(struct fsl_pwm_chip *fpc)
@@ -393,18 +392,19 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct fsl_pwm_chip *fpc;
 	void __iomem *base;
 	int ret;
 
-	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
-	if (!fpc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*fpc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	fpc = to_fsl_chip(chip);
 
 	mutex_init(&fpc->lock);
 
 	fpc->soc = of_device_get_match_data(&pdev->dev);
-	fpc->chip.dev = &pdev->dev;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -423,16 +423,16 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
 
-	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(fpc->chip.dev, "ftm_fix");
+	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(&pdev->dev, "ftm_fix");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
 
-	fpc->clk[FSL_PWM_CLK_EXT] = devm_clk_get(fpc->chip.dev, "ftm_ext");
+	fpc->clk[FSL_PWM_CLK_EXT] = devm_clk_get(&pdev->dev, "ftm_ext");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_EXT]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_EXT]);
 
 	fpc->clk[FSL_PWM_CLK_CNTEN] =
-				devm_clk_get(fpc->chip.dev, "ftm_cnt_clk_en");
+				devm_clk_get(&pdev->dev, "ftm_cnt_clk_en");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
 
@@ -445,16 +445,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
 
 
-	fpc->chip.ops = &fsl_pwm_ops;
-	fpc->chip.npwm = 8;
+	chip->ops = &fsl_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &fpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, fpc);
+	platform_set_drvdata(pdev, chip);
 
 	return fsl_pwm_init(fpc);
 }
@@ -462,14 +461,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int fsl_pwm_suspend(struct device *dev)
 {
-	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	int i;
 
 	regcache_cache_only(fpc->regmap, true);
 	regcache_mark_dirty(fpc->regmap);
 
-	for (i = 0; i < fpc->chip.npwm; i++) {
-		struct pwm_device *pwm = &fpc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
@@ -488,11 +488,12 @@ static int fsl_pwm_suspend(struct device *dev)
 
 static int fsl_pwm_resume(struct device *dev)
 {
-	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	int i;
 
-	for (i = 0; i < fpc->chip.npwm; i++) {
-		struct pwm_device *pwm = &fpc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
-- 
2.42.0


