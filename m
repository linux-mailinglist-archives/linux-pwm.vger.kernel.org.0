Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81511774403
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjHHSOo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjHHSOO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCE91DD63
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-0007Pv-O8; Tue, 08 Aug 2023 19:19:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-00227d-47; Tue, 08 Aug 2023 19:19:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-00BTE9-Go; Tue, 08 Aug 2023 19:19:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 062/101] pwm: twl: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:52 +0200
Message-Id: <20230808171931.944154-63-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IrfOK/pnLPUC/Ond8S7xyvm337C7DPTn4WTirDYcaHg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nj2ZwMqGVcAxvyehjBSqZcC3Ib0tD+85EU8c 4ac2k4Hl2mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ49gAKCRCPgPtYfRL+ TnB7B/4xAxpiraSa4+HCuU0c+sRafDfYebLokqVcK9b2TjomnAdVKMr+ui8YUkCOVxXIK6Di15q P8WCWt7DcfJXMxf+7Mv/V3HIRQQzif/PHBhCV1vXHYf2nA111Bao9woY2ZqZVD2FnmPU78QMrxd 2osIfjxRDVxIiZ1qYS1vcb0zeO/c5VncaTWAD7N+BRtCwvvc7qfDW9nFErpEVns0SnHj4JoKOXa JE6erjHg4K6j6QlIASsqqis3onndMuvBEdoMPDp5E3ZiDNwhpmJx9Ao+XmHG+lbhFBNPNNTV6ua OkZiwx+T08PWUFEMcsICDWMLzE5G5GfxQrx1tKXm1YqPyjL0
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

This prepares the pwm-twol driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 603d31f27470..d66596c8597d 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -46,7 +46,6 @@
 #define TWL6030_PWM_TOGGLE(pwm, x)	((x) << (pwm * 3))
 
 struct twl_pwm_chip {
-	struct pwm_chip chip;
 	struct mutex mutex;
 	u8 twl6030_toggle3;
 	u8 twl4030_pwm_mux;
@@ -54,7 +53,7 @@ struct twl_pwm_chip {
 
 static inline struct twl_pwm_chip *to_twl(struct pwm_chip *chip)
 {
-	return container_of(chip, struct twl_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -341,23 +340,22 @@ static const struct pwm_ops twl6030_pwm_ops = {
 
 static int twl_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct twl_pwm_chip *twl;
 
-	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
-	if (!twl)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*twl));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	twl = to_twl(chip);
 
 	if (twl_class_is_4030())
-		twl->chip.ops = &twl4030_pwm_ops;
+		chip->ops = &twl4030_pwm_ops;
 	else
-		twl->chip.ops = &twl6030_pwm_ops;
-
-	twl->chip.dev = &pdev->dev;
-	twl->chip.npwm = 2;
+		chip->ops = &twl6030_pwm_ops;
 
 	mutex_init(&twl->mutex);
 
-	return devm_pwmchip_add(&pdev->dev, &twl->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.40.1

