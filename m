Return-Path: <linux-pwm+bounces-363-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC4806E9F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F9B281BF3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118F358B1;
	Wed,  6 Dec 2023 11:48:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9B109
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-0006oE-Rc; Wed, 06 Dec 2023 12:48:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-00DwvE-Ra; Wed, 06 Dec 2023 12:48:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-00FR0W-IY; Wed, 06 Dec 2023 12:48:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 062/115] pwm: img: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:16 +0100
Message-ID:  <d2d2fd787bde5e61f0353677603565fc041e4b2a.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4173; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5v7JMq7GW3Ut08Nv0h9HcfpFAbf+saKPxOj60LGvXlw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7C7nZNPk7n790wjzoGkR1yGVBLtzmYiODTV 6Pa4cp8wbeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBewgAKCRCPgPtYfRL+ TlTKB/98G6X7c7rTyLLFk7au9y+i9//OT5OVoMqe+5hP7QkUDX4EWItYGF+Ep5F5Tzlt60Z60wD sjH9GgFhOFCPRnhCrNo4QHRW3duObroXVS7hp06AR6MKcwtdWyupYaniuCJgH+2YD9lv6tyL62f oH89XtUjYdPQxR8iG61XrKJWa05+t471aOw+8KeRU0YfyqnQCU3HQXv51/gdPPHN98+W0BpFMxr wKtPcyWxiERy7lri090WakR+4RYDNyy6T0jOshodyQlupNQtfAtkC+LVQLE/YS04T6YgXbyNJT3 2rwxMDSwj1de10h2gQNdjm/R5m8Po5EM7/if1iAPV3RPUMIR
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
index 2d7477fc391a..8226169699fa 100644
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
+	return pwmchip_get_drvdata(chip);
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


