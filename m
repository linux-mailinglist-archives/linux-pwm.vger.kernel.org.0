Return-Path: <linux-pwm+bounces-2966-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7AC9460BF
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F3F1C21490
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74515C12A;
	Fri,  2 Aug 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1k3SDhv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8D1537B7;
	Fri,  2 Aug 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613469; cv=none; b=k/wLXmXG1xlZ64z90IznxuLCcsBQH0WOpgG/RsYe4yJBDfd/1KveSq23GJGXXagCNICf0OIb0X2iHNdtzRT8euYqCio9wN4BPHD/99GnRMOXpoSlWVTmvxsMJwePhri7+o0Bi5gTNGOcypN8xwTRLTl1MpQwQ8goXdJABBCbY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613469; c=relaxed/simple;
	bh=DDbPDIdST10PqgBgKufZ/mh19WwyOQcfy5H11w75Kw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqWhNAUoOOAK6ikLgGjO9RZhoynAP6k3mjqQDWGuLGMFo6Mx8qjajQLf4K5peZT5fvg3cPQzD4vh7p0DivKjJRz8B1nFyi+HxbsfzPZi3H58cnkA6E6up5sl3FrWzGjPP/91IrPUkCt/D1l5Y3w6MxWTmzO2gx9smL0HSpDRWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1k3SDhv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so18111184e87.0;
        Fri, 02 Aug 2024 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722613465; x=1723218265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCzeoOfgRyN73yjz89XP9iP1Oo6tqinC2NDD3XRCXj8=;
        b=V1k3SDhvX/VoZwc9SOd2QdSMT89EQpn4OX2qgQ0GHOSyg0ZVW8eVlc/o1EjuYwpF7X
         J2D2SAqaF2hn7ilt9u9rDjMgjMnxlK+d7GBDhWGzIORRleEr2D2yAx2/G/zLGMYTbyhN
         wFPjaMLI9MaVeV4uCXfiAemdOGXemD8/UGAJJZmC6xqG5bjVXIOHG+ZXRyazTa7OMlYf
         gCd/0lSxu6qdi8oNgT4P3KYY1deGCT3biSlii5qNtGGHpgKR1KlspVO32qJrQdmSvQhz
         a/raOIMAGbitLYMgNtl2vjU+r2sI0Kdlm5hjI5+4DZDvNQsSqmjEs7M1TLW3SzfXrfY8
         xfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613465; x=1723218265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCzeoOfgRyN73yjz89XP9iP1Oo6tqinC2NDD3XRCXj8=;
        b=EyP1s42eN8EniV5TfvmtN55ujSNe3PKVbgn/nBzfQfjZQB1JvCwtHRIRLFgx6M9Wmv
         IdFGGZ702QArH1Gnvy/tx4ahRTcI5W35vnB1nVt21ZsQT0NTkeZvjBZG86Qb1HRh0fXQ
         lDP9FNASX2kKrwLL640k6oJ78wsn2Xo9J+GwZJkwg/Gu+UkdAJtapmkmg+4Yvf3s+vcj
         /b7qB1xBOWApaqmEjduttCMBJBaQ7zzgvcoKpA5riDpCQhHLZgPP7L3feDvHZ4JdBKra
         /S9fNpdfX6TQvCbtM4iLM3XNQmjPp4YCbrg7ebfSDzjVAjZF9rJJdoRwRwJtQiGwEVas
         lWmw==
X-Forwarded-Encrypted: i=1; AJvYcCVYc2yaeK6SwoouEyMQsX0B2UG4QsJUuzJ6k/xJZDwP/x3JkEkdFGsldsuTLUFUJtgzt90T1/1nKFbHGoKz7TR30bPL1EEs1F+fZRdyMGS40bPQ/rEBDVl0SFGgN50VUgGEFca21EGLvs4nXCheWmFy2fuYzOCAalaIKebZgS7G5Pjfig==
X-Gm-Message-State: AOJu0YzZkpgFCbwmZa05Vhzfl+/XdaoBENGMaM7HxLJNRCfybj2EWxVL
	zD1WpR6Iu305XX4IBbCGX6K26B+narnvCCWgxV0Y8a/REN4X9VN+
X-Google-Smtp-Source: AGHT+IGCZIEIePDOnbaHnoxU8b+C6munOPw7nKfVIlUaSoYvM4469Qmopy3614IitmXWg9J7RXtOgA==
X-Received: by 2002:a05:6512:2399:b0:52c:9877:71b7 with SMTP id 2adb3069b0e04-530bb3bd153mr3731866e87.59.1722613464337;
        Fri, 02 Aug 2024 08:44:24 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:640:3a00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3d14sm112577566b.22.2024.08.02.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:44:23 -0700 (PDT)
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
Subject: [PATCH v5 2/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri,  2 Aug 2024 17:44:08 +0200
Message-Id: <20240802154408.135632-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802154408.135632-1-dima.fedrau@gmail.com>
References: <20240802154408.135632-1-dima.fedrau@gmail.com>
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
 drivers/pwm/pwm-mc33xs2410.c | 419 +++++++++++++++++++++++++++++++++++
 3 files changed, 432 insertions(+)
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
index 000000000000..63e6a48b0d02
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,419 @@
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
+	 * Check which step is appropriate for the given period, starting with
+	 * the highest frequency(lowest period). Higher frequencies are
+	 * represented with better resolution by the device. Therefore favor
+	 * frequency range with the better resolution to minimize error
+	 * introduced by the frequency steps.
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
+	if (!duty_cycle && !state->enabled)
+		state->duty_cycle = 0;
+	else
+		state->duty_cycle = DIV_ROUND_UP_ULL((u64)(duty_cycle + 1) * state->period, 256);
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
+	int ret, rel_dc;
+	u16 val[4];
+	u8 mask;
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
+	mc33xs2410 = to_pwm_mc33xs2410_chip(chip);
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


