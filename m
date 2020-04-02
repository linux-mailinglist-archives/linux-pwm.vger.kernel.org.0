Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8419CB9A
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 22:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbgDBUiJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 16:38:09 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38109 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389514AbgDBUhR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 16:37:17 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D68BB23D22;
        Thu,  2 Apr 2020 22:37:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585859834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaWwf4uffcPQf7EE7ZV+X/pMrqzfzrhbi/7KT6avBwM=;
        b=DEo9GkYtkohYmY81gx80Vs3YUYRyjlNOuqMvKhlTN7/cE2u81Pz69GXeCWpxf//xwojjta
        GqOuObzxMCwDMiEK7YIo8nrBksweynrmUTENmWwL6Oeh7pBNP+vaXeZkboIv986Az2GpTn
        qB8yEqADJpCHkVny+AJnxX6ETwOHZZk=
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
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 07/16] irqchip: add sl28cpld interrupt controller support
Date:   Thu,  2 Apr 2020 22:36:47 +0200
Message-Id: <20200402203656.27047-8-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402203656.27047-1-michael@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: D68BB23D22
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.166];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the interrupt controller inside the sl28
CPLD management controller.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/irqchip/Kconfig        |  3 ++
 drivers/irqchip/Makefile       |  1 +
 drivers/irqchip/irq-sl28cpld.c | 97 ++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig            |  2 +
 4 files changed, 103 insertions(+)
 create mode 100644 drivers/irqchip/irq-sl28cpld.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a85aada04a64..234db932e7cf 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -246,6 +246,9 @@ config RENESAS_RZA1_IRQC
 	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
 	  to 8 external interrupts with configurable sense select.
 
+config SL28CPLD_INTC
+	bool
+
 config ST_IRQCHIP
 	bool
 	select REGMAP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 37bbe39bf909..e3c6b94f7b0a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
+obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
new file mode 100644
index 000000000000..88de71d32b09
--- /dev/null
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld interrupt controller driver.
+ *
+ * Copyright 2019 Kontron Europe GmbH
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
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
+	struct sl28cpld_intc *irqchip;
+	struct resource *res;
+	unsigned int irq;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
+	if (!irqchip)
+		return -ENOMEM;
+
+	irqchip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!irqchip->regmap)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (!res)
+		return -EINVAL;
+
+	irqchip->chip.name = "sl28cpld-intc";
+	irqchip->chip.irqs = sl28cpld_irqs;
+	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
+	irqchip->chip.num_regs = 1;
+	irqchip->chip.status_base = res->start + INTC_IP;
+	irqchip->chip.mask_base = res->start + INTC_IE;
+	irqchip->chip.mask_invert = true,
+	irqchip->chip.ack_base = res->start + INTC_IP;
+
+	ret = devm_regmap_add_irq_chip(&pdev->dev, irqchip->regmap, irq,
+				       IRQF_SHARED | IRQF_ONESHOT, 0,
+				       &irqchip->chip, &irqchip->irq_data);
+	if (ret)
+		return ret;
+	dev_info(&pdev->dev, "registered IRQ %d\n", irq);
+
+	return 0;
+}
+
+static const struct platform_device_id sl28cpld_intc_id_table[] = {
+	{ "sl28cpld-intc" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, sl28cpld_intc_id_table);
+
+static struct platform_driver sl28cpld_intc_driver = {
+	.probe	= sl28cpld_intc_probe,
+	.id_table = sl28cpld_intc_id_table,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	}
+};
+module_platform_driver(sl28cpld_intc_driver);
+
+MODULE_DESCRIPTION("sl28cpld Interrupt Controller Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7c6761161f7a..4f741d640705 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2064,6 +2064,8 @@ config MFD_SL28CPLD
 	depends on I2C=y
 	depends on OF
 	select REGMAP_I2C
+	select REGMAP_IRQ
+	select SL28CPLD_INTC
 	select MFD_CORE
 	help
 	  This option enables support for the board management controller
-- 
2.20.1

