Return-Path: <linux-pwm+bounces-6772-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD20AFD05E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D78C1C20920
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CFB2E427E;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1cbKOnj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77F2D94AA;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991188; cv=none; b=jVeI+B/h1gpffdyvshqs1jzu48KneVJvK+y9oS5WiCbgypHpH0kywps9szfNOWD7P9kmNHGFSCh0Kzols7kfWdbEgeXWt6ZGQowTZIB1MjsrtlEq2Xy/p1XZ+QTa7vo8Ru3+99gNBW3n5VKgJKMBbybcoMZIA5dm+DUyRUXmd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991188; c=relaxed/simple;
	bh=fgYq0ayJwMVQuOPA26R7MTd/+Nvb95/+seIZgbppJG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lhc46wwrOUksoqvuKfMjE3mCMFLVYnLz02eY0v7+ErNTdjqJGBNO7uEKJHcxB71nbVfuPCcZYPbhrPh/j2Z/dMch+Yw8FEdAP+2/y8YyFPNqxxdv96PzGAPGZsoW3jmLrLGEgkfsKVt4mDj6189ioELrd/INRmOiOw0ITTXZz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1cbKOnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44DC1C4CEEF;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991188;
	bh=fgYq0ayJwMVQuOPA26R7MTd/+Nvb95/+seIZgbppJG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P1cbKOnjMTXJhqHYt1OiVqkhlN7I0HDlw9RKCZwMwM9UDrfZad/cdITIuZoUQHmkQ
	 uW96CeBUT3p+8iIln6KTdTqt0lEvoAfYcGwakh9SajjeC3SYTpinOR0FttjjpT+5pd
	 5QSRDfWL49/ilqPTGDneQPvKO8FJzAsnZAQxa3BWROlXMcQKfghqF+7CopQ5yYVc3k
	 pbbQApmnKtBa6lBBKn+xT29mpO5+C/59+YDTjXGaLBE89Y7oyTIr0vN3g7PPuhl/9X
	 4NMSREbVYzM/4luN6kCaTya8Qgble11d+WoiLORKgBWAU+DaJvFeDa8CqzNCLegWCe
	 isYcKsvwIaO1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9FC83F0D;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 08 Jul 2025 18:13:04 +0200
Subject: [PATCH v4 2/2] hwmon: add support for MC33XS2410 hardware
 monitoring
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-mc33xs2410-hwmon-v4-2-95b9e3ea5f5c@liebherr.com>
References: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
In-Reply-To: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751991187; l=7071;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Y3gflseXUc2ZtNcSajbTMZmapBy8gGu7sjRri5Ir/7k=;
 b=rhiQBQ1jiYgC0eUlIXyJZdhiX3DO1TkCuW01ZHxsS0qHstBN/EotDivM3F03wjXg9dxky2HHq
 255K9CUDqfnBweg/a4TehVDOZ6okm5faHA9FwyIBfAXJYLAnzgr/Raa
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
 drivers/hwmon/Kconfig            |  10 +++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/mc33xs2410_hwmon.c | 179 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)

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
index 0000000000000000000000000000000000000000..71a14932c6ccaf8d15b045b55093238d924160ea
--- /dev/null
+++ b/drivers/hwmon/mc33xs2410_hwmon.c
@@ -0,0 +1,179 @@
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
+MODULE_IMPORT_NS("PWM_MC33XS2410");

-- 
2.39.5



