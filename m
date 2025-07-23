Return-Path: <linux-pwm+bounces-6874-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC42B0F95F
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jul 2025 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB5A3BC59C
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jul 2025 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727C6228C9D;
	Wed, 23 Jul 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw975G9v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CA2222A7;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292107; cv=none; b=VZGTwq4L/O9y2qfjn18bmHp7KMhu3OjV7WODe9rrRvMAC7/Ay7sKMMplIByP7n8sfdM+ZONX0yotXVjWNFZwZ+82BvrA1QfYEtvyCfxPzO7YPCvchITolig6v+MYXgCdleQBoDRcD1UnsxSEnr8u2YzGy31ivfCILhET9saxB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292107; c=relaxed/simple;
	bh=hBmYcaNHoIqZydKfbh8wgcy7HWw8qwr/hO73PbZOsWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TuHf2xJNJTqpYCJofuwA0k4rdMNlQmavBWbya4Xw/P7rzFsZK3AM0fY/2Qx0LuEjMFiZEE3w3hxbc8U2tzQ8i+TWW0QUJnfFEuPsMIRCRFDJyyGqiz2yjry0ymTR1BxQA7xH4cXn7lVu66kYShvkjQahmvG0oIq9NHv+DMB8IuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw975G9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF057C4CEF1;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753292106;
	bh=hBmYcaNHoIqZydKfbh8wgcy7HWw8qwr/hO73PbZOsWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Iw975G9vP3k4kKCoH2XJDvsdqQM5ltnpznHImCa2KflV/9Stdmcrz675XAjXqBRPg
	 PE6ORU2bGRr6pXBS/mVUd/wbx8yfIwTOzro7gJmlSRPxjeJRdgDeT3fdvYJrkf1yu+
	 5c82MJ4WMCfuRNDTRPRZkrIr1Fom/v2IcqNqS5YRG/tzQeuFDSiSeDISiQ/Ga8NiaS
	 GbdkP/9NHff1B5jgj+zdNG1dJRKBbpIMLQ/vkfxjtGPVfBWLlpDPRL4X08tLDPGulv
	 qA7dEwvP7NoBYMnf+MTbv2+JBH+W/eD3e9mDWMHUc9+nSKh4+gIWvvwrHFMkBPSgde
	 MFA5loM+tEWZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CADBC87FC5;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 23 Jul 2025 19:34:57 +0200
Subject: [PATCH v5 2/2] hwmon: add support for MC33XS2410 hardware
 monitoring
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-mc33xs2410-hwmon-v5-2-f62aab71cd59@liebherr.com>
References: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
In-Reply-To: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753292105; l=8847;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=YCCOttXZ9iOZy8OoouzxY5slMvI1RSmNaE/50XP8LQ8=;
 b=q2Q9U7owpZSCdSikq27SLgh4CUvrElB2yDXwFneDlqJUgIi8lt8r6Po+B6eTs3724EZE2U4H+
 hcHPAQZ8FiQBLV2lNat1ufVeWGcO++gm6E9Qv49ENBdWSbu2s0RTIeE
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The device is able to monitor temperature, voltage and current of each of
the four outputs. Add basic support for monitoring the temperature of the
four outputs and the die temperature.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/hwmon/index.rst            |   1 +
 Documentation/hwmon/mc33xs2410_hwmon.rst |  34 ++++++
 drivers/hwmon/Kconfig                    |  10 ++
 drivers/hwmon/Makefile                   |   1 +
 drivers/hwmon/mc33xs2410_hwmon.c         | 178 +++++++++++++++++++++++++++++++
 5 files changed, 224 insertions(+)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index b45bfb4ebf30823094fe82726d2237f90be17642..d292a86ac5da902cad02c1965c90f5de530489df 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -167,6 +167,7 @@ Hardware Monitoring Kernel Drivers
    max77705
    max8688
    mc13783-adc
+   mc33xs2410_hwmon
    mc34vr500
    mcp3021
    menf21bmc
diff --git a/Documentation/hwmon/mc33xs2410_hwmon.rst b/Documentation/hwmon/mc33xs2410_hwmon.rst
new file mode 100644
index 0000000000000000000000000000000000000000..8a2136ef913911851874179620815f4e74e6e5e9
--- /dev/null
+++ b/Documentation/hwmon/mc33xs2410_hwmon.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mc33xs2410_hwmon
+==============================
+
+Supported devices:
+
+  * NXPs MC33XS2410
+
+    Datasheet: https://www.nxp.com/docs/en/data-sheet/MC33XS2410.pdf
+
+Authors:
+
+	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+
+Description
+-----------
+
+The MC33XS2410 is a four channel self-protected high-side switch featuring
+hardware monitoring functions such as temperature, current and voltages for each
+of the four channels.
+
+Sysfs entries
+-------------
+
+======================= ======================================================
+temp1_label		"Central die temperature"
+temp1_input		Measured temperature of central die
+
+temp[2-5]_label		"Channel [1-4] temperature"
+temp[2-5]_input		Measured temperature of a single channel
+temp[2-5]_alarm		Temperature alarm
+temp[2-5]_max		Maximal temperature
+======================= ======================================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 079620dd42862ef5e026697e9e1b1fcd5b8be298..9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -700,6 +700,16 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 and MC13892 PMIC.
 
+config SENSORS_MC33XS2410
+	tristate "MC33XS2410 HWMON support"
+	depends on PWM_MC33XS2410
+	help
+	  If you say yes here you get hardware monitoring support for
+	  MC33XS2410.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called mc33xs2410_hwmon.
+
 config SENSORS_FSCHMD
 	tristate "Fujitsu Siemens Computers sensor chips"
 	depends on (X86 || COMPILE_TEST) && I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 48e5866c0c9a7677089d1001a9c5ae4adebff5d5..cd8bc4752b4dbf015c6eb46157626f4e8f87dfae 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -165,6 +165,7 @@ obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
 obj-$(CONFIG_MAX31827) += max31827.o
 obj-$(CONFIG_SENSORS_MAX77705) += max77705-hwmon.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
+obj-$(CONFIG_SENSORS_MC33XS2410) += mc33xs2410_hwmon.o
 obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
diff --git a/drivers/hwmon/mc33xs2410_hwmon.c b/drivers/hwmon/mc33xs2410_hwmon.c
new file mode 100644
index 0000000000000000000000000000000000000000..23eb90e337091724c5562703df7d77a5fae6253b
--- /dev/null
+++ b/drivers/hwmon/mc33xs2410_hwmon.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Liebherr-Electronics and Drives GmbH
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/hwmon.h>
+#include <linux/mc33xs2410.h>
+#include <linux/module.h>
+
+/* ctrl registers */
+
+#define MC33XS2410_TEMP_WT			0x29
+#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
+
+/* diag registers */
+
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
+#define MC33XS2410_OUT_STA_OTW			BIT(8)
+
+#define MC33XS2410_TS_TEMP_DIE			0x26
+#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
+
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
+
+static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_LABEL | HWMON_T_INPUT,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM),
+	NULL,
+};
+
+static umode_t mc33xs2410_hwmon_is_visible(const void *data,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_alarm:
+	case hwmon_temp_label:
+		return 0444;
+	case hwmon_temp_max:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int mc33xs2410_hwmon_read(struct device *dev,
+				 enum hwmon_sensor_types type,
+				 u32 attr, int channel, long *val)
+{
+	struct spi_device *spi = dev_get_drvdata(dev);
+	u16 reg_val;
+	int ret;
+	u8 reg;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = (channel == 0) ? MC33XS2410_TS_TEMP_DIE :
+				       MC33XS2410_TS_TEMP(channel);
+		ret = mc33xs2410_read_reg_diag(spi, reg, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		/* LSB is 0.25 degree celsius */
+		*val = FIELD_GET(MC33XS2410_TS_TEMP_MASK, reg_val) * 250 - 40000;
+		return 0;
+	case hwmon_temp_alarm:
+		ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel),
+					       &reg_val);
+		if (ret < 0)
+			return ret;
+
+		*val = FIELD_GET(MC33XS2410_OUT_STA_OTW, reg_val);
+		return 0;
+	case hwmon_temp_max:
+		ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_TEMP_WT, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		/* LSB is 1 degree celsius */
+		*val = FIELD_GET(MC33XS2410_TEMP_WT_MASK, reg_val) * 1000 - 40000;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mc33xs2410_hwmon_write(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long val)
+{
+	struct spi_device *spi = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		val = clamp_val(val, -40000, 215000);
+
+		/* LSB is 1 degree celsius */
+		val = (val / 1000) + 40;
+		return mc33xs2410_modify_reg(spi, MC33XS2410_TEMP_WT,
+					     MC33XS2410_TEMP_WT_MASK, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const char *const mc33xs2410_temp_label[] = {
+	"Central die temperature",
+	"Channel 1 temperature",
+	"Channel 2 temperature",
+	"Channel 3 temperature",
+	"Channel 4 temperature",
+};
+
+static int mc33xs2410_read_string(struct device *dev,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel, const char **str)
+{
+	*str = mc33xs2410_temp_label[channel];
+
+	return 0;
+}
+
+static const struct hwmon_ops mc33xs2410_hwmon_hwmon_ops = {
+	.is_visible = mc33xs2410_hwmon_is_visible,
+	.read = mc33xs2410_hwmon_read,
+	.read_string = mc33xs2410_read_string,
+	.write = mc33xs2410_hwmon_write,
+};
+
+static const struct hwmon_chip_info mc33xs2410_hwmon_chip_info = {
+	.ops = &mc33xs2410_hwmon_hwmon_ops,
+	.info = mc33xs2410_hwmon_info,
+};
+
+static int mc33xs2410_hwmon_probe(struct auxiliary_device *adev,
+				  const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct spi_device *spi = container_of(dev->parent, struct spi_device, dev);
+	struct device *hwmon;
+
+	hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
+						     &mc33xs2410_hwmon_chip_info,
+						     NULL);
+	return PTR_ERR_OR_ZERO(hwmon);
+}
+
+static const struct auxiliary_device_id mc33xs2410_hwmon_ids[] = {
+	{
+		.name = "pwm_mc33xs2410.hwmon",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, mc33xs2410_hwmon_ids);
+
+static struct auxiliary_driver mc33xs2410_hwmon_driver = {
+	.probe = mc33xs2410_hwmon_probe,
+	.id_table = mc33xs2410_hwmon_ids,
+};
+module_auxiliary_driver(mc33xs2410_hwmon_driver);
+
+MODULE_DESCRIPTION("NXP MC33XS2410 hwmon driver");
+MODULE_AUTHOR("Dimitri Fedrau <dimitri.fedrau@liebherr.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5



