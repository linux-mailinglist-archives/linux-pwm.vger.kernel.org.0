Return-Path: <linux-pwm+bounces-1361-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217418545AD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4663D1C2693A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA41755E;
	Wed, 14 Feb 2024 09:34:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6192182DB
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903272; cv=none; b=m7Wsf7OH6dGzRhIkUtLFPLO8LzL7dKriaTJNpBrbKYK4wPKkHGu88U7HqJfEOWem2CQvmo5Fo1jS8JqsqnMoVbdk7Q5fzEu7+U5kllfS4ebTKSEtp50kjvPaChFXftFyQbjBbA3/66WWdLm8Dxy8j/ib3vLqaMNBGXA0JXCfIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903272; c=relaxed/simple;
	bh=+ZSoms2b3EqbgtyN2cZhD4af3gbvsNGnNj6uCUcRmrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmePTYJkZQ5L09hnKstY0UY+LLb63zsvvr+FeNySWYDDnPiZF187rq1yDGfYcdSDO11Hu02Tp3ZHD0h1l1EtUTkUkVZcKJrHz2ooEAhInEJvfHuxOCFUXyltS2TKnayX/B8kd0x085pMBcAc/mfnnX82mBOmQ1/kzkxK015lSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-0004hL-8J; Wed, 14 Feb 2024 10:34:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-000fBc-Rk; Wed, 14 Feb 2024 10:34:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-004Y2j-2W;
	Wed, 14 Feb 2024 10:34:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 045/164] pwm: img: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:31:32 +0100
Message-ID:  <2ddf76d127f69eca7d9faa6475091e432e890ac9.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4482; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+ZSoms2b3EqbgtyN2cZhD4af3gbvsNGnNj6uCUcRmrM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh+0kYF/bL6vcoM59x6cDVm2Hh+UoCMbaIKQ LgLRFnqO96JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIfgAKCRCPgPtYfRL+ TtPRB/0VWSyM7Yz/QzDSTd3ApeCH6GgbVadnYFINvAMRWSzupHC8tuaOXBgE8bKgqI9Pzd1Toxb L+bxgwZ237uh+tpirDMBWm+YlGuZ3aMwSyd6NqDLZ9ifer6YglrebDkoGHaEiW3nQEz3L2CkIZP CzVlqNNf2Z9lZujjvdxLnAqRm59JgI9q6Y2QgpMeZy2/MhSpHLuOl08k8/aK71cP50fI/miVGSu KzbMQWcnoX+pKbUqswINci8dlKK0Lg4ehoJq8Zty0dxgS2Ypo0hCFVRCHFKRnZVnHiaSK7LpSg0 bQgM6b30HoDFQdL1icKJdLTY4y8CNblzfWb9Gj6rEiUWuMXf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct img_pwm_chip. Use the pwm_chip as driver data
instead of the img_pwm_chip to get access to the pwm_chip in
img_pwm_remove() and the PM callbacks without using imgchip->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index a4ffe3d71d56..e99d5bc979c2 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -224,7 +224,8 @@ MODULE_DEVICE_TABLE(of, img_pwm_of_match);
 
 static int img_pwm_runtime_suspend(struct device *dev)
 {
-	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 
 	clk_disable_unprepare(imgchip->pwm_clk);
 	clk_disable_unprepare(imgchip->sys_clk);
@@ -234,7 +235,8 @@ static int img_pwm_runtime_suspend(struct device *dev)
 
 static int img_pwm_runtime_resume(struct device *dev)
 {
-	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 
 	ret = clk_prepare_enable(imgchip->sys_clk);
@@ -258,11 +260,13 @@ static int img_pwm_probe(struct platform_device *pdev)
 	int ret;
 	u64 val;
 	unsigned long clk_rate;
+	struct pwm_chip *chip;
 	struct img_pwm_chip *imgchip;
 
 	imgchip = devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL);
 	if (!imgchip)
 		return -ENOMEM;
+	chip = &imgchip->chip;
 
 	imgchip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imgchip->base))
@@ -287,7 +291,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imgchip->pwm_clk);
 	}
 
-	platform_set_drvdata(pdev, imgchip);
+	platform_set_drvdata(pdev, chip);
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_PWM_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -314,11 +318,11 @@ static int img_pwm_probe(struct platform_device *pdev)
 	do_div(val, clk_rate);
 	imgchip->min_period_ns = val;
 
-	imgchip->chip.dev = &pdev->dev;
-	imgchip->chip.ops = &img_pwm_ops;
-	imgchip->chip.npwm = IMG_PWM_NPWM;
+	chip->dev = &pdev->dev;
+	chip->ops = &img_pwm_ops;
+	chip->npwm = IMG_PWM_NPWM;
 
-	ret = pwmchip_add(&imgchip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
 		goto err_suspend;
@@ -337,19 +341,20 @@ static int img_pwm_probe(struct platform_device *pdev)
 
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
@@ -358,7 +363,7 @@ static int img_pwm_suspend(struct device *dev)
 			return ret;
 	}
 
-	for (i = 0; i < imgchip->chip.npwm; i++)
+	for (i = 0; i < chip->npwm; i++)
 		imgchip->suspend_ch_cfg[i] = img_pwm_readl(imgchip,
 							   PWM_CH_CFG(i));
 
@@ -371,7 +376,8 @@ static int img_pwm_suspend(struct device *dev)
 
 static int img_pwm_resume(struct device *dev)
 {
-	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 	int i;
 
@@ -379,13 +385,13 @@ static int img_pwm_resume(struct device *dev)
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
2.43.0


