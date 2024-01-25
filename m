Return-Path: <linux-pwm+bounces-1006-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECA783C1E9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28881C22A93
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5F3EA62;
	Thu, 25 Jan 2024 12:10:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7D4776A
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184659; cv=none; b=h3sk1n/M5S2I2Sdw+8xSVB0l/b4HFMcw6XKZtKzEzEYvu+4vtSFkJTHGceesLzYNsZ+CN7tiCb2CTcwi9H7IWDiqvK61ejVuoZzLAjVOl7VbHCDbYLhaRqc73dYfz68WR8qAUtaTydUGQKGootgpGIOzv24vdZf5aHOz7SPMTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184659; c=relaxed/simple;
	bh=q7gYTyr75ccBLRk0l0v9LT7305ravTnhDw2pdohEEK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVCyU1KTJ437zYzDIWWrUtFNSlGPq+DZjqMyuK+0m28jEETmeyKs6fnJfwLOthX2mZ0OUGJerIM9TZrhGlplU03jQ2LQxCrqUkMZbDqJIsl7B5Q35aoZYoCNhOYzqlrUERVQgDTwwtg42OCU/vMCivol7m0LT/g9k0jhuZDa2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-0004Pb-Qm; Thu, 25 Jan 2024 13:10:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-002HT7-DO; Thu, 25 Jan 2024 13:10:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-007n2i-15;
	Thu, 25 Jan 2024 13:10:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 068/111] pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:30 +0100
Message-ID:  <200c88b25064360f01776574deda657adc646b45.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3045; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=q7gYTyr75ccBLRk0l0v9LT7305ravTnhDw2pdohEEK8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+KkUIR0iwRFKUiiTU9thDO0PgLE/RD3UpMn JZ/2kJKcTOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPigAKCRCPgPtYfRL+ TjCmCACJvnX+waF4sOiCdNEGmXtwh3wZTghCj3KdplWTnBr4fJ3VNgn8hgU4vMPiozMUU6nRH/9 14FZ5YtB+/iNwoFnWdgScp7ai65E2dwMO+Ce4NvW2hJG27YLVzZBZbxbUgc8tZOZHcm35jazTRm leQ5OmcI/ExLJtGObgP43Bi8MlR48PjGV4snvO0TYmp34kpE+mKtSoWITTRhI+F6krC+8Tae6Oh J+xj+vHJ++CkUzpHn/ZrX6Xv35T6UifAwSAvWyfSnYnD2kN4J4vYf3qAlsV4U7uNetXw6v9mgb/ 70Y48OqfIrgWjpc4goB6PM1AEJbe1z6dX/lY3PXPDNMqbi8/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-lpc18xx-sct driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 1d2d342c05fd..23c324d4c0bb 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -93,7 +93,6 @@ struct lpc18xx_pwm_data {
 
 struct lpc18xx_pwm_chip {
 	struct device *parent;
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *pwm_clk;
 	unsigned long clk_rate;
@@ -110,7 +109,7 @@ struct lpc18xx_pwm_chip {
 static inline struct lpc18xx_pwm_chip *
 to_lpc18xx_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lpc18xx_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline void lpc18xx_pwm_writel(struct lpc18xx_pwm_chip *lpc18xx_pwm,
@@ -349,14 +348,15 @@ MODULE_DEVICE_TABLE(of, lpc18xx_pwm_of_match);
 
 static int lpc18xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct lpc18xx_pwm_chip *lpc18xx_pwm;
 	int ret;
 	u64 val;
 
-	lpc18xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*lpc18xx_pwm),
-				   GFP_KERNEL);
-	if (!lpc18xx_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, LPC18XX_NUM_PWMS, sizeof(*lpc18xx_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 
 	lpc18xx_pwm->parent = &pdev->dev;
 
@@ -389,9 +389,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->min_period_ns = DIV_ROUND_UP(NSEC_PER_SEC,
 						  lpc18xx_pwm->clk_rate);
 
-	lpc18xx_pwm->chip.dev = &pdev->dev;
-	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
-	lpc18xx_pwm->chip.npwm = LPC18XX_NUM_PWMS;
+	chip->ops = &lpc18xx_pwm_ops;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
@@ -423,21 +421,22 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	val |= LPC18XX_PWM_PRE(0);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
 
-	ret = pwmchip_add(&lpc18xx_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add failed\n");
 
-	platform_set_drvdata(pdev, lpc18xx_pwm);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void lpc18xx_pwm_remove(struct platform_device *pdev)
 {
-	struct lpc18xx_pwm_chip *lpc18xx_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 	u32 val;
 
-	pwmchip_remove(&lpc18xx_pwm->chip);
+	pwmchip_remove(chip);
 
 	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
-- 
2.43.0


