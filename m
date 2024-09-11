Return-Path: <linux-pwm+bounces-3202-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F8975B18
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137411F23E09
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42021BAECD;
	Wed, 11 Sep 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCf5aaxs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4A17DFFC;
	Wed, 11 Sep 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084279; cv=none; b=MYE/hUFFvj5f1GkDkTXcZlYaQsIAo3LezCnlHY/ekh3cpxMny7IKZnfR40DbK+h3ZMN/yP0s/5KapD17r0YfFho6eERQfliDc0QTMLW2JKOG53FSkZ9izYq4Kv+z957EgzsmkE8DymDPXdrUByAupgDZqfkZPdEY9inT+fFXhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084279; c=relaxed/simple;
	bh=4I4G8bZBqDJ2HsWRC0P9SVr2iP8mE3fCk30nlYLxnKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rD6uZV44LcMAgu/p5cFtkkLbNMVvvvC7juo5NVSvXaUb4zjsJjLH/E+dRn1eOTZKfasGxSQjRuGDMa2FiDViJUKM+3ukrtHBD+s7yj34QWgp2bhHvq/ECdt+0YmQBBdb26S3JkDh8ZaxUm8E7OrWI9WxmqUVCxxe1Y92b8yucBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCf5aaxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42B2C4CEC0;
	Wed, 11 Sep 2024 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726084279;
	bh=4I4G8bZBqDJ2HsWRC0P9SVr2iP8mE3fCk30nlYLxnKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JCf5aaxsRemFEDlhKvBg69NH+at3ESY2n23wLNZ8/LT7posxFDm8zcMBMZlM3FzyY
	 tIz91yaFWZH8gP8sEXAMv70y6sl8ty7OQaeUSQF3wXfIgzYDrf9tRxe0fMawOQ8kNS
	 WcKQhYZWaEQdxchrfshuxI2Jn0EfDTXZyl9xGD7WFrfkaZSnfHsT5Gn8sNdfv2nAcU
	 3ev3OhrR739ZdkGGLCK7JpiieesZta6Je+9Z4oTjsPGuQY1VVcVq3fYajkp9K4gBh1
	 AvUmlpueXxw8I7IqAvDXU4UnS1shcKMhwudTWtneM8jOCpEtRoMqHStKT0PH/02Mws
	 5d/bFBeQCdiOQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 11 Sep 2024 21:50:05 +0200
Subject: [PATCH v4 5/5] pwm: airoha: Add support for EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-en7581-pinctrl-v4-5-60ac93d760bb@kernel.org>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
In-Reply-To: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
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
X-Mailer: b4 0.14.1

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

Introduce driver for PWM module available on EN7581 SoC.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-airoha.c | 414 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 425 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3e53838990f5..0a78bda0707d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -47,6 +47,16 @@ config PWM_AB8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-ab8500.
 
+config PWM_AIROHA
+	tristate "Airoha PWM support"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on OF
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
index 0be4f3e6dd43..7ee61822d88d 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
+obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
new file mode 100644
index 000000000000..bab2e15e06e7
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,414 @@
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
+#include <linux/mfd/airoha-en7581-mfd.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/gpio.h>
+#include <linux/bitops.h>
+#include <asm/div64.h>
+
+#define REG_SGPIO_LED_DATA		0x0024
+#define SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
+#define SGPIO_LED_DATA_DATA		GENMASK(16, 0)
+
+#define REG_SGPIO_CLK_DIVR		0x0028
+#define REG_SGPIO_CLK_DLY		0x002c
+
+#define REG_SIPO_FLASH_MODE_CFG		0x0030
+#define SERIAL_GPIO_FLASH_MODE		BIT(1)
+#define SERIAL_GPIO_MODE		BIT(0)
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
+struct airoha_pwm {
+	void __iomem *base;
+
+	struct device_node *np;
+	u64 initialized;
+
+	struct {
+		/* Bitmask of PWM channels using this bucket */
+		u64 used;
+		u64 period_ns;
+		u64 duty_ns;
+	} bucket[8];
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
+static u32 airoha_pwm_rmw(struct airoha_pwm *pc, u32 addr, u32 mask, u32 val)
+{
+	val |= (readl(pc->base + addr) & ~mask);
+	writel(val, pc->base + addr);
+
+	return val;
+}
+
+#define airoha_pwm_set_bits(pc, addr, val)	\
+	airoha_pwm_rmw((pc), (addr), (val), (val))
+
+#define airoha_pwm_clear_bit(pc, addr, mask)	\
+	airoha_pwm_rmw(pc, addr, mask, 0)
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
+	u32 clk_divr_val = 3, sipo_clock_delay = 1;
+	u32 val, sipo_clock_divisor = 32;
+
+	if (!(pc->initialized >> PWM_NUM_GPIO))
+		return 0;
+
+	/* Select the right shift register chip */
+	if (of_property_read_bool(pc->np, "hc74595"))
+		airoha_pwm_set_bits(pc, REG_SIPO_FLASH_MODE_CFG,
+				    SERIAL_GPIO_MODE);
+	else
+		airoha_pwm_clear_bit(pc, REG_SIPO_FLASH_MODE_CFG,
+				     SERIAL_GPIO_MODE);
+
+	if (!of_property_read_u32(pc->np, "sipo-clock-divisor",
+				  &sipo_clock_divisor)) {
+		switch (sipo_clock_divisor) {
+		case 4:
+			clk_divr_val = 0;
+			break;
+		case 8:
+			clk_divr_val = 1;
+			break;
+		case 16:
+			clk_divr_val = 2;
+			break;
+		case 32:
+			clk_divr_val = 3;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	/* Configure shift register timings */
+	writel(clk_divr_val, pc->base + REG_SGPIO_CLK_DIVR);
+
+	of_property_read_u32(pc->np, "sipo-clock-delay", &sipo_clock_delay);
+	if (sipo_clock_delay < 1 || sipo_clock_delay > sipo_clock_divisor / 2)
+		return -EINVAL;
+
+	/*
+	 * The actual delay is sclkdly + 1 so subtract 1 from
+	 * sipo-clock-delay to calculate the register value
+	 */
+	sipo_clock_delay--;
+	writel(sipo_clock_delay, pc->base + REG_SGPIO_CLK_DLY);
+
+	/*
+	 * It it necessary to after muxing explicitly shift out all
+	 * zeroes to initialize the shift register before enabling PWM
+	 * mode because in PWM mode SIPO will not start shifting until
+	 * it needs to output a non-zero value (bit 31 of led_data
+	 * indicates shifting in progress and it must return to zero
+	 * before led_data can be written or PWM mode can be set)
+	 */
+	if (readl_poll_timeout(pc->base + REG_SGPIO_LED_DATA, val,
+			       !(val & SGPIO_LED_DATA_SHIFT_FLAG), 10,
+			       200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	airoha_pwm_clear_bit(pc, REG_SGPIO_LED_DATA, SGPIO_LED_DATA_DATA);
+	if (readl_poll_timeout(pc->base + REG_SGPIO_LED_DATA, val,
+			       !(val & SGPIO_LED_DATA_SHIFT_FLAG), 10,
+			       200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	/* Set SIPO in PWM mode */
+	airoha_pwm_set_bits(pc, REG_SIPO_FLASH_MODE_CFG,
+			    SERIAL_GPIO_FLASH_MODE);
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
+	airoha_pwm_rmw(pc, REG_CYCLE_CFG_VALUE(index / 4), mask, val);
+
+	/* Configure duty cycle */
+	duty = ((DUTY_FULL - duty) << 8) | duty;
+	mask = GPIO_FLASH_PRD_MASK(index % 2);
+	val = (duty << __ffs(mask)) & mask;
+	airoha_pwm_rmw(pc, REG_GPIO_FLASH_PRD_SET(index / 2), mask, val);
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
+		airoha_pwm_clear_bit(pc, addr, GPIO_FLASH_EN(hwpwm % 8));
+		return;
+	}
+
+	mask = GPIO_FLASH_SETID_MASK(hwpwm % 8);
+	val = ((index & 7) << __ffs(mask)) & mask;
+	airoha_pwm_rmw(pc, addr, mask, val);
+	airoha_pwm_set_bits(pc, addr, GPIO_FLASH_EN(hwpwm % 8));
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
+		airoha_pwm_clear_bit(pc, REG_SIPO_FLASH_MODE_CFG,
+				     SERIAL_GPIO_FLASH_MODE);
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
+	struct airoha_mfd *mfd;
+	struct airoha_pwm *pc;
+	struct pwm_chip *chip;
+
+	/* Assign parent MFD of_node to dev */
+	device_set_of_node_from_dev(dev, dev->parent);
+	mfd = dev_get_drvdata(dev->parent);
+
+	chip = devm_pwmchip_alloc(dev, PWM_NUM_GPIO + PWM_NUM_SIPO,
+				  sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	pc = pwmchip_get_drvdata(chip);
+	pc->np = dev->of_node;
+	pc->base = mfd->base;
+	chip->ops = &airoha_pwm_ops;
+
+	return devm_pwmchip_add(&pdev->dev, chip);
+}
+
+static struct platform_driver airoha_pwm_driver = {
+	.driver = {
+		.name = "pwm-airoha",
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
2.46.0


