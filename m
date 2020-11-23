Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AE32C10C5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Nov 2020 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbgKWQhQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Nov 2020 11:37:16 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:41326 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgKWQhQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 23 Nov 2020 11:37:16 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id C379CC81EEB;
        Mon, 23 Nov 2020 17:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1606149434;
        bh=Kc6Fqrrn44fvOnRrUmkrUS9dVkPwBhPEwVaxBFioCTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w2KhMJOry0PmX39LhN+BBMGxyxy9JWzQCMG1v+5XaCfAVIrYZIV0Ty+vD/kJJ+APP
         8rtX0g8KBnZiyUd5mrex1WzCeDmMMbWJ3Ku+8QlTq/p5jxSt7HZcv7xprxUf0/vL3H
         kTn/S4SxAcl7yTudiLbqdDNH3gBqt6BK2fx2x2Fk=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v2 3/4] pwm: pca9685: Support staggered output ON times
Date:   Mon, 23 Nov 2020 17:36:22 +0100
Message-Id: <20201123163622.166048-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123163622.166048-1-clemens.gruber@pqgruber.com>
References: <20201123163622.166048-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PCA9685 supports staggered LED output ON times to minimize current
surges and reduce EMI.
When this new option is enabled, the ON times of each channel are
delayed by channel number x counter range / 16, which avoids asserting
all enabled outputs at the same counter value while still maintaining
the configured duty cycle of each output.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---

Changes since v1:
- Rebased

 drivers/pwm/pwm-pca9685.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index eaeadfa853cf..c22268b63fcc 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -75,6 +75,7 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	int prescale;
+	bool staggered_outputs;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -350,7 +351,7 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty, prescale;
-	unsigned int reg;
+	unsigned int on, off, reg;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EOPNOTSUPP;
@@ -386,6 +387,32 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = (PCA9685_COUNTER_RANGE - 1) * state->duty_cycle;
 	duty = DIV_ROUND_UP_ULL(duty, state->period);
 
+	if (pca->staggered_outputs) {
+		if (pwm->hwpwm < PCA9685_MAXCHAN) {
+			/*
+			 * To reduce EMI, the ON times of each channel are
+			 * spread out evenly within the counter range, while
+			 * still maintaining the configured duty cycle
+			 */
+			on = pwm->hwpwm * PCA9685_COUNTER_RANGE /
+				PCA9685_MAXCHAN;
+			off = (on + duty) % PCA9685_COUNTER_RANGE;
+			regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm),
+				     on & 0xff);
+			regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm),
+				     (on >> 8) & 0xf);
+			regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm),
+				     off & 0xff);
+			regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
+				     (off >> 8) & 0xf);
+			return 0;
+		}
+
+		/* No staggering possible if "all LEDs" channel is used */
+		regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
+		regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
+	}
+
 	if (pwm->hwpwm >= PCA9685_MAXCHAN)
 		reg = PCA9685_ALL_LED_OFF_L;
 	else
@@ -489,6 +516,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	regmap_write(pca->regmap, PCA9685_MODE2, reg);
 
+	pca->staggered_outputs = device_property_read_bool(
+		&client->dev, "staggered-outputs");
+
 	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
 	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
@@ -497,6 +527,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	/* Reset OFF registers to HW default (only full OFF bit is set) */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
+	/* Reset ON registers to HW default */
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
-- 
2.29.2

