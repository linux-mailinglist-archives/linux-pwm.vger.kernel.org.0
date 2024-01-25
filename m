Return-Path: <linux-pwm+bounces-1000-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7B83C1E2
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D430D1C22514
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3D374F5;
	Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BC45C0B
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184658; cv=none; b=lAbadsQ/W+CKNZntKnvtk8woi0npDGeTWI3il5tNqgy6cmn/8hpBiX0jd0duekLmoT852Orfhz3VAv/jVOe4K+IJslI7QyKNf68PwTcgm1qXTQ6QSIzA84Zrp2nFRxxGrwCkmUWmGdqT13CADx+z7/HFqbS4ZNKxXly2h7EWXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184658; c=relaxed/simple;
	bh=GdtKgm7FPgwKAnVXQCebICOlKgI3Ggq5uNj+mQ4o03s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAYCibBUOWPQu91p3QCItwYXXWKCEsa9EjQqmAerr/80NPdl4wY+t8ZYCXg9GOK6o6lnoachC/23OZJz4ZbmrDfnfaqHhp5QxcTCyh8P61CEug2QeiYkM5SK6jpXMdIWm3ca87DIcTAtkaoROoEtEvGyCTuUj9EyvfIEMN0Vl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-0004Nm-KR; Thu, 25 Jan 2024 13:10:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-002HSs-KZ; Thu, 25 Jan 2024 13:10:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-007n2S-1o;
	Thu, 25 Jan 2024 13:10:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 064/111] pwm: iqs620a: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:26 +0100
Message-ID:  <6287799c690e9e3f7625f0161e13585e21f4655e.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4074; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GdtKgm7FPgwKAnVXQCebICOlKgI3Ggq5uNj+mQ4o03s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+FtolNENm+LLHTBvzNapR7eySjIBdNrigpb CiR7Kxw1JeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPhQAKCRCPgPtYfRL+ Tv/qB/9omVunve83AW78S3y7sNI7KF480NkxUYAJ/FLnkT+oUPMXZL4IHTWyFFemjoWxQi8D8Vu 6uO5jaz0+4jmL+CXd4usppuPR9N2jkzTyRe5IWtodbEbRmPy2ZFgFseMx/5x1KN9Fyxs0INyw6r DDE3AmufHiFvzxjmWqBvhgjihb0FHbAsJVsY04fUWN4dsYzRVkv2FOIIp5ebjolGbR0cK6Ha+D2 NS5OZNYc/IyXI0BUEDQ8iHr1D4ZQ8yP9P4LPMon0S98FdcemnsgTRvBZ6GuG/EQ8e5X5ZUx/IVn qsTCA0fZF0I5PRpsyVe3HD4LmqLh9Bj8Cd44n0NC5bFn9BC8
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
 drivers/pwm/pwm-iqs620a.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 378ab036edfe..f2d1ed8df3eb 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -34,12 +34,17 @@
 
 struct iqs620_pwm_private {
 	struct iqs62x_core *iqs62x;
-	struct pwm_chip chip;
+	struct device *dev;
 	struct notifier_block notifier;
 	struct mutex lock;
 	unsigned int duty_scale;
 };
 
+static inline struct iqs620_pwm_private *iqs620_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
 static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
 			   unsigned int duty_scale)
 {
@@ -73,7 +78,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period < IQS620_PWM_PERIOD_NS)
 		return -EINVAL;
 
-	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	iqs620_pwm = iqs620_pwm_from_chip(chip);
 
 	/*
 	 * The duty cycle generated by the device is calculated as follows:
@@ -107,9 +112,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
-	struct iqs620_pwm_private *iqs620_pwm;
-
-	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	struct iqs620_pwm_private *iqs620_pwm = iqs620_pwm_from_chip(chip);
 
 	mutex_lock(&iqs620_pwm->lock);
 
@@ -155,7 +158,7 @@ static int iqs620_pwm_notifier(struct notifier_block *notifier,
 	mutex_unlock(&iqs620_pwm->lock);
 
 	if (ret) {
-		dev_err(iqs620_pwm->chip.dev,
+		dev_err(iqs620_pwm->dev,
 			"Failed to re-initialize device: %d\n", ret);
 		return NOTIFY_BAD;
 	}
@@ -170,28 +173,32 @@ static const struct pwm_ops iqs620_pwm_ops = {
 
 static void iqs620_pwm_notifier_unregister(void *context)
 {
-	struct iqs620_pwm_private *iqs620_pwm = context;
+	struct pwm_chip *chip = context;
+	struct iqs620_pwm_private *iqs620_pwm = iqs620_pwm_from_chip(chip);
 	int ret;
 
 	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
 						 &iqs620_pwm->notifier);
 	if (ret)
-		dev_err(iqs620_pwm->chip.dev,
+		dev_err(iqs620_pwm->dev,
 			"Failed to unregister notifier: %d\n", ret);
 }
 
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
 
 	iqs620_pwm->iqs62x = iqs62x;
+	iqs620_pwm->dev = &pdev->dev;
 
 	ret = regmap_read(iqs62x->regmap, IQS620_PWR_SETTINGS, &val);
 	if (ret)
@@ -205,9 +212,7 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 		iqs620_pwm->duty_scale = val + 1;
 	}
 
-	iqs620_pwm->chip.dev = &pdev->dev;
-	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
-	iqs620_pwm->chip.npwm = 1;
+	chip->ops = &iqs620_pwm_ops;
 
 	mutex_init(&iqs620_pwm->lock);
 
@@ -221,11 +226,11 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       iqs620_pwm_notifier_unregister,
-				       iqs620_pwm);
+				       chip);
 	if (ret)
 		return ret;
 
-	ret = devm_pwmchip_add(&pdev->dev, &iqs620_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
 
-- 
2.43.0


