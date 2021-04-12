Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A235C79D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbhDLNaD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 09:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbhDLN34 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 09:29:56 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ADCC061574;
        Mon, 12 Apr 2021 06:29:37 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 99182C725D3;
        Mon, 12 Apr 2021 15:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618234175;
        bh=KyPRSPFejQcjD78lvjGuMZggsZivK22Hi191tT9EGMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0pilKT75Myxh9U1NxZpfc9Tak3IFKkESRVn2PAn3F9WvbsjyTZkX1fhy/dQhdrEX
         06ZaI/7zXjCZyUt1L99NBDDlR01RHlHvgMIq079u3boyJcCCGXHJNYGftQyG681SCD
         b2VmOG0X3cqd/c6NnOH4Re4QG8bOJUx7v9kGf3OI=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v8 8/8] pwm: pca9685: Add error messages for failed regmap calls
Date:   Mon, 12 Apr 2021 15:27:45 +0200
Message-Id: <20210412132745.76609-8-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
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
Changes since v7:
- Use %pe instead of %d for error codes (Suggested by Uwe)

drivers/pwm/pwm-pca9685.c | 83 ++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 4583edd5e477..b0b321203947 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -107,6 +107,30 @@ static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
 	return test_bit(channel, pca->pwms_enabled);
 }
 
+static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsigned int *val)
+{
+	struct device *dev = pca->chip.dev;
+	int err;
+
+	err = regmap_read(pca->regmap, reg, val);
+	if (err != 0)
+		dev_err(dev, "regmap_read of register 0x%x failed: %pe\n", reg, ERR_PTR(err));
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
+		dev_err(dev, "regmap_write to register 0x%x failed: %pe\n", reg, ERR_PTR(err));
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
 
@@ -141,11 +165,11 @@ static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int
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
@@ -158,26 +182,26 @@ static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
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
 	if (!pwm->args.usage_power)
 		return off;
 
 	/* Read ON register to calculate duty cycle of staggered output */
 	val = 0;
-	regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
+	pca9685_read_reg(pca, LED_N_ON_L(channel), &val);
 	on = ((on & 0xf) << 8) | (val & 0xff);
 	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
 }
@@ -320,8 +344,15 @@ static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 
 static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 {
-	regmap_update_bits(pca->regmap, PCA9685_MODE1,
-			   MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
+	struct device *dev = pca->chip.dev;
+	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
+				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
+	if (err != 0) {
+		dev_err(dev, "regmap_update_bits of register 0x%x failed: %pe\n",
+			PCA9685_MODE1, ERR_PTR(err));
+		return;
+	}
+
 	if (!enable) {
 		/* Wait 500us for the oscillator to be back up */
 		udelay(500);
@@ -350,7 +381,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
+	pca9685_read_reg(pca, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
 		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
 			dev_err(chip->dev,
@@ -368,7 +399,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pca9685_set_sleep_mode(pca, true);
 
 		/* Change the chip-wide output frequency */
-		regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
+		pca9685_write_reg(pca, PCA9685_PRESCALE, prescale);
 
 		/* Wake the chip up */
 		pca9685_set_sleep_mode(pca, false);
@@ -407,7 +438,7 @@ static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int val = 0;
 
 	/* Calculate (chip-wide) period from prescale value */
-	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
+	pca9685_read_reg(pca, PCA9685_PRESCALE, &val);
 	/*
 	 * PCA9685_OSC_CLOCK_MHZ is 25, i.e. an integer divider of 1000.
 	 * The following calculation is therefore only a multiplication
@@ -504,7 +535,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	mutex_init(&pca->lock);
 
-	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
+	ret = pca9685_read_reg(pca, PCA9685_MODE2, &reg);
+	if (ret != 0)
+		return ret;
 
 	if (device_property_read_bool(&client->dev, "invert"))
 		reg |= MODE2_INVRT;
@@ -516,18 +549,20 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	else
 		reg |= MODE2_OUTDRV;
 
-	regmap_write(pca->regmap, PCA9685_MODE2, reg);
+	ret = pca9685_write_reg(pca, PCA9685_MODE2, reg);
+	if (ret != 0)
+		return ret;
 
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

