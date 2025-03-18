Return-Path: <linux-pwm+bounces-5227-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C41A6799E
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A38A11F9
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E9213254;
	Tue, 18 Mar 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O0Mmy2G0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120C211A38;
	Tue, 18 Mar 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315219; cv=none; b=Wjk0rrh2kA5fggtP1+55tm6KNlWVnyUZjNHQT3m5gQJUyHivkx2Iryk+BcjwwkdKkBOp6jrcn+tlfr7/VsOieQYgk8PGy5GzCIFh0jz4UW/ybXqQNIWKgA1RwOOkMhtFU2TPYWMWs551jvIgUtbMJE9SUsTyMMo5YCZziYu2heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315219; c=relaxed/simple;
	bh=eUGhPzhgxF35yqlWjMNClaRU3sbQwSrdyBxYK3LPOec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoJ/7vU4KbAEWs4SAA6LMf7eotxfYthGoZ5iSx4zDCb4a4zr7YiqeiHT5vn0WvZSlDt1s1l5Y7XNFB9xzR0qO+9+TAcmS/42DHUbePwl9/7BLv0FOb+RNT31XA8IBq4KFyZHNnMxKNXKIVllSUJfRAHj7dJmg2f7fT+eiBBV+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O0Mmy2G0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94011442BA;
	Tue, 18 Mar 2025 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742315214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gR7Gx6QnAmTETgSqlw+Sw5PyJD+hfohNdfISAL5gtk=;
	b=O0Mmy2G012or+YWx/qEVfEsbhoJ4mO7S/lZv6J6r7WjYpBohmIfg4Zu2E7zzZIvKjOuu/q
	+yBQq2AUNy/16dcSkENOfl36FKG8TQkVQVpoOzH40nZ1DFX4L8ndfeHQ76WvpSuWEb9088
	IsKuSTwMz6FEjOLywjH3nz1OmvQ9wFTdO0P8ESo35e2OZMqjNPlAIbDr1jzSJYxoVnKyKs
	QX+66J0uvVylrMpEpfvEdEbzB25VddbH7il4vrkHtQnc6heNyuyo8e4xKqkhxWtqdMws/F
	EKzbKLXfIfxacFEOctQtxtN7+euOg8bQkZlMscV5UZ2q+LmtmWe7Gu7yFHPSvQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 18 Mar 2025 17:26:24 +0100
Subject: [PATCH v5 08/11] gpio: max7360: Add MAX7360 gpio support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mdb-max7360-support-v5-8-fb20baf97da0@bootlin.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
In-Reply-To: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742315204; l=9749;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=eUGhPzhgxF35yqlWjMNClaRU3sbQwSrdyBxYK3LPOec=;
 b=AlOcBgYYqztWAKx0TWInkDo6eiIZpDeD16flHC/EVNP800bH7/oCHI4w6kqVLRQN4MNicZVOx
 fzitN8JAUdzAXdXEynSgyS/ThTdVDVFKtIna7XOZUMFSuvmPki81HQc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlhesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhg
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
 drivers/gpio/Kconfig        |  12 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-max7360.c | 246 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 98b4d1633b25..4ff68ec6a990 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1445,6 +1445,18 @@ config GPIO_MADERA
 	help
 	  Support for GPIOs on Cirrus Logic Madera class codecs.
 
+config GPIO_MAX7360
+	tristate "MAX7360 GPIO support"
+	depends on MFD_MAX7360
+	select GPIO_REGMAP
+	select PINCTRL_MAX7360
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
index 000000000000..4acf0a9dbaba
--- /dev/null
+++ b/drivers/gpio/gpio-max7360.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
+ *
+ * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/bitmap.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define MAX7360_GPIO_PORT	1
+#define MAX7360_GPIO_COL	2
+
+static int max7360_get_available_gpos(struct device *dev, unsigned int *available_gpios)
+{
+	u32 columns;
+	int ret;
+
+	ret = device_property_read_u32(dev->parent, "keypad,num-columns", &columns);
+	if (ret < 0) {
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
+	bitmap_clear(valid_mask, 0, MAX7360_MAX_KEY_COLS - ngpios);
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
+	if (ret) {
+		dev_err(dev, "Failed to write max7360 columns/gpos configuration");
+		return ret;
+	}
+
+	return 0;
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
+		*mask = 0xFF;
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
+	unsigned int val;
+
+	for (unsigned int i = 0; i < MAX7360_MAX_GPIO; ++i) {
+		val = (mask_buf & BIT(i)) ? MAX7360_PORT_CFG_INTERRUPT_MASK : 0;
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
+	struct gpio_regmap_config gpio_config = { };
+	struct device *dev = &pdev->dev;
+	unsigned long gpio_function;
+	struct regmap *regmap;
+	unsigned int outconf;
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
+		gpio_config.regmap_irq_flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
+		gpio_config.regmap_irq_irqno = fwnode_irq_get_byname(dev_fwnode(dev->parent),
+								     "inti");
+		if (gpio_config.regmap_irq_irqno < 0)
+			return dev_err_probe(dev, gpio_config.regmap_irq_irqno,
+					     "Failed to get IRQ\n");
+
+		irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
+		gpio_config.regmap_irq_chip = irq_chip;
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
+			return dev_err_probe(dev, ret, "Failed to read %s device property\n",
+					     "maxim,constant-current-disable");
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


