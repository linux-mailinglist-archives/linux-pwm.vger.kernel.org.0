Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587B334D0B9
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhC2M7e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhC2M7W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 08:59:22 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5051EC061574;
        Mon, 29 Mar 2021 05:59:22 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id E409EC72850;
        Mon, 29 Mar 2021 14:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617022761;
        bh=a+6Tf/7N+yofFcME49R1IaiFgFnKW1GEScpwMJvXS8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ir84w4dHK/48fWdFRJ1XTui0M82tdGnt0xt6FwWI8lKy8/FvyCNCl0VaT11JxoveE
         Fz8FcJfF9IuHyx02zOYqQURWfMmzGsDPMEh4xqKOKldb13kA2iYQaMfe6BMLKzCytE
         jijCR2Fq/SDslKwxELoWJl2Ur8qzM0ttbbu/pEEI=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v6 6/7] pwm: pca9685: Restrict period change for prescaler users
Date:   Mon, 29 Mar 2021 14:57:06 +0200
Message-Id: <20210329125707.182732-6-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Previously, the last used PWM channel could change the global prescale
setting, even if other channels are already in use.

Fix it by only allowing the first user of the prescaler to change the
global chip-wide prescale setting. If there is more than one channel in
use, the prescale settings resulting from the chosen periods must match.

PWMs that are disabled or have a duty cycle of 0% or 100% are not
considered to be using the prescaler as they have the full OFF or full
ON bits set. This also applies to channels used as GPIOs.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
Changes since v5:
- Reused the existing lock
- Improved readability of can_change function
- Moved locking out of apply function
- Improved error messages

drivers/pwm/pwm-pca9685.c | 63 ++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index a61eafdd2335..418d3c5b2fa2 100644
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
+ * that uses the prescaler is allowed to change the prescale register.
+ * PWM channels requested afterwards must use a period that results in the same
+ * prescale setting as the one set by the first requested channel, unless they
+ * use duty cycles of 0% or 100% (prescaler not used for full OFF/ON).
  */
 
 #define PCA9685_MODE1		0x00
@@ -79,8 +79,9 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	bool staggered_outputs;
-#if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
+	DECLARE_BITMAP(prescaler_users, PCA9685_MAXCHAN + 1);
+#if IS_ENABLED(CONFIG_GPIOLIB)
 	struct gpio_chip gpio;
 	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
 #endif
@@ -91,6 +92,22 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 	return container_of(chip, struct pca9685, chip);
 }
 
+/* This function is supposed to be called with the lock mutex held */
+static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
+{
+	/* Prescaler not in use: Change allowed */
+	if (bitmap_empty(pca->prescaler_users, PCA9685_MAXCHAN + 1))
+		return true;
+	/* More than one PWM using the prescaler: Change not allowed */
+	if (bitmap_weight(pca->prescaler_users, PCA9685_MAXCHAN + 1) > 1)
+		return false;
+	/*
+	 * Only one PWM using the prescaler: Change allowed if the PWM about to
+	 * be changed is the one using the prescaler
+	 */
+	return test_bit(channel, pca->prescaler_users);
+}
+
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
 {
@@ -263,8 +280,6 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 {
 	struct device *dev = pca->chip.dev;
 
-	mutex_init(&pca->lock);
-
 	pca->gpio.label = dev_name(dev);
 	pca->gpio.parent = dev;
 	pca->gpio.request = pca9685_pwm_gpio_request;
@@ -308,8 +323,8 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 	}
 }
 
-static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			     const struct pwm_state *state)
+static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty, prescale;
@@ -330,14 +345,22 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!state->enabled || duty < 1) {
 		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+		clear_bit(pwm->hwpwm, pca->prescaler_users);
 		return 0;
 	} else if (duty == PCA9685_COUNTER_RANGE) {
 		pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
+		clear_bit(pwm->hwpwm, pca->prescaler_users);
 		return 0;
 	}
 
 	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
+		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
+			dev_err(chip->dev,
+				"pwm not changed: prescaler in use with different setting!\n");
+			return -EBUSY;
+		}
+
 		/*
 		 * Putting the chip briefly into SLEEP mode
 		 * at this point won't interfere with the
@@ -355,9 +378,23 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
+	set_bit(pwm->hwpwm, pca->prescaler_users);
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
+	mutex_unlock(&pca->lock);
+
+	return ret;
+}
+
 static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				  struct pwm_state *state)
 {
@@ -413,7 +450,11 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
+	mutex_lock(&pca->lock);
+	clear_bit(pwm->hwpwm, pca->prescaler_users);
 	pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+	mutex_unlock(&pca->lock);
+
 	pm_runtime_put(chip->dev);
 	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
@@ -454,6 +495,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, pca);
 
+	mutex_init(&pca->lock);
+
 	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
 
 	if (device_property_read_bool(&client->dev, "invert"))
-- 
2.31.1

