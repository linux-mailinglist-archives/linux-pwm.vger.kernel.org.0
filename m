Return-Path: <linux-pwm+bounces-2377-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2C90034D
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 14:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C25C1F252E6
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328C19408A;
	Fri,  7 Jun 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi0Q+fjd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE41922C4;
	Fri,  7 Jun 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762703; cv=none; b=kjsKRkzNIlHExb65Nxti0U2spIKnxPjmSzeXM4GqTYf8FsmnWFC51XIkkmIx7+6DTfm0rG0aRAKTU0XkABvMsYIvt7/ohqJfIdqTUWYmmMfv7HhpvsHKO7J2cFOmF/APmFRLXeue8IK9mT88wbdrgudyW0pKo8Xh8/o/HRwij24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762703; c=relaxed/simple;
	bh=bzWp1X0/Wh0ZymHCeLbUX2Uxar5EKW/2FCNGi7waxT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAICKiXdxWWY9H2preg1paDLn8mTnWfObAaB1NKa/x4Jc2RQJ+vmUi/sv93XcgJpkx/Lg8kDkBJGKL3zxJfBu0l6UuwJ9rff1OMyl9gHleZ8+JEQsA+SW+9cXxnxarZ7RZCDPf6szWFLTXZ6kYYa3k6fyiu5S+1y/tLb7w139HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi0Q+fjd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a63359aaacaso314036566b.1;
        Fri, 07 Jun 2024 05:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717762699; x=1718367499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O559nqm03nFFaxQ0yf+Ad5DrP8cuy6TQygOpwJ6XWpY=;
        b=Fi0Q+fjd5/0ps72gIrNfr3M6ObG3BWRTT7NhgbtUbQFzXKGAUDQjyLe3absN+19iAi
         1hk3ybX/QVkiFeV6BqB34uFN3nUIeDMJN8mWM5n07PnjlfbHsYOmmamaxuXT114txoVF
         xtxatgGvGurxaAC1gaXXbQP0mdYiPBM/pwFOK/Gcsbv7kSOPSPPBToLyX7Rd15UIQENc
         e2mIQVo2uMFJTMNJuWTmcOL0k7T3dPrGFM1KKPHYhxhX2cKhBGd33MgIcagwdjgckfiA
         d+u9wuQNguvGBNgd7AbsLdPi6dM8lipEcCyiXbhJMXq9OSiDvdMbBOsyHF9T/fcWmI4R
         AySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717762699; x=1718367499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O559nqm03nFFaxQ0yf+Ad5DrP8cuy6TQygOpwJ6XWpY=;
        b=M7lnJwpQYeqG7apxgszr8QlCHTEGhBeRLriYWY5GO5Oz2D0VVMglQfybwn19TbqmRS
         hwo8Ql/boSkBe1wcUtKVEPOKVEra9TLvYJ92IcpPoZn35SEU44WyMlXTRqREmxwMdgN9
         dS7KxUph1KqNd/zVKnYMPkC+isPcbKML7a0+7VXVXoB2pOpzhdVHEsJtUt1CqHCqFODA
         m3llwvIP4wPAS++Cyp8+mOAQP1RuDIh8C3t45D7WuNb5kjXnQR5dfisL7VNTWlG1Q/XX
         6PLZrZ+Oxm1keOYr3zSXAUbgdNQyRwsNhyHDgCUrwO/q3YIWuVeWQSqLxBgyFsLodwMw
         2q1g==
X-Forwarded-Encrypted: i=1; AJvYcCXn/GA0OWnNAAOK5MzXHFbWoMXcwZzc/0bpJyuhdFj3WPDUizF3+bo2jWhxtbi2mcgUoX4VuUtX6P63q6LuWnIho5ZN0rxnYloog3z4Lac8Sm5SUbJB31277ygXzmTYS0f0nUY9dNSP6pLikIuAKPbC5W5tfcPzjnqTno+CO7NxDePWKg==
X-Gm-Message-State: AOJu0YyILBdxPZq6d1+B56w0m+Ssti6A6s/xqVFDJ9Wh3s4I8DAAYzBg
	sGsWWFpEmwexT4fwA6xntIXG9uE/+j/nMfGPZFP78833KMe3UcSb
X-Google-Smtp-Source: AGHT+IF1v/wy5tdksuVfgujVLRoOMENtJfxoQX0oEXhkivzioFlfVL0nFuYHDWpmgE8cQHT7QPdBuA==
X-Received: by 2002:a17:907:6d1a:b0:a59:9a28:f1bd with SMTP id a640c23a62f3a-a6cdbfec4aemr173870466b.66.1717762699153;
        Fri, 07 Jun 2024 05:18:19 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm237785066b.110.2024.06.07.05.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:18:18 -0700 (PDT)
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
Subject: [PATCH v4 2/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri,  7 Jun 2024 14:18:10 +0200
Message-Id: <20240607121810.460154-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607121810.460154-1-dima.fedrau@gmail.com>
References: <20240607121810.460154-1-dima.fedrau@gmail.com>
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
 drivers/pwm/pwm-mc33xs2410.c | 408 +++++++++++++++++++++++++++++++++++
 3 files changed, 421 insertions(+)
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1dd7921194f5..1e873a19a1cf 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -380,6 +380,18 @@ config PWM_LPSS_PLATFORM
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
index 90913519f11a..b9b202f7fe7e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
new file mode 100644
index 000000000000..9ac4b5a2161b
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
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
+#include <asm/unaligned.h>
+
+#include <linux/spi/spi.h>
+
+#define MC33XS2410_GLB_CTRL		0x00
+#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
+#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
+#define MC33XS2410_PWM_CTRL1		0x05
+#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
+#define MC33XS2410_PWM_CTRL3		0x07
+/* x in { 0 ... 3 } */
+#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))
+#define MC33XS2410_PWM_FREQ1		0x08
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x - 1))
+#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
+#define MC33XS2410_PWM_FREQ_COUNT_MASK	GENMASK(5, 0)
+#define MC33XS2410_PWM_DC1		0x0c
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x - 1))
+#define MC33XS2410_WDT			0x14
+
+#define MC33XS2410_WR			BIT(7)
+#define MC33XS2410_RD_CTRL		BIT(7)
+#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
+
+#define MC33XS2410_MIN_PERIOD_STEP0	31250000
+#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
+/* x in { 0 ... 3 } */
+#define MC33XS2410_MIN_PERIOD_STEP(x)	(MC33XS2410_MIN_PERIOD_STEP0 >> (2 * x))
+/* x in { 0 ... 3 } */
+#define MC33XS2410_MAX_PERIOD_STEP(x)	(MC33XS2410_MAX_PERIOD_STEP0 >> (2 * x))
+
+#define MC33XS2410_MAX_TRANSFERS	5
+#define MC33XS2410_WORD_LEN		2
+
+struct mc33xs2410_pwm {
+	struct spi_device *spi;
+};
+
+static
+inline struct mc33xs2410_pwm *to_pwm_mc33xs2410_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u8 *reg,
+				u16 *val, bool *ctrl, int len)
+{
+	struct spi_transfer t[MC33XS2410_MAX_TRANSFERS] = { { 0 } };
+	u8 tx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
+	u8 rx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
+	int i, ret, reg_i, val_i;
+
+	if (!len)
+		return 0;
+
+	if (read)
+		len++;
+
+	if (len > MC33XS2410_MAX_TRANSFERS)
+		return -EINVAL;
+
+	for (i = 0; i < len; i++) {
+		reg_i = i * MC33XS2410_WORD_LEN;
+		val_i = reg_i + 1;
+		if (read) {
+			if (i < len - 1) {
+				tx[reg_i] = reg[i];
+				tx[val_i] = ctrl[i] ? MC33XS2410_RD_CTRL : 0;
+				t[i].tx_buf = &tx[reg_i];
+			}
+
+			if (i > 0)
+				t[i].rx_buf = &rx[reg_i - MC33XS2410_WORD_LEN];
+		} else {
+			tx[reg_i] = reg[i] | MC33XS2410_WR;
+			tx[val_i] = val[i];
+			t[i].tx_buf = &tx[reg_i];
+		}
+
+		t[i].len = MC33XS2410_WORD_LEN;
+		t[i].cs_change = 1;
+	}
+
+	t[len - 1].cs_change = 0;
+
+	ret = spi_sync_transfer(spi, &t[0], len);
+	if (ret < 0)
+		return ret;
+
+	if (read) {
+		for (i = 0; i < len - 1; i++) {
+			reg_i = i * MC33XS2410_WORD_LEN;
+			val[i] = FIELD_GET(MC33XS2410_RD_DATA_MASK,
+					   get_unaligned_be16(&rx[reg_i]));
+		}
+	}
+
+	return 0;
+}
+
+static
+int mc33xs2410_write_regs(struct spi_device *spi, u8 *reg, u16 *val, int len)
+{
+
+	return mc33xs2410_xfer_regs(spi, false, reg, val, NULL, len);
+}
+
+static int mc33xs2410_read_regs(struct spi_device *spi, u8 *reg, bool *ctrl,
+				u16 *val, u8 len)
+{
+	return mc33xs2410_xfer_regs(spi, true, reg, val, ctrl, len);
+}
+
+
+static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u16 val)
+{
+	return mc33xs2410_write_regs(spi, &reg, &val, 1);
+}
+
+static
+int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, bool ctrl)
+{
+	return mc33xs2410_read_regs(spi, &reg, &ctrl, val, 1);
+}
+
+static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
+{
+	return mc33xs2410_read_reg(spi, reg, val, true);
+}
+
+static
+int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u16 mask, u16 val)
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
+	 * Check if period is within the limits of each of the four frequency
+	 * ranges, starting with the highest frequency(lowest period). Higher
+	 * frequencies are represented with better resolution by the device.
+	 * Therefore favor frequency range with the better resolution to
+	 * minimize error introduced by the frequency steps.
+	 */
+
+	switch (period) {
+	case MC33XS2410_MIN_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(3):
+		step = 3;
+		break;
+	case MC33XS2410_MAX_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(2):
+		step = 2;
+		break;
+	case MC33XS2410_MAX_PERIOD_STEP(2) + 1 ... MC33XS2410_MAX_PERIOD_STEP(1):
+		step = 1;
+		break;
+	case MC33XS2410_MAX_PERIOD_STEP(1) + 1 ... MC33XS2410_MAX_PERIOD_STEP(0):
+		step = 0;
+		break;
+	}
+
+	count = DIV_ROUND_UP((u32)MC33XS2410_MAX_PERIOD_STEP(step), (u32)period);
+	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
+	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT_MASK, count - 1);
+}
+
+static u64 mc33xs2410_pwm_get_period(u8 reg)
+{
+	u32 freq, code, steps;
+
+	/*
+	 * steps:
+	 *   - 0 = 0.5Hz
+	 *   - 1 = 2Hz
+	 *   - 2 = 8Hz
+	 *   - 3 = 32Hz
+	 * frequency = (code + 1) x steps.
+	 *
+	 * To avoid division in case steps value is zero we scale the steps
+	 * value for now by two and keep it in mind when calculating the period
+	 * that we have doubled the frequency.
+	 */
+	steps = 1 << (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, reg) * 2);
+	code = FIELD_GET(MC33XS2410_PWM_FREQ_COUNT_MASK, reg);
+	freq = (code + 1) * steps;
+
+	/* Convert frequency to period, considering the doubled frequency. */
+	return DIV_ROUND_UP((u32)(2 * NSEC_PER_SEC), freq);
+}
+
+static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_cycle)
+{
+	if (!period)
+		return 0;
+
+	duty_cycle *= 256;
+	duty_cycle = DIV_ROUND_CLOSEST_ULL(duty_cycle, period);
+
+	/* Device is not able to generate 0% duty cycle */
+	if (!duty_cycle)
+		return -ERANGE;
+
+	return duty_cycle - 1;
+}
+
+static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = to_pwm_mc33xs2410_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u8 reg[4] = {
+			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
+			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
+			MC33XS2410_PWM_CTRL1,
+			MC33XS2410_PWM_CTRL3
+		    };
+	bool ctrl[2] = { true, true };
+	u64 period, duty_cycle;
+	u16 val[4];
+	u8 mask;
+	int ret;
+
+	period = min(state->period, MC33XS2410_MAX_PERIOD_STEP(0));
+	if (period < MC33XS2410_MIN_PERIOD_STEP(3) + 1)
+		return -EINVAL;
+
+	ret = mc33xs2410_read_regs(spi, &reg[2], &ctrl[0], &val[2], 2);
+	if (ret < 0)
+		return ret;
+
+	/* frequency */
+	val[0] = mc33xs2410_pwm_get_freq(period);
+
+	/* duty cycle */
+	duty_cycle = min(period, state->duty_cycle);
+	ret = mc33xs2410_pwm_get_relative_duty_cycle(period, duty_cycle);
+	if (ret < 0)
+		return ret;
+
+	val[1] = ret;
+	/* polarity */
+	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
+	val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
+		 (val[2] | mask) : (val[2] & ~mask);
+
+	/* enable output */
+	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
+	val[3] = (state->enabled) ? (val[3] | mask) : (val[3] & ~mask);
+
+	return mc33xs2410_write_regs(spi, reg, val, 4);
+}
+
+static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = to_pwm_mc33xs2410_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u8 reg[4] = {
+			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
+			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
+			MC33XS2410_PWM_CTRL1,
+			MC33XS2410_PWM_CTRL3,
+		    };
+	bool ctrl[4] = { true, true, true, true };
+	u16 val[4];
+	int ret;
+
+	ret = mc33xs2410_read_regs(spi, reg, ctrl, val, 4);
+	if (ret < 0)
+		return ret;
+
+	state->period = mc33xs2410_pwm_get_period(val[0]);
+	pwm_set_relative_duty_cycle(state, val[1] + 1, 256);
+	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
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
+	struct mc33xs2410_pwm *mc33xs2410;
+	struct device *dev = &spi->dev;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*mc33xs2410));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	mc33xs2410 = to_pwm_mc33xs2410_chip(chip);
+	mc33xs2410->spi = spi;
+	chip->ops = &mc33xs2410_pwm_ops;
+
+	ret = mc33xs2410_reset(dev);
+	if (ret)
+		return ret;
+
+	/* Disable watchdog */
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
+
+	/* Transition to normal mode */
+	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
+				    MC33XS2410_GLB_CTRL_MODE_MASK,
+				    MC33XS2410_GLB_CTRL_NORMAL_MODE);
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
2.39.2


