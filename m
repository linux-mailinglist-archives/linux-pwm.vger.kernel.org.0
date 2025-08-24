Return-Path: <linux-pwm+bounces-7158-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20201B32FD0
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 14:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E4D17E835
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F192D8395;
	Sun, 24 Aug 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1N+aeJxl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A32D8371;
	Sun, 24 Aug 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036703; cv=none; b=pbMXNWkyrTknlTI+Zp+2kHlIOldM016V2G26rCF+Qa2bBhaE72fgha1Pq5+IJXxHPW05GceMfBnJNGZe4QtHo19wpTGKBPTicRtjuqKjFL/8P5sDN/v0VifPS82j2EBTauNmNx8Shj9YXub/F4cG/BdKVJx7aSFOq6s0ba7Hh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036703; c=relaxed/simple;
	bh=2v4Dgbe6hq+wdSRIXvh5BuUWXcpjkNg18oOGqSvkItU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvEOuap/2+krupbD+9Y/doAMQ+/cfwfCVN6vSGvkbSWX4c8YBKhz/Fhda/qGWeZm2PZuCD/cEANvwGnqTiKB50/YtG45wpjREhnR4qtnAIe/wcNl5pUN3G3Ww8rPoKSCyDyuUTw+w4IsKM+21VvaibP5SaHCquMqPpTESnP0uVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1N+aeJxl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 12D48C8F1D2;
	Sun, 24 Aug 2025 11:58:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16A16605F1;
	Sun, 24 Aug 2025 11:58:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDAEF1C22D349;
	Sun, 24 Aug 2025 13:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756036698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sBm9TiZCsfioYpI77cRnJDLH/bNDXhwaEMybBYCr/vQ=;
	b=1N+aeJxlooX46AR2GpK2M+qiM3L8PUr2y+Mf+YifQ6X486LkCQcSmzXmRgmLOMJ5oR4/Y8
	dhbsvUJfih+hyscaD/upZDXGdznDRkEqaEgeC9bd+UuAluSlcU+aJAr2SfAT6BKOIhzTp4
	D7n3anKb5DsVS9xqoP403uAWq8JQh3cyI0a8Y28ZO7TibiAemNdMx2mL4eyF6U0Z652tds
	oJbECmMXUSdqaO5HMOxeRK+v4PUvoxm7IKpkouSwflSZ/QHB3NrbiEAV4Zc9J8b68nNrOT
	vVedABKFjNHiNRRuh/NMVTFkTzvj9QSW3WZy+wEUO11mcDDMgVM/FoXShfxA1A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 24 Aug 2025 13:57:26 +0200
Subject: [PATCH v14 07/10] gpio: max7360: Add MAX7360 gpio support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-mdb-max7360-support-v14-7-435cfda2b1ea@bootlin.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756036647; l=10280;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=2v4Dgbe6hq+wdSRIXvh5BuUWXcpjkNg18oOGqSvkItU=;
 b=ULsnBYrcN+FZgVsg2c4rDGW5bnX8/2Ag8dH+5suGyuKW8X19WnF69ouwZd6qTD8cw06RoNZE/
 8DL7w2ADEVeB3Ygl5+qgSED+ddT0CIUFg9ox0QTmnWxRfPNdamjawSj
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.

Two sets of GPIOs are provided by the device:
- Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
  These GPIOs also provide interrupts on input changes.
- Up to 6 GPOs, on unused keypad columns pins.

Co-developed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/gpio/Kconfig        |  12 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-max7360.c | 257 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e43abb322fa6..6cf57a18dbe7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1492,6 +1492,18 @@ config GPIO_MADERA
 	help
 	  Support for GPIOs on Cirrus Logic Madera class codecs.
 
+config GPIO_MAX7360
+	tristate "MAX7360 GPIO support"
+	depends on MFD_MAX7360
+	select GPIO_REGMAP
+	select REGMAP_IRQ
+	help
+	  Allows to use MAX7360 I/O Expander PWM lines as GPIO and keypad COL
+	  lines as GPO.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio-max7360.
+
 config GPIO_MAX77620
 	tristate "GPIO support for PMIC MAX77620 and MAX20024"
 	depends on MFD_MAX77620
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 379f55e9ed1e..52abba3ef81c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_GPIO_MAX7300)		+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)		+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX730X)		+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX732X)		+= gpio-max732x.o
+obj-$(CONFIG_GPIO_MAX7360)		+= gpio-max7360.o
 obj-$(CONFIG_GPIO_MAX77620)		+= gpio-max77620.o
 obj-$(CONFIG_GPIO_MAX77650)		+= gpio-max77650.o
 obj-$(CONFIG_GPIO_MAX77759)		+= gpio-max77759.o
diff --git a/drivers/gpio/gpio-max7360.c b/drivers/gpio/gpio-max7360.c
new file mode 100644
index 000000000000..db92a43776a9
--- /dev/null
+++ b/drivers/gpio/gpio-max7360.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
+ *
+ * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define MAX7360_GPIO_PORT	1
+#define MAX7360_GPIO_COL	2
+
+struct max7360_gpio_plat_data {
+	unsigned int function;
+};
+
+static struct max7360_gpio_plat_data max7360_gpio_port_plat = { .function = MAX7360_GPIO_PORT };
+static struct max7360_gpio_plat_data max7360_gpio_col_plat = { .function = MAX7360_GPIO_COL };
+
+static int max7360_get_available_gpos(struct device *dev, unsigned int *available_gpios)
+{
+	u32 columns;
+	int ret;
+
+	ret = device_property_read_u32(dev->parent, "keypad,num-columns", &columns);
+	if (ret) {
+		dev_err(dev, "Failed to read columns count\n");
+		return ret;
+	}
+
+	*available_gpios = min(MAX7360_MAX_GPO, MAX7360_MAX_KEY_COLS - columns);
+
+	return 0;
+}
+
+static int max7360_gpo_init_valid_mask(struct gpio_chip *gc,
+				       unsigned long *valid_mask,
+				       unsigned int ngpios)
+{
+	unsigned int available_gpios;
+	int ret;
+
+	ret = max7360_get_available_gpos(gc->parent, &available_gpios);
+	if (ret)
+		return ret;
+
+	bitmap_clear(valid_mask, 0, MAX7360_MAX_KEY_COLS - available_gpios);
+
+	return 0;
+}
+
+static int max7360_set_gpos_count(struct device *dev, struct regmap *regmap)
+{
+	/*
+	 * MAX7360 COL0 to COL7 pins can be used either as keypad columns,
+	 * general purpose output or a mix of both.
+	 * By default, all pins are used as keypad, here we update this
+	 * configuration to allow to use some of them as GPIOs.
+	 */
+	unsigned int available_gpios;
+	unsigned int val;
+	int ret;
+
+	ret = max7360_get_available_gpos(dev, &available_gpios);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure which GPIOs will be used for keypad.
+	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad debounce
+	 * timings and gpos/keypad columns repartition. Only the later is
+	 * modified here.
+	 */
+	val = FIELD_PREP(MAX7360_PORTS, available_gpios);
+	ret = regmap_write_bits(regmap, MAX7360_REG_DEBOUNCE, MAX7360_PORTS, val);
+	if (ret)
+		dev_err(dev, "Failed to write max7360 columns/gpos configuration");
+
+	return ret;
+}
+
+static int max7360_gpio_reg_mask_xlate(struct gpio_regmap *gpio,
+				       unsigned int base, unsigned int offset,
+				       unsigned int *reg, unsigned int *mask)
+{
+	if (base == MAX7360_REG_PWMBASE) {
+		/*
+		 * GPIO output is using PWM duty cycle registers: one register
+		 * per line, with value being either 0 or 255.
+		 */
+		*reg = base + offset;
+		*mask = GENMASK(7, 0);
+	} else {
+		*reg = base;
+		*mask = BIT(offset);
+	}
+
+	return 0;
+}
+
+static const struct regmap_irq max7360_regmap_irqs[MAX7360_MAX_GPIO] = {
+	REGMAP_IRQ_REG(0, 0, BIT(0)),
+	REGMAP_IRQ_REG(1, 0, BIT(1)),
+	REGMAP_IRQ_REG(2, 0, BIT(2)),
+	REGMAP_IRQ_REG(3, 0, BIT(3)),
+	REGMAP_IRQ_REG(4, 0, BIT(4)),
+	REGMAP_IRQ_REG(5, 0, BIT(5)),
+	REGMAP_IRQ_REG(6, 0, BIT(6)),
+	REGMAP_IRQ_REG(7, 0, BIT(7)),
+};
+
+static int max7360_handle_mask_sync(const int index,
+				    const unsigned int mask_buf_def,
+				    const unsigned int mask_buf,
+				    void *const irq_drv_data)
+{
+	struct regmap *regmap = irq_drv_data;
+	int ret;
+
+	for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
+		ret = regmap_assign_bits(regmap, MAX7360_REG_PWMCFG(i),
+					 MAX7360_PORT_CFG_INTERRUPT_MASK, mask_buf & BIT(i));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int max7360_gpio_probe(struct platform_device *pdev)
+{
+	const struct max7360_gpio_plat_data *plat_data;
+	struct gpio_regmap_config gpio_config = { };
+	struct regmap_irq_chip *irq_chip;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	unsigned int outconf;
+	int ret;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
+
+	plat_data = device_get_match_data(dev);
+	if (plat_data->function == MAX7360_GPIO_PORT) {
+		if (device_property_read_bool(dev, "interrupt-controller")) {
+			/*
+			 * Port GPIOs with interrupt-controller property: add IRQ
+			 * controller.
+			 */
+			gpio_config.regmap_irq_flags = IRQF_ONESHOT | IRQF_SHARED;
+			gpio_config.regmap_irq_line =
+				fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");
+			if (gpio_config.regmap_irq_line < 0)
+				return dev_err_probe(dev, gpio_config.regmap_irq_line,
+						     "Failed to get IRQ\n");
+
+			/* Create custom IRQ configuration. */
+			irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
+			gpio_config.regmap_irq_chip = irq_chip;
+			if (!irq_chip)
+				return -ENOMEM;
+
+			irq_chip->name = dev_name(dev);
+			irq_chip->status_base = MAX7360_REG_GPIOIN;
+			irq_chip->status_is_level = true;
+			irq_chip->num_regs = 1;
+			irq_chip->num_irqs = MAX7360_MAX_GPIO;
+			irq_chip->irqs = max7360_regmap_irqs;
+			irq_chip->handle_mask_sync = max7360_handle_mask_sync;
+			irq_chip->irq_drv_data = regmap;
+
+			for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
+				ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
+							MAX7360_PORT_CFG_INTERRUPT_EDGES,
+							MAX7360_PORT_CFG_INTERRUPT_EDGES);
+				if (ret)
+					return dev_err_probe(dev, ret,
+							     "Failed to enable interrupts\n");
+			}
+		}
+
+		/*
+		 * Port GPIOs: set output mode configuration (constant-current or not).
+		 * This property is optional.
+		 */
+		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
+		if (!ret) {
+			ret = regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to set constant-current configuration\n");
+		}
+	}
+
+	/* Add gpio device. */
+	gpio_config.parent = dev;
+	gpio_config.regmap = regmap;
+	if (plat_data->function == MAX7360_GPIO_PORT) {
+		gpio_config.ngpio = MAX7360_MAX_GPIO;
+		gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOIN);
+		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PWMBASE);
+		gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOCTRL);
+		gpio_config.ngpio_per_reg = MAX7360_MAX_GPIO;
+		gpio_config.reg_mask_xlate = max7360_gpio_reg_mask_xlate;
+	} else {
+		ret = max7360_set_gpos_count(dev, regmap);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to set GPOS pin count\n");
+
+		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PORTS);
+		gpio_config.ngpio = MAX7360_MAX_KEY_COLS;
+		gpio_config.init_valid_mask = max7360_gpo_init_valid_mask;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+}
+
+static const struct of_device_id max7360_gpio_of_match[] = {
+	{
+		.compatible = "maxim,max7360-gpo",
+		.data = &max7360_gpio_col_plat
+	}, {
+		.compatible = "maxim,max7360-gpio",
+		.data = &max7360_gpio_port_plat
+	}, {
+	}
+};
+MODULE_DEVICE_TABLE(of, max7360_gpio_of_match);
+
+static struct platform_driver max7360_gpio_driver = {
+	.driver = {
+		.name	= "max7360-gpio",
+		.of_match_table = max7360_gpio_of_match,
+	},
+	.probe		= max7360_gpio_probe,
+};
+module_platform_driver(max7360_gpio_driver);
+
+MODULE_DESCRIPTION("MAX7360 GPIO driver");
+MODULE_AUTHOR("Kamel BOUHARA <kamel.bouhara@bootlin.com>");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5


