Return-Path: <linux-pwm+bounces-4407-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79FB9F7F73
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1735188894B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68522912F;
	Thu, 19 Dec 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VnR/ugfn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0B22654A;
	Thu, 19 Dec 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625321; cv=none; b=T4bHTohuKQhgHAXTYF42zkdrD0tue7AC63H+V8grdgtOAF5ZXMZHJyx73syGqgeEfnmRCkMOiiVDC4uTW2JxkuCwCLmiLvuooiGATwgGtS4CrkoOHlXzdsL2nRrCIYcjuPtjqh0ODB22HxXKyW/vMM+qyrMIMQI7WbBRZotYmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625321; c=relaxed/simple;
	bh=PybKAU+3vbndizy2H1sa0Lwsq0GbIx6ABnD6dcyNxWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6/eghu4LNOjAzGGqZxJ6UbsMmfmN8t93Xb2UNmLAjblVhKi17+JM4TFei8Uf1r9S2RqDIhLvLFdacuFr9HcEpxwEozZ9U5cJUhdMlE+t/4ON13YM6Fe9BicwoYd5wVja6UiE70rCFXLTJMzedo7eN7QznwrIv81XoZz5O8wIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VnR/ugfn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17CC860003;
	Thu, 19 Dec 2024 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734625310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfUnDdooPof7eT/RduRzy7XQjBZM7wassZexFE60gSM=;
	b=VnR/ugfn6rN534C0YR0r/IHcaaSBv/jjSiB9bRIs59IeKXwhQL1jLpFNXB6bpeN+t6QyoJ
	x3DIv/8mqQaP0145EOE76Nq+GCT6SjIft5r6F91veMA5BpaRGkW4+ceBjEZGIE5wGuJrIe
	wceRxdKeFl8AbiGOgBf5daiiWtJri+JIq7EZ8idY9WbocJRZ6uSTHghecWlSSTfl8GYV6h
	qqECafGYc4tZz3utgf11ZWyXrOQuk0Br5ghqbt5Dnjc2w+LV4x4x/7yCj7csRUQcM22o/1
	bA1qW9KkMFAoMHdo5cWRWY5mzWqSyPcKkUzXBAPzRU37d3Yw7hPKhD/kL/305g==
From: mathieu.dubois-briand@bootlin.com
Date: Thu, 19 Dec 2024 17:21:20 +0100
Subject: [PATCH 3/8] mfd: Add max7360 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-mdb-max7360-support-v1-3-8e8317584121@bootlin.com>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
In-Reply-To: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734625307; l=13201;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=doolHWPKXd7dXbLUCc0fkQ10pFTbxLhiIJPiEIXe1XE=;
 b=CUq0LgiAqO+36IuT9iQg8SzXZfxk5jm07J1sTSeTg1KF54oSIEoeNsvm53AhLWCA1rQxTIxx9
 sIKnzWw++8nBJ0vzGvMR/vZN9A+l82N8KLZTq1ydmbEoeJbmktp6rpr
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add core driver to support MAX7360 i2c chip, multi function device
with keypad, gpio, pwm, gpo and rotary encoder submodules.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/mfd/Kconfig         |  12 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/max7360.c       | 302 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max7360.h | 103 +++++++++++++++
 4 files changed, 418 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae23b317a64e..c1ddda480922 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2414,5 +2414,17 @@ config MFD_RSMU_SPI
 	  Additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_MAX7360
+	tristate "Maxim MAX7360 Support"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for Maxim MAX7360.
+	  This driver provides common support for accessing
+	  the device; additional drivers must be enabled in
+	  order to use the functionality of the device.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e057d6d6faef..6cd55504106d 100644
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
index 000000000000..c53b42f00a9d
--- /dev/null
+++ b/drivers/mfd/max7360.c
@@ -0,0 +1,302 @@
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
+struct max7360_mfd {
+	struct regmap *regmap;
+	unsigned int requested_ports;
+	struct device *dev;
+};
+
+#define GPO_COMPATIBLE "maxim,max7360-gpo"
+#define KEYPAD_COMPATIBLE "maxim,max7360-keypad"
+
+static const struct mfd_cell max7360_cells[] = {
+	{
+		.name           = "max7360-pwm",
+		.of_compatible	= "maxim,max7360-pwm",
+	},
+	{
+		.name           = "max7360-gpo",
+		.of_compatible	= GPO_COMPATIBLE,
+	},
+	{
+		.name           = "max7360-gpio",
+		.of_compatible	= "maxim,max7360-gpio",
+	},
+	{
+		.name           = "max7360-keypad",
+		.of_compatible	= KEYPAD_COMPATIBLE,
+	},
+	{
+		.name           = "max7360-rotary",
+		.of_compatible	= "maxim,max7360-rotary",
+	},
+};
+
+const struct regmap_range max7360_volatile_ranges[] = {
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
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int max7360_set_gpos_count(struct max7360_mfd *max7360_mfd)
+{
+	/*
+	 * Max7360 COL0 to COL7 pins can be used either as keypad columns,
+	 * general purpose output or a mix of both.
+	 * Get the number of pins requested by the corresponding drivers, ensure
+	 * they are compatible with each others and apply the corresponding
+	 * configuration.
+	 */
+	struct device_node *np;
+	u32 gpos = 0;
+	u32 columns = 0;
+	unsigned int val;
+	int ret;
+
+	np = of_get_compatible_child(max7360_mfd->dev->of_node, GPO_COMPATIBLE);
+	if (np) {
+		ret = of_property_read_u32(np, "ngpios", &gpos);
+		if (ret < 0) {
+			dev_err(max7360_mfd->dev, "Failed to read gpos count\n");
+			return ret;
+		}
+	}
+
+	np = of_get_compatible_child(max7360_mfd->dev->of_node,
+				     KEYPAD_COMPATIBLE);
+	if (np) {
+		ret = of_property_read_u32(np, "keypad,num-columns", &columns);
+		if (ret < 0) {
+			dev_err(max7360_mfd->dev, "Failed to read columns count\n");
+			return ret;
+		}
+	}
+
+	if (gpos > MAX7360_MAX_GPO ||
+	    (gpos + columns > MAX7360_MAX_KEY_COLS)) {
+		dev_err(max7360_mfd->dev,
+			"Incompatible gpos and columns count (%u, %u)\n",
+			gpos, columns);
+		return -EINVAL;
+	}
+
+	/*
+	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad debounce
+	 * timings and gpos/keypad columns repartition. Only the later is
+	 * modified here.
+	 */
+	val = FIELD_PREP(MAX7360_PORTS, gpos);
+	ret = regmap_write_bits(max7360_mfd->regmap, MAX7360_REG_DEBOUNCE,
+				MAX7360_PORTS, val);
+	if (ret) {
+		dev_err(max7360_mfd->dev,
+			"Failed to write max7360 columns/gpos configuration");
+		return ret;
+	}
+
+	return 0;
+}
+
+int max7360_port_pin_request(struct device *dev, unsigned int pin, bool request)
+{
+	struct i2c_client *client;
+	struct max7360_mfd *max7360_mfd;
+	unsigned long flags;
+	int ret = 0;
+
+	client = to_i2c_client(dev);
+	max7360_mfd = i2c_get_clientdata(client);
+
+	spin_lock_irqsave(&request_lock, flags);
+	if (request) {
+		if (max7360_mfd->requested_ports & BIT(pin))
+			ret = -EBUSY;
+		else
+			max7360_mfd->requested_ports |= BIT(pin);
+	} else {
+		max7360_mfd->requested_ports &= ~BIT(pin);
+	}
+	spin_unlock_irqrestore(&request_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(max7360_port_pin_request);
+
+static int max7360_mask_irqs(struct max7360_mfd *max7360_mfd)
+{
+	unsigned int i;
+	unsigned int val;
+	int ret;
+
+	/*
+	 * GPIO/PWM interrupts are not masked on reset: mask the during probe,
+	 * avoiding repeated spurious interrupts if the corresponding drivers
+	 * are not present.
+	 */
+	for (i = 0; i < MAX7360_PORT_PWM_COUNT; i++) {
+		ret = regmap_write_bits(max7360_mfd->regmap,
+					MAX7360_REG_PWMCFG + i,
+					MAX7360_PORT_CFG_INTERRUPT_MASK,
+					MAX7360_PORT_CFG_INTERRUPT_MASK);
+		if (ret) {
+			dev_err(max7360_mfd->dev,
+				"failed to write max7360 port configuration");
+			return ret;
+		}
+	}
+
+	/* Read gpio in register, to ack any pending IRQ.
+	 */
+	ret = regmap_read(max7360_mfd->regmap, MAX7360_REG_GPIOIN, &val);
+	if (ret) {
+		dev_err(max7360_mfd->dev, "Failed to read gpio values: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max7360_reset(struct max7360_mfd *max7360_mfd)
+{
+	int err;
+
+	/*
+	 * Set back the default values.
+	 * We do not use GPIO reset function here, as it does not work reliably.
+	 */
+	err = regmap_write(max7360_mfd->regmap, MAX7360_REG_GPIODEB, 0x00);
+	if (err) {
+		dev_err(max7360_mfd->dev, "Failed to set configuration\n");
+		return err;
+	}
+
+	err = regmap_write(max7360_mfd->regmap, MAX7360_REG_GPIOCURR, MAX7360_REG_GPIOCURR_FIXED);
+	if (err) {
+		dev_err(max7360_mfd->dev, "Failed to set configuration\n");
+		return err;
+	}
+
+	err = regmap_write(max7360_mfd->regmap, MAX7360_REG_GPIOOUTM, 0x00);
+	if (err) {
+		dev_err(max7360_mfd->dev, "Failed to set configuration\n");
+		return err;
+	}
+
+	err = regmap_write(max7360_mfd->regmap, MAX7360_REG_PWMCOM, 0x00);
+	if (err) {
+		dev_err(max7360_mfd->dev, "Failed to set configuration\n");
+		return err;
+	}
+
+	err = regmap_write(max7360_mfd->regmap, MAX7360_REG_SLEEP, 0);
+	if (err) {
+		dev_err(max7360_mfd->dev, "Failed to set configuration\n");
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
+	struct max7360_mfd *max7360_mfd;
+	int err;
+
+	regmap = devm_regmap_init_i2c(client, &max7360_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialise regmap\n");
+
+	max7360_mfd = devm_kzalloc(dev, sizeof(*max7360_mfd), GFP_KERNEL);
+	if (!max7360_mfd)
+		return -ENOMEM;
+
+	max7360_mfd->regmap = regmap;
+	max7360_mfd->dev = dev;
+	i2c_set_clientdata(client, max7360_mfd);
+
+	err = max7360_reset(max7360_mfd);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to reset device\n");
+
+	err = max7360_set_gpos_count(max7360_mfd);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to set GPOS pin count\n");
+
+	/*
+	 * Get the device out of shutdown mode.
+	 */
+	err = regmap_write_bits(regmap, MAX7360_REG_GPIOCFG,
+				MAX7360_GPIO_CFG_GPIO_EN,
+				MAX7360_GPIO_CFG_GPIO_EN);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to set device out of shutdown\n");
+
+	err = max7360_mask_irqs(max7360_mfd);
+	if (err)
+		return dev_err_probe(dev, err, "could not mask interrupts\n");
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
+MODULE_DESCRIPTION("Maxim MAX7360 MFD core driver");
+MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max7360.h b/include/linux/mfd/max7360.h
new file mode 100644
index 000000000000..2b77110acd80
--- /dev/null
+++ b/include/linux/mfd/max7360.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_MFD_MAX7360_H
+#define __LINUX_MFD_MAX7360_H
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
+ * MAX7360 registers
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
+#define MAX7360_REG_PWMCFG	0x58
+
+#define MAX7360_REG_PORTCFGBASE 0x58
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


