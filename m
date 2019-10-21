Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED451DE304
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 06:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfJUETS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 00:19:18 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:59412
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbfJUETR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 00:19:17 -0400
Received: from localhost.localdomain ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id MP2oifB4Hr3FgMP2xiDyZ4; Sun, 20 Oct 2019 21:11:59 -0700
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 4/8] hwmon: Add support for Azoteq IQS620AT temperature sensor
Date:   Sun, 20 Oct 2019 23:11:19 -0500
Message-Id: <1571631083-4962-5-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571631083-4962-1-git-send-email-jeff@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
X-CMAE-Envelope: MS4wfCTkk/bvHPNeSN2+Q+jpjtr2J/0Ob93zwQWi+DTPZgwKCpLlK69iByoBdRDSs5xHJnke3tH9pqvEGLI687VXIo7aSQUfMvNm/Xod0m0GRk2sndpDSbuJ
 cmnM8rLkjgczHq3LIsYZ92SBmpXxiOfPML+jfsHBqp+JYgjS01hJGpi8dus/a0T7UOupRPLaExTouw3YORAzu55EMbsfARZ61xDrai9LgbDSHPpvPMBNPDK1
 wMtjXSHOMVz+Xhq+HNMHtvjJ1O2v2oeLm9u6DxMCf5+sc8nWzLF5X/nsi9/GplypmlLWOcQPwPg4g9QuNNYLxHXPU8b2PzilQXpNOtzozS5uGh3gAychES72
 HYVMfe4TOnkhhWYFY0ciupauqA5ueoeJEBJ4C1ZlvvvCMadtCtJHVv0i9551dJc81m8CVudIk4M1DoBd/6eS6mTwkMTADV+FxxPwDQn9+NZo4kW1ZsrzF25Z
 wEocQGo+9cYQ5bJXWLXUlT5emrs1+Ox17/XC9az77LTUwlJdHNzDEFFkon065RTzQ7qJAIZTEnipXOntQ0Y047F2IjMo10RFJiqSkqHqDMv9IwKXLjfWtjVS
 L4hrzXQ0KqCF3CIj3f/j2Ur4vFdBDbShAqxB3IKSBnwyxL6ci5ATSCqisXCStaB7eLxX/ccaakrvuoJG0lL0GWROKBtrmseLMK1wXn6LgHupMf7JdB/EVJT8
 AaN7pvwfD0TH3Sgp2pwFavCoXh3X74t2NiJlfmPA5NSx8P8pKLYRfQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620AT temperature sensor,
capable of reporting its absolute die temperature.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/hwmon/Kconfig         | 12 +++++-
 drivers/hwmon/Makefile        |  1 +
 drivers/hwmon/iqs620at-temp.c | 96 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwmon/iqs620at-temp.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 13a6b4a..3e56be6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -385,6 +385,16 @@ config SENSORS_ATXP1
 	  This driver can also be built as a module. If so, the module
 	  will be called atxp1.
 
+config SENSORS_IQS620AT
+	tristate "Azoteq IQS620AT temperature sensor"
+	depends on MFD_IQS62X
+	help
+	  Say Y here if you want to build support for the Azoteq IQS620AT
+	  temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs620at-temp.
+
 config SENSORS_DS620
 	tristate "Dallas Semiconductor DS620"
 	depends on I2C
@@ -1593,7 +1603,7 @@ config SENSORS_ADS7871
 
 config SENSORS_AMC6821
 	tristate "Texas Instruments AMC6821"
-	depends on I2C 
+	depends on I2C
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  AMC6821 hardware monitoring chips.
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 40c036e..2360add 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
 obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
 obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
+obj-$(CONFIG_SENSORS_IQS620AT)	+= iqs620at-temp.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
diff --git a/drivers/hwmon/iqs620at-temp.c b/drivers/hwmon/iqs620at-temp.c
new file mode 100644
index 0000000..0af49b6
--- /dev/null
+++ b/drivers/hwmon/iqs620at-temp.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620AT Temperature Sensor
+ *
+ * Copyright (C) 2019
+ * Author: Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define IQS620_TEMP_UI_OUT			0x1A
+
+static umode_t iqs620_temp_is_visible(const void *drvdata,
+				      enum hwmon_sensor_types type,
+				      u32 attr, int channel)
+{
+	if (type != hwmon_temp || attr != hwmon_temp_input)
+		return 0;
+
+	return 0444;
+}
+
+static int iqs620_temp_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
+	int error;
+	__le16 val_buf;
+
+	if (type != hwmon_temp || attr != hwmon_temp_input)
+		return -EINVAL;
+
+	error = regmap_raw_read(iqs62x->map, IQS620_TEMP_UI_OUT, &val_buf,
+				sizeof(val_buf));
+	if (error)
+		return error;
+
+	*val = (le16_to_cpu(val_buf) - 100) * 1000;
+
+	return 0;
+}
+
+static const struct hwmon_ops iqs620_temp_ops = {
+	.is_visible = iqs620_temp_is_visible,
+	.read = iqs620_temp_read,
+};
+
+static const struct hwmon_channel_info *iqs620_temp_channel_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info iqs620_temp_chip_info = {
+	.ops = &iqs620_temp_ops,
+	.info = iqs620_temp_channel_info,
+};
+
+static int iqs620_temp_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct device *hdev;
+	int error = 0;
+
+	hdev = devm_hwmon_device_register_with_info(&pdev->dev,
+						    iqs62x->dev_desc->dev_name,
+						    iqs62x,
+						    &iqs620_temp_chip_info,
+						    NULL);
+	if (IS_ERR(hdev)) {
+		error = PTR_ERR(hdev);
+		dev_err(&pdev->dev, "Failed to register device: %d\n", error);
+	}
+
+	return error;
+}
+
+static struct platform_driver iqs620_temp_platform_driver = {
+	.driver = {
+		.name	= IQS620_DRV_NAME_TEMP,
+	},
+	.probe		= iqs620_temp_probe,
+};
+module_platform_driver(iqs620_temp_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620AT Temperature Sensor");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS620_DRV_NAME_TEMP);
-- 
2.7.4

