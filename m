Return-Path: <linux-pwm+bounces-4568-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B062A08917
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 08:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB0D3A9187
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD84207E1A;
	Fri, 10 Jan 2025 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhw0Zz3K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B069207DE5;
	Fri, 10 Jan 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494686; cv=none; b=W7z7aN6XY1b1xh0w+WnNjiAAGbXsiy9ZPtkVnZ9dtT6saDcNO97Pms4riQdrX79wOLRsxNaQz2UQkgcPwFaAp0dhwbsmwwiO5urCyxHY0vYBZQUpxmm6kXjnYVNPUYZeUSXhzUJ5zJGQa9JBDPpCtX20HjnUEP7ZZx8TNkyMOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494686; c=relaxed/simple;
	bh=Xk3GeD4sJ8VT+W1A045kvV1mhbF5tFxb08m8VBBQrR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjBPwj55PI8JZnq138k+mS38IaEaA+bABdm3hUUbTHRXWUU1HLC/umQ5yH0E9oQ41P5drKJpM8HZ103OQ8zQUwWQ2dBIwuv5UhxY0cvqZ4pGXpQ/a9Li5n3Oln/HBJuv4gps247gWXA6d4G7wsQYrA6enho9gAqOPO5HhXv0kh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhw0Zz3K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43675b1155bso20239425e9.2;
        Thu, 09 Jan 2025 23:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736494682; x=1737099482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/3kCeWuhprnBzgfmg85WY4v72F++jPMjgNl3ndW03k=;
        b=Hhw0Zz3KDCR4QzxsA0BbOk06jQBf51pfS3oxumV7geopn5kwjgXq1Y0D5XeaVhvHHI
         MyVMSjTq/IvBYIt8NO3R0kmghkcZ5AwPFleKJcBREthYlQpivltlumv/JsF52L5lq8Ex
         bLMqNzdbNnu6ZeFvs5m+jcm3iDXh3nvok5xx4OmbALb98g2mYaIc0p1cOpxSnRW9B3Ia
         zhhvep+H4oAfqr/ngnZhqqtlJilk/fgzeIbCUmmY5cYDD6pxlxwS7sHQODENf7HzqVle
         ZgYQp/0Q4NeiLOcxG3ToKLYqD99eQqk76lcHTBwLix9+8zGoJNbPm0iCKQiTa9Z30Jnw
         bglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736494682; x=1737099482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/3kCeWuhprnBzgfmg85WY4v72F++jPMjgNl3ndW03k=;
        b=AeUgoNFyo3PDVuJXpPmJnfV/hEvFPUHF97qmejO/iPHKslCT/wVmExV3DK5amsIq85
         aoB4CNQHJbmJAZVSDLdA9K8rU+UG8lRYL/SblJE7xvAsc0h1xKvg3NIcepcunxiV8col
         V2cQj/H2soodeJmnsfYdsC93OFoFTsMzqW++IYFokUMTdUtWcK0ZOKKMqxbI5Fbefmp5
         pjl3bMXdOYr6sfOLxOy/LtKeBwebGBSmynRY7pgHew8T+9pt+5SrYW4GQGjYdVMT68eb
         u1xrp2IasmHK8o03BlYIaEYoI5CgxRGoXfsNr5hOb4bT217NDAM2Qq53omwVOhuFgPzN
         kcXA==
X-Forwarded-Encrypted: i=1; AJvYcCUAlMXTssTNssrw3BXH15x+ywwhZjnmqtjnFIFK/y2gG8ACGD+HrDDBkairSHOHilTp4qoREk71E/YT@vger.kernel.org, AJvYcCX4B24WO8M3ayQb4tHL8bsUAsc/y2gFuUyhXnRFgsHwELHJ1OBAuWL6QFdWLqZxhGQBjkfTTvIC4mGi@vger.kernel.org, AJvYcCXjTRm2ULv6zrbyOxGr4pQ3uXfRnvUzco80Qk60ufgrf5jNamQfry4Wueqk0ucDAJ8O1slqvw0ezvTYXg0M@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+kP2sc8XxPTN3+95WrLHhbZaSDnfEBYQg6xi2D0kpSytFdD2
	P3m9j4izw7Y+7M8xdkgMSMMlc4mvWT0t4+JmRhHRAYDZgzawMkRQ
X-Gm-Gg: ASbGnctExmxaZbCZI/+j6w9gL+/R+Eq6gX781DZfo/G1E55/oRpI+a8z/fH8kyAd44R
	c0nLpvYEEeyq6/WEv7KKKZAuF5IhFKji9/0L/9ogTDt1YPYBxioh8Oj1DvBJsp+JVPg8TlUNEgs
	I2R07gcEMv8AV2dxt+1okmkzjy8q+CeMF6TFUaua8JVe/yJbKcMKwq2oOgfe++fdLdiTo31zbeZ
	ygdtRtgBCyXdAvn6+alVWU1MvL60RyxY7Cy4a3e4J4IseeVoQ1fezmNepTxpxqZOw==
X-Google-Smtp-Source: AGHT+IH36AWDm7aFXRtfQApMRbdlk5CZ9tYbxjbdlBzUUrGfe1ZIxgn99fY5kZtHuqhWpKtxguaCxA==
X-Received: by 2002:a5d:5f85:0:b0:386:3213:5b9b with SMTP id ffacd0b85a97d-38a8732c132mr9711876f8f.43.1736494682138;
        Thu, 09 Jan 2025 23:38:02 -0800 (PST)
Received: from debian.fritz.box ([2a00:79c0:6a1:e700:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38397csm3726478f8f.24.2025.01.09.23.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 23:38:01 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri, 10 Jan 2025 08:37:55 +0100
Message-Id: <20250110073755.29541-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110073755.29541-1-dima.fedrau@gmail.com>
References: <20250110073755.29541-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MC33XS2410 is a four channel high-side switch. Featuring advanced
monitoring and control function, the device is operational from 3.0 V to
60 V. The device is controlled by SPI port for configuration.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/pwm/Kconfig          |  12 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-mc33xs2410.c | 378 +++++++++++++++++++++++++++++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..f513513f9b2f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -411,6 +411,18 @@ config PWM_LPSS_PLATFORM
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
index 9081e0c0e9e0..c75deeeace40 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
new file mode 100644
index 000000000000..432693b4f8eb
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,378 @@
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
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_CTRL1_POL_INV(chan)	BIT((chan) + 1)
+
+#define MC33XS2410_PWM_CTRL3			0x07
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_CTRL3_EN(chan)		BIT(4 + (chan) - 1)
+
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_FREQ(chan)		(0x08 + (chan) - 1)
+#define MC33XS2410_PWM_FREQ_STEP		GENMASK(7, 6)
+#define MC33XS2410_PWM_FREQ_COUNT		GENMASK(5, 0)
+
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_DC(chan)			(0x0c + (chan) - 1)
+
+#define MC33XS2410_WDT				0x14
+
+#define MC33XS2410_PWM_MIN_PERIOD		488282
+/* x in { 0 ... 3 } */
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
+	 * Check which step is appropriate for the given period, starting with
+	 * the highest frequency(lowest period). Higher frequencies are
+	 * represented with better resolution by the device. Therefore favor
+	 * frequency range with the better resolution to minimize error
+	 * introduced by the frequency steps.
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
+	u32 freq, code, doubled_steps;
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
+	freq = (code + 1) * doubled_steps;
+
+	/* Convert frequency to period, considering the doubled frequency. */
+	return DIV_ROUND_UP(2 * NSEC_PER_SEC, freq);
+}
+
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
+	/* frequency */
+	wr_val[0] = mc33xs2410_pwm_get_freq(period);
+	/* Continue calculations with the possibly truncated period */
+	period = mc33xs2410_pwm_get_period(wr_val[0]);
+
+	/* duty cycle */
+	duty_cycle = min(period, state->duty_cycle);
+	rel_dc = div64_u64(duty_cycle * 256, period) - 1;
+	if (rel_dc < 0)
+		wr_val[1] = 0;
+	else
+		wr_val[1] = rel_dc;
+
+	/* polarity */
+	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1);
+	wr_val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
+		    (rd_val[0] | mask) : (rd_val[0] & ~mask);
+
+	/*
+	 * As the hardware cannot generate a 0% relative duty cycle but emits a
+	 * constant low signal when disabled, also disable in the duty_cycle = 0
+	 * case.
+	 */
+	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1);
+	wr_val[3] = (state->enabled && rel_dc >= 0) ? (rd_val[1] | mask) :
+						      (rd_val[1] & ~mask);
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
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(reset_gpio))
+		return PTR_ERR_OR_ZERO(reset_gpio);
+
+	fsleep(1000);
+	gpiod_set_value_cansleep(reset_gpio, 0);
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
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.5


