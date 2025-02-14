Return-Path: <linux-pwm+bounces-4888-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B8A35CFC
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4B91892496
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF892641E6;
	Fri, 14 Feb 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XDSMCzMp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A497263C70;
	Fri, 14 Feb 2025 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533822; cv=none; b=iDPeYD90f4UbVYAHFXka4UbJQY6agvs9pCDkiohZ4pMsmixVLDakuotrJUJY+FZn3ynQ0jaAR9K2Lk1n+ZAU2V1Qag+m/fZSSUAUoVj0rJWTv2/hlFUEvLIUtimUTv2IeTGwmyXFlUU5ez77bkcn8/VTa/PLVhGDAqmz3f9a0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533822; c=relaxed/simple;
	bh=+/brog6yOneIHTXSivDBSeKcb0NPvBa2cb8E0wfddBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0G99XFV9CATV8tM6VdCjuVCKs+pL9bQGR7hu45U0pnfEXIldQg1CjADhyDhGHYy+azmGdjJC6VQ2ea6RyE2El7aXv5hsnFMe7LiFBWS08GMd5tRUd076GriCCybYQMtXmV2iam2pipzJwYB4CTcOKJ5uFNz7a2wYRjsOMDi5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XDSMCzMp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A81B5442A5;
	Fri, 14 Feb 2025 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLXKpMthXdWQSi9HXQKyQXRueDKRFXkR7s6n7DDIuo0=;
	b=XDSMCzMpBSGxa1eV6C71D/C+ObxWT/wy32StPjqjvXn6bj/rYU2pC65rIS+nCQmwVFIlx/
	hvvF7tFiFGXDvQ3ZdlM/L5cm/2KHICwNTSIqr+R6LoT0jTDYDjLMXDMtOSHWs2lLnYcvII
	J2n6XWiQYZ6qPXDIZztLsjdb87nT15qLzbPiWY+ZtJIWlS5bYq4Q8izLOuC3/s0yyA2raG
	7DmxyuukNzJ7saHXmZIoX/9C81CPDtoJfoj1aT+mLbRAU4ehbpxSiSABqjg9dzovfQYHTi
	EbjyrNen7hLhSBmTr6qUjMouU3phRtkrSYpGaBeav+kuV1rg/CROoGUPP3wMNQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Feb 2025 12:49:57 +0100
Subject: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
In-Reply-To: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
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
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=9950;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=+/brog6yOneIHTXSivDBSeKcb0NPvBa2cb8E0wfddBA=;
 b=zKH/h447CwCnmBp79KfhXvgX1gsrWsIlf7wB18ZbgkqHm0gkGcJ43G7j3Vaho3UpfCHvUPcc5
 AxPrMqyrYA1D4bICFIy/2UUZwCsKYKmnJZkhzOdyNal0o8P7r569/Mg
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrt
 ghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.

Two sets of GPIOs are provided by the device:
- Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
  These GPIOs also provide interrupts on input changes.
- Up to 6 GPOs, on unused keypad columns pins.

Co-developed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/gpio/Kconfig        |  11 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-max7360.c | 253 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 98b4d1633b25..3b3babc1c029 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1445,6 +1445,17 @@ config GPIO_MADERA
 	help
 	  Support for GPIOs on Cirrus Logic Madera class codecs.
 
+config GPIO_MAX7360
+	tristate "MAX7360 GPIO support"
+	depends on MFD_MAX7360
+	select GPIO_REGMAP
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
index af3ba4d81b58..581341b3e3e4 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_GPIO_MAX7300)		+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)		+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX730X)		+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX732X)		+= gpio-max732x.o
+obj-$(CONFIG_GPIO_MAX7360)		+= gpio-max7360.o
 obj-$(CONFIG_GPIO_MAX77620)		+= gpio-max77620.o
 obj-$(CONFIG_GPIO_MAX77650)		+= gpio-max77650.o
 obj-$(CONFIG_GPIO_MB86S7X)		+= gpio-mb86s7x.o
diff --git a/drivers/gpio/gpio-max7360.c b/drivers/gpio/gpio-max7360.c
new file mode 100644
index 000000000000..99ccda687b88
--- /dev/null
+++ b/drivers/gpio/gpio-max7360.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Bootlin
+ *
+ * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define MAX7360_GPIO_PORT	1
+#define MAX7360_GPIO_COL	2
+
+static int max7360_gpo_reg_mask_xlate(struct gpio_regmap *gpio,
+				      unsigned int base, unsigned int offset,
+				      unsigned int *reg, unsigned int *mask)
+{
+	u16 ngpios = gpio_regmap_get_ngpio(gpio);
+
+	*reg = base;
+	*mask = BIT(MAX7360_MAX_KEY_COLS - (ngpios - offset));
+
+	return 0;
+}
+
+static int max7360_gpio_request(struct gpio_chip *gc, unsigned int pin)
+{
+	/*
+	 * GPIOs on PORT pins are shared with the PWM and rotary encoder
+	 * drivers: they have to be requested from the MFD driver.
+	 */
+	return max7360_port_pin_request(gc->parent->parent, pin, true);
+}
+
+static void max7360_gpio_free(struct gpio_chip *gc, unsigned int pin)
+{
+	max7360_port_pin_request(gc->parent->parent, pin, false);
+}
+
+static int max7360_set_gpos_count(struct device *dev, struct regmap *regmap)
+{
+	/*
+	 * MAX7360 COL0 to COL7 pins can be used either as keypad columns,
+	 * general purpose output or a mix of both.
+	 */
+	unsigned int val;
+	u32 columns;
+	u32 ngpios;
+	int ret;
+
+	ret = device_property_read_u32(dev, "ngpios", &ngpios);
+	if (ret < 0) {
+		dev_err(dev, "Missing ngpios OF property\n");
+		return ret;
+	}
+
+	/*
+	 * Get the number of pins requested by the keypad and ensure our own pin
+	 * count is compatible with it.
+	 */
+	ret = device_property_read_u32(dev->parent, "keypad,num-columns", &columns);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read columns count\n");
+		return ret;
+	}
+
+	if (ngpios > MAX7360_MAX_GPO ||
+	    (ngpios + columns > MAX7360_MAX_KEY_COLS)) {
+		dev_err(dev, "Incompatible gpos and columns count (%u, %u)\n",
+			ngpios, columns);
+		return -EINVAL;
+	}
+
+	/*
+	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad debounce
+	 * timings and gpos/keypad columns repartition. Only the later is
+	 * modified here.
+	 */
+	val = FIELD_PREP(MAX7360_PORTS, ngpios);
+	ret = regmap_write_bits(regmap, MAX7360_REG_DEBOUNCE, MAX7360_PORTS, val);
+	if (ret) {
+		dev_err(dev, "Failed to write max7360 columns/gpos configuration");
+		return ret;
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
+	unsigned int val;
+
+	for (unsigned int i = 0; i < MAX7360_MAX_GPIO; ++i) {
+		val = (mask_buf & 1 << i) ? MAX7360_PORT_CFG_INTERRUPT_MASK : 0;
+		regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
+				  MAX7360_PORT_CFG_INTERRUPT_MASK, val);
+	}
+
+	return 0;
+}
+
+static int max7360_gpio_probe(struct platform_device *pdev)
+{
+	struct regmap_irq_chip *irq_chip;
+	struct regmap_irq_chip_data *irq_chip_data;
+	struct gpio_regmap_config gpio_config = { };
+	struct device *dev = &pdev->dev;
+	unsigned long gpio_function;
+	struct regmap *regmap;
+	unsigned int outconf;
+	unsigned long flags;
+	int irq;
+	int ret;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
+
+	gpio_function = (uintptr_t)device_get_match_data(dev);
+
+	if (gpio_function == MAX7360_GPIO_PORT &&
+	    (device_property_read_bool(dev, "interrupt-controller"))) {
+		/*
+		 * Port GPIOs with interrupt-controller property: add IRQ
+		 * controller.
+		 */
+		irq = fwnode_irq_get_byname(dev->parent->fwnode, "inti");
+		if (irq < 0)
+			return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+		irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
+		if (!irq_chip)
+			return -ENOMEM;
+
+		irq_chip->name = dev_name(dev);
+		irq_chip->status_base = MAX7360_REG_GPIOIN;
+		irq_chip->num_regs = 1;
+		irq_chip->num_irqs = MAX7360_MAX_GPIO;
+		irq_chip->irqs = max7360_regmap_irqs;
+		irq_chip->handle_mask_sync = max7360_handle_mask_sync;
+		irq_chip->status_is_level = true;
+		irq_chip->irq_drv_data = regmap;
+
+		for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
+			regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
+					  MAX7360_PORT_CFG_INTERRUPT_EDGES,
+					  MAX7360_PORT_CFG_INTERRUPT_EDGES);
+		}
+
+		flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
+		ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), regmap, irq, flags, 0,
+						      irq_chip, &irq_chip_data);
+		if (ret)
+			return dev_err_probe(dev, ret, "IRQ registration failed\n");
+
+		gpio_config.irq_domain = regmap_irq_get_domain(irq_chip_data);
+	}
+
+	if (gpio_function == MAX7360_GPIO_PORT) {
+		/*
+		 * Port GPIOs: set output mode configuration (constant-current or not).
+		 * This property is optional.
+		 */
+		outconf = 0;
+		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
+		if (ret && (ret != -EINVAL))
+			return dev_err_probe(dev, -ENODEV,
+					     "Failed to read maxim,constant-current-disable OF property\n");
+
+		regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
+	}
+
+	/* Add gpio device. */
+	gpio_config.parent = dev;
+	gpio_config.regmap = regmap;
+	if (gpio_function == MAX7360_GPIO_PORT) {
+		gpio_config.ngpio = MAX7360_MAX_GPIO;
+		gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOIN);
+		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PWMBASE);
+		gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(MAX7360_REG_GPIOCTRL);
+		gpio_config.ngpio_per_reg = MAX7360_MAX_GPIO;
+		gpio_config.request = max7360_gpio_request;
+		gpio_config.free = max7360_gpio_free;
+	} else {
+		u32 ngpios;
+
+		ret = device_property_read_u32(dev, "ngpios", &ngpios);
+		if (ret < 0) {
+			dev_err(dev, "Missing ngpios OF property\n");
+			return ret;
+		}
+
+		gpio_config.reg_set_base = GPIO_REGMAP_ADDR(MAX7360_REG_PORTS);
+		gpio_config.reg_mask_xlate = max7360_gpo_reg_mask_xlate;
+		gpio_config.ngpio = ngpios;
+
+		ret = max7360_set_gpos_count(dev, regmap);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to set GPOS pin count\n");
+	}
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+}
+
+static const struct of_device_id max7360_gpio_of_match[] = {
+	{
+		.compatible = "maxim,max7360-gpo",
+		.data = (void *)MAX7360_GPIO_COL
+	}, {
+		.compatible = "maxim,max7360-gpio",
+		.data = (void *)MAX7360_GPIO_PORT
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


