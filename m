Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC04774AEC
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjHHUic (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjHHUiV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:38:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F08D8C9B
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-0007Gd-9V; Tue, 08 Aug 2023 19:19:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00225o-FA; Tue, 08 Aug 2023 19:19:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00BTCf-Oh; Tue, 08 Aug 2023 19:19:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 040/101] pwm: pca9685: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:30 +0200
Message-Id: <20230808171931.944154-41-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4809; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9IPPl/UPVm6cDkGs9iB9l8Pa37DgWc+ioCOKBv4jpaM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njdCKbQz7FkOqLlZFf27rPqDrr71Ma0oIcbG 92r+n4T/CmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ43QAKCRCPgPtYfRL+ Ts0fB/wJ+Iw+IqCtdd+Ln/7kJCCqTCLuNzvglR7vAJLTR/oJKXFFh0hFm7BaJ6mW1qoC9k9tuCq zJmdDmpknF3+44eSFLsnfh1ZueT6kAr8HF8UZK4NE2IE1ke2DDKajQpR5tqfZB4EVTIHPcDbLUA U1EFBKzKiygdjwwMfN6bL+1kVyYjpMNvVnyqowBFOKkyJ8GOQ7e2jwAVvjNdJme6tOC1ZL3jBDY qq/KTQOD1JB0+LTgon2tJpuINqvDUVBaypVdk7XZtTqyedjvpV+aDcK47TSyeNSN9hX+eEQj6EQ nY+JiUxSdQtxJbXcJhQjfNdZUp+n36TSeAJjMUz0dXRi15kt
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

This prepares the pwm-pca9685 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 9d4e7915c1e9..0d32b4bb51d8 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -76,7 +76,7 @@
 #define REG_OFF_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))
 
 struct pca9685 {
-	struct pwm_chip chip;
+	struct pwm_chip *chip;
 	struct regmap *regmap;
 	struct mutex lock;
 	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
@@ -88,7 +88,7 @@ struct pca9685 {
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pca9685, chip);
+	return pwmchip_priv(chip);
 }
 
 /* This function is supposed to be called with the lock mutex held */
@@ -120,7 +120,7 @@ static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsigned int
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
 {
-	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	struct pwm_device *pwm = &pca->chip->pwms[channel];
 	unsigned int on, off;
 
 	if (duty == 0) {
@@ -159,7 +159,7 @@ static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int
 
 static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
 {
-	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	struct pwm_device *pwm = &pca->chip->pwms[channel];
 	unsigned int off = 0, on = 0, val = 0;
 
 	if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
@@ -237,7 +237,7 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 
 	if (pca9685_pwm_test_and_set_inuse(pca, offset))
 		return -EBUSY;
-	pm_runtime_get_sync(pca->chip.dev);
+	pm_runtime_get_sync(pca->chip->dev);
 	return 0;
 }
 
@@ -261,7 +261,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 	struct pca9685 *pca = gpiochip_get_data(gpio);
 
 	pca9685_pwm_set_duty(pca, offset, 0);
-	pm_runtime_put(pca->chip.dev);
+	pm_runtime_put(pca->chip->dev);
 	pca9685_pwm_clear_inuse(pca, offset);
 }
 
@@ -294,7 +294,7 @@ static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
  */
 static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 {
-	struct device *dev = pca->chip.dev;
+	struct device *dev = pca->chip->dev;
 
 	pca->gpio.label = dev_name(dev);
 	pca->gpio.parent = dev;
@@ -331,7 +331,7 @@ static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 
 static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 {
-	struct device *dev = pca->chip.dev;
+	struct device *dev = pca->chip->dev;
 	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
 				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
 	if (err) {
@@ -497,13 +497,17 @@ static const struct regmap_config pca9685_regmap_i2c_config = {
 
 static int pca9685_pwm_probe(struct i2c_client *client)
 {
+	struct pwm_chip *chip;
 	struct pca9685 *pca;
 	unsigned int reg;
 	int ret;
 
-	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
-	if (!pca)
-		return -ENOMEM;
+	/* Add an extra channel for ALL_LED */
+	chip = devm_pwmchip_alloc(&client->dev, PCA9685_MAXCHAN + 1, sizeof(*pca));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pca = to_pca(chip);
+	pca->chip = chip;
 
 	pca->regmap = devm_regmap_init_i2c(client, &pca9685_regmap_i2c_config);
 	if (IS_ERR(pca->regmap)) {
@@ -546,19 +550,15 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_L, 0);
 	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, LED_FULL);
 
-	pca->chip.ops = &pca9685_pwm_ops;
-	/* Add an extra channel for ALL_LED */
-	pca->chip.npwm = PCA9685_MAXCHAN + 1;
+	chip->ops = &pca9685_pwm_ops;
 
-	pca->chip.dev = &client->dev;
-
-	ret = pwmchip_add(&pca->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return ret;
 
 	ret = pca9685_pwm_gpio_probe(pca);
 	if (ret < 0) {
-		pwmchip_remove(&pca->chip);
+		pwmchip_remove(chip);
 		return ret;
 	}
 
@@ -583,7 +583,7 @@ static void pca9685_pwm_remove(struct i2c_client *client)
 {
 	struct pca9685 *pca = i2c_get_clientdata(client);
 
-	pwmchip_remove(&pca->chip);
+	pwmchip_remove(pca->chip);
 
 	if (!pm_runtime_enabled(&client->dev)) {
 		/* Put chip in sleep state if runtime PM is disabled */
-- 
2.40.1

