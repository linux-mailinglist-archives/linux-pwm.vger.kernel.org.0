Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7181123A22E
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Aug 2020 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgHCJmm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Aug 2020 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHCJmk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Aug 2020 05:42:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888CC061756;
        Mon,  3 Aug 2020 02:42:37 -0700 (PDT)
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 74E0622FF5;
        Mon,  3 Aug 2020 11:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1596447753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s1L0ndOkiFqCMWeuxeG2p4Ect7vfNDUMgnZUyMV0Kk4=;
        b=DkxSBb4iXO73M+X+xqhkZZMH+k144Q/nQA/sz135DLFOdLLEsm2XA+QObaG375LAh+XD6C
        vHOTrF50rvxZuJVX9SN5DtAkj5tInju1pzkcc2CDt4wktLvsl3Axj44hXCPULNzuDDXxiB
        CO1JwGKjPkRt8pJOSLwrLMkFK0Shpyg=
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
Subject: [PATCH v7 01/13] mfd: add simple regmap based I2C driver
Date:   Mon,  3 Aug 2020 11:35:47 +0200
Message-Id: <20200803093559.12289-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803093559.12289-1-michael@walle.cc>
References: <20200803093559.12289-1-michael@walle.cc>
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
Changes since v6:
 - added SIMPLE_MFD_I2C help text
 - revised description in module header

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

 drivers/mfd/Kconfig          | 12 ++++++++
 drivers/mfd/Makefile         |  1 +
 drivers/mfd/simple-mfd-i2c.c | 56 ++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 drivers/mfd/simple-mfd-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df0837ab41..6e1a38944d28 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1162,6 +1162,18 @@ config MFD_SI476X_CORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called si476x-core.
 
+config MFD_SIMPLE_MFD_I2C
+	tristate
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver creates a single register map with the intention for it
+	  to be shared by all sub-devices.
+
+	  Once the register map has been successfully initialised, any
+	  sub-devices represented by child nodes in Device Tree will be
+	  subsequently registered.
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
index 000000000000..09b40ebfdf07
--- /dev/null
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Simple MFD - I2C
+ *
+ * This driver creates a single register map with the intention for it to be
+ * shared by all sub-devices.  Children can use their parent's device structure
+ * (dev.parent) in order reference it.
+ *
+ * Once the register map has been successfully initialised, any sub-devices
+ * represented by child nodes in Device Tree will be subsequently registered.
+ */
+
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
+MODULE_DESCRIPTION("Simple MFD - I2C driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

