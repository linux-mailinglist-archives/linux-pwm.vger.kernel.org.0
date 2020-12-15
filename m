Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B975A2DB5EC
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgLOVac (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 16:30:32 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:54846 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgLOVaE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Dec 2020 16:30:04 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id C8382C727E5;
        Tue, 15 Dec 2020 22:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608067760;
        bh=mD2EIk+dKlXW5XQ3vfEC6pRh0s99jCzK0Z+HEmXXw3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lO6qzAd9AQcL2kfqm4qZkMvwl3J87dUOg96jR2WHC+F21syY+dqMV/uCbeWgVByUS
         MnMeh1EGPm4/LxJqlxfSnmbuJuyjWzT+OFIHhmqYXblcWgZ3WrVNNg+VFfPOORu5IT
         9QsMchEg5YRQg+ncEFpIk/tEfOa2Ec6nmdI9TaG8=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v5 7/7] pwm: pca9685: Restrict period change for prescaler users
Date:   Tue, 15 Dec 2020 22:22:28 +0100
Message-Id: <20201215212228.185517-7-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Previously, the last used PWM channel could change the global prescale
setting, even if other channels were already in use.

Fix it by only allowing the first user of the prescaler to change the
global chip-wide prescale setting. If there is more than one channel in
use, the prescale settings resulting from the chosen periods must match.

PWMs that are disabled or have a duty cycle of 0% or 100% are not
considered to be using the prescaler as they have the full OFF or full
ON bits set. This also applies to channels used as GPIOs.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 51 +++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index ff916980de49..438492d4aed4 100644
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
@@ -80,6 +80,8 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	bool staggered_outputs;
+	struct mutex prescaler_users_lock;
+	DECLARE_BITMAP(prescaler_users, PCA9685_MAXCHAN + 1);
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -92,6 +94,18 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 	return container_of(chip, struct pca9685, chip);
 }
 
+/* This function is supposed to be called with the prescaler_users_lock held */
+static inline bool pca9685_may_change_prescaler(struct pca9685 *pca, int channel)
+{
+	/*
+	 * A PWM channel may only change the prescaler if there are no users of
+	 * the prescaler yet or that same channel is the only one in use.
+	 */
+	return bitmap_empty(pca->prescaler_users, PCA9685_MAXCHAN + 1) ||
+		(bitmap_weight(pca->prescaler_users, PCA9685_MAXCHAN + 1) == 1 &&
+		 test_bit(channel, pca->prescaler_users));
+}
+
 static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
 {
 	unsigned int on, off;
@@ -337,16 +351,25 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
 	duty = DIV_ROUND_CLOSEST_ULL(duty, state->period);
 
+	mutex_lock(&pca->prescaler_users_lock);
+
 	if (!state->enabled || duty < 1) {
 		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
-		return 0;
+		goto prescaler_unused;
 	} else if (duty == PCA9685_COUNTER_RANGE) {
 		pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
-		return 0;
+		goto prescaler_unused;
 	}
 
 	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
+		if (!pca9685_may_change_prescaler(pca, pwm->hwpwm)) {
+			mutex_unlock(&pca->prescaler_users_lock);
+			dev_err(chip->dev,
+				"prescaler not set: already in use with different setting!\n");
+			return -EBUSY;
+		}
+
 		/*
 		 * Putting the chip briefly into SLEEP mode
 		 * at this point won't interfere with the
@@ -364,6 +387,14 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
+
+	set_bit(pwm->hwpwm, pca->prescaler_users);
+	mutex_unlock(&pca->prescaler_users_lock);
+	return 0;
+
+prescaler_unused:
+	clear_bit(pwm->hwpwm, pca->prescaler_users);
+	mutex_unlock(&pca->prescaler_users_lock);
 	return 0;
 }
 
@@ -422,7 +453,11 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
+	mutex_lock(&pca->prescaler_users_lock);
+	clear_bit(pwm->hwpwm, pca->prescaler_users);
 	pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+	mutex_unlock(&pca->prescaler_users_lock);
+
 	pm_runtime_put(chip->dev);
 	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
@@ -463,6 +498,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, pca);
 
+	mutex_init(&pca->prescaler_users_lock);
+
 	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
 
 	if (device_property_read_bool(&client->dev, "invert"))
-- 
2.29.2

