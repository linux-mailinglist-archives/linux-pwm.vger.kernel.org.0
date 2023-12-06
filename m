Return-Path: <linux-pwm+bounces-388-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B90806EBA
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36C11C20A15
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501934578;
	Wed,  6 Dec 2023 11:48:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92C10CF
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-0007Be-Sc; Wed, 06 Dec 2023 12:48:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00DwwL-Th; Wed, 06 Dec 2023 12:48:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00FR1p-KX; Wed, 06 Dec 2023 12:48:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 081/115] pwm: pca9685: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:35 +0100
Message-ID:  <5bf14e652eb20de9c567bee4e3794cbe55aa74e4.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8919; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=xl/mMBac0YZAzvsu5xINE1pRknsK90zSmE60MUTobUE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8AL+Wne+4uFjKGbrI2Hgw+yh4019P8+UJOI YhMm5kBSIeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfAAAKCRCPgPtYfRL+ TllyB/9g7pRcsNl2dl7Z7gzDQr8jzStJU2p/Fx3OTeYZLTdD+upLwv7f+PLG3hm2Iupkhd1/9YR vqpZml9ZfuKHFb/dLSx/ojQUTAs5e/LpdchE4m3ysmnvClj7BkKbRHsBeL8C1yljx2SQQa5g4OQ SJbOH2mR/SN0wZQtiQ9tOBFznk4XpZN33QTOPwVjFt4KSxDyiPXRTDZ/5+ns3pDdUwRXbyig5fa uC6M8l4Ev4z9uBv0nqlNyqqTmDWck2jjPmLuUzlo6bGi4y6lsIDbxgZSc992irKBShvJOf+lGMl 9p6/IXCJexAJK+iA8RfIs0lsxSQnTSlvmRRiW132YXZqumLO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-pca9685 driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 76 +++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 04e713ef790f..f88cc4c9c193 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -76,7 +76,6 @@
 #define REG_OFF_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))
 
 struct pca9685 {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	struct mutex lock;
 	struct device *parent;
@@ -89,7 +88,7 @@ struct pca9685 {
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pca9685, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /* This function is supposed to be called with the lock mutex held */
@@ -133,9 +132,9 @@ static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsigned int
 }
 
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
-static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
+static void pca9685_pwm_set_duty(struct pwm_chip *chip, struct pca9685 *pca, int channel, unsigned int duty)
 {
-	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	struct pwm_device *pwm = &chip->pwms[channel];
 	unsigned int on, off;
 
 	if (duty == 0) {
@@ -172,9 +171,9 @@ static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int
 	pca9685_write_reg(pca, REG_OFF_H(channel), (off >> 8) & 0xf);
 }
 
-static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
+static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, struct pca9685 *pca, int channel)
 {
-	struct pwm_device *pwm = &pca->chip.pwms[channel];
+	struct pwm_device *pwm = &chip->pwms[channel];
 	unsigned int off = 0, on = 0, val = 0;
 
 	if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
@@ -248,7 +247,8 @@ static void pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
 
 static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
+	struct pca9685 *pca = to_pca(chip);
 
 	if (pca9685_pwm_test_and_set_inuse(pca, offset))
 		return -EBUSY;
@@ -258,24 +258,27 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 
 static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
+	struct pca9685 *pca = to_pca(chip);
 
-	return pca9685_pwm_get_duty(pca, offset) != 0;
+	return pca9685_pwm_get_duty(chip, pca, offset) != 0;
 }
 
 static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 				 int value)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
+	struct pca9685 *pca = to_pca(chip);
 
-	pca9685_pwm_set_duty(pca, offset, value ? PCA9685_COUNTER_RANGE : 0);
+	pca9685_pwm_set_duty(chip, pca, offset, value ? PCA9685_COUNTER_RANGE : 0);
 }
 
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_chip *chip = gpiochip_get_data(gpio);
+	struct pca9685 *pca = to_pca(chip);
 
-	pca9685_pwm_set_duty(pca, offset, 0);
+	pca9685_pwm_set_duty(chip, pca, offset, 0);
 	pm_runtime_put(pca->parent);
 	pca9685_pwm_clear_inuse(pca, offset);
 }
@@ -307,7 +310,7 @@ static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
  * expose a GPIO chip here which can exclusively take over the underlying
  * PWM channel.
  */
-static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
+static int pca9685_pwm_gpio_probe(struct pwm_chip *chip, struct pca9685 *pca)
 {
 	struct device *dev = pca->parent;
 
@@ -324,7 +327,7 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 	pca->gpio.ngpio = PCA9685_MAXCHAN;
 	pca->gpio.can_sleep = true;
 
-	return devm_gpiochip_add_data(dev, &pca->gpio, pca);
+	return devm_gpiochip_add_data(dev, &pca->gpio, chip);
 }
 #else
 static inline bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca,
@@ -338,7 +341,7 @@ pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
 {
 }
 
-static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
+static inline int pca9685_pwm_gpio_probe(struct pwm_chip *chip, struct pca9685 *pca)
 {
 	return 0;
 }
@@ -379,7 +382,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (!state->enabled) {
-		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+		pca9685_pwm_set_duty(chip, pca, pwm->hwpwm, 0);
 		return 0;
 	}
 
@@ -409,7 +412,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
 	duty = DIV_ROUND_UP_ULL(duty, state->period);
-	pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
+	pca9685_pwm_set_duty(chip, pca, pwm->hwpwm, duty);
 	return 0;
 }
 
@@ -463,7 +466,7 @@ static int pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	state->enabled = true;
-	duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
+	duty = pca9685_pwm_get_duty(chip, pca, pwm->hwpwm);
 	state->duty_cycle = DIV_ROUND_DOWN_ULL(duty * state->period, PCA9685_COUNTER_RANGE);
 
 	return 0;
@@ -493,7 +496,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pca9685 *pca = to_pca(chip);
 
 	mutex_lock(&pca->lock);
-	pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
+	pca9685_pwm_set_duty(chip, pca, pwm->hwpwm, 0);
 	clear_bit(pwm->hwpwm, pca->pwms_enabled);
 	mutex_unlock(&pca->lock);
 
@@ -517,13 +520,16 @@ static const struct regmap_config pca9685_regmap_i2c_config = {
 
 static int pca9685_pwm_probe(struct i2c_client *client)
 {
+	struct pwm_chip *chip;
 	struct pca9685 *pca;
 	unsigned int reg;
 	int ret;
 
-	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
-	if (!pca)
-		return -ENOMEM;
+	/* Add an extra channel for ALL_LED */
+	chip = devm_pwmchip_alloc(&client->dev, PCA9685_MAXCHAN + 1, sizeof(*pca));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pca = to_pca(chip);
 
 	pca->regmap = devm_regmap_init_i2c(client, &pca9685_regmap_i2c_config);
 	if (IS_ERR(pca->regmap)) {
@@ -533,7 +539,7 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	i2c_set_clientdata(client, pca);
+	i2c_set_clientdata(client, chip);
 
 	mutex_init(&pca->lock);
 
@@ -566,20 +572,17 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_L, 0);
 	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, LED_FULL);
 
-	pca->chip.ops = &pca9685_pwm_ops;
-	/* Add an extra channel for ALL_LED */
-	pca->chip.npwm = PCA9685_MAXCHAN + 1;
+	chip->ops = &pca9685_pwm_ops;
 
-	pca->chip.dev = &client->dev;
 	pca->parent = &client->dev;
 
-	ret = pwmchip_add(&pca->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return ret;
 
-	ret = pca9685_pwm_gpio_probe(pca);
+	ret = pca9685_pwm_gpio_probe(chip, pca);
 	if (ret < 0) {
-		pwmchip_remove(&pca->chip);
+		pwmchip_remove(chip);
 		return ret;
 	}
 
@@ -602,9 +605,10 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 
 static void pca9685_pwm_remove(struct i2c_client *client)
 {
-	struct pca9685 *pca = i2c_get_clientdata(client);
+	struct pwm_chip *chip = i2c_get_clientdata(client);
+	struct pca9685 *pca = to_pca(chip);
 
-	pwmchip_remove(&pca->chip);
+	pwmchip_remove(chip);
 
 	if (!pm_runtime_enabled(&client->dev)) {
 		/* Put chip in sleep state if runtime PM is disabled */
@@ -617,7 +621,8 @@ static void pca9685_pwm_remove(struct i2c_client *client)
 static int __maybe_unused pca9685_pwm_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct pca9685 *pca = i2c_get_clientdata(client);
+	struct pwm_chip *chip = i2c_get_clientdata(client);
+	struct pca9685 *pca = to_pca(chip);
 
 	pca9685_set_sleep_mode(pca, true);
 	return 0;
@@ -626,7 +631,8 @@ static int __maybe_unused pca9685_pwm_runtime_suspend(struct device *dev)
 static int __maybe_unused pca9685_pwm_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct pca9685 *pca = i2c_get_clientdata(client);
+	struct pwm_chip *chip = i2c_get_clientdata(client);
+	struct pca9685 *pca = to_pca(chip);
 
 	pca9685_set_sleep_mode(pca, false);
 	return 0;
-- 
2.42.0


