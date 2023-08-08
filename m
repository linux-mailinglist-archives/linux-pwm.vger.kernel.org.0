Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF7774408
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjHHSOr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjHHSOS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8A01DD76
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-0007SZ-F8; Tue, 08 Aug 2023 19:19:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00228P-3Y; Tue, 08 Aug 2023 19:19:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-00BTEi-Ao; Tue, 08 Aug 2023 19:19:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 071/101] pwm: ab8500: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:01 +0200
Message-Id: <20230808171931.944154-72-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=b59Z0B92+Vmv0gp17eYaP4bDW86CwRYn+N0P3ZOIXyg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkA+r3sVVEVFGV0eBDVUd0mF0YoWNKd9rHeQ 3M9gFB9K+eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5AAAKCRCPgPtYfRL+ TkftCACHV2cujhrhiKFFFsnQ33wJI662fdMMTq2bltMUrZe4n14Z9hKPDjFTT01JnGYlweE9vjM fqOoJyXOSFLFR+cd45BG8Wor/0kqyBge6DDPUbT94xf+YOIiCWOJSsuqLbReiOU/gyfR5IiGqxw QkBRlwv6z4cQckS/J5Gsgd2JBHnem66Z8KTBHl/gE5sFoiAQcly3Y8CTh27iUYDkTDxZEjCVl0U jjN3OQWZN9Xynmas2sHpoir/wS50gfnLqTvMh193Jwnwrubk4n2wxIYm1ec/m7fHzTB7yhWpiQt RhPA21/VnRAdgkS3xByEyq3jB8BXWbz1L6np6AtioRGX0XU6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index f64f3fd251e7..663fdfe90bb6 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -24,6 +24,7 @@
 #define AB8500_PWM_CLKRATE 9600000
 
 struct ab8500_pwm_chip {
+	struct device *parent;
 	unsigned int hwid;
 };
 
@@ -91,7 +92,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * when disabled.
 	 */
 	if (!state->enabled || duty_steps == 0) {
-		ret = abx500_mask_and_set_register_interruptible(chip->dev,
+		ret = abx500_mask_and_set_register_interruptible(ab8500->parent,
 					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 					1 << ab8500->hwid, 0);
 
@@ -111,18 +112,18 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(ab8500->parent, AB8500_MISC,
 			reg, lower_val);
 	if (ret < 0)
 		return ret;
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(ab8500->parent, AB8500_MISC,
 			(reg + 1), higher_val);
 	if (ret < 0)
 		return ret;
 
 	/* enable */
-	ret = abx500_mask_and_set_register_interruptible(chip->dev,
+	ret = abx500_mask_and_set_register_interruptible(ab8500->parent,
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 				1 << ab8500->hwid, 1 << ab8500->hwid);
 
@@ -137,7 +138,7 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
 	unsigned int div, duty_steps;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(ab8500->parent, AB8500_MISC,
 						AB8500_PWM_OUT_CTRL7_REG,
 						&ctrl7);
 	if (ret)
@@ -150,13 +151,13 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(ab8500->parent, AB8500_MISC,
 						AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2),
 						&lower_val);
 	if (ret)
 		return ret;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(ab8500->parent, AB8500_MISC,
 						AB8500_PWM_OUT_CTRL2_REG + (ab8500->hwid * 2),
 						&higher_val);
 	if (ret)
@@ -196,6 +197,7 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	ab8500 = pwmchip_priv(chip);
 
 	chip->ops = &ab8500_pwm_ops;
+	ab8500->parent = &pdev->dev;
 	ab8500->hwid = pdev->id - 1;
 
 	err = devm_pwmchip_add(&pdev->dev, chip);
-- 
2.40.1

