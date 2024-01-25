Return-Path: <linux-pwm+bounces-993-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47083C1DC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D422909A3
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD245C1A;
	Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386344502E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184656; cv=none; b=vFU8LE1Ccg2SWqY+LVG7i1Bwe9OH8tmeOR60uUZpHzV0pq0OdAdYao/RL6aimCxCG/6pNVptRa3+3Mg7sgQObEiPNYAQmg4Z8RUsvFeMQXnF1y+5o5l+Nau539smvdnyo29bD3WwFPOGZaBTdk2DojRZajezf1Ho7aErZINk4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184656; c=relaxed/simple;
	bh=WXk07+NGdbESkX0tBs1Ypbmmmgelgd/RficH8drz2o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nr2AhHwNgEEx/9z9nBEuLfKibwG4pHqD0mLXLw1B72L24qj0wvXPh1ctpRqA4sQ17xfgE1yJJGhK9V9ca3cwzE6aUintyoXLsgZbUEO1PXBux9frtokupoKHWKA9Dc+Yk75ZgBWmpnHdwI9Y0ryE2Fa2Uh9+y4CupS0XjmEkjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-0004Kp-TI; Thu, 25 Jan 2024 13:10:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-002HSN-8e; Thu, 25 Jan 2024 13:10:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-007n1v-0c;
	Thu, 25 Jan 2024 13:10:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 057/111] pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:19 +0100
Message-ID:  <f7e4e1e2662956e8d4d8a14844fed50e33c3ae45.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4225; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=WXk07+NGdbESkX0tBs1Ypbmmmgelgd/RficH8drz2o0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk99Y2N+J1Tp0pNml7cZVpau9KbZQPW+u9ln1 93HSeS/vXOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPfQAKCRCPgPtYfRL+ TkiyCACCDdOiICYDVbolUd2K2RUBfsyzl8uT06pOxA3KujR3wZcjCwEOdIeng2E58QOOMhMOJGJ nlradFYbGKzP6zOXKpM9N5HsooyI6B8OegP+8kd3yqB/hCUHvqqqMK5Bd88dPtmKqgAxKqcHDva cSein1k32dO6MVzgXuXz9GgVzNYz80ophfNRvQ1rwYy0KlSyR7uF3P6qV3hZ4zNbagnEwQNaz8Y seF33tecHlQhtiJvPML8XyWICeYNmT31TK7TuarL6xKsjx723glkInonNcTPh/vZHfOh35KDy/z 0nvGQKlnITjxRL/AJSzxhCsSV4/7pYv5y645uVkmy8rIn9Dr
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
2.43.0


