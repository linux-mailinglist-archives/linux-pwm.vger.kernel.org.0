Return-Path: <linux-pwm+bounces-5366-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFCA7E8C2
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 19:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A07189F3D1
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17642253F2D;
	Mon,  7 Apr 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYvXUerx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B4253F0C;
	Mon,  7 Apr 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047404; cv=none; b=JwgUwZd8RffcRNOiJPbmprs5PGs2tU8nabn9C7S3BWaSd0Cbl6k3uykwlLImnjgxeVMwWtIkPg0C5osEOQg0IekQXlhTB2iKc986NwA7NHjZNeXFU6HjB/NrLvsPK0pFUhztgO9zLZB7joHF1JEn1ohq3Mj9u0ME+Ssvm8eGS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047404; c=relaxed/simple;
	bh=hVsKXxfS9TYGAtgKcOq6Du5OvBst3ZZi0OqpIg8EGuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsDbkWsU5eAyu5MsB75FhpioaHe0RtC7EKpI+EtsE/rxENQXBp1oNfx5cbPTXE2JeNmTbE33zRm4FUHWF2ZSDqbgQNJsO3rj1ccki1N9wtA8qS5t8l5aWxw9CqXNb9IUO1Qc7T92BBa7WJI9yNBirqmjCynmTFiWt/zMz8CgqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYvXUerx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2f391864so2589666f8f.3;
        Mon, 07 Apr 2025 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744047400; x=1744652200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWFaX54o7hhhdk8H12wesxTeLsQ9TMWZAUM8US5hzMQ=;
        b=AYvXUerxGtd1OU8vIOPcEKWWNzFW0mPs5Nqn14kkuu+yTYBsXi9E1fWZHe6t0VAxXJ
         bgowWYmBgV4CDhKAK3580Ve08ZJZZJ2C8/6KYg7ym68VMuycWTRg4pYs42bQyp23SsM6
         WET8Vz/KJGdDWW1Xmm5eIijo+74TC9/0eUmMDx0rOuHidYZNXRLlyx++H38OJ0LkQDzq
         TxM2rgxf7c2j4K5dX0ytVSix81mey164h493IS/lF6UgktPE+i66rVgbrKD8S4FQJx1Z
         DynbUDQ3nCUuUqu8PK9WkRhiLzgA8CxWefbG7ydHNiIAw0Zxc0/gZzkgjjoOdnSpnCok
         tmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744047400; x=1744652200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWFaX54o7hhhdk8H12wesxTeLsQ9TMWZAUM8US5hzMQ=;
        b=COuhVnHwOUTBe/NfzB9NckdNIH6+jLpf6s7R5TZ45gUYs3PqRE899Ar12S5GAFIIVI
         JBb3viPir1T8+0yVf7PUykH9EMACOchRkH6t8NxMzB1FOa/GoN/1MWNM/kBIu8uhDkxZ
         ztxb7JF95b0DRBqTHGjj+N4c1+yeKf0G9x2maZDd7iddiTP5LnTCLH6t1kurPZcAIa3E
         XFNh0QrHSMsjxgPWdHtHcjqNPPOmuX8gzTqF/CeXMq8Icr1i+8765vyA+w+1TUbWpEOJ
         6saebynKSO2Vi4Z8ojSuy2YPIqOD067m9MDDbQ+2YiBL/4/VDOwfXQh3djwjwPA/U+bP
         jUDw==
X-Forwarded-Encrypted: i=1; AJvYcCWjdD7quiG0chMtp7swW9cneC4A9QS69oIKdUuI9TuzCVBYo8Fr9AVTJ3/jSVtLA/J0oPkTWrJ5TiIP@vger.kernel.org, AJvYcCXZTspQmE4COrgeD2wxblLXOd+YyZwUrd7/6lqSf005U2+9tOlID2iH/KrHGbxsljg181mQ0u1VMudkgMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqn8EqaxhqVMG/HFdq+Dhp5aWT/6yxHlS9OAGQamPFY4QhkqGL
	5O0ML3Xs/CZtzT9sG2wuLQOtcziEk8JhKSvLCi1MuUwpXtzYWY6nMR0Jbw==
X-Gm-Gg: ASbGncvsb5LZ4owiL+XIwp9ySiuUX63TDJba4JCYU3bweZiAzZh2j598ro8D5PvBqAT
	kk1f9Bgk9fr6+kxdetiH1ChnkyXnCoNpJyuWh7bntiuGnOkoejdIRcmXbF+t5SmRYsg38/5g1Jm
	A8K5OjPsIS3sKWnoJB5dR6WXTOmyMAXNyuUnIrUCfv/E2LsgKbuFxjueccrgHqGffB9gXGcE0Bp
	BzSd11MkWZ6xOurmK3lTaanTnAz3emtH4uG1f+RLB+kooAfOcJlMTYWf7qd5UJbtNEjgdXFScuX
	GH756cqoyJUdTKvHMrTt8QOpINTgOQamg/h0uQmERehmdMrzOrA9001VMRQratVIBYeOB5LFeuV
	/euHBJ6pBajMgsg==
X-Google-Smtp-Source: AGHT+IFnW/g2yp0HAbUjf9rQgtqfQIrDFWgw2B0U7/YfEuo3mzX1YZlPsY3fFvkLD41QKIbavnw3Xg==
X-Received: by 2002:a05:6000:1849:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-39d0de3e88dmr11741914f8f.35.1744047399185;
        Mon, 07 Apr 2025 10:36:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c301b76f2sm12797261f8f.53.2025.04.07.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:36:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v12] pwm: airoha: Add support for EN7581 SoC
Date: Mon,  7 Apr 2025 19:35:53 +0200
Message-ID: <20250407173559.29600-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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
Changes v12:
- Make shift function more readable
- Use unsigned int where possible
- Better comment some SIPO strangeness
- Move SIPO init after flash map config
- Retrun real values in get_state instead of the
  one saved in bucket
- Improve period_ns parsing so we can better share generators

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
 drivers/pwm/pwm-airoha.c | 506 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 518 insertions(+)
 create mode 100644 drivers/pwm/pwm-airoha.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63beb0010e3e..e939187784c0 100644
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
index 539e0def3f82..97c1c79bbc54 100644
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
index 000000000000..05dd34656c23
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,506 @@
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
+	unsigned int offset, hwpwm_bit;
+
+	if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
+		unsigned int sipohwpwm = hwpwm - AIROHA_PWM_NUM_GPIO;
+
+		offset = sipohwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
+		hwpwm_bit = sipohwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
+
+		/* One FLASH_MAP register handles 8 pins */
+		*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
+		*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
+	} else {
+		offset = hwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
+		hwpwm_bit = hwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
+
+		/* One FLASH_MAP register handles 8 pins */
+		*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
+		*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
+	}
+}
+
+static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_tick,
+					 u64 duty_ns, u32 *duty_tick)
+{
+	u64 tmp_duty_tick;
+
+	*period_tick = div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
+
+	tmp_duty_tick = mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
+					    period_ns);
+	if (tmp_duty_tick > AIROHA_PWM_DUTY_FULL)
+		tmp_duty_tick = AIROHA_PWM_DUTY_FULL;
+	*duty_tick = tmp_duty_tick;
+}
+
+static void airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
+				  u64 *period_ns, u64 *duty_ns)
+{
+	u32 period_tick, duty_tick;
+	unsigned int offset;
+	u32 shift, val;
+
+	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
+	shift = bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
+	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
+
+	regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), &val);
+
+	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
+	*period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
+
+	offset = bucket / AIROHA_PWM_BUCKET_PER_FLASH_PROD;
+	shift = bucket % AIROHA_PWM_BUCKET_PER_FLASH_PROD;
+	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
+
+	regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+		    &val);
+
+	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
+	*duty_ns = DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_FULL);
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
+	unsigned int addr;
+	u32 shift;
+
+	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
+
+	/* index -1 means disable PWM channel */
+	if (index < 0) {
+		/*
+		 * If we need to disable the PWM, we just put low the
+		 * GPIO. No need to setup buckets.
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
+	unsigned int hwpwm = pwm->hwpwm;
+	int bucket;
+
+	bucket = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
+					      hwpwm);
+	if (bucket < 0)
+		return -EBUSY;
+
+	airoha_pwm_calc_bucket_config(pc, bucket, duty_ns, period_ns);
+	airoha_pwm_config_flash_map(pc, hwpwm, bucket);
+
+	pc->initialized |= BIT_ULL(hwpwm);
+	pc->channel_bucket[hwpwm] = bucket;
+
+	/*
+	 * SIPO are special GPIO attached to a shift register chip. The handling
+	 * of this chip is internal to the SoC that takes care of applying the
+	 * values based on the flash map. To apply a new flash map, it's needed
+	 * to trigger a refresh on the shift register chip.
+	 * If we are configuring a SIPO, always reinit the shift register chip
+	 * to make sure the correct flash map is applied.
+	 * We skip reconfiguring the shift register if we related hwpwm
+	 * is disabled (as it doesn't need to be mapped).
+	 */
+	if (!(pc->initialized & BIT_ULL(hwpwm)) && hwpwm >= AIROHA_PWM_NUM_GPIO)
+		airoha_pwm_sipo_init(pc);
+
+	return 0;
+}
+
+static void airoha_pwm_disable(struct airoha_pwm *pc, struct pwm_device *pwm)
+{
+	/* Disable PWM and release the bucket */
+	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
+	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
+
+	pc->initialized &= ~BIT_ULL(pwm->hwpwm);
+
+	/* If no SIPO is used, disable the shift register chip */
+	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
+		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
+				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
+}
+
+static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+	u64 period_ns;
+
+	/* Only normal polarity is supported */
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		airoha_pwm_disable(pc, pwm);
+		return 0;
+	}
+
+	/*
+	 * Period goes at 4ns step, normalize it to check if we can
+	 * share a generator.
+	 */
+	period_ns = rounddown(state->period, AIROHA_PWM_PERIOD_TICK_NS);
+
+	/* Clamp period to MAX supported value */
+	if (period_ns > AIROHA_PWM_PERIOD_MAX_NS)
+		period_ns = AIROHA_PWM_PERIOD_MAX_NS;
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
+	airoha_pwm_get_bucket(pc, bucket, &state->period,
+			      &state->duty_cycle);
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
+	int ret;
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
2.48.1


