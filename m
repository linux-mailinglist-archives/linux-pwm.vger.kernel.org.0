Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC6D62E8
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2019 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfJNMsN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Oct 2019 08:48:13 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43729 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfJNMsM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Oct 2019 08:48:12 -0400
Received: from xps13.stephanxp.local (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 256BE240006;
        Mon, 14 Oct 2019 12:48:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de
Cc:     linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
Date:   Mon, 14 Oct 2019 14:48:03 +0200
Message-Id: <20191014124803.13661-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The MAX7313 chip is fully compatible with the PCA9535 on its basic
functions but can also manage the intensity on each of its ports with
PWM. Each output is independent and may be tuned with 16 values (4
bits per output). The period is always 32kHz, only the duty-cycle may
be changed. One can use any output as GPIO or PWM.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/gpio/gpio-pca953x.c | 249 +++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index de5d1383f28d..16b5a991b32e 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -18,12 +18,15 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/pca953x.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <asm/unaligned.h>
 
+#include "gpiolib.h"
+
 #define PCA953X_INPUT		0x00
 #define PCA953X_OUTPUT		0x01
 #define PCA953X_INVERT		0x02
@@ -63,11 +66,18 @@
 
 #define PCA_INT			BIT(8)
 #define PCA_PCAL		BIT(9)
+#define MAX_PWM			BIT(10)
 #define PCA_LATCH_INT		(PCA_PCAL | PCA_INT)
 #define PCA953X_TYPE		BIT(12)
 #define PCA957X_TYPE		BIT(13)
 #define PCA_TYPE_MASK		GENMASK(15, 12)
 
+#define MAX7313_MASTER		0x0E
+#define MAX7313_CONFIGURATION	0x0F
+#define MAX7313_INTENSITY	0x10
+
+#define MAX7313_GLOB_INTENSITY	BIT(2)
+
 #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
 
 static const struct i2c_device_id pca953x_id[] = {
@@ -93,7 +103,7 @@ static const struct i2c_device_id pca953x_id[] = {
 
 	{ "max7310", 8  | PCA953X_TYPE, },
 	{ "max7312", 16 | PCA953X_TYPE | PCA_INT, },
-	{ "max7313", 16 | PCA953X_TYPE | PCA_INT, },
+	{ "max7313", 16 | PCA953X_TYPE | PCA_INT | MAX_PWM, },
 	{ "max7315", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "max7318", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "pca6107", 8  | PCA953X_TYPE | PCA_INT, },
@@ -118,6 +128,16 @@ MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
 
 #define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)
 
+#define PWM_CHANNELS 16
+#define PWM_PER_REG 2
+#define PWM_BITS_PER_REG (8 / PWM_PER_REG)
+#define PWM_INTENSITY_MASK GENMASK(PWM_BITS_PER_REG - 1, 0)
+#define PWM_BANK_SZ (PWM_CHANNELS / PWM_PER_REG)
+
+#define PWM_PERIOD_NS 31250
+#define PWM_DC_STATES 16
+#define PWM_OFFSET_NS (PWM_PERIOD_NS / PWM_DC_STATES)
+
 struct pca953x_reg_config {
 	int direction;
 	int output;
@@ -139,6 +159,12 @@ static const struct pca953x_reg_config pca957x_regs = {
 	.invert = PCA957X_INVRT,
 };
 
+struct max7313_pwm {
+	struct pwm_chip chip;
+	struct gpio_desc *gpiods[PWM_CHANNELS];
+	unsigned int used;
+};
+
 struct pca953x_chip {
 	unsigned gpio_start;
 	struct mutex i2c_lock;
@@ -161,6 +187,8 @@ struct pca953x_chip {
 	struct regulator *regulator;
 
 	const struct pca953x_reg_config *regs;
+
+	struct max7313_pwm pwm;
 };
 
 static int pca953x_bank_shift(struct pca953x_chip *chip)
@@ -243,6 +271,13 @@ static bool pca953x_readable_register(struct device *dev, unsigned int reg)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 	u32 bank;
 
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
+	    chip->driver_data & MAX_PWM) {
+		if (reg >= MAX7313_MASTER &&
+		    reg < (MAX7313_INTENSITY + PWM_BANK_SZ))
+			return true;
+	}
+
 	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
 		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
 		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
@@ -266,6 +301,13 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 	u32 bank;
 
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
+	    chip->driver_data & MAX_PWM) {
+		if (reg >= MAX7313_MASTER &&
+		    reg < (MAX7313_INTENSITY + PWM_BANK_SZ))
+			return true;
+	}
+
 	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
 		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
 			PCA953x_BANK_CONFIG;
@@ -886,6 +928,206 @@ static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
 	return ret;
 }
 
+/* PWM specific methods */
+
+static struct max7313_pwm *to_max7313_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct max7313_pwm, chip);
+}
+
+static struct pca953x_chip *to_pca953x(struct max7313_pwm *chip)
+{
+	return container_of(chip, struct pca953x_chip, pwm);
+}
+
+static int max7313_pwm_set_intensity(struct pca953x_chip *chip,
+				     unsigned int idx, u8 duty_cycle)
+{
+	/* Duty-cycle is in the range [1;16] while registers expect [0;15] */
+	u8 intensity = (duty_cycle - 1) & PWM_INTENSITY_MASK;
+	unsigned int reg, off;
+	u8 val, mask;
+	int ret;
+
+	reg = MAX7313_INTENSITY + (idx / PWM_PER_REG);
+	off = (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
+
+	mask = PWM_INTENSITY_MASK << off;
+	val = intensity << off;
+
+	mutex_lock(&chip->i2c_lock);
+	ret = regmap_write_bits(chip->regmap, reg, mask, val);
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
+}
+
+static int max7313_pwm_disable(struct pca953x_chip *chip, unsigned int idx)
+{
+	return pca953x_gpio_direction_input(&chip->gpio_chip, idx);
+}
+
+static int max7313_pwm_enable_static_low(struct pca953x_chip *chip,
+					 unsigned int idx)
+{
+	/*
+	 * For a given PWM channel, when the blink phase 0 bit is set, the
+	 * intensity range is only [1/16;16/16]. With this range, a static low
+	 * output is physically not possible. When the blink phase 0 bit is
+	 * cleared, the intensity range is [15/16;0/16] which then allows a
+	 * static low output but not a static high output.
+	 *
+	 * In this driver we choose to set the blink phase 0 bit by default,
+	 * hence we can slide from a low output to a fully high output without
+	 * glitch. However,  The only way to get a static low output is by
+	 * clearing the blink phase 0 bit, and by changing the intensity value
+	 * to its maximum (as, at this moment, intensity is reversed). There is
+	 * no way to atomically flip the register *and* change the PWM value at
+	 * the same time so this operation will produce a small glitch.
+	 */
+
+	/* Invert the the PWM phase */
+	pca953x_gpio_direction_output(&chip->gpio_chip, idx, 0);
+
+	/* Maximize the low time */
+	return max7313_pwm_set_intensity(chip, idx, PWM_DC_STATES);
+}
+
+static int max7313_pwm_enable(struct pca953x_chip *chip, unsigned int idx,
+			      unsigned int duty_cycle)
+{
+	/* PWM phase must not be inverted to work in the [1/16;16/16] range */
+	pca953x_gpio_direction_output(&chip->gpio_chip, idx, 1);
+
+	/* Set the PWM intensity to the desired duty-cycle */
+	return max7313_pwm_set_intensity(chip, idx, duty_cycle);
+}
+
+static int max7313_pwm_request(struct pwm_chip *pwm_chip,
+			       struct pwm_device *pwm_device)
+{
+	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
+	struct pca953x_chip *chip = to_pca953x(pwm);
+	int idx = pwm_device->hwpwm;
+	struct gpio_desc *desc;
+	int ret;
+
+	if (pwm->gpiods[idx]) {
+		ret = -EBUSY;
+	} else {
+		desc = gpio_to_desc(chip->gpio_chip.base + idx);
+		if (!desc)
+			return -ENODEV;
+
+		ret = gpiod_request(desc, "max7313-pwm");
+		if (ret)
+			return ret;
+
+		pwm->gpiods[idx] = desc;
+	}
+
+	ret = max7313_pwm_disable(chip, idx);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set master intensity to the maximum level to let individual outputs
+	 * the greatest flexibility range. Also enables the internal oscillator.
+	 */
+	if (!pwm->used) {
+		mutex_lock(&chip->i2c_lock);
+		ret = regmap_write_bits(chip->regmap, MAX7313_MASTER,
+					PWM_INTENSITY_MASK << PWM_BITS_PER_REG,
+					PWM_INTENSITY_MASK << PWM_BITS_PER_REG);
+		mutex_unlock(&chip->i2c_lock);
+		if (ret)
+			return ret;
+	}
+
+	pwm->used++;
+
+	return 0;
+}
+
+static void max7313_pwm_free(struct pwm_chip *pwm_chip,
+			     struct pwm_device *pwm_device)
+{
+	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
+	struct pca953x_chip *chip = to_pca953x(pwm);
+	int idx = pwm_device->hwpwm;
+
+	max7313_pwm_disable(chip, idx);
+	pwm->used--;
+
+	/* Disable the internal oscillator if no channel is in use */
+	if (!pwm->used) {
+		mutex_lock(&chip->i2c_lock);
+		regmap_write_bits(chip->regmap, MAX7313_MASTER,
+				  PWM_INTENSITY_MASK << PWM_BITS_PER_REG, 0);
+		mutex_unlock(&chip->i2c_lock);
+	}
+
+	gpiod_free(pwm->gpiods[idx]);
+	pwm->gpiods[idx] = NULL;
+}
+
+static int max7313_pwm_apply(struct pwm_chip *pwm_chip,
+			     struct pwm_device *pwm_device,
+			     const struct pwm_state *state)
+{
+	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
+	struct pca953x_chip *chip = to_pca953x(pwm);
+	int idx = pwm_device->hwpwm;
+	unsigned int duty_cycle;
+
+	if (!state->enabled)
+		return max7313_pwm_disable(chip, idx);
+
+	if (!state->period || !state->duty_cycle)
+		return max7313_pwm_enable_static_low(chip, idx);
+
+	/* Convert the duty-cycle to be in the [1;16] range */
+	duty_cycle = DIV_ROUND_UP(state->duty_cycle * PWM_DC_STATES,
+				  state->period);
+
+	return max7313_pwm_enable(chip, idx, duty_cycle);
+}
+
+static const struct pwm_ops max7313_pwm_ops = {
+	.request = max7313_pwm_request,
+	.free = max7313_pwm_free,
+	.apply = max7313_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static int max7313_pwm_probe(struct device *dev,
+			     struct pca953x_chip *chip)
+{
+	struct max7313_pwm *pwm = &chip->pwm;
+	struct pwm_chip *pwm_chip = &pwm->chip;
+	int ret;
+
+	if (!(chip->driver_data & MAX_PWM))
+		return 0;
+
+	pwm_chip->dev = dev;
+	pwm_chip->ops = &max7313_pwm_ops;
+	pwm_chip->npwm = chip->gpio_chip.ngpio;
+	pwm_chip->base = -1;
+
+	/* Disable global control */
+	mutex_lock(&chip->i2c_lock);
+	ret = regmap_write_bits(chip->regmap, MAX7313_CONFIGURATION,
+				MAX7313_GLOB_INTENSITY, 0);
+	mutex_unlock(&chip->i2c_lock);
+	if (ret)
+		return ret;
+
+	ret = pwmchip_add(pwm_chip);
+
+	return ret;
+}
+
 static const struct of_device_id pca953x_dt_ids[];
 
 static int pca953x_probe(struct i2c_client *client,
@@ -1018,6 +1260,9 @@ static int pca953x_probe(struct i2c_client *client,
 			dev_warn(&client->dev, "setup failed, %d\n", ret);
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		return max7313_pwm_probe(&client->dev, chip);
+
 	return 0;
 
 err_exit:
@@ -1162,7 +1407,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 
 	{ .compatible = "maxim,max7310", .data = OF_953X( 8, 0), },
 	{ .compatible = "maxim,max7312", .data = OF_953X(16, PCA_INT), },
-	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT), },
+	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT | MAX_PWM), },
 	{ .compatible = "maxim,max7315", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "maxim,max7318", .data = OF_953X(16, PCA_INT), },
 
-- 
2.20.1

