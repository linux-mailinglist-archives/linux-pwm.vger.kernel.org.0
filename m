Return-Path: <linux-pwm+bounces-1317-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1185457E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D062F286B93
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F916428;
	Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C717565
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903264; cv=none; b=pTbXQU5+RxBr1AldZBLwdA9tdyqgnZ6Ej2oV1znGJbi8HXYRyx5QPTONXKDRmY8T2n5dzpitoE74rmPrrIZk9OYehMBRtSGa9581ktnQEQvb6Dd1VlhZ5OnF6pCF139IoAHCsSVZRWCXRD9wAiNNPnVvsNbquAlvSS+J58QFAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903264; c=relaxed/simple;
	bh=QIQRTGWYyMDDIqzmMspyZIZGmehbfXvdg62xGI/Tyy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCA9mU+VBnb0ImJ4XDAEirTt1IxhBoWmSMaCsGG3+5o4lFavA6DYXHD5OaPSuJBiFIeyChLoLGbO+BZd59c/mSVtsuTw6DP3ZytC8Vdnjvx3LUWTAUVTxY92Xe7pXMJnL3XScZendpaL/aWB9d0coGq55Lu2q1rDpH8amxLIFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-0004Ok-EF; Wed, 14 Feb 2024 10:34:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-000f71-18; Wed, 14 Feb 2024 10:34:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-004Y0B-34;
	Wed, 14 Feb 2024 10:34:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 008/164] pwm: atmel: Change prototype of a helper to prepare further changes
Date: Wed, 14 Feb 2024 10:30:55 +0100
Message-ID:  <c9a92f77760e401debfe0c9bfc086222f31fb3c4.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2858; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=QIQRTGWYyMDDIqzmMspyZIZGmehbfXvdg62xGI/Tyy0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhU1jXvH4ESWAqWsDYttDHJM5uqvSf1HqTuN xSTBs4ZIvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIVAAKCRCPgPtYfRL+ TnBsB/96dYVoGauzJJA7c5p/W7a1Y6fZ33BOsOLnX6EMLoSOJfgeDz8QhX3sl/McT59eBlPlaIM M9x5nubm1F4Hb/G5zDHO8/xVjWRiRHkZ0FYciOb8EvEO1hnyka/JsNrODbDdvhvtVgj0BUUWQJk k89FcLo8zmr2RcDCfUhOoDcme8RgPj4szJj8xGt7NoMNOMy8YaeKtzTMdI4h762FbQP1YzwabUA R5snKsGNJnnSdnC/TIawvIeOAHA79JC1bV2sZd7xc/vKYBYo2UGBscS4Y1mJbbZCU2HUwrZryRL FYzu5pOYiIVj2xfv7MKWHK1eP5H/GCg22jgFElzBj8cLIDL8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given atmel_pwm_chip. To just not have to
do that, rework atmel_pwm_enable_clk_if_on() to take a pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 47bcc8a3bf9d..2f7d6c43be85 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -462,8 +462,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
+static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 {
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int i, cnt = 0;
 	unsigned long sr;
 	int ret = 0;
@@ -472,7 +473,7 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 	if (!sr)
 		return 0;
 
-	cnt = bitmap_weight(&sr, atmel_pwm->chip.npwm);
+	cnt = bitmap_weight(&sr, chip->npwm);
 
 	if (!on)
 		goto disable_clk;
@@ -480,7 +481,7 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err(atmel_pwm->chip.dev,
+			dev_err(chip->dev,
 				"failed to enable clock for pwm %pe\n",
 				ERR_PTR(ret));
 
@@ -501,6 +502,7 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
+	struct pwm_chip *chip;
 	int ret;
 
 	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
@@ -521,15 +523,16 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
 				     "failed to get prepared PWM clock\n");
 
-	atmel_pwm->chip.dev = &pdev->dev;
-	atmel_pwm->chip.ops = &atmel_pwm_ops;
-	atmel_pwm->chip.npwm = 4;
+	chip = &atmel_pwm->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &atmel_pwm_ops;
+	chip->npwm = 4;
 
-	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
+	ret = atmel_pwm_enable_clk_if_on(chip, true);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_pwmchip_add(&pdev->dev, &atmel_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 		goto disable_clk;
@@ -538,7 +541,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
+	atmel_pwm_enable_clk_if_on(chip, false);
 
 	return ret;
 }
-- 
2.43.0


