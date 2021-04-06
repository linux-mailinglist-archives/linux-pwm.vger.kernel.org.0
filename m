Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA7355974
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbhDFQoX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbhDFQoL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 12:44:11 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F0FC061756;
        Tue,  6 Apr 2021 09:44:03 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id BE877C6AE58;
        Tue,  6 Apr 2021 18:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617727442;
        bh=6xt8rcpKXf7/7ZgfkeDyBlRn2Lb3FJLaOO+t8c6Yu8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0cVM3izGHQ9CzIiMUsfGJHETFcoGuKaa1mbeM15g9b3AIXymmrdPUNy7BXYoy6qb
         ZotPfSaXWjScFqFeHPPseATa4gscK9UUULZjDoTYozELyIIfwq87qBpcv6Xaq6f9fg
         W1NwEwBW4iMEGGaxyTOeL5Wii9UHGo5UsoHHA7qk=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v7 6/8] pwm: pca9685: Support new PWM_STAGGERING_ALLOWED flag
Date:   Tue,  6 Apr 2021 18:41:38 +0200
Message-Id: <20210406164140.81423-6-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PCA9685 supports staggered LED output ON times to minimize current
surges and reduce EMI.
When the PWM_STAGGERING_ALLOWED flag is set for a channel, its ON time
is delayed by channel number x counter range / 16, which avoids
asserting all the enabled outputs at the same counter value while still
maintaining the configured duty cycle of each output.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
Changes since v6:
- Use a per-PWM flag instead of one global DT parameter

 drivers/pwm/pwm-pca9685.c | 60 ++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 0bcec04b138a..24221ee7a77a 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -93,46 +93,73 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
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
+	if (pwm->args.staggering_allowed && channel < PCA9685_MAXCHAN) {
+		/*
+		 * To reduce EMI, the ON times of each channel are
+		 * spread out evenly within the counter range, while
+		 * still maintaining the configured duty cycle
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
+	if (!pwm->args.staggering_allowed)
+		return off;
+
+	/* Read ON register to calculate duty cycle of staggered output */
+	val = 0;
+	regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
+	on = ((on & 0xf) << 8) | (val & 0xff);
+	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
 }
 
 #if IS_ENABLED(CONFIG_GPIOLIB)
@@ -453,9 +480,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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
@@ -464,6 +493,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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

