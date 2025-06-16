Return-Path: <linux-pwm+bounces-6386-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DBCADBAE9
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 22:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09233B760A
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331528A402;
	Mon, 16 Jun 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/qKMCch"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B265289836;
	Mon, 16 Jun 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104971; cv=none; b=Oq995M/pjD+UFjDwaSLXJJYKQUFhiJbp+jV/F6CRZI3L7vGlNuy8M5kc44qvzHIgdq9bcFJUTgHuqR0ElKvxHSeTF8wo2aZ4FZualVfDrHpfmMiXuPnlpCwVO5Po5JrgdHXMSKvoiKovc+25ciJN0zJuUkNym6IBqKFB1JJP9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104971; c=relaxed/simple;
	bh=5utOUPoLfkVixm4TsXtYZUgXulhsjSyAx+2Pv5701r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Epzb2LeeenKauBc5fEts/G8IXEPNM4VxI71Y83MrJjR6GRjmTjPJS02h6SKvJiKNadPn5YimLhPETjsc0xp7VIb99gJcjdx3x0ugu0KmBPv9nED5MLdL5ruYULOoJkcTcwqYE3Zs1j9y8hBlPg0Io9Pqb2Qrp+WsURFon3xCqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/qKMCch; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso2893083f8f.0;
        Mon, 16 Jun 2025 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750104967; x=1750709767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shTlnmL88q8HBEq4jKkHTQX16PdTY4CXUfgPlC8soTM=;
        b=d/qKMCchh5HIgVc4bqmJqOk2SbdnXzp8LKuMQL/PI1aVM8hZUbE8fljWEm6ljng/jv
         bmmy9NJvlabSYw8oj6/euOrwEJ58RB86sli2X9e26QxQBolNjrdkSK20urEMf6p7nxS1
         i1lB7zTX07QQ1BVtZ7uLkYLp3DoPgiwJmGttsjNI8RXMuG3f9QuexDGMveN4zSY8Lp0e
         mVsMitFO9OI3JTA+4H6edtQPRw0s8lEpRTVYFtDe+AFjK9ezBHPt92FijbeN+Hi5Zq10
         NPeWXx7xSWFJlQ40Zz4IoMYJkChL8UBTQeJ+LRZZ7vIpLxLazkwl53kJtbnB+4COwuIT
         X+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750104967; x=1750709767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shTlnmL88q8HBEq4jKkHTQX16PdTY4CXUfgPlC8soTM=;
        b=L8i4MPYp0BLwRo9OzUHaot++guD9pTGyORHLm24WICcCBtWLv7S+ZUhdUlIt6/JcxN
         bgq4mjw5b3/ozE8iHZ2DHSo6bZbjuEqo0Wq9csdDQj24zyaI7ksByXMAe9Q35o8IvsrG
         v45G+bIzj5HZOT+jvqoAQB7D0XTqk40S6EM+tHaGDG/yPyVsOffB2qN+p5dSL4rmEqP1
         Hk1CnhEvElmLuiWVDQg929uYYwl29hvqhmNJis8Y+wmfdbOrVBcfqOKxwJxtOqexAg+A
         qxchJT7C1a6pqIsblnH28ueZi0Y0i3YR3Nl4ky1xbujqz5Rur8Wrw+TyySIJj+sUrbrp
         vJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCVjscCF5+5l/DyytovPdkeqpn9Gf/g/hxPAwioMDo/P0nOTpYA4iLrWE8q+tD8wAoaDfBzzHHY15c36fbI=@vger.kernel.org, AJvYcCXVOMoWyWTLhv/9A1m0R2RvP9oRtYYWj2l/bIdJTC96uncNozuj5Kn95vfQ+GXqM1/HbPOgN4fYT8TQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqYQ7Mx6Z2tvpnLrwXIHMHXboCPpsUsXs+A5H/O4cPZGaoFJl
	jYkBxpHpubt9wRx4kfjLLi+zZT4JpEl/WuqtURtpILZwNbWYz4n6wi5j
X-Gm-Gg: ASbGncsL/KMaMamBVwSSlHICeXI1VKiuMYwySAMPI7K5m6XzZ4BNJY5QaU73tdwLO1y
	sxPzK35TgmzAZ1hjuQw0k4BMppnuBDSydQe6oI17uPecVNT84RCoaSaP0oSjXCkQyAPxgYhXT0Q
	5xGMx4/RTpbRghdXy0oNc0A+l981vWVrnSOt0P4NgEkJESeElTwyxfTHcWbOhRMYgjZH2JrLGs4
	pfmPQpd/eVKonMq7zyO2Bbe7AEmMq+Ys7X2AIhYzL4No7SK7m9yGZGjrogo0AydrcjzGhbHPiAm
	elnHBPb8iqGw+VkH3c9HRZUJXHmXgc4qMWFilnHrihfB4bT1L7cZhEeFDg7dzz9xnoPFU4kLwgx
	NSkig9t+ZjlYfsK5KdqQWPeYonZWNV8Y=
X-Google-Smtp-Source: AGHT+IHgIF+fh0+18abSJVixtY+xhgNPALMc+qUX9/uoAXWcC6TkcpJNNIGMAFGN7WUsJai3oPrkhw==
X-Received: by 2002:a05:6000:4304:b0:3a5:1f2:68f3 with SMTP id ffacd0b85a97d-3a572e2e049mr9558142f8f.46.1750104966961;
        Mon, 16 Jun 2025 13:16:06 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568b090b0sm11878077f8f.46.2025.06.16.13.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:16:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v14] pwm: airoha: Add support for EN7581 SoC
Date: Mon, 16 Jun 2025 22:15:24 +0200
Message-ID: <20250616201532.29047-1-ansuelsmth@gmail.com>
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
Changes v14:
- Fix logic for bucket recycle
  (was tested by not releasing the bucket and observing
   the best one gets used)
- Assign bucket period and duty only if not used
- Skip bucket period/duty calculation if already used
- Permit disable also if inversed polarity is asked
- Normalize duty similar to period

Changes v13:
- Reorder include
- Split ticks_from_ns function
- Add additional comments for shift register chip clock
- Address suggested minor optimization (Uwe)

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
 drivers/pwm/pwm-airoha.c | 569 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 581 insertions(+)
 create mode 100644 drivers/pwm/pwm-airoha.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c866ed388da9..113ca01f319f 100644
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
index 5c782af8f49b..cd3e6de2e44a 100644
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
index 000000000000..5a1732ccb90a
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,569 @@
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
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define AIROHA_PWM_REG_SGPIO_LED_DATA		0x0024
+#define AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
+#define AIROHA_PWM_SGPIO_LED_DATA_DATA		GENMASK(16, 0)
+
+#define AIROHA_PWM_REG_SGPIO_CLK_DIVR		0x0028
+#define AIROHA_PWM_SGPIO_CLK_DIVR		GENMASK(1, 0)
+#define AIROHA_PWM_SGPIO_CLK_DIVR_32		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3)
+#define AIROHA_PWM_SGPIO_CLK_DIVR_16		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x2)
+#define AIROHA_PWM_SGPIO_CLK_DIVR_8		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x1)
+#define AIROHA_PWM_SGPIO_CLK_DIVR_4		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x0)
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
+static u32 airoha_pwm_get_period_ticks_from_ns(u64 period_ns)
+{
+	return div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
+}
+
+static u32 airoha_pwm_get_duty_ticks_from_ns(u64 period_ns, u64 duty_ns)
+{
+	return mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
+				   period_ns);
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
+	/*
+	 * Overflow can't occur in multiplication as duty_tick is just 8 bit
+	 * and period_ns is clamped to AIROHA_PWM_PERIOD_MAX_NS and fit in a
+	 * u64.
+	 */
+	*duty_ns = DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_FULL);
+}
+
+static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
+				    u64 period_ns)
+{
+	int i, best = -ENOENT, unused = -ENOENT;
+	u64 best_period_ns = 0;
+	u64 best_duty_ns = 0;
+
+	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
+		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
+		u64 bucket_period_ns = bucket->period_ns;
+		u64 bucket_duty_ns = bucket->duty_ns;
+		u32 duty_ticks, duty_ticks_bucket;
+
+		/* If found, save an unused bucket to return it later */
+		if (!bucket->used) {
+			unused = i;
+			continue;
+		}
+
+		/* We found a matching bucket, exit early */
+		if (duty_ns == bucket_duty_ns &&
+		    period_ns == bucket_period_ns)
+			return i;
+
+		/*
+		 * Unlike duty cycle zero, which can be handled by
+		 * disabling PWM, a generator is needed for full duty
+		 * cycle but it can be reused regardless of period
+		 */
+		duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
+		duty_ticks_bucket = airoha_pwm_get_duty_ticks_from_ns(bucket_period_ns,
+								      bucket_duty_ns);
+		if (duty_ticks == AIROHA_PWM_DUTY_FULL &&
+		    duty_ticks_bucket == AIROHA_PWM_DUTY_FULL)
+			return i;
+
+		/*
+		 * With an unused bucket available, skip searching for
+		 * a bucket to recycle (closer to the requested period/duty)
+		 */
+		if (unused != -ENOENT)
+			continue;
+
+		/* Ignore bucket with invalid configs */
+		if (bucket_period_ns > period_ns ||
+		    bucket_duty_ns > duty_ns)
+			continue;
+
+		/*
+		 * Search for a bucket closer to the requested period/duty
+		 * that has the maximal possible period that isn't bigger
+		 * than the requested period. For that period pick the maximal
+		 * duty_cycle that isn't bigger than the requested duty_cycle.
+		 */
+		if (bucket_period_ns > best_period_ns ||
+		    (bucket_period_ns == best_period_ns &&
+		     bucket_duty_ns > best_duty_ns)) {
+			best_period_ns = bucket_period_ns;
+			best_duty_ns = bucket_duty_ns;
+			best = i;
+		}
+	}
+
+	/* With no unused bucket, return the best one found (if ever) */
+	return unused == -ENOENT ? best : unused;
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
+static void airoha_pwm_apply_bucket_config(struct airoha_pwm *pc, int bucket,
+					   u64 duty_ns, u64 period_ns)
+{
+	u32 period_ticks, duty_ticks;
+	u32 mask, shift, val;
+	u64 offset;
+
+	period_ticks = airoha_pwm_get_period_ticks_from_ns(period_ns);
+	duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
+
+	offset = bucket;
+	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
+	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
+
+	/* Configure frequency divisor */
+	mask = AIROHA_PWM_WAVE_GEN_CYCLE << shift;
+	val = FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_ticks) << shift;
+	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), mask, val);
+
+	offset = bucket;
+	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
+	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
+
+	/* Configure duty cycle */
+	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
+	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_ticks) << shift;
+	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+			   mask, val);
+
+	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
+	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
+			 AIROHA_PWM_DUTY_FULL - duty_ticks) << shift;
+	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+			   mask, val);
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
+	 * If not found, -ENOENT is returned.
+	 */
+	bucket = airoha_pwm_get_generator(pc, duty_ns, period_ns);
+	if (bucket < 0)
+		return bucket;
+
+	/* Release previous used bucket (if any) */
+	airoha_pwm_release_bucket_config(pc, hwpwm);
+	if (!pc->buckets[bucket].used) {
+		pc->buckets[bucket].period_ns = period_ns;
+		pc->buckets[bucket].duty_ns = duty_ns;
+		airoha_pwm_apply_bucket_config(pc, bucket, duty_ns,
+					       period_ns);
+	}
+
+	pc->buckets[bucket].used |= BIT_ULL(hwpwm);
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
+	/* Configure shift register chip clock timings, use 32x divisor */
+	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DIVR,
+		     AIROHA_PWM_SGPIO_CLK_DIVR_32);
+
+	/*
+	 * Configure the shift register chip clock delay. This needs
+	 * to be configured based on the chip characteristics when the SoC
+	 * apply the shift register configuration.
+	 * This doesn't affect actual PWM operation and is only specific to
+	 * the shift register chip.
+	 *
+	 * For 74HC164 we set it to 0.
+	 *
+	 * For reference, the actual delay applied is the internal clock
+	 * feed to the SGPIO chip + 1.
+	 *
+	 * From documentation is specified that clock delay should not be
+	 * greater than (AIROHA_PWM_REG_SGPIO_CLK_DIVR / 2) - 1.
+	 */
+	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
+
+	/*
+	 * It is necessary to explicitly shift out all zeros after muxing
+	 * to initialize the shift register before enabling PWM
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
+	u64 duty_ns = state->duty_cycle;
+	u64 period_ns = state->period;
+
+	if (!state->enabled) {
+		airoha_pwm_disable(pc, pwm);
+		return 0;
+	}
+
+	/* Only normal polarity is supported */
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	/* Exit early if period is less than minimum supported */
+	if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
+		return -EINVAL;
+
+	/*
+	 * Period goes at 4ns step, normalize it to check if we can
+	 * share a generator.
+	 */
+	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
+
+	/*
+	 * Duty goes at 255 step, normalize it to check if we can
+	 * share a generator.
+	 */
+	duty_ns = DIV_U64_ROUND_UP(duty_ns * AIROHA_PWM_DUTY_FULL,
+				   AIROHA_PWM_DUTY_FULL);
+
+	/* Clamp period to MAX supported value */
+	if (period_ns > AIROHA_PWM_PERIOD_MAX_NS) {
+		period_ns = AIROHA_PWM_PERIOD_MAX_NS;
+
+		if (duty_ns > period_ns)
+			duty_ns = period_ns;
+	}
+
+	return airoha_pwm_config(pc, pwm, duty_ns, period_ns);
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


