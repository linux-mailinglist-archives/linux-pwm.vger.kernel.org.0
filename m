Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3F2215DC9
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2020 19:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgGFR6U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jul 2020 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgGFR5e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 13:57:34 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A783C08C5DF;
        Mon,  6 Jul 2020 10:57:34 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BC91B22FE5;
        Mon,  6 Jul 2020 19:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594058252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqCWQaunJFcI+EjS6nwLb3VSi9/aiJlPB65+2R1urOY=;
        b=Ao8Py/NpfUjJhR+1xqoto0UpGaZQWULpRmXP2o7fOMw4fAccWLBUXgbtZ4UrbEYmu7ySYR
        D7IRkrcX3Pt4XEaR3wf+Q8eILd6Qxq4SElkxgAZIeMAIQJ/ANKwJF+K4qPrjCZpk8TNCv4
        d5K26CGOYKtm/NAQ4SCVtNk6/iVLZvc=
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
Subject: [PATCH v5 05/13] irqchip: add sl28cpld interrupt controller support
Date:   Mon,  6 Jul 2020 19:53:45 +0200
Message-Id: <20200706175353.16404-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706175353.16404-1-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for the interrupt controller inside the sl28 CPLD management
controller.

The interrupt controller can handle at most 8 interrupts and is really
simplistic and consists only of an interrupt mask and an interrupt
pending register.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v4:
 - update copyright year
 - don't use "int irq" instead of "unsigne int irq", because
   platform_get_irq() might return a negative error code. Found by "kernel
   test robot <lkp@intel.com>
 - remove comma in terminator line of the compatible strings list,
   suggested by Andy
 - use newer devm_regmap_add_irq_chip_fwnode()
 - don't use KBUID_MODNAME, suggested by Andy
 - remove the platform device table

Changes since v3:
 - see cover letter

 drivers/irqchip/Kconfig        |  8 +++
 drivers/irqchip/Makefile       |  1 +
 drivers/irqchip/irq-sl28cpld.c | 96 ++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/irqchip/irq-sl28cpld.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 216b3b8392b5..b23d23eed3a5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -246,6 +246,14 @@ config RENESAS_RZA1_IRQC
 	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
 	  to 8 external interrupts with configurable sense select.
 
+config SL28CPLD_INTC
+	bool "Kontron sl28cpld IRQ controller"
+	select MFD_SIMPLE_MFD_I2C
+	select REGMAP_IRQ
+	help
+	  Interrupt controller driver for the board management controller
+	  found on the Kontron sl28 CPLD.
+
 config ST_IRQCHIP
 	bool
 	select REGMAP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c45744a..39af7d89204d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
new file mode 100644
index 000000000000..0aa50d025ef6
--- /dev/null
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld interrupt controller driver
+ *
+ * Copyright 2020 Kontron Europe GmbH
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define INTC_IE 0x00
+#define INTC_IP 0x01
+
+static const struct regmap_irq sl28cpld_irqs[] = {
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
+struct sl28cpld_intc {
+	struct regmap *regmap;
+	struct regmap_irq_chip chip;
+	struct regmap_irq_chip_data *irq_data;
+};
+
+static int sl28cpld_intc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sl28cpld_intc *irqchip;
+	int irq;
+	u32 base;
+	int ret;
+
+	if (!dev->parent)
+		return -ENODEV;
+
+	irqchip = devm_kzalloc(dev, sizeof(*irqchip), GFP_KERNEL);
+	if (!irqchip)
+		return -ENOMEM;
+
+	irqchip->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!irqchip->regmap)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = device_property_read_u32(&pdev->dev, "reg", &base);
+	if (ret)
+		return -EINVAL;
+
+	irqchip->chip.name = "sl28cpld-intc";
+	irqchip->chip.irqs = sl28cpld_irqs;
+	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
+	irqchip->chip.num_regs = 1;
+	irqchip->chip.status_base = base + INTC_IP;
+	irqchip->chip.mask_base = base + INTC_IE;
+	irqchip->chip.mask_invert = true,
+	irqchip->chip.ack_base = base + INTC_IP;
+
+	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
+					       irqchip->regmap, irq,
+					       IRQF_SHARED | IRQF_ONESHOT, 0,
+					       &irqchip->chip,
+					       &irqchip->irq_data);
+}
+
+static const struct of_device_id sl28cpld_intc_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-intc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_intc_of_match);
+
+static struct platform_driver sl28cpld_intc_driver = {
+	.probe = sl28cpld_intc_probe,
+	.driver = {
+		.name = "sl28cpld-intc",
+		.of_match_table = sl28cpld_intc_of_match,
+	}
+};
+module_platform_driver(sl28cpld_intc_driver);
+
+MODULE_DESCRIPTION("sl28cpld Interrupt Controller Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

