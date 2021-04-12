Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82D135C798
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbhDLN3w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbhDLN3p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 09:29:45 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B9DC061574;
        Mon, 12 Apr 2021 06:29:26 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 07E4DC725CF;
        Mon, 12 Apr 2021 15:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618234165;
        bh=GlaCGh4zwBDc8RGpNt6TXQ3TkAIL1O1C1FtzLl1o8Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOmIuWZ/OhMdvk35ijC8x0jefaYdY7AwkK5sGPA/R9LQsJxq/tci+i/NERaISe0VA
         f98JeS2xg81yXdgYKUNrOIRafHyA59m/PJKaW+CPM7NhwyJPPYmYaxF3atG0mDsz5X
         Aq5xECSblAkA8K/K5K8yci0/ie1bSlDm7aO2SbZY=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v8 6/8] pwm: pca9685: Support new PWM_USAGE_POWER flag
Date:   Mon, 12 Apr 2021 15:27:43 +0200
Message-Id: <20210412132745.76609-6-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
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
 drivers/pwm/pwm-pca9685.c | 63 ++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 7f97965033e7..410b93b115dc 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -93,46 +93,76 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
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
 
-	val = 0;
 	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
-	return ((off_h & 0xf) << 8) | (val & 0xff);
+	off = ((off & 0xf) << 8) | (val & 0xff);
+	if (!pwm->args.usage_power)
+		return off;
+
+	/* Read ON register to calculate duty cycle of staggered output */
+	val = 0;
+	regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
+	on = ((on & 0xf) << 8) | (val & 0xff);
+	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
 }
 
 #if IS_ENABLED(CONFIG_GPIOLIB)
@@ -439,9 +469,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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
@@ -450,6 +482,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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

