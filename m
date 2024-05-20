Return-Path: <linux-pwm+bounces-2195-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B48CA30B
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C851C21917
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9613A257;
	Mon, 20 May 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n6aDhvhl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6643139D1C;
	Mon, 20 May 2024 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235201; cv=none; b=HZ2GubaxFdCD3x08mRecILCHL/UwsgGBPY5YjnseECONFfcWmjABeUdjaHkjOM0t7FiJULIxqVleFIrycBxcBVWBb6TWsvKzN3LSZAOC6yOjzCojVAa0iKpiUJfSntz8ui5d1zKsu8R22sLDbNMBZhk2HusmbWCZM6HHLerkjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235201; c=relaxed/simple;
	bh=edOZnoLpGGwMfNSHAt6rfmjOeaPRifmFW19KtEa3l2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgqjLKDg3Oh33ME2sT8iGjToOvSONf4yQEBkr8nYtoHEbUmhT+iq67dfF4qLO1Kq1AHwWSQpkWaEizZXI721cQ7ZQrICA/exJw0lRi2l+uPW+V+C/bVFp9xKDmG4euB3GPzl9AtCZq65rD5kGXkodD86cWeymx0hOZAqcXPuA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=n6aDhvhl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E817DEBB;
	Mon, 20 May 2024 21:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716235186;
	bh=edOZnoLpGGwMfNSHAt6rfmjOeaPRifmFW19KtEa3l2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6aDhvhlmt7JYn0a9FIj6vD5A7zWGpFD4SWGYLOgRZj9a+Ov8L9ApCHogSNmFfiMq
	 ONF/X+4aUUOcUcx7h56g3kxcrJQX1CoopXWPub5wtHufsDGLZSmeF8caHKs1NbF0zM
	 0r5XAmfqfKlHd67EC8jL2ds0R4Yq93V5VkJWh44k=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 5/5] pwm: adp5585: Add Analog Devices ADP5585 support
Date: Mon, 20 May 2024 22:59:41 +0300
Message-ID: <20240520195942.11582-6-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
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
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
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
 drivers/pwm/pwm-adp5585.c | 230 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 drivers/pwm/pwm-adp5585.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5689fec270ef..280f97129598 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -505,6 +505,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
 F:	drivers/gpio/gpio-adp5585.c
 F:	drivers/mfd/adp5585.c
+F:	drivers/pwm/pwm-adp5585.c
 F:	include/linux/mfd/adp5585.h
 
 ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..2393a50b3781 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -51,6 +51,13 @@ config PWM_AB8500
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
index c5ec9e168ee7..100ac66b5f40 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
+obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
new file mode 100644
index 000000000000..709713d8f47a
--- /dev/null
+++ b/drivers/pwm/pwm-adp5585.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices ADP5585 PWM driver
+ *
+ * Copyright 2022 NXP
+ * Copyright 2024 Ideas on Board Oy
+ */
+
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/mfd/adp5585.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+
+#define ADP5585_PWM_CHAN_NUM		1
+
+#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
+#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
+#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
+
+struct adp5585_pwm_chip {
+	struct pwm_chip chip;
+	struct regmap *regmap;
+	struct mutex lock;
+	u8 pin_config_val;
+};
+
+static inline struct adp5585_pwm_chip *
+to_adp5585_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct adp5585_pwm_chip, chip);
+}
+
+static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&adp5585_pwm->lock);
+
+	ret = regmap_read(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C, &val);
+	if (ret)
+		return ret;
+
+	adp5585_pwm->pin_config_val = val;
+
+	ret = regmap_update_bits(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C,
+				 ADP5585_R3_EXTEND_CFG_MASK,
+				 ADP5585_R3_EXTEND_CFG_PWM_OUT);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
+				 ADP5585_OSC_EN, ADP5585_OSC_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+
+	guard(mutex)(&adp5585_pwm->lock);
+
+	regmap_update_bits(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C,
+			   ADP5585_R3_EXTEND_CFG_MASK,
+			   adp5585_pwm->pin_config_val);
+	regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
+			   ADP5585_OSC_EN, 0);
+}
+
+static int pwm_adp5585_apply(struct pwm_chip *chip,
+			     struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+	u32 on, off;
+	int ret;
+
+	if (!state->enabled) {
+		guard(mutex)(&adp5585_pwm->lock);
+
+		return regmap_update_bits(adp5585_pwm->regmap, ADP5585_PWM_CFG,
+					  ADP5585_PWM_EN, 0);
+	}
+
+	if (state->period < ADP5585_PWM_MIN_PERIOD_NS ||
+	    state->period > ADP5585_PWM_MAX_PERIOD_NS)
+		return -EINVAL;
+
+	/*
+	 * Compute the on and off time. As the internal oscillator frequency is
+	 * 1MHz, the calculation can be simplified without loss of precision.
+	 */
+	on = DIV_ROUND_CLOSEST_ULL(state->duty_cycle,
+				   NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
+	off = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
+				    NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		swap(on, off);
+
+	guard(mutex)(&adp5585_pwm->lock);
+
+	ret = regmap_write(adp5585_pwm->regmap, ADP5585_PWM_OFFT_LOW,
+			   off & 0xff);
+	if (ret)
+		return ret;
+	ret = regmap_write(adp5585_pwm->regmap, ADP5585_PWM_OFFT_HIGH,
+			   (off >> 8) & 0xff);
+	if (ret)
+		return ret;
+	ret = regmap_write(adp5585_pwm->regmap, ADP5585_PWM_ONT_LOW,
+			   on & 0xff);
+	if (ret)
+		return ret;
+	ret = regmap_write(adp5585_pwm->regmap, ADP5585_PWM_ONT_HIGH,
+			   (on >> 8) & 0xff);
+	if (ret)
+		return ret;
+
+	/* Enable PWM in continuous mode and no external AND'ing. */
+	ret = regmap_update_bits(adp5585_pwm->regmap, ADP5585_PWM_CFG,
+				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
+				 ADP5585_PWM_EN, ADP5585_PWM_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pwm_adp5585_get_state(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+	unsigned int on, off;
+	unsigned int val;
+
+	regmap_read(adp5585_pwm->regmap, ADP5585_PWM_OFFT_LOW, &off);
+	regmap_read(adp5585_pwm->regmap, ADP5585_PWM_OFFT_HIGH, &val);
+	off |= val << 8;
+
+	regmap_read(adp5585_pwm->regmap, ADP5585_PWM_ONT_LOW, &on);
+	regmap_read(adp5585_pwm->regmap, ADP5585_PWM_ONT_HIGH, &val);
+	on |= val << 8;
+
+	state->duty_cycle = on * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
+	state->period = (on + off) * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	regmap_read(adp5585_pwm->regmap, ADP5585_PWM_CFG, &val);
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
+	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	struct adp5585_pwm_chip *adp5585_pwm;
+	int ret;
+
+	adp5585_pwm = devm_kzalloc(&pdev->dev, sizeof(*adp5585_pwm), GFP_KERNEL);
+	if (!adp5585_pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, adp5585_pwm);
+
+	adp5585_pwm->regmap = adp5585->regmap;
+
+	mutex_init(&adp5585_pwm->lock);
+
+	adp5585_pwm->chip.dev = &pdev->dev;
+	adp5585_pwm->chip.ops = &adp5585_pwm_ops;
+	adp5585_pwm->chip.npwm = ADP5585_PWM_CHAN_NUM;
+
+	ret = devm_pwmchip_add(&pdev->dev, &adp5585_pwm->chip);
+	if (ret) {
+		mutex_destroy(&adp5585_pwm->lock);
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+	}
+
+	return 0;
+}
+
+static void adp5585_pwm_remove(struct platform_device *pdev)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = platform_get_drvdata(pdev);
+
+	mutex_destroy(&adp5585_pwm->lock);
+}
+
+static const struct of_device_id adp5585_pwm_of_match[] = {
+	{ .compatible = "adi,adp5585-pwm" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, adp5585_pwm_of_match);
+
+static struct platform_driver adp5585_pwm_driver = {
+	.driver	= {
+		.name = "adp5585-pwm",
+		.of_match_table = adp5585_pwm_of_match,
+	},
+	.probe = adp5585_pwm_probe,
+	.remove_new = adp5585_pwm_remove,
+};
+module_platform_driver(adp5585_pwm_driver);
+
+MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
+MODULE_DESCRIPTION("ADP5585 PWM Driver");
+MODULE_LICENSE("GPL");
-- 
Regards,

Laurent Pinchart


