Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF951EED16
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2020 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgFDVLw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Jun 2020 17:11:52 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:37193 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgFDVLZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Jun 2020 17:11:25 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EE2E222FE3;
        Thu,  4 Jun 2020 23:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591305082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thRMUD35mQ2CLp7g40OFx33tgegHp5PmiaEGuFoICU4=;
        b=nGLZ5abcsYGdDGICEhta44xmh0XdHbzE9ufB5L86JS8J0xdMYHDGt/w2zf+SASEq60oiJd
        Lv9YKcUjTzEWnpFiOYB0F1zFfxlViz261bZxf1PlfbQdHr35uylL0gFvk7bEU5EkbaSpVs
        QeHlzo0gCwVGV6PPdRpnZYd/Jzzefgw=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 06/11] gpio: add support for the sl28cpld GPIO controller
Date:   Thu,  4 Jun 2020 23:10:34 +0200
Message-Id: <20200604211039.12689-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604211039.12689-1-michael@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for the GPIO controller of the sl28 board management
controller. This driver is part of a multi-function device.

A controller has 8 lines. There are three different flavors:
full-featured GPIO with interrupt support, input-only and output-only.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/gpio/Kconfig         |  11 +++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-sl28cpld.c | 180 +++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/gpio/gpio-sl28cpld.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bcacd9c74aa8..a325d2d619a8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1215,6 +1215,17 @@ config GPIO_RC5T583
 	  This driver provides the support for driving/reading the gpio pins
 	  of RC5T583 device through standard gpio library.
 
+config GPIO_SL28CPLD
+	tristate "Kontron sl28 GPIO"
+	depends on MFD_SL28CPLD
+	select GPIO_REGMAP
+	select GPIOLIB_IRQCHIP
+	help
+	  This enables support for the GPIOs found on the Kontron sl28 CPLD.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio-sl28cpld.
+
 config GPIO_STMPE
 	bool "STMPE GPIOs"
 	depends on MFD_STMPE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1e4894e0bf0f..152127a9b339 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
 obj-$(CONFIG_GPIO_SCH)			+= gpio-sch.o
 obj-$(CONFIG_GPIO_SIFIVE)		+= gpio-sifive.o
 obj-$(CONFIG_GPIO_SIOX)			+= gpio-siox.o
+obj-$(CONFIG_GPIO_SL28CPLD)		+= gpio-sl28cpld.o
 obj-$(CONFIG_GPIO_SODAVILLE)		+= gpio-sodaville.o
 obj-$(CONFIG_GPIO_SPEAR_SPICS)		+= gpio-spear-spics.o
 obj-$(CONFIG_GPIO_SPRD)			+= gpio-sprd.o
diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
new file mode 100644
index 000000000000..800e218ee624
--- /dev/null
+++ b/drivers/gpio/gpio-sl28cpld.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld GPIO driver.
+ *
+ * Copyright 2019 Michael Walle <michael@walle.cc>
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/regmap.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* GPIO flavor */
+#define GPIO_REG_DIR	0x00
+#define GPIO_REG_OUT	0x01
+#define GPIO_REG_IN	0x02
+#define GPIO_REG_IE	0x03
+#define GPIO_REG_IP	0x04
+
+/* input-only flavor */
+#define GPI_REG_IN	0x00
+
+/* output-only flavor */
+#define GPO_REG_OUT	0x00
+
+enum sl28cpld_gpio_type {
+	SL28CPLD_GPIO = 1,
+	SL28CPLD_GPI,
+	SL28CPLD_GPO,
+};
+
+struct sl28cpld_gpio {
+	struct regmap_irq_chip irq_chip;
+	struct regmap_irq_chip_data *irq_data;
+};
+
+static const struct regmap_irq sl28cpld_gpio_irqs[] = {
+	REGMAP_IRQ_REG_LINE(0, 8),
+	REGMAP_IRQ_REG_LINE(1, 8),
+	REGMAP_IRQ_REG_LINE(2, 8),
+	REGMAP_IRQ_REG_LINE(3, 8),
+	REGMAP_IRQ_REG_LINE(4, 8),
+	REGMAP_IRQ_REG_LINE(5, 8),
+	REGMAP_IRQ_REG_LINE(6, 8),
+	REGMAP_IRQ_REG_LINE(7, 8),
+};
+
+static int sl28cpld_gpio_irq_init(struct device *dev,
+				  struct sl28cpld_gpio *gpio,
+				  struct regmap *regmap, unsigned int base,
+				  int irq)
+{
+	struct regmap_irq_chip *irq_chip = &gpio->irq_chip;
+
+	irq_chip->name = "sl28cpld-gpio-irq",
+	irq_chip->irqs = sl28cpld_gpio_irqs;
+	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
+	irq_chip->num_regs = 1;
+	irq_chip->status_base = base + GPIO_REG_IP;
+	irq_chip->mask_base = base + GPIO_REG_IE;
+	irq_chip->mask_invert = true,
+	irq_chip->ack_base = base + GPIO_REG_IP;
+
+	return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), regmap,
+					   irq, IRQF_SHARED | IRQF_ONESHOT, 0,
+					   irq_chip, &gpio->irq_data);
+}
+
+static int sl28cpld_gpio_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *dev_id;
+	struct gpio_regmap_config config = {0};
+	enum sl28cpld_gpio_type type;
+	struct sl28cpld_gpio *gpio;
+	bool irq_support = false;
+	struct regmap *regmap;
+	int irq, ret;
+	u32 base;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	dev_id = platform_get_device_id(pdev);
+	if (dev_id)
+		type = dev_id->driver_data;
+	else
+		type = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	if (!type)
+		return -ENODEV;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	ret = device_property_read_u32(&pdev->dev, "reg", &base);
+	if (ret)
+		return -EINVAL;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	config.regmap = regmap;
+	config.parent = &pdev->dev;
+	config.ngpio = 8;
+
+	switch (type) {
+	case SL28CPLD_GPIO:
+		config.reg_dat_base = base + GPIO_REG_IN;
+		config.reg_set_base = base + GPIO_REG_OUT;
+		/* reg_dir_out_base might be zero */
+		config.reg_dir_out_base = GPIO_REGMAP_ADDR(base +
+							   GPIO_REG_DIR);
+		irq_support = true;
+		break;
+	case SL28CPLD_GPO:
+		config.reg_set_base = base + GPO_REG_OUT;
+		break;
+	case SL28CPLD_GPI:
+		config.reg_dat_base = base + GPI_REG_IN;
+		break;
+	default:
+		dev_err(&pdev->dev, "unknown type %d\n", type);
+		return -ENODEV;
+	}
+
+	if (irq_support &&
+	    device_property_read_bool(&pdev->dev, "interrupt-controller")) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
+
+		ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
+					     base, irq);
+		if (ret)
+			return ret;
+
+		config.irq_domain = regmap_irq_get_domain(gpio->irq_data);
+	}
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
+}
+
+static const struct of_device_id sl28cpld_gpio_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-gpio",
+	  .data = (void *)SL28CPLD_GPIO },
+	{ .compatible = "kontron,sl28cpld-gpi",
+	  .data = (void *)SL28CPLD_GPI },
+	{ .compatible = "kontron,sl28cpld-gpo",
+	  .data = (void *)SL28CPLD_GPO },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_gpio_of_match);
+
+static const struct platform_device_id sl28cpld_gpio_id_table[] = {
+	{ "sl28cpld-gpio", SL28CPLD_GPIO },
+	{ "sl28cpld-gpi", SL28CPLD_GPI },
+	{ "sl28cpld-gpo", SL28CPLD_GPO },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, sl28cpld_gpio_id_table);
+
+static struct platform_driver sl28cpld_gpio_driver = {
+	.probe = sl28cpld_gpio_probe,
+	.id_table = sl28cpld_gpio_id_table,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = sl28cpld_gpio_of_match,
+	},
+};
+module_platform_driver(sl28cpld_gpio_driver);
+
+MODULE_DESCRIPTION("sl28cpld GPIO Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

