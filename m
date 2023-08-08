Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643677440E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjHHSOw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjHHSOY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA975873
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0007fa-7T; Tue, 08 Aug 2023 19:20:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00229c-FL; Tue, 08 Aug 2023 19:20:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-00BTFd-Bl; Tue, 08 Aug 2023 19:19:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 085/101] pwm: pca9685: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:15 +0200
Message-Id: <20230808171931.944154-86-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HU+trDG+jcJFGtg+ztofnP0VA2/diT4r0UDOhHVdka8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkQNz+wCphzV3FjIIClEchwDWNd36tpEsjlK smHOUR0lHSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5EAAKCRCPgPtYfRL+ TuM7CACN9Y0pGLJUb/jCyOzTsVYQgdwEjzwB8yRdPZAOEU4nhAWzBh1nZcsBPOC4KZ6WJPKWhal uLlDdknaRVuGd5gCX3kcjNcMkBGjD83/LDJqSSRVMc3XIjIEdqcgebMaptDj4DsFvXSDLqQrE+z gUjhEqkdJkkdkrZXT8+Z2+nslk6zsS1kASncwYHezRvoTLwrc0xs2jHaHr4tboYUGdrae2dAE4h f5yii91QLSICiVX1r/F9EMfLf2RnMIwEciGtXV9T7Xt1A9ibuvznNRH8qGfe1L4uzaKquPd8/I6 4TCz02/60dLZBVy/ay+i0wbEPrpIT3wFRiKBYGxr/D2bbmbl
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
 drivers/pwm/pwm-pca9685.c | 14 ++++++++------
 include/linux/pwm.h       |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 0d32b4bb51d8..679adf48cb4d 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -76,6 +76,7 @@
 #define REG_OFF_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))
 
 struct pca9685 {
+	struct device *parent;
 	struct pwm_chip *chip;
 	struct regmap *regmap;
 	struct mutex lock;
@@ -237,7 +238,7 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 
 	if (pca9685_pwm_test_and_set_inuse(pca, offset))
 		return -EBUSY;
-	pm_runtime_get_sync(pca->chip->dev);
+	pm_runtime_get_sync(pca->parent);
 	return 0;
 }
 
@@ -261,7 +262,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 	struct pca9685 *pca = gpiochip_get_data(gpio);
 
 	pca9685_pwm_set_duty(pca, offset, 0);
-	pm_runtime_put(pca->chip->dev);
+	pm_runtime_put(pca->parent);
 	pca9685_pwm_clear_inuse(pca, offset);
 }
 
@@ -294,7 +295,7 @@ static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
  */
 static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 {
-	struct device *dev = pca->chip->dev;
+	struct device *dev = pca->parent;
 
 	pca->gpio.label = dev_name(dev);
 	pca->gpio.parent = dev;
@@ -331,7 +332,7 @@ static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 
 static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 {
-	struct device *dev = pca->chip->dev;
+	struct device *dev = pca->parent;
 	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
 				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
 	if (err) {
@@ -463,7 +464,7 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		mutex_unlock(&pca->lock);
 	}
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pca->parent);
 
 	return 0;
 }
@@ -477,7 +478,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clear_bit(pwm->hwpwm, pca->pwms_enabled);
 	mutex_unlock(&pca->lock);
 
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pca->parent);
 	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
 
@@ -508,6 +509,7 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 		return PTR_ERR(chip);
 	pca = to_pca(chip);
 	pca->chip = chip;
+	pca->parent = &client->dev;
 
 	pca->regmap = devm_regmap_init_i2c(client, &pca9685_regmap_i2c_config);
 	if (IS_ERR(pca->regmap)) {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 74f095afffa4..fbcba204de44 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -290,7 +290,7 @@ struct pwm_ops {
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
-	struct device dev;
+	struct device *dev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	int id;
-- 
2.40.1

