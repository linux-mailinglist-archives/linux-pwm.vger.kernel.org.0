Return-Path: <linux-pwm+bounces-54-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413C57F2F87
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7293B1C2166B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B453810;
	Tue, 21 Nov 2023 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6610C9
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-0005eu-8q; Tue, 21 Nov 2023 14:51:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAS-00Aazv-2N; Tue, 21 Nov 2023 14:51:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAR-004xeT-Pd; Tue, 21 Nov 2023 14:51:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 056/108] pwm: img: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:58 +0100
Message-ID: <20231121134901.208535-57-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4166; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Jvkspjr7uzaPtxemBrHORmwQXRrDQd4lGppDFAHOOqE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWKR1stATiOg/XaVUG5VHYCiyK8hSHvSwDo9 kk+yDPso+uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1igAKCRCPgPtYfRL+ Tm7SB/4q5mEAC0zJAml64cSz3BHzHU+dm1rVyGkuheE5h0KBoZGCiGaNFRqaMi02mVL+ePy8D9c DDUZz2eptgj/c/N+o2kK50YPewRinY/CwRKF56euP0eqGYPcarQgr71APktZoKaVsCgBZr+sFMN HYIbQJLHyvi8CCY5LQll7aCwQG8zitTPp3dgsy2TNFEtOVXKYSSI6/yh5lW41JlvYNvsKyl6ZD+ BJ6wPFdevnerAD/ba+IQAMm319v3DmxiU6PVG6NtIEC2r35CxZN08jQD4Bp19tOaD0LV+DlLM79 E5AFqTLbq6ZMXwD7x3K3m/MYw3fKUorM0eZyCQE1hc7XjMrA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-img driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index d5d50645530f..b0f5954f2643 100644
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
@@ -259,11 +258,13 @@ static int img_pwm_probe(struct platform_device *pdev)
 	int ret;
 	u64 val;
 	unsigned long clk_rate;
+	struct pwm_chip *chip;
 	struct img_pwm_chip *imgchip;
 
-	imgchip = devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL);
-	if (!imgchip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, IMG_PWM_NPWM, sizeof(*imgchip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imgchip = to_img_pwm_chip(chip);
 
 	imgchip->dev = &pdev->dev;
 
@@ -290,7 +291,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imgchip->pwm_clk);
 	}
 
-	platform_set_drvdata(pdev, imgchip);
+	platform_set_drvdata(pdev, chip);
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_PWM_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -317,11 +318,9 @@ static int img_pwm_probe(struct platform_device *pdev)
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
@@ -340,19 +339,20 @@ static int img_pwm_probe(struct platform_device *pdev)
 
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
@@ -361,7 +361,7 @@ static int img_pwm_suspend(struct device *dev)
 			return ret;
 	}
 
-	for (i = 0; i < imgchip->chip.npwm; i++)
+	for (i = 0; i < chip->npwm; i++)
 		imgchip->suspend_ch_cfg[i] = img_pwm_readl(imgchip,
 							   PWM_CH_CFG(i));
 
@@ -374,7 +374,8 @@ static int img_pwm_suspend(struct device *dev)
 
 static int img_pwm_resume(struct device *dev)
 {
-	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 	int i;
 
@@ -382,13 +383,13 @@ static int img_pwm_resume(struct device *dev)
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


