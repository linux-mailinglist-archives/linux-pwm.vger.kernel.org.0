Return-Path: <linux-pwm+bounces-1011-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419D83C217
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687E9B216C9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722DD4501B;
	Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F93B19D
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184660; cv=none; b=tI0WGjIBwj/+XKcWFCx5F0FclyvYk9z0JBsTfOq0X2NywN38222k21/Ip3Jn1wt6CuukxnhKhhyE3BzsFoAQUFaUyyNdDqmK5Kf9m7aBo8qwwW/wtKLatfc1FlaxFC19QuDsvzcAWWmJ8F0cotNJ0Hlyd5nmzgta/air7z3MwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184660; c=relaxed/simple;
	bh=y408aXm7DpzyHOBVxSg45bp7eBxCcd1kEFBMz0F1kDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrUN+KGwuG5P6tlKWCjbMZoZVB0iCinUWJAvqnCFh/HN7qTVXPk0Q0FLpCvLNGBf6A54gBRonF7JjczOnyIK4d4ug3CJnKYGGVYzBl3R9UaGS2owXl4qJSUzBMAj3tlk9RtQxh45Ftgt4L6BSvWp6SxHi8Z50JHbd5u/BHm1s9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-0004Sg-BI; Thu, 25 Jan 2024 13:10:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-002HTf-7F; Thu, 25 Jan 2024 13:10:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-007n3I-0R;
	Thu, 25 Jan 2024 13:10:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 077/111] pwm: omap-dmtimer: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:39 +0100
Message-ID:  <5201dc290c7e00fdd0d5e3ee429279ef2b98ea27.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3591; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=y408aXm7DpzyHOBVxSg45bp7eBxCcd1kEFBMz0F1kDU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+UrjQJhe1+7L8YGcMrGhckP8rN2oBgUfSnE 4THCGA19KmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPlAAKCRCPgPtYfRL+ TgDKB/0aMBZTUdoLYW5uf4kiTxxdtZ7a4BtTK+xW4lNQZx1DQYYp5/d14S3H3bcTsIqPXoRXGQu 1cqFKA7FYcIdAiF6j2TjPYpkpNkupCc8xFomctXa3Io6Gfyn3CijtoCNqpD84e5iytu26917oTK Vgaj9nxUsh5WWKOCc1Bg14XfanEGrgE9kGoajWtshmBfzbyPeNMIT7DWnDBiX1QusZnd8xjOf0m 9JxAEHMR+ohdXgwwWkMkwTuY+LT4+HSK8/fTB74/KFrjKdjaZ6OvHLfNlzICRyR+QiCyuoMs8st qyPwxWU/M4qOUZVSjKDWe6OuSZBagOXFsfhVRC9Zlezqw8z4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-omap-dmtimer driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 527a7aa0ce61..705f40fd0bea 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -53,13 +53,11 @@
 /**
  * struct pwm_omap_dmtimer_chip - Structure representing a pwm chip
  *				  corresponding to omap dmtimer.
- * @chip:		PWM chip structure representing PWM controller
  * @dm_timer:		Pointer to omap dm timer.
  * @pdata:		Pointer to omap dm timer ops.
  * @dm_timer_pdev:	Pointer to omap dm timer platform device
  */
 struct pwm_omap_dmtimer_chip {
-	struct pwm_chip chip;
 	/* Mutex to protect pwm apply state */
 	struct omap_dm_timer *dm_timer;
 	const struct omap_dm_timer_ops *pdata;
@@ -69,7 +67,7 @@ struct pwm_omap_dmtimer_chip {
 static inline struct pwm_omap_dmtimer_chip *
 to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_omap_dmtimer_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /**
@@ -311,6 +309,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	struct dmtimer_platform_data *timer_pdata;
 	const struct omap_dm_timer_ops *pdata;
 	struct platform_device *timer_pdev;
+	struct pwm_chip *chip;
 	struct pwm_omap_dmtimer_chip *omap;
 	struct omap_dm_timer *dm_timer;
 	struct device_node *timer;
@@ -368,11 +367,12 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		goto err_request_timer;
 	}
 
-	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
-	if (!omap) {
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*omap));
+	if (!chip) {
 		ret = -ENOMEM;
 		goto err_alloc_omap;
 	}
+	omap = to_pwm_omap_dmtimer_chip(chip);
 
 	omap->pdata = pdata;
 	omap->dm_timer = dm_timer;
@@ -392,11 +392,9 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v))
 		omap->pdata->set_source(omap->dm_timer, v);
 
-	omap->chip.dev = &pdev->dev;
-	omap->chip.ops = &pwm_omap_dmtimer_ops;
-	omap->chip.npwm = 1;
+	chip->ops = &pwm_omap_dmtimer_ops;
 
-	ret = pwmchip_add(&omap->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
 		goto err_pwmchip_add;
@@ -404,14 +402,14 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	of_node_put(timer);
 
-	platform_set_drvdata(pdev, omap);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
 err_pwmchip_add:
 
 	/*
-	 * *omap is allocated using devm_kzalloc,
+	 * *omap is allocated using devm_pwmchip_alloc,
 	 * so no free necessary here
 	 */
 err_alloc_omap:
@@ -432,9 +430,10 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 static void pwm_omap_dmtimer_remove(struct platform_device *pdev)
 {
-	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
-	pwmchip_remove(&omap->chip);
+	pwmchip_remove(chip);
 
 	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
 		omap->pdata->stop(omap->dm_timer);
-- 
2.43.0


