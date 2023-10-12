Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB76E7C72DE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379466AbjJLQbb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379631AbjJLQbK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C35CF
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-0005Oj-JD; Thu, 12 Oct 2023 18:31:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaU-001C8n-BW; Thu, 12 Oct 2023 18:31:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaU-00F5Pw-2K; Thu, 12 Oct 2023 18:31:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 057/109] pwm: img: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:25 +0200
Message-ID: <20231012162827.1002444-168-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4207; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lrD2d+bpp7bEs32z8mQjAO7pDGyrf+3HOzxE1jmoBQg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7v6zKmg1+7d8ElwX+78dM6or1e9yN0iIdPR gRuyo+PJD+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge7wAKCRCPgPtYfRL+ TvSxB/4l30HBeg63IMF26BV+txUwiI64ipD9w2nBe2qtksizjLfTbfw3C2IwnYPzmhhfBmWUS90 S3rJ7CcnOB3wGexOIDyvatZ85Fhe2sPJOgpwA5oqflLS45UYwOx33TMRvpujwTg56kDzpiHGRfn a9pNas1ttx7/pMkaJnx+1WSeWcW9QmK9R/VJfH/LgPRbM6PtZIJ/gBjxKaM7o2TePGdGplyfSDC ffa+pd4SXDqp9VgBJcYTwTF3jDdMT/T+EaClda9fBraAs1339pEXvIzhYC7n9npKCFKF1QEZoie 9cmZJkm+zWDqNkIvo8bwVMjrUHmFYto2wR1SqgfjuGrZC+dP
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

This prepares the pwm-img driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index c2398a2e3a14..18776e2ca054 100644
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
2.42.0

