Return-Path: <linux-pwm+bounces-375-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF2806EAE
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04411F21371
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10B364B6;
	Wed,  6 Dec 2023 11:48:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A410D1
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-0007AA-Oi; Wed, 06 Dec 2023 12:48:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00DwwI-OF; Wed, 06 Dec 2023 12:48:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00FR1l-FZ; Wed, 06 Dec 2023 12:48:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 080/115] pwm: omap-dmtimer: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:34 +0100
Message-ID:  <7a4d3a25edf7f1ab2a810e7e4546a0e0f0cd90b4.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mhrsq4Q2GuIG0Rjq4zcdn3AP5ie/Zu6ZtubAK4qfqX8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF76QO9wdtBJE+O1B3HonXXkK1CvzJycJAEMd 1YtDHnaypyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe+gAKCRCPgPtYfRL+ Tr37B/wPy8GCV1MU1HzaXr/mN9Roy+NBp6tjuv2NNfkJzhF1Gp7a82Ol7c+wph9DcSYecKMQQEu KeFL1ck1eQscFP1JPdQZ1eNtzyqzklzUISozcs8eGYLTP829goSXpXazQJwxCYsmyvBr7HVESNs IIvW+BIrjc8USXWTc3ZdbA4RBXcIGecSW8N4rnu37QQ3CWJMriyGUOvruipBVs1uCEQwkprO92+ 2ByV09qo+S+vzpO0wlyo0bX9BCZilNwPwQ5SeQSuHnej7y+fs+Z85aIrVCCgN4Lmse764vhwrCQ g+sjwv68wHhVpCC7qKet4Q1Px5CvVyFuUrxxWc0IZf34Dz70
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
 drivers/pwm/pwm-omap-dmtimer.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index c7c7383f4b14..42f3e33a8aa8 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -61,7 +61,6 @@
  * @dm_timer_pdev:	Pointer to omap dm timer platform device
  */
 struct pwm_omap_dmtimer_chip {
-	struct pwm_chip chip;
 	/* Mutex to protect pwm apply state */
 	struct mutex mutex;
 	struct omap_dm_timer *dm_timer;
@@ -72,7 +71,7 @@ struct pwm_omap_dmtimer_chip {
 static inline struct pwm_omap_dmtimer_chip *
 to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_omap_dmtimer_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /**
@@ -319,6 +318,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	struct dmtimer_platform_data *timer_pdata;
 	const struct omap_dm_timer_ops *pdata;
 	struct platform_device *timer_pdev;
+	struct pwm_chip *chip;
 	struct pwm_omap_dmtimer_chip *omap;
 	struct omap_dm_timer *dm_timer;
 	struct device_node *timer;
@@ -376,11 +376,12 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
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
@@ -400,13 +401,11 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v))
 		omap->pdata->set_source(omap->dm_timer, v);
 
-	omap->chip.dev = &pdev->dev;
-	omap->chip.ops = &pwm_omap_dmtimer_ops;
-	omap->chip.npwm = 1;
+	chip->ops = &pwm_omap_dmtimer_ops;
 
 	mutex_init(&omap->mutex);
 
-	ret = pwmchip_add(&omap->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
 		goto err_pwmchip_add;
@@ -414,14 +413,14 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
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
@@ -442,9 +441,10 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
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
2.42.0


