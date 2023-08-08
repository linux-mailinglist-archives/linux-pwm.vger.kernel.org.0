Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5B6774413
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjHHSPB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjHHSOd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827991DD21
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNH-0007lS-Gx; Tue, 08 Aug 2023 19:20:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0022AX-Qk; Tue, 08 Aug 2023 19:20:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-00BTGS-PU; Tue, 08 Aug 2023 19:20:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 097/101] pwm: twl-led: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:27 +0200
Message-Id: <20230808171931.944154-98-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6746; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6hnxPguv3/jYzXlsDudTGkmdRjiCS1Tw/AyMNRRw3pM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkdUfjFN8I2JQ08em86j+DdH7TcmojlSoUCv b1FGfq9K8iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5HQAKCRCPgPtYfRL+ Tq3zCAC3IuQqdPosE7/Ci288x+RKoxwt80eKgRR0HkIJnpI5leMSuxxnZUrgxFBK6CvBRW6UWti 9GjV3pXJr3Faxm2V+QG06zNmQ9v4hfxccFrwxEWqfO5hekT5+HbA4a8zlXovNfrUbOtQfojOoAI LKxB6SNL3FMuW5apNNlQhzu3uWBsd/UTv9NoXmUtnclDjgRMPaGipvp489soUb1MZJRmP8we7h3 29ZRXShfUj5DD7ncwky5Nxv7yLT+fSGgu/BPyIaJ5cnt23RperAZsrRPMX1XY9hFQB+Y5rnxv2B ZWMLuqC2W84APvysavyei/ex68Dxb0ebDlfdFz82sg3v4pbM
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
 drivers/pwm/pwm-twl-led.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 4591ffab7863..8222107cf272 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -62,6 +62,7 @@
 #define TWL6040_LED_MODE_MASK	0x03
 
 struct twl_pwmled_chip {
+	struct device *parent;
 	struct mutex mutex;
 };
 
@@ -73,6 +74,7 @@ static inline struct twl_pwmled_chip *to_twl(struct pwm_chip *chip)
 static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
+	struct twl_pwmled_chip *twl = to_twl(chip);
 	int duty_cycle = DIV_ROUND_UP(duty_ns * TWL4030_LED_MAX, period_ns) + 1;
 	u8 pwm_config[2] = { 1, 0 };
 	int base, ret;
@@ -99,7 +101,7 @@ static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = twl_i2c_write(TWL4030_MODULE_LED, pwm_config, base, 2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -113,7 +115,7 @@ static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read LEDEN\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to read LEDEN\n", pwm->label);
 		goto out;
 	}
 
@@ -121,7 +123,7 @@ static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_LED, val, TWL4030_LEDEN_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -138,7 +140,7 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read LEDEN\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to read LEDEN\n", pwm->label);
 		goto out;
 	}
 
@@ -146,7 +148,7 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_LED, val, TWL4030_LEDEN_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -193,6 +195,7 @@ static const struct pwm_ops twl4030_pwmled_ops = {
 static int twl6030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
+	struct twl_pwmled_chip *twl = to_twl(chip);
 	int duty_cycle = (duty_ns * TWL6030_LED_MAX) / period_ns;
 	u8 on_time;
 	int ret;
@@ -202,7 +205,7 @@ static int twl6030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, on_time,
 			       TWL6030_LED_PWM_CTRL1);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -216,7 +219,7 @@ static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(twl->parent, "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -226,7 +229,7 @@ static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -243,7 +246,7 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(twl->parent, "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -253,7 +256,7 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -294,7 +297,7 @@ static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(twl->parent, "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -304,7 +307,7 @@ static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to request PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to request PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -320,7 +323,7 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(twl->parent, "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -330,7 +333,7 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to free PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to free PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -357,6 +360,7 @@ static int twl_pwmled_probe(struct platform_device *pdev)
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	twl = to_twl(chip);
+	twl->parent = &pdev->dev;
 
 	if (twl_class_is_4030())
 		chip->ops = &twl4030_pwmled_ops;
-- 
2.40.1

