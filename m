Return-Path: <linux-pwm+bounces-4889-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30BA35CED
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434103B0D33
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000A264A61;
	Fri, 14 Feb 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LqYFCJGj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B3263C64;
	Fri, 14 Feb 2025 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533822; cv=none; b=A1paWREWbC5uLRyMtEIdKHBE0ew1Gx3C44j5Cwxom6x6J+HtIeln1ziNg+MMSua+FsWkbrVrvOBImwEM4bsT+9mIdGVytqU+OxpH4EcSEQcj4zVObjaJRbR+1GoEoRoCUoUFlW4k/uDFWDUsvFTvKG0AGZ71cj2YsCzAj+z7ghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533822; c=relaxed/simple;
	bh=cM8GtLZ+bLNxWZhWtRWMTgHK+nu3k2+SE/685tamwdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PMUD3+wkyFW02tEv+y4iXGEHGMR3eKYikGJ5rfZDQUl2zyUB73s3UQb3GCM9WcbT7vLFoROLykrPNZ7W8PoTQO1Hc04jgl6KEqdKNMtAvnhhcUgTUJa7AIO/5mvJcPBlFg8pmrV3HtQPMM+K0YC3NP+WN2/C7L966gcKYTfpWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LqYFCJGj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 629AD4429B;
	Fri, 14 Feb 2025 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6dN52st5BOuW/1TAQeF1FVppaZge03iCWeKGuavnsY=;
	b=LqYFCJGjWSUikCbXdJIMbogCscRV3XKsQq0VH8eFqTgyPpiQajFFe/cT5ZLQ5Bwd0aRIgv
	kfq0adqMcRuHAZ1erhu5HD9OWaR3QUCreJ78eXBbOffOKEJ9uV2uCgVb2zeaN/8JvlnmAG
	af73+tZskRpJCC30VKkLBtOZUMSu2IY2vAJAXEy6OJL4owaiG5Ym359NCm2YhNCFenU2aW
	dQvGBFe2S0TC44ZUlzGXjbIIRJa7Yt2WWoR8aGLdwwEZIqKQGWqoCx+LzdmnTtfaHH0bd/
	2Il5lzQtMMQRMA3jd3eqdf61UQ7vB+Nz1tzlW2L069NKISZfGhO3jYWqOLZofQ==
From: mathieu.dubois-briand@bootlin.com
Date: Fri, 14 Feb 2025 12:49:52 +0100
Subject: [PATCH v4 02/10] mfd: Add max7360 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-mdb-max7360-support-v4-2-8a35c6dbb966@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=11127;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=eGMCWid0yMZTgPOBVWirLnrWY5N03FatifPs65pXIts=;
 b=qSSZJbN+EQIdnJ/qbC+KKVS/y+y1rmDCBNL7drRv2hQRVX87/KrqfCly+kfn6Qrywpw47GIj9
 LOb7A0Gl0YWBaKUTy5LvfPepQMkLIUyBx9r3aLTcl8EUIdakP+OWyAQ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmnecuggftrfgrthhtvghrnhepveehffetteetffeftedvleeltddttdfhvefhgfelheefvdevudduhfehudfgleegnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add core driver to support MAX7360 i2c chip, multi function device
with keypad, gpio, pwm, gpo and rotary encoder submodules.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/mfd/Kconfig         |  14 +++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/max7360.c       | 218 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max7360.h | 112 +++++++++++++++++++++++
 4 files changed, 345 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6b0682af6e32..ef02a1c4322c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2439,5 +2439,19 @@ config MFD_UPBOARD_FPGA
 	  To compile this driver as a module, choose M here: the module will be
 	  called upboard-fpga.
 
+config MFD_MAX7360
+	tristate "Maxim MAX7360 I2C IO Expander"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for Maxim MAX7360 device, embedding
+	  keypad, rotary encoder, PWM and GPIO features.
+
+	  This driver provides common support for accessing the device;
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9220eaf7cf12..db2bd232c150 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -163,6 +163,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
 obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
 
 obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
+obj-$(CONFIG_MFD_MAX7360)	+= max7360.o
 obj-$(CONFIG_MFD_MAX77541)	+= max77541.o
 obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
diff --git a/drivers/mfd/max7360.c b/drivers/mfd/max7360.c
new file mode 100644
index 000000000000..04ff8f5c811b
--- /dev/null
+++ b/drivers/mfd/max7360.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Maxim MAX7360 Core Driver
+ *
+ * Copyright (C) 2024 Kamel Bouhara
+ * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max7360.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static DEFINE_SPINLOCK(request_lock);
+
+struct max7360 {
+	struct device *dev;
+	struct regmap *regmap;
+	unsigned int requested_ports;
+};
+
+static const struct mfd_cell max7360_cells[] = {
+	{
+		.name           = "max7360-pwm",
+	},
+	{
+		.name           = "max7360-gpo",
+		.of_compatible	= "maxim,max7360-gpo",
+	},
+	{
+		.name           = "max7360-gpio",
+		.of_compatible	= "maxim,max7360-gpio",
+	},
+	{
+		.name           = "max7360-keypad",
+	},
+	{
+		.name           = "max7360-rotary",
+	},
+};
+
+static const struct regmap_range max7360_volatile_ranges[] = {
+	{
+		.range_min = MAX7360_REG_KEYFIFO,
+		.range_max = MAX7360_REG_KEYFIFO,
+	}, {
+		.range_min = 0x48,
+		.range_max = 0x4a,
+	},
+};
+
+static const struct regmap_access_table max7360_volatile_table = {
+	.yes_ranges = max7360_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max7360_volatile_ranges),
+};
+
+static const struct regmap_config max7360_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+	.volatile_table = &max7360_volatile_table,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+int max7360_port_pin_request(struct device *dev, unsigned int pin, bool request)
+{
+	struct i2c_client *client;
+	struct max7360 *max7360;
+	unsigned long flags;
+	int ret = 0;
+
+	client = to_i2c_client(dev);
+	max7360 = i2c_get_clientdata(client);
+
+	spin_lock_irqsave(&request_lock, flags);
+	if (request) {
+		if (max7360->requested_ports & BIT(pin))
+			ret = -EBUSY;
+		else
+			max7360->requested_ports |= BIT(pin);
+	} else {
+		max7360->requested_ports &= ~BIT(pin);
+	}
+	spin_unlock_irqrestore(&request_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(max7360_port_pin_request);
+
+static int max7360_mask_irqs(struct max7360 *max7360)
+{
+	unsigned int val;
+	int ret;
+
+	/*
+	 * GPIO/PWM interrupts are not masked on reset: mask the during probe,
+	 * avoiding repeated spurious interrupts if the corresponding drivers
+	 * are not present.
+	 */
+	for (int i = 0; i < MAX7360_PORT_PWM_COUNT; i++) {
+		ret = regmap_write_bits(max7360->regmap, MAX7360_REG_PWMCFG(i),
+					MAX7360_PORT_CFG_INTERRUPT_MASK,
+					MAX7360_PORT_CFG_INTERRUPT_MASK);
+		if (ret) {
+			dev_err(max7360->dev, "Failed to write max7360 port configuration");
+			return ret;
+		}
+	}
+
+	/* Read GPIO in register, to ACK any pending IRQ. */
+	ret = regmap_read(max7360->regmap, MAX7360_REG_GPIOIN, &val);
+	if (ret) {
+		dev_err(max7360->dev, "Failed to read gpio values: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max7360_reset(struct max7360 *max7360)
+{
+	int err;
+
+	err = regmap_write(max7360->regmap, MAX7360_REG_GPIOCFG,
+			   MAX7360_GPIO_CFG_GPIO_RST);
+	if (err) {
+		dev_err(max7360->dev, "Failed to reset GPIO configuration: %x\n", err);
+		return err;
+	}
+
+	err = regcache_drop_region(max7360->regmap, MAX7360_REG_GPIOCFG,
+				   MAX7360_REG_GPIO_LAST);
+	if (err) {
+		dev_err(max7360->dev, "Failed to drop regmap cache: %x\n", err);
+		return err;
+	}
+
+	err = regmap_write(max7360->regmap, MAX7360_REG_SLEEP, 0);
+	if (err) {
+		dev_err(max7360->dev, "Failed to reset autosleep configuration: %x\n", err);
+		return err;
+	}
+
+	err = regmap_write(max7360->regmap, MAX7360_REG_DEBOUNCE, 0);
+	if (err) {
+		dev_err(max7360->dev, "Failed to reset GPO port count: %x\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int max7360_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+	struct max7360 *max7360;
+	int err;
+
+	regmap = devm_regmap_init_i2c(client, &max7360_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialise regmap\n");
+
+	max7360 = devm_kzalloc(dev, sizeof(*max7360), GFP_KERNEL);
+	if (!max7360)
+		return -ENOMEM;
+
+	max7360->regmap = regmap;
+	max7360->dev = dev;
+	i2c_set_clientdata(client, max7360);
+
+	err = max7360_reset(max7360);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to reset device\n");
+
+	/* Get the device out of shutdown mode. */
+	err = regmap_write_bits(regmap, MAX7360_REG_GPIOCFG,
+				MAX7360_GPIO_CFG_GPIO_EN,
+				MAX7360_GPIO_CFG_GPIO_EN);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable GPIO and PWM module\n");
+
+	err = max7360_mask_irqs(max7360);
+	if (err)
+		return dev_err_probe(dev, err, "Could not mask interrupts\n");
+
+	err =  devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				    max7360_cells, ARRAY_SIZE(max7360_cells),
+				    NULL, 0, NULL);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register child devices\n");
+
+	return 0;
+}
+
+static const struct of_device_id max7360_dt_match[] = {
+	{ .compatible = "maxim,max7360" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, max7360_dt_match);
+
+static struct i2c_driver max7360_driver = {
+	.driver = {
+		.name = "max7360",
+		.of_match_table = max7360_dt_match,
+	},
+	.probe = max7360_probe,
+};
+module_i2c_driver(max7360_driver);
+
+MODULE_DESCRIPTION("Maxim MAX7360 I2C IO Expander core driver");
+MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max7360.h b/include/linux/mfd/max7360.h
new file mode 100644
index 000000000000..6beff7405d10
--- /dev/null
+++ b/include/linux/mfd/max7360.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_MFD_MAX7360_H
+#define __LINUX_MFD_MAX7360_H
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+
+#define MAX7360_MAX_KEY_ROWS	8
+#define MAX7360_MAX_KEY_COLS	8
+#define MAX7360_MAX_KEY_NUM	(MAX7360_MAX_KEY_ROWS * MAX7360_MAX_KEY_COLS)
+#define MAX7360_ROW_SHIFT	3
+
+#define MAX7360_MAX_GPIO 8
+#define MAX7360_MAX_GPO 6
+#define MAX7360_PORT_PWM_COUNT	8
+#define MAX7360_PORT_RTR_PIN	(MAX7360_PORT_PWM_COUNT - 1)
+
+/*
+ * MAX7360 registers
+ */
+#define MAX7360_REG_KEYFIFO	0x00
+#define MAX7360_REG_CONFIG	0x01
+#define MAX7360_REG_DEBOUNCE	0x02
+#define MAX7360_REG_INTERRUPT	0x03
+#define MAX7360_REG_PORTS	0x04
+#define MAX7360_REG_KEYREP	0x05
+#define MAX7360_REG_SLEEP	0x06
+
+/*
+ * MAX7360 GPIO registers
+ *
+ * All these registers are reset together when writing bit 3 of
+ * MAX7360_REG_GPIOCFG.
+ */
+#define MAX7360_REG_GPIOCFG	0x40
+#define MAX7360_REG_GPIOCTRL	0x41
+#define MAX7360_REG_GPIODEB	0x42
+#define MAX7360_REG_GPIOCURR	0x43
+#define MAX7360_REG_GPIOOUTM	0x44
+#define MAX7360_REG_PWMCOM	0x45
+#define MAX7360_REG_RTRCFG	0x46
+#define MAX7360_REG_GPIOIN	0x49
+#define MAX7360_REG_RTR_CNT	0x4A
+#define MAX7360_REG_PWMBASE	0x50
+#define MAX7360_REG_PWMCFGBASE	0x58
+
+#define MAX7360_REG_GPIO_LAST	0x5F
+
+#define MAX7360_REG_PWM(x)	(MAX7360_REG_PWMBASE + (x))
+#define MAX7360_REG_PWMCFG(x)	(MAX7360_REG_PWMCFGBASE + (x))
+
+/*
+ * Configuration register bits
+ */
+#define MAX7360_FIFO_EMPTY	0x3f
+#define MAX7360_FIFO_OVERFLOW	0x7f
+#define MAX7360_FIFO_RELEASE	BIT(6)
+#define MAX7360_FIFO_COL	GENMASK(5, 3)
+#define MAX7360_FIFO_ROW	GENMASK(2, 0)
+
+#define MAX7360_CFG_SLEEP	BIT(7)
+#define MAX7360_CFG_INTERRUPT	BIT(5)
+#define MAX7360_CFG_KEY_RELEASE	BIT(3)
+#define MAX7360_CFG_WAKEUP	BIT(1)
+#define MAX7360_CFG_TIMEOUT	BIT(0)
+
+#define MAX7360_DEBOUNCE	GENMASK(4, 0)
+#define MAX7360_DEBOUNCE_MIN	9
+#define MAX7360_DEBOUNCE_MAX	40
+#define MAX7360_PORTS		GENMASK(8, 5)
+
+#define MAX7360_INTERRUPT_TIME_MASK GENMASK(4, 0)
+#define MAX7360_INTERRUPT_FIFO_MASK GENMASK(7, 5)
+
+#define MAX7360_PORT_CFG_INTERRUPT_MASK BIT(7)
+#define MAX7360_PORT_CFG_INTERRUPT_EDGES BIT(6)
+
+#define MAX7360_REG_GPIOCURR_FIXED 0xC0
+
+/*
+ * Autosleep register values (ms)
+ */
+#define MAX7360_AUTOSLEEP_8192	0x01
+#define MAX7360_AUTOSLEEP_4096	0x02
+#define MAX7360_AUTOSLEEP_2048	0x03
+#define MAX7360_AUTOSLEEP_1024	0x04
+#define MAX7360_AUTOSLEEP_512	0x05
+#define MAX7360_AUTOSLEEP_256	0x06
+
+#define MAX7360_GPIO_CFG_RTR_EN		BIT(7)
+#define MAX7360_GPIO_CFG_GPIO_EN	BIT(4)
+#define MAX7360_GPIO_CFG_GPIO_RST	BIT(3)
+
+#define MAX7360_ROT_DEBOUNCE	GENMASK(3, 0)
+#define MAX7360_ROT_DEBOUNCE_MIN 0
+#define MAX7360_ROT_DEBOUNCE_MAX 15
+#define MAX7360_ROT_INTCNT	GENMASK(6, 4)
+#define MAX7360_ROT_INTCNT_DLY	BIT(7)
+
+#define MAX7360_INT_INTI	0
+#define MAX7360_INT_INTK	1
+
+#define MAX7360_INT_GPIO   0
+#define MAX7360_INT_KEYPAD 1
+#define MAX7360_INT_ROTARY 2
+
+#define MAX7360_NR_INTERNAL_IRQS	3
+
+int max7360_port_pin_request(struct device *dev, unsigned int pin, bool request);
+
+#endif

-- 
2.39.5


