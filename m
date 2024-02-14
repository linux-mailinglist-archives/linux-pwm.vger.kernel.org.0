Return-Path: <linux-pwm+bounces-1403-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626618545E1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C01B22DA0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA8118C3A;
	Wed, 14 Feb 2024 09:34:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2E18638
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903282; cv=none; b=Ljp2evwvPZROpjanM0iW//0ejFLgxV1V/Zogk0OQhdV6OayuHDe08TGpudv9/aRyodAPNo+ICSykTJfoDIKzMzXIrsoYDk9JM74GcdNPjkl9Z9uastJ8BxeTphxYaReloA/Cf6rrKAlS1OwB8OWHGjoQinRrwXhtBTwy8NUjrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903282; c=relaxed/simple;
	bh=rDBSkx1Q8pUQd0lt512zuTI+up5rBm8GMK7XMY0TddY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gmnw4aKn/HH3nWKYyamflvZXq8eBF/bJO99EJ4UkN/1a6OOON6jGun7vQdfdqqdt5TZDF+w9RVCnMp3xwhex+IUBtZdl3SzjY8qRaAfKcfsdEEnFRgQv/LrNc93rqDPo73eYqpcaau+aWwp1/hcxfZ0dCGPlt09X11TXdH9eqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-0005FW-NI; Wed, 14 Feb 2024 10:34:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-000fDk-H9; Wed, 14 Feb 2024 10:34:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-004Y5D-1R;
	Wed, 14 Feb 2024 10:34:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 081/164] pwm: pca9685: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:08 +0100
Message-ID:  <e87b378545cee15a52f0d410fcceebf671ab90e0.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=14613; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rDBSkx1Q8pUQd0lt512zuTI+up5rBm8GMK7XMY0TddY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIinrEgGnGQYJ23aW/FsDfiiLdVd9FnOlPc4N G4fftKnI7CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIpwAKCRCPgPtYfRL+ TmTNCACQoNP+fKPA1V/fOonRcFEfZHanRMESXSmBn7+IZFkJ/RrKqpTPxa4N8hvtk2Q/NLjR9wR scLQy6HE6IFTeACJtg9/CI1L7xPfV4wYkS/KoWC3xOZD8oDH825Qytv+kb9WvmqrejCVynXOyCK LKlpTUg7uNL5FaYHi3U2fD/26fkbylsel8TuVJx3g1V3Cw0VrmKEb1tR/stIgEdCCwvFwjzRxNc 3vO7IOmHSVIUvOxsBWhPcTQTF/4VcCvnXU74tmWF/grNImDqbbljZn5+VHuQK9B8XruVDQIyIPm fG+BoM7M/yL/GonD3mBCH0XbpTZBNSEuRyR1ALv/zJwV52QE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct pca9685. Use the pwm_chip as i2c client data
and gpiochip data instead of the pca9685 to get access to the
pwm_chip in pca9685_pwm_remove(), pca9685_pwm_runtime_suspend(),
pca9685_pwm_runtime_resume(), pca9685_pwm_gpio_request() and the gpio
callbacks without using pca->chip. Also the prototype for various helper
functions is changed to take a pwm_chip instead of a pca9685 for the
same reason.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 143 ++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 68 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index e79b1de8c4d8..d7542517fa49 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -107,9 +107,10 @@ static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
 	return test_bit(channel, pca->pwms_enabled);
 }
 
-static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsigned int *val)
+static int pca9685_read_reg(struct pwm_chip *chip, unsigned int reg, unsigned int *val)
 {
-	struct device *dev = pca->chip.dev;
+	struct pca9685 *pca = to_pca(chip);
+	struct device *dev = chip->dev;
 	int err;
 
 	err = regmap_read(pca->regmap, reg, val);
@@ -119,9 +120,10 @@ static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsigned int
 	return err;
 }
 
-static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsigned int val)
+static int pca9685_write_reg(struct pwm_chip *chip, unsigned int reg, unsigned int val)
 {
-	struct device *dev = pca->chip.dev;
+	struct pca9685 *pca = to_pca(chip);
+	struct device *dev = chip->dev;
 	int err;
 
 	err = regmap_write(pca->regmap, reg, val);
@@ -132,19 +134,19 @@ static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsigned int
 }
 
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
-static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
+static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned int duty)
 {
-	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	struct pwm_device *pwm = &chip->pwms[channel];
 	unsigned int on, off;
 
 	if (duty == 0) {
 		/* Set the full OFF bit, which has the highest precedence */
-		pca9685_write_reg(pca, REG_OFF_H(channel), LED_FULL);
+		pca9685_write_reg(chip, REG_OFF_H(channel), LED_FULL);
 		return;
 	} else if (duty >= PCA9685_COUNTER_RANGE) {
 		/* Set the full ON bit and clear the full OFF bit */
-		pca9685_write_reg(pca, REG_ON_H(channel), LED_FULL);
-		pca9685_write_reg(pca, REG_OFF_H(channel), 0);
+		pca9685_write_reg(chip, REG_ON_H(channel), LED_FULL);
+		pca9685_write_reg(chip, REG_OFF_H(channel), 0);
 		return;
 	}
 
@@ -164,16 +166,16 @@ static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int
 	off = (on + duty) % PCA9685_COUNTER_RANGE;
 
 	/* Set ON time (clears full ON bit) */
-	pca9685_write_reg(pca, REG_ON_L(channel), on & 0xff);
-	pca9685_write_reg(pca, REG_ON_H(channel), (on >> 8) & 0xf);
+	pca9685_write_reg(chip, REG_ON_L(channel), on & 0xff);
+	pca9685_write_reg(chip, REG_ON_H(channel), (on >> 8) & 0xf);
 	/* Set OFF time (clears full OFF bit) */
-	pca9685_write_reg(pca, REG_OFF_L(channel), off & 0xff);
-	pca9685_write_reg(pca, REG_OFF_H(channel), (off >> 8) & 0xf);
+	pca9685_write_reg(chip, REG_OFF_L(channel), off & 0xff);
+	pca9685_write_reg(chip, REG_OFF_H(channel), (off >> 8) & 0xf);
 }
 
-static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
+static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, int channel)
 {
-	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	struct pwm_device *pwm = &chip->pwms[channel];
 	unsigned int off = 0, on = 0, val = 0;
 
 	if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
@@ -181,25 +183,25 @@ static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
 		return 0;
 	}
 
-	pca9685_read_reg(pca, LED_N_OFF_H(channel), &off);
+	pca9685_read_reg(chip, LED_N_OFF_H(channel), &off);
 	if (off & LED_FULL) {
 		/* Full OFF bit is set */
 		return 0;
 	}
 
-	pca9685_read_reg(pca, LED_N_ON_H(channel), &on);
+	pca9685_read_reg(chip, LED_N_ON_H(channel), &on);
 	if (on & LED_FULL) {
 		/* Full ON bit is set */
 		return PCA9685_COUNTER_RANGE;
 	}
 
-	pca9685_read_reg(pca, LED_N_OFF_L(channel), &val);
+	pca9685_read_reg(chip, LED_N_OFF_L(channel), &val);
 	off = ((off & 0xf) << 8) | (val & 0xff);
 	if (!pwm->state.usage_power)
 		return off;
 
 	/* Read ON register to calculate duty cycle of staggered output */
-	if (pca9685_read_reg(pca, LED_N_ON_L(channel), &val)) {
+	if (pca9685_read_reg(chip, LED_N_ON_L(channel), &val)) {
 		/* Reset val to 0 in case reading LED_N_ON_L failed */
 		val = 0;
 	}
@@ -247,35 +249,37 @@ static void pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
 
 static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
+	struct pca9685 *pca = to_pca(chip);
 
 	if (pca9685_pwm_test_and_set_inuse(pca, offset))
 		return -EBUSY;
-	pm_runtime_get_sync(pca->chip.dev);
+	pm_runtime_get_sync(chip->dev);
 	return 0;
 }
 
 static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
 
-	return pca9685_pwm_get_duty(pca, offset) != 0;
+	return pca9685_pwm_get_duty(chip, offset) != 0;
 }
 
 static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 				 int value)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
 
-	pca9685_pwm_set_duty(pca, offset, value ? PCA9685_COUNTER_RANGE : 0);
+	pca9685_pwm_set_duty(chip, offset, value ? PCA9685_COUNTER_RANGE : 0);
 }
 
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
+	struct pca9685 *pca = to_pca(chip);
 
-	pca9685_pwm_set_duty(pca, offset, 0);
-	pm_runtime_put(pca->chip.dev);
+	pca9685_pwm_set_duty(chip, offset, 0);
+	pm_runtime_put(chip->dev);
 	pca9685_pwm_clear_inuse(pca, offset);
 }
 
@@ -306,9 +310,10 @@ static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
  * expose a GPIO chip here which can exclusively take over the underlying
  * PWM channel.
  */
-static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
+static int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
 {
-	struct device *dev = pca->chip.dev;
+	struct pca9685 *pca = to_pca(chip);
+	struct device *dev = chip->dev;
 
 	pca->gpio.label = dev_name(dev);
 	pca->gpio.parent = dev;
@@ -323,7 +328,7 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 	pca->gpio.ngpio = PCA9685_MAXCHAN;
 	pca->gpio.can_sleep = true;
 
-	return devm_gpiochip_add_data(dev, &pca->gpio, pca);
+	return devm_gpiochip_add_data(dev, &pca->gpio, chip);
 }
 #else
 static inline bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca,
@@ -337,15 +342,16 @@ pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
 {
 }
 
-static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
+static inline int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
 {
 	return 0;
 }
 #endif
 
-static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
+static void pca9685_set_sleep_mode(struct pwm_chip *chip, bool enable)
 {
-	struct device *dev = pca->chip.dev;
+	struct device *dev = chip->dev;
+	struct pca9685 *pca = to_pca(chip);
 	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
 				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
 	if (err) {
@@ -378,11 +384,11 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (!state->enabled) {
-		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+		pca9685_pwm_set_duty(chip, pwm->hwpwm, 0);
 		return 0;
 	}
 
-	pca9685_read_reg(pca, PCA9685_PRESCALE, &val);
+	pca9685_read_reg(chip, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
 		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
 			dev_err(chip->dev,
@@ -397,18 +403,18 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * state is guaranteed active here.
 		 */
 		/* Put chip into sleep mode */
-		pca9685_set_sleep_mode(pca, true);
+		pca9685_set_sleep_mode(chip, true);
 
 		/* Change the chip-wide output frequency */
-		pca9685_write_reg(pca, PCA9685_PRESCALE, prescale);
+		pca9685_write_reg(chip, PCA9685_PRESCALE, prescale);
 
 		/* Wake the chip up */
-		pca9685_set_sleep_mode(pca, false);
+		pca9685_set_sleep_mode(chip, false);
 	}
 
 	duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
 	duty = DIV_ROUND_UP_ULL(duty, state->period);
-	pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
+	pca9685_pwm_set_duty(chip, pwm->hwpwm, duty);
 	return 0;
 }
 
@@ -434,12 +440,11 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				 struct pwm_state *state)
 {
-	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
 	unsigned int val = 0;
 
 	/* Calculate (chip-wide) period from prescale value */
-	pca9685_read_reg(pca, PCA9685_PRESCALE, &val);
+	pca9685_read_reg(chip, PCA9685_PRESCALE, &val);
 	/*
 	 * PCA9685_OSC_CLOCK_MHZ is 25, i.e. an integer divider of 1000.
 	 * The following calculation is therefore only a multiplication
@@ -462,7 +467,7 @@ static int pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	state->enabled = true;
-	duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
+	duty = pca9685_pwm_get_duty(chip, pwm->hwpwm);
 	state->duty_cycle = DIV_ROUND_DOWN_ULL(duty * state->period, PCA9685_COUNTER_RANGE);
 
 	return 0;
@@ -492,7 +497,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pca9685 *pca = to_pca(chip);
 
 	mutex_lock(&pca->lock);
-	pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+	pca9685_pwm_set_duty(chip, pwm->hwpwm, 0);
 	clear_bit(pwm->hwpwm, pca->pwms_enabled);
 	mutex_unlock(&pca->lock);
 
@@ -516,6 +521,7 @@ static const struct regmap_config pca9685_regmap_i2c_config = {
 
 static int pca9685_pwm_probe(struct i2c_client *client)
 {
+	struct pwm_chip *chip;
 	struct pca9685 *pca;
 	unsigned int reg;
 	int ret;
@@ -531,12 +537,13 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 			ret);
 		return ret;
 	}
+	chip = &pca->chip;
 
-	i2c_set_clientdata(client, pca);
+	i2c_set_clientdata(client, chip);
 
 	mutex_init(&pca->lock);
 
-	ret = pca9685_read_reg(pca, PCA9685_MODE2, &reg);
+	ret = pca9685_read_reg(chip, PCA9685_MODE2, &reg);
 	if (ret)
 		return ret;
 
@@ -550,34 +557,34 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	else
 		reg |= MODE2_OUTDRV;
 
-	ret = pca9685_write_reg(pca, PCA9685_MODE2, reg);
+	ret = pca9685_write_reg(chip, PCA9685_MODE2, reg);
 	if (ret)
 		return ret;
 
 	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
-	pca9685_read_reg(pca, PCA9685_MODE1, &reg);
+	pca9685_read_reg(chip, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
-	pca9685_write_reg(pca, PCA9685_MODE1, reg);
+	pca9685_write_reg(chip, PCA9685_MODE1, reg);
 
 	/* Reset OFF/ON registers to POR default */
-	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_L, 0);
-	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_H, LED_FULL);
-	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_L, 0);
-	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, LED_FULL);
+	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_L, 0);
+	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_H, LED_FULL);
+	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_L, 0);
+	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_H, LED_FULL);
 
-	pca->chip.ops = &pca9685_pwm_ops;
+	chip->ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
-	pca->chip.npwm = PCA9685_MAXCHAN + 1;
+	chip->npwm = PCA9685_MAXCHAN + 1;
 
-	pca->chip.dev = &client->dev;
+	chip->dev = &client->dev;
 
-	ret = pwmchip_add(&pca->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return ret;
 
-	ret = pca9685_pwm_gpio_probe(pca);
+	ret = pca9685_pwm_gpio_probe(chip);
 	if (ret < 0) {
-		pwmchip_remove(&pca->chip);
+		pwmchip_remove(chip);
 		return ret;
 	}
 
@@ -588,11 +595,11 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 		 * Although the chip comes out of power-up in the sleep state,
 		 * we force it to sleep in case it was woken up before
 		 */
-		pca9685_set_sleep_mode(pca, true);
+		pca9685_set_sleep_mode(chip, true);
 		pm_runtime_set_suspended(&client->dev);
 	} else {
 		/* Wake the chip up if runtime PM is disabled */
-		pca9685_set_sleep_mode(pca, false);
+		pca9685_set_sleep_mode(chip, false);
 	}
 
 	return 0;
@@ -600,13 +607,13 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 
 static void pca9685_pwm_remove(struct i2c_client *client)
 {
-	struct pca9685 *pca = i2c_get_clientdata(client);
+	struct pwm_chip *chip = i2c_get_clientdata(client);
 
-	pwmchip_remove(&pca->chip);
+	pwmchip_remove(chip);
 
 	if (!pm_runtime_enabled(&client->dev)) {
 		/* Put chip in sleep state if runtime PM is disabled */
-		pca9685_set_sleep_mode(pca, true);
+		pca9685_set_sleep_mode(chip, true);
 	}
 
 	pm_runtime_disable(&client->dev);
@@ -615,18 +622,18 @@ static void pca9685_pwm_remove(struct i2c_client *client)
 static int __maybe_unused pca9685_pwm_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct pca9685 *pca = i2c_get_clientdata(client);
+	struct pwm_chip *chip = i2c_get_clientdata(client);
 
-	pca9685_set_sleep_mode(pca, true);
+	pca9685_set_sleep_mode(chip, true);
 	return 0;
 }
 
 static int __maybe_unused pca9685_pwm_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct pca9685 *pca = i2c_get_clientdata(client);
+	struct pwm_chip *chip = i2c_get_clientdata(client);
 
-	pca9685_set_sleep_mode(pca, false);
+	pca9685_set_sleep_mode(chip, false);
 	return 0;
 }
 
-- 
2.43.0


