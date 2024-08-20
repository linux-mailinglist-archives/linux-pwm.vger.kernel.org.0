Return-Path: <linux-pwm+bounces-3049-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B599586A1
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 14:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C6DB20FF3
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100518EFF1;
	Tue, 20 Aug 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjzEGCK6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1118A6BC;
	Tue, 20 Aug 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155980; cv=none; b=nof/T8ciB8PW/d+Vh2IRmM2b8unKAgiTMuBEBQYJRERi55S1ckX3SA8uagURsDPjAPUiuUr2kop9VRbPB+QYqjai+dCN7ODCsGQqEdvJlQpg/s/simGHigFKcsBAlTimqs3lWMOOAS0+n1LYQZ8QyBTqqPVVldw3O3uTXr8CSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155980; c=relaxed/simple;
	bh=Fwiak3SJ1Xig73oco/Y9Wl8pWzBJwM3a2zpXAGypp6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhW0YvzsyVJSv9cSmE4ui4bA25xdz75N1rtXvNqGywDuvfm6j+7XmMQRDifWMA9WJqlTlpQhjRuyZ5KKkTAV3M1EOn0c8WsV4xvQS5xWz2NniYuMlp089Zw2eF1ajwv3c8DVZrU4fXKl6Z4ynVDPw3+uXaz1QBOxNi8Mf0mRxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjzEGCK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F1CC4AF09;
	Tue, 20 Aug 2024 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724155980;
	bh=Fwiak3SJ1Xig73oco/Y9Wl8pWzBJwM3a2zpXAGypp6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AjzEGCK6I+SJVbacUCiabR4mdW4i08zwHn3l52msrLBtu0dZPgLRPtk+sy744EMcZ
	 cxmjQCp8mzL3ynNix0ZQ1qw5hxYQS0iLCoqud87roTjgh/LsU/eZhKZe9eeaRQRzXB
	 1283v/67Ak502svXEHJsR4l0keAWpkGZ5GDIfwewV+6mfH7YZrtKHfoe3bRKM5l1p8
	 HvYaZ2Xn5uDeqRkLCDXs24a+DTvSpq7ymP5cb03Y3aLEmiVFZmOf23m+l4U6LV/ouJ
	 rGJyQccrrLKUEy+PSfsFB/4G7BIhmq0g3uWQ8PLCi1vXYUWJB+ReX63d/IyzzLwqk+
	 I2Fuw0zzzLULw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 20 Aug 2024 14:12:16 +0200
Subject: [PATCH v4 2/2] pwm: airoha: Add support for EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-airoha-pwm-drv-v4-2-2b1c2b760744@kernel.org>
References: <20240820-airoha-pwm-drv-v4-0-2b1c2b760744@kernel.org>
In-Reply-To: <20240820-airoha-pwm-drv-v4-0-2b1c2b760744@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, angelogioacchino.delregno@collabora.com, 
 ansuelsmth@gmail.com, benjamin.larsson@genexis.eu, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.0

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

Introduce driver for PWM module available on EN7581 SoC.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-airoha.c | 408 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 419 insertions(+)

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
index 000000000000..8e0b48b21b5e
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/gpio.h>
+#include <linux/bitops.h>
+#include <asm/div64.h>
+
+#define REG_SGPIO_LED_DATE		0x0000
+#define SGPIO_LED_SHIFT_FLAG		BIT(31)
+#define SGPIO_LED_DATA			GENMASK(16, 0)
+
+#define REG_SGPIO_CLK_DIVR		0x0004
+#define REG_SGPIO_CLK_DLY		0x0008
+
+#define REG_SIPO_FLASH_MODE_CFG		0x000c
+#define SERIAL_GPIO_FLASH_MODE		BIT(1)
+#define SERIAL_GPIO_MODE		BIT(0)
+
+#define REG_GPIO_FLASH_PRD_SET(_n)	(0x0004 + ((_n) << 2))
+#define GPIO_FLASH_PRD_MASK(_n)		GENMASK(15 + ((_n) << 4), ((_n) << 4))
+
+#define REG_GPIO_FLASH_MAP(_n)		(0x0014 + ((_n) << 2))
+#define GPIO_FLASH_SETID_MASK(_n)	GENMASK(2 + ((_n) << 2), ((_n) << 2))
+#define GPIO_FLASH_EN(_n)		BIT(3 + ((_n) << 2))
+
+#define REG_SIPO_FLASH_MAP(_n)		(0x001c + ((_n) << 2))
+
+#define REG_CYCLE_CFG_VALUE(_n)		(0x0000 + ((_n) << 2))
+#define WAVE_GEN_CYCLE_MASK(_n)		GENMASK(7 + ((_n) << 3), ((_n) << 3))
+
+struct airoha_pwm {
+	void __iomem *sgpio_cfg;
+	void __iomem *flash_cfg;
+	void __iomem *cycle_cfg;
+
+	struct device_node *np;
+	u64 initialized;
+
+	struct {
+		/* Bitmask of PWM channels using this bucket */
+		u64 used;
+		/* Relative duty cycle, 0-255 */
+		u32 duty;
+		/* In 1/250 s, 1-250 permitted */
+		u32 period;
+	} bucket[8];
+};
+
+/*
+ * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
+ * The SIPO GPIO pins are 16 pins which are mapped into 17 PWM channels, 16-32.
+ * However, we've only got 8 concurrent waveform generators and can therefore
+ * only use up to 8 different combinations of duty cycle and period at a time.
+ */
+#define PWM_NUM_GPIO	16
+#define PWM_NUM_SIPO	17
+
+/* The PWM hardware supports periods between 4 ms and 1 s */
+#define PERIOD_MIN_NS	4000000
+#define PERIOD_MAX_NS	1000000000
+/* It is represented internally as 1/250 s between 1 and 250 */
+#define PERIOD_MIN	1
+#define PERIOD_MAX	250
+/* Duty cycle is relative with 255 corresponding to 100% */
+#define DUTY_FULL	255
+
+static u32 airoha_pwm_rmw(struct airoha_pwm *pc, void __iomem *addr,
+			  u32 mask, u32 val)
+{
+	val |= (readl(addr) & ~mask);
+	writel(val, addr);
+
+	return val;
+}
+
+#define airoha_pwm_sgpio_rmw(pc, offset, mask, val)				\
+	airoha_pwm_rmw((pc), (pc)->sgpio_cfg + (offset), (mask), (val))
+#define airoha_pwm_flash_rmw(pc, offset, mask, val)				\
+	airoha_pwm_rmw((pc), (pc)->flash_cfg + (offset), (mask), (val))
+#define airoha_pwm_cycle_rmw(pc, offset, mask, val)				\
+	airoha_pwm_rmw((pc), (pc)->cycle_cfg + (offset), (mask), (val))
+
+#define airoha_pwm_sgpio_set(pc, offset, val)					\
+	airoha_pwm_sgpio_rmw((pc), (offset), 0, (val))
+#define airoha_pwm_sgpio_clear(pc, offset, mask)				\
+	airoha_pwm_sgpio_rmw((pc), (offset), (mask), 0)
+#define airoha_pwm_flash_set(pc, offset, val)					\
+	airoha_pwm_flash_rmw((pc), (offset), 0, (val))
+#define airoha_pwm_flash_clear(pc, offset, mask)				\
+	airoha_pwm_flash_rmw((pc), (offset), (mask), 0)
+
+static int airoha_pwm_get_waveform(struct airoha_pwm *pc, u32 duty, u32 period)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pc->bucket); i++) {
+		if (!pc->bucket[i].used)
+			continue;
+
+		if (duty == pc->bucket[i].duty &&
+		    period == pc->bucket[i].period)
+			return i;
+
+		/*
+		 * Unlike duty cycle zero, which can be handled by
+		 * disabling PWM, a generator is needed for full duty
+		 * cycle but it can be reused regardless of period
+		 */
+		if (duty == DUTY_FULL && pc->bucket[i].duty == DUTY_FULL)
+			return i;
+	}
+
+	return -1;
+}
+
+static void airoha_pwm_free_waveform(struct airoha_pwm *pc, unsigned int hwpwm)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pc->bucket); i++)
+		pc->bucket[i].used &= ~BIT_ULL(hwpwm);
+}
+
+static int airoha_pwm_consume_waveform(struct airoha_pwm *pc, u32 duty,
+				       u32 period, unsigned int hwpwm)
+{
+	int id = airoha_pwm_get_waveform(pc, duty, period);
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
+	if (id > 0) {
+		airoha_pwm_free_waveform(pc, hwpwm);
+		pc->bucket[id].used |= BIT_ULL(hwpwm);
+		pc->bucket[id].period = period;
+		pc->bucket[id].duty = duty;
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
+		airoha_pwm_sgpio_set(pc, REG_SIPO_FLASH_MODE_CFG,
+				     SERIAL_GPIO_MODE);
+	else
+		airoha_pwm_sgpio_clear(pc, REG_SIPO_FLASH_MODE_CFG,
+				       SERIAL_GPIO_MODE);
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
+	writel(clk_divr_val, pc->sgpio_cfg + REG_SGPIO_CLK_DIVR);
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
+	writel(sipo_clock_delay, pc->sgpio_cfg + REG_SGPIO_CLK_DLY);
+
+	/*
+	 * It it necessary to after muxing explicitly shift out all
+	 * zeroes to initialize the shift register before enabling PWM
+	 * mode because in PWM mode SIPO will not start shifting until
+	 * it needs to output a non-zero value (bit 31 of led_data
+	 * indicates shifting in progress and it must return to zero
+	 * before led_data can be written or PWM mode can be set)
+	 */
+	if (readl_poll_timeout(pc->sgpio_cfg + REG_SGPIO_LED_DATE, val,
+			       !(val & SGPIO_LED_SHIFT_FLAG), 10,
+			       200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	airoha_pwm_sgpio_clear(pc, REG_SGPIO_LED_DATE, SGPIO_LED_DATA);
+	if (readl_poll_timeout(pc->sgpio_cfg + REG_SGPIO_LED_DATE, val,
+			       !(val & SGPIO_LED_SHIFT_FLAG), 10,
+			       200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	/* Set SIPO in PWM mode */
+	airoha_pwm_sgpio_set(pc, REG_SIPO_FLASH_MODE_CFG,
+			     SERIAL_GPIO_FLASH_MODE);
+
+	return 0;
+}
+
+static void airoha_pwm_config_waveform(struct airoha_pwm *pc, int index,
+				       u32 duty, u32 period)
+{
+	u32 mask, val;
+
+	/* Configure frequency divisor */
+	mask = WAVE_GEN_CYCLE_MASK(index % 4);
+	val = (period << __ffs(mask)) & mask;
+	airoha_pwm_cycle_rmw(pc, REG_CYCLE_CFG_VALUE(index / 4), mask, val);
+
+	/* Configure duty cycle */
+	duty = ((DUTY_FULL - duty) << 8) | duty;
+	mask = GPIO_FLASH_PRD_MASK(index % 2);
+	val = (duty << __ffs(mask)) & mask;
+	airoha_pwm_flash_rmw(pc, REG_GPIO_FLASH_PRD_SET(index / 2), mask, val);
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
+		airoha_pwm_flash_clear(pc, addr, GPIO_FLASH_EN(hwpwm % 8));
+		return;
+	}
+
+	mask = GPIO_FLASH_SETID_MASK(hwpwm % 8);
+	val = ((index & 7) << __ffs(mask)) & mask;
+	airoha_pwm_flash_rmw(pc, addr, mask, val);
+	airoha_pwm_flash_set(pc, addr, GPIO_FLASH_EN(hwpwm % 8));
+}
+
+static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
+			     u64 duty_ns, u64 period_ns,
+			     enum pwm_polarity polarity)
+{
+	u32 duty, period;
+	int index = -1;
+
+	duty = clamp_val(div64_u64(DUTY_FULL * duty_ns, period_ns), 0,
+			 DUTY_FULL);
+	if (polarity == PWM_POLARITY_INVERSED)
+		duty = DUTY_FULL - duty;
+
+	period = clamp_val(div64_u64(25 * period_ns, 100000000), PERIOD_MIN,
+			   PERIOD_MAX);
+	if (duty) {
+		index = airoha_pwm_consume_waveform(pc, duty, period,
+						    pwm->hwpwm);
+		if (index < 0)
+			return -EBUSY;
+	}
+
+	if (!(pc->initialized & BIT_ULL(pwm->hwpwm)) &&
+	    pwm->hwpwm >= PWM_NUM_GPIO)
+		airoha_pwm_sipo_init(pc);
+
+	if (index >= 0) {
+		airoha_pwm_config_waveform(pc, index, duty, period);
+		airoha_pwm_config_flash_map(pc, pwm->hwpwm, index);
+	} else {
+		airoha_pwm_config_flash_map(pc, pwm->hwpwm, index);
+		airoha_pwm_free_waveform(pc, pwm->hwpwm);
+	}
+
+	pc->initialized |= BIT_ULL(pwm->hwpwm);
+
+	return 0;
+}
+
+static void airoha_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+
+	/* Disable PWM and release the waveform */
+	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
+	airoha_pwm_free_waveform(pc, pwm->hwpwm);
+
+	pc->initialized &= ~BIT_ULL(pwm->hwpwm);
+	if (!(pc->initialized >> PWM_NUM_GPIO))
+		airoha_pwm_sgpio_clear(pc, REG_SIPO_FLASH_MODE_CFG,
+				       SERIAL_GPIO_FLASH_MODE);
+
+	/*
+	 * Clear the state to force re-initialization the next time
+	 * this PWM channel is used since we cannot retain state in
+	 * hardware due to limited number of waveform generators
+	 */
+	memset(&pwm->state, 0, sizeof(pwm->state));
+}
+
+static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+	u64 duty = state->enabled ? state->duty_cycle : 0;
+
+	if (state->period < PERIOD_MIN_NS || state->period > PERIOD_MAX_NS)
+		return -EINVAL;
+
+	return airoha_pwm_config(pc, pwm, duty, state->period,
+				 state->polarity);
+}
+
+static const struct pwm_ops airoha_pwm_ops = {
+	.apply = airoha_pwm_apply,
+	.free = airoha_pwm_free,
+};
+
+static int airoha_pwm_probe(struct platform_device *pdev)
+{
+	struct airoha_pwm *pc;
+	struct pwm_chip *chip;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, PWM_NUM_GPIO + PWM_NUM_SIPO,
+				  sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	pc = pwmchip_get_drvdata(chip);
+	pc->np = pdev->dev.of_node;
+
+	pc->sgpio_cfg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->sgpio_cfg))
+		return PTR_ERR(pc->sgpio_cfg);
+
+	pc->flash_cfg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(pc->flash_cfg))
+		return PTR_ERR(pc->flash_cfg);
+
+	pc->cycle_cfg = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(pc->cycle_cfg))
+		return PTR_ERR(pc->cycle_cfg);
+
+	chip->ops = &airoha_pwm_ops;
+	chip->of_xlate = of_pwm_xlate_with_flags;
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
+		.name = "airoha-pwm",
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
2.46.0


