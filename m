Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A810774695
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjHHS6x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjHHS6i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8177F175DFD
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-0007CP-CS; Tue, 08 Aug 2023 19:19:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00225L-Lo; Tue, 08 Aug 2023 19:19:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-00BTBl-RC; Tue, 08 Aug 2023 19:19:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 026/101] pwm: iqs620a: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:16 +0200
Message-Id: <20230808171931.944154-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4067; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LmTSmFGmHzEQjOdcguSRyCG027WKMMalWO8lUxZK6CI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njOC8qXpnybljWmmzHsIltLc/Dk+cix7lcmh DN+J0knlGiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4zgAKCRCPgPtYfRL+ ToGZB/9n3UMxhg9HQEQTHEgPI21GSaPjxftsMoHA8olJ3I5QixIboMG9yH7rFCnmVHKStzNkJRu t0/yICkzOa/5oSQu379uBsd+B4z5ZO5iRNGr+fgIgoaalYK3HWrbKFzkYSeShwNYSKIYeD/0cTo R+ahptJYRhj1uTzVjUiMlcX8gB+PJdsifWqTlA4ofz4/hUX8XfN1L9lNxibH7nyw8eRd19Lw4xi ZPxAgidXRD5T0SY9u0XnTqLerTLUcP9mmK8DdGNgmqUVnCPrdGPc+jbdalsrDEkYSFzBQc18UWa H95W+sYNLcJGNz3DNAeT+eoT5hNNikWupfBwzG5FTb/uNT1B
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

This prepares the pwm-iqs620a driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-iqs620a.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 378ab036edfe..a012a0f22b9a 100644
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
+	return pwmchip_priv(chip);
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
2.40.1

