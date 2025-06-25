Return-Path: <linux-pwm+bounces-6522-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25A4AE738F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 02:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A205A1BC4233
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D41FC3;
	Wed, 25 Jun 2025 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp4h53YN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6817BA5;
	Wed, 25 Jun 2025 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809696; cv=none; b=u7evUM5yqoXkCkkXhw9AY2vAr7ZoLKDcstSYeWJOUlkT0H1lXxMYis/M3wh66im3irkaWb0ooG3BsMQLVEWMqaHs8hIuQ3GYd6omuEWOLK5Xg7rbcw4OPLHrln/3io4QeiofUYlAIwa+Z4kEOAu7ME7aIAz2xjCvgUBgF98Dkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809696; c=relaxed/simple;
	bh=SvVzhDcAUUWmyoaDMF+k8/k1p3KtgWmD1ASf4hFp46U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZly9tDdvVBcir/a/MWmbOvaR9u+h/EvJz7gAfqc+027E4ENtQ04IK7MLK1OZibSY9Z5WhTWr1oDahD/LDv+FpgA6RA6XhKMMjypLWTbZ0YEt0pQvYpu+CeM0VnKeq+OrW4MQ4Snp3XCcEcslD3K8FB7c88uu+H8awXZmWTWLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp4h53YN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so172581f8f.1;
        Tue, 24 Jun 2025 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750809692; x=1751414492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJbrsopzxI9hN29MIgRLvgZpeA6KJHvvgGd0tC+il18=;
        b=Yp4h53YNRYy8ORYcuhna4yUYyWLNjeqGrK4D8tQzHYpgZpPHqW0V6FrMtw8uYXcfdZ
         N0TINacMMo5ok972ceKrpOBiFVZnEc/kVgx0pAxL2/MticgBwq3kCBI2jzlcs3lkga8Q
         7ILWYhAnBVrDwZDUdnxapgkHxaHhHSBZzi4h4jm8eh+8jp9D6BiyclchPNGZKfqS+10d
         ue9Z79mcl1GhH0RnoEWOXbGlUsCx5vRr0boeMfvx3RyMR8cjCVrqUGMXwYLOPF+WnBmT
         SOajbUwlfVDvqp8Wl2GtB4lj2tYaBxEKu3Bds/l7nlOUx6joUOd9blYYc4uoBdP0cgkz
         nR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809692; x=1751414492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJbrsopzxI9hN29MIgRLvgZpeA6KJHvvgGd0tC+il18=;
        b=je0HPPSGfrNzaENB3RdiSSTY+WNwJ58b/ZHlMTgaMHV9sAfRgNx88PiNTTnumiJlRg
         OheLBJTy+JdARkivXxVXrpEvzjQcn/RJcKPXQzALDtLi1iLrIxM5wfC9UfZ31ru9Fwq5
         7p8Er7EaLJrAP7MuBJp3xdg7TKCGuKh/M2YMWevwswv3F12Bag3MVXhEiv/I0RWyWYh/
         oye5bCatuPbtf2PZTvCJ2DsVvHwYRddwQsN5nP2EgIW6fwJ2QNEbHLsqoH3II3oVUDx2
         vuUKoUAegRr2UXeLAaIfYrmdaBcMW4SFPldpaBq4c3f3kVa87IZfddKqPFsbX5ZZrnLw
         E+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOLunZ2Pzk67kKiN3M645A53ULcOY4nGjbXuw45kLgT+2j7HAYRft/mqFHWVOw0vgo8MKDUKgoraQY@vger.kernel.org, AJvYcCW/ulALrQhZLxIlb4bQkvrb2AdWwDO5BmGtQKUpTRle4GJvD1qyCh9OkN76B22aaoDrPKqydivFlmSYpRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgzJ93OtElgQ6MYLPHPa+DNfC0e8r15DnCZ2rLJooNX2WxahP
	U7I1sNMui+6t2RLsfc52Jsm9KBPBQ8NzFKL4ikKHIN3JrOhd27wb+Oun
X-Gm-Gg: ASbGnctuhZW6vixl9UJofTqfsYvsD8hZs8f0OLcTMM08wKl7bkURKH4igzLGiQicytZ
	ghU4vTPYUuTGKK3xcUONcK865aWwMLxbPIgR1nPxcr4l1tZrjBVpjc6RpKOtIxt4up8134qqeA1
	m2PaO8ZuE2Is+BYXaqbEa7zyV0YxJi5OvdQy5kQqiGLFYHJTz2jjO4npsuHWCGMoNnx7LE3wakZ
	2y92cXeKaTRxUKABK7b1+f0Ix/zqnRz892XtCkiOtUDDZrg62SSVccocLCjSG1RRc60VN7Oap8E
	+1pbjqaVFALV7DVBYSYaYbajGEJ64uhLBUJJTy98sZQ7EYfO9a4Z1xM//c2Mm7PwC3R8Hfen9MU
	/OcPlnzuK2zjA/HawqPOAZ34Sg4k+yJA=
X-Google-Smtp-Source: AGHT+IGLk+juSE5kCTbuwYCzeU/npC48FXFfSLRUjVcRwCDPqZK8ZRpA2HqotiFLS1ovqdW63NQbKg==
X-Received: by 2002:a05:6000:713:b0:3a3:7ba5:9a68 with SMTP id ffacd0b85a97d-3a6ecf48f39mr485243f8f.18.1750809691522;
        Tue, 24 Jun 2025 17:01:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a6e80f27besm3091909f8f.57.2025.06.24.17.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:01:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
Date: Wed, 25 Jun 2025 02:00:39 +0200
Message-ID: <20250625000059.20040-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250625000059.20040-1-ansuelsmth@gmail.com>
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
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
Changes v16:
- Always check regmap return
- Add missing header
- Use bitmask APIs
- Use refcount instead of raw u64
- Fix spelling mistake and improve text
- Drop OF dependency
- Drop redundant always true if condition
- Add myself as Author

Changes v15:
- Fix compilation error for 64bit division on 32bit (patch 01)
- Add prefer async probe

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

 drivers/pwm/Kconfig      |  10 +
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-airoha.c | 613 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 624 insertions(+)
 create mode 100644 drivers/pwm/pwm-airoha.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c866ed388da9..4aa7d94cd680 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -54,6 +54,16 @@ config PWM_ADP5585
 	  This option enables support for the PWM function found in the Analog
 	  Devices ADP5585.
 
+config PWM_AIROHA
+	tristate "Airoha PWM support"
+	depends on ARCH_AIROHA || COMPILE_TEST
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
index 000000000000..836c9c73f779
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,613 @@
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
+#include <linux/bitmap.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/refcount.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
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
+	/* Track concurrent usage of the bucket */
+	refcount_t used;
+	u64 period_ns;
+	u64 duty_ns;
+};
+
+struct airoha_pwm {
+	struct regmap *regmap;
+
+	DECLARE_BITMAP(initialized, AIROHA_PWM_MAX_CHANNELS);
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
+static int airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
+				 u64 *period_ns, u64 *duty_ns)
+{
+	u32 period_tick, duty_tick;
+	unsigned int offset;
+	u32 shift, val;
+	int ret;
+
+	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
+	shift = bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
+	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
+
+	ret = regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset),
+			  &val);
+	if (ret)
+		return ret;
+
+	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
+	*period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
+
+	offset = bucket / AIROHA_PWM_BUCKET_PER_FLASH_PROD;
+	shift = bucket % AIROHA_PWM_BUCKET_PER_FLASH_PROD;
+	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
+
+	ret = regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+			  &val);
+	if (ret)
+		return ret;
+
+	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
+	/*
+	 * Overflow can't occur in multiplication as duty_tick is just 8 bit
+	 * and period_ns is clamped to AIROHA_PWM_PERIOD_MAX_NS and fit in a
+	 * u64.
+	 */
+	*duty_ns = DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_FULL);
+
+	return 0;
+}
+
+static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
+				    u64 period_ns)
+{
+	int best = -ENOENT, unused = -ENOENT;
+	u64 best_period_ns = 0;
+	u64 best_duty_ns = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
+		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
+		u64 bucket_period_ns = bucket->period_ns;
+		u64 bucket_duty_ns = bucket->duty_ns;
+		u32 duty_ticks, duty_ticks_bucket;
+
+		/* If found, save an unused bucket to return it later */
+		if (refcount_read(&bucket->used) == 0) {
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
+	if (!test_bit(hwpwm, pc->initialized))
+		return;
+
+	bucket = pc->channel_bucket[hwpwm];
+	refcount_dec(&pc->buckets[bucket].used);
+}
+
+static int airoha_pwm_apply_bucket_config(struct airoha_pwm *pc, int bucket,
+					  u64 duty_ns, u64 period_ns)
+{
+	u32 period_ticks, duty_ticks;
+	u32 mask, shift, val;
+	u64 offset;
+	int ret;
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
+	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset),
+				 mask, val);
+	if (ret)
+		return ret;
+
+	offset = bucket;
+	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
+	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
+
+	/* Configure duty cycle */
+	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
+	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_ticks) << shift;
+	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+				 mask, val);
+	if (ret)
+		return ret;
+
+	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
+	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
+			 AIROHA_PWM_DUTY_FULL - duty_ticks) << shift;
+	return regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
+				  mask, val);
+}
+
+static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
+					u64 duty_ns, u64 period_ns,
+					unsigned int hwpwm)
+{
+	int bucket, ret;
+
+	/*
+	 * Search for a bucket that already satisfies duty and period
+	 * or an unused one.
+	 * If not found, -ENOENT is returned.
+	 */
+	bucket = airoha_pwm_get_generator(pc, duty_ns, period_ns);
+	if (bucket < 0)
+		return bucket;
+
+	/* Release previous used bucket (if any) */
+	airoha_pwm_release_bucket_config(pc, hwpwm);
+	if (refcount_read(&pc->buckets[bucket].used) == 0) {
+		pc->buckets[bucket].period_ns = period_ns;
+		pc->buckets[bucket].duty_ns = duty_ns;
+		ret = airoha_pwm_apply_bucket_config(pc, bucket,
+						     duty_ns,
+						     period_ns);
+		if (ret)
+			return ret;
+
+		refcount_set(&pc->buckets[bucket].used, 1);
+	} else {
+		refcount_inc(&pc->buckets[bucket].used);
+	}
+
+	return bucket;
+}
+
+static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
+				AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);
+	if (ret)
+		return ret;
+
+	/* Configure shift register chip clock timings, use 32x divisor */
+	ret = regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DIVR,
+			   AIROHA_PWM_SGPIO_CLK_DIVR_32);
+	if (ret)
+		return ret;
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
+	ret = regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * It is necessary to explicitly shift out all zeros after muxing
+	 * to initialize the shift register before enabling PWM
+	 * mode because in PWM mode SIPO will not start shifting until
+	 * it needs to output a non-zero value (bit 31 of led_data
+	 * indicates shifting in progress and it must return to zero
+	 * before led_data can be written or PWM mode can be set)
+	 */
+	ret = regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
+				       !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
+				       10, 200 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA,
+				AIROHA_PWM_SGPIO_LED_DATA_DATA);
+	if (ret)
+		return ret;
+	ret = regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
+				       !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
+				       10, 200 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	/* Set SIPO in PWM mode */
+	return regmap_set_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
+			       AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
+}
+
+static int airoha_pwm_config_flash_map(struct airoha_pwm *pc,
+				       unsigned int hwpwm, int index)
+{
+	unsigned int addr;
+	u32 shift;
+	int ret;
+
+	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
+
+	/* negative index means disable PWM channel */
+	if (index < 0) {
+		/*
+		 * If we need to disable the PWM, we just put low the
+		 * GPIO. No need to setup buckets.
+		 */
+		return regmap_clear_bits(pc->regmap, addr,
+					 AIROHA_PWM_GPIO_FLASH_EN << shift);
+	}
+
+	ret = regmap_update_bits(pc->regmap, addr,
+				 AIROHA_PWM_GPIO_FLASH_SET_ID << shift,
+				 FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID, index) << shift);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(pc->regmap, addr, AIROHA_PWM_GPIO_FLASH_EN << shift);
+}
+
+static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
+			     u64 duty_ns, u64 period_ns)
+{
+	unsigned int hwpwm = pwm->hwpwm;
+	int bucket, ret;
+
+	bucket = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
+					      hwpwm);
+	if (bucket < 0)
+		return bucket;
+
+	ret = airoha_pwm_config_flash_map(pc, hwpwm, bucket);
+	if (ret) {
+		refcount_dec(&pc->buckets[bucket].used);
+		return ret;
+	}
+
+	set_bit(hwpwm, pc->initialized);
+	pc->channel_bucket[hwpwm] = bucket;
+
+	/*
+	 * SIPO are special GPIO attached to a shift register chip. The handling
+	 * of this chip is internal to the SoC that takes care of applying the
+	 * values based on the flash map. To apply a new flash map, it's needed
+	 * to trigger a refresh on the shift register chip.
+	 * If a SIPO is getting configuring , always reinit the shift register
+	 * chip to make sure the correct flash map is applied.
+	 * Skip reconfiguring the shift register if the related hwpwm
+	 * is disabled (as it doesn't need to be mapped).
+	 */
+	if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
+		ret = airoha_pwm_sipo_init(pc);
+		if (ret) {
+			airoha_pwm_release_bucket_config(pc, hwpwm);
+			return ret;
+		}
+	}
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
+	clear_bit(pwm->hwpwm, pc->initialized);
+
+	/* If no SIPO is used, disable the shift register chip */
+	if (find_next_bit(pc->initialized, AIROHA_PWM_MAX_CHANNELS,
+			  AIROHA_PWM_NUM_GPIO) >= AIROHA_PWM_NUM_GPIO)
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
+	period_ns = rounddown_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
+
+	/*
+	 * Duty is divided in 255 segment, normalize it to check if we
+	 * can share a generator.
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
+	return airoha_pwm_get_bucket(pc, bucket, &state->period,
+				     &state->duty_cycle);
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
+	unsigned int i;
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
+	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++)
+		refcount_set(&pc->buckets[i].used, 0);
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
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = airoha_pwm_of_match,
+	},
+	.probe = airoha_pwm_probe,
+};
+module_platform_driver(airoha_pwm_driver);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_AUTHOR("Markus Gothe <markus.gothe@genexis.eu>");
+MODULE_AUTHOR("Benjamin Larsson <benjamin.larsson@genexis.eu>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Airoha EN7581 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


