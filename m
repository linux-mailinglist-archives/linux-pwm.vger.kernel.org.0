Return-Path: <linux-pwm+bounces-1372-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D311C8545BC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860851F2D875
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DC6182BF;
	Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568212B9B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903275; cv=none; b=I5lypxhnX7LR++wRsuol6vzgJ78eRAHSbVmOrm5Kb5gchF1Jzxybm094/BhUDxRVHtHIooijQEmnONRtoBQ8nTTdZflJg1eJGIyaLS1vRGWKm6QQQVGvKE9CMGtxzdUnQUwWGZnziMPYiaVm2QlimHUYZozWD/clygkgbIEEzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903275; c=relaxed/simple;
	bh=7e33xUSle6tucrmU7JPAAxCXOKLGA4HlX7gje6Yzne8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPKg0ZUtQjEJ7R5EoCPSHgC+Kt5JVQSepGMCVWndb0gwkbh0lVks4qOdJxhzN+JDAtsEjvPP52lptISOggrjfCEDQhLdHeBFLy+8BnteBgEn05WhUr6xxnly2FsZQHk9JOywkra5sbo0YWO789uG7LRdo5l29mxQqNE8f/oqhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-0004q5-GQ; Wed, 14 Feb 2024 10:34:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-000fCB-75; Wed, 14 Feb 2024 10:34:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-004Y3J-0S;
	Wed, 14 Feb 2024 10:34:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 054/164] pwm: iqs620a: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:41 +0100
Message-ID:  <85cb0e73baadd76ede364abc4b57ee72000880e5.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=7e33xUSle6tucrmU7JPAAxCXOKLGA4HlX7gje6Yzne8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiI4JVS7p3KA+Htqqx2bDvcNcwP5VZM51Fc6 h40EEipCeaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIiAAKCRCPgPtYfRL+ Tg6MB/9e7OjSk1eAB7jgsTdCmxWeIAuT4Wao6kRLl7nmMM16jGTR4WbyCl6OFPMXANLVoQXRBWM CX/m9+CZkrnY/GAVBwFMqy4RIYD4gHSK9y4JpSGPKbJEHw20aiy8BErCe6Mp8MsXhx02yylolU6 HlyuxbqVziIh3YG20lnnLNrAhqO/XCZqTes4JpVCJ4/pY4z9s6ZXbX9E1DiEJNkufks3BY3Hmuq h1T6lo3+jM16KfAiga0UsVzUP+GcwBBcITfcfFFM6GcaHDVsIhG6L9yUVYkZaTMOrUGa77oRXCg 4vsE1lWYBKy8aCg14FqU/AQ8IDoafye7cWhAoZflVUsxlxF/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-iqs620a driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-iqs620a.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index faf52d3c2720..13e5e138c8e9 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -35,7 +35,6 @@
 struct iqs620_pwm_private {
 	struct iqs62x_core *iqs62x;
 	struct device *dev;
-	struct pwm_chip chip;
 	struct notifier_block notifier;
 	struct mutex lock;
 	unsigned int duty_scale;
@@ -43,7 +42,7 @@ struct iqs620_pwm_private {
 
 static inline struct iqs620_pwm_private *iqs620_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct iqs620_pwm_private, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
@@ -189,14 +188,16 @@ static void iqs620_pwm_notifier_unregister(void *context)
 static int iqs620_pwm_probe(struct platform_device *pdev)
 {
 	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct iqs620_pwm_private *iqs620_pwm;
 	unsigned int val;
 	int ret;
 
-	iqs620_pwm = devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERNEL);
-	if (!iqs620_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*iqs620_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
+	iqs620_pwm = iqs620_pwm_from_chip(chip);
 	iqs620_pwm->dev = &pdev->dev;
 	iqs620_pwm->iqs62x = iqs62x;
 
@@ -212,9 +213,7 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 		iqs620_pwm->duty_scale = val + 1;
 	}
 
-	iqs620_pwm->chip.dev = &pdev->dev;
-	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
-	iqs620_pwm->chip.npwm = 1;
+	chip->ops = &iqs620_pwm_ops;
 
 	mutex_init(&iqs620_pwm->lock);
 
@@ -232,7 +231,7 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_pwmchip_add(&pdev->dev, &iqs620_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
 
-- 
2.43.0


