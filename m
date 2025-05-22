Return-Path: <linux-pwm+bounces-6076-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C1FAC0B21
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A8A1895B56
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB128A71F;
	Thu, 22 May 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WAaSN1K5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21608289E35;
	Thu, 22 May 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915609; cv=none; b=uMVDZoSdblotiD+UI5jvZ0VVBFb4g2hPMfffzmbhKSG2qx1Ov3wSuXNTx2kSVJYHG5XvWNmhekqh3aGwfMlUIv1KDlSEZnN2Ll6rZrMjnx+FOvtofgUbzbfJs8NcvN+LH7nlZi0AhzRPKizsNyuE/h/X5BMa7WQZTbSugEYuEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915609; c=relaxed/simple;
	bh=+akmWLW9op4JgcAuyMt43ym335BurNgd31VfijKCylU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cf08Ra5GyYpnQ7mRgjTjd0iDPVHs3eWFioIpn/kPqk/xd4U1ukefzBwis3pT94rBM23poeVagWontWUaBDrFJl28kxKDpGOuZ+7QQfqzgUlG5LYrdiAnQnL/1S60N9fg+91VQqUvqgmRYiPXIEVOByv6akMEXIqFxngCX6qqLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WAaSN1K5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BD761FCF3;
	Thu, 22 May 2025 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747915605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ez+JrwG7KQaKCryUKW2Ux1EEekY5LyIMC3ab9jmtyTA=;
	b=WAaSN1K5avokAdNhiKr2y088bxS679O/CyuptTMkNsAr6hs4ZnTuUKwWFKkqE4g+Hu7drX
	MsWMxdhCdyOruYyvvCk+Qo6Sk6x9IsXIxp3r+YoX569/zj1ldSSjFnvszt++yxyAqy6DBX
	PWELSF7V4aozhkdj0a5mcQo8ZRA4VVP3m+KmXAt6eJaFqQmS6SGrSjBrfYAwDDlYACD5Lh
	X4Rt8EkMTi3TGUy2Hj1cHyeN2k/wAjSeHwakByhd79mhrWgUj4kH5x+8e95Ik29X/JD01N
	uEY99z4gNuv1ZRn0O2hxcFlspM36CiKVGO9HrQnxrMIJT9lnjlHfd+0jaq/8sQ==
From: mathieu.dubois-briand@bootlin.com
Date: Thu, 22 May 2025 14:06:17 +0200
Subject: [PATCH v9 02/11] mfd: Add max7360 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-mdb-max7360-support-v9-2-74fc03517e41@bootlin.com>
References: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
In-Reply-To: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747915601; l=10501;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=GIupl4p/k0jiBxoYEh+9yxR2yubWSq+A0Aa6KSuoV/k=;
 b=IVTj5lraF9IyTaPG2KMn+7lucdNtOzEkrHWWQ9RfD4/B3n1yUMOHWG/FzPyQHkHsEmf45k9I7
 i6BhEyzBGgJDMtV9Vg4fQhnj/r6vGfoLyLV05kEC33/0MXTKOo0V3lV
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehleduucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhenucggtffrrghtthgvrhhnpeevheffteettefffeetvdelledttddthfevhffgleehfedvveduudfhhedugfelgeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhto
 hepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add core driver to support MAX7360 i2c chip, multi function device
with keypad, GPIO, PWM, GPO and rotary encoder submodules.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/mfd/Kconfig         |  14 ++++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/max7360.c       | 171 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max7360.h | 109 ++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 22b936310039..c2998c6ce54c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2422,5 +2422,19 @@ config MFD_UPBOARD_FPGA
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
index 948cbdf42a18..add9ff58eb25 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -162,6 +162,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
 obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
 
 obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
+obj-$(CONFIG_MFD_MAX7360)	+= max7360.o
 obj-$(CONFIG_MFD_MAX77541)	+= max77541.o
 obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
diff --git a/drivers/mfd/max7360.c b/drivers/mfd/max7360.c
new file mode 100644
index 000000000000..5ee459c490ec
--- /dev/null
+++ b/drivers/mfd/max7360.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Maxim MAX7360 Core Driver
+ *
+ * Copyright 2025 Bootlin
+ *
+ * Authors:
+ *    Kamel Bouhara <kamel.bouhara@bootlin.com>
+ *    Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device/devres.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max7360.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+static const struct mfd_cell max7360_cells[] = {
+	{ .name           = "max7360-pinctrl" },
+	{ .name           = "max7360-pwm" },
+	{ .name           = "max7360-keypad" },
+	{ .name           = "max7360-rotary" },
+	{
+		.name           = "max7360-gpo",
+		.of_compatible	= "maxim,max7360-gpo",
+	},
+	{
+		.name           = "max7360-gpio",
+		.of_compatible	= "maxim,max7360-gpio",
+	},
+};
+
+static const struct regmap_range max7360_volatile_ranges[] = {
+	regmap_reg_range(MAX7360_REG_KEYFIFO, MAX7360_REG_KEYFIFO),
+	regmap_reg_range(MAX7360_REG_I2C_TIMEOUT, MAX7360_REG_RTR_CNT),
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
+	.max_register = MAX7360_REG_PWMCFG(MAX7360_PORT_PWM_COUNT - 1),
+	.volatile_table = &max7360_volatile_table,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int max7360_mask_irqs(struct regmap *regmap)
+{
+	struct device *dev = regmap_get_device(regmap);
+	unsigned int val;
+	int ret;
+
+	/*
+	 * GPIO/PWM interrupts are not masked on reset: as the MAX7360 "INTI"
+	 * interrupt line is shared between GPIOs and rotary encoder, this could
+	 * result in repeated spurious interrupts on the rotary encoder driver
+	 * if the GPIO driver is not loaded. Mask them now to avoid this
+	 * situation.
+	 */
+	for (unsigned int i = 0; i < MAX7360_PORT_PWM_COUNT; i++) {
+		ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
+					MAX7360_PORT_CFG_INTERRUPT_MASK,
+					MAX7360_PORT_CFG_INTERRUPT_MASK);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to write MAX7360 port configuration\n");
+	}
+
+	/* Read GPIO in register, to ACK any pending IRQ. */
+	ret = regmap_read(regmap, MAX7360_REG_GPIOIN, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read GPIO values\n");
+
+	return 0;
+}
+
+static int max7360_reset(struct regmap *regmap)
+{
+	struct device *dev = regmap_get_device(regmap);
+	int ret;
+
+	ret = regmap_write(regmap, MAX7360_REG_GPIOCFG, MAX7360_GPIO_CFG_GPIO_RST);
+	if (ret) {
+		dev_err(dev, "Failed to reset GPIO configuration: %x\n", ret);
+		return ret;
+	}
+
+	ret = regcache_drop_region(regmap, MAX7360_REG_GPIOCFG, MAX7360_REG_GPIO_LAST);
+	if (ret) {
+		dev_err(dev, "Failed to drop regmap cache: %x\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(regmap, MAX7360_REG_SLEEP, 0);
+	if (ret) {
+		dev_err(dev, "Failed to reset autosleep configuration: %x\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(regmap, MAX7360_REG_DEBOUNCE, 0);
+	if (ret)
+		dev_err(dev, "Failed to reset GPO port count: %x\n", ret);
+
+	return ret;
+}
+
+static int max7360_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &max7360_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to initialise regmap\n");
+
+	ret = max7360_reset(regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset device\n");
+
+	/* Get the device out of shutdown mode. */
+	ret = regmap_write_bits(regmap, MAX7360_REG_GPIOCFG,
+				MAX7360_GPIO_CFG_GPIO_EN,
+				MAX7360_GPIO_CFG_GPIO_EN);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable GPIO and PWM module\n");
+
+	ret = max7360_mask_irqs(regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not mask interrupts\n");
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   max7360_cells, ARRAY_SIZE(max7360_cells),
+				   NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register child devices\n");
+
+	return 0;
+}
+
+static const struct of_device_id max7360_dt_match[] = {
+	{ .compatible = "maxim,max7360" },
+	{}
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
index 000000000000..44cf2bf651a2
--- /dev/null
+++ b/include/linux/mfd/max7360.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_MFD_MAX7360_H
+#define __LINUX_MFD_MAX7360_H
+
+#include <linux/bits.h>
+
+#define MAX7360_MAX_KEY_ROWS		8
+#define MAX7360_MAX_KEY_COLS		8
+#define MAX7360_MAX_KEY_NUM		(MAX7360_MAX_KEY_ROWS * MAX7360_MAX_KEY_COLS)
+#define MAX7360_ROW_SHIFT		3
+
+#define MAX7360_MAX_GPIO		8
+#define MAX7360_MAX_GPO			6
+#define MAX7360_PORT_PWM_COUNT		8
+#define MAX7360_PORT_RTR_PIN		(MAX7360_PORT_PWM_COUNT - 1)
+
+/*
+ * MAX7360 registers
+ */
+#define MAX7360_REG_KEYFIFO		0x00
+#define MAX7360_REG_CONFIG		0x01
+#define MAX7360_REG_DEBOUNCE		0x02
+#define MAX7360_REG_INTERRUPT		0x03
+#define MAX7360_REG_PORTS		0x04
+#define MAX7360_REG_KEYREP		0x05
+#define MAX7360_REG_SLEEP		0x06
+
+/*
+ * MAX7360 GPIO registers
+ *
+ * All these registers are reset together when writing bit 3 of
+ * MAX7360_REG_GPIOCFG.
+ */
+#define MAX7360_REG_GPIOCFG		0x40
+#define MAX7360_REG_GPIOCTRL		0x41
+#define MAX7360_REG_GPIODEB		0x42
+#define MAX7360_REG_GPIOCURR		0x43
+#define MAX7360_REG_GPIOOUTM		0x44
+#define MAX7360_REG_PWMCOM		0x45
+#define MAX7360_REG_RTRCFG		0x46
+#define MAX7360_REG_I2C_TIMEOUT		0x48
+#define MAX7360_REG_GPIOIN		0x49
+#define MAX7360_REG_RTR_CNT		0x4A
+#define MAX7360_REG_PWMBASE		0x50
+#define MAX7360_REG_PWMCFGBASE		0x58
+
+#define MAX7360_REG_GPIO_LAST		0x5F
+
+#define MAX7360_REG_PWM(x)		(MAX7360_REG_PWMBASE + (x))
+#define MAX7360_REG_PWMCFG(x)		(MAX7360_REG_PWMCFGBASE + (x))
+
+/*
+ * Configuration register bits
+ */
+#define MAX7360_FIFO_EMPTY		0x3F
+#define MAX7360_FIFO_OVERFLOW		0x7F
+#define MAX7360_FIFO_RELEASE		BIT(6)
+#define MAX7360_FIFO_COL		GENMASK(5, 3)
+#define MAX7360_FIFO_ROW		GENMASK(2, 0)
+
+#define MAX7360_CFG_SLEEP		BIT(7)
+#define MAX7360_CFG_INTERRUPT		BIT(5)
+#define MAX7360_CFG_KEY_RELEASE		BIT(3)
+#define MAX7360_CFG_WAKEUP		BIT(1)
+#define MAX7360_CFG_TIMEOUT		BIT(0)
+
+#define MAX7360_DEBOUNCE		GENMASK(4, 0)
+#define MAX7360_DEBOUNCE_MIN		9
+#define MAX7360_DEBOUNCE_MAX		40
+#define MAX7360_PORTS			GENMASK(8, 5)
+
+#define MAX7360_INTERRUPT_TIME_MASK	GENMASK(4, 0)
+#define MAX7360_INTERRUPT_FIFO_MASK	GENMASK(7, 5)
+
+#define MAX7360_PORT_CFG_INTERRUPT_MASK		BIT(7)
+#define MAX7360_PORT_CFG_INTERRUPT_EDGES	BIT(6)
+#define MAX7360_PORT_CFG_COMMON_PWM		BIT(5)
+
+/*
+ * Autosleep register values
+ */
+#define MAX7360_AUTOSLEEP_8192MS	0x01
+#define MAX7360_AUTOSLEEP_4096MS	0x02
+#define MAX7360_AUTOSLEEP_2048MS	0x03
+#define MAX7360_AUTOSLEEP_1024MS	0x04
+#define MAX7360_AUTOSLEEP_512MS		0x05
+#define MAX7360_AUTOSLEEP_256MS		0x06
+
+#define MAX7360_GPIO_CFG_RTR_EN		BIT(7)
+#define MAX7360_GPIO_CFG_GPIO_EN	BIT(4)
+#define MAX7360_GPIO_CFG_GPIO_RST	BIT(3)
+
+#define MAX7360_ROT_DEBOUNCE		GENMASK(3, 0)
+#define MAX7360_ROT_DEBOUNCE_MIN	0
+#define MAX7360_ROT_DEBOUNCE_MAX	15
+#define MAX7360_ROT_INTCNT		GENMASK(6, 4)
+#define MAX7360_ROT_INTCNT_DLY		BIT(7)
+
+#define MAX7360_INT_INTI		0
+#define MAX7360_INT_INTK		1
+
+#define MAX7360_INT_GPIO		0
+#define MAX7360_INT_KEYPAD		1
+#define MAX7360_INT_ROTARY		2
+
+#define MAX7360_NR_INTERNAL_IRQS	3
+
+#endif

-- 
2.39.5


