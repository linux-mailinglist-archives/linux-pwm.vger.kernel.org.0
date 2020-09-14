Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE2526981A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Sep 2020 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINVpY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 17:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgINVoH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 17:44:07 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1284C06178B;
        Mon, 14 Sep 2020 14:44:06 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 839AD23E45;
        Mon, 14 Sep 2020 23:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600119845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQ5trF1OGQDCqg6cnv1KRNil3tF6UoLVK8scjDjPyCg=;
        b=ocpiEf7L6FNLKY4yyS7Rgfak/BquqJGfuPvuqRFuLsanz0tJ4Dm5nPK5GYR+jj5dkk+xyU
        /DU39LHm9/GcJK0E6/+MBKGSn/we8YFnZucRoRj8zpm/97ektMfV7KWr10FRlulJJUYSTX
        iLgUVNlkFmO0MBo/Zd1gIrWgQYQtpb4=
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
Subject: [PATCH v10 08/13] hwmon: add support for the sl28cpld hardware monitoring controller
Date:   Mon, 14 Sep 2020 23:43:36 +0200
Message-Id: <20200914214341.14268-9-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914214341.14268-1-michael@walle.cc>
References: <20200914214341.14268-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for the hardware monitoring controller of the sl28cpld board
management controller. This driver is part of a multi-function device.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes since v9:
 - none

Changes since v8:
 - none

Changes since v7:
 - added "depends on MFD_SL28CPLD || COMPILE_TEST"

Changes since v6:
 - none

Changes since v5:
 - none

Changes since v4:
 - update copyright year
 - remove #include <linux/of_device.h>, suggested by Andy.
 - use PTR_ERR_OR_ZERO(), suggested by Andy.
 - remove the platform device table
 - don't use KBUID_MODNAME

Changes since v3:
 - see cover letter

 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/sl28cpld.rst |  36 ++++++++
 drivers/hwmon/Kconfig            |  10 +++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/sl28cpld-hwmon.c   | 142 +++++++++++++++++++++++++++++++
 5 files changed, 190 insertions(+)
 create mode 100644 Documentation/hwmon/sl28cpld.rst
 create mode 100644 drivers/hwmon/sl28cpld-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index a926f1abaec3..e79986ea4ae5 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -155,6 +155,7 @@ Hardware Monitoring Kernel Drivers
    sht3x
    shtc1
    sis5595
+   sl28cpld
    smm665
    smsc47b397
    smsc47m192
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
index 8dc28b26916e..d98c0a6860d1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1479,6 +1479,16 @@ config SENSORS_RASPBERRYPI_HWMON
 	  This driver can also be built as a module. If so, the module
 	  will be called raspberrypi-hwmon.
 
+config SENSORS_SL28CPLD
+	tristate "Kontron sl28cpld hardware monitoring driver"
+	depends on MFD_SL28CPLD || COMPILE_TEST
+	help
+	  If you say yes here you get support for the fan supervisor of the
+	  sl28cpld board management controller.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sl28cpld-hwmon.
+
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index a8f4b35b136b..dee8511f9348 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -159,6 +159,7 @@ obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
 obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
+obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
 obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
diff --git a/drivers/hwmon/sl28cpld-hwmon.c b/drivers/hwmon/sl28cpld-hwmon.c
new file mode 100644
index 000000000000..e48f58ec5b9c
--- /dev/null
+++ b/drivers/hwmon/sl28cpld-hwmon.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld hardware monitoring driver
+ *
+ * Copyright 2020 Kontron Europe GmbH
+ */
+
+#include <linux/bitfield.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
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
+	struct sl28cpld_hwmon *hwmon;
+	struct device *hwmon_dev;
+	int ret;
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
+	ret = device_property_read_u32(&pdev->dev, "reg", &hwmon->offset);
+	if (ret)
+		return -EINVAL;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+				"sl28cpld_hwmon", hwmon,
+				&sl28cpld_hwmon_chip_info, NULL);
+	if (IS_ERR(hwmon_dev))
+		dev_err(&pdev->dev, "failed to register as hwmon device");
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct of_device_id sl28cpld_hwmon_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-fan" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_hwmon_of_match);
+
+static struct platform_driver sl28cpld_hwmon_driver = {
+	.probe = sl28cpld_hwmon_probe,
+	.driver = {
+		.name = "sl28cpld-fan",
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

