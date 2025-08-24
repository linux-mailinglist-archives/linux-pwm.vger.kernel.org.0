Return-Path: <linux-pwm+bounces-7160-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A62B32FE2
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 14:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CE8189635D
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F72DE1F0;
	Sun, 24 Aug 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SyStqqpw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015B2D877F;
	Sun, 24 Aug 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036710; cv=none; b=eDPP3eUqSTCPU3evr3Xish9CrnoXLjlVKrunqSskIUUOH4soSgLDQRdK/GzU7kR1wv4XKOlWeoUuq3+LLPbQqZUjY6OFvUStMT9gE7cDoHTX+eHSVSk/72cyAlPyL0VBpL4pRavGLTwTLnfQzEwsnZZYDiPxekphpsr8+J/O7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036710; c=relaxed/simple;
	bh=BO0UHDtr7pSNWhL5eLvAfXpLX1izwh+f5++BPpnTsAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spYiPiVJMtUCzpxFACEefW1qNf49ir+8A2OhOE+KSNnhvBHZ9RJ/58dANx1Hetd0STk7fGQjiQOYyhu+qo4vQEoWijeXsYXfnX3cYlkmJlN0RiR31tQeYMzn0Pyp6hoiRVHCGjizAugHdd4yU9BhEeBeAva7W6qOhRADZCfA+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SyStqqpw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4B772C8F1D2;
	Sun, 24 Aug 2025 11:58:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50376605F1;
	Sun, 24 Aug 2025 11:58:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67CBF1C22AB0F;
	Sun, 24 Aug 2025 13:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756036706; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0HLUha8z27dTrKx5/1HKwWyi33BxVl7LpPldqBPQcRY=;
	b=SyStqqpwwi9OIV78Esi2SQtX6Vgtbqjv3JRn97IzheZltYViJC8/1dC7+4gdng6LZymH/V
	IRfx7BCpe9pME4uKMUzBaF9FbePKZMjHjFEi/IfMuhQ298ygydhd5Z/1rpfsoI+sYn3jWv
	Om1NHBJZoDgWkleoP2Le8U60nwsU/FsjU8IHRxl3xp4UQd8YQkDcisGRxTlqJxWs9EVcoB
	SPVsnWR+GNvLJLB1uGclA+X7dQ9EYWe9bcDVSnjIY8haDdFMj/D/edQLY40vRdqQl9EIz6
	IJX85JjTy7o4y9WDeGrlIwUZpuJk6Be+8AtgOx/TzpqM1488Ai/RJf7E4mFswA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 24 Aug 2025 13:57:28 +0200
Subject: [PATCH v14 09/10] input: misc: Add support for MAX7360 rotary
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-mdb-max7360-support-v14-9-435cfda2b1ea@bootlin.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756036647; l=7729;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=BO0UHDtr7pSNWhL5eLvAfXpLX1izwh+f5++BPpnTsAQ=;
 b=hKz7/tI+/XmbFORfcm+zBzS5VnI2UNjS9c5wFnCaUTAtJvB4TyXKcoJqoDuj36yT8L/NRnMze
 9coqQlbbz/XAfQZG4Dlg3TPX7JhcT5GH4VOhQRAbJgQlycMcXmpVI6+
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

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
index 0fb21c99a5e3..d604aad90a89 100644
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
index d468c8140b93..ac45cb9b5c99 100644
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


