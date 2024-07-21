Return-Path: <linux-pwm+bounces-2878-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D861293856D
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 18:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B50B20F49
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A5116B39C;
	Sun, 21 Jul 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KHAxgd0N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92416A957;
	Sun, 21 Jul 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721577677; cv=none; b=NeetTky/JjiyFxPccQa/95qt+JkOFrhUenTUtgv+4PiW9a6WZKunDVXy+ZdEJOip/rm6nKh8vdI1+sA/DB1XgSmAHiCW4kS0yKFJajAIZHQKjb7kzkz9pBZef9XjGqb7jwGK3IsfDgLT0IcNE0JjfTVCfe4UT1TvbGKYqeGE7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721577677; c=relaxed/simple;
	bh=iDhOO4X9y3eSBO9TaT9Yo0NX3EpU4bC0T1x93SfbK9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyWJZ9k2lpV3bYRUK9K5/dLDqX9BntH8lg5qSpo8owJ4TO6dymGx1K8lTMyWeZmnp4Iw+eE2BR2mUiYFW49Jo4/bRsmyCdBr13L+iNJFnauooZDqvDRUfPCDTmKGJaUnopOfkSVHs8I9nqaCzGWGbBlY2jwcY/p1aoidX/mhk5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KHAxgd0N; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4EFC4226;
	Sun, 21 Jul 2024 18:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721577632;
	bh=iDhOO4X9y3eSBO9TaT9Yo0NX3EpU4bC0T1x93SfbK9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHAxgd0NP1y0k+NeYh2JioElolTu+whiKixc5cltWRVPWgzNLRQAIUuyXMCJAym66
	 DbG6lPYD8KHsK41yGa3whB+Gbra3M2J1jYK7lZYhR1JMlwAU0Ej0ze9qgqo+m5ryX0
	 NQHtdu5lURnL38n79aEK8Eek+PZl87FP8zqRr8yo=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: [PATCH v6 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Date: Sun, 21 Jul 2024 19:00:49 +0300
Message-ID: <20240721160049.20470-5-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240721160049.20470-1-laurent.pinchart@ideasonboard.com>
References: <20240721160049.20470-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Clark Wang <xiaoning.wang@nxp.com>

The ADP5585 is a 10/11 input/output port expander with a built in keypad
matrix decoder, programmable logic, reset generator, and PWM generator.
This driver supports the PWM function using the platform device
registered by the core MFD driver.

The driver is derived from an initial implementation from NXP, available
in commit 113113742208 ("MLK-25922-1 pwm: adp5585: add adp5585 PWM
support") in their BSP kernel tree. It has been extensively rewritten.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v5:

- Use regmap_clear_bits() and regmap_set_bits()
- Move ADP5585_OSC_EN bit handling to .apply()
- Drop comma after sentinel

Changes since v4:

- Use the regmap bulk API

Changes since v2:

- Add missing headers
- Sort headers

Changes since v1:

- Drop mutex
- Restore R3 pinconfig to known value
- Simplify error check in pwm_adp5585_request()
- Don't fake PWM_POLARITY_INVERSED
- Fix rounding of period and duty cycle
- Drop OF match table
- Drop empty .remove() handler
- Allocate pwm_chip dynamically
- Document limitations
- Add platform ID table
- Set struct device of_node manually
- Merge child DT node into parent node

Changes compared to the NXP original version

- Add MAINTAINERS entry
- Drop pwm_ops.owner
- Fix compilation
- Add prefix to compatible string
- Switch to regmap
- Use devm_pwmchip_add()
- Cleanup header includes
- White space fixes
- Drop ADP5585_REG_MASK
- Fix register field names
- Use mutex scope guards
- Clear OSC_EN when freeing PWM
- Reorder functions
- Clear PWM_IN_AND and PWM_MODE bits
- Support inverted polarity
- Clean up on/off computations
- Fix duty cycle computation in .get_state()
- Destroy mutex on remove
- Update copyright
- Update license to GPL-2.0-only
---
 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |   7 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-adp5585.c | 183 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 drivers/pwm/pwm-adp5585.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b748af2acf9f..a2087f6647e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -534,6 +534,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
 F:	drivers/gpio/gpio-adp5585.c
 F:	drivers/mfd/adp5585.c
+F:	drivers/pwm/pwm-adp5585.c
 F:	include/linux/mfd/adp5585.h
 
 ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1dd7921194f5..b778ecee3e9b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -47,6 +47,13 @@ config PWM_AB8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-ab8500.
 
+config PWM_ADP5585
+	tristate "ADP5585 PWM support"
+	depends on MFD_ADP5585
+	help
+	  This option enables support for the PWM function found in the Analog
+	  Devices ADP5585.
+
 config PWM_APPLE
 	tristate "Apple SoC PWM support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 90913519f11a..f24d518d20f2 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
+obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
new file mode 100644
index 000000000000..c2d2b65cd807
--- /dev/null
+++ b/drivers/pwm/pwm-adp5585.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices ADP5585 PWM driver
+ *
+ * Copyright 2022 NXP
+ * Copyright 2024 Ideas on Board Oy
+ *
+ * Limitations:
+ * - The .apply() operation executes atomically, but may not wait for the
+ *   period to complete (this is not documented and would need to be tested).
+ * - Disabling the PWM drives the output pin to a low level immediately.
+ * - The hardware can only generate normal polarity output.
+ */
+
+#include <asm/byteorder.h>
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math64.h>
+#include <linux/mfd/adp5585.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define ADP5585_PWM_CHAN_NUM		1
+
+#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
+#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
+#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
+
+static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+
+	return regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
+				  ADP5585_R3_EXTEND_CFG_MASK,
+				  ADP5585_R3_EXTEND_CFG_PWM_OUT);
+}
+
+static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+
+	regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
+			   ADP5585_R3_EXTEND_CFG_MASK,
+			   ADP5585_R3_EXTEND_CFG_GPIO4);
+}
+
+static int pwm_adp5585_apply(struct pwm_chip *chip,
+			     struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	u64 period, duty_cycle;
+	u32 on, off;
+	__le16 val;
+	int ret;
+
+	if (!state->enabled) {
+		regmap_clear_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
+		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
+		return 0;
+	}
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
+		return -EINVAL;
+
+	period = min(state->period, ADP5585_PWM_MAX_PERIOD_NS);
+	duty_cycle = min(state->duty_cycle, period);
+
+	/*
+	 * Compute the on and off time. As the internal oscillator frequency is
+	 * 1MHz, the calculation can be simplified without loss of precision.
+	 */
+	on = div_u64(duty_cycle, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
+	off = div_u64(period, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on;
+
+	val = cpu_to_le16(off);
+	ret = regmap_bulk_write(regmap, ADP5585_PWM_OFFT_LOW, &val, 2);
+	if (ret)
+		return ret;
+
+	val = cpu_to_le16(on);
+	ret = regmap_bulk_write(regmap, ADP5585_PWM_ONT_LOW, &val, 2);
+	if (ret)
+		return ret;
+
+	/* Enable PWM in continuous mode and no external AND'ing. */
+	ret = regmap_update_bits(regmap, ADP5585_PWM_CFG,
+				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
+				 ADP5585_PWM_EN, ADP5585_PWM_EN);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
+}
+
+static int pwm_adp5585_get_state(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	unsigned int on, off;
+	unsigned int val;
+	__le16 on_off;
+	int ret;
+
+	ret = regmap_bulk_read(regmap, ADP5585_PWM_OFFT_LOW, &on_off, 2);
+	if (ret)
+		return ret;
+	off = le16_to_cpu(on_off);
+
+	ret = regmap_bulk_read(regmap, ADP5585_PWM_ONT_LOW, &on_off, 2);
+	if (ret)
+		return ret;
+	on = le16_to_cpu(on_off);
+
+	state->duty_cycle = on * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
+	state->period = (on + off) * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	regmap_read(regmap, ADP5585_PWM_CFG, &val);
+	state->enabled = !!(val & ADP5585_PWM_EN);
+
+	return 0;
+}
+
+static const struct pwm_ops adp5585_pwm_ops = {
+	.request = pwm_adp5585_request,
+	.free = pwm_adp5585_free,
+	.apply = pwm_adp5585_apply,
+	.get_state = pwm_adp5585_get_state,
+};
+
+static int adp5585_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, ADP5585_PWM_CHAN_NUM, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	device_set_of_node_from_dev(dev, dev->parent);
+
+	pwmchip_set_drvdata(chip, adp5585->regmap);
+	chip->ops = &adp5585_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct platform_device_id adp5585_pwm_id_table[] = {
+	{ "adp5585-pwm" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, adp5585_pwm_id_table);
+
+static struct platform_driver adp5585_pwm_driver = {
+	.driver	= {
+		.name = "adp5585-pwm",
+	},
+	.probe = adp5585_pwm_probe,
+	.id_table = adp5585_pwm_id_table,
+};
+module_platform_driver(adp5585_pwm_driver);
+
+MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
+MODULE_DESCRIPTION("ADP5585 PWM Driver");
+MODULE_LICENSE("GPL");
-- 
Regards,

Laurent Pinchart


