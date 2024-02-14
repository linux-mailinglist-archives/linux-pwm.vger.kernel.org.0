Return-Path: <linux-pwm+bounces-1321-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F36854582
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B0D1F2E071
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F818035;
	Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9017584
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903265; cv=none; b=awgEsXWsnS3mTZ1jxRQGtaz0fcQdQHG9C0w5FogTIRGHHqM8H+snxBHswH9+wfHkR7vVycYxrstLX/aGt0BZsjCZiPXg4flMmE9aFpZSi5Ndtx2hteNxBlNSLaGZIyaZZefpHvqv2XEw7eYKvza/EWUzaY5+O/4CvhPUZAsas9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903265; c=relaxed/simple;
	bh=y89OcbTy+fiOpfQjg5mC1/J3D4k2pVm31e6norgskAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkCNo5vi1wHJV6Ly8AvE9IphdxqEvT0V7ZXuz9K9c+vrty9duva2Qo0UwjKHQK7wMD0/bAqE/JY+1bHyIKO5426wTz7y8u/zCVF0uGx5a+EiHXbOmiFRIRyPd3iSRaqM25qIDWGmcVp/xwp3dIVJAjnmW3LZjQa9MhnVw162WV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-0004PA-UD; Wed, 14 Feb 2024 10:34:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-000f7Z-Gg; Wed, 14 Feb 2024 10:34:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-004Y0N-1N;
	Wed, 14 Feb 2024 10:34:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 011/164] pwm: atmel-hlcdc: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:30:58 +0100
Message-ID:  <0e97342f15540c7330d405eaaf3e68baa8e1e488.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=y89OcbTy+fiOpfQjg5mC1/J3D4k2pVm31e6norgskAU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhXR2pGUnszLY2jeSyJE302rX70+MLmEMuqM ppd1XTQGDuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIVwAKCRCPgPtYfRL+ To+uB/4iR01+B7kqb0I/Br70QqxvbczTVgomN3vVloHAky+wwppLZPMWh2K8XGZ7nnYBoR++lWn e9lU1zo9mw9Jqjdr9YnA1QlimrjyCCdkrlVMFQcc8Veko+a8AZG8TImGz9tFgBvHYqU+a0lbR2w auPTCbKD7KWr+jRS/mTIghjlDKZtE5fvwI/fTaaslmdy5UoeW6nLkbXsq66vTM2+uTw6N9cuU8H BKkwRwrp1xo86iLiZfBfsrvfzdbCQkktwRnrt5Fht29QqWU8/zqcchWrCk4KlCIgDczb9pnslrP cSlf1okBqB2+QcQsFDTd85/bEun+d6sitLVGqCwHnBapt0S4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct atmel_hlcdc_pwm. Use the pwm_chip as driver
data instead of the atmel_hlcdc_pwm to get access to the pwm_chip in
the .suspend() and .resume() callbacks and atmel_hlcdc_pwm_remove()
without using atmel->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 1f6fc9a9fcf3..f3f6c951bda5 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -182,10 +182,11 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (!pwm_is_enabled(&chip->pwms[0]))
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
@@ -193,11 +194,12 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 
 static int atmel_hlcdc_pwm_resume(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 	struct pwm_state state;
 	int ret;
 
-	pwm_get_state(&atmel->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 
 	/* Re-enable the periph clock it was stopped during suspend. */
 	if (!state.enabled) {
@@ -206,8 +208,7 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
 			return ret;
 	}
 
-	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
-				     &state);
+	return atmel_hlcdc_pwm_apply(chip, &chip->pwms[0], &state);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
@@ -243,6 +244,7 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct atmel_hlcdc_pwm *atmel;
 	struct atmel_hlcdc *hlcdc;
 	int ret;
@@ -262,26 +264,28 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 		atmel->errata = match->data;
 
 	atmel->hlcdc = hlcdc;
-	atmel->chip.ops = &atmel_hlcdc_pwm_ops;
-	atmel->chip.dev = dev;
-	atmel->chip.npwm = 1;
+	chip = &atmel->chip;
+	chip->ops = &atmel_hlcdc_pwm_ops;
+	chip->dev = dev;
+	chip->npwm = 1;
 
-	ret = pwmchip_add(&atmel->chip);
+	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, atmel);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_hlcdc_pwm *atmel = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 
-	pwmchip_remove(&atmel->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(atmel->hlcdc->periph_clk);
 }
-- 
2.43.0


