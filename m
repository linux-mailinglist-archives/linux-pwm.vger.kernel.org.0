Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F97746A1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjHHS67 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjHHS6l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C9575866
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-0007Ib-VZ; Tue, 08 Aug 2023 19:19:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-002261-6B; Tue, 08 Aug 2023 19:19:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00BTCb-HZ; Tue, 08 Aug 2023 19:19:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 039/101] pwm: omap-dmtimer: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:29 +0200
Message-Id: <20230808171931.944154-40-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dwvi2mTGIED9RReoPReeDB0RCuOpj5cTJgVgrgQHvOw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njc4QnHf7RRRgfNBtP3h8pXZoBGz/zD9gMPz gsRBhGd27aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ43AAKCRCPgPtYfRL+ ThBiB/9goWB+j9M9Z5HnG9B+Ol1NH9/lEYPBytTSUXdLNjTWl7j5zC8+Wf8ts+36cjCs+dwUdkt L07Kv1E8s2NaSUJKQ0UAgq6JSrcOYHttB8LRXym+UM7Oo5Q0IgxA+cpi1kZKIfmZSbpWiUf+gkM tdIodK63M0AAdp2GJv7amZ4u1aQoxeNYrCxHvqZ1RQE55eYcQervUDc0J/cuO7mbwYcJVusWvb5 E5dc1DjKkcnI6SJfwA7CMncRT8FV3u4NhJXerEG87jN/gRLlU82QGKvvcYRLFvnCcAKMeCw3i9f WgihwKThJFUNsS13/feEuMWzWQmDoUO02NfzqozhgdZWhwfU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 40a46138ebbb..c8d2db240b9e 100644
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
2.40.1

