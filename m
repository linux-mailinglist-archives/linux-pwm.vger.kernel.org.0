Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8798376604
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhEGNUR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 09:20:17 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:37516 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhEGNUR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 7 May 2021 09:20:17 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 370ECC5574D;
        Fri,  7 May 2021 15:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1620393556;
        bh=dIc+rdMHJw6NaQNk32/6rv1S08CEUMejD+3jh7ujaxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XaaNKUClGtHUs5ghFcqIGD9h3Zdfj18YVDRw83O7Fi1nn9cI4rvJoRrV/NEuJWDms
         Zfmh+JvwZYpwKQ9GBbSrE0YZFtf6X1eSvh7pKwqO1WpA6PcOkyjRLg8MJ9I2dqGx/r
         ivKg3HjeJz/XIrc8cYerQInFZ3SEXTZ4I4bcBvfA=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 2/4] pwm: pca9685: Support new usage_power setting in PWM state
Date:   Fri,  7 May 2021 15:18:43 +0200
Message-Id: <20210507131845.37605-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If usage_power is set, the pca9685 driver will phase shift the
individual channels relative to their channel number. This improves EMI
because the enabled channels no longer turn on at the same time, while
still maintaining the configured duty cycle / power output.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 61 +++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 7c9f174de64e..20dd579297e6 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -93,48 +93,77 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
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
+	if (pwm->state.usage_power && channel < PCA9685_MAXCHAN) {
+		/*
+		 * If usage_power is set, the pca9685 driver will phase shift
+		 * the individual channels relative to their channel number.
+		 * This improves EMI because the enabled channels no longer
+		 * turn on at the same time, while still maintaining the
+		 * configured duty cycle / power output.
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
+	if (!pwm->state.usage_power)
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
@@ -441,9 +470,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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
-- 
2.31.1

