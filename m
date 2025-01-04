Return-Path: <linux-pwm+bounces-4536-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6577A015AD
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Jan 2025 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A1316336E
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Jan 2025 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841141AC892;
	Sat,  4 Jan 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx88jSoH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F57E105;
	Sat,  4 Jan 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736006566; cv=none; b=BIznbFyRD3s137HNYqNgfndb2/PgEnMurC5kLaF676EKtKVOr1BO36oInfDR5DpYtRsZhf/A4NIpOUeItLc/31Vu0eqx2kwHnDb+qmdKjZq2dlEU0jVjEYOC7itWL6tg3GkVy9sVNeTrs2x9g8414pOAel1SIOfPKkvC4sr7TrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736006566; c=relaxed/simple;
	bh=1ALXzAvIdkyuF4o9quLsZoDKVkWu6cEnimAsvNTDLAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9NGsCeenlWjhcgIz+KnEPXcwUnmwZUGZGa4o5FVODQQx3g/aU8bn4XqYAhnM7BqI783m07Gln4+X2/wvOdE+Up18LvoETJmvEEIH5wr59PB5cmyrMyBQyullGfb4eSAlblbpX3qghx+uFCP965ZZHhTVrx38oE+cRVNKGdRyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx88jSoH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436281c8a38so93792305e9.3;
        Sat, 04 Jan 2025 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736006562; x=1736611362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6r/mxma51K6iW+BCWS4QTSNmAtlmCyU94qvPkNRXfFs=;
        b=Zx88jSoHO0Bm2RzJ9HGOek25jmf3LOzKPTvMsG2rgFbNfn8DbfZD2Ng7iWzexONQEl
         qGL1N/q7KISt3DDQH+IyH5TLUElogaNtFB/Z5v3or3gUa+H4tdSF1DpThh6m+w/PrjUx
         80x0jhjkFhluK7Qlr6uieJtzdSglJc79l9z2tuyvwKVgccIHKi2BvZKuo5+1EP7IrSSm
         Z3cATHPZblVk01T6Qe9khCC0gJrtrm7fM1K51gLKUbQJqJ1u0bVeX47coOMFTlDYuIbG
         S3zsu0YQei62+XaJ3/kXoEAtQvZKjfbL0OKL+t0a+jxzDy8Hh40f8Dbuy+tSrw+9hIGy
         4k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736006562; x=1736611362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6r/mxma51K6iW+BCWS4QTSNmAtlmCyU94qvPkNRXfFs=;
        b=W+3AVw6oSgpH/MiaUejBk0uBaX/YqK1jUa+Si+2NI4hTrpXSauj/LF+zjQG5/oSRad
         ZWMRvSoA+mri5X2ckxD2wB9Xb4BqFwh3bv6yQddy5NvWO+zY454iQtCSF1ZNyV+L4LZa
         PgBDuf84WvNSVkGxWrpBq9Ck8KMLcYEHMgw5mgJ8//7pT+9KEjFzFQSyE8gwAtYDx/zA
         4b/qkX+uAejc9iWNc9stx955HTQr+SWI2NMHhX+ny6vwdo3rfksMH8TO6TVp0G4fmRj0
         lzj7ctEZntnZv1f+4alxK67sB+VueNk7Ba7d4a4ZnxpR0kz6WG8nQ/FzMhp5LkPskOLU
         oDuA==
X-Forwarded-Encrypted: i=1; AJvYcCW3AQK1AJdlr+od4lI8UG/mE7wSAV7iI6SrJuNIv15QHICP/8Z24VK4CrecdTkFqaxkemDlAc17Hu2FJB0=@vger.kernel.org, AJvYcCWS0ks7CNuCGYLYkOF9fKk+ZWicaup4BQA2mmGbTdtdMLZPhj9WPPWM3rvzqQyWP8dzbdOtUe056PS8@vger.kernel.org
X-Gm-Message-State: AOJu0YxgiNrSlrC04n+AX90ocij2UYnM7IFMoGsshn2MJoL+eneDyD/Z
	HesaZuEWShAYuedZPPgcsQxgAmdTvRZBilvO5T2X0ngQhXU/Jg8knXLLOw==
X-Gm-Gg: ASbGnctwzDxd/x65LIY5pWurr+IbBZmlQfFP1Hbrd1HyEI403BU2tLB/ZLDbpAvGPeD
	+NvEeBiBwsrOdX6NwdYra6sy8Mg5IIodEPXfoGil4yUEdQ6OsOCcH7HC4vFU3EEJSBzihp9a5Rs
	5jIx3zKu3vB6LRu0rt5AFNoTXoo09u22Gt0Luld81/9/DcBYw9QhykyWQ95s3XlsHy0CpWbm5zY
	So4dYc2xG+rNM99ETSYkQWghKYcdG06jRRvUvap22urg536NEcOLtfD/9RWWleHP1qyaV+DY3bj
	vEi3KKHuvTv0DQlFvs/AWngZmt0Ph2LGAAZ4xEHRmw==
X-Google-Smtp-Source: AGHT+IHpzVsnAuoYAKTrU9NcAqeaLFd0WN9b9ymWWWUQusX0mqWyx0zpfJXwRlYg345PMOzNZlDDCQ==
X-Received: by 2002:a05:600c:6b09:b0:434:eb86:aeca with SMTP id 5b1f17b1804b1-43675cb208bmr506466955e9.10.1736006561684;
        Sat, 04 Jan 2025 08:02:41 -0800 (PST)
Received: from localhost.localdomain (host-95-246-253-26.retail.telecomitalia.it. [95.246.253.26])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4366127c4d7sm514746645e9.34.2025.01.04.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:02:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	upstream@airoha.com
Cc: Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v11] pwm: airoha: Add support for EN7581 SoC
Date: Sat,  4 Jan 2025 17:01:39 +0100
Message-ID: <20250104160201.19836-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

Introduce driver for PWM module available on EN7581 SoC.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v11:
- Fix wrong calculation of period and duty
- Use AIROHA_PWM prefix for each define
- Drop set/get special define in favour of BITS and GENMASK
- Correctly use dev_err_probe
- Init bucket with initial values
- Rework define to make use of FIELD_PREP and FIELD_GET

Changes in v10:
- repost just patch 6/6 (pwm driver) since patches {1/6-5/6} have been
  already applied in linux-pinctrl tree
- pwm: introduce AIROHA_PWM_FIELD_GET and AIROHA_PWM_FIELD_SET macros to
  get/set field with non-const mask
- pwm: simplify airoha_pwm_get_generator() to report unused generator
  and remove double lookup
- pwm: remove device_node pointer in airoha_pwm struct since this is
  write-only field
- pwm: cosmetics
- Link to v9: https://lore.kernel.org/r/20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org

Changes in v9:
- pwm: remove unused properties
- Link to v8: https://lore.kernel.org/r/20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org

Changes in v8:
- pwm: add missing properties documentation
- Link to v7: https://lore.kernel.org/r/20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org

Changes in v7:
- pinctrl: cosmetics
- pinctrl: fix compilation warning
- Link to v6: https://lore.kernel.org/r/20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org

Changes in v6:
- pwm: rely on regmap APIs
- pwm: introduce compatible string
- pinctrl: introduce compatible string
- remove airoha-mfd driver
- add airoha,en7581-pinctrl binding
- add airoha,en7581-pwm binding
- update airoha,en7581-gpio-sysctl binding
- Link to v5: https://lore.kernel.org/r/20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org

Changes in v5:
- use spin_lock in airoha_pinctrl_rmw instead of a mutex since it can run
  in interrupt context
- remove unused includes in pinctrl driver
- since the irq_chip is immutable, allocate the gpio_irq_chip struct
  statically in pinctrl driver
- rely on regmap APIs in pinctrl driver but keep the spin_lock local to the
  driver
- rely on guard/guard_scope APIs in pinctrl driver
- improve naming convention pinctrl driver
- introduce airoha_pinconf_set_pin_value utility routine
- Link to v4: https://lore.kernel.org/r/20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org

Changes in v4:
- add 'Limitation' description in pwm driver
- fix comments in pwm driver
- rely on mfd->base __iomem pointer in pwm driver, modify register
  offsets according to it and get rid of sgpio_cfg, flash_cfg and
  cycle_cfg pointers
- simplify register utility routines in pwm driver
- use 'generator' instead of 'waveform' suffix for pwm routines
- fix possible overflow calculating duty cycle in pwm driver
- do not modify pwm state in free callback in pwm driver
- cap the maximum period in pwm driver
- do not allow inverse polarity in pwm driver
- do not set of_xlate callback in the pwm driver and allow the stack to
  do it
- fix MAINTAINERS file for airoha pinctrl driver
- fix undefined reference to __ffsdi2 in pinctrl driver
- simplify airoha,en7581-gpio-sysctl.yam binding
- Link to v3: https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org

Changes in v3:
- introduce airoha-mfd driver
- add pwm driver to the same series
- model pinctrl and pwm drivers as childs of a parent mfd driver.
- access chip-scu memory region in pinctrl driver via syscon
- introduce a single airoha,en7581-gpio-sysctl.yaml binding and get rid
  of dedicated bindings for pinctrl and pwm
- add airoha,en7581-chip-scu.yaml binding do the series
- Link to v2: https://lore.kernel.org/r/20240822-en7581-pinctrl-v2-0-ba1559173a7f@kernel.org

Changes in v2:
- Fix compilation errors
- Collapse some register mappings for gpio and irq controllers
- update dt-bindings according to new register mapping
- fix some dt-bindings errors
- Link to v1: https://lore.kernel.org/all/cover.1723392444.git.lorenzo@kernel.org/

 drivers/pwm/Kconfig      |  11 +
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-airoha.c | 488 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 500 insertions(+)
 create mode 100644 drivers/pwm/pwm-airoha.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..99aa87136c27 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -54,6 +54,17 @@ config PWM_ADP5585
 	  This option enables support for the PWM function found in the Analog
 	  Devices ADP5585.
 
+config PWM_AIROHA
+	tristate "Airoha PWM support"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on OF
+	select REGMAP_MMIO
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
index 9081e0c0e9e0..fbf7723d8458 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
+obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
new file mode 100644
index 000000000000..51d02a5ff064
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,488 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
+ *
+ *  Limitations:
+ *  - Only 8 concurrent waveform generators are available for 8 combinations of
+ *    duty_cycle and period. Waveform generators are shared between 16 GPIO
+ *    pins and 17 SIPO GPIO pins.
+ *  - Supports only normal polarity.
+ *  - On configuration the currently running period is completed.
+ *  - Minimum supported period is 4ms
+ *  - Maximum supported period is 1s
+ */
+
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/gpio.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <asm/div64.h>
+
+#define AIROHA_PWM_REG_SGPIO_LED_DATA		0x0024
+#define AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
+#define AIROHA_PWM_SGPIO_LED_DATA_DATA		GENMASK(16, 0)
+
+#define AIROHA_PWM_REG_SGPIO_CLK_DIVR		0x0028
+#define AIROHA_PWM_SGPIO_CLK_DIVR		GENMASK(1, 0)
+
+#define AIROHA_PWM_REG_SGPIO_CLK_DLY		0x002c
+
+#define AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG	0x0030
+#define AIROHA_PWM_SERIAL_GPIO_FLASH_MODE	BIT(1)
+#define AIROHA_PWM_SERIAL_GPIO_MODE_74HC164	BIT(0)
+
+#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + (4 * (_n)))
+#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(_n) (16 * (_n))
+#define AIROHA_PWM_GPIO_FLASH_PRD_LOW		GENMASK(15, 8)
+#define AIROHA_PWM_GPIO_FLASH_PRD_HIGH		GENMASK(7, 0)
+
+#define AIROHA_PWM_REG_GPIO_FLASH_MAP(_n)	(0x004c + (4 * (_n)))
+#define AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(_n) (4 * (_n))
+#define AIROHA_PWM_GPIO_FLASH_EN		BIT(3)
+#define AIROHA_PWM_GPIO_FLASH_SET_ID		GENMASK(2, 0)
+
+/* Register map is equal to GPIO flash map */
+#define AIROHA_PWM_REG_SIPO_FLASH_MAP(_n)	(0x0054 + (4 * (_n)))
+
+#define AIROHA_PWM_REG_CYCLE_CFG_VALUE(_n)	(0x0098 + (4 * (_n)))
+#define AIROHA_PWM_REG_CYCLE_CFG_SHIFT(_n)	(8 * (_n))
+#define AIROHA_PWM_WAVE_GEN_CYCLE		GENMASK(7, 0)
+
+/* GPIO/SIPO flash map handles 8 pins in one register */
+#define AIROHA_PWM_PINS_PER_FLASH_MAP		8
+/* Cycle cfg handles 4 generators in one register */
+#define AIROHA_PWM_BUCKET_PER_CYCLE_CFG		4
+/* Flash producer handles 2 generators in one register */
+#define AIROHA_PWM_BUCKET_PER_FLASH_PROD	2
+
+#define AIROHA_PWM_NUM_BUCKETS			8
+/*
+ * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
+ * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels, 16-32.
+ * However, we've only got 8 concurrent waveform generators and can therefore
+ * only use up to 8 different combinations of duty cycle and period at a time.
+ */
+#define AIROHA_PWM_NUM_GPIO			16
+#define AIROHA_PWM_NUM_SIPO			17
+#define AIROHA_PWM_MAX_CHANNELS			(AIROHA_PWM_NUM_GPIO + AIROHA_PWM_NUM_SIPO)
+
+struct airoha_pwm_bucket {
+	/* Bitmask of PWM channels using this bucket */
+	u64 used;
+	u64 period_ns;
+	u64 duty_ns;
+};
+
+struct airoha_pwm {
+	struct regmap *regmap;
+
+	u64 initialized;
+
+	struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
+
+	/* Cache bucket used by each pwm channel */
+	u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
+};
+
+/* The PWM hardware supports periods between 4 ms and 1 s */
+#define AIROHA_PWM_PERIOD_TICK_NS	(4 * NSEC_PER_MSEC)
+#define AIROHA_PWM_PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
+/* It is represented internally as 1/250 s between 1 and 250. Unit is ticks. */
+#define AIROHA_PWM_PERIOD_MIN		1
+#define AIROHA_PWM_PERIOD_MAX		250
+/* Duty cycle is relative with 255 corresponding to 100% */
+#define AIROHA_PWM_DUTY_FULL		255
+
+static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
+						    u32 *addr, u32 *shift)
+{
+	u64 offset = hwpwm;
+
+	if (hwpwm >= AIROHA_PWM_NUM_GPIO)
+		offset -= AIROHA_PWM_NUM_GPIO;
+
+	/* One FLASH_MAP register handles 8 pins */
+	*shift = do_div(offset, AIROHA_PWM_PINS_PER_FLASH_MAP);
+	*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(*shift);
+
+	if (offset < AIROHA_PWM_NUM_GPIO)
+		*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
+	else
+		*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
+}
+
+static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_tick,
+					 u64 duty_ns, u32 *duty_tick)
+{
+	period_ns = min_t(u64, period_ns, AIROHA_PWM_PERIOD_MAX_NS);
+	*period_tick = div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
+
+	*duty_tick = mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
+					 *period_tick * AIROHA_PWM_PERIOD_TICK_NS);
+	*duty_tick = min_t(u32, *duty_tick, AIROHA_PWM_DUTY_FULL);
+}
+
+static void airoha_pwm_fill_bucket(struct airoha_pwm *pc, int bucket)
+{
+	u64 offset, period_ns, duty_ns;
+	u32 period_tick, duty_tick;
+	u32 shift, val;
+
+	offset = bucket;
+	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
+	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
+
+	regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), &val);
+
+	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
+	period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
+
+	offset = bucket;
+	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
+	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
+
+	regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+		    &val);
+
+	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
+	duty_ns = mul_u64_u64_div_u64(duty_tick, period_ns, AIROHA_PWM_DUTY_FULL);
+
+	pc->buckets[bucket].period_ns = period_ns;
+	pc->buckets[bucket].duty_ns = duty_ns;
+}
+
+static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
+				    u64 period_ns)
+{
+	int i, unused = -1;
+
+	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
+		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
+		u32 duty_tick, duty_tick_bucket;
+		u32 period_tick;
+
+		/* If found, save an unused bucket to return it later */
+		if (!bucket->used && unused == -1) {
+			unused = i;
+			continue;
+		}
+
+		if (duty_ns == bucket->duty_ns &&
+		    period_ns == bucket->period_ns)
+			return i;
+
+		/*
+		 * Unlike duty cycle zero, which can be handled by
+		 * disabling PWM, a generator is needed for full duty
+		 * cycle but it can be reused regardless of period
+		 */
+		airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
+					     duty_ns, &duty_tick);
+		airoha_pwm_get_ticks_from_ns(bucket->period_ns, &period_tick,
+					     bucket->duty_ns, &duty_tick_bucket);
+		if (duty_tick == AIROHA_PWM_DUTY_FULL &&
+		    duty_tick == duty_tick_bucket)
+			return i;
+	}
+
+	return unused;
+}
+
+static void airoha_pwm_release_bucket_config(struct airoha_pwm *pc,
+					     unsigned int hwpwm)
+{
+	int bucket;
+
+	/* Nothing to clear, PWM channel never used */
+	if (!(pc->initialized & BIT_ULL(hwpwm)))
+		return;
+
+	bucket = pc->channel_bucket[hwpwm];
+	pc->buckets[bucket].used &= ~BIT_ULL(hwpwm);
+}
+
+static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
+					u64 duty_ns, u64 period_ns,
+					unsigned int hwpwm)
+{
+	int bucket;
+
+	/*
+	 * Search for a bucket that already satisfy duty and period
+	 * or an unused one.
+	 * If not found, -1 is returned.
+	 */
+	bucket = airoha_pwm_get_generator(pc, duty_ns, period_ns);
+	if (bucket < 0)
+		return bucket;
+
+	airoha_pwm_release_bucket_config(pc, hwpwm);
+	pc->buckets[bucket].used |= BIT_ULL(hwpwm);
+	pc->buckets[bucket].period_ns = period_ns;
+	pc->buckets[bucket].duty_ns = duty_ns;
+
+	return bucket;
+}
+
+static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
+{
+	u32 val;
+
+	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
+		return 0;
+
+	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
+			  AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);
+
+	/* Configure shift register timings, use 32x divisor */
+	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DIVR,
+		     FIELD_PREP(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3));
+
+	/*
+	 * The actual delay is clock + 1.
+	 * Notice that clock delay should not be greater
+	 * than (divisor / 2) - 1.
+	 * Set to 0 by default. (aka 1)
+	 */
+	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
+
+	/*
+	 * It it necessary to after muxing explicitly shift out all
+	 * zeroes to initialize the shift register before enabling PWM
+	 * mode because in PWM mode SIPO will not start shifting until
+	 * it needs to output a non-zero value (bit 31 of led_data
+	 * indicates shifting in progress and it must return to zero
+	 * before led_data can be written or PWM mode can be set)
+	 */
+	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
+				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
+				     10, 200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA,
+			  AIROHA_PWM_SGPIO_LED_DATA_DATA);
+	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
+				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
+				     10, 200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	/* Set SIPO in PWM mode */
+	regmap_set_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
+			AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
+
+	return 0;
+}
+
+static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int bucket,
+					  u64 duty_ns, u64 period_ns)
+{
+	u32 period_tick, duty_tick;
+	u32 mask, shift, val;
+	u64 offset;
+
+	airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
+				     duty_ns, &duty_tick);
+
+	offset = bucket;
+	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
+	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
+
+	/* Configure frequency divisor */
+	mask = AIROHA_PWM_WAVE_GEN_CYCLE << shift;
+	val = FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_tick) << shift;
+	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), mask, val);
+
+	offset = bucket;
+	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
+	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
+
+	/* Configure duty cycle */
+	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
+	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_tick) << shift;
+	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+			   mask, val);
+
+	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
+	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
+			 AIROHA_PWM_DUTY_FULL - duty_tick) << shift;
+	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+			   mask, val);
+}
+
+static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
+					unsigned int hwpwm, int index)
+{
+	u32 addr, shift;
+
+	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
+
+	/* index -1 means disable PWM channel */
+	if (index < 0) {
+		/*
+		 * Change of waveform takes effect immediately but
+		 * disabling has some delay so to prevent glitching
+		 * only the enable bit is touched when disabling.
+		 * Duty cycle can't be set to 0 as it might be shared with
+		 * others channels with same duty cycle.
+		 */
+		regmap_clear_bits(pc->regmap, addr,
+				  AIROHA_PWM_GPIO_FLASH_EN << shift);
+		return;
+	}
+
+	regmap_update_bits(pc->regmap, addr,
+			   AIROHA_PWM_GPIO_FLASH_SET_ID << shift,
+			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID, index) << shift);
+	regmap_set_bits(pc->regmap, addr, AIROHA_PWM_GPIO_FLASH_EN << shift);
+}
+
+static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
+			     u64 duty_ns, u64 period_ns)
+{
+	int bucket, hwpwm = pwm->hwpwm;
+
+	bucket = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
+					      hwpwm);
+	if (bucket < 0)
+		return -EBUSY;
+
+	/*
+	 * For SIPO reinit is always needed to trigger the shift register chip
+	 * and apply the new flash configuration.
+	 */
+	if (!(pc->initialized & BIT_ULL(hwpwm)) && hwpwm >= AIROHA_PWM_NUM_GPIO)
+		airoha_pwm_sipo_init(pc);
+
+	airoha_pwm_calc_bucket_config(pc, bucket, duty_ns, period_ns);
+	airoha_pwm_config_flash_map(pc, hwpwm, bucket);
+
+	pc->initialized |= BIT_ULL(hwpwm);
+	pc->channel_bucket[hwpwm] = bucket;
+
+	return 0;
+}
+
+static void airoha_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+
+	/* Disable PWM and release the bucket */
+	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
+	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
+
+	pc->initialized &= ~BIT_ULL(pwm->hwpwm);
+	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
+		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
+				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
+}
+
+static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+	u64 period_ns = state->period;
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
+	if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
+		return -EINVAL;
+
+	return airoha_pwm_config(pc, pwm, state->duty_cycle, period_ns);
+}
+
+static int airoha_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+	int ret, hwpwm = pwm->hwpwm;
+	u32 addr, shift, val;
+	u8 bucket;
+
+	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
+
+	ret = regmap_read(pc->regmap, addr, &val);
+	if (ret)
+		return ret;
+
+	state->enabled = FIELD_GET(AIROHA_PWM_GPIO_FLASH_EN, val >> shift);
+	if (!state->enabled)
+		return 0;
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	bucket = FIELD_GET(AIROHA_PWM_GPIO_FLASH_SET_ID, val >> shift);
+	state->period = pc->buckets[bucket].period_ns;
+	state->duty_cycle = pc->buckets[bucket].duty_ns;
+
+	return 0;
+}
+
+static const struct pwm_ops airoha_pwm_ops = {
+	.apply = airoha_pwm_apply,
+	.get_state = airoha_pwm_get_state,
+};
+
+static int airoha_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct airoha_pwm *pc;
+	struct pwm_chip *chip;
+	int i, ret;
+
+	chip = devm_pwmchip_alloc(dev, AIROHA_PWM_MAX_CHANNELS, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	chip->ops = &airoha_pwm_ops;
+	pc = pwmchip_get_drvdata(chip);
+
+	pc->regmap = device_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(pc->regmap))
+		return dev_err_probe(dev, PTR_ERR(pc->regmap), "Failed to get PWM regmap\n");
+
+	/* Fill buckets with initial values */
+	for (i = 0; i < AIROHA_PWM_NUM_BUCKETS; i++)
+		airoha_pwm_fill_bucket(pc, i);
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
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
+		.name = "pwm-airoha",
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
2.45.2


