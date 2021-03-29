Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27334D0BF
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhC2NAG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 09:00:06 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:55454 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhC2M7j (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Mar 2021 08:59:39 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 90DC6C72850;
        Mon, 29 Mar 2021 14:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617022777;
        bh=x7/rmoN1rvbHplc619xYQLnqT9dor1RAV1sG80FysJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eb+HLKCqyrNMQl6zbyaCqWZgzGogUDQwHLBKrfqEYSR6cmLkFQAVKMhrCA0xsJJr2
         qcYD6rKE7Ub081N8GVzZpXUEjRg+QQVndziUA/NjWp+5fQE1VZUYpbsxwIMBNJ2MC8
         knGmqUnpKFvn4fyFgjLVuLfTnQ0flXcoIpLGFSao=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v6 7/7] pwm: pca9685: Add error messages for failed regmap calls
Date:   Mon, 29 Mar 2021 14:57:07 +0200
Message-Id: <20210329125707.182732-7-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Regmap operations can fail if the underlying subsystem is not working
properly (e.g. hogged I2C bus, etc.)
As this is useful information for the user, print an error message if it
happens.
Let probe fail if the first regmap_read or the first regmap_write fails.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 83 ++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 418d3c5b2fa2..065141b87fc3 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -108,6 +108,30 @@ static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
 	return test_bit(channel, pca->prescaler_users);
 }
 
+static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsigned int *val)
+{
+	struct device *dev = pca->chip.dev;
+	int err;
+
+	err = regmap_read(pca->regmap, reg, val);
+	if (err != 0)
+		dev_err(dev, "regmap_read of register 0x%x failed: %d\n", reg, err);
+
+	return err;
+}
+
+static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsigned int val)
+{
+	struct device *dev = pca->chip.dev;
+	int err;
+
+	err = regmap_write(pca->regmap, reg, val);
+	if (err != 0)
+		dev_err(dev, "regmap_write to register 0x%x failed: %d\n", reg, err);
+
+	return err;
+}
+
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
 {
@@ -115,12 +139,12 @@ static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int
 
 	if (duty == 0) {
 		/* Set the full OFF bit, which has the highest precedence */
-		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
+		pca9685_write_reg(pca, REG_OFF_H(channel), LED_FULL);
 		return;
 	} else if (duty >= PCA9685_COUNTER_RANGE) {
 		/* Set the full ON bit and clear the full OFF bit */
-		regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
-		regmap_write(pca->regmap, REG_OFF_H(channel), 0);
+		pca9685_write_reg(pca, REG_ON_H(channel), LED_FULL);
+		pca9685_write_reg(pca, REG_OFF_H(channel), 0);
 		return;
 	}
 
@@ -137,11 +161,11 @@ static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int
 	off = (on + duty) % PCA9685_COUNTER_RANGE;
 
 	/* Set ON time (clears full ON bit) */
-	regmap_write(pca->regmap, REG_ON_L(channel), on & 0xff);
-	regmap_write(pca->regmap, REG_ON_H(channel), (on >> 8) & 0xf);
+	pca9685_write_reg(pca, REG_ON_L(channel), on & 0xff);
+	pca9685_write_reg(pca, REG_ON_H(channel), (on >> 8) & 0xf);
 	/* Set OFF time (clears full OFF bit) */
-	regmap_write(pca->regmap, REG_OFF_L(channel), off & 0xff);
-	regmap_write(pca->regmap, REG_OFF_H(channel), (off >> 8) & 0xf);
+	pca9685_write_reg(pca, REG_OFF_L(channel), off & 0xff);
+	pca9685_write_reg(pca, REG_OFF_H(channel), (off >> 8) & 0xf);
 }
 
 static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
@@ -153,26 +177,26 @@ static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
 		return 0;
 	}
 
-	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off);
+	pca9685_read_reg(pca, LED_N_OFF_H(channel), &off);
 	if (off & LED_FULL) {
 		/* Full OFF bit is set */
 		return 0;
 	}
 
-	regmap_read(pca->regmap, LED_N_ON_H(channel), &on);
+	pca9685_read_reg(pca, LED_N_ON_H(channel), &on);
 	if (on & LED_FULL) {
 		/* Full ON bit is set */
 		return PCA9685_COUNTER_RANGE;
 	}
 
-	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
+	pca9685_read_reg(pca, LED_N_OFF_L(channel), &val);
 	off = ((off & 0xf) << 8) | (val & 0xff);
 	if (!pca->staggered_outputs)
 		return off;
 
 	/* Read ON register to calculate duty cycle of staggered output */
 	val = 0;
-	regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
+	pca9685_read_reg(pca, LED_N_ON_L(channel), &val);
 	on = ((on & 0xf) << 8) | (val & 0xff);
 	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
 }
@@ -315,8 +339,15 @@ static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 
 static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 {
-	regmap_update_bits(pca->regmap, PCA9685_MODE1,
-			   MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
+	struct device *dev = pca->chip.dev;
+	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
+				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
+	if (err != 0) {
+		dev_err(dev, "regmap_update_bits of register 0x%x failed: %d\n",
+			PCA9685_MODE1, err);
+		return;
+	}
+
 	if (!enable) {
 		/* Wait 500us for the oscillator to be back up */
 		udelay(500);
@@ -353,7 +384,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
+	pca9685_read_reg(pca, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
 		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
 			dev_err(chip->dev,
@@ -371,7 +402,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pca9685_set_sleep_mode(pca, true);
 
 		/* Change the chip-wide output frequency */
-		regmap_write(pca->regmap, PCA9685_PRESCALE, (int)prescale);
+		pca9685_write_reg(pca, PCA9685_PRESCALE, (int)prescale);
 
 		/* Wake the chip up */
 		pca9685_set_sleep_mode(pca, false);
@@ -403,7 +434,7 @@ static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int val = 0;
 
 	/* Calculate (chip-wide) period from prescale value */
-	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
+	pca9685_read_reg(pca, PCA9685_PRESCALE, &val);
 	state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
 			(val + 1);
 
@@ -497,7 +528,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	mutex_init(&pca->lock);
 
-	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
+	ret = pca9685_read_reg(pca, PCA9685_MODE2, &reg);
+	if (ret != 0)
+		return ret;
 
 	if (device_property_read_bool(&client->dev, "invert"))
 		reg |= MODE2_INVRT;
@@ -509,21 +542,23 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	else
 		reg |= MODE2_OUTDRV;
 
-	regmap_write(pca->regmap, PCA9685_MODE2, reg);
+	ret = pca9685_write_reg(pca, PCA9685_MODE2, reg);
+	if (ret != 0)
+		return ret;
 
 	pca->staggered_outputs = device_property_read_bool(
 		&client->dev, "nxp,staggered-outputs");
 
 	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
-	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
+	pca9685_read_reg(pca, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
-	regmap_write(pca->regmap, PCA9685_MODE1, reg);
+	pca9685_write_reg(pca, PCA9685_MODE1, reg);
 
 	/* Reset OFF/ON registers to POR default */
-	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, LED_FULL);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
+	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_L, LED_FULL);
+	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_H, LED_FULL);
+	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_L, 0);
+	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, 0);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
-- 
2.31.1

