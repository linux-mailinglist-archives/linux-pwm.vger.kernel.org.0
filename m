Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2127BB64
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 05:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgI2DPC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 23:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgI2DOs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 23:14:48 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3625C061755
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 20:14:47 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u126so3817591oif.13
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 20:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+xk58zjsO2StCQDbyTr0Z8ok+0zBySXt4f6h7DK3zg=;
        b=magUqWfGZHXhTWofqBzQTouaIW6QOrImMbIFc8xjN+5qSR6x8CK7UeKXIzQvON/AKi
         4OZ1y5mJCxukRGk0XlHWVbbeCEkl0O2aLToF56ilbY9c82uE9IZwfzYHWXR6dKrtDP1T
         5FWZ+/0Mn/OQJGA67dYHjAaYfwBeqvN9ZGjn7mmnwCSCZF+SZuvke42tegmcqLXi5Et0
         0tzWjB3LL5rMItY3p4iDWM4rfvGHZjbpbVYb0wXRJYEisrw4+rCW/FgmfbyovWdv2/W6
         cx9EPS1bgT0QWL67Po/psB62lFL6RpvDr4tb328/fh7SIF0st5eFiIvVgC7Uw9s7ATSu
         QOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+xk58zjsO2StCQDbyTr0Z8ok+0zBySXt4f6h7DK3zg=;
        b=puONaiJfmGr96H3ESKIl0g1xz+TVmQMPJk4o3bhA59k11+k7ZGS13EhdO8w9yPmQno
         m49b41EmdzDnByWDk1bIkgwM3i1PG5SXwGg8m/9K1TzVMEpkp5Z0NvkpLmJ6d7bcyWkx
         n/gHtAyLkWtGrqf6CwgDJKSEUsyhowaETDCoVJ+Ac1y5KoN74vfFHJOpSnvyTSY8tk3o
         RllAJPS2H0we8cQygXyQa0utJ5GFa+WS0TmcTK5nZpZaHhkCPIjLDvrSO5873a1Pelja
         wEHV6nbh9kuh7JM8+pX2Kge8sEYkjlmQqOt3uGOTdh4JfRUAlaTCo034FnUxKFlH35R0
         aP3g==
X-Gm-Message-State: AOAM533T6CTudiZ5Z6lX79Nur6h/mlz5FmoT8cWQTLov06M5xKqhr31u
        Ol7rHBNQLfdRbA5HvzTTKafPIw==
X-Google-Smtp-Source: ABdhPJxDtvdzr5bwXCyODnD967WyXJ2OO/jjRC1eI0jIDq5hI80TuvLaFAmmRAJa0htq9kuJsk4RCA==
X-Received: by 2002:aca:913:: with SMTP id 19mr1171105oij.169.1601349286821;
        Mon, 28 Sep 2020 20:14:46 -0700 (PDT)
Received: from localhost.localdomain (99-135-181-32.lightspeed.austtx.sbcglobal.net. [99.135.181.32])
        by smtp.gmail.com with ESMTPSA id 36sm729548otb.30.2020.09.28.20.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:14:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v4 2/4] leds: Add driver for Qualcomm LPG
Date:   Mon, 28 Sep 2020 20:15:42 -0700
Message-Id: <20200929031544.1000204-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
References: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
PMICs from Qualcomm. It can operate on fixed parameters or based on a
lookup-table, altering the duty cycle over time - which provides the
means for e.g. hardware assisted transitions of LED brightness.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Adopt multicolor model
- Simplified hw_pattern implementation

 drivers/leds/Kconfig         |    9 +
 drivers/leds/Makefile        |    1 +
 drivers/leds/leds-qcom-lpg.c | 1213 ++++++++++++++++++++++++++++++++++
 3 files changed, 1223 insertions(+)
 create mode 100644 drivers/leds/leds-qcom-lpg.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 849d3c5f908e..d500648c586f 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -803,6 +803,15 @@ config LEDS_POWERNV
 	  To compile this driver as a module, choose 'm' here: the module
 	  will be called leds-powernv.
 
+config LEDS_QCOM_LPG
+	tristate "LED support for Qualcomm LPG"
+	depends on LEDS_CLASS_MULTICOLOR
+	depends on OF
+	depends on SPMI
+	help
+	  This option enables support for the Light Pulse Generator found in a
+	  wide variety of Qualcomm PMICs.
+
 config LEDS_SYSCON
 	bool "LED support for LEDs on system controllers"
 	depends on LEDS_CLASS=y
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 73e603e1727e..52d0ea26fc35 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_LEDS_PCA963X)		+= leds-pca963x.o
 obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
 obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
+obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
 obj-$(CONFIG_LEDS_REGULATOR)		+= leds-regulator.o
 obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
diff --git a/drivers/leds/leds-qcom-lpg.c b/drivers/leds/leds-qcom-lpg.c
new file mode 100644
index 000000000000..17594ce37c9a
--- /dev/null
+++ b/drivers/leds/leds-qcom-lpg.c
@@ -0,0 +1,1213 @@
+/*
+ * Copyright (c) 2017-2019 Linaro Ltd
+ * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/led-class-multicolor.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define LPG_PATTERN_CONFIG_REG	0x40
+#define LPG_SIZE_CLK_REG	0x41
+#define LPG_PREDIV_CLK_REG	0x42
+#define PWM_TYPE_CONFIG_REG	0x43
+#define PWM_VALUE_REG		0x44
+#define PWM_ENABLE_CONTROL_REG	0x46
+#define PWM_SYNC_REG		0x47
+#define LPG_RAMP_DURATION_REG	0x50
+#define LPG_HI_PAUSE_REG	0x52
+#define LPG_LO_PAUSE_REG	0x54
+#define LPG_HI_IDX_REG		0x56
+#define LPG_LO_IDX_REG		0x57
+#define PWM_SEC_ACCESS_REG	0xd0
+#define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
+
+#define TRI_LED_SRC_SEL		0x45
+#define TRI_LED_EN_CTL		0x46
+#define TRI_LED_ATC_CTL		0x47
+
+#define LPG_LUT_REG(x)		(0x40 + (x) * 2)
+#define RAMP_CONTROL_REG	0xc8
+
+struct lpg_channel;
+struct lpg_data;
+
+/**
+ * struct lpg - LPG device context
+ * @dev:	struct device for LPG device
+ * @map:	regmap for register access
+ * @pwm:	PWM-chip object, if operating in PWM mode
+ * @lut_base:	base address of the LUT block (optional)
+ * @lut_size:	number of entries in the LUT block
+ * @lut_bitmap:	allocation bitmap for LUT entries
+ * @triled_base: base address of the TRILED block (optional)
+ * @triled_src:	power-source for the TRILED
+ * @channels:	list of PWM channels
+ * @num_channels: number of @channels
+ */
+struct lpg {
+	struct device *dev;
+	struct regmap *map;
+
+	struct pwm_chip pwm;
+
+	const struct lpg_data *data;
+
+	u32 lut_base;
+	u32 lut_size;
+	unsigned long *lut_bitmap;
+
+	u32 triled_base;
+	u32 triled_src;
+
+	struct lpg_channel *channels;
+	unsigned int num_channels;
+};
+
+/**
+ * struct lpg_channel - per channel data
+ * @lpg:	reference to parent lpg
+ * @base:	base address of the PWM channel
+ * @triled_mask: mask in TRILED to enable this channel
+ * @lut_mask:	mask in LUT to start pattern generator for this channel
+ * @in_use:	channel is exposed to LED framework
+ * @color:	color of the LED attached to this channel
+ * @dtest_line:	DTEST line for output, or 0 if disabled
+ * @dtest_value: DTEST line configuration
+ * @pwm_value:	duty (in microseconds) of the generated pulses, overriden by LUT
+ * @enabled:	output enabled?
+ * @period_us:	period (in microseconds) of the generated pulses
+ * @pwm_size:	resolution of the @pwm_value, 6 or 9 bits
+ * @clk:	base frequency of the clock generator
+ * @pre_div:	divider of @clk
+ * @pre_div_exp: exponential divider of @clk
+ * @ramp_enabled: duty cycle is driven by iterating over lookup table
+ * @ramp_ping_pong: reverse through pattern, rather than wrapping to start
+ * @ramp_oneshot: perform only a single pass over the pattern
+ * @ramp_reverse: iterate over pattern backwards
+ * @ramp_duration_ms: length (in milliseconds) of one pattern run
+ * @ramp_lo_pause_ms: pause (in milliseconds) before iterating over pattern
+ * @ramp_hi_pause_ms: pause (in milliseconds) after iterating over pattern
+ * @pattern_lo_idx: start index of associated pattern
+ * @pattern_hi_idx: last index of associated pattern
+ */
+struct lpg_channel {
+	struct lpg *lpg;
+
+	u32 base;
+	unsigned int triled_mask;
+	unsigned int lut_mask;
+
+	bool in_use;
+
+	int color;
+
+	u32 dtest_line;
+	u32 dtest_value;
+
+	u16 pwm_value;
+	bool enabled;
+
+	unsigned int period_us;
+	unsigned int pwm_size;
+	unsigned int clk;
+	unsigned int pre_div;
+	unsigned int pre_div_exp;
+
+	bool ramp_enabled;
+	bool ramp_ping_pong;
+	bool ramp_oneshot;
+	bool ramp_reverse;
+	unsigned long ramp_duration_ms;
+	unsigned long ramp_lo_pause_ms;
+	unsigned long ramp_hi_pause_ms;
+
+	unsigned int pattern_lo_idx;
+	unsigned int pattern_hi_idx;
+};
+
+/**
+ * struct lpg_led - logical LED object
+ * @lpg:		lpg context reference
+ * @cdev:		LED class device
+ * @mcdev:		Multicolor LED class device
+ * @num_channels:	number of @channels
+ * @channels:		list of channels associated with the LED
+ */
+struct lpg_led {
+	struct lpg *lpg;
+
+	struct led_classdev cdev;
+	struct led_classdev_mc mcdev;
+
+	unsigned int num_channels;
+	struct lpg_channel *channels[];
+};
+
+/**
+ * struct lpg_channel_data - per channel initialization data
+ * @base:		base address for PWM channel registers
+ * @triled_mask:	bitmask for controlling this channel in TRILED
+ */
+struct lpg_channel_data {
+	unsigned int base;
+	u8 triled_mask;
+};
+
+/**
+ * struct lpg_data - initialization data
+ * @lut_base:		base address of LUT block
+ * @lut_size:		number of entries in LUT
+ * @triled_base:	base address of TRILED
+ * @pwm_9bit_mask:	bitmask for switching from 6bit to 9bit pwm
+ * @num_channels:	number of channels in LPG
+ * @channels:		list of channel initialization data
+ */
+struct lpg_data {
+	unsigned int lut_base;
+	unsigned int lut_size;
+	unsigned int triled_base;
+	unsigned int pwm_9bit_mask;
+	int num_channels;
+	struct lpg_channel_data *channels;
+};
+
+static int triled_set(struct lpg *lpg, unsigned int mask, bool enable)
+{
+	/* Skip if we don't have a triled block */
+	if (!lpg->triled_base)
+		return 0;
+
+	return regmap_update_bits(lpg->map, lpg->triled_base + TRI_LED_EN_CTL,
+				  mask, enable ? mask : 0);
+}
+
+static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
+			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
+{
+	unsigned int idx;
+	u8 val[2];
+	int i;
+
+	/* Hardware does not behave when LO_IDX == HI_IDX */
+	if (len == 1)
+		return -EINVAL;
+
+	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
+					 0, len, 0);
+	if (idx >= lpg->lut_size)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		val[0] = pattern[i].brightness & 0xff;
+		val[1] = pattern[i].brightness >> 8;
+
+		regmap_bulk_write(lpg->map,
+				  lpg->lut_base + LPG_LUT_REG(idx + i), val, 2);
+	}
+
+	bitmap_set(lpg->lut_bitmap, idx, len);
+
+	*lo_idx = idx;
+	*hi_idx = idx + len - 1;
+
+	return 0;
+}
+
+static void lpg_lut_free(struct lpg *lpg, unsigned int lo_idx, unsigned int hi_idx)
+{
+	int len;
+
+	if (lo_idx == hi_idx)
+		return;
+
+	len = hi_idx - lo_idx + 1;
+	bitmap_clear(lpg->lut_bitmap, lo_idx, len);
+}
+
+static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
+{
+	return regmap_write(lpg->map, lpg->lut_base + RAMP_CONTROL_REG, mask);
+}
+
+#define NUM_PWM_PREDIV	4
+#define NUM_PWM_CLK	3
+#define NUM_EXP		7
+
+static const unsigned int lpg_clk_table[NUM_PWM_PREDIV][NUM_PWM_CLK] = {
+	{
+		1 * (NSEC_PER_SEC / 1024),
+		1 * (NSEC_PER_SEC / 32768),
+		1 * (NSEC_PER_SEC / 19200000),
+	},
+	{
+		3 * (NSEC_PER_SEC / 1024),
+		3 * (NSEC_PER_SEC / 32768),
+		3 * (NSEC_PER_SEC / 19200000),
+	},
+	{
+		5 * (NSEC_PER_SEC / 1024),
+		5 * (NSEC_PER_SEC / 32768),
+		5 * (NSEC_PER_SEC / 19200000),
+	},
+	{
+		6 * (NSEC_PER_SEC / 1024),
+		6 * (NSEC_PER_SEC / 32768),
+		6 * (NSEC_PER_SEC / 19200000),
+	},
+};
+
+/*
+ * PWM Frequency = Clock Frequency / (N * T)
+ *      or
+ * PWM Period = Clock Period * (N * T)
+ *      where
+ * N = 2^9 or 2^6 for 9-bit or 6-bit PWM size
+ * T = Pre-divide * 2^m, where m = 0..7 (exponent)
+ *
+ * This is the formula to figure out m for the best pre-divide and clock:
+ * (PWM Period / N) = (Pre-divide * Clock Period) * 2^m
+ */
+static void lpg_calc_freq(struct lpg_channel *chan, unsigned int period_us)
+{
+	int             n, m, clk, div;
+	int             best_m, best_div, best_clk;
+	unsigned int    last_err, cur_err, min_err;
+	unsigned int    tmp_p, period_n;
+
+	if (period_us == chan->period_us)
+		return;
+
+	/* PWM Period / N */
+	if (period_us < ((unsigned int)(-1) / NSEC_PER_USEC)) {
+		period_n = (period_us * NSEC_PER_USEC) >> 6;
+		n = 6;
+	} else {
+		period_n = (period_us >> 9) * NSEC_PER_USEC;
+		n = 9;
+	}
+
+	min_err = last_err = (unsigned int)(-1);
+	best_m = 0;
+	best_clk = 0;
+	best_div = 0;
+	for (clk = 0; clk < NUM_PWM_CLK; clk++) {
+		for (div = 0; div < NUM_PWM_PREDIV; div++) {
+			/* period_n = (PWM Period / N) */
+			/* tmp_p = (Pre-divide * Clock Period) * 2^m */
+			tmp_p = lpg_clk_table[div][clk];
+			for (m = 0; m <= NUM_EXP; m++) {
+				if (period_n > tmp_p)
+					cur_err = period_n - tmp_p;
+				else
+					cur_err = tmp_p - period_n;
+
+				if (cur_err < min_err) {
+					min_err = cur_err;
+					best_m = m;
+					best_clk = clk;
+					best_div = div;
+				}
+
+				if (m && cur_err > last_err)
+					/* Break for bigger cur_err */
+					break;
+
+				last_err = cur_err;
+				tmp_p <<= 1;
+			}
+		}
+	}
+
+	/* Use higher resolution */
+	if (best_m >= 3 && n == 6) {
+		n += 3;
+		best_m -= 3;
+	}
+
+	chan->clk = best_clk;
+	chan->pre_div = best_div;
+	chan->pre_div_exp = best_m;
+	chan->pwm_size = n;
+
+	chan->period_us = period_us;
+}
+
+static void lpg_calc_duty(struct lpg_channel *chan, unsigned int duty_us)
+{
+	unsigned long max = (1 << chan->pwm_size) - 1;
+	unsigned long val;
+
+	/* Figure out pwm_value with overflow handling */
+	if (duty_us < 1 << (sizeof(val) * 8 - chan->pwm_size))
+		val = (duty_us << chan->pwm_size) / chan->period_us;
+	else
+		val = duty_us / (chan->period_us >> chan->pwm_size);
+
+	if (val > max)
+		val = max;
+
+	chan->pwm_value = val;
+}
+
+static void lpg_apply_freq(struct lpg_channel *chan)
+{
+	unsigned long val;
+	struct lpg *lpg = chan->lpg;
+
+	if (!chan->enabled)
+		return;
+
+	/* Clock register values are off-by-one from lpg_clk_table */
+	val = chan->clk + 1;
+
+	if (chan->pwm_size == 9)
+		val |= lpg->data->pwm_9bit_mask;
+
+	regmap_write(lpg->map, chan->base + LPG_SIZE_CLK_REG, val);
+
+	val = chan->pre_div << 5 | chan->pre_div_exp;
+	regmap_write(lpg->map, chan->base + LPG_PREDIV_CLK_REG, val);
+}
+
+#define LPG_ENABLE_GLITCH_REMOVAL	BIT(5)
+
+static void lpg_enable_glitch(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
+			   LPG_ENABLE_GLITCH_REMOVAL, 0);
+}
+
+static void lpg_disable_glitch(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
+			   LPG_ENABLE_GLITCH_REMOVAL,
+			   LPG_ENABLE_GLITCH_REMOVAL);
+}
+
+static void lpg_apply_pwm_value(struct lpg_channel *chan)
+{
+	u8 val[] = { chan->pwm_value & 0xff, chan->pwm_value >> 8 };
+	struct lpg *lpg = chan->lpg;
+
+	if (!chan->enabled)
+		return;
+
+	regmap_bulk_write(lpg->map, chan->base + PWM_VALUE_REG, val, 2);
+}
+
+#define LPG_PATTERN_CONFIG_LO_TO_HI	BIT(4)
+#define LPG_PATTERN_CONFIG_REPEAT	BIT(3)
+#define LPG_PATTERN_CONFIG_TOGGLE	BIT(2)
+#define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
+#define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
+
+static void lpg_apply_lut_control(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+	unsigned int hi_pause;
+	unsigned int lo_pause;
+	unsigned int step;
+	unsigned int conf = 0;
+	unsigned int lo_idx = chan->pattern_lo_idx;
+	unsigned int hi_idx = chan->pattern_hi_idx;
+	int pattern_len;
+
+	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
+		return;
+
+	pattern_len = hi_idx - lo_idx + 1;
+
+	step = DIV_ROUND_UP(chan->ramp_duration_ms, pattern_len);
+	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, step);
+	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, step);
+
+	if (!chan->ramp_reverse)
+		conf |= LPG_PATTERN_CONFIG_LO_TO_HI;
+	if (!chan->ramp_oneshot)
+		conf |= LPG_PATTERN_CONFIG_REPEAT;
+	if (chan->ramp_ping_pong)
+		conf |= LPG_PATTERN_CONFIG_TOGGLE;
+	if (chan->ramp_hi_pause_ms)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_HI;
+	if (chan->ramp_lo_pause_ms)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_LO;
+
+	regmap_write(lpg->map, chan->base + LPG_PATTERN_CONFIG_REG, conf);
+	regmap_write(lpg->map, chan->base + LPG_HI_IDX_REG, hi_idx);
+	regmap_write(lpg->map, chan->base + LPG_LO_IDX_REG, lo_idx);
+
+	regmap_write(lpg->map, chan->base + LPG_RAMP_DURATION_REG, step);
+	regmap_write(lpg->map, chan->base + LPG_HI_PAUSE_REG, hi_pause);
+	regmap_write(lpg->map, chan->base + LPG_LO_PAUSE_REG, lo_pause);
+}
+
+#define LPG_ENABLE_CONTROL_OUTPUT		BIT(7)
+#define LPG_ENABLE_CONTROL_BUFFER_TRISTATE	BIT(5)
+#define LPG_ENABLE_CONTROL_SRC_PWM		BIT(2)
+#define LPG_ENABLE_CONTROL_RAMP_GEN		BIT(1)
+
+static void lpg_apply_control(struct lpg_channel *chan)
+{
+	unsigned int ctrl;
+	struct lpg *lpg = chan->lpg;
+
+	ctrl = LPG_ENABLE_CONTROL_BUFFER_TRISTATE;
+
+	if (chan->enabled)
+		ctrl |= LPG_ENABLE_CONTROL_OUTPUT;
+
+	if (chan->pattern_lo_idx != chan->pattern_hi_idx)
+		ctrl |= LPG_ENABLE_CONTROL_RAMP_GEN;
+	else
+		ctrl |= LPG_ENABLE_CONTROL_SRC_PWM;
+
+	regmap_write(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG, ctrl);
+
+	/*
+	 * Due to LPG hardware bug, in the PWM mode, having enabled PWM,
+	 * We have to write PWM values one more time.
+	 */
+	if (chan->enabled)
+		lpg_apply_pwm_value(chan);
+}
+
+#define LPG_SYNC_PWM	BIT(0)
+
+static void lpg_apply_sync(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	regmap_write(lpg->map, chan->base + PWM_SYNC_REG, LPG_SYNC_PWM);
+}
+
+static void lpg_apply_dtest(struct lpg_channel *chan)
+{
+	struct lpg *lpg = chan->lpg;
+
+	if (!chan->dtest_line)
+		return;
+
+	regmap_write(lpg->map, chan->base + PWM_SEC_ACCESS_REG, 0xa5);
+	regmap_write(lpg->map, chan->base + PWM_DTEST_REG(chan->dtest_line),
+		     chan->dtest_value);
+}
+
+static void lpg_apply(struct lpg_channel *chan)
+{
+	lpg_disable_glitch(chan);
+	lpg_apply_freq(chan);
+	lpg_apply_pwm_value(chan);
+	lpg_apply_control(chan);
+	lpg_apply_sync(chan);
+	lpg_apply_lut_control(chan);
+	lpg_enable_glitch(chan);
+}
+
+static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
+			       struct mc_subled *subleds)
+{
+	enum led_brightness brightness;
+	struct lpg_channel *chan;
+	unsigned int triled_mask = 0;
+	unsigned int lut_mask = 0;
+	unsigned int duty_us;
+	struct lpg *lpg = led->lpg;
+	int i;
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+		brightness = subleds[i].brightness;
+
+		if (brightness == LED_OFF) {
+			chan->enabled = false;
+			chan->ramp_enabled = false;
+		} else if (chan->pattern_lo_idx != chan->pattern_hi_idx) {
+			lpg_calc_freq(chan, NSEC_PER_USEC);
+
+			chan->enabled = true;
+			chan->ramp_enabled = true;
+
+			lut_mask |= chan->lut_mask;
+			triled_mask |= chan->triled_mask;
+		} else {
+			lpg_calc_freq(chan, NSEC_PER_USEC);
+
+			duty_us = brightness * chan->period_us / cdev->max_brightness;
+			lpg_calc_duty(chan, duty_us);
+			chan->enabled = true;
+			chan->ramp_enabled = false;
+
+			triled_mask |= chan->triled_mask;
+		}
+
+		lpg_apply(chan);
+	}
+
+	/* Toggle triled lines */
+	if (triled_mask)
+		triled_set(lpg, triled_mask, chan->enabled);
+
+	/* Trigger start of ramp generator(s) */
+	if (lut_mask)
+		lpg_lut_sync(lpg, lut_mask);
+}
+
+static void lpg_brightness_single_set(struct led_classdev *cdev,
+				      enum led_brightness value)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+	struct mc_subled info;
+
+	info.brightness = value;
+	lpg_brightness_set(led, cdev, &info);
+}
+
+static void lpg_brightness_mc_set(struct led_classdev *cdev,
+				  enum led_brightness value)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+
+	led_mc_calc_color_components(mc, value);
+	lpg_brightness_set(led, cdev, mc->subled_info);
+}
+
+static int lpg_blink_set(struct lpg_led *led,
+			 unsigned long delay_on, unsigned long delay_off)
+{
+	struct lpg_channel *chan;
+	unsigned int period_us;
+	unsigned int duty_us;
+	int i;
+
+	if (!delay_on && !delay_off) {
+		delay_on = 500;
+		delay_off = 500;
+	}
+
+	duty_us = delay_on * USEC_PER_MSEC;
+	period_us = (delay_on + delay_off) * USEC_PER_MSEC;
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+
+		lpg_calc_freq(chan, period_us);
+		lpg_calc_duty(chan, duty_us);
+
+		chan->enabled = true;
+		chan->ramp_enabled = false;
+
+		lpg_apply(chan);
+	}
+
+	return 0;
+}
+
+static int lpg_blink_single_set(struct led_classdev *cdev,
+				unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+
+	return lpg_blink_set(led, *delay_on, *delay_off);
+}
+
+static int lpg_blink_mc_set(struct led_classdev *cdev,
+			    unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+
+	return lpg_blink_set(led, *delay_on, *delay_off);
+}
+
+#define interpolate(x1, y1, x2, y2, x) \
+	((y1) + ((y2) - (y1)) * ((x) - (x1)) / ((x2) - (x1)))
+
+static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *pattern,
+			   u32 len, int repeat)
+{
+	struct lpg_channel *chan;
+	struct lpg *lpg = led->lpg;
+	unsigned int hi_pause;
+	unsigned int lo_pause;
+	unsigned int lo_idx;
+	unsigned int hi_idx;
+	bool ping_pong = true;
+	int brightness_a;
+	int brightness_b;
+	int ret;
+	int i;
+
+	/* Only support oneshot or indefinite loops, due to limited pattern space */
+	if (repeat != -1 && repeat != 1)
+		return -EINVAL;
+
+	/*
+	 * The LPG plays patterns with at a fixed pace, a "low pause" can be
+	 * performed before the pattern and a "high pause" after. In order to
+	 * save space the pattern can be played in "ping pong" mode, in which
+	 * the pattern is first played forward, then "high pause" is applied,
+	 * then the pattern is played backwards and finally the "low pause" is
+	 * applied.
+	 *
+	 * The delta_t of the first entry is used to determine the pace of the
+	 * pattern.
+	 *
+	 * If the specified pattern is a palindrome the ping pong mode is
+	 * enabled. In this scenario the delta_t of the last entry determines
+	 * the "low pause" time and the delta_t of the middle entry (i.e. the
+	 * last in the programmed pattern) determines the "high pause". If the
+	 * pattern consists of an odd number of values, no "high pause" is
+	 * used.
+	 *
+	 * When ping pong mode is not selected, the delta_t of the last entry
+	 * is used as "high pause". No "low pause" is used.
+	 *
+	 * delta_t of any other members of the pattern is ignored.
+	 */
+
+	/* Detect palindromes and use "ping pong" to reduce LUT usage */
+	for (i = 0; i < len / 2; i++) {
+		brightness_a = pattern[i].brightness;
+		brightness_b = pattern[len - i - 1].brightness;
+
+		if (brightness_a != brightness_b) {
+			ping_pong = false;
+			break;
+		}
+	}
+
+	if (ping_pong) {
+		if (len % 2)
+			hi_pause = 0;
+		else
+			hi_pause = pattern[len + 1 / 2].delta_t;
+		lo_pause = pattern[len - 1].delta_t;
+
+		len = (len + 1) / 2;
+	} else {
+		hi_pause = pattern[len - 1].delta_t;
+		lo_pause = 0;
+	}
+
+	ret = lpg_lut_store(lpg, pattern, len, &lo_idx, &hi_idx);
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+
+		chan->ramp_duration_ms = pattern[0].delta_t * len;
+		chan->ramp_ping_pong = ping_pong;
+		chan->ramp_oneshot = repeat != -1;
+
+		chan->ramp_lo_pause_ms = lo_pause;
+		chan->ramp_hi_pause_ms = hi_pause;
+
+		chan->pattern_lo_idx = lo_idx;
+		chan->pattern_hi_idx = hi_idx;
+	}
+
+out:
+	return ret;
+}
+
+static int lpg_pattern_single_set(struct led_classdev *cdev,
+				  struct led_pattern *pattern, u32 len,
+				  int repeat)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+	int ret;
+
+	ret = lpg_pattern_set(led, pattern, len, repeat);
+	if (ret < 0)
+		return ret;
+
+	lpg_brightness_single_set(cdev, LED_FULL);
+
+	return 0;
+}
+
+static int lpg_pattern_mc_set(struct led_classdev *cdev,
+			      struct led_pattern *pattern, u32 len,
+			      int repeat)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+	int ret;
+
+	ret = lpg_pattern_set(led, pattern, len, repeat);
+	if (ret < 0)
+		return ret;
+
+	led_mc_calc_color_components(mc, LED_FULL);
+	lpg_brightness_set(led, cdev, mc->subled_info);
+
+	return 0;
+}
+
+static int lpg_pattern_clear(struct lpg_led *led)
+{
+	struct lpg_channel *chan;
+	struct lpg *lpg = led->lpg;
+	int i;
+
+	chan = led->channels[0];
+	lpg_lut_free(lpg, chan->pattern_lo_idx, chan->pattern_hi_idx);
+
+	for (i = 0; i < led->num_channels; i++) {
+		chan = led->channels[i];
+		chan->pattern_lo_idx = 0;
+		chan->pattern_hi_idx = 0;
+	}
+
+	return 0;
+}
+
+static int lpg_pattern_single_clear(struct led_classdev *cdev)
+{
+	struct lpg_led *led = container_of(cdev, struct lpg_led, cdev);
+
+	return lpg_pattern_clear(led);
+}
+
+static int lpg_pattern_mc_clear(struct led_classdev *cdev)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
+
+	return lpg_pattern_clear(led);
+}
+
+static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+
+	return chan->in_use ? -EBUSY : 0;
+}
+
+static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+
+	lpg_calc_freq(chan, state->period / NSEC_PER_USEC);
+	lpg_calc_duty(chan, state->duty_cycle / NSEC_PER_USEC);
+	chan->enabled = state->enabled;
+
+	lpg_apply(chan);
+
+	triled_set(lpg, chan->triled_mask, chan->enabled);
+
+	return 0;
+}
+
+static const struct pwm_ops lpg_pwm_ops = {
+	.request = lpg_pwm_request,
+	.apply = lpg_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static int lpg_add_pwm(struct lpg *lpg)
+{
+	int ret;
+
+	lpg->pwm.base = -1;
+	lpg->pwm.dev = lpg->dev;
+	lpg->pwm.npwm = lpg->num_channels;
+	lpg->pwm.ops = &lpg_pwm_ops;
+
+	ret = pwmchip_add(&lpg->pwm);
+	if (ret)
+		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
+
+	return ret;
+}
+
+static int lpg_parse_channel(struct lpg *lpg, struct device_node *np,
+			     struct lpg_channel **channel)
+{
+	struct lpg_channel *chan;
+	u32 dtest[2];
+	u32 color = LED_COLOR_ID_GREEN;
+	u32 reg;
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &reg);
+	if (ret || !reg || reg > lpg->num_channels) {
+		dev_err(lpg->dev, "invalid reg of %pOFn\n", np);
+		return -EINVAL;
+	}
+
+	chan = &lpg->channels[reg - 1];
+	chan->in_use = true;
+
+	ret = of_property_read_u32(np, "color", &color);
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+
+	chan->color = color;
+
+	ret = of_property_read_u32_array(np, "qcom,dtest", dtest, 2);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(lpg->dev, "malformed qcom,dtest of %pOFn\n", np);
+		return ret;
+	} else if (!ret) {
+		chan->dtest_line = dtest[0];
+		chan->dtest_value = dtest[1];
+	}
+
+	*channel = chan;
+
+	return 0;
+}
+
+static int lpg_add_led(struct lpg *lpg, struct device_node *np)
+{
+	struct led_classdev *cdev;
+	struct device_node *child;
+	struct mc_subled *info;
+	struct lpg_led *led;
+	const char *state;
+	int num_channels;
+	u32 color = 0;
+	int size;
+	int ret;
+	int i;
+
+	ret = of_property_read_u32(np, "color", &color);
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+
+	if (color == LED_COLOR_ID_MULTI)
+		num_channels = of_get_available_child_count(np);
+	else
+		num_channels = 1;
+
+	size = sizeof(*led) + num_channels * sizeof(struct lpg_channel*);
+	led = devm_kzalloc(lpg->dev, size, GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	led->lpg = lpg;
+	led->num_channels = num_channels;
+
+	if (color == LED_COLOR_ID_MULTI) {
+		info = devm_kcalloc(lpg->dev, num_channels, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+		i = 0;
+		for_each_available_child_of_node(np, child) {
+			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
+			if (ret < 0)
+				return ret;
+
+			info[i].color_index = led->channels[i]->color;
+			info[i].intensity = LED_FULL;
+			i++;
+		}
+
+		led->mcdev.subled_info = info;
+		led->mcdev.num_colors = num_channels;
+
+		cdev = &led->mcdev.led_cdev;
+		cdev->brightness_set = lpg_brightness_mc_set;
+		cdev->blink_set = lpg_blink_mc_set;
+
+		/* Register pattern accessors only if we have a LUT block */
+		if (lpg->lut_base) {
+			cdev->pattern_set = lpg_pattern_mc_set;
+			cdev->pattern_clear = lpg_pattern_mc_clear;
+		}
+	} else {
+		ret = lpg_parse_channel(lpg, np, &led->channels[0]);
+		if (ret < 0)
+			return ret;
+
+		cdev = &led->cdev;
+		cdev->brightness_set = lpg_brightness_single_set;
+		cdev->blink_set = lpg_blink_single_set;
+
+		/* Register pattern accessors only if we have a LUT block */
+		if (lpg->lut_base) {
+			cdev->pattern_set = lpg_pattern_single_set;
+			cdev->pattern_clear = lpg_pattern_single_clear;
+		}
+	}
+
+	/* Use label else node name */
+	cdev->name = of_get_property(np, "label", NULL) ? : np->name;
+	cdev->default_trigger = of_get_property(np, "linux,default-trigger", NULL);
+	cdev->max_brightness = 255;
+
+	if (!of_property_read_string(np, "default-state", &state) &&
+	    !strcmp(state, "on"))
+		cdev->brightness = LED_FULL;
+	else
+		cdev->brightness = LED_OFF;
+
+	cdev->brightness_set(cdev, cdev->brightness);
+
+	if (color == LED_COLOR_ID_MULTI)
+		ret = devm_led_classdev_multicolor_register(lpg->dev, &led->mcdev);
+	else
+		ret = devm_led_classdev_register(lpg->dev, &led->cdev);
+	if (ret)
+		dev_err(lpg->dev, "unable to register %s\n", cdev->name);
+
+	return ret;
+}
+
+static int lpg_init_channels(struct lpg *lpg)
+{
+	const struct lpg_data *data = lpg->data;
+	int i;
+
+	lpg->num_channels = data->num_channels;
+	lpg->channels = devm_kcalloc(lpg->dev, data->num_channels,
+				     sizeof(struct lpg_channel), GFP_KERNEL);
+	if (!lpg->channels)
+		return -ENOMEM;
+
+	for (i = 0; i < data->num_channels; i++) {
+		lpg->channels[i].lpg = lpg;
+		lpg->channels[i].base = data->channels[i].base;
+		lpg->channels[i].triled_mask = data->channels[i].triled_mask;
+		lpg->channels[i].lut_mask = BIT(i);
+	}
+
+	return 0;
+}
+
+static int lpg_init_triled(struct lpg *lpg)
+{
+	struct device_node *np = lpg->dev->of_node;
+	int ret;
+
+	/* Skip initialization if we don't have a triled block */
+	if (!lpg->data->triled_base)
+		return 0;
+
+	lpg->triled_base = lpg->data->triled_base;
+
+	ret = of_property_read_u32(np, "qcom,power-source", &lpg->triled_src);
+	if (ret || lpg->triled_src == 2 || lpg->triled_src > 3) {
+		dev_err(lpg->dev, "invalid power source\n");
+		return -EINVAL;
+	}
+
+	/* Disable automatic trickle charge LED */
+	regmap_write(lpg->map, lpg->triled_base + TRI_LED_ATC_CTL, 0);
+
+	/* Configure power source */
+	regmap_write(lpg->map, lpg->triled_base + TRI_LED_SRC_SEL, lpg->triled_src);
+
+	/* Default all outputs to off */
+	regmap_write(lpg->map, lpg->triled_base + TRI_LED_EN_CTL, 0);
+
+	return 0;
+}
+
+static int lpg_init_lut(struct lpg *lpg)
+{
+	const struct lpg_data *data = lpg->data;
+	size_t bitmap_size;
+
+	if (!data->lut_base)
+		return 0;
+
+	lpg->lut_base = data->lut_base;
+	lpg->lut_size = data->lut_size;
+
+	bitmap_size = BITS_TO_LONGS(lpg->lut_size) * sizeof(unsigned long);
+	lpg->lut_bitmap = devm_kzalloc(lpg->dev, bitmap_size, GFP_KERNEL);
+
+	bitmap_clear(lpg->lut_bitmap, 0, lpg->lut_size);
+	return lpg->lut_bitmap ? 0 : -ENOMEM;
+}
+
+static int lpg_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct lpg *lpg;
+	int ret;
+	int i;
+
+	lpg = devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
+	if (!lpg)
+		return -ENOMEM;
+
+	lpg->data = of_device_get_match_data(&pdev->dev);
+	if (!lpg->data)
+		return -EINVAL;
+
+	lpg->dev = &pdev->dev;
+
+	lpg->map = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!lpg->map) {
+		dev_err(&pdev->dev, "parent regmap unavailable\n");
+		return -ENXIO;
+	}
+
+	ret = lpg_init_channels(lpg);
+	if (ret < 0)
+		return ret;
+
+	ret = lpg_init_triled(lpg);
+	if (ret < 0)
+		return ret;
+
+	ret = lpg_init_lut(lpg);
+	if (ret < 0)
+		return ret;
+
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		ret = lpg_add_led(lpg, np);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < lpg->num_channels; i++)
+		lpg_apply_dtest(&lpg->channels[i]);
+
+	ret = lpg_add_pwm(lpg);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, lpg);
+
+	return 0;
+}
+
+static int lpg_remove(struct platform_device *pdev)
+{
+	struct lpg *lpg = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&lpg->pwm);
+
+	return 0;
+}
+
+static const struct lpg_data pm8916_pwm_data = {
+	.pwm_9bit_mask = BIT(2),
+
+	.num_channels = 1,
+	.channels = (struct lpg_channel_data[]) {
+		{ .base = 0xbc00 },
+	},
+};
+
+static const struct lpg_data pm8941_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 64,
+
+	.triled_base = 0xd000,
+
+	.pwm_9bit_mask = 3 << 4,
+
+	.num_channels = 8,
+	.channels = (struct lpg_channel_data[]) {
+		{ .base = 0xb100 },
+		{ .base = 0xb200 },
+		{ .base = 0xb300 },
+		{ .base = 0xb400 },
+		{ .base = 0xb500, .triled_mask = BIT(5) },
+		{ .base = 0xb600, .triled_mask = BIT(6) },
+		{ .base = 0xb700, .triled_mask = BIT(7) },
+		{ .base = 0xb800 },
+	},
+};
+
+static const struct lpg_data pm8994_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 64,
+
+	.pwm_9bit_mask = 3 << 4,
+
+	.num_channels = 6,
+	.channels = (struct lpg_channel_data[]) {
+		{ .base = 0xb100 },
+		{ .base = 0xb200 },
+		{ .base = 0xb300 },
+		{ .base = 0xb400 },
+		{ .base = 0xb500 },
+		{ .base = 0xb600 },
+	},
+};
+
+static const struct lpg_data pmi8994_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 24,
+
+	.triled_base = 0xd000,
+
+	.pwm_9bit_mask = BIT(4),
+
+	.num_channels = 4,
+	.channels = (struct lpg_channel_data[]) {
+		{ .base = 0xb100, .triled_mask = BIT(5) },
+		{ .base = 0xb200, .triled_mask = BIT(6) },
+		{ .base = 0xb300, .triled_mask = BIT(7) },
+		{ .base = 0xb400 },
+	},
+};
+
+static const struct lpg_data pmi8998_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 49,
+
+	.pwm_9bit_mask = BIT(4),
+
+	.num_channels = 6,
+	.channels = (struct lpg_channel_data[]) {
+		{ .base = 0xb100 },
+		{ .base = 0xb200 },
+		{ .base = 0xb300, .triled_mask = BIT(5) },
+		{ .base = 0xb400, .triled_mask = BIT(6) },
+		{ .base = 0xb500, .triled_mask = BIT(7) },
+		{ .base = 0xb600 },
+	},
+};
+
+static const struct of_device_id lpg_of_table[] = {
+	{ .compatible = "qcom,pm8916-pwm", .data = &pm8916_pwm_data },
+	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
+	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
+	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
+	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lpg_of_table);
+
+static struct platform_driver lpg_driver = {
+	.probe = lpg_probe,
+	.remove = lpg_remove,
+	.driver = {
+		.name = "qcom-spmi-lpg",
+		.of_match_table = lpg_of_table,
+	},
+};
+module_platform_driver(lpg_driver);
+
+MODULE_DESCRIPTION("Qualcomm LPG LED driver");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

