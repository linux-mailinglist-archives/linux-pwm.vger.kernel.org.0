Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1624D2D19D9
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgLGTiC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 14:38:02 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:35210 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgLGTiC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 14:38:02 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 42E4AC8926D;
        Mon,  7 Dec 2020 20:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607369839;
        bh=2aTuh/OTF7qUnaEWBSyPsz9linBNYAjPZccuYISJWAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubKs4K5gJ2uzt6LYg981PCKHSJ0ebOy/DJlB5HLOuujnm6oPqiOXOpf8lbW1bHF+W
         kKGwD4uMpEtCFqHjVpVO780MREUdSH5gWLKXJ465Gtuepte8lDEbYFrkCF+68F6Kvv
         Dd3gju+CVw/sytn/yh6W01qZvKY6E1SR7+h1uFR8=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v4 3/4] pwm: pca9685: Support staggered output ON times
Date:   Mon,  7 Dec 2020 20:36:29 +0100
Message-Id: <20201207193629.493241-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
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
Changes since v3:
- Refactoring: Extracted common functions
- Fixed error in .get_state
- Added vendor prefix to DT property

Changes since v1:
- Rebased

 drivers/pwm/pwm-pca9685.c | 72 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index fdce5fb9f41e..2697138ee95a 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -74,6 +74,7 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
+	bool staggered_outputs;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -161,6 +162,35 @@ static unsigned int pca9685_pwm_off_time(struct pca9685 *pca, int index)
 	return off | (val & 0xff);
 }
 
+static void pca9685_pwm_set_on_time(struct pca9685 *pca, int index, unsigned int on)
+{
+	int reg;
+
+	/* Note: This function also clears the full ON bit */
+
+	reg = index >= PCA9685_MAXCHAN ?
+		PCA9685_ALL_LED_ON_L : LED_N_ON_L(index);
+	regmap_write(pca->regmap, reg, on & 0xff);
+
+	reg = index >= PCA9685_MAXCHAN ?
+		PCA9685_ALL_LED_ON_H : LED_N_ON_H(index);
+	regmap_write(pca->regmap, reg, (on >> 8) & 0xf);
+}
+
+static unsigned int pca9685_pwm_on_time(struct pca9685 *pca, int index)
+{
+	unsigned int on, val = 0;
+
+	if (index >= PCA9685_MAXCHAN)
+		return 0;
+
+	regmap_read(pca->regmap, LED_N_ON_H(index), &val);
+	on = (val & 0xf) << 8;
+
+	regmap_read(pca->regmap, LED_N_ON_L(index), &val);
+	return on | (val & 0xff);
+}
+
 #if IS_ENABLED(CONFIG_GPIOLIB)
 static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
 {
@@ -322,7 +352,7 @@ static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
-	unsigned int val = 0;
+	unsigned int on, off, val = 0;
 
 	/* Calculate (chip-wide) period from prescale value */
 	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
@@ -349,7 +379,19 @@ static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return;
 	}
 
-	duty = pca9685_pwm_off_time(pca, pwm->hwpwm) * state->period;
+	off = pca9685_pwm_off_time(pca, pwm->hwpwm);
+
+	if (pca->staggered_outputs) {
+		on = pca9685_pwm_on_time(pca, pwm->hwpwm);
+
+		if (off >= on)
+			duty = off - on;
+		else
+			duty = off + PCA9685_COUNTER_RANGE - on;
+	} else
+		duty = off;
+
+	duty *= state->period;
 	state->duty_cycle = duty / PCA9685_COUNTER_RANGE;
 }
 
@@ -358,7 +400,7 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty, prescale;
-	unsigned int val = 0;
+	unsigned int on, off, val = 0;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EOPNOTSUPP;
@@ -405,6 +447,24 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
+	if (pca->staggered_outputs) {
+		if (pwm->hwpwm < PCA9685_MAXCHAN) {
+			/*
+			 * To reduce EMI, the ON times of each channel are
+			 * spread out evenly within the counter range, while
+			 * still maintaining the configured duty cycle
+			 */
+			on = pwm->hwpwm * PCA9685_COUNTER_RANGE / PCA9685_MAXCHAN;
+			off = (on + duty) % PCA9685_COUNTER_RANGE;
+			pca9685_pwm_set_on_time(pca, pwm->hwpwm, on);
+			pca9685_pwm_set_off_time(pca, pwm->hwpwm, off);
+			return 0;
+		}
+
+		/* No staggering possible if "all LEDs" channel is used */
+		pca9685_pwm_set_on_time(pca, PCA9685_MAXCHAN, 0);
+	}
+
 	pca9685_pwm_set_off_time(pca, pwm->hwpwm, duty);
 	/* Clear full ON bit after OFF time was set */
 	pca9685_pwm_set_full_on(pca, pwm->hwpwm, false);
@@ -481,6 +541,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	regmap_write(pca->regmap, PCA9685_MODE2, reg);
 
+	pca->staggered_outputs = device_property_read_bool(
+		&client->dev, "nxp,staggered-outputs");
+
 	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
 	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
@@ -489,6 +552,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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

