Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6916D360916
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhDOMQA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 08:16:00 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:34792 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232836AbhDOMP7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 15 Apr 2021 08:15:59 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 3350AC725D8;
        Thu, 15 Apr 2021 14:15:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618488934;
        bh=e7T/pjKrbxXXjLeiOJ7w1qh/Bu1UNFSyypxVNrneVpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7gfngpQX5U4YbuX1gqZSXTum//xjmB6wQuP5s1Kz0MutmSXLebxtiVvIgBC6r3h3
         TqBmAmI5dLO+q70tDJOKQ3rFxmSdXITYtVAvjcPYd+2gLdBkGlqXXPLGsrtknbfgKJ
         +C0eQNDshs9kJJinB5TB28VLymVKP7wONc626kf4=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v9 6/8] pwm: pca9685: Support new PWM_USAGE_POWER flag
Date:   Thu, 15 Apr 2021 14:14:53 +0200
Message-Id: <20210415121455.39536-6-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If PWM_USAGE_POWER is set on a PWM, the pca9685 driver will phase shift
the individual channels relative to their channel number. This improves
EMI because the enabled channels no longer turn on at the same time,
while still maintaining the configured duty cycle / power output.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
Changes since v8:
- Improved readability of failed regmap_read
- Rebased

 drivers/pwm/pwm-pca9685.c | 65 ++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 1b013d03f5d8..315a75db254d 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -93,48 +93,78 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
 {
+	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	unsigned int on, off;
+
 	if (duty == 0) {
 		/* Set the full OFF bit, which has the highest precedence */
 		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
+		return;
 	} else if (duty >= PCA9685_COUNTER_RANGE) {
 		/* Set the full ON bit and clear the full OFF bit */
 		regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
 		regmap_write(pca->regmap, REG_OFF_H(channel), 0);
-	} else {
-		/* Set OFF time (clears the full OFF bit) */
-		regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
-		regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
-		/* Clear the full ON bit */
-		regmap_write(pca->regmap, REG_ON_H(channel), 0);
+		return;
 	}
+
+
+	if (pwm->args.usage_power && channel < PCA9685_MAXCHAN) {
+		/*
+		 * If PWM_USAGE_POWER is set on a PWM, the pca9685
+		 * driver will phase shift the individual channels
+		 * relative to their channel number.
+		 * This improves EMI because the enabled channels no
+		 * longer turn on at the same time, while still
+		 * maintaining the configured duty cycle / power output.
+		 */
+		on = channel * PCA9685_COUNTER_RANGE / PCA9685_MAXCHAN;
+	} else
+		on = 0;
+
+	off = (on + duty) % PCA9685_COUNTER_RANGE;
+
+	/* Set ON time (clears full ON bit) */
+	regmap_write(pca->regmap, REG_ON_L(channel), on & 0xff);
+	regmap_write(pca->regmap, REG_ON_H(channel), (on >> 8) & 0xf);
+	/* Set OFF time (clears full OFF bit) */
+	regmap_write(pca->regmap, REG_OFF_L(channel), off & 0xff);
+	regmap_write(pca->regmap, REG_OFF_H(channel), (off >> 8) & 0xf);
 }
 
 static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
 {
-	unsigned int off_h = 0, val = 0;
+	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	unsigned int off = 0, on = 0, val = 0;
 
 	if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
 		/* HW does not support reading state of "all LEDs" channel */
 		return 0;
 	}
 
-	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
-	if (off_h & LED_FULL) {
+	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off);
+	if (off & LED_FULL) {
 		/* Full OFF bit is set */
 		return 0;
 	}
 
-	regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
-	if (val & LED_FULL) {
+	regmap_read(pca->regmap, LED_N_ON_H(channel), &on);
+	if (on & LED_FULL) {
 		/* Full ON bit is set */
 		return PCA9685_COUNTER_RANGE;
 	}
 
-	if (regmap_read(pca->regmap, LED_N_OFF_L(channel), &val)) {
-		/* Reset val to 0 in case reading LED_N_OFF_L failed */
+	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
+	off = ((off & 0xf) << 8) | (val & 0xff);
+	if (!pwm->args.usage_power)
+		return off;
+
+	/* Read ON register to calculate duty cycle of staggered output */
+	if (regmap_read(pca->regmap, LED_N_ON_L(channel), &val)) {
+		/* Reset val to 0 in case reading LED_N_ON_L failed */
 		val = 0;
 	}
-	return ((off_h & 0xf) << 8) | (val & 0xff);
+	on = ((on & 0xf) << 8) | (val & 0xff);
+	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
 }
 
 #if IS_ENABLED(CONFIG_GPIOLIB)
@@ -441,9 +471,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
 	regmap_write(pca->regmap, PCA9685_MODE1, reg);
 
-	/* Reset OFF registers to POR default */
+	/* Reset OFF/ON registers to POR default */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, LED_FULL);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
@@ -452,6 +484,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	pca->chip.dev = &client->dev;
 	pca->chip.base = -1;
 
+	pca->chip.of_xlate = of_pwm_xlate_with_flags;
+	pca->chip.of_pwm_n_cells = 3;
+
 	ret = pwmchip_add(&pca->chip);
 	if (ret < 0)
 		return ret;
-- 
2.31.1

