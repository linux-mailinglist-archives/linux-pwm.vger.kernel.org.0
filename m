Return-Path: <linux-pwm+bounces-5355-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D9FA7DC19
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 13:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BF18879EC
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325923AE83;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mphIwRKR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F60224FD;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024921; cv=none; b=Bkm7WyXz6rPPQOSv62K2VeA8cF1xEGnruEOAPoMT2j9hJz/d2zVW7nWUz6ahusbutBkw8dxOhPJFRMPZNmqrwKaX2sZOUi7pbzbY17KIHRJMS77tgZ/zGXUJp1s/7kxNukrvsi8hZxrx1Fe7CtZCj1mindmo/x1o8tIw6xgzIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024921; c=relaxed/simple;
	bh=InYRaHKWOHxttF52iLZ6voOabDb+8Rvvpi9YZpkXZkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpQk+eLBdaqiy8G6NBbq/2Mt4VzkSbYmFhyAEx0kmvrShYqYhFZ4gpbqthDwvkI5PG2ZT9f5n4WX3QD/q7wR7pWYDyhdoh2taWwAC/Q7vfKftc0GBGIFlHy5XkHZGwrkC5RFOmDeGTR8R8MfOY+YEfo0CSwVP6cRI7gZIQoQwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mphIwRKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F58DC4CEEB;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744024921;
	bh=InYRaHKWOHxttF52iLZ6voOabDb+8Rvvpi9YZpkXZkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mphIwRKRA2A7eDIvH50kaGJgc0gnAuZD9LFa7GPk7N6mIQ/xOyb7shBG0bHicDVf9
	 AD3blD/2t8eqwwmJR1fMQFJFYzftd0M3XcA2arHvZ07qOCS+b/1w293Zdr+T1zS1jN
	 sXhw8mE76f2oJ66g+eK+Qr7mQqj6wg2CvxflLiNrcUVNVtmYq9yHbVERxtIBuqNHMu
	 Gu4ScVgq3LEzAhFgQgVxdwl8JkRQTWIKyF8++6lyvbJ5qRv5rVXkSfafJ00lI02wEk
	 iUaCPL/DoTb4wvJ61otDHZYZEf6Iqz894SUQ0wbN9MEQ+/tKuFg05Qt28t0QE7et1A
	 yhcPxkdSazdPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A4C369A3;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 07 Apr 2025 13:21:52 +0200
Subject: [PATCH v9 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-mc33xs2410-v9-2-57adcb56a6e4@liebherr.com>
References: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
In-Reply-To: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744024920; l=13817;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=N7KZpoUGwKZXgj0cSl+IePd1RIEv1DKYHkr228hHnXA=;
 b=ReNW8CeCwH6/O3+1BA4HWRKcKe9/1+b2EON4YYWRnXUjESF7uxFc4yh9ePxvHkG0rwb4AuZ8U
 B6zzyV5GMgYAlWrEbt55/NkhVmmbX1jh/iW0dzfSrdiVZ237WneDJKJ
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The MC33XS2410 is a four channel high-side switch. Featuring advanced
monitoring and control function, the device is operational from 3.0 V to
60 V. The device is controlled by SPI port for configuration.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/pwm/Kconfig          |  12 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-mc33xs2410.c | 391 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ead63f9d0c7314e9f87f4f453e2ec834bbd831cc..046e01a24949448d3e546e517d92c5897182afff 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -423,6 +423,18 @@ config PWM_LPSS_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss-platform.
 
+config PWM_MC33XS2410
+	tristate "MC33XS2410 PWM support"
+	depends on OF
+	depends on SPI
+	help
+	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
+	  channel high-side switch. The device is operational from 3.0 V
+	  to 60 V. The device is controlled by SPI port for configuration.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-mc33xs2410.
+
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index e52d0940b2473c7eed22591bcac624de63fb77fa..86e07844a93361f59978eacb20a72bb6f3d513dc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
new file mode 100644
index 0000000000000000000000000000000000000000..a1ac3445ccdb4709d92e0075d424a8abc1416eee
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ *
+ * Reference Manual : https://www.nxp.com/docs/en/data-sheet/MC33XS2410.pdf
+ *
+ * Limitations:
+ * - Supports frequencies between 0.5Hz and 2048Hz with following steps:
+ *   - 0.5 Hz steps from 0.5 Hz to 32 Hz
+ *   - 2 Hz steps from 2 Hz to 128 Hz
+ *   - 8 Hz steps from 8 Hz to 512 Hz
+ *   - 32 Hz steps from 32 Hz to 2048 Hz
+ * - Cannot generate a 0 % duty cycle.
+ * - Always produces low output if disabled.
+ * - Configuration isn't atomic. When changing polarity, duty cycle or period
+ *   the data is taken immediately, counters not being affected, resulting in a
+ *   behavior of the output pin that is neither the old nor the new state,
+ *   rather something in between.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+
+#include <linux/spi/spi.h>
+
+#define MC33XS2410_GLB_CTRL			0x00
+#define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
+#define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
+
+#define MC33XS2410_PWM_CTRL1			0x05
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_PWM_CTRL1_POL_INV(chan)	BIT((chan) + 1)
+
+#define MC33XS2410_PWM_CTRL3			0x07
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_PWM_CTRL3_EN(chan)		BIT(4 + (chan) - 1)
+
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_PWM_FREQ(chan)		(0x08 + (chan) - 1)
+#define MC33XS2410_PWM_FREQ_STEP		GENMASK(7, 6)
+#define MC33XS2410_PWM_FREQ_COUNT		GENMASK(5, 0)
+
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_PWM_DC(chan)			(0x0c + (chan) - 1)
+
+#define MC33XS2410_WDT				0x14
+
+#define MC33XS2410_PWM_MIN_PERIOD		488282
+/* step in { 0 ... 3 } */
+#define MC33XS2410_PWM_MAX_PERIOD(step)		(2000000000 >> (2 * (step)))
+
+#define MC33XS2410_FRAME_IN_ADDR		GENMASK(15, 8)
+#define MC33XS2410_FRAME_IN_DATA		GENMASK(7, 0)
+#define MC33XS2410_FRAME_IN_ADDR_WR		BIT(7)
+#define MC33XS2410_FRAME_IN_DATA_RD		BIT(7)
+#define MC33XS2410_FRAME_OUT_DATA		GENMASK(13, 0)
+
+#define MC33XS2410_MAX_TRANSFERS		5
+
+static int mc33xs2410_write_regs(struct spi_device *spi, u8 *reg, u8 *val,
+				 unsigned int len)
+{
+	u16 tx[MC33XS2410_MAX_TRANSFERS];
+	int i;
+
+	if (len > MC33XS2410_MAX_TRANSFERS)
+		return -EINVAL;
+
+	for (i = 0; i < len; i++)
+		tx[i] = FIELD_PREP(MC33XS2410_FRAME_IN_DATA, val[i]) |
+			FIELD_PREP(MC33XS2410_FRAME_IN_ADDR,
+				   MC33XS2410_FRAME_IN_ADDR_WR | reg[i]);
+
+	return spi_write(spi, tx, len * 2);
+}
+
+static int mc33xs2410_read_regs(struct spi_device *spi, u8 *reg, u8 flag,
+				u16 *val, unsigned int len)
+{
+	u16 tx[MC33XS2410_MAX_TRANSFERS];
+	u16 rx[MC33XS2410_MAX_TRANSFERS];
+	struct spi_transfer t = {
+		.tx_buf = tx,
+		.rx_buf = rx,
+	};
+	int i, ret;
+
+	len++;
+	if (len > MC33XS2410_MAX_TRANSFERS)
+		return -EINVAL;
+
+	t.len = len * 2;
+	for (i = 0; i < len - 1; i++)
+		tx[i] = FIELD_PREP(MC33XS2410_FRAME_IN_DATA, flag) |
+			FIELD_PREP(MC33XS2410_FRAME_IN_ADDR, reg[i]);
+
+	ret = spi_sync_transfer(spi, &t, 1);
+	if (ret < 0)
+		return ret;
+
+	for (i = 1; i < len; i++)
+		val[i - 1] = FIELD_GET(MC33XS2410_FRAME_OUT_DATA, rx[i]);
+
+	return 0;
+}
+
+static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u8 val)
+{
+	return mc33xs2410_write_regs(spi, &reg, &val, 1);
+}
+
+static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, u8 flag)
+{
+	return mc33xs2410_read_regs(spi, &reg, flag, val, 1);
+}
+
+static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
+{
+	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
+}
+
+static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
+{
+	u16 tmp;
+	int ret;
+
+	ret = mc33xs2410_read_reg_ctrl(spi, reg, &tmp);
+	if (ret < 0)
+		return ret;
+
+	tmp &= ~mask;
+	tmp |= val & mask;
+
+	return mc33xs2410_write_reg(spi, reg, tmp);
+}
+
+static u8 mc33xs2410_pwm_get_freq(u64 period)
+{
+	u8 step, count;
+
+	/*
+	 * Check which step [0 .. 3] is appropriate for the given period. The
+	 * period ranges for the different step values overlap. Prefer big step
+	 * values as these allow more finegrained period and duty cycle
+	 * selection.
+	 */
+
+	switch (period) {
+	case MC33XS2410_PWM_MIN_PERIOD ... MC33XS2410_PWM_MAX_PERIOD(3):
+		step = 3;
+		break;
+	case MC33XS2410_PWM_MAX_PERIOD(3) + 1 ... MC33XS2410_PWM_MAX_PERIOD(2):
+		step = 2;
+		break;
+	case MC33XS2410_PWM_MAX_PERIOD(2) + 1 ... MC33XS2410_PWM_MAX_PERIOD(1):
+		step = 1;
+		break;
+	case MC33XS2410_PWM_MAX_PERIOD(1) + 1 ... MC33XS2410_PWM_MAX_PERIOD(0):
+		step = 0;
+		break;
+	}
+
+	/*
+	 * Round up here because a higher count results in a higher frequency
+	 * and so a smaller period.
+	 */
+	count = DIV_ROUND_UP((u32)MC33XS2410_PWM_MAX_PERIOD(step), (u32)period);
+	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP, step) |
+	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT, count - 1);
+}
+
+static u64 mc33xs2410_pwm_get_period(u8 reg)
+{
+	u32 doubled_freq, code, doubled_steps;
+
+	/*
+	 * steps:
+	 *   - 0 = 0.5Hz
+	 *   - 1 = 2Hz
+	 *   - 2 = 8Hz
+	 *   - 3 = 32Hz
+	 * frequency = (code + 1) x steps.
+	 *
+	 * To avoid losing precision in case steps value is zero, scale the
+	 * steps value for now by two and keep it in mind when calculating the
+	 * period that the frequency had been doubled.
+	 */
+	doubled_steps = 1 << (FIELD_GET(MC33XS2410_PWM_FREQ_STEP, reg) * 2);
+	code = FIELD_GET(MC33XS2410_PWM_FREQ_COUNT, reg);
+	doubled_freq = (code + 1) * doubled_steps;
+
+	/* Convert frequency to period, considering the doubled frequency. */
+	return DIV_ROUND_UP(2 * NSEC_PER_SEC, doubled_freq);
+}
+
+/*
+ * The hardware cannot generate a 0% relative duty cycle for normal and inversed
+ * polarity. For normal polarity, the channel must be disabled, the device then
+ * emits a constant low signal.
+ * For inverted polarity, the channel must be enabled, the polarity must be set
+ * to normal and the relative duty cylce must be set to 100%. The device then
+ * emits a constant high signal.
+ */
+static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct spi_device *spi = pwmchip_get_drvdata(chip);
+	u8 reg[4] = {
+			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
+			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
+			MC33XS2410_PWM_CTRL1,
+			MC33XS2410_PWM_CTRL3
+		    };
+	u64 period, duty_cycle;
+	int ret, rel_dc;
+	u16 rd_val[2];
+	u8 wr_val[4];
+	u8 mask;
+
+	period = min(state->period, MC33XS2410_PWM_MAX_PERIOD(0));
+	if (period < MC33XS2410_PWM_MIN_PERIOD)
+		return -EINVAL;
+
+	ret = mc33xs2410_read_regs(spi, &reg[2], MC33XS2410_FRAME_IN_DATA_RD, rd_val, 2);
+	if (ret < 0)
+		return ret;
+
+	/* Frequency */
+	wr_val[0] = mc33xs2410_pwm_get_freq(period);
+	/* Continue calculations with the possibly truncated period */
+	period = mc33xs2410_pwm_get_period(wr_val[0]);
+
+	/* Duty cycle */
+	duty_cycle = min(period, state->duty_cycle);
+	rel_dc = div64_u64(duty_cycle * 256, period) - 1;
+	if (rel_dc >= 0)
+		wr_val[1] = rel_dc;
+	else if (state->polarity == PWM_POLARITY_NORMAL)
+		wr_val[1] = 0;
+	else
+		wr_val[1] = 255;
+
+	/* Polarity */
+	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1);
+	if (state->polarity == PWM_POLARITY_INVERSED && rel_dc >= 0)
+		wr_val[2] = rd_val[0] | mask;
+	else
+		wr_val[2] = rd_val[0] & ~mask;
+
+	/* Enable */
+	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1);
+	if (state->enabled &&
+	    !(state->polarity == PWM_POLARITY_NORMAL && rel_dc < 0))
+		wr_val[3] = rd_val[1] | mask;
+	else
+		wr_val[3] = rd_val[1] & ~mask;
+
+	return mc33xs2410_write_regs(spi, reg, wr_val, 4);
+}
+
+static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct spi_device *spi = pwmchip_get_drvdata(chip);
+	u8 reg[4] = {
+			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
+			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
+			MC33XS2410_PWM_CTRL1,
+			MC33XS2410_PWM_CTRL3,
+		    };
+	u16 val[4];
+	int ret;
+
+	ret = mc33xs2410_read_regs(spi, reg, MC33XS2410_FRAME_IN_DATA_RD, val,
+				   ARRAY_SIZE(reg));
+	if (ret < 0)
+		return ret;
+
+	state->period = mc33xs2410_pwm_get_period(val[0]);
+	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1)) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1));
+	state->duty_cycle = DIV_ROUND_UP_ULL((val[1] + 1) * state->period, 256);
+
+	return 0;
+}
+
+static const struct pwm_ops mc33xs2410_pwm_ops = {
+	.apply = mc33xs2410_pwm_apply,
+	.get_state = mc33xs2410_pwm_get_state,
+};
+
+static int mc33xs2410_reset(struct device *dev)
+{
+	struct gpio_desc *reset_gpio;
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR_OR_NULL(reset_gpio))
+		return PTR_ERR_OR_ZERO(reset_gpio);
+
+	/* Wake-up time */
+	fsleep(10000);
+
+	return 0;
+}
+
+static int mc33xs2410_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 4, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	spi->bits_per_word = 16;
+	spi->mode |= SPI_CS_WORD;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	pwmchip_set_drvdata(chip, spi);
+	chip->ops = &mc33xs2410_pwm_ops;
+
+	/*
+	 * Deasserts the reset of the device. Shouldn't change the output signal
+	 * if the device was setup prior to probing.
+	 */
+	ret = mc33xs2410_reset(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Disable watchdog and keep in mind that the watchdog won't trigger a
+	 * reset of the machine when running into an timeout, instead the
+	 * control over the outputs is handed over to the INx input logic
+	 * signals of the device. Disabling it here just deactivates this
+	 * feature until a proper solution is found.
+	 */
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
+
+	/* Transition to normal mode */
+	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
+				    MC33XS2410_GLB_CTRL_MODE,
+				    MC33XS2410_GLB_CTRL_MODE_NORMAL);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to transition to normal mode\n");
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
+
+	return 0;
+}
+
+static const struct spi_device_id mc33xs2410_spi_id[] = {
+	{ "mc33xs2410" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, mc33xs2410_spi_id);
+
+static const struct of_device_id mc33xs2410_of_match[] = {
+	{ .compatible = "nxp,mc33xs2410" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mc33xs2410_of_match);
+
+static struct spi_driver mc33xs2410_driver = {
+	.driver = {
+		.name = "mc33xs2410-pwm",
+		.of_match_table = mc33xs2410_of_match,
+	},
+	.probe = mc33xs2410_probe,
+	.id_table = mc33xs2410_spi_id,
+};
+module_spi_driver(mc33xs2410_driver);
+
+MODULE_DESCRIPTION("NXP MC33XS2410 high-side switch driver");
+MODULE_AUTHOR("Dimitri Fedrau <dimitri.fedrau@liebherr.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5



