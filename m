Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD26B22DA96
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 01:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGYXTB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Jul 2020 19:19:01 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43885 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgGYXTA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Jul 2020 19:19:00 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CB21823E3A;
        Sun, 26 Jul 2020 01:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595719137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMQQPwPH6zBMKiAkGJns9PNN/bsW4dSvESSYPM21Euw=;
        b=E9ZkxZeD4hLfdzP0mF4PvBDAIprw13kqLPvIWlJ2I2jyDDmGLpe4wYdJSAoPy+g1VHh2GK
        04vLE2cKhuB3y6Jqusp2/TCxdWsu7URh4leGwAG51CUHs8K5j7YxOMIzLH0Zo8XrpasxHE
        cH/LHLAfvd2L5jBpIpNBAer/nRjfhkA=
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v6 01/13] mfd: add simple regmap based I2C driver
Date:   Sun, 26 Jul 2020 01:18:22 +0200
Message-Id: <20200725231834.25642-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200725231834.25642-1-michael@walle.cc>
References: <20200725231834.25642-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are I2C devices which contain several different functions but
doesn't require any special access functions. For these kind of drivers
an I2C regmap should be enough.

Create an I2C driver which creates an I2C regmap and enumerates its
children. If a device wants to use this as its MFD core driver, it has
to add an individual compatible string. It may provide its own regmap
configuration.

Subdevices can use dev_get_regmap() on the parent to get their regmap
instance.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v5:
 - removed "select MFD_CORE" in Kconfig
 - removed help text in Kconfig, we assume that the users of this
   driver will have a "select MFD_SIMPLE_MFD_I2C". Instead added
   a small description to the driver itself.
 - removed "struct simple_mfd_i2c_config" and use regmap_config
   directly
 - changed builtin_i2c_driver() to module_i2c_driver(), added
   MODULE_ boilerplate
 - cleaned up the included files

Changes since v4:
 - new patch. Lee, please bear with me. I didn't want to delay the
   new version (where a lot of remarks on the other patches were
   addressed) even more, just because we haven't figured out how
   to deal with the MFD part. So for now, I've included this one.

 drivers/mfd/Kconfig          |  5 ++++
 drivers/mfd/Makefile         |  1 +
 drivers/mfd/simple-mfd-i2c.c | 55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 drivers/mfd/simple-mfd-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df0837ab41..c08539c7a166 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1162,6 +1162,11 @@ config MFD_SI476X_CORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called si476x-core.
 
+config MFD_SIMPLE_MFD_I2C
+	tristate
+	depends on I2C
+	select REGMAP_I2C
+
 config MFD_SM501
 	tristate "Silicon Motion SM501"
 	depends on HAS_DMA
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a60e5f835283..78d24a3e7c9e 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,3 +264,4 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
new file mode 100644
index 000000000000..45090ddad104
--- /dev/null
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A very simple I2C MFD driver
+ *
+ * The driver enumerates its children and registers a common regmap. Use
+ * dev_get_regmap(pdev->dev.parent, NULL) in the child nodes to fetch that
+ * regmap instance.
+ *
+ * In the future this driver might be extended to support also other interfaces
+ * like SPI etc.
+ */
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config simple_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int simple_mfd_i2c_probe(struct i2c_client *i2c)
+{
+	const struct regmap_config *config;
+	struct regmap *regmap;
+
+	config = device_get_match_data(&i2c->dev);
+	if (!config)
+		config = &simple_regmap_config;
+
+	regmap = devm_regmap_init_i2c(i2c, config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return devm_of_platform_populate(&i2c->dev);
+}
+
+static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{}
+};
+MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
+
+static struct i2c_driver simple_mfd_i2c_driver = {
+	.probe_new = simple_mfd_i2c_probe,
+	.driver = {
+		.name = "simple-mfd-i2c",
+		.of_match_table = simple_mfd_i2c_of_match,
+	},
+};
+module_i2c_driver(simple_mfd_i2c_driver);
+
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_DESCRIPTION("Simple I2C MFD driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

