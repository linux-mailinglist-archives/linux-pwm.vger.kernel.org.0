Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83C22B834A
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgKRRpJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 12:45:09 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:53842 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgKRRpJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 12:45:09 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 1F18FC7D0F7;
        Wed, 18 Nov 2020 18:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605721507;
        bh=Vd2Gr8YsjPn2h239nMG1j/VeOssRUKO75wDDPmdvDvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwRi9o/ITD1HtvB48kAD6kQ8ZS5PllEDKSmyoIZpx6XBFvDmMvkBsVFH3HZNr3hXg
         NtTMjFeLcGAUaamZe2Ag2JHfyP+tnHeQmMf7zC9/xJIn/hUM/2n8Pw5OjEMQjcikO6
         rTXJt/ZJaehwb05LcXKIa5TYqQudHol7AL5V+ETE=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 3/3] pwm: pca9685: Support staggered output ON times
Date:   Wed, 18 Nov 2020 18:44:17 +0100
Message-Id: <20201118174417.278011-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
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
 drivers/pwm/pwm-pca9685.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 88028222335f..95958b5cce0d 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -74,6 +74,7 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	int prescale;
+	bool staggered_outputs;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -348,7 +349,7 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty, prescale;
-	unsigned int reg;
+	unsigned int on, off, reg;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EOPNOTSUPP;
@@ -395,6 +396,32 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -494,6 +521,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	regmap_write(pca->regmap, PCA9685_MODE2, reg);
 
+	pca->staggered_outputs = device_property_read_bool(
+		&client->dev, "staggered-outputs");
+
 	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
 	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
@@ -502,6 +532,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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

