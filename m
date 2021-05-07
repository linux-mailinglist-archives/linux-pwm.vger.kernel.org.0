Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B33D376606
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhEGNU0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbhEGNUV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 May 2021 09:20:21 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C8FC061763;
        Fri,  7 May 2021 06:19:21 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id F2C7FC7C83F;
        Fri,  7 May 2021 15:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1620393559;
        bh=Mz1kswUI7YR9M9Gllqdljly4PtXQ/lQyl+G7Z4/fcJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTpSgl1ESnNaJw/w1V4nJbHcDkjO/K95l42z77SD4F6Ncyu0NTYg7rnKbyvZmAXKM
         n70SDPVqGPT6oa/jI4LKYqO/lVG1S9ezeK9nxVENtpa4LqXecw633RdP/5kGV7v6bx
         rKDvHcLHtp5yvM1f8mGvSpE5lM92WY5DuYuIuzSM=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 3/4] pwm: pca9685: Restrict period change for enabled PWMs
Date:   Fri,  7 May 2021 15:18:44 +0200
Message-Id: <20210507131845.37605-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Previously, the last used PWM channel could change the global prescale
setting, even if other channels are already in use.

Fix it by only allowing the first enabled PWM to change the global
chip-wide prescale setting. If there is more than one channel in use,
the prescale settings resulting from the chosen periods must match.

GPIOs do not count as enabled PWMs as they are not using the prescaler
and can't change it.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 74 +++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 20dd579297e6..f70162114197 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -23,11 +23,11 @@
 #include <linux/bitmap.h>
 
 /*
- * Because the PCA9685 has only one prescaler per chip, changing the period of
- * one channel affects the period of all 16 PWM outputs!
- * However, the ratio between each configured duty cycle and the chip-wide
- * period remains constant, because the OFF time is set in proportion to the
- * counter range.
+ * Because the PCA9685 has only one prescaler per chip, only the first channel
+ * that is enabled is allowed to change the prescale register.
+ * PWM channels requested afterwards must use a period that results in the same
+ * prescale setting as the one set by the first requested channel.
+ * GPIOs do not count as enabled PWMs as they are not using the prescaler.
  */
 
 #define PCA9685_MODE1		0x00
@@ -78,8 +78,9 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
-#if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
+	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
+#if IS_ENABLED(CONFIG_GPIOLIB)
 	struct gpio_chip gpio;
 	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
 #endif
@@ -90,6 +91,22 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 	return container_of(chip, struct pca9685, chip);
 }
 
+/* This function is supposed to be called with the lock mutex held */
+static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
+{
+	/* No PWM enabled: Change allowed */
+	if (bitmap_empty(pca->pwms_enabled, PCA9685_MAXCHAN + 1))
+		return true;
+	/* More than one PWM enabled: Change not allowed */
+	if (bitmap_weight(pca->pwms_enabled, PCA9685_MAXCHAN + 1) > 1)
+		return false;
+	/*
+	 * Only one PWM enabled: Change allowed if the PWM about to
+	 * be changed is the one that is already enabled
+	 */
+	return test_bit(channel, pca->pwms_enabled);
+}
+
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
 {
@@ -269,8 +286,6 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 {
 	struct device *dev = pca->chip.dev;
 
-	mutex_init(&pca->lock);
-
 	pca->gpio.label = dev_name(dev);
 	pca->gpio.parent = dev;
 	pca->gpio.request = pca9685_pwm_gpio_request;
@@ -314,8 +329,8 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 	}
 }
 
-static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			     const struct pwm_state *state)
+static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty, prescale;
@@ -338,6 +353,12 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
+		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
+			dev_err(chip->dev,
+				"pwm not changed: periods of enabled pwms must match!\n");
+			return -EBUSY;
+		}
+
 		/*
 		 * Putting the chip briefly into SLEEP mode
 		 * at this point won't interfere with the
@@ -360,6 +381,25 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct pca9685 *pca = to_pca(chip);
+	int ret;
+
+	mutex_lock(&pca->lock);
+	ret = __pca9685_pwm_apply(chip, pwm, state);
+	if (ret == 0) {
+		if (state->enabled)
+			set_bit(pwm->hwpwm, pca->pwms_enabled);
+		else
+			clear_bit(pwm->hwpwm, pca->pwms_enabled);
+	}
+	mutex_unlock(&pca->lock);
+
+	return ret;
+}
+
 static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				  struct pwm_state *state)
 {
@@ -401,6 +441,14 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	if (pca9685_pwm_test_and_set_inuse(pca, pwm->hwpwm))
 		return -EBUSY;
+
+	if (pwm->hwpwm < PCA9685_MAXCHAN) {
+		/* PWMs - except the "all LEDs" channel - default to enabled */
+		mutex_lock(&pca->lock);
+		set_bit(pwm->hwpwm, pca->pwms_enabled);
+		mutex_unlock(&pca->lock);
+	}
+
 	pm_runtime_get_sync(chip->dev);
 
 	return 0;
@@ -410,7 +458,11 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
+	mutex_lock(&pca->lock);
 	pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+	clear_bit(pwm->hwpwm, pca->pwms_enabled);
+	mutex_unlock(&pca->lock);
+
 	pm_runtime_put(chip->dev);
 	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
@@ -451,6 +503,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, pca);
 
+	mutex_init(&pca->lock);
+
 	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
 
 	if (device_property_read_bool(&client->dev, "invert"))
-- 
2.31.1

