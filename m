Return-Path: <linux-pwm+bounces-5503-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D7A8A1B6
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61EF19008FE
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4329B76C;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfeGtB6g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0E29C344;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728560; cv=none; b=ElIyXLznPQZveyfkj9xwc/Oks2KdriN+9O6V7sTZeMDkhsX7K/cbPhLt9tNhuB3BlGZXRxBY3r4fYm/jvmbh7i8c4CKzZTtTg8NJa38zgg2XrlQciMDEq0seNjYXGX1XuWVQNjsuWABCcXTifZPcyFVVEiy7CUJEytrCXPVflBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728560; c=relaxed/simple;
	bh=iVhgU6oV67ih93tinGJIsjkoppOG74W/wQwnUiQILTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPHBb3nWcHTzZBpu1RrArsfbWfBW4+wnsfJsA9C1kknXmlYPOD8C4tew4/19OvTyEvHpaq5XR4jXdSQ9vPh3QJ8yQ6CpEmaWfB1FJf+bHmz8UxuyDSsoVvHL0RqD3KN83b7WDFW6w5N4YxILYs6SmPLrhvWqfUjqLDfuenPsHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfeGtB6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB49DC4AF55;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728560;
	bh=iVhgU6oV67ih93tinGJIsjkoppOG74W/wQwnUiQILTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pfeGtB6gk6IsfWPp7d9uQnWQBO8EAFEj6QsSKn9Ic2ir02KMcj8rg10FRrXiuKUHx
	 tABbDwGS1+PZJBz1XXmDGDdllCqEc0VsgBo/Le586DkGZxmtPmQD1bqnrdRnY1ljWj
	 7WTXbIitfrE1OJjtrciHUcUxcDbh7qq7ztsrmgLJ0pusXhw0qRAQZzshyakS1k6GTi
	 pWb0qLwoJUNyXB0MTFWDMVQOtSiz+NDAZYuN4bQEr1GBUYE7hEL9ymS/kFprr2qXWb
	 ou73T3A4MvdozgDdWL9s8238paoGgxI0QJc57vabuOWxzTkmhuqnCZUlY7OH7q8ke9
	 Djpr5Z+yp1XLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1840C369C1;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:28 +0100
Subject: [PATCH v2 12/17] Input: adp5585: Add Analog Devices ADP5585/89
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-12-3a799c3ed812@analog.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728560; l=9142;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JrfKluLxDKtg4bj+oFHP0M300253piXuwv6kEF5DBpM=;
 b=COQk4keBOrfSXZhqmDZeHBwztsNoMNCCeFzExrYBgEucNIgly5MDsYz+f0Fn12/AvoOopW9QE
 ADUzuYSgHcoCzlePOj/KQ9BJEKsTBy6P03RtiI/JjfepwyzHJqV/F4y
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The ADP5585 is a 10/11 input/output port expander with a built in keypad
matrix decoder, programmable logic, reset generator, and PWM generator.
This driver supports the keyboard function using the platform device
registered by the core MFD driver.

The ADP5589 has 19 pins and also features an unlock function.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 MAINTAINERS                           |   1 +
 drivers/input/keyboard/Kconfig        |  11 ++
 drivers/input/keyboard/Makefile       |   1 +
 drivers/input/keyboard/adp5585-keys.c | 221 ++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5acf50fc6af4322dec0dad2169b46c6a1903e3c..48bd39a1a96d9c57145cf2560eec54248427fc89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -549,6 +549,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
 F:	drivers/gpio/gpio-adp5585.c
+F:	drivers/input/adp5585-keys.c
 F:	drivers/mfd/adp5585.c
 F:	drivers/pwm/pwm-adp5585.c
 F:	include/linux/mfd/adp5585.h
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 721ab69e84ac6586f4f19102890a15ca3fcf1910..322da0957067db77c7f66ab26a181d39c2c1d513 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -37,6 +37,17 @@ config KEYBOARD_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called adp5520-keys.
 
+config KEYBOARD_ADP5585
+	tristate "ADP5585 and similar  I2C QWERTY Keypad and IO Expanders"
+	depends on MFD_ADP5585
+	select INPUT_MATRIXKMAP
+	help
+	  This option enables support for the KEYMAP function found in the Analog
+	  Devices ADP5585 and similar devices.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adp5585-keys.
+
 config KEYBOARD_ADP5588
 	tristate "ADP5588/87 I2C QWERTY Keypad and IO Expander"
 	depends on I2C
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 1e0721c3070968a6339a42f65a95af48364f6897..f00ec003a59aa28577ae164c0539cc5aff9579fc 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -7,6 +7,7 @@
 
 obj-$(CONFIG_KEYBOARD_ADC)		+= adc-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
+obj-$(CONFIG_KEYBOARD_ADP5585)		+= adp5585-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5589)		+= adp5589-keys.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
diff --git a/drivers/input/keyboard/adp5585-keys.c b/drivers/input/keyboard/adp5585-keys.c
new file mode 100644
index 0000000000000000000000000000000000000000..93961a9e822f8b10b1bca526b9486eed4ad7f8f7
--- /dev/null
+++ b/drivers/input/keyboard/adp5585-keys.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices ADP5585 Keys driver
+ *
+ * Copyright (C) 2025 Analog Devices, Inc.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/device.h>
+#include <linux/find.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/mfd/adp5585.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+/* As needed for the matrix parsing code */
+#define ADP5589_MAX_KEYMAPSIZE		123
+
+struct adp5585_kpad {
+	struct input_dev *input;
+	unsigned short keycode[ADP5589_MAX_KEYMAPSIZE];
+	struct device *dev;
+	int row_shift;
+	u8 max_rows;
+	u8 max_cols;
+};
+
+static int adp5585_keys_parse_fw(const struct adp5585_dev *adp5585,
+				 struct adp5585_kpad *kpad)
+{
+	unsigned long row_map, col_map;
+	struct device *dev = kpad->dev;
+	u32 cols = 0, rows = 0;
+	int ret;
+
+	row_map = bitmap_read(adp5585->keypad, 0, kpad->max_rows);
+	col_map = bitmap_read(adp5585->keypad, kpad->max_rows, kpad->max_cols);
+	/*
+	 * Note that given that we get a mask (and the HW allows it), we
+	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
+	 * However, for the matrix parsing functions we need to pass the
+	 * number of rows/cols as the maximum row/col used plus 1. This
+	 * pretty much means we will also have holes in our SW keypad.
+	 */
+	if (!bitmap_empty(&row_map, kpad->max_rows))
+		rows = find_last_bit(&row_map, kpad->max_rows) + 1;
+	if (!bitmap_empty(&col_map, kpad->max_cols))
+		cols = find_last_bit(&col_map, kpad->max_cols) + 1;
+
+	if (!rows && !cols)
+		return dev_err_probe(dev, -EINVAL,
+				     "No rows or columns defined for the keypad\n");
+
+	if (cols && !rows)
+		return dev_err_probe(dev, -EINVAL,
+				     "Cannot have columns with no rows!\n");
+
+	if (rows && !cols)
+		return dev_err_probe(dev, -EINVAL,
+				     "Cannot have rows with no columns!\n");
+
+	ret = matrix_keypad_build_keymap(NULL, NULL, rows, cols,
+					 kpad->keycode, kpad->input);
+	if (ret)
+		return ret;
+
+	kpad->row_shift = get_count_order(cols);
+
+	if (device_property_present(kpad->dev, "autorepeat"))
+		__set_bit(EV_REP, kpad->input->evbit);
+
+	return 0;
+}
+
+static int adp5585_keys_setup(const struct adp5585_dev *adp5585,
+			      struct adp5585_kpad *kpad)
+{
+	unsigned long keys_bits, start = 0, nbits = kpad->max_rows;
+	const struct adp5585_regs *regs = adp5585->info->regs;
+	unsigned int i = 0, max_cols = kpad->max_cols;
+	int ret;
+
+	/*
+	 * Take care as the below assumes max_rows is always less or equal than
+	 * 8 which is true for the supported devices. If we happen to add
+	 * another device we need to make sure this still holds true. Although
+	 * adding a new device is very unlikely.
+	 */
+	do {
+		keys_bits = bitmap_read(adp5585->keypad, start, nbits);
+		if (keys_bits) {
+			ret = regmap_write(adp5585->regmap, regs->pin_cfg_a + i,
+					   keys_bits);
+			if (ret)
+				return ret;
+		}
+
+		start += nbits;
+		if (max_cols > 8) {
+			nbits = 8;
+			max_cols -= nbits;
+		} else {
+			nbits = max_cols;
+		}
+
+		i++;
+	} while (start < kpad->max_rows + kpad->max_cols);
+
+	return 0;
+}
+
+static void adp5585_keys_ev_handle(struct device *dev, unsigned int key,
+				   bool key_press)
+{
+	struct adp5585_kpad *kpad = dev_get_drvdata(dev);
+	unsigned int row, col, code;
+
+	row = (key - 1) / (kpad->max_cols);
+	col = (key - 1) % (kpad->max_cols);
+	code = MATRIX_SCAN_CODE(row, col, kpad->row_shift);
+
+	dev_dbg_ratelimited(kpad->dev, "report key(%d) r(%d) c(%d) code(%d)\n",
+			    key, row, col, kpad->keycode[code]);
+
+	input_report_key(kpad->input, kpad->keycode[code], key_press);
+	input_sync(kpad->input);
+}
+
+static void adp5585_keys_ev_handle_clean(void *adp5585)
+{
+	adp5585_keys_ev_handle_set(adp5585, NULL, NULL);
+}
+
+static int adp5585_keys_probe(struct platform_device *pdev)
+{
+	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct adp5585_kpad *kpad;
+	unsigned int revid;
+	const char *phys;
+	int ret;
+
+	kpad = devm_kzalloc(dev, sizeof(*kpad), GFP_KERNEL);
+	if (!kpad)
+		return -ENOMEM;
+
+	if (!adp5585->irq)
+		return dev_err_probe(dev, -EINVAL,
+				     "IRQ is mandatory for the keypad\n");
+
+	kpad->dev = dev;
+	kpad->max_cols = adp5585->info->max_cols;
+	kpad->max_rows = adp5585->info->max_rows;
+
+	kpad->input = devm_input_allocate_device(dev);
+	if (!kpad->input)
+		return -ENOMEM;
+
+	ret = regmap_read(adp5585->regmap, ADP5585_ID, &revid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read device ID\n");
+
+	phys = devm_kasprintf(dev, GFP_KERNEL, "%s/input0", pdev->name);
+	if (!phys)
+		return -ENOMEM;
+
+	kpad->input->name = pdev->name;
+	kpad->input->phys = phys;
+	kpad->input->dev.parent = dev;
+
+	input_set_drvdata(kpad->input, kpad);
+
+	kpad->input->id.bustype = BUS_I2C;
+	kpad->input->id.vendor = 0x0001;
+	kpad->input->id.product = 0x0001;
+	kpad->input->id.version = revid & ADP5585_REV_ID_MASK;
+
+	device_set_of_node_from_dev(dev, dev->parent);
+
+	ret = adp5585_keys_parse_fw(adp5585, kpad);
+	if (ret)
+		return ret;
+
+	ret = adp5585_keys_setup(adp5585, kpad);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, kpad);
+	adp5585_keys_ev_handle_set(adp5585, adp5585_keys_ev_handle, dev);
+	ret = devm_add_action_or_reset(dev, adp5585_keys_ev_handle_clean,
+				       adp5585);
+	if (ret)
+		return ret;
+
+	return input_register_device(kpad->input);
+}
+
+static const struct platform_device_id adp5585_keys_id_table[] = {
+	{ "adp5585-keys" },
+	{ "adp5589-keys" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, adp5585_keys_id_table);
+
+static struct platform_driver adp5585_keys_driver = {
+	.driver	= {
+		.name = "adp5585-keys",
+	},
+	.probe = adp5585_keys_probe,
+	.id_table = adp5585_keys_id_table,
+};
+module_platform_driver(adp5585_keys_driver);
+
+MODULE_AUTHOR("Nuno Sá <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("ADP5585 Keys Driver");
+MODULE_LICENSE("GPL");

-- 
2.49.0



