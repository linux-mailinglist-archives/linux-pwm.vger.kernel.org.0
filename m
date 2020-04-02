Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9419CB7E
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 22:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389469AbgDBUhx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 16:37:53 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38109 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbgDBUhV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 16:37:21 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D1AB423E29;
        Thu,  2 Apr 2020 22:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585859838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqVw31B9JUYNo3A0ggVmYlpsp1a1y3aV8KHog9j7Pgw=;
        b=EDZeMAbJjjUgmfB1BFidyQNbagS7DoixCpL8AvxNXMDBupz+BUgeqUYaBYmD9NmCvYexbZ
        vzqYmpkCn46nAcac3sLe5IfJ8cvw0i7lf1durr4eZPTHCXXwHjOZxWjWGrNQv2FH3sTAK3
        7mkjh5CWO+CY0guVZ9f6Cr3Ls7TPSWA=
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
Subject: [PATCH v2 12/16] hwmon: add support for the sl28cpld hardware monitoring controller
Date:   Thu,  2 Apr 2020 22:36:52 +0200
Message-Id: <20200402203656.27047-13-michael@walle.cc>
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
X-Rspamd-Queue-Id: D1AB423E29
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
         NEURAL_HAM(-0.00)[-0.157];
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

This adds support for the hardware monitoring controller of the sl28cpld
board management controller. This driver is part of a multi-function
device.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 Documentation/hwmon/sl28cpld.rst |  36 ++++++++
 drivers/hwmon/Kconfig            |  10 ++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/sl28cpld-hwmon.c   | 151 +++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 Documentation/hwmon/sl28cpld.rst
 create mode 100644 drivers/hwmon/sl28cpld-hwmon.c

diff --git a/Documentation/hwmon/sl28cpld.rst b/Documentation/hwmon/sl28cpld.rst
new file mode 100644
index 000000000000..7ed65f78250c
--- /dev/null
+++ b/Documentation/hwmon/sl28cpld.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver sl28cpld
+======================
+
+Supported chips:
+
+   * Kontron sl28cpld
+
+     Prefix: 'sl28cpld'
+
+     Datasheet: not available
+
+Authors: Michael Walle <michael@walle.cc>
+
+Description
+-----------
+
+The sl28cpld is a board management controller which also exposes a hardware
+monitoring controller. At the moment this controller supports a single fan
+supervisor. In the future there might be other flavours and additional
+hardware monitoring might be supported.
+
+The fan supervisor has a 7 bit counter register and a counter period of 1
+second. If the 7 bit counter overflows, the supervisor will automatically
+switch to x8 mode to support a wider input range at the loss of
+granularity.
+
+Sysfs entries
+-------------
+
+The following attributes are supported.
+
+======================= ========================================================
+fan1_input		Fan RPM. Assuming 2 pulses per revolution.
+======================= ========================================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 05a30832c6ba..c98716f78cfa 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1412,6 +1412,16 @@ config SENSORS_RASPBERRYPI_HWMON
 	  This driver can also be built as a module. If so, the module
 	  will be called raspberrypi-hwmon.
 
+config SENSORS_SL28CPLD
+	tristate "Kontron's SMARC-sAL28 hardware monitoring driver"
+	depends on MFD_SL28CPLD
+	help
+	  If you say yes here you get support for a fan connected to the
+	  input of the SMARC connector of Kontron's SMARC-sAL28 module.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sl28cpld-hwmon.
+
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b0b9c8e57176..dfb0f8cda2dd 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -155,6 +155,7 @@ obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
 obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
+obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
 obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
diff --git a/drivers/hwmon/sl28cpld-hwmon.c b/drivers/hwmon/sl28cpld-hwmon.c
new file mode 100644
index 000000000000..c79bdfed8332
--- /dev/null
+++ b/drivers/hwmon/sl28cpld-hwmon.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld hardware monitoring driver.
+ *
+ * Copyright 2019 Kontron Europe GmbH
+ */
+
+#include <linux/bitfield.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define FAN_INPUT		0x00
+#define   FAN_SCALE_X8		BIT(7)
+#define   FAN_VALUE_MASK	GENMASK(6, 0)
+
+struct sl28cpld_hwmon {
+	struct regmap *regmap;
+	u32 offset;
+};
+
+static umode_t sl28cpld_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type,
+					 u32 attr, int channel)
+{
+	return 0444;
+}
+
+static int sl28cpld_hwmon_read(struct device *dev,
+			       enum hwmon_sensor_types type, u32 attr,
+			       int channel, long *input)
+{
+	struct sl28cpld_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned int value;
+	int ret;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		ret = regmap_read(hwmon->regmap, hwmon->offset + FAN_INPUT,
+				  &value);
+		if (ret)
+			return ret;
+		/*
+		 * The register has a 7 bit value and 1 bit which indicates the
+		 * scale. If the MSB is set, then the lower 7 bit has to be
+		 * multiplied by 8, to get the correct reading.
+		 */
+		if (value & FAN_SCALE_X8)
+			value = FIELD_GET(FAN_VALUE_MASK, value) << 3;
+
+		/*
+		 * The counter period is 1000ms and the sysfs specification
+		 * says we should asssume 2 pulses per revolution.
+		 */
+		value *= 60 / 2;
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*input = value;
+	return 0;
+}
+
+static const u32 sl28cpld_hwmon_fan_config[] = {
+	HWMON_F_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info sl28cpld_hwmon_fan = {
+	.type = hwmon_fan,
+	.config = sl28cpld_hwmon_fan_config,
+};
+
+static const struct hwmon_channel_info *sl28cpld_hwmon_info[] = {
+	&sl28cpld_hwmon_fan,
+	NULL
+};
+
+static const struct hwmon_ops sl28cpld_hwmon_ops = {
+	.is_visible = sl28cpld_hwmon_is_visible,
+	.read = sl28cpld_hwmon_read,
+};
+
+static const struct hwmon_chip_info sl28cpld_hwmon_chip_info = {
+	.ops = &sl28cpld_hwmon_ops,
+	.info = sl28cpld_hwmon_info,
+};
+
+static int sl28cpld_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *hwmon_dev;
+	struct sl28cpld_hwmon *hwmon;
+	struct resource *res;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	hwmon->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!hwmon->regmap)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (!res)
+		return -EINVAL;
+	hwmon->offset = res->start;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+				"sl28cpld_hwmon", hwmon,
+				&sl28cpld_hwmon_chip_info, NULL);
+	if (IS_ERR(hwmon_dev)) {
+		dev_err(&pdev->dev, "failed to register as hwmon device");
+		return PTR_ERR(hwmon_dev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sl28cpld_hwmon_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-fan" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_hwmon_of_match);
+
+static const struct platform_device_id sl28cpld_hwmon_id_table[] = {
+	{ "sl28cpld-fan" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, sl28cpld_hwmon_id_table);
+
+static struct platform_driver sl28cpld_hwmon_driver = {
+	.probe = sl28cpld_hwmon_probe,
+	.id_table = sl28cpld_hwmon_id_table,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = sl28cpld_hwmon_of_match,
+	},
+};
+module_platform_driver(sl28cpld_hwmon_driver);
+
+MODULE_DESCRIPTION("sl28cpld Hardware Monitoring Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

