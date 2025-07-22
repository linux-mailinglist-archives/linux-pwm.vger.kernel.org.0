Return-Path: <linux-pwm+bounces-6870-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836CB0E1CC
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 18:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D4418922B3
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849E281351;
	Tue, 22 Jul 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="il8mbBqw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898B27FD4A;
	Tue, 22 Jul 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201457; cv=none; b=i79eXW3A3yi9bvOC6GQEK1lJu0Hd84LqEsdVl6S7erXCrvAucWGfd2XJub+rweHRSoPA6Id7QPKvq/vP3984P58MsIMe2a9wECIUzTTDjbQzSNnA2wfulS+myO2pNlh12MDWP8T8h8nkBCaGQdvSjVEUnGGNDHcri4FTKaYDcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201457; c=relaxed/simple;
	bh=ivCv2diegFAI10yvN/kIznk53Nc/V6s4C22VehNSBd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bckvnx0FJ5BI1/Tumyw5rj22q+eyr6aqszFhW9MPE+S7Vd2St/VVB4xwllbacO5uVk5qPga5NGqfHRLXDJPjRyh/IH1DNLP9SgOVa5t7wdVTmTTGcvo+DSkmGXiC3J52buCTTvDEOKOE2Bnt81bFLQ3WDTXouq0QQmh1ci7Y21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=il8mbBqw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 632DB442B9;
	Tue, 22 Jul 2025 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753201453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3qubtbFuYPrSo/BjVwcQQS6M3xWsCf4JaEdFKScetg=;
	b=il8mbBqwMRoKA30LS169957IoeC/qdLg3Oq7AX3RD4zXhzXiMSIAcPyVJf4XXyEFW074mg
	mnOdu9tx8x1VV+eaoMpJeIpEXwFzc1XJEBXo4CIMCuQcKcFSKpPGv4AiEjK6bi5qRD8ZCT
	xM7bChHzCNDnyi2vXUPjgKOXPkzGcAGQy3NmUtbvN7X3Zc9UvNllj30H1kngSgCa1p+vbS
	AIP2lzL+4Hi0rYKvEPTvPqWtGnk6kxhlYGf+oep5c23TelzFHw5lyXMqRp20mUxJRWG6Pi
	vtdGPr59ODGha9ZQkcVbt82fz3KUsvohSSDlU45qX78IgrqrE/rHiRL3LK1WdA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 22 Jul 2025 18:23:53 +0200
Subject: [PATCH v12 09/10] input: misc: Add support for MAX7360 rotary
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-mdb-max7360-support-v12-9-3747721a8d02@bootlin.com>
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
In-Reply-To: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753201440; l=7729;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ivCv2diegFAI10yvN/kIznk53Nc/V6s4C22VehNSBd4=;
 b=O0CnSm2QFJp+hkCEqXqYv4Fcc4hrmKeeZWQp1pQfIPp/EFS5BD8LWJdviQuHtUiDRYXIzvgA1
 47p6LRbqrBVDVOsHSxtnDcIiCSBc6MqIicUZt+PFzAM1TQSi1d2QhmP
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhv
 ghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 rotary encoder controller,
supporting a single rotary switch.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/input/misc/Kconfig          |  10 ++
 drivers/input/misc/Makefile         |   1 +
 drivers/input/misc/max7360-rotary.c | 192 ++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index f5496ca0c0d2..0bc9d121c984 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -230,6 +230,16 @@ config INPUT_M68K_BEEP
 	tristate "M68k Beeper support"
 	depends on M68K
 
+config INPUT_MAX7360_ROTARY
+	tristate "Maxim MAX7360 Rotary Encoder"
+	depends on MFD_MAX7360
+	help
+	  If you say yes here you get support for the rotary encoder on the
+	  Maxim MAX7360 I/O Expander.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max7360_rotary.
+
 config INPUT_MAX77650_ONKEY
 	tristate "Maxim MAX77650 ONKEY support"
 	depends on MFD_MAX77650
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 6d91804d0a6f..c454fba3a3ae 100644
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
index 000000000000..385831ef34b6
--- /dev/null
+++ b/drivers/input/misc/max7360-rotary.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
+ *
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device/devres.h>
+#include <linux/dev_printk.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define MAX7360_ROTARY_DEFAULT_STEPS 24
+
+struct max7360_rotary {
+	struct input_dev *input;
+	struct regmap *regmap;
+	unsigned int debounce_ms;
+
+	unsigned int pos;
+
+	u32 steps;
+	u32 axis;
+	bool relative_axis;
+	bool rollover;
+};
+
+static void max7360_rotary_report_event(struct max7360_rotary *max7360_rotary, int steps)
+{
+	if (max7360_rotary->relative_axis) {
+		input_report_rel(max7360_rotary->input, max7360_rotary->axis, steps);
+	} else {
+		int pos = max7360_rotary->pos;
+		int maxval = max7360_rotary->steps;
+
+		/*
+		 * Add steps to the position.
+		 * Make sure added steps are always in ]-maxval; maxval[
+		 * interval, so (pos + maxval) is always >= 0.
+		 * Then set back pos to the [0; maxval[ interval.
+		 */
+		pos += steps % maxval;
+		if (max7360_rotary->rollover)
+			pos = (pos + maxval) % maxval;
+		else
+			pos = clamp(pos, 0, maxval - 1);
+
+		max7360_rotary->pos = pos;
+		input_report_abs(max7360_rotary->input, max7360_rotary->axis, max7360_rotary->pos);
+	}
+
+	input_sync(max7360_rotary->input);
+}
+
+static irqreturn_t max7360_rotary_irq(int irq, void *data)
+{
+	struct max7360_rotary *max7360_rotary = data;
+	struct device *dev = max7360_rotary->input->dev.parent;
+	unsigned int val;
+	int error;
+
+	error = regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
+	if (error < 0) {
+		dev_err(dev, "Failed to read rotary counter\n");
+		return IRQ_NONE;
+	}
+
+	if (val == 0)
+		return IRQ_NONE;
+
+	max7360_rotary_report_event(max7360_rotary, sign_extend32(val, 7));
+
+	return IRQ_HANDLED;
+}
+
+static int max7360_rotary_hw_init(struct max7360_rotary *max7360_rotary)
+{
+	struct device *dev = max7360_rotary->input->dev.parent;
+	int val;
+	int error;
+
+	val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
+	      FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;
+	error = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
+	if (error)
+		dev_err(dev, "Failed to set max7360 rotary encoder configuration\n");
+
+	return error;
+}
+
+static int max7360_rotary_probe(struct platform_device *pdev)
+{
+	struct max7360_rotary *max7360_rotary;
+	struct device *dev = &pdev->dev;
+	struct input_dev *input;
+	struct regmap *regmap;
+	int irq;
+	int error;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
+
+	irq = fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	max7360_rotary = devm_kzalloc(dev, sizeof(*max7360_rotary), GFP_KERNEL);
+	if (!max7360_rotary)
+		return -ENOMEM;
+
+	max7360_rotary->regmap = regmap;
+
+	device_property_read_u32(dev->parent, "linux,axis", &max7360_rotary->axis);
+	max7360_rotary->rollover = device_property_read_bool(dev->parent,
+							     "rotary-encoder,rollover");
+	max7360_rotary->relative_axis =
+		device_property_read_bool(dev->parent, "rotary-encoder,relative-axis");
+
+	error = device_property_read_u32(dev->parent, "rotary-encoder,steps",
+					 &max7360_rotary->steps);
+	if (error)
+		max7360_rotary->steps = MAX7360_ROTARY_DEFAULT_STEPS;
+
+	device_property_read_u32(dev->parent, "rotary-debounce-delay-ms",
+				 &max7360_rotary->debounce_ms);
+	if (max7360_rotary->debounce_ms > MAX7360_ROT_DEBOUNCE_MAX)
+		return dev_err_probe(dev, -EINVAL, "Invalid debounce timing: %u\n",
+				     max7360_rotary->debounce_ms);
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	max7360_rotary->input = input;
+
+	input->id.bustype = BUS_I2C;
+	input->name = pdev->name;
+
+	if (max7360_rotary->relative_axis)
+		input_set_capability(input, EV_REL, max7360_rotary->axis);
+	else
+		input_set_abs_params(input, max7360_rotary->axis, 0, max7360_rotary->steps, 0, 1);
+
+	error = devm_request_threaded_irq(dev, irq, NULL, max7360_rotary_irq,
+					  IRQF_ONESHOT | IRQF_SHARED,
+					  "max7360-rotary", max7360_rotary);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to register interrupt\n");
+
+	error = input_register_device(input);
+	if (error)
+		return dev_err_probe(dev, error, "Could not register input device\n");
+
+	error = max7360_rotary_hw_init(max7360_rotary);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to initialize max7360 rotary\n");
+
+	device_init_wakeup(dev, true);
+	error = dev_pm_set_wake_irq(dev, irq);
+	if (error)
+		dev_warn(dev, "Failed to set up wakeup irq: %d\n", error);
+
+	return 0;
+}
+
+static void max7360_rotary_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
+
+static struct platform_driver max7360_rotary_driver = {
+	.driver = {
+		.name	= "max7360-rotary",
+	},
+	.probe		= max7360_rotary_probe,
+	.remove		= max7360_rotary_remove,
+};
+module_platform_driver(max7360_rotary_driver);
+
+MODULE_DESCRIPTION("MAX7360 Rotary driver");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5


