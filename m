Return-Path: <linux-pwm+bounces-4892-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE791A35D1A
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC57170EF7
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28326560C;
	Fri, 14 Feb 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kQCT0dDq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA3263F2D;
	Fri, 14 Feb 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533824; cv=none; b=Nb5JSY7+GuyCzebxKpQXpkeKwYWBtP3QL0OROruoWBzwSTXInQonNtvMeC0GwvLJ3MVMH+qcj7ur6W1caQr4Q3gg6nmYUkqq3fp1p6e2SkCEOtcxHqeqDV6jWUGKxMThnzlbxBMrBGzalAwlDbjzH2m3HnKQXvAJ728QvfldqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533824; c=relaxed/simple;
	bh=2YQix1en3Vx/atfszEacllAnN0Jh/8t0ppRktHo2Hz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQtMfFcpciP2q935j2E6iIcfEEbLlB6bxryLxS+ZcCCjqivk8JF0JNynHL0kRFWy9kjedYtj3bSAYQBsLz9xP388NycWozq1h8rXHhsWO6b3FKriYRBbasJEvvV4G9pBZX9ZOS5x5lsON9rgkQTzt3ZMexmvl2J3pkcjlxwqP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kQCT0dDq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAE6C442E4;
	Fri, 14 Feb 2025 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RjYNaOLtqlk640MTT3kapCE7TApzxrTf3pYinTkrbk=;
	b=kQCT0dDqyAW87DJ0p5LUC8QK3GCMi3V3b29K2JdINE4WDl5Ie6feHlsY9RUZctTovYnWvi
	Q0WAcAof2agxXsr9x7OFMc26r8yJsxY2On9Xd/1JbJDvEC0RJ3h6hx1iXZvfLXrkJgmCaL
	1WdZFzyYSU5eFQM01Pvqh/rc3L7vK37NgtCefvbeg7vHQTxnD3R8X0RgfojBZMiHaEvm/Y
	tRjeFtDj0Ax1fuma8q3phzsrOL1pkiTSdslYMv2LKTvAuD6yf3jmuiMcqLjjXNErD4d62P
	q8Ra62TvSIYcbL9/gRi5Z66k7DBKKL7LGZ+xhfUuR/ey1c/g0wr2hfuvreSIzQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Feb 2025 12:49:59 +0100
Subject: [PATCH v4 09/10] input: misc: Add support for MAX7360 rotary
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-mdb-max7360-support-v4-9-8a35c6dbb966@bootlin.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
In-Reply-To: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=7143;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=2YQix1en3Vx/atfszEacllAnN0Jh/8t0ppRktHo2Hz4=;
 b=dQU9wHAKLuEv+C0CVk1g6smFcRccf5AY/VjOnb6Kha4QAeG07laRGyutJtRXUnQPeAZvsX5Wm
 khMSvGdmYUtBzKn25zjpjqzTehdYhzVapXYTt+0PWC+AYIARbD25o+r
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrt
 ghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 rotary encoder controller,
supporting a single rotary switch.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/input/misc/Kconfig          |  11 +++
 drivers/input/misc/Makefile         |   1 +
 drivers/input/misc/max7360-rotary.c | 182 ++++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 13d135257e06..96b183b4d3a5 100644
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
index 000000000000..bea25203a5c1
--- /dev/null
+++ b/drivers/input/misc/max7360-rotary.c
@@ -0,0 +1,182 @@
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
+#include <linux/property.h>
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
+			"Failed to read rotary counter\n");
+		return IRQ_NONE;
+	}
+
+	if (val == 0) {
+		dev_dbg(&max7360_rotary->input->dev,
+			"Got a spurious interrupt\n");
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
+			"Failed to enable max7360 rotary encoder\n");
+		return ret;
+	}
+
+	val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
+		FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;
+	ret = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
+	if (ret) {
+		dev_err(&max7360_rotary->input->dev,
+			"Failed to set max7360 rotary encoder configuration\n");
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
+		return dev_err_probe(&pdev->dev, ret,
+				     "Could not request rotary pin\n");
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
+		return -ENOMEM;
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
+				     "Failed to register interrupt\n");
+
+	ret = input_register_device(input);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Could not register input device\n");
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


