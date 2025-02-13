Return-Path: <linux-pwm+bounces-4876-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B822BA33B67
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 10:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290E6188A1C8
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA2210F58;
	Thu, 13 Feb 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSNjgpv9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133EB20DD72;
	Thu, 13 Feb 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439669; cv=none; b=AWHFYGmYcuZf/1YtMgRN5FD33Byj4dtzHLWjWrPQYgL5YJvYHzTJKSeXnANKt7NvXwGotEnD9RUiCjAeVPGF4wBWOESsX1E5bgjZy4UcrGM9GfMfp4UaENoPhvp/QddCp6uu+JDbRJ1hOYimPJll6Xn0/Gwz2ym0/PG5uo2SXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439669; c=relaxed/simple;
	bh=poSdOQLJ0aa+ypG4bhoxUZ6eDX7/QqkKUD+mmfU8Dto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODG6tG4mYejD/xe8OiWdBkG3DpzCXv3fNZ0s+WuHlIRXdBPE71N4rX9e2WYHkCFh27irvOzR9748AexG6V8u0gUD7Zfzhp0ycUBNVKAKfOezNwAazilcE/T9UxsTmIQXjTPep3zdl7in6vJ6FLIWwITYf6NvQLBi1aBTHolt/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSNjgpv9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5450408455dso679850e87.0;
        Thu, 13 Feb 2025 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739439665; x=1740044465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NmeS9foi57N6w4no4pH/e8F+/9zjxmhS+0FDke+vdk=;
        b=NSNjgpv96KHRWwMJm86WeQCqxmbi9Duz8d7CNB8jZhPDrv0CddlEV4rigx0hN6FQEl
         L4DI7GH9RoCXQ8RjRBb/ban2rQY/znywl5uWNMqN3i65myL63ZGSk+8mPXDG6DArIlDK
         xOgS/0Z3If52pOC5cWaUvlydHia6QBoISgYiv6v0JqpUXFm70nSDU0Q8bi1E91ylXiBT
         FK5W7zHYI2/Ms6SHT2LOOi4n3azcUDLNeQ429o3h8oSnHVof2Tu3TpnvjXQ5hecJBoBV
         u03Yvw+6JZjfaxQ7j/0uYEat2DhQ/KlXv7oUuIMQcp+IRSW3C8ytNfXFGdHo5VHGJ9/s
         92zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439665; x=1740044465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NmeS9foi57N6w4no4pH/e8F+/9zjxmhS+0FDke+vdk=;
        b=KpvrfBpRGIrjBVQVT2hQcI953+BbOyZEMLPpeBFynFbqW/R8NoDTozgJzhKIxPjxlb
         EQ/g7N60d0M2/7Luh4DjwPNpaJVhsMTWaQ8uSDOAyyoUurGM/scqlzNGOrfw3QeYkoiS
         eUEBCLuNc7Z6Yb17IdO7veOXblVgvMhCp7tu2bV3TLAm5SrwYIZvwsBz7qXusB2NWSFO
         eUg8C6P3ucvoroPqWoi/S3A2aV6hcrAQIKtFZ8oZGe/T6u7n4E4qz0puGN9uQDRKXvRc
         b1lr4NWe2Ewt0T/gGKT5kxzauSRnh61MzM0OBlqmOrqay5IqNhbMIB+4AKfH0aMklCCy
         kAeA==
X-Forwarded-Encrypted: i=1; AJvYcCUjh5aYAz35pbVoSDsTZwBGS/U1C4a39DX8lLwFoaafIDPMMVhjqlCyzP8YHwa5pP6wHM+owI9OPzEI@vger.kernel.org, AJvYcCVFQJPCMSXK6fM9WnKUUTsRh9zK174Pg9StfuVxNZFqp2nu4GkPAAT9hxMWQJYKybv276fZzlyhsxw2@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7Z6+Hp/SR5oKX4GKey32YvjvjARnkAyT+GZDaE1ZehXhZZbz
	ZHT8xfcChr7xM2FndGGXjmZBoQHF7u7HnZ6EiN+HS+wXubhNhHwlgDjoz0kNMKtJ
X-Gm-Gg: ASbGncsGR03XBckQFLtQKJ0o04kYo8MkNqo/SPERWkI5+vjMcB0xy7KoJJAgZ5SoTEX
	+ykSj721q+JaGdZGOxs9Tgw1X+1dmf6UtNQDsvwxNkZZ5/PQg1g4ZqFs5OBahfPK0pz3beDH0wU
	LzNYVpIaConBqxo6exZezP1l5ozKo5whyLO4Wr4SskjP+vIUCG9FaRs2c5YqMWNKkDUxn3Duemf
	BuU3VUUKdjLqfFcK9CHMVE+O3ri8P283nja4dLnsuQ71Eb7eqnNOp5z3b8Atj5L34Y/N4YEq1zz
	cLGCn3DJW3Y8i26RGo0Rd8oaFMuypPA=
X-Google-Smtp-Source: AGHT+IHH0kPe6LBC8uhMeUjIrHu12aHBMxWW4e5nB5bx4fSeJedqf8Yf3xtC90RHKNWC0VLXDt4VJA==
X-Received: by 2002:a05:6512:3f0d:b0:545:532:fd2f with SMTP id 2adb3069b0e04-5451dd9274emr743078e87.12.1739439664464;
        Thu, 13 Feb 2025 01:41:04 -0800 (PST)
Received: from localhost.localdomain ([178.176.176.188])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cae7sm119518e87.183.2025.02.13.01.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:41:04 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
Date: Thu, 13 Feb 2025 12:40:13 +0300
Message-Id: <20250213094018.134081-3-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213094018.134081-1-privatesub2@gmail.com>
References: <20250213094018.134081-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
controllers with ones supported by pwm-sun4i driver.

This patch adds a PWM controller driver for Allwinner's D1,
T113-S3 and R329 SoCs. The main difference between these SoCs
is the number of channels defined by the DT property.

Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sun20i.c | 370 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun20i.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..778151aa3860 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -652,6 +652,16 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN20I
+	tristate "Allwinner D1/T113s/R329 PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun20i.
+
 config PWM_SUNPLUS
 	tristate "Sunplus PWM support"
 	depends on ARCH_SUNPLUS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e0..85ad1fe0dde1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN20I)	+= pwm-sun20i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
new file mode 100644
index 000000000000..409fa8e9bc45
--- /dev/null
+++ b/drivers/pwm/pwm-sun20i.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
+ *
+ * Limitations:
+ * - When the parameters change, the current running period is not completed
+ *   and new settings are applied immediately.
+ * - The PWM output goes to a HIGH-Z state when the channel is disabled.
+ * - Changing the clock configuration (SUN20I_PWM_CLK_CFG)
+ * - may cause a brief output glitch.
+ *
+ * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#define SUN20I_PWM_CLK_CFG(pair)		(0x20 + ((pair) * 0x4))
+#define SUN20I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
+#define SUN20I_PWM_CLK_CFG_DIV_M		GENMASK(3, 0)
+#define SUN20I_PWM_CLK_DIV_M_MAX		8
+
+#define SUN20I_PWM_CLK_GATE			0x40
+#define SUN20I_PWM_CLK_GATE_BYPASS(chan)	BIT((chan) + 16)
+#define SUN20I_PWM_CLK_GATE_GATING(chan)	BIT(chan)
+
+#define SUN20I_PWM_ENABLE			0x80
+#define SUN20I_PWM_ENABLE_EN(chan)		BIT(chan)
+
+#define SUN20I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
+#define SUN20I_PWM_CTL_ACT_STA			BIT(8)
+#define SUN20I_PWM_CTL_PRESCAL_K		GENMASK(7, 0)
+#define SUN20I_PWM_CTL_PRESCAL_K_MAX		field_max(SUN20I_PWM_CTL_PRESCAL_K)
+
+#define SUN20I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
+#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
+#define SUN20I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
+
+#define SUN20I_PWM_PCNTR_SIZE			BIT(16)
+
+/*
+ * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock dividers
+ * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL_K)
+ * without using a loop. These dividers limit the # of cycles in a period
+ * to SUN20I_PWM_PCNTR_SIZE (65536) by applying a scaling factor of
+ * 1/(div_m * (prescale_k + 1)) to the clock source.
+ *
+ * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
+ * such that for a given requested period,
+ *
+ * i) div_m is minimized for any prescale_k ≤ SUN20I_PWM_CTL_PRESCAL_K_MAX,
+ * ii) prescale_k is minimized.
+ *
+ * The derivation proceeds as follows, with val = # of cycles for requested
+ * period:
+ *
+ * for a given value of div_m we want the smallest prescale_k such that
+ *
+ * (val >> div_m) // (prescale_k + 1) ≤ 65536 (= SUN20I_PWM_PCNTR_SIZE)
+ *
+ * This is equivalent to:
+ *
+ * (val >> div_m) ≤ 65536 * (prescale_k + 1) + prescale_k
+ * ⟺ (val >> div_m) ≤ 65537 * prescale_k + 65536
+ * ⟺ (val >> div_m) - 65536 ≤ 65537 * prescale_k
+ * ⟺ ((val >> div_m) - 65536) / 65537 ≤ prescale_k
+ *
+ * As prescale_k is integer, this becomes
+ *
+ * ((val >> div_m) - 65536) // 65537 ≤ prescale_k
+ *
+ * And is minimized at
+ *
+ * ((val >> div_m) - 65536) // 65537
+ *
+ * Now we pick the smallest div_m that satifies prescale_k ≤ 255
+ * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
+ *
+ * ((val >> div_m) - 65536) // 65537 ≤ 255
+ * ⟺ (val >> div_m) - 65536 ≤ 255 * 65537 + 65536
+ * ⟺ val >> div_m ≤ 255 * 65537 + 2 * 65536
+ * ⟺ val >> div_m < (255 * 65537 + 2 * 65536 + 1)
+ * ⟺ div_m = fls((val) / (255 * 65537 + 2 * 65536 + 1))
+ *
+ * Suggested by Uwe Kleine-König
+ */
+#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
+#define SUN20I_PWM_DIV_CONST			65537
+
+struct sun20i_pwm_chip {
+	struct clk *clk_hosc, *clk_apb;
+	void __iomem *base;
+};
+
+static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
+				   unsigned long offset)
+{
+	return readl(chip->base + offset);
+}
+
+static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
+				     u32 val, unsigned long offset)
+{
+	writel(val, chip->base + offset);
+}
+
+static int sun20i_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
+	u16 ent_cycle, act_cycle, prescale_k;
+	u64 clk_rate, tmp;
+	u8 div_m;
+	u32 val;
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2));
+	div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
+	if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
+		div_m = SUN20I_PWM_CLK_DIV_M_MAX;
+
+	/*
+	 * If CLK_CFG_SRC is 0, use the hosc clock;
+	 * otherwise (any nonzero value) use the APB clock.
+	 */
+	if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) == 0)
+		clk_rate = clk_get_rate(sun20i_chip->clk_hosc);
+	else
+		clk_rate = clk_get_rate(sun20i_chip->clk_apb);
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
+	state->polarity = (SUN20I_PWM_CTL_ACT_STA & val) ?
+			   PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
+
+	prescale_k = FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
+	state->enabled = (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : false;
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpwm));
+
+	act_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
+	ent_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
+
+	/*
+	 * The duration of the active phase should not be longer
+	 * than the duration of the period
+	 */
+	if (act_cycle > ent_cycle)
+		act_cycle = ent_cycle;
+
+	/*
+	 * We have act_cycle <= ent_cycle <= 0xffff, prescale_k <= 0x100,
+	 * div_m <= 8. So the multiplication fits into an u64 without
+	 * overflow.
+	 */
+	tmp = ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, clk_rate);
+	tmp = ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_UP_ULL(tmp, clk_rate);
+
+	return 0;
+}
+
+static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
+	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
+	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
+	u32 prescale_k, div_m;
+	bool use_bus_clk;
+
+	pwm_en = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
+
+	if (state->enabled != pwm->state.enabled) {
+		clk_gate = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_GATE);
+
+		if (!state->enabled) {
+			clk_gate &= ~SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
+			pwm_en &= ~SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
+			sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
+			sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
+
+			return 0;
+		}
+	}
+
+	ctl = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
+	clk_cfg = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2));
+	hosc_rate = clk_get_rate(sun20i_chip->clk_hosc);
+	bus_rate = clk_get_rate(sun20i_chip->clk_apb);
+	if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
+		/* If the neighbor channel is enabled, use the current clock settings */
+		use_bus_clk = FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) != 0;
+		val = mul_u64_u64_div_u64(state->period,
+					  (use_bus_clk ? bus_rate : hosc_rate),
+					  NSEC_PER_SEC);
+
+		div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
+	} else {
+		/*
+		 * Select the clock source based on the period.
+		 * Since bus_rate > hosc_rate, which means bus_rate
+		 * can provide a higher frequency than hosc_rate.
+		 */
+		use_bus_clk = false;
+		val = mul_u64_u64_div_u64(state->period, hosc_rate, NSEC_PER_SEC);
+		/*
+		 * If the calculated value is ≤ 1, the period is too short
+		 * for proper PWM operation
+		 */
+		if (val <= 1) {
+			use_bus_clk = true;
+			val = mul_u64_u64_div_u64(state->period, bus_rate, NSEC_PER_SEC);
+			if (val <= 1)
+				return -EINVAL;
+		}
+		div_m = fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
+		if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
+			return -EINVAL;
+
+		/* Set up the CLK_DIV_M and clock CLK_SRC */
+		clk_cfg = FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
+		clk_cfg |= FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_clk);
+
+		sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2));
+	}
+
+	/* Calculate prescale_k and determine the number of cycles for a full PWM period */
+	ent_cycle = val >> div_m;
+	prescale_k = DIV_ROUND_DOWN_ULL(ent_cycle, SUN20I_PWM_DIV_CONST);
+	if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
+		prescale_k = SUN20I_PWM_CTL_PRESCAL_K_MAX;
+
+	/* ent_cycle must not be zero */
+	if (ent_cycle == 0)
+		return -EINVAL;
+	do_div(ent_cycle, prescale_k + 1);
+
+	/* For N cycles, PPRx.PWM_ENTIRE_CYCLE = (N-1) */
+	reg_period = FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - 1);
+
+	/* Calculate the active cycles (duty cycle) */
+	val = mul_u64_u64_div_u64(state->duty_cycle,
+				  (use_bus_clk ? bus_rate : hosc_rate),
+				  NSEC_PER_SEC);
+	act_cycle = val >> div_m;
+	do_div(act_cycle, prescale_k + 1);
+
+	/*
+	 * The formula of the output period and the duty-cycle for PWM are as follows.
+	 * T period = PWM0_PRESCALE_K / PWM01_CLK * (PPR0.PWM_ENTIRE_CYCLE + 1)
+	 * T high-level = PWM0_PRESCALE_K / PWM01_CLK * PPR0.PWM_ACT_CYCLE
+	 * Duty-cycle = T high-level / T period
+	 */
+	reg_period |= FIELD_PREP(SUN20I_PWM_PERIOD_ACT_CYCLE, act_cycle);
+	sun20i_pwm_writel(sun20i_chip, reg_period, SUN20I_PWM_PERIOD(pwm->hwpwm));
+
+	ctl = FIELD_PREP(SUN20I_PWM_CTL_PRESCAL_K, prescale_k);
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		ctl |= SUN20I_PWM_CTL_ACT_STA;
+
+	sun20i_pwm_writel(sun20i_chip, ctl, SUN20I_PWM_CTL(pwm->hwpwm));
+
+	if (state->enabled != pwm->state.enabled) {
+		clk_gate &= ~SUN20I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
+		clk_gate |= SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
+		pwm_en |= SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
+		sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
+		sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops sun20i_pwm_ops = {
+	.apply = sun20i_pwm_apply,
+	.get_state = sun20i_pwm_get_state,
+};
+
+static const struct of_device_id sun20i_pwm_dt_ids[] = {
+	{ .compatible = "allwinner,sun20i-d1-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
+
+static int sun20i_pwm_probe(struct platform_device *pdev)
+{
+	struct pwm_chip *chip;
+	struct sun20i_pwm_chip *sun20i_chip;
+	struct clk *clk_bus;
+	struct reset_control *rst;
+	u32 npwm;
+	int ret;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "allwinner,npwms", &npwm);
+	if (ret < 0)
+		npwm = 8; /* Default value */
+
+	if (npwm > 16) {
+		dev_info(&pdev->dev, "Limiting number of PWM lines from %u to 16", npwm);
+		npwm = 16;
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*sun20i_chip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	sun20i_chip = to_sun20i_pwm_chip(chip);
+
+	sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sun20i_chip->base))
+		return PTR_ERR(sun20i_chip->base);
+
+	clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
+	if (IS_ERR(clk_bus))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk_bus),
+				     "Failed to get bus clock\n");
+
+	sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
+	if (IS_ERR(sun20i_chip->clk_hosc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
+				     "Failed to get hosc clock\n");
+
+	sun20i_chip->clk_apb = devm_clk_get_enabled(&pdev->dev, "apb");
+	if (IS_ERR(sun20i_chip->clk_apb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb),
+				     "Failed to get apb clock\n");
+
+	if (clk_get_rate(sun20i_chip->clk_apb) <= clk_get_rate(sun20i_chip->clk_hosc))
+		dev_info(&pdev->dev, "APB clock must be greater than hosc clock");
+
+	rst = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
+				     "Failed to get reset control\n");
+
+	chip->ops = &sun20i_pwm_ops;
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver sun20i_pwm_driver = {
+	.driver = {
+		.name = "sun20i-pwm",
+		.of_match_table = sun20i_pwm_dt_ids,
+	},
+	.probe = sun20i_pwm_probe,
+};
+module_platform_driver(sun20i_pwm_driver);
+
+MODULE_AUTHOR("Aleksandr Shubin <privatesub2@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun20i PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


