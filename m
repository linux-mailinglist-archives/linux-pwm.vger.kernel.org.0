Return-Path: <linux-pwm+bounces-4020-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72A9BA836
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 22:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B28B2062B
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248A18BBAA;
	Sun,  3 Nov 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvBaCsg5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2416087B;
	Sun,  3 Nov 2024 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667890; cv=none; b=iE/rpVK4LZ0qsLmY8PuTJyuFeUpfPyvUtIUFOQvDDosrbJ0YB4+cG1CFWXJGknQJg9GywNHU88rWHWI34CKafZE8J3rkY0Hho9tnSCO3ZS/H09fbBarZ2Gw6IqSJj1tiJd8vlPrLcKxH/zmddsdZm5eukPL8c8ktCxWOZRPcwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667890; c=relaxed/simple;
	bh=d/JnkB6K7WA0lLD6CtsP3OjiVO74avE9TAmPfdOUqHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iVbwMo45tLcIiVP5uEx0MUNZ3wTDhxxwY6mXjVxZPff+Ic+wlbYWBRZAckZBALBJlAOFj28qJNePBI47fD53b9yRr6EtHBby+Wy+1+IphqpuQLGG7MQapeFocVWxWu1aG/FpiLvNifJR33S+2jk4z45RXFAc8cOuZNaCH/1lzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvBaCsg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FD9C4CECD;
	Sun,  3 Nov 2024 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667889;
	bh=d/JnkB6K7WA0lLD6CtsP3OjiVO74avE9TAmPfdOUqHI=;
	h=From:Date:Subject:To:Cc:From;
	b=LvBaCsg5eAmI1JjzDNpfs5GetPj0HW5iRBMlc0ocxJFu475WdUPNcGJ4pLKoXXaH7
	 3SW1Pqf0kUotXKWZdSt2Jd2rUwN+08FeY8fBxx8fVAx/T4NK7syS2kKnc25NnMZQiO
	 NCL+kax3Z9Q9HB9llRs3a4JiegPighvBCItaeKBbOGkVWYFCLF2j2eVIk48XbsCllp
	 yw4p4SJsiwwHfhwUeeWfZY5gjz05i9kLi4fblql3Igc4X5PZGMGavJ+PwAG73iKeJQ
	 Ed6uoXNiX5gIqLZWd0ObZBrwED+EehPV9juPzf2mb2eqKmnUgpphTSdj1aLAWnAPSD
	 nVsPvIBTGzTxQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 03 Nov 2024 22:04:04 +0100
Subject: [PATCH v10] pwm: airoha: Add support for EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241103-en7581-pinctrl-v10-1-1990fb6996a0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEPlJ2cC/2XSzW7bMAwH8FcJfJ4CUaK+ctp7DD2IEpUYzexM8
 YxuRd69SlqsXnUkgR/5F6HX4cp15Otw2L0OldfxOs5TK0B+2w3pFKcjizG3xqCkQunBC56c8SA
 u45SWehZABZQEg8RyaOhSuYwvj4k/nlpd6vxTLKfK8TFGZqMde08WPTpKyBicsaQwkOKSU0EfK
 Kg9OKV1UIi4P47L/jxXnv7O35+5Tnzez/X4sazyr98t9fK+8TPzYfdI7KQRZa7CCgBBlyKixsA
 lSZ+LP6xquGc8jddlrn8eR2it+5z35yr19bmrElJQBGMCOB1d2Sa6z1r1xmvovG4+eGYqhDla2
 3n89AF6j81bGVPQ2VlJ1Hnzz4OUvTfN5wSJDSqyqd9vNx50523zSqJnlWUISXXebb3tvGseS7E
 ARdl2wM77re++2+rv97fOUrA2QobOh41Xff7QfCwkE6VIktN//na7vQE2p3aaEgMAAA==
X-Change-ID: 20240818-en7581-pinctrl-1bf120154be0
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.2

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

Introduce driver for PWM module available on EN7581 SoC.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
needs to access the same memory block (gpio memory region) to configure
{gio,irq}_chip and pwm functionalities respectively, so model them as
childs of a parent mfd driver.
Current EN7581 pinctrl driver supports the following functionalities:
- pin multiplexing via chip_scu syscon
- pin pull-up, pull-down, open-drain, current strength,
  {input,output}_enable, output_{low,high} via chip_scu syscon
- gpio controller
- irq controller
---
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
---
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-airoha.c | 434 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16d451e987dcc5f10e0b57edc32ee1..99aa87136c272555c10102590fcf9f911161c3d3 100644
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
index 9081e0c0e9e09713fe05479c257eebe5f02b91e9..fbf7723d845807fd1e2893c6ea4f736785841b0d 100644
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
index 0000000000000000000000000000000000000000..78bc29e1deef9640f7021ce44fff5bce32dd5477
--- /dev/null
+++ b/drivers/pwm/pwm-airoha.c
@@ -0,0 +1,434 @@
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
+#define REG_SGPIO_LED_DATA		0x0024
+#define SGPIO_LED_DATA_SHIFT_FLAG_MASK	BIT(31)
+#define SGPIO_LED_DATA_DATA_MASK	GENMASK(16, 0)
+
+#define REG_SGPIO_CLK_DIVR		0x0028
+#define SGPIO_CLK_DIVR_MASK		GENMASK(1, 0)
+
+#define REG_SGPIO_CLK_DLY		0x002c
+
+#define REG_SIPO_FLASH_MODE_CFG		0x0030
+#define SERIAL_GPIO_FLASH_MODE_MASK	BIT(1)
+#define SERIAL_GPIO_MODE_74HC164_MASK	BIT(0)
+
+#define REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + (((_n) >> 1) << 2))
+#define GPIO_FLASH_PRD_HIGH_MASK(_n)	\
+	GENMASK(7 + (((_n) % 2) << 4),	((_n) % 2) << 4)
+#define GPIO_FLASH_PRD_LOW_MASK(_n)	\
+	GENMASK(15 + (((_n) % 2) << 4), 8 + (((_n) % 2) << 4))
+
+#define REG_GPIO_FLASH_MAP(_n)		(0x004c + (((_n) >> 3) << 2))
+#define GPIO_FLASH_EN_MASK(_n)		BIT(3 + (((_n) % 8) << 2))
+#define GPIO_FLASH_SET_ID_MASK(_n)	\
+	GENMASK(2 + (((_n) % 8) << 2), ((_n) % 8) << 2)
+
+/* Register map is equal to GPIO flash map */
+#define REG_SIPO_FLASH_MAP(_n)		(0x0054 + (((_n) >> 3) << 2))
+
+#define REG_CYCLE_CFG_VALUE(_n)		(0x0098 + (((_n) >> 2) << 2))
+#define WAVE_GEN_CYCLE_MASK(_n)		\
+	GENMASK(7 + (((_n) % 4) << 3), ((_n) % 4) << 3)
+
+#define AIROHA_PWM_NUM_BUCKETS		8
+/*
+ * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
+ * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels, 16-32.
+ * However, we've only got 8 concurrent waveform generators and can therefore
+ * only use up to 8 different combinations of duty cycle and period at a time.
+ */
+#define AIROHA_PWM_NUM_GPIO		16
+#define AIROHA_PWM_NUM_SIPO		17
+#define AIROHA_PWM_MAX_CHANNELS		(AIROHA_PWM_NUM_GPIO + AIROHA_PWM_NUM_SIPO)
+
+#define AIROHA_PWM_FIELD_GET(mask, val)	(((val) & (mask)) >> __ffs(mask))
+#define AIROHA_PWM_FIELD_SET(mask, val)	(((val) << __ffs(mask)) & (mask))
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
+#define AIROHA_PWM_PERIOD_MIN_NS	(4 * NSEC_PER_MSEC)
+#define AIROHA_PWM_PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
+/* It is represented internally as 1/250 s between 1 and 250 */
+#define AIROHA_PWM_PERIOD_MIN		1
+#define AIROHA_PWM_PERIOD_MAX		250
+/* Duty cycle is relative with 255 corresponding to 100% */
+#define AIROHA_PWM_DUTY_FULL		255
+
+static u32 airoha_pwm_get_duty_tick_from_ns(u64 duty_ns, u64 period_ns)
+{
+	u32 duty_tick;
+
+	duty_tick = mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
+					period_ns);
+	return min_t(u32, duty_tick, AIROHA_PWM_DUTY_FULL);
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
+		duty_tick = airoha_pwm_get_duty_tick_from_ns(duty_ns,
+							     period_ns);
+		duty_tick_bucket =
+			airoha_pwm_get_duty_tick_from_ns(bucket->duty_ns,
+							 bucket->period_ns);
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
+	regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
+			  SERIAL_GPIO_MODE_74HC164_MASK);
+
+	/* Configure shift register timings, use 32x divisor */
+	regmap_write(pc->regmap, REG_SGPIO_CLK_DIVR,
+		     FIELD_PREP(SGPIO_CLK_DIVR_MASK, 0x3));
+
+	/*
+	 * The actual delay is clock + 1.
+	 * Notice that clock delay should not be greater
+	 * than (divisor / 2) - 1.
+	 * Set to 0 by default. (aka 1)
+	 */
+	regmap_write(pc->regmap, REG_SGPIO_CLK_DLY, 0x0);
+
+	/*
+	 * It it necessary to after muxing explicitly shift out all
+	 * zeroes to initialize the shift register before enabling PWM
+	 * mode because in PWM mode SIPO will not start shifting until
+	 * it needs to output a non-zero value (bit 31 of led_data
+	 * indicates shifting in progress and it must return to zero
+	 * before led_data can be written or PWM mode can be set)
+	 */
+	if (regmap_read_poll_timeout(pc->regmap, REG_SGPIO_LED_DATA, val,
+				     !(val & SGPIO_LED_DATA_SHIFT_FLAG_MASK),
+				     10, 200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	regmap_clear_bits(pc->regmap, REG_SGPIO_LED_DATA,
+			  SGPIO_LED_DATA_DATA_MASK);
+	if (regmap_read_poll_timeout(pc->regmap, REG_SGPIO_LED_DATA, val,
+				     !(val & SGPIO_LED_DATA_SHIFT_FLAG_MASK),
+				     10, 200 * USEC_PER_MSEC))
+		return -ETIMEDOUT;
+
+	/* Set SIPO in PWM mode */
+	regmap_set_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
+			SERIAL_GPIO_FLASH_MODE_MASK);
+
+	return 0;
+}
+
+static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int bucket,
+					  u64 duty_ns, u64 period_ns)
+{
+	u32 period_tick, duty_tick, mask, val;
+
+	duty_tick = airoha_pwm_get_duty_tick_from_ns(duty_ns, period_ns);
+	period_tick = mul_u64_u64_div_u64(period_ns, AIROHA_PWM_PERIOD_MAX,
+					  NSEC_PER_SEC);
+	period_tick = min_t(u32, period_tick, AIROHA_PWM_PERIOD_MAX);
+
+	/* Configure frequency divisor */
+	mask = WAVE_GEN_CYCLE_MASK(bucket);
+	val = AIROHA_PWM_FIELD_SET(mask, period_tick);
+	regmap_update_bits(pc->regmap, REG_CYCLE_CFG_VALUE(bucket), mask, val);
+
+	/* Configure duty cycle */
+	mask = GPIO_FLASH_PRD_HIGH_MASK(bucket);
+	val = AIROHA_PWM_FIELD_SET(mask, duty_tick);
+	regmap_update_bits(pc->regmap, REG_GPIO_FLASH_PRD_SET(bucket),
+			   mask, val);
+
+	mask = GPIO_FLASH_PRD_LOW_MASK(bucket);
+	val = AIROHA_PWM_FIELD_SET(mask, AIROHA_PWM_DUTY_FULL - duty_tick);
+	regmap_update_bits(pc->regmap, REG_GPIO_FLASH_PRD_SET(bucket),
+			   mask, val);
+}
+
+static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
+					unsigned int hwpwm, int index)
+{
+	u32 addr, mask, val;
+
+	if (hwpwm < AIROHA_PWM_NUM_GPIO) {
+		addr = REG_GPIO_FLASH_MAP(hwpwm);
+	} else {
+		hwpwm -= AIROHA_PWM_NUM_GPIO;
+		addr = REG_SIPO_FLASH_MAP(hwpwm);
+	}
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
+		regmap_clear_bits(pc->regmap, addr, GPIO_FLASH_EN_MASK(hwpwm));
+		return;
+	}
+
+	mask = GPIO_FLASH_SET_ID_MASK(hwpwm);
+	val = AIROHA_PWM_FIELD_SET(mask, index);
+	regmap_update_bits(pc->regmap, addr, mask, val);
+	regmap_set_bits(pc->regmap, addr, GPIO_FLASH_EN_MASK(hwpwm));
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
+	if (!(pc->initialized & BIT_ULL(hwpwm)) &&
+	    hwpwm >= AIROHA_PWM_NUM_GPIO)
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
+		regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
+				  SERIAL_GPIO_FLASH_MODE_MASK);
+}
+
+static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	u64 duty_ns = state->enabled ? state->duty_cycle : 0;
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
+	if (period_ns < AIROHA_PWM_PERIOD_MIN_NS)
+		return -EINVAL;
+
+	return airoha_pwm_config(pc, pwm, duty_ns, period_ns);
+}
+
+static int airoha_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
+	int ret, hwpwm = pwm->hwpwm;
+	u32 addr, val;
+	u8 bucket;
+
+	if (hwpwm < AIROHA_PWM_NUM_GPIO) {
+		addr = REG_GPIO_FLASH_MAP(hwpwm);
+	} else {
+		hwpwm -= AIROHA_PWM_NUM_GPIO;
+		addr = REG_SIPO_FLASH_MAP(hwpwm);
+	}
+
+	ret = regmap_read(pc->regmap, addr, &val);
+	if (ret)
+		return ret;
+
+	state->enabled = AIROHA_PWM_FIELD_GET(GPIO_FLASH_EN_MASK(hwpwm), val);
+	if (!state->enabled)
+		return 0;
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	bucket = AIROHA_PWM_FIELD_GET(GPIO_FLASH_SET_ID_MASK(hwpwm), val);
+	ret = regmap_read(pc->regmap, REG_CYCLE_CFG_VALUE(bucket), &val);
+	if (ret)
+		return ret;
+
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
+	if (IS_ERR(pc->regmap)) {
+		dev_err_probe(dev, PTR_ERR(pc->regmap), "failed to get PWM regmap");
+		return PTR_ERR(pc->regmap);
+	}
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret)
+		dev_err_probe(dev, ret, "failed to add PWM chip");
+
+	return ret;
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

---
base-commit: efd367efd1357176f4e725e9aa0eb70fc546114f
change-id: 20240818-en7581-pinctrl-1bf120154be0
prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


