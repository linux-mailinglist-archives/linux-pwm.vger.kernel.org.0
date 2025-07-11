Return-Path: <linux-pwm+bounces-6833-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE8B017CD
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 11:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557885403A4
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4D27CCE2;
	Fri, 11 Jul 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aHVWUFhh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D02627FC;
	Fri, 11 Jul 2025 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226238; cv=none; b=kWXbTgNpnZQ1Q92m2aQ7/mbScaAIs7VtptdjVFcQ4bF8aB7TLS2IY/xzSwgIAXQi2GksKxwB06EOJRAXfYIvQn/lIvBMg/zQTlYD5ELLhIi9f2gJiU/ZyVwRr99N/j05IQf3bVcZg5IuqGBPxURNQcSt5vJrw8YNy2AgAFH0Uik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226238; c=relaxed/simple;
	bh=Vfwr3T6oFIr11ChPVQ4cLfkvMx4CouG1IEddNOdLMdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9g9w1FFVcnHqEC7ehfACEI8PCWNp2tgN3bOmTkzjjTOG/A2GzY4l1qLwHEIfuQnprVW6Std8M7hcxMVxWQnq/7cSGNGh10jxYIuWQEM+kGQ8v+wRV14Jb8O+LrFaeKn0rvQ3wFd7za4xiBqkTggcCHu3NSaxYRywjyffP0cKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aHVWUFhh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8267243A1E;
	Fri, 11 Jul 2025 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752226228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/2/VGmKfyMKjx1nQXnOEIb84oP44Mh6hiFeixIS2G0=;
	b=aHVWUFhhVoorpY944GkSJoQ4wkxCY/FhOagC9M30ydgPX+iBI+HLc6I/O+dcAn72ott4nP
	QKhdae6jEcNM/+p39vFJBKmVhPEjdWC+Czu3DmMXJ7515CwlIXi0SPEkx0PW8zSQPQtyXA
	98VREFBlwKTMW1GADrZTg9oZ+G7wMMwtVqIzSW+NngbuwqAIDxX0ZwV2Qh32IU1AQp5/NI
	41W4A03PUj1NH+F8aWzEb4fO7N7YFyfPVt0ujJOgVDX/JV1MZM5PK4TkdbkeTBWIuRYUuo
	HCvfMxhywQ3ZIwsRuJPsWm9333I+YIJSy2BN0XLHQuoHH6hc5oLrGHBczS4g8w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 11 Jul 2025 11:29:43 +0200
Subject: [PATCH v11 03/10] pinctrl: Add MAX7360 pinctrl driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mdb-max7360-support-v11-3-cf1dee2a7d4c@bootlin.com>
References: <20250711-mdb-max7360-support-v11-0-cf1dee2a7d4c@bootlin.com>
In-Reply-To: <20250711-mdb-max7360-support-v11-0-cf1dee2a7d4c@bootlin.com>
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
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752226224; l=9011;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Vfwr3T6oFIr11ChPVQ4cLfkvMx4CouG1IEddNOdLMdg=;
 b=zn4tY80ooTcwHhMyMV+GEzhDZohBc8T+5g5TIAE1I7BO0S+uSY+9lN8LVaw+Kx/7xAvQ7VCUN
 I8yMhcgOYR3Df0V6GGLerVLtMQGy/hr+TdB0+r6InHCijsWQj7nCwlL
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
can be used either for GPIO, PWM or rotary encoder functionalities.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/Kconfig           |  11 ++
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-max7360.c | 215 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 33db9104df17..98448db31456 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -346,6 +346,17 @@ config PINCTRL_LPC18XX
 	help
 	  Pinctrl driver for NXP LPC18xx/43xx System Control Unit (SCU).
 
+config PINCTRL_MAX7360
+	tristate "MAX7360 Pincontrol support"
+	depends on MFD_MAX7360
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  Say Y here to enable pin control support for Maxim MAX7360 keypad
+	  controller.
+	  This keypad controller has 8 GPIO pins that may work as GPIO, or PWM,
+	  or rotary encoder alternate modes.
+
 config PINCTRL_MAX77620
 	tristate "MAX77620/MAX20024 Pincontrol support"
 	depends on MFD_MAX77620 && OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index ac27e88677d1..974a179b5593 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
 obj-$(CONFIG_PINCTRL_LOONGSON2) += pinctrl-loongson2.o
 obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
 obj-$(CONFIG_PINCTRL_LPC18XX)	+= pinctrl-lpc18xx.o
+obj-$(CONFIG_PINCTRL_MAX7360)	+= pinctrl-max7360.o
 obj-$(CONFIG_PINCTRL_MAX77620)	+= pinctrl-max77620.o
 obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o
 obj-$(CONFIG_PINCTRL_MCP23S08_SPI)	+= pinctrl-mcp23s08_spi.o
diff --git a/drivers/pinctrl/pinctrl-max7360.c b/drivers/pinctrl/pinctrl-max7360.c
new file mode 100644
index 000000000000..abfaff468bad
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-max7360.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
+ *
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mfd/max7360.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/stddef.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "core.h"
+#include "pinmux.h"
+
+struct max7360_pinctrl {
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pinctrl_desc;
+};
+
+static const struct pinctrl_pin_desc max7360_pins[] = {
+	PINCTRL_PIN(0, "PORT0"),
+	PINCTRL_PIN(1, "PORT1"),
+	PINCTRL_PIN(2, "PORT2"),
+	PINCTRL_PIN(3, "PORT3"),
+	PINCTRL_PIN(4, "PORT4"),
+	PINCTRL_PIN(5, "PORT5"),
+	PINCTRL_PIN(6, "PORT6"),
+	PINCTRL_PIN(7, "PORT7"),
+};
+
+static const unsigned int port0_pins[] = {0};
+static const unsigned int port1_pins[] = {1};
+static const unsigned int port2_pins[] = {2};
+static const unsigned int port3_pins[] = {3};
+static const unsigned int port4_pins[] = {4};
+static const unsigned int port5_pins[] = {5};
+static const unsigned int port6_pins[] = {6};
+static const unsigned int port7_pins[] = {7};
+static const unsigned int rotary_pins[] = {6, 7};
+
+static const struct pingroup max7360_groups[] = {
+	PINCTRL_PINGROUP("PORT0", port0_pins, ARRAY_SIZE(port0_pins)),
+	PINCTRL_PINGROUP("PORT1", port1_pins, ARRAY_SIZE(port1_pins)),
+	PINCTRL_PINGROUP("PORT2", port2_pins, ARRAY_SIZE(port2_pins)),
+	PINCTRL_PINGROUP("PORT3", port3_pins, ARRAY_SIZE(port3_pins)),
+	PINCTRL_PINGROUP("PORT4", port4_pins, ARRAY_SIZE(port4_pins)),
+	PINCTRL_PINGROUP("PORT5", port5_pins, ARRAY_SIZE(port5_pins)),
+	PINCTRL_PINGROUP("PORT6", port6_pins, ARRAY_SIZE(port6_pins)),
+	PINCTRL_PINGROUP("PORT7", port7_pins, ARRAY_SIZE(port7_pins)),
+	PINCTRL_PINGROUP("ROTARY", rotary_pins, ARRAY_SIZE(rotary_pins)),
+};
+
+static int max7360_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(max7360_groups);
+}
+
+static const char *max7360_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+						  unsigned int group)
+{
+	return max7360_groups[group].name;
+}
+
+static int max7360_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  const unsigned int **pins,
+					  unsigned int *num_pins)
+{
+	*pins = max7360_groups[group].pins;
+	*num_pins = max7360_groups[group].npins;
+	return 0;
+}
+
+static const struct pinctrl_ops max7360_pinctrl_ops = {
+	.get_groups_count = max7360_pinctrl_get_groups_count,
+	.get_group_name = max7360_pinctrl_get_group_name,
+	.get_group_pins = max7360_pinctrl_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
+static const char * const simple_groups[] = {
+	"PORT0", "PORT1", "PORT2", "PORT3",
+	"PORT4", "PORT5", "PORT6", "PORT7",
+};
+
+static const char * const rotary_groups[] = { "ROTARY" };
+
+#define MAX7360_PINCTRL_FN_GPIO		0
+#define MAX7360_PINCTRL_FN_PWM		1
+#define MAX7360_PINCTRL_FN_ROTARY	2
+static const struct pinfunction max7360_functions[] = {
+	[MAX7360_PINCTRL_FN_GPIO] = PINCTRL_PINFUNCTION("gpio", simple_groups,
+							ARRAY_SIZE(simple_groups)),
+	[MAX7360_PINCTRL_FN_PWM] = PINCTRL_PINFUNCTION("pwm", simple_groups,
+						       ARRAY_SIZE(simple_groups)),
+	[MAX7360_PINCTRL_FN_ROTARY] = PINCTRL_PINFUNCTION("rotary", rotary_groups,
+							  ARRAY_SIZE(rotary_groups)),
+};
+
+static int max7360_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(max7360_functions);
+}
+
+static const char *max7360_get_function_name(struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	return max7360_functions[selector].name;
+}
+
+static int max7360_get_function_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+				       const char * const **groups,
+				       unsigned int * const num_groups)
+{
+	*groups = max7360_functions[selector].groups;
+	*num_groups = max7360_functions[selector].ngroups;
+
+	return 0;
+}
+
+static int max7360_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
+			   unsigned int group)
+{
+	struct regmap *regmap = dev_get_regmap(pctldev->dev->parent, NULL);
+	int val;
+
+	/*
+	 * GPIO and PWM functions are the same: we only need to handle the
+	 * rotary encoder function, on pins 6 and 7.
+	 */
+	if (max7360_groups[group].pins[0] >= 6) {
+		if (selector == MAX7360_PINCTRL_FN_ROTARY)
+			val = MAX7360_GPIO_CFG_RTR_EN;
+		else
+			val = 0;
+
+		return regmap_write_bits(regmap, MAX7360_REG_GPIOCFG, MAX7360_GPIO_CFG_RTR_EN, val);
+	}
+
+	return 0;
+}
+
+static const struct pinmux_ops max7360_pmxops = {
+	.get_functions_count = max7360_get_functions_count,
+	.get_function_name = max7360_get_function_name,
+	.get_function_groups = max7360_get_function_groups,
+	.set_mux = max7360_set_mux,
+	.strict = true,
+};
+
+static int max7360_pinctrl_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	struct pinctrl_desc *pd;
+	struct max7360_pinctrl *chip;
+	struct device *dev = &pdev->dev;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	pd = &chip->pinctrl_desc;
+
+	pd->pctlops = &max7360_pinctrl_ops;
+	pd->pmxops = &max7360_pmxops;
+	pd->name = dev_name(dev);
+	pd->pins = max7360_pins;
+	pd->npins = MAX7360_MAX_GPIO;
+	pd->owner = THIS_MODULE;
+
+	/*
+	 * This MFD sub-device does not have any associated device tree node:
+	 * properties are stored in the device node of the parent (MFD) device
+	 * and this same node is used in phandles of client devices.
+	 * Reuse this device tree node here, as otherwise the pinctrl subsystem
+	 * would be confused by this topology.
+	 */
+	device_set_of_node_from_dev(dev, dev->parent);
+
+	chip->pctldev = devm_pinctrl_register(dev, pd, chip);
+	if (IS_ERR(chip->pctldev))
+		return dev_err_probe(dev, PTR_ERR(chip->pctldev), "can't register controller\n");
+
+	return 0;
+}
+
+static struct platform_driver max7360_pinctrl_driver = {
+	.driver = {
+		.name	= "max7360-pinctrl",
+	},
+	.probe		= max7360_pinctrl_probe,
+};
+module_platform_driver(max7360_pinctrl_driver);
+
+MODULE_DESCRIPTION("MAX7360 pinctrl driver");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5


