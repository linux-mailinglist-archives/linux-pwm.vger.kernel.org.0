Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0529C1B6290
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2020 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgDWRrj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Apr 2020 13:47:39 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55937 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbgDWRqf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Apr 2020 13:46:35 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5A05223061;
        Thu, 23 Apr 2020 19:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587663991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUECqCfzEEvWPBtkoJEbwPzhLTHGLBes4B0V/gGklX0=;
        b=EipujZYj5ScXnw2cZ+rk7CWjbPAAeKpdwQZlFPm6TqmrkMoiL+F+EkKuz9dzZu7CQFoFOY
        TqRiKBe5+fTtxTg1IESNtfuPLOdAQ8mQJoWquY422CGCqGDmX3ZlqfM/bK2g+L+gvCKAl5
        bHJlx+DHdOW9EP0gmc5/ux8aUk+lJ3U=
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld management controller
Date:   Thu, 23 Apr 2020 19:45:32 +0200
Message-Id: <20200423174543.17161-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423174543.17161-1-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 5A05223061
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[1.003];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         MID_CONTAINS_FROM(1.00)[];
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

This patch adds core support for the board management controller found
on the SMARC-sAL28 board. It consists of the following functions:
 - watchdog
 - GPIO controller
 - PWM controller
 - fan sensor
 - interrupt controller

At the moment, this controller is used on the Kontron SMARC-sAL28 board.

Please note that the MFD driver is defined as bool in the Kconfig
because the next patch will add interrupt support.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mfd/Kconfig    |  19 +++++
 drivers/mfd/Makefile   |   2 +
 drivers/mfd/sl28cpld.c | 153 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/mfd/sl28cpld.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0a59249198d3..be0c8d93c526 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2060,5 +2060,24 @@ config SGI_MFD_IOC3
 	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
 	  then say Y. Otherwise say N.
 
+config MFD_SL28CPLD
+	bool "Kontron sl28 core driver"
+	depends on I2C=y
+	depends on OF
+	select REGMAP_I2C
+	select MFD_CORE
+	help
+	  This option enables support for the board management controller
+	  found on the Kontron sl28 CPLD. You have to select individual
+	  functions, such as watchdog, GPIO, etc, under the corresponding menus
+	  in order to enable them.
+
+	  Currently supported boards are:
+
+		Kontron SMARC-sAL28
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called sl28cpld.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f935d10cbf0f..9bc38863b9c7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -259,3 +259,5 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+
+obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
diff --git a/drivers/mfd/sl28cpld.c b/drivers/mfd/sl28cpld.c
new file mode 100644
index 000000000000..1e5860cc7ffc
--- /dev/null
+++ b/drivers/mfd/sl28cpld.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MFD core for the sl28cpld.
+ *
+ * Copyright 2019 Kontron Europe GmbH
+ */
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+#define SL28CPLD_VERSION	0x03
+#define SL28CPLD_WATCHDOG_BASE	0x04
+#define SL28CPLD_HWMON_FAN_BASE	0x0b
+#define SL28CPLD_PWM0_BASE	0x0c
+#define SL28CPLD_PWM1_BASE	0x0e
+#define SL28CPLD_GPIO0_BASE	0x10
+#define SL28CPLD_GPIO1_BASE	0x15
+#define SL28CPLD_GPO_BASE	0x1a
+#define SL28CPLD_GPI_BASE	0x1b
+#define SL28CPLD_INTC_BASE	0x1c
+
+/* all subdevices share the same IRQ */
+#define SL28CPLD_IRQ 0
+
+#define SL28CPLD_MIN_REQ_VERSION 14
+
+struct sl28cpld {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config sl28cpld_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_stride = 1,
+};
+
+static struct resource sl28cpld_watchdog_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_WATCHDOG_BASE, 1),
+};
+
+static struct resource sl28cpld_hwmon_fan_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_HWMON_FAN_BASE, 1),
+};
+
+static struct resource sl28cpld_pwm0_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_PWM0_BASE, 1),
+};
+
+static struct resource sl28cpld_pwm1_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_PWM1_BASE, 1),
+};
+
+static struct resource sl28cpld_gpio0_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_GPIO0_BASE, 1),
+	DEFINE_RES_IRQ(SL28CPLD_IRQ),
+};
+
+static struct resource sl28cpld_gpio1_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_GPIO1_BASE, 1),
+	DEFINE_RES_IRQ(SL28CPLD_IRQ),
+};
+
+static struct resource sl28cpld_gpo_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_GPO_BASE, 1),
+};
+
+static struct resource sl28cpld_gpi_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_GPI_BASE, 1),
+};
+
+static struct resource sl28cpld_intc_resources[] = {
+	DEFINE_RES_REG(SL28CPLD_INTC_BASE, 1),
+	DEFINE_RES_IRQ(SL28CPLD_IRQ),
+};
+
+static const struct mfd_cell sl28cpld_devs[] = {
+	OF_MFD_CELL_REG("sl28cpld-wdt", sl28cpld_watchdog_resources,
+			NULL, 0, 0, "kontron,sl28cpld-wdt", 0),
+	OF_MFD_CELL_REG("sl28cpld-fan", sl28cpld_hwmon_fan_resources,
+			NULL, 0, 0, "kontron,sl28cpld-fan", 1),
+	OF_MFD_CELL_REG("sl28cpld-pwm", sl28cpld_pwm0_resources,
+			NULL, 0, 0, "kontron,sl28cpld-pwm", 2),
+	OF_MFD_CELL_REG("sl28cpld-pwm", sl28cpld_pwm1_resources,
+			NULL, 0, 1, "kontron,sl28cpld-pwm", 3),
+	OF_MFD_CELL_REG("sl28cpld-gpio", sl28cpld_gpio0_resources,
+			NULL, 0, 0, "kontron,sl28cpld-gpio", 4),
+	OF_MFD_CELL_REG("sl28cpld-gpio", sl28cpld_gpio1_resources,
+			NULL, 0, 1, "kontron,sl28cpld-gpio", 5),
+	OF_MFD_CELL_REG("sl28cpld-gpo", sl28cpld_gpo_resources,
+			NULL, 0, 0, "kontron,sl28cpld-gpo", 6),
+	OF_MFD_CELL_REG("sl28cpld-gpi", sl28cpld_gpi_resources,
+			NULL, 0, 0, "kontron,sl28cpld-gpi", 7),
+	MFD_CELL_RES("sl28cpld-intc", sl28cpld_intc_resources),
+};
+
+static int sl28cpld_probe(struct i2c_client *i2c)
+{
+	struct sl28cpld *sl28cpld;
+	struct device *dev = &i2c->dev;
+	unsigned int cpld_version;
+	int ret;
+
+	sl28cpld = devm_kzalloc(dev, sizeof(*sl28cpld), GFP_KERNEL);
+	if (!sl28cpld)
+		return -ENOMEM;
+
+	sl28cpld->regmap = devm_regmap_init_i2c(i2c, &sl28cpld_regmap_config);
+	if (IS_ERR(sl28cpld->regmap))
+		return PTR_ERR(sl28cpld->regmap);
+
+	ret = regmap_read(sl28cpld->regmap, SL28CPLD_VERSION, &cpld_version);
+	if (ret)
+		return ret;
+
+	if (cpld_version < SL28CPLD_MIN_REQ_VERSION) {
+		dev_err(dev, "unsupported CPLD version %d\n", cpld_version);
+		return -ENODEV;
+	}
+
+	sl28cpld->dev = dev;
+	i2c_set_clientdata(i2c, sl28cpld);
+
+	dev_info(dev, "successfully probed. CPLD version %d\n", cpld_version);
+
+	return devm_mfd_add_devices(dev, -1, sl28cpld_devs,
+				    ARRAY_SIZE(sl28cpld_devs), NULL,
+				    i2c->irq, NULL);
+}
+
+static const struct of_device_id sl28cpld_of_match[] = {
+	{ .compatible = "kontron,sl28cpld", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_of_match);
+
+static struct i2c_driver sl28cpld_driver = {
+	.probe_new = sl28cpld_probe,
+	.driver = {
+		.name = "sl28cpld",
+		.of_match_table = of_match_ptr(sl28cpld_of_match),
+	},
+};
+module_i2c_driver(sl28cpld_driver);
+
+MODULE_DESCRIPTION("sl28cpld MFD Core Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

