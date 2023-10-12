Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8EB7C72F2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379605AbjJLQbl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379607AbjJLQbP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:15 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC871C0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-0005ga-Ot; Thu, 12 Oct 2023 18:31:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaY-001C9u-Bw; Thu, 12 Oct 2023 18:31:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaY-00F5RB-2s; Thu, 12 Oct 2023 18:31:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 075/109] pwm: omap-dmtimer: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:43 +0200
Message-ID: <20231012162827.1002444-186-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hL01n8HkZgcSyMVzZH0K2Cl+9kMFjIcq8rDxLRiq+/0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNeRbP5uMOhk8zVwYr8XxZ1DqFb1/7278Pd29MrWpc+ yx9B09XJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATKYhj/2cSqlJZM40rvd2v bOGn1KS/ilcOdT/LLnqt+4h5Rvf/E6uuTOcM2H4xfuUFjYluHV/WT3wW0PNvyuSFW7+s9D9gIjD f09exIZMjM91+9oHPAqtnqnD0BXRMExLf2lBs/UvudIbp0l1VCzutpgdyrXvYVHtXK+73+wyJim O2ERVZZ9t/WUXwbGzyfjNb7WvUD4GMCfdCZqw4f3ifhHDN3wRmzam2yV8Exc+m3OUJVwrM5lY9V On9dmZV/3vdn0vCxMO17AuWXVbJ19R+1q7NV+11mOPyslk/ndjuZ3fW3dZVzw2fuVLs4pmvm1v7 nYq3M+9r7bBq2CxQq2mUXmXVWv1zQ5t4u7D/BUPnZreFAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-omap-dmtimer driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index c7c7383f4b14..7d161008c74c 100644
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
+	return pwmchip_priv(chip);
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

