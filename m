Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66B82B8346
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 18:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgKRRoz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 12:44:55 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:53814 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgKRRoz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 12:44:55 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id DECD2C6866D;
        Wed, 18 Nov 2020 18:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605721491;
        bh=0h8qvojkIKLurIM1SU17h0C7vyy249XJDyY1onLMgOE=;
        h=From:To:Cc:Subject:Date:From;
        b=e58DRlK3m48F8QWaN7vu/HW6JtVa2mNTu+ioNWMOlflsiag2z3TX772RcyBqmNREB
         9Yi7739al8XmUs9CPbhtZ14wOMHbe/uetlRTMZ3Zs6DavLAOMnLNhMEkAXfqzWYxJO
         KluyVXlzfKwTjT/rXNhs5xQoFRNp+SpxFFcCKuTA=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 1/3] pwm: pca9685: Switch to atomic API
Date:   Wed, 18 Nov 2020 18:44:15 +0100
Message-Id: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This switch to the atomic API goes hand in hand with a few fixes to
previously experienced issues:
- The duty cycle is no longer lost after disable/enable (previously the
  OFF registers were cleared in disable and the user was required to
  call config to restore the duty cycle settings)
- The prescale register is now read out. If one sets a period resulting
  in the same prescale register value, the sleep and write to the
  register is skipped

The hardware readout may return slightly different values than those
that were set in apply due to the limited range of possible prescale and
counter register values. If one channel is reconfigured with new duty
cycle and period, the others will keep the same relative duty cycle to
period ratio as they had before, even though the per-chip / global
frequency changed. (The PCA9685 has only one prescaler!)

Note that although the datasheet mentions 200 Hz as default frequency
when using the internal 25 MHz oscillator, the calculated period from
the default prescaler register setting of 30 is 5079040ns.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 233 ++++++++++++++++++++------------------
 1 file changed, 124 insertions(+), 109 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 4a55dc18656c..20f1314e6754 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -51,7 +51,6 @@
 #define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
 
 #define PCA9685_COUNTER_RANGE	4096
-#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns = 1/200 Hz */
 #define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 MHz */
 
 #define PCA9685_NUMREGS		0xFF
@@ -74,7 +73,7 @@
 struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
-	int period_ns;
+	int prescale;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -246,18 +245,117 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 	}
 }
 
-static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			      int duty_ns, int period_ns)
+static void pca9685_pwm_full_off(struct pwm_chip *chip,
+				 struct pwm_device *pwm)
+{
+	struct pca9685 *pca = to_pca(chip);
+	int reg;
+
+	/*
+	 * Set the full OFF bit to cause the PWM channel to be always off.
+	 * The full OFF bit has precedence over the other register values.
+	 */
+
+	if (pwm->hwpwm >= PCA9685_MAXCHAN)
+		reg = PCA9685_ALL_LED_OFF_H;
+	else
+		reg = LED_N_OFF_H(pwm->hwpwm);
+
+	regmap_write(pca->regmap, reg, LED_FULL);
+}
+
+static void pca9685_pwm_full_on(struct pwm_chip *chip,
+				struct pwm_device *pwm)
+{
+	struct pca9685 *pca = to_pca(chip);
+	int reg;
+
+	/*
+	 * Clear the OFF registers (including the full OFF bit) and set
+	 * the full ON bit to cause the PWM channel to be always on.
+	 */
+
+	if (pwm->hwpwm >= PCA9685_MAXCHAN)
+		reg = PCA9685_ALL_LED_OFF_L;
+	else
+		reg = LED_N_OFF_L(pwm->hwpwm);
+
+	regmap_write(pca->regmap, reg, 0x0);
+
+	if (pwm->hwpwm >= PCA9685_MAXCHAN)
+		reg = PCA9685_ALL_LED_OFF_H;
+	else
+		reg = LED_N_OFF_H(pwm->hwpwm);
+
+	regmap_write(pca->regmap, reg, 0x0);
+
+	if (pwm->hwpwm >= PCA9685_MAXCHAN)
+		reg = PCA9685_ALL_LED_ON_H;
+	else
+		reg = LED_N_ON_H(pwm->hwpwm);
+
+	regmap_write(pca->regmap, reg, LED_FULL);
+}
+
+static int pca9685_pwm_read_global_period(struct pca9685 *pca)
+{
+	unsigned int prescale = 0;
+
+	regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
+
+	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX)
+		return 0;
+
+	return (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
+		(prescale + 1);
+}
+
+static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pca9685 *pca = to_pca(chip);
+	unsigned int val, duty;
+	int reg;
+
+	/* Read out (chip-wide) period */
+	state->period = pca9685_pwm_read_global_period(pca);
+
+	/* The (per-channel) polarity is fixed */
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	/* Read out current duty cycle and enabled state */
+	reg = pwm->hwpwm >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H :
+		LED_N_OFF_H(pwm->hwpwm);
+	regmap_read(pca->regmap, reg, &val);
+	duty = (val & 0xf) << 8;
+
+	state->enabled = !(val & LED_FULL);
+
+	reg = pwm->hwpwm >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L :
+		LED_N_OFF_L(pwm->hwpwm);
+	regmap_read(pca->regmap, reg, &val);
+	duty |= (val & 0xff);
+
+	if (duty < PCA9685_COUNTER_RANGE) {
+		duty *= state->period;
+		state->duty_cycle = duty / (PCA9685_COUNTER_RANGE - 1);
+	} else
+		state->duty_cycle = 0;
+}
+
+static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
 {
 	struct pca9685 *pca = to_pca(chip);
-	unsigned long long duty;
+	unsigned long long duty, prescale;
 	unsigned int reg;
-	int prescale;
 
-	if (period_ns != pca->period_ns) {
-		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
-					     PCA9685_COUNTER_RANGE * 1000) - 1;
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EOPNOTSUPP;
 
+	prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
+					 PCA9685_COUNTER_RANGE * 1000) - 1;
+	if (prescale != pca->prescale) {
 		if (prescale >= PCA9685_PRESCALE_MIN &&
 			prescale <= PCA9685_PRESCALE_MAX) {
 			/*
@@ -270,12 +368,13 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			pca9685_set_sleep_mode(pca, true);
 
 			/* Change the chip-wide output frequency */
-			regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
+			regmap_write(pca->regmap, PCA9685_PRESCALE,
+				     (int)prescale);
 
 			/* Wake the chip up */
 			pca9685_set_sleep_mode(pca, false);
 
-			pca->period_ns = period_ns;
+			pca->prescale = (int)prescale;
 		} else {
 			dev_err(chip->dev,
 				"prescaler not set: period out of bounds!\n");
@@ -283,46 +382,18 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	if (duty_ns < 1) {
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_H;
-		else
-			reg = LED_N_OFF_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, LED_FULL);
-
+	if (!state->enabled || state->duty_cycle < 1) {
+		pca9685_pwm_full_off(chip, pwm);
 		return 0;
 	}
 
-	if (duty_ns == period_ns) {
-		/* Clear both OFF registers */
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_L;
-		else
-			reg = LED_N_OFF_L(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, 0x0);
-
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_H;
-		else
-			reg = LED_N_OFF_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, 0x0);
-
-		/* Set the full ON bit */
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_ON_H;
-		else
-			reg = LED_N_ON_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, LED_FULL);
-
+	if (state->duty_cycle == state->period) {
+		pca9685_pwm_full_on(chip, pwm);
 		return 0;
 	}
 
-	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
-	duty = DIV_ROUND_UP_ULL(duty, period_ns);
+	duty = (PCA9685_COUNTER_RANGE - 1) * state->duty_cycle;
+	duty = DIV_ROUND_UP_ULL(duty, state->period);
 
 	if (pwm->hwpwm >= PCA9685_MAXCHAN)
 		reg = PCA9685_ALL_LED_OFF_L;
@@ -349,64 +420,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pca9685 *pca = to_pca(chip);
-	unsigned int reg;
-
-	/*
-	 * The PWM subsystem does not support a pre-delay.
-	 * So, set the ON-timeout to 0
-	 */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_L;
-	else
-		reg = LED_N_ON_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_H;
-	else
-		reg = LED_N_ON_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
-
-	/*
-	 * Clear the full-off bit.
-	 * It has precedence over the others and must be off.
-	 */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
-
-	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
-
-	return 0;
-}
-
-static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pca9685 *pca = to_pca(chip);
-	unsigned int reg;
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, LED_FULL);
-
-	/* Clear the LED_OFF counter. */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_L;
-	else
-		reg = LED_N_OFF_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0x0);
-}
-
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
@@ -422,15 +435,14 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	pca9685_pwm_disable(chip, pwm);
+	pca9685_pwm_full_off(chip, pwm);
 	pm_runtime_put(chip->dev);
 	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
-	.enable = pca9685_pwm_enable,
-	.disable = pca9685_pwm_disable,
-	.config = pca9685_pwm_config,
+	.get_state = pca9685_pwm_get_state,
+	.apply = pca9685_pwm_apply,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
@@ -448,7 +460,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 {
 	struct pca9685 *pca;
 	unsigned int reg;
-	int ret;
+	int prescale = 0, ret;
 
 	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
 	if (!pca)
@@ -461,10 +473,13 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 			ret);
 		return ret;
 	}
-	pca->period_ns = PCA9685_DEFAULT_PERIOD;
 
 	i2c_set_clientdata(client, pca);
 
+	regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
+	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX)
+		pca->prescale = prescale;
+
 	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
 
 	if (device_property_read_bool(&client->dev, "invert"))
-- 
2.29.2

