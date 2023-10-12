Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E827C72C2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379568AbjJLQbO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379607AbjJLQbB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBF4DD
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-0004wr-UL; Thu, 12 Oct 2023 18:30:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-001C7R-Hj; Thu, 12 Oct 2023 18:30:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-00F5ON-8g; Thu, 12 Oct 2023 18:30:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 034/109] pwm: twl-led: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:29:02 +0200
Message-ID: <20231012162827.1002444-145-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5759; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EHzSUIME7/PKYwsjXByjKLoB1ZA/rLxu224ObIm9evY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7UXdEjLQXwVb+4tmqpyJLfWe5vjYG1BcnN8 mgZ6XeU8xiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge1AAKCRCPgPtYfRL+ TsbQB/9k5ZGqww0Xk6k6sl5oHyeNHRdqeuNjMmBHa768A/mfOd9yqmz1ipTteK+bVaxWrMqWPro PJN/zJdKoAQpoiRU2oWQG43Dhkn/ZKV1Yha5FHG894q/EY28BcCP471S6KKiHa3qqQlKipsvA0k FiGD0+nqSEvPxVoFuILpMfPWx2XyYTgeBwCRa6sObL4YKsaCXfeyfZ4na1JHRAVqnWdYhDevNWv /fpUO0WD4PWi20P/NW/dcSkxyzSrrt3SeClM5acddSXjyqoWWe6WPAYqHzSp9RLuwEc47jIIJMQ C6yqDUXgEsV9mQYgsOjTLhVMQX7ucstN7u4bSBIckYrBpzYR
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

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl-led.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 625233f4703a..f1a9f04295ea 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -100,7 +100,7 @@ static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = twl_i2c_write(TWL4030_MODULE_LED, pwm_config, base, 2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -114,7 +114,7 @@ static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read LEDEN\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read LEDEN\n", pwm->label);
 		goto out;
 	}
 
@@ -122,7 +122,7 @@ static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_LED, val, TWL4030_LEDEN_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -139,7 +139,7 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read LEDEN\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read LEDEN\n", pwm->label);
 		goto out;
 	}
 
@@ -147,7 +147,7 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_LED, val, TWL4030_LEDEN_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -203,7 +203,7 @@ static int twl6030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, on_time,
 			       TWL6030_LED_PWM_CTRL1);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -217,7 +217,7 @@ static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -227,7 +227,7 @@ static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -244,7 +244,7 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -254,7 +254,7 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -295,7 +295,7 @@ static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -305,7 +305,7 @@ static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to request PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to request PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -321,7 +321,7 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -331,7 +331,7 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to free PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to free PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
-- 
2.42.0

