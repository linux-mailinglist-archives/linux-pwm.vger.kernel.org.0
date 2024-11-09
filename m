Return-Path: <linux-pwm+bounces-4053-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783F9C2EE1
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 18:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D000B2146C
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6619F113;
	Sat,  9 Nov 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOpmMi5d"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8219DFA5;
	Sat,  9 Nov 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174107; cv=none; b=DHGFsJ7eaQai7fOmETBhz7TkmF23f14xGqBgsP+GKZGTq5M9n293HpDOyh1hr6IBmJDR1Fd/ediiYtMr/IuNv7qR9j6VOwxzSyGCAWlwVxpODMkjwFkERo/QEWjcmrt7VeiOzI7o0LtX1Btj1aFZAl5asWyaVidRTOjm5rmN2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174107; c=relaxed/simple;
	bh=U2wnVl8pDpqYK/SSLtC+00Xk9FtRH+TTGkidqBfsoL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzGNvGmKXFQbaF+Cy6GYQoGrce2Wb7gS8tCXoWTHYnBN07LAWUQoepkeR06XT6a2LrdJhXWhcTuHXkCHEy4+ALrOTmCsYUON6rmWqXrSdeqiYXGYvnnT7sOTuKpZz+ap6PKrG83jQg+5SPKBo632nPxdOnFSuZWolUg8pL0UPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOpmMi5d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431695fa98bso25040775e9.3;
        Sat, 09 Nov 2024 09:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731174104; x=1731778904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIZ3Pod6uFsC5aQPwLz1gT8xGdaob9qbUQFVgHnwKdc=;
        b=fOpmMi5dHiAvUhrqzzef0tSGmS+oSEDE3rrM87HUrSpo1ua/V/pwtoyJcMeWNIcm2f
         0pVZZmT/SBR0QTcznPQX1Z16wrE0NgT+l/ZmVRELcAinSIXjp1fc/t0f7C39vf+1cG6d
         7FgoF9sXsLdGbr4L/lWK2JtbVnRA1cWWzxTbWV+3vE/hXBWchv0TaX3dzeAGyNgMurzN
         v6+rnBzP7fK8FA7YjQIoXPslbZrmZfWmS2LdsV3w1s+/V52Jf7JHYGoS2mRJQO39VDy9
         gCvBoCCmM0JfSXQFfAlzPA48R6o8o0uVkimNeC+fep7ATe7YS084meJ0myanjUyUpQuZ
         t1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731174104; x=1731778904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIZ3Pod6uFsC5aQPwLz1gT8xGdaob9qbUQFVgHnwKdc=;
        b=tEmq8cUGglXb+2ODj2AXizomUC2XO7MGuySr2+TKaKM/qTJmNsvbGntmMkd+9yvUyL
         A1Tm6rWsaBkwLYZE7M3UF9LzT4ZasfsYALOUNcJQ+u9UzIG5kDWZ0K31HCJx1Eqo5rQl
         xI0V/F+ACcGVQC4beU6Or9vUEuexMF31FrQ5zQOG96+SCkBPC/a/UOWRpIfdhT2cfdFB
         e1KQfa10wUJ+XtaBcl/RHXv87JtbEUpqMA98Y3c13A3CrmX1Ooi05yU4wpe/dqF3E5yn
         dnXU9xEXL+4RZYT1umKT7SbIekRLUGnQD9zOoAUB/rq06cwKcUejiM1cZBXz9NJucwsw
         tKhw==
X-Forwarded-Encrypted: i=1; AJvYcCUEhxk0cepdpk0SYEa7WfBSXlYHpRpL4GIu9xehCTsFw7/qeAdLv795D1XVwb8Tn5fOL/GjAKYulbiK@vger.kernel.org, AJvYcCVwrFR20Ly8rnFaSsz26d9go2qWF4nvvDPSpLAiE8mjGIxHB8gmJzWDroKvQmmSw3RIWzKEK3mguZqN@vger.kernel.org, AJvYcCW8XF4ntiDimYC4gIkoM9PLxbjmlGnmBvMNm/pqqiHiUrLUTKe71ttiKkiwbqtIIrhwpz2BQHEwJF82NT9d@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHAvw4BScv59BwR2+/ePuO2KuD/y1xHX/whRn3hGSsLxprBrx
	2eDsQfEuo0rCl3ZM2IhmalIaxareybetZVZimW6xwbJwgdJJ1OugVN6MyjEy
X-Google-Smtp-Source: AGHT+IEMOOyIS55ppOvL6DvcS0XGFUmYzvw5oO2Kv4ll57MkqvnrbNWQflKFLgTc4kK0Uo/519aKnA==
X-Received: by 2002:a05:600c:3ca4:b0:42c:a6da:a149 with SMTP id 5b1f17b1804b1-432b751839dmr63047175e9.25.1731174103710;
        Sat, 09 Nov 2024 09:41:43 -0800 (PST)
Received: from debian.fritz.box ([2a00:79c0:605:8200:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm117582285e9.30.2024.11.09.09.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 09:41:43 -0800 (PST)
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
Subject: [PATCH v7 2/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Sat,  9 Nov 2024 18:41:35 +0100
Message-Id: <20241109174135.26292-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241109174135.26292-1-dima.fedrau@gmail.com>
References: <20241109174135.26292-1-dima.fedrau@gmail.com>
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
 drivers/pwm/pwm-mc33xs2410.c | 388 +++++++++++++++++++++++++++++++++++
 3 files changed, 401 insertions(+)
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
index 000000000000..97cf31ef608a
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,388 @@
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
+#define MC33XS2410_GLB_CTRL		0x00
+#define MC33XS2410_GLB_CTRL_MODE	GENMASK(7, 6)
+#define MC33XS2410_GLB_CTRL_MODE_NORMAL	FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
+
+#define MC33XS2410_PWM_CTRL1		0x05
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT((x - 1))
+
+#define MC33XS2410_PWM_CTRL3		0x07
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x - 1))
+
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_FREQ(x)		(0x08 + (x - 1))
+#define MC33XS2410_PWM_FREQ_STEP	GENMASK(7, 6)
+#define MC33XS2410_PWM_FREQ_COUNT	GENMASK(5, 0)
+
+/* x in { 1 ... 4 } */
+#define MC33XS2410_PWM_DC(x)		(0x0c + (x - 1))
+
+#define MC33XS2410_WDT			0x14
+
+#define MC33XS2410_PWM_MIN_PERIOD	488282
+/* x in { 0 ... 3 } */
+#define MC33XS2410_PWM_MAX_PERIOD(x)	(2000000000 >> (2 * x))
+
+#define MC33XS2410_FRAME_IN_ADDR	GENMASK(15, 8)
+#define MC33XS2410_FRAME_IN_DATA	GENMASK(7, 0)
+#define MC33XS2410_FRAME_IN_ADDR_WR	BIT(7)
+#define MC33XS2410_FRAME_IN_DATA_RD	BIT(7)
+#define MC33XS2410_FRAME_OUT_DATA	GENMASK(13, 0)
+
+#define MC33XS2410_MAX_TRANSFERS	5
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
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_from_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
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
+	/* enable output */
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
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_from_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u8 reg[4] = {
+			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
+			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
+			MC33XS2410_PWM_CTRL1,
+			MC33XS2410_PWM_CTRL3,
+		    };
+	u16 val[4];
+	int ret;
+
+	ret = mc33xs2410_read_regs(spi, reg, MC33XS2410_FRAME_IN_DATA_RD, val, 4);
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
+	struct mc33xs2410_pwm *mc33xs2410;
+	struct device *dev = &spi->dev;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*mc33xs2410));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	spi->bits_per_word = 16;
+	spi->mode |= SPI_CS_WORD;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
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


