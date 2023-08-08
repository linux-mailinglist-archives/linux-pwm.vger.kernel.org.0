Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD5774B0D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjHHUjp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjHHUjQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:39:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B8175DE6
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-0006z2-Si; Tue, 08 Aug 2023 19:19:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00224P-6X; Tue, 08 Aug 2023 19:19:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-00BTBU-RF; Tue, 08 Aug 2023 19:19:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 021/101] pwm: img: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:11 +0200
Message-Id: <20230808171931.944154-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4207; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=e+Pj98NAcN3MIbhiwml67LlwwyP31jZj+t8E7vOVQ0U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njIYTs8e0PperRHnTyQDOAAUHHdW2/lZuAFp 0I3v9HRLbqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4yAAKCRCPgPtYfRL+ TrUTB/wKWqk+hdUoUcVITH/oFvSKs7obOmBW2NTU+y78BygJ3npTOyKSmAWQmonrMZLkrbx9kSV m2mzBKWh26casfPSq5FEfnk1Qy5u9+nTNgOP86RKEfB0ZEeritRkjEbWaUvITmwtiLb7AhN/G4u 47cizvMgePrXc/7neJFDghnbMELvKaooIGN3axQ8h4Y7PORa9A+yo9hvNh7hXqCp7dh5W1W+9ds 0PGkWRa9222M+e2m7nZfZ0b3toP1MPaPDhUdQyIbVnMbyMNxWp6gRYfa8YTT0qz6Ty/hoyioim1 W1hZhzuTyzeyMLkvHNmgX9Qc2i9RucDioSXqjsaXlxi07IdP
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

This prepares the pwm-img driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 116fa060e302..64e35ca1b576 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -60,7 +60,6 @@ struct img_pwm_soc_data {
 
 struct img_pwm_chip {
 	struct device	*dev;
-	struct pwm_chip	chip;
 	struct clk	*pwm_clk;
 	struct clk	*sys_clk;
 	void __iomem	*base;
@@ -74,7 +73,7 @@ struct img_pwm_chip {
 
 static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct img_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline void img_pwm_writel(struct img_pwm_chip *imgchip,
@@ -259,12 +258,14 @@ static int img_pwm_probe(struct platform_device *pdev)
 	int ret;
 	u64 val;
 	unsigned long clk_rate;
+	struct pwm_chip *chip;
 	struct img_pwm_chip *imgchip;
 	const struct of_device_id *of_dev_id;
 
-	imgchip = devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL);
-	if (!imgchip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, IMG_PWM_NPWM, sizeof(*imgchip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imgchip = to_img_pwm_chip(chip);
 
 	imgchip->dev = &pdev->dev;
 
@@ -294,7 +295,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imgchip->pwm_clk);
 	}
 
-	platform_set_drvdata(pdev, imgchip);
+	platform_set_drvdata(pdev, chip);
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_PWM_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -321,11 +322,9 @@ static int img_pwm_probe(struct platform_device *pdev)
 	do_div(val, clk_rate);
 	imgchip->min_period_ns = val;
 
-	imgchip->chip.dev = &pdev->dev;
-	imgchip->chip.ops = &img_pwm_ops;
-	imgchip->chip.npwm = IMG_PWM_NPWM;
+	chip->ops = &img_pwm_ops;
 
-	ret = pwmchip_add(&imgchip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
 		goto err_suspend;
@@ -344,19 +343,20 @@ static int img_pwm_probe(struct platform_device *pdev)
 
 static void img_pwm_remove(struct platform_device *pdev)
 {
-	struct img_pwm_chip *imgchip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		img_pwm_runtime_suspend(&pdev->dev);
 
-	pwmchip_remove(&imgchip->chip);
+	pwmchip_remove(chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int img_pwm_suspend(struct device *dev)
 {
-	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int i, ret;
 
 	if (pm_runtime_status_suspended(dev)) {
@@ -365,7 +365,7 @@ static int img_pwm_suspend(struct device *dev)
 			return ret;
 	}
 
-	for (i = 0; i < imgchip->chip.npwm; i++)
+	for (i = 0; i < chip->npwm; i++)
 		imgchip->suspend_ch_cfg[i] = img_pwm_readl(imgchip,
 							   PWM_CH_CFG(i));
 
@@ -378,7 +378,8 @@ static int img_pwm_suspend(struct device *dev)
 
 static int img_pwm_resume(struct device *dev)
 {
-	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 	int i;
 
@@ -386,13 +387,13 @@ static int img_pwm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < imgchip->chip.npwm; i++)
+	for (i = 0; i < chip->npwm; i++)
 		img_pwm_writel(imgchip, PWM_CH_CFG(i),
 			       imgchip->suspend_ch_cfg[i]);
 
 	img_pwm_writel(imgchip, PWM_CTRL_CFG, imgchip->suspend_ctrl_cfg);
 
-	for (i = 0; i < imgchip->chip.npwm; i++)
+	for (i = 0; i < chip->npwm; i++)
 		if (imgchip->suspend_ctrl_cfg & BIT(i))
 			regmap_clear_bits(imgchip->periph_regs,
 					  PERIP_PWM_PDM_CONTROL,
-- 
2.40.1

