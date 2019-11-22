Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADED710716A
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2019 12:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKVLch (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Nov 2019 06:32:37 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57375 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVLcg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Nov 2019 06:32:36 -0500
X-Originating-IP: 90.76.211.102
Received: from localhost.localdomain (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8B50F6000B;
        Fri, 22 Nov 2019 11:32:33 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de
Cc:     linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
Date:   Fri, 22 Nov 2019 12:32:30 +0100
Message-Id: <20191122113230.16486-1-miquel.raynal@bootlin.com>
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

Changes in v3:
* Added two error messages in ->request().
* Protected the PWM count agains races with an additional mutex.
* Dropped an useless check on the period value in ->apply().
* Forced the .period to be constant.
* Checked state->polarity when needed.
* Used DIV_ROUND_DOWN_ULL for computing the duty_cycle.
* Implemented ->get_state().
* Added a comment to explain that the GPIO functionality is not harmed
  by the global intensity setting.

Changes in v2:
* Removed the hardcoding of PWM_CHANNELS, changed the code to use the
  number of GPIO lines which is programatically known.
* Used per pwm_device chip data to store the GPIO descriptors instead
  of having a static array of GPIO descriptors in the private PWM
  structure. It also enhanced the readability.
* Rename an offset variable: s/off/shift/.
* The default PWM state is now static low instead of input.
* Used the GPIO as regular consumer thanks to the stored GPIO
  descriptors to "make it more idiomatic" (requested by Thierry).
* Used gpiochip_request_own_desc() instead of
  gpio_to_desc()/gpiod_request(). This prevented the build issue and
  an additional dependency that would have requested a DEPENDS ON line
  in Kconfig.
* Enhanced the return line of max7313_pwm_probe().


 drivers/gpio/gpio-pca953x.c | 332 +++++++++++++++++++++++++++++++++++-
 1 file changed, 330 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index de5d1383f28d..baf639bec18d 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -12,18 +12,22 @@
 #include <linux/bits.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
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
@@ -63,11 +67,18 @@
 
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
@@ -93,7 +104,7 @@ static const struct i2c_device_id pca953x_id[] = {
 
 	{ "max7310", 8  | PCA953X_TYPE, },
 	{ "max7312", 16 | PCA953X_TYPE | PCA_INT, },
-	{ "max7313", 16 | PCA953X_TYPE | PCA_INT, },
+	{ "max7313", 16 | PCA953X_TYPE | PCA_INT | MAX_PWM, },
 	{ "max7315", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "max7318", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "pca6107", 8  | PCA953X_TYPE | PCA_INT, },
@@ -118,6 +129,14 @@ MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
 
 #define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)
 
+#define PWM_PER_REG 2
+#define PWM_BITS_PER_REG (8 / PWM_PER_REG)
+#define PWM_INTENSITY_MASK GENMASK(PWM_BITS_PER_REG - 1, 0)
+
+#define PWM_PERIOD_NS 31250
+#define PWM_DC_STATES 16
+#define PWM_OFFSET_NS (PWM_PERIOD_NS / PWM_DC_STATES)
+
 struct pca953x_reg_config {
 	int direction;
 	int output;
@@ -139,6 +158,22 @@ static const struct pca953x_reg_config pca957x_regs = {
 	.invert = PCA957X_INVRT,
 };
 
+struct max7313_pwm_data {
+	struct gpio_desc *desc;
+	bool enabled;
+	unsigned int duty_cycle;
+};
+
+struct max7313_pwm {
+	struct pwm_chip chip;
+	/*
+	 * Protect races when counting active PWMs for enabling or disabling
+	 * the internal oscillator.
+	 */
+	struct mutex count_lock;
+	unsigned int count;
+};
+
 struct pca953x_chip {
 	unsigned gpio_start;
 	struct mutex i2c_lock;
@@ -161,6 +196,8 @@ struct pca953x_chip {
 	struct regulator *regulator;
 
 	const struct pca953x_reg_config *regs;
+
+	struct max7313_pwm pwm;
 };
 
 static int pca953x_bank_shift(struct pca953x_chip *chip)
@@ -241,8 +278,16 @@ static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
 static bool pca953x_readable_register(struct device *dev, unsigned int reg)
 {
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
+	unsigned int bank_sz = chip->driver_data & PCA_GPIO_MASK;
 	u32 bank;
 
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
+	    chip->driver_data & MAX_PWM) {
+		if (reg >= MAX7313_MASTER &&
+		    reg < (MAX7313_INTENSITY + bank_sz))
+			return true;
+	}
+
 	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
 		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
 		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
@@ -264,8 +309,16 @@ static bool pca953x_readable_register(struct device *dev, unsigned int reg)
 static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
 {
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
+	unsigned int bank_sz = chip->driver_data & PCA_GPIO_MASK;
 	u32 bank;
 
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
+	    chip->driver_data & MAX_PWM) {
+		if (reg >= MAX7313_MASTER &&
+		    reg < (MAX7313_INTENSITY + bank_sz))
+			return true;
+	}
+
 	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
 		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
 			PCA953x_BANK_CONFIG;
@@ -886,6 +939,278 @@ static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
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
+static u8 max7313_pwm_get_intensity(struct pca953x_chip *chip,
+				    unsigned int idx)
+{
+	unsigned int reg, shift, val;
+	u8 duty_cycle;
+
+	reg = MAX7313_INTENSITY + (idx / PWM_PER_REG);
+	shift = (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
+
+	mutex_lock(&chip->i2c_lock);
+	regmap_read(chip->regmap, reg, &val);
+	mutex_unlock(&chip->i2c_lock);
+
+	if (shift)
+		val >>= shift;
+
+	val &= PWM_INTENSITY_MASK;
+
+	/*
+	 * Register values in the [0;15] range mean a value in the [1;16] range.
+	 * A register value of 16 means the logic has been inverted to produce a
+	 * static low output.
+	 */
+	if (val == PWM_INTENSITY_MASK)
+		duty_cycle = 0;
+	else
+		duty_cycle = val + 1;
+
+	return duty_cycle;
+}
+
+static int max7313_pwm_set_intensity(struct pca953x_chip *chip,
+				     unsigned int idx, u8 duty_cycle)
+{
+	/* Duty-cycle is in the range [1;16] while registers expect [0;15] */
+	u8 intensity = (duty_cycle - 1) & PWM_INTENSITY_MASK;
+	unsigned int reg, shift;
+	u8 val, mask;
+	int ret;
+
+	reg = MAX7313_INTENSITY + (idx / PWM_PER_REG);
+	shift = (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
+
+	mask = PWM_INTENSITY_MASK << shift;
+	val = intensity << shift;
+
+	mutex_lock(&chip->i2c_lock);
+	ret = regmap_write_bits(chip->regmap, reg, mask, val);
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
+}
+
+/*
+ * For a given PWM channel, when the blink phase 0 bit is set, the intensity
+ * range is only [1/16;16/16]. With this range, a static low output is
+ * physically not possible. When the blink phase 0 bit is cleared, the intensity
+ * range is [15/16;0/16] which then allows a static low output but not a static
+ * high output.
+ *
+ * In this driver we choose to set the blink phase 0 bit by default, hence we
+ * can slide from a low output to a fully high output without glitch. However,
+ * the only way to get a static low output is by clearing the blink phase 0 bit,
+ * and by changing the intensity value to its maximum (as, at this moment,
+ * intensity is reversed). There is no way to atomically flip the register *and*
+ * change the PWM value at the same time so this will produce a small glitch.
+ */
+static int max7313_pwm_set_state(struct pca953x_chip *chip,
+				 struct pwm_device *pwm_device,
+				 unsigned int duty_cycle)
+{
+	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
+	struct gpio_desc *desc = data->desc;
+	int ret;
+
+	/* A null duty_cycle will invert the phase */
+	ret = gpiod_direction_output(desc, duty_cycle);
+	if (ret)
+		return ret;
+
+	/* Maximize the low time in case of static low state */
+	if (!duty_cycle)
+		duty_cycle = PWM_DC_STATES;
+
+	return max7313_pwm_set_intensity(chip, pwm_device->hwpwm, duty_cycle);
+}
+
+static int max7313_pwm_request(struct pwm_chip *pwm_chip,
+			       struct pwm_device *pwm_device)
+{
+	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
+	struct pca953x_chip *chip = to_pca953x(pwm);
+	struct max7313_pwm_data *data;
+	struct gpio_desc *desc;
+	int ret;
+
+	desc = gpiochip_request_own_desc(&chip->gpio_chip, pwm_device->hwpwm,
+					 "max7313-pwm", GPIO_ACTIVE_HIGH,
+					 GPIOD_OUT_LOW);
+	if (IS_ERR(desc)) {
+		dev_err(&chip->client->dev,
+			"pin already in use (probably as GPIO)\n");
+		return PTR_ERR(desc);
+	}
+
+	data = devm_kzalloc(&chip->client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->desc = desc;
+	pwm_set_chip_data(pwm_device, data);
+
+	ret = max7313_pwm_set_state(chip, pwm_device, 0);
+	if (ret) {
+		dev_err(&chip->client->dev, "cannot set PWM default state\n");
+		goto free_gpiod;
+	}
+
+	/*
+	 * Set master intensity to the maximum level to let individual outputs
+	 * the greatest flexibility range. Also enables the internal oscillator.
+	 */
+	mutex_lock(&pwm->count_lock);
+	if (!pwm->count) {
+		mutex_lock(&chip->i2c_lock);
+		ret = regmap_write_bits(chip->regmap, MAX7313_MASTER,
+					PWM_INTENSITY_MASK << PWM_BITS_PER_REG,
+					PWM_INTENSITY_MASK << PWM_BITS_PER_REG);
+		mutex_unlock(&chip->i2c_lock);
+	}
+
+	if (!ret)
+		pwm->count++;
+
+	mutex_unlock(&pwm->count_lock);
+
+	if (ret)
+		goto free_gpiod;
+
+	return 0;
+
+free_gpiod:
+	gpiochip_free_own_desc(data->desc);
+
+	return ret;
+}
+
+static void max7313_pwm_free(struct pwm_chip *pwm_chip,
+			     struct pwm_device *pwm_device)
+{
+	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
+	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
+	struct pca953x_chip *chip = to_pca953x(pwm);
+
+	max7313_pwm_set_state(chip, pwm_device, 0);
+
+	mutex_lock(&pwm->count_lock);
+
+	pwm->count--;
+
+	/* Disable the internal oscillator if no channel is in use */
+	if (!pwm->count) {
+		mutex_lock(&chip->i2c_lock);
+		regmap_write_bits(chip->regmap, MAX7313_MASTER,
+				  PWM_INTENSITY_MASK << PWM_BITS_PER_REG, 0);
+		mutex_unlock(&chip->i2c_lock);
+	}
+
+	mutex_unlock(&pwm->count_lock);
+
+	gpiochip_free_own_desc(data->desc);
+}
+
+static int max7313_pwm_apply(struct pwm_chip *pwm_chip,
+			     struct pwm_device *pwm_device,
+			     const struct pwm_state *state)
+{
+	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
+	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
+	struct pca953x_chip *chip = to_pca953x(pwm);
+	unsigned int duty_cycle;
+
+	if (state->period != PWM_PERIOD_NS ||
+	    state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	data->enabled = state->enabled;
+	data->duty_cycle = state->duty_cycle;
+
+	if (!state->enabled || !state->duty_cycle)
+		duty_cycle = 0;
+	else
+		/* Convert the duty-cycle to be in the [1;16] range */
+		duty_cycle = DIV_ROUND_DOWN_ULL(state->duty_cycle,
+						PWM_OFFSET_NS);
+
+	/* The hardware is supposedly glitch-free */
+	return max7313_pwm_set_state(chip, pwm_device, duty_cycle);
+}
+
+static void max7313_pwm_get_state(struct pwm_chip *pwm_chip,
+				  struct pwm_device *pwm_device,
+				  struct pwm_state *state)
+{
+	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
+	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
+	struct pca953x_chip *chip = to_pca953x(pwm);
+	u8 duty_cycle;
+
+	state->period = PWM_PERIOD_NS;
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	if (!data)
+		return;
+
+	state->enabled = data->enabled;
+	if (!state->enabled) {
+		state->duty_cycle = data->duty_cycle;
+	} else {
+		duty_cycle = max7313_pwm_get_intensity(chip, pwm_device->hwpwm);
+		state->duty_cycle = duty_cycle * PWM_OFFSET_NS;
+	}
+};
+
+static const struct pwm_ops max7313_pwm_ops = {
+	.request = max7313_pwm_request,
+	.free = max7313_pwm_free,
+	.apply = max7313_pwm_apply,
+	.get_state = max7313_pwm_get_state,
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
+	/* Disable global control (does not affect GPIO functionality) */
+	mutex_lock(&chip->i2c_lock);
+	ret = regmap_write_bits(chip->regmap, MAX7313_CONFIGURATION,
+				MAX7313_GLOB_INTENSITY, 0);
+	mutex_unlock(&chip->i2c_lock);
+	if (ret)
+		return ret;
+
+	mutex_init(&pwm->count_lock);
+
+	return pwmchip_add(pwm_chip);
+}
+
 static const struct of_device_id pca953x_dt_ids[];
 
 static int pca953x_probe(struct i2c_client *client,
@@ -1018,6 +1343,9 @@ static int pca953x_probe(struct i2c_client *client,
 			dev_warn(&client->dev, "setup failed, %d\n", ret);
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		return max7313_pwm_probe(&client->dev, chip);
+
 	return 0;
 
 err_exit:
@@ -1162,7 +1490,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 
 	{ .compatible = "maxim,max7310", .data = OF_953X( 8, 0), },
 	{ .compatible = "maxim,max7312", .data = OF_953X(16, PCA_INT), },
-	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT), },
+	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT | MAX_PWM), },
 	{ .compatible = "maxim,max7315", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "maxim,max7318", .data = OF_953X(16, PCA_INT), },
 
-- 
2.20.1

