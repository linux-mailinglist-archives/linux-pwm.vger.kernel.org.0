Return-Path: <linux-pwm+bounces-3766-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F049ABA06
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 01:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A51B2303C
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527A1CEADD;
	Tue, 22 Oct 2024 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffzmv4lu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E061CEAAC;
	Tue, 22 Oct 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639290; cv=none; b=c/6/1L56aGjfUouQR4RfHmm6aAyvxrJtgbL2Z/0XcWybRy/xVsAb8i+hBDHtVKBebgMdfTgD7Qr+5eS9wRIohcq/XX14O0aisa04Q0ZlOf8JP3GTmYeE1JGi2RZL3DTcJwHQJd5Cdlbxz4/OfYkxLYhYLkp0sLMTC0Wp621S+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639290; c=relaxed/simple;
	bh=b2fyck5U2RVUdu3fpFkx0Ro+4NjFb7pDaMEmsa8plgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwLaAqoaBfLTs29wO+1yXio41WYmSHdJX5j+YesUfDtyI78tSTAdTbgBONUpcCJ2mUSulBiFeGZktbDQBxMguCn7J98E+9qm3HNXNY8/mwETVpzByXCzXm1IYdvPb9KssCIn6lztCln9DO9OFuxFs6LajPFWIBnLTUkJt6Pzd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffzmv4lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA35CC4CEC3;
	Tue, 22 Oct 2024 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729639289;
	bh=b2fyck5U2RVUdu3fpFkx0Ro+4NjFb7pDaMEmsa8plgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ffzmv4luZWjFgajxI0EY34q7MfVmKfHCe+Tsnc4Uz1119HTWyORxqXstgQMnGcymL
	 QaFjXlG/JE2aQXyCwXbgFFK+CO4LvN7h0hje0GDmteAmQXkLz4cLywOqo4Vw4abj5I
	 A5LZEBRiuFgWmvhS+wH7cm2FfydJW5L90igWNOhXpXE9SF2A/6l6K/2SRiJqwDTdUH
	 T9ypYdlI9Vq55k2IXpREG8O11uu2Ezj0T/mdmKjARmJnQ9Yy/GwF75RBURaakGV+pZ
	 eUFI59hXtO0nuyXItx1rrZFtWNu+3fcomNXNBsjUYvoUdDrDnNOryoMb5MSkZFVZQP
	 fsPaOc5VyYKRg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 23 Oct 2024 01:20:06 +0200
Subject: [PATCH v9 6/6] pwm: airoha: Add support for EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-en7581-pinctrl-v9-6-afb0cbcab0ec@kernel.org>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
In-Reply-To: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.2

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

Introduce driver for PWM module available on EN7581 SoC.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-airoha.c | 386 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16d451e987dcc5f10e0b57edc32ee1..99aa87136c272555c10102590fcf9f911161c3d3 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -54,6 +54,17 @@ config PWM_ADP5585
 	  This option enables support for the PWM function found in the Analog
 	  Devices ADP5585.
 
+config PWM_AIROHA
+	tristate "Airoha PWM support"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on OF
+	select REGMAP_MMIO
+	help
+	  Generic PWM framework driver for Airoha SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-airoha.
+
 config PWM_APPLE
 	tristate "Apple SoC PWM support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e09713fe05479c257eebe5f02b91e9..fbf7723d845807fd1e2893c6ea4f736785841b0d 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
+obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
new file mode 100644
index 0000000000000000000000000000000000000000..658884852e7ad7a76ff499879eda9c50dfc5f745
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
+ *
+ *  Limitations:
+ *  - No disable bit, so a disabled PWM is simulated by setting duty_cycle to 0
+ *  - Only 8 concurrent waveform generators are available for 8 combinations of
+ *    duty_cycle and period. Waveform generators are shared between 16 GPIO
+ *    pins and 17 SIPO GPIO pins.
+ *  - Supports only normal polarity.
+ *  - On configuration the currently running period is completed.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/gpio.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <asm/div64.h>
+
+#define REG_SGPIO_LED_DATA		0x0024
+#define SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
+#define SGPIO_LED_DATA_DATA		GENMASK(16, 0)
+
+#define REG_SGPIO_CLK_DIVR		0x0028
+#define REG_SGPIO_CLK_DIVR_MASK		GENMASK(1, 0)
+#define REG_SGPIO_CLK_DLY		0x002c
+
+#define REG_SIPO_FLASH_MODE_CFG		0x0030
+#define SERIAL_GPIO_FLASH_MODE		BIT(1)
+#define SERIAL_GPIO_MODE_74HC164	BIT(0)
+
+#define REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + ((_n) << 2))
+#define GPIO_FLASH_PRD_MASK(_n)		GENMASK(15 + ((_n) << 4), ((_n) << 4))
+
+#define REG_GPIO_FLASH_MAP(_n)		(0x004c + ((_n) << 2))
+#define GPIO_FLASH_SETID_MASK(_n)	GENMASK(2 + ((_n) << 2), ((_n) << 2))
+#define GPIO_FLASH_EN(_n)		BIT(3 + ((_n) << 2))
+
+#define REG_SIPO_FLASH_MAP(_n)		(0x0054 + ((_n) << 2))
+
+#define REG_CYCLE_CFG_VALUE(_n)		(0x0098 + ((_n) << 2))
+#define WAVE_GEN_CYCLE_MASK(_n)		GENMASK(7 + ((_n) << 3), ((_n) << 3))
+
+#define PWM_NUM_BUCKETS			8
+
+struct airoha_pwm_bucket {
+	/* Bitmask of PWM channels using this bucket */
+	u64 used;
+	u64 period_ns;
+	u64 duty_ns;
+};
+
+struct airoha_pwm {
+	struct regmap *regmap;
+
+	struct device_node *np;
+	u64 initialized;
+
+	struct airoha_pwm_bucket bucket[PWM_NUM_BUCKETS];
+};
+
+/*
+ * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
+ * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels, 16-32.
+ * However, we've only got 8 concurrent waveform generators and can therefore
+ * only use up to 8 different combinations of duty cycle and period at a time.
+ */
+#define PWM_NUM_GPIO	16
+#define PWM_NUM_SIPO	17
+
+/* The PWM hardware supports periods between 4 ms and 1 s */
+#define PERIOD_MIN_NS	(4 * NSEC_PER_MSEC)
+#define PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
+/* It is represented internally as 1/250 s between 1 and 250 */
+#define PERIOD_MIN	1
+#define PERIOD_MAX	250
+/* Duty cycle is relative with 255 corresponding to 100% */
+#define DUTY_FULL	255
+
+static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
+				    u64 period_ns)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pc->bucket); i++) {
+		if (!pc->bucket[i].used)
+			continue;
+
+		if (duty_ns == pc->bucket[i].duty_ns &&
+		    period_ns == pc->bucket[i].period_ns)
+			return i;
+
+		/*
+		 * Unlike duty cycle zero, which can be handled by
+		 * disabling PWM, a generator is needed for full duty
+		 * cycle but it can be reused regardless of period
+		 */
+		if (duty_ns == DUTY_FULL && pc->bucket[i].duty_ns == DUTY_FULL)
+			return i;
+	}
+
+	return -1;
+}
+
+static void airoha_pwm_release_bucket_config(struct airoha_pwm *pc,
+					     unsigned int hwpwm)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pc->bucket); i++)
+		pc->bucket[i].used &= ~BIT_ULL(hwpwm);
+}
+
+static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
+					u64 duty_ns, u64 period_ns,
+					unsigned int hwpwm)
+{
+	int id = airoha_pwm_get_generator(pc, duty_ns, period_ns);
+
+	if (id < 0) {
+		int i;
+
+		/* find an unused waveform generator */
+		for (i = 0; i < ARRAY_SIZE(pc->bucket); i++) {
+			if (!(pc->bucket[i].used & ~BIT_ULL(hwpwm))) {
+				id = i;
+				break;
+			}
+		}
+	}
+
+	if (id >= 0) {
+		airoha_pwm_release_bucket_config(pc, hwpwm);
+		pc->bucket[id].used |= BIT_ULL(hwpwm);
+		pc->bucket[id].period_ns = period_ns;
+		pc->bucket[id].duty_ns = duty_ns;
+	}
+
+	return id;
+}
+
+static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
+{
+	u32 val;
+
+	if (!(pc->initialized >> PWM_NUM_GPIO))
+		return 0;
+
+	regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
+			  SERIAL_GPIO_MODE_74HC164);
+
+	/* Configure shift register timings, use 32x divisor */
+	regmap_write(pc->regmap, REG_SGPIO_CLK_DIVR,
+		     FIELD_PREP(REG_SGPIO_CLK_DIVR_MASK, 0x3));
+
+	/*
+	 * The actual delay is clock + 1.
+	 * Notice that clock delay should not be greater
+	 * than (divisor / 2) - 1.
+	 * Set to 0 by default. (aka 1)
+	 */
+	regmap_write(pc->regmap, REG_SGPIO_CLK_DLY, 0x0);
+
+	/*
+	 * It it necessary to after muxing explicitly shift out all
+	 * zeroes to initialize the shift register before enabling PWM
+	 * mode because in PWM mode SIPO will not start shifting until
+	 * it needs to output a non-zero value (bit 31 of led_data
+	 * indicates shifting in progress and it must return to zero
+	 * before led_data can be written or PWM mode can be set)
+	 */
+	if (regmap_read_poll_timeout(pc->regmap, REG_SGPIO_LED_DATA, val,
+				     !(val & SGPIO_LED_DATA_SHIFT_FLAG), 10,
+				     200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	regmap_clear_bits(pc->regmap, REG_SGPIO_LED_DATA, SGPIO_LED_DATA_DATA);
+	if (regmap_read_poll_timeout(pc->regmap, REG_SGPIO_LED_DATA, val,
+				     !(val & SGPIO_LED_DATA_SHIFT_FLAG), 10,
+				     200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	/* Set SIPO in PWM mode */
+	regmap_set_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
+			SERIAL_GPIO_FLASH_MODE);
+
+	return 0;
+}
+
+static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int index,
+					  u64 duty_ns, u64 period_ns)
+{
+	u32 period, duty, mask, val;
+	u64 tmp;
+
+	tmp = duty_ns * DUTY_FULL;
+	duty = clamp_val(div64_u64(tmp, period_ns), 0, DUTY_FULL);
+	tmp = period_ns * 25;
+	period = clamp_val(div64_u64(tmp, 100000000), PERIOD_MIN, PERIOD_MAX);
+
+	/* Configure frequency divisor */
+	mask = WAVE_GEN_CYCLE_MASK(index % 4);
+	val = (period << __ffs(mask)) & mask;
+	regmap_update_bits(pc->regmap, REG_CYCLE_CFG_VALUE(index / 4),
+			   mask, val);
+
+	/* Configure duty cycle */
+	duty = ((DUTY_FULL - duty) << 8) | duty;
+	mask = GPIO_FLASH_PRD_MASK(index % 2);
+	val = (duty << __ffs(mask)) & mask;
+	regmap_update_bits(pc->regmap, REG_GPIO_FLASH_PRD_SET(index / 2),
+			   mask, val);
+}
+
+static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
+					unsigned int hwpwm, int index)
+{
+	u32 addr, mask, val;
+
+	if (hwpwm < PWM_NUM_GPIO) {
+		addr = REG_GPIO_FLASH_MAP(hwpwm / 8);
+	} else {
+		addr = REG_SIPO_FLASH_MAP(hwpwm / 8);
+		hwpwm -= PWM_NUM_GPIO;
+	}
+
+	if (index < 0) {
+		/*
+		 * Change of waveform takes effect immediately but
+		 * disabling has some delay so to prevent glitching
+		 * only the enable bit is touched when disabling
+		 */
+		regmap_clear_bits(pc->regmap, addr, GPIO_FLASH_EN(hwpwm % 8));
+		return;
+	}
+
+	mask = GPIO_FLASH_SETID_MASK(hwpwm % 8);
+	val = ((index & 7) << __ffs(mask)) & mask;
+	regmap_update_bits(pc->regmap, addr, mask, val);
+	regmap_set_bits(pc->regmap, addr, GPIO_FLASH_EN(hwpwm % 8));
+}
+
+static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
+			     u64 duty_ns, u64 period_ns)
+{
+	int index = -1;
+
+	index = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
+					     pwm->hwpwm);
+	if (index < 0)
+		return -EBUSY;
+
+	if (!(pc->initialized & BIT_ULL(pwm->hwpwm)) &&
+	    pwm->hwpwm >= PWM_NUM_GPIO)
+		airoha_pwm_sipo_init(pc);
+
+	if (index >= 0) {
+		airoha_pwm_calc_bucket_config(pc, index, duty_ns, period_ns);
+		airoha_pwm_config_flash_map(pc, pwm->hwpwm, index);
+	} else {
+		airoha_pwm_config_flash_map(pc, pwm->hwpwm, index);
+		airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
+	}
+
+	pc->initialized |= BIT_ULL(pwm->hwpwm);
+
+	return 0;
+}
+
+static void airoha_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+
+	/* Disable PWM and release the waveform */
+	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
+	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
+
+	pc->initialized &= ~BIT_ULL(pwm->hwpwm);
+	if (!(pc->initialized >> PWM_NUM_GPIO))
+		regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
+				  SERIAL_GPIO_FLASH_MODE);
+}
+
+static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+	u64 duty = state->enabled ? state->duty_cycle : 0;
+	u64 period = state->period;
+
+	/* Only normal polarity is supported */
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		airoha_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	if (period < PERIOD_MIN_NS)
+		return -EINVAL;
+
+	if (period > PERIOD_MAX_NS)
+		period = PERIOD_MAX_NS;
+
+	return airoha_pwm_config(pc, pwm, duty, period);
+}
+
+static int airoha_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+	int i;
+
+	/* find hwpwm in waveform generator bucket */
+	for (i = 0; i < ARRAY_SIZE(pc->bucket); i++) {
+		if (pc->bucket[i].used & BIT_ULL(pwm->hwpwm)) {
+			state->enabled = pc->initialized & BIT_ULL(pwm->hwpwm);
+			state->polarity = PWM_POLARITY_NORMAL;
+			state->period = pc->bucket[i].period_ns;
+			state->duty_cycle = pc->bucket[i].duty_ns;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(pc->bucket))
+		state->enabled = false;
+
+	return 0;
+}
+
+static const struct pwm_ops airoha_pwm_ops = {
+	.get_state = airoha_pwm_get_state,
+	.apply = airoha_pwm_apply,
+};
+
+static int airoha_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct airoha_pwm *pc;
+	struct pwm_chip *chip;
+
+	chip = devm_pwmchip_alloc(dev, PWM_NUM_GPIO + PWM_NUM_SIPO,
+				  sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	chip->ops = &airoha_pwm_ops;
+	pc = pwmchip_get_drvdata(chip);
+	pc->np = dev->of_node;
+
+	pc->regmap = device_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(pc->regmap))
+		return PTR_ERR(pc->regmap);
+
+	return devm_pwmchip_add(&pdev->dev, chip);
+}
+
+static const struct of_device_id airoha_pwm_of_match[] = {
+	{ .compatible = "airoha,en7581-pwm" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, airoha_pwm_of_match);
+
+static struct platform_driver airoha_pwm_driver = {
+	.driver = {
+		.name = "pwm-airoha",
+		.of_match_table = airoha_pwm_of_match,
+	},
+	.probe = airoha_pwm_probe,
+};
+module_platform_driver(airoha_pwm_driver);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_AUTHOR("Markus Gothe <markus.gothe@genexis.eu>");
+MODULE_AUTHOR("Benjamin Larsson <benjamin.larsson@genexis.eu>");
+MODULE_DESCRIPTION("Airoha EN7581 PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.47.0


