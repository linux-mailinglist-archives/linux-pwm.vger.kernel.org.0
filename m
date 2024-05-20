Return-Path: <linux-pwm+bounces-2196-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05368CA30D
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD991C21188
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358D13A267;
	Mon, 20 May 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zl3xKYZ7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE836139D1D;
	Mon, 20 May 2024 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235201; cv=none; b=IqA0L6NicolH3VurXGGXVpxUi5CRJNS7L6TuLAUyThckvDZwXxZb2aU7awfzJn6uuTckZbfl7bttywqnlwwam+5d/Gu1ITzxYfu2XQTr504tNmCJ6e8hkfvekNGiMHHwH+cmYvlMZwGfP0QJsJdDeAMlVaM5XYkpecKAQXFEDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235201; c=relaxed/simple;
	bh=82jsgl19cMYoCxoET5IPGfygxkn3NkEukJF9ABMZrPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkvsV084LW4WMrebYWRQ2394HHccLVUr4QlD+6VUp6hpxRb9IEiUjFoL73nBPRvufpJNnb1wuYNDrqKi0c7fpHcfoVmQcQxo5ZaI2Dl25lO14NQfowk5yK1mX5KdJabjRu9wVhpOEKiBf2mb0mZtv6XlrE4+90MsWTFGzi9j7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Zl3xKYZ7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A363D49;
	Mon, 20 May 2024 21:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716235184;
	bh=82jsgl19cMYoCxoET5IPGfygxkn3NkEukJF9ABMZrPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zl3xKYZ7UdntKDMBpE3gCa8eVOczo5FVCpRMBTD97s80qyuOoVuJ4nwa0vfUONnFl
	 BikhoiW3qk2LlUghBwLrT7FIIBp2JzUopGWZUm9tc3Jpy/gIy1kGvBll16p7DD5R+h
	 M8WXiJ86ik+5LMYAa+0s4v2y2PFH/4b0bhkHXdCY=
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 4/5] gpio: adp5585: Add Analog Devices ADP5585 support
Date: Mon, 20 May 2024 22:59:40 +0300
Message-ID: <20240520195942.11582-5-laurent.pinchart@ideasonboard.com>
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

From: Haibo Chen <haibo.chen@nxp.com>

The ADP5585 is a 10/11 input/output port expander with a built in keypad
matrix decoder, programmable logic, reset generator, and PWM generator.
This driver supports the GPIO function using the platform device
registered by the core MFD driver.

The driver is derived from an initial implementation from NXP, available
in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
adp5585-gpio support") in their BSP kernel tree. It has been extensively
rewritten.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes compared to the NXP original version

- Add MAINTAINERS entry
- Add prefix to compatible string
- Switch to regmap
- White space fixes
- Use sizeof(*variable)
- Initialize variables at declaration time
- Use mutex scope guards
- Cleanup header includes
- Support R5 GPIO pin
- Reorder functions
- Add bias support
- Return real pin value from .get()
- Add debounce support
- Add drive mode support
- Destroy mutex on remove
- Update copyright
- Update license to GPL-2.0-only
---
 MAINTAINERS                 |   1 +
 drivers/gpio/Kconfig        |   7 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-adp5585.c | 232 ++++++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+)
 create mode 100644 drivers/gpio/gpio-adp5585.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7150f091b69b..5689fec270ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -503,6 +503,7 @@ L:	linux-gpio@vger.kernel.org
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
+F:	drivers/gpio/gpio-adp5585.c
 F:	drivers/mfd/adp5585.c
 F:	include/linux/mfd/adp5585.h
 
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b50d0b470849..79d004e31a47 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1206,6 +1206,13 @@ config GPIO_ADP5520
 	  This option enables support for on-chip GPIO found
 	  on Analog Devices ADP5520 PMICs.
 
+config GPIO_ADP5585
+	tristate "GPIO Support for ADP5585"
+	depends on MFD_ADP5585
+	help
+	  This option enables support for the GPIO function found in the Analog
+	  Devices ADP5585.
+
 config GPIO_ALTERA_A10SR
 	tristate "Altera Arria10 System Resource GPIO"
 	depends on MFD_ALTERA_A10SR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fdd28c58d890..b44b6bc3a74f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_GPIO_74X164)		+= gpio-74x164.o
 obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
 obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
+obj-$(CONFIG_GPIO_ADP5585)		+= gpio-adp5585.o
 obj-$(CONFIG_GPIO_AGGREGATOR)		+= gpio-aggregator.o
 obj-$(CONFIG_GPIO_ALTERA_A10SR)		+= gpio-altera-a10sr.o
 obj-$(CONFIG_GPIO_ALTERA)  		+= gpio-altera.o
diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
new file mode 100644
index 000000000000..30e538f8d1ac
--- /dev/null
+++ b/drivers/gpio/gpio-adp5585.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices ADP5585 GPIO driver
+ *
+ * Copyright 2022 NXP
+ * Copyright 2024 Ideas on Board Oy
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/mfd/adp5585.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define ADP5585_GPIO_MAX	11
+
+struct adp5585_gpio_dev {
+	struct gpio_chip gpio_chip;
+	struct regmap *regmap;
+	struct mutex lock;
+};
+
+static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned int off)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	unsigned int bank = ADP5585_BANK(off);
+	unsigned int bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	return regmap_update_bits(adp5585_gpio->regmap,
+				  ADP5585_GPIO_DIRECTION_A + bank,
+				  bit, 0);
+}
+
+static int adp5585_gpio_direction_output(struct gpio_chip *chip, unsigned int off, int val)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	unsigned int bank = ADP5585_BANK(off);
+	unsigned int bit = ADP5585_BIT(off);
+	int ret;
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	ret = regmap_update_bits(adp5585_gpio->regmap,
+				 ADP5585_GPO_DATA_OUT_A + bank, bit,
+				 val ? bit : 0);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(adp5585_gpio->regmap,
+				  ADP5585_GPIO_DIRECTION_A + bank,
+				  bit, bit);
+}
+
+static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	unsigned int bank = ADP5585_BANK(off);
+	unsigned int bit = ADP5585_BIT(off);
+	unsigned int val;
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	regmap_read(adp5585_gpio->regmap, ADP5585_GPI_STATUS_A + bank, &val);
+
+	return !!(val & bit);
+}
+
+static void adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off, int val)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	unsigned int bank = ADP5585_BANK(off);
+	unsigned int bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	regmap_update_bits(adp5585_gpio->regmap, ADP5585_GPO_DATA_OUT_A + bank,
+			   bit, val ? bit : 0);
+}
+
+static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
+				 unsigned int off, unsigned int bias)
+{
+	unsigned int bit, reg, mask, val;
+
+	/*
+	 * The bias configuration fields are 2 bits wide and laid down in
+	 * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4 bits
+	 * after R5.
+	 */
+	bit = off * 2 + (off > 5 ? 4 : 0);
+	reg = ADP5585_RPULL_CONFIG_A + bit / 8;
+	mask = ADP5585_Rx_PULL_CFG(bit % 8, ADP5585_Rx_PULL_CFG_MASK);
+	val = ADP5585_Rx_PULL_CFG(bit % 8, bias);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	return regmap_update_bits(adp5585_gpio->regmap, reg, mask, val);
+}
+
+static int adp5585_gpio_set_drive(struct adp5585_gpio_dev *adp5585_gpio,
+				  unsigned int off, enum pin_config_param drive)
+{
+	unsigned int bank = ADP5585_BANK(off);
+	unsigned int bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	return regmap_update_bits(adp5585_gpio->regmap,
+				  ADP5585_GPO_OUT_MODE_A + bank, bit,
+				  drive == PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
+}
+
+static int adp5585_gpio_set_debounce(struct adp5585_gpio_dev *adp5585_gpio,
+				     unsigned int off, unsigned int debounce)
+{
+	unsigned int bank = ADP5585_BANK(off);
+	unsigned int bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	return regmap_update_bits(adp5585_gpio->regmap,
+				  ADP5585_DEBOUNCE_DIS_A + bank, bit,
+				  debounce ? 0 : 1);
+}
+
+static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
+				   unsigned long config)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	enum pin_config_param param = pinconf_to_config_param(config);
+	u32 arg = pinconf_to_config_argument(config);
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		return adp5585_gpio_set_bias(adp5585_gpio, off,
+					     ADP5585_Rx_PULL_CFG_DISABLE);
+
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return adp5585_gpio_set_bias(adp5585_gpio, off, arg ?
+					     ADP5585_Rx_PULL_CFG_PD_300K :
+					     ADP5585_Rx_PULL_CFG_DISABLE);
+
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return adp5585_gpio_set_bias(adp5585_gpio, off, arg ?
+					     ADP5585_Rx_PULL_CFG_PU_300K :
+					     ADP5585_Rx_PULL_CFG_DISABLE);
+
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return adp5585_gpio_set_drive(adp5585_gpio, off, param);
+
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return adp5585_gpio_set_debounce(adp5585_gpio, off, arg);
+
+	default:
+		return -ENOTSUPP;
+	};
+}
+
+static int adp5585_gpio_probe(struct platform_device *pdev)
+{
+	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	struct adp5585_gpio_dev *adp5585_gpio;
+	struct device *dev = &pdev->dev;
+	struct gpio_chip *gc;
+	int ret;
+
+	adp5585_gpio = devm_kzalloc(&pdev->dev, sizeof(*adp5585_gpio), GFP_KERNEL);
+	if (!adp5585_gpio)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, adp5585_gpio);
+
+	adp5585_gpio->regmap = adp5585->regmap;
+
+	mutex_init(&adp5585_gpio->lock);
+
+	gc = &adp5585_gpio->gpio_chip;
+	gc->parent = dev;
+	gc->direction_input  = adp5585_gpio_direction_input;
+	gc->direction_output = adp5585_gpio_direction_output;
+	gc->get = adp5585_gpio_get_value;
+	gc->set = adp5585_gpio_set_value;
+	gc->set_config = adp5585_gpio_set_config;
+	gc->can_sleep = true;
+
+	gc->base = -1;
+	gc->ngpio = ADP5585_GPIO_MAX;
+	gc->label = pdev->name;
+	gc->owner = THIS_MODULE;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &adp5585_gpio->gpio_chip,
+				     adp5585_gpio);
+	if (ret) {
+		mutex_destroy(&adp5585_gpio->lock);
+		return dev_err_probe(&pdev->dev, ret, "failed to add GPIO chip\n");
+	}
+
+	return 0;
+}
+
+static void adp5585_gpio_remove(struct platform_device *pdev)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = platform_get_drvdata(pdev);
+
+	mutex_destroy(&adp5585_gpio->lock);
+}
+
+static const struct of_device_id adp5585_of_match[] = {
+	{ .compatible = "adi,adp5585-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, adp5585_of_match);
+
+static struct platform_driver adp5585_gpio_driver = {
+	.driver	= {
+		.name = "adp5585-gpio",
+		.of_match_table = adp5585_of_match,
+	},
+	.probe = adp5585_gpio_probe,
+	.remove_new = adp5585_gpio_remove,
+};
+module_platform_driver(adp5585_gpio_driver);
+
+MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
+MODULE_DESCRIPTION("GPIO ADP5585 Driver");
+MODULE_LICENSE("GPL");
-- 
Regards,

Laurent Pinchart


