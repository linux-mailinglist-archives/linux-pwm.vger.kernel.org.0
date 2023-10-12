Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C37C7306
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379627AbjJLQbw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379564AbjJLQbU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F924D3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyad-0005p9-R0; Thu, 12 Oct 2023 18:31:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-001CB2-W9; Thu, 12 Oct 2023 18:31:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-00F5SH-NA; Thu, 12 Oct 2023 18:31:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 092/109] pwm: sun4i: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:30:00 +0200
Message-ID: <20231012162827.1002444-203-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NamMhonsmWC/vi5fd8wfhvGOrAdNJTRMzmBa6OpmDa8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8YjaoSvfLlTQRQTIEZx8QXpI4WVF2SrI4t6 3vk84iJ+3KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfGAAKCRCPgPtYfRL+ TioSB/9kiJvgg8FolMdjD37DF1+YhTdHSw2vJSO/ev34HTpmFbx0vdbOfA8UDDiUQ5jL/6Dbq1h R86pdG//PRPZdkWE4hpAKMt+jNs5+F+FNV/81D2So2QNXt+aQYGyuH0amFVm7mBLjGJDDafa2Dw 7gXFgqGDp9Qqk8hy/n6v1HHpAX7tyRLGr7A13vH3+7lQhakRdWVG+HJsaPKWLkbYk1rj2qWG7rF yVz4Q0/5ZVSzQKU4f/A0HhvxkuHSeO4XIXzDd7cG+0x4IofFFA7+gQfHVqsmXyGdXDRGY7j3xHM dBbY07/+haGKNXNnmRd8GJ8aYuFFiJj2Gyj3DIukASX/6lG5
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

This prepares the pwm-sun4i driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 44edf1ce5739..65652f510237 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -81,7 +81,6 @@ struct sun4i_pwm_data {
 };
 
 struct sun4i_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -92,7 +91,7 @@ struct sun4i_pwm_chip {
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sun4i_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
@@ -384,17 +383,22 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct sun4i_pwm_chip *sun4ichip;
+	const struct sun4i_pwm_data *data;
 	int ret;
 
-	sun4ichip = devm_kzalloc(&pdev->dev, sizeof(*sun4ichip), GFP_KERNEL);
-	if (!sun4ichip)
-		return -ENOMEM;
-
-	sun4ichip->data = of_device_get_match_data(&pdev->dev);
-	if (!sun4ichip->data)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
+	chip = devm_pwmchip_alloc(&pdev->dev, data->npwm, sizeof(*sun4ichip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	sun4ichip = to_sun4i_pwm_chip(chip);
+
+	sun4ichip->data = data;
+
 	sun4ichip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sun4ichip->base))
 		return PTR_ERR(sun4ichip->base);
@@ -451,19 +455,18 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto err_bus;
 	}
 
-	sun4ichip->chip.dev = &pdev->dev;
-	sun4ichip->chip.ops = &sun4i_pwm_ops;
-	sun4ichip->chip.npwm = sun4ichip->data->npwm;
+	chip->ops = &sun4i_pwm_ops;
+	chip->npwm = sun4ichip->data->npwm;
 
 	spin_lock_init(&sun4ichip->ctrl_lock);
 
-	ret = pwmchip_add(&sun4ichip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		goto err_pwm_add;
 	}
 
-	platform_set_drvdata(pdev, sun4ichip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -477,9 +480,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 static void sun4i_pwm_remove(struct platform_device *pdev)
 {
-	struct sun4i_pwm_chip *sun4ichip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct sun4i_pwm_chip *sun4ichip = to_sun4i_pwm_chip(chip);
 
-	pwmchip_remove(&sun4ichip->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(sun4ichip->bus_clk);
 	reset_control_assert(sun4ichip->rst);
-- 
2.42.0

