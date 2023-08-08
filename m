Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37A774D50
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 23:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjHHVsN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHHVsE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 17:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384E31DD4B
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-0007Kf-66; Tue, 08 Aug 2023 19:19:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-00226Z-Dt; Tue, 08 Aug 2023 19:19:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00BTCy-Ks; Tue, 08 Aug 2023 19:19:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 044/101] pwm: renesas-tpu: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:34 +0200
Message-Id: <20230808171931.944154-45-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+uGF8pR6UFalJ/fSEomMGE39VSujXvrgBk+BrfHOdQw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njifvOrTXaU4I/aFrOKplCWv5rfgeO+w0aZP LkIgosdOQGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ44gAKCRCPgPtYfRL+ TpLZCACpTjNqgZH6Mj/pPTBv+ZOIqJ8e2sh/NFd9p8Fg1X0Lgz0GwX3IOoQGDVqreWnwfn8RL0C LRb2FT+J34p1AUmi3Df6vEp3xqQeElQ5i+lYatqAMmWrLMxSUzAZbZ7HPo2ndOCftN+JAAJmEBC I2ANzVVbLub2PKF8XPjfduGubkBVGWJdgUQXudJwCkl0s0cStypzI7N9hcL2P+upQDrQ/wY7L6s lQwB9fBA160pjn+EdSmEz/ow2A/9hwApuhfrlF3pL2NwnPPeFKXHPZgD3Kt33mTjluiB2fsSF8H wHglSCLkxUIbhWWtJ/YDtb345kLp+RTkQs6j52HLSFZsk6Zr
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

This prepares the pwm-renesas-tpu driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4239f2c3e8b2..2f6b2351619b 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -80,7 +80,6 @@ struct tpu_pwm_device {
 
 struct tpu_device {
 	struct platform_device *pdev;
-	struct pwm_chip chip;
 	spinlock_t lock;
 
 	void __iomem *base;
@@ -88,7 +87,10 @@ struct tpu_device {
 	struct tpu_pwm_device tpd[TPU_CHANNEL_MAX];
 };
 
-#define to_tpu_device(c)	container_of(c, struct tpu_device, chip)
+static inline struct tpu_device *to_tpu_device(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static void tpu_pwm_write(struct tpu_pwm_device *tpd, int reg_nr, u16 value)
 {
@@ -439,12 +441,14 @@ static const struct pwm_ops tpu_pwm_ops = {
 
 static int tpu_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct tpu_device *tpu;
 	int ret;
 
-	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
-	if (tpu == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, TPU_CHANNEL_MAX, sizeof(*tpu));
+	if (chip == NULL)
 		return -ENOMEM;
+	tpu = to_tpu_device(chip);
 
 	spin_lock_init(&tpu->lock);
 	tpu->pdev = pdev;
@@ -461,15 +465,13 @@ static int tpu_probe(struct platform_device *pdev)
 	/* Initialize and register the device. */
 	platform_set_drvdata(pdev, tpu);
 
-	tpu->chip.dev = &pdev->dev;
-	tpu->chip.ops = &tpu_pwm_ops;
-	tpu->chip.npwm = TPU_CHANNEL_MAX;
+	chip->ops = &tpu_pwm_ops;
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to enable runtime PM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &tpu->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register PWM chip\n");
 
-- 
2.40.1

