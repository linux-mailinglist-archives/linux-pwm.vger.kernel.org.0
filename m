Return-Path: <linux-pwm+bounces-4466-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F49FB344
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C9A1882BC3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40B1CCEE9;
	Mon, 23 Dec 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iJza9+6Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7A1AF4EA;
	Mon, 23 Dec 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972235; cv=none; b=BHmnpPGVg26WcOxSJ4GPCm5eXVlpJz2eDqVcLjkpPXgjKDWUjXxsJqKOBJm70RyFNNQU/VZNGfXMWJ8jkcWNAFQErPo2o8qFQSW26iA7TFoc58r0mWm9JW7zy50V4XHWeB83ubHjJRdrvtUFU3Gihc3fcIsK/E46c3EIlDV809Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972235; c=relaxed/simple;
	bh=0EJQPkVhhNMKsiwDvvk461KdgQxGVzMquFT7FGnpaog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAe3yLDprUV9CftBvBD2g7zoN6rFxqGy17FAYr4VNJXIEIIb73QL3UH9DCovlsnfkLqn3WSmtp/UjgPv0pK1gZRbK0MDIOn4e1CWaxIaj1jvr3FbTRIe2zN2bN6YOY/dmTcBEM/Dk2Krjv5P0+kozI1NioDXxTtIdNk1njuibFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iJza9+6Q; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6A6360009;
	Mon, 23 Dec 2024 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734972224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaqU+EPlCrnqw0J8p74OVWkYfLWAN6jtSeZ6XBraqms=;
	b=iJza9+6Q6yZUQ9rCau6zQhGhQEtiqjCV8CiT3STkZpJ/xnKDBf8Iyg1G/A6wCK19//MoK9
	8M5G+76BK4LsNZdWIsBjd6w9sXsHrUxj8OzgDLaXZyFyH7ZfZcTF9LIhshrm05Wemnv9G9
	AwF1eZFLNkHqxEna/mZFZM4IhaeKdBdzXsTnShwfKbALRHxTUrJ6Vb5foKl81ln57KGve8
	l3dJvi7TLwOwJDCXm1rWBFIRyp0VvoyYL7C2i15iVIq+XBXxS20x0opqqJ+I1tYOXa0Cny
	IepQMaJW3XBRZSuuyY0+xaCMl0bn4fTTXWZOYF/4gmm/iwwkKeS/Ya8XXHYMbg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 23 Dec 2024 17:42:38 +0100
Subject: [PATCH v2 6/7] input: misc: Add support for MAX7360 rotary
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-mdb-max7360-support-v2-6-37a8d22c36ed@bootlin.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
In-Reply-To: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734972218; l=7282;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=0EJQPkVhhNMKsiwDvvk461KdgQxGVzMquFT7FGnpaog=;
 b=y/TJpNOvzTGaS1+mt3uUTOrwHGpLWC/KLp3HoYRZ12NRn4M+WOXJXJI9798kqZmq2jbv0jdmp
 zdBZJrcuJ7ZBxVC+vEf2X+NTLdOCIODGg4ZgWOYAinnJsfNdR7fgngO
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 rotary encoder controller,
supporting a single rotary switch.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/input/misc/Kconfig          |  11 +++
 drivers/input/misc/Makefile         |   1 +
 drivers/input/misc/max7360-rotary.c | 185 ++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6a852c76331b..8430aaf08c04 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -230,6 +230,17 @@ config INPUT_M68K_BEEP
 	tristate "M68k Beeper support"
 	depends on M68K
 
+config INPUT_MAX7360_ROTARY
+	tristate "Maxim MAX7360 Rotary Encoder"
+	depends on I2C
+	depends on MFD_MAX7360
+	help
+	  If you say yes here you get support for the rotary encoder on the
+	  Maxim MAX7360 I/O Expander.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called max7360_rotary.
+
 config INPUT_MAX77650_ONKEY
 	tristate "Maxim MAX77650 ONKEY support"
 	depends on MFD_MAX77650
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 4f7f736831ba..0ed447543e43 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_INPUT_IQS7222)		+= iqs7222.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
+obj-$(CONFIG_INPUT_MAX7360_ROTARY)	+= max7360-rotary.o
 obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
 obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
diff --git a/drivers/input/misc/max7360-rotary.c b/drivers/input/misc/max7360-rotary.c
new file mode 100644
index 000000000000..4639c73a3f9d
--- /dev/null
+++ b/drivers/input/misc/max7360-rotary.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Bootlin
+ *
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+struct max7360_rotary {
+	u32 axis;
+	struct input_dev *input;
+	unsigned int debounce_ms;
+	struct regmap *regmap;
+};
+
+static irqreturn_t max7360_rotary_irq(int irq, void *data)
+{
+	struct max7360_rotary *max7360_rotary = data;
+	int val;
+	int ret;
+
+	ret = regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
+	if (ret < 0) {
+		dev_err(&max7360_rotary->input->dev,
+			"Failed to read rotary counter");
+		return IRQ_NONE;
+	}
+
+	if (val == 0) {
+		dev_dbg(&max7360_rotary->input->dev,
+			"Got a spurious interrupt");
+
+		return IRQ_NONE;
+	}
+
+	input_report_rel(max7360_rotary->input, max7360_rotary->axis,
+			 (int8_t)val);
+	input_sync(max7360_rotary->input);
+
+	return IRQ_HANDLED;
+}
+
+static int max7360_rotary_hw_init(struct max7360_rotary *max7360_rotary)
+{
+	int val;
+	int ret;
+
+	ret = regmap_write_bits(max7360_rotary->regmap, MAX7360_REG_GPIOCFG,
+				MAX7360_GPIO_CFG_RTR_EN,
+				MAX7360_GPIO_CFG_RTR_EN);
+	if (ret) {
+		dev_err(&max7360_rotary->input->dev,
+			"Failed to enable max7360 rotary encoder");
+		return ret;
+	}
+
+	val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
+		FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;
+	ret = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
+	if (ret) {
+		dev_err(&max7360_rotary->input->dev,
+			"Failed to set max7360 rotary encoder configuration");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max7360_rotary_probe(struct platform_device *pdev)
+{
+	struct max7360_rotary *max7360_rotary;
+	struct input_dev *input;
+	int irq;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");
+
+	ret = max7360_port_pin_request(pdev->dev.parent, MAX7360_PORT_RTR_PIN,
+				       true);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret,
+			      "Could not request rotary pin\n");
+
+	irq = platform_get_irq_byname(to_platform_device(pdev->dev.parent),
+				      "inti");
+	if (irq < 0)
+		return irq;
+
+	max7360_rotary = devm_kzalloc(&pdev->dev, sizeof(*max7360_rotary),
+				      GFP_KERNEL);
+	if (!max7360_rotary)
+		return -ENOMEM;
+
+	max7360_rotary->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!max7360_rotary->regmap)
+		dev_err_probe(&pdev->dev, -ENODEV,
+			      "Could not get parent regmap\n");
+
+	device_property_read_u32(pdev->dev.parent, "linux,axis",
+				 &max7360_rotary->axis);
+	device_property_read_u32(pdev->dev.parent, "rotary-debounce-delay-ms",
+				 &max7360_rotary->debounce_ms);
+	if (max7360_rotary->debounce_ms > MAX7360_ROT_DEBOUNCE_MAX)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid debounce timing: %u\n",
+				     max7360_rotary->debounce_ms);
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocate input device\n");
+
+	max7360_rotary->input = input;
+
+	input->id.bustype = BUS_I2C;
+	input->name = pdev->name;
+	input->dev.parent = &pdev->dev;
+
+	input_set_capability(input, EV_REL, max7360_rotary->axis);
+	input_set_drvdata(input, max7360_rotary);
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					max7360_rotary_irq,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
+					"max7360-rotary", max7360_rotary);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register interrupt: %d\n", ret);
+
+	ret = input_register_device(input);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Could not register input device: %d\n",
+			ret);
+
+	platform_set_drvdata(pdev, max7360_rotary);
+
+	device_init_wakeup(&pdev->dev, true);
+	ret = dev_pm_set_wake_irq(&pdev->dev, irq);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n", ret);
+
+	ret = max7360_rotary_hw_init(max7360_rotary);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to initialize max7360 rotary\n");
+
+	return 0;
+}
+
+static void max7360_rotary_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+
+	/*
+	 * Free the MAX7360_PORT_RTR_PIN pin, so it can be requested later by
+	 * this driver, the MAX7360 GPIO driver or the MAX7360 PWM driver.
+	 */
+	max7360_port_pin_request(pdev->dev.parent, MAX7360_PORT_RTR_PIN, false);
+}
+
+static struct platform_driver max7360_rotary_driver = {
+	.driver = {
+		.name	= MAX7360_DRVNAME_ROTARY,
+	},
+	.probe		= max7360_rotary_probe,
+	.remove		= max7360_rotary_remove,
+};
+module_platform_driver(max7360_rotary_driver);
+
+MODULE_DESCRIPTION("MAX7360 Rotary driver");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_ALIAS("platform:" MAX7360_DRVNAME_ROTARY);
+MODULE_LICENSE("GPL");

-- 
2.39.5


