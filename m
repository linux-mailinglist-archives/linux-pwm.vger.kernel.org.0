Return-Path: <linux-pwm+bounces-3382-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD09885E0
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 14:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87727B21E23
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3918E058;
	Fri, 27 Sep 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3McnZxL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19D18DF68;
	Fri, 27 Sep 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441876; cv=none; b=UUFvrc73V8ZXcowbzCNB6Pnz63e99qgsOIUvvCQLMm9QPGd7gX0YPSy8SQtEK1OLdjebFrxzLuXFmJJYzwn0JVer9a/5aomXvErjOe9oq88neUeSnXaHEwag99JU61FOY8ebYLsanBoVj3Nr/9WwBzFZKm8YrCNk3bmhZTON6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441876; c=relaxed/simple;
	bh=hy/7MMiwqt06olSDE9Q+W8Z32QwfyyT82k5CZUTJwgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oz2t16GVFB6KtPpGhkTnUzhgeoaufChj3UWeCaBGdqffBO55KA6A6w2Xj0V3s/2D5lr/9UQPfFvxxtS7onsqJ3gtXEd6vaHWXqYR0lyoFEoA8Ab7wmWVZY4Bt0isnPB+mIDUjq0ICXpOgoply/G/14ip0eAKDcYAJ1S43xQDMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3McnZxL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so18126195e9.2;
        Fri, 27 Sep 2024 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727441872; x=1728046672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od40muGTBaa+ZQ11YizfdQOFP4nmxYN1NvKyOeoabeI=;
        b=Y3McnZxLZPbPqQ2kH/Gdy2tfnT0+f0718y8Muy4oC0c8xL0Z7U0JSsIFTZJIwQtL1E
         W1FoA59N6otIWiK5xlaI29A7CbJ6fAomwDEOkB5oK+NLu2JE/jK6l3pzj5brK1LXf6mH
         aHdfF5TBH2R8dfBeRl7ykCtOXspAjSMZ9b+0mdyysQ2wD34w1FzlNZY3OS1JKJCK6vJA
         fRNPfeeabnXTXaWyWQ6mnN/uG36CvJKCJWkk3pxUY6UGRib0Y0MTO/nlnq8LJQ/GJjT5
         OLu+8R+RLSst/JeNxB11z62YstOGXjS0u4jzVBTBR6utJ55MijYNwz4hb5Oc+F0APJm6
         91hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727441872; x=1728046672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Od40muGTBaa+ZQ11YizfdQOFP4nmxYN1NvKyOeoabeI=;
        b=TSbKizX4YJwN9VoiKUI6cFbpQroB2W2whFkvtv7Che6FH+LfvX/AMrZiB6239ju8me
         ie+8Iul+TMek8PVfEue7B7QzrwGwgVIiO+caYfpKDKQJJog5zH9FsoHl3CYl8encfi7R
         N2xTkjhxF0USyWmR7wn1cGMhqN6EkASYgmaaxjyHjWJGC+jg6falRLFzxtyPbuUlTerk
         pcOd3SIrsEcq9eP+LMD1Tp7KNAKZ3YBVoecB8Tvd+LdV19KYIoTtmKoBHgpLoEc6DYCj
         d2DrM0SSSZyRLOsMuctH8Hq9MfRWz2tdyZCFRRAnHCkWZ96d9lL35Ewj/VDGa9SuJGGk
         en5g==
X-Forwarded-Encrypted: i=1; AJvYcCWtDrBoLaLO07CHWj/ftv/uHp2Dafz3TQOR9MKgDm3DRjLHOITi4L353lvitu945Z85vE1/PU1A7vnI@vger.kernel.org, AJvYcCX3AYi/CJRAwjijaxFCPGsrEceQ15RBj4XM6Jf2YZrz5LHM3Q8nVcWvT8lfq6VZ+m/o7VIJpJMFJPTWleeu@vger.kernel.org, AJvYcCXS8DSrGzu/SUxn7NBQq3m4c6zoGP9kjP+tHnUr48kgkubB2J6JQjzQItYiObU9lLl7GZLW/nnNc3mA@vger.kernel.org
X-Gm-Message-State: AOJu0YyHG9uGL43azL1RV3OC4H7fevqvDJ8AC1F8IAHd42uABKqT3Gs4
	ZtPLNCO+OIMmLT7AP6wXGr4D+ROPiio5CBMZFAdNpCMDIBHlWwzuuHqRDQ==
X-Google-Smtp-Source: AGHT+IEEkoxsp+qeHTxORkVR1ZjtcADc1Ad43Ujbt5OpUYdsv1jpSsz+KF2TgJXQkQR7wTbsLynsTA==
X-Received: by 2002:a05:600c:1e0b:b0:42c:b995:20c8 with SMTP id 5b1f17b1804b1-42f5848551fmr21047905e9.24.1727441872083;
        Fri, 27 Sep 2024 05:57:52 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:666:ff00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddad1sm73814575e9.9.2024.09.27.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 05:57:51 -0700 (PDT)
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
Subject: [PATCH v6 2/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri, 27 Sep 2024 14:57:45 +0200
Message-Id: <20240927125745.38367-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927125745.38367-1-dima.fedrau@gmail.com>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
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
 drivers/pwm/Kconfig          |  12 +
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-mc33xs2410.c | 422 +++++++++++++++++++++++++++++++++++
 3 files changed, 435 insertions(+)
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
index 000000000000..f9a334a5e69b
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,422 @@
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
+#include <asm/unaligned.h>
+
+#include <linux/spi/spi.h>
+
+#define MC33XS2410_GLB_CTRL		0x00
+#define MC33XS2410_GLB_CTRL_MODE	GENMASK(7, 6)
+#define MC33XS2410_GLB_CTRL_MODE_NORMAL	FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
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
+#define MC33XS2410_MIN_PERIOD		488282
+#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
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
+static inline struct mc33xs2410_pwm *mc33xs2410_from_chip(struct pwm_chip *chip)
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
+	 * Check which step is appropriate for the given period, starting with
+	 * the highest frequency(lowest period). Higher frequencies are
+	 * represented with better resolution by the device. Therefore favor
+	 * frequency range with the better resolution to minimize error
+	 * introduced by the frequency steps.
+	 */
+
+	switch (period) {
+	case MC33XS2410_MIN_PERIOD ... MC33XS2410_MAX_PERIOD_STEP(3):
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
+	/*
+	 * Round up here because a higher count results in a higher frequency
+	 * and so a smaller period.
+	 */
+	count = DIV_ROUND_UP((u32)MC33XS2410_MAX_PERIOD_STEP(step), (u32)period);
+	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
+	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT_MASK, count - 1);
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
+	doubled_steps = 1 << (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, reg) * 2);
+	code = FIELD_GET(MC33XS2410_PWM_FREQ_COUNT_MASK, reg);
+	freq = (code + 1) * doubled_steps;
+
+	/* Convert frequency to period, considering the doubled frequency. */
+	return DIV_ROUND_UP((u32)(2 * NSEC_PER_SEC), freq);
+}
+
+static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_cycle)
+{
+	/*
+	 * duty_cycle cannot overflow and period is not zero, since this is
+	 * guaranteed by the caller.
+	 */
+	duty_cycle *= 256;
+	duty_cycle = div64_u64(duty_cycle, period);
+
+	return duty_cycle - 1;
+}
+
+static void mc33xs2410_pwm_set_relative_duty_cycle(struct pwm_state *state,
+						   u16 duty_cycle)
+{
+	if (!state->enabled)
+		state->duty_cycle = 0;
+	else
+		state->duty_cycle = DIV_ROUND_UP_ULL((duty_cycle + 1) * state->period, 256);
+}
+
+static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_from_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u8 reg[4] = {
+			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
+			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
+			MC33XS2410_PWM_CTRL1,
+			MC33XS2410_PWM_CTRL3
+		    };
+	bool ctrl[2] = { true, true };
+	u64 period, duty_cycle;
+	int ret, rel_dc;
+	u16 val[4];
+	u8 mask;
+
+	period = min(state->period, MC33XS2410_MAX_PERIOD_STEP(0));
+	if (period < MC33XS2410_MIN_PERIOD)
+		return -EINVAL;
+
+	ret = mc33xs2410_read_regs(spi, &reg[2], &ctrl[0], &val[2], 2);
+	if (ret < 0)
+		return ret;
+
+	/* frequency */
+	val[0] = mc33xs2410_pwm_get_freq(period);
+	/* Continue calculations with the possibly truncated period */
+	period = mc33xs2410_pwm_get_period(val[0]);
+
+	/* duty cycle */
+	duty_cycle = min(period, state->duty_cycle);
+	rel_dc = mc33xs2410_pwm_get_relative_duty_cycle(period, duty_cycle);
+	val[1] = rel_dc < 0 ? 0 : rel_dc;
+
+	/* polarity */
+	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
+	val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
+		 (val[2] | mask) : (val[2] & ~mask);
+
+	/* enable output */
+	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
+	val[3] = (state->enabled && rel_dc >= 0) ? (val[3] | mask) :
+						   (val[3] & ~mask);
+
+	return mc33xs2410_write_regs(spi, reg, val, 4);
+}
+
+static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_from_chip(chip);
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
+	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
+	mc33xs2410_pwm_set_relative_duty_cycle(state, val[1]);
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
+	mc33xs2410 = mc33xs2410_from_chip(chip);
+	mc33xs2410->spi = spi;
+	chip->ops = &mc33xs2410_pwm_ops;
+
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


