Return-Path: <linux-pwm+bounces-5163-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327CA5F7A9
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17303420C70
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4A268FD0;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAlsL51Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE7268C7F;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=RNXF5IM52kn0ggLxaGJ9J0CR5Wp2HLqpmFo8Mbj7h5Zm5WNQSh6hKpp4+FjWrOzfPqixPfOJBPUD32+ZlNtaKhRouAvMbM6nV85dZ6PK+lNwoSvYEPEcrdRUYCRv4yj5PtOsTDoIB8P00pnFBalJ7sDbsFvZ0Ncx0+ztmjU6mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=7tls/dbZLtpEqzrMx1gGjWfMhZOgychxmGds7O6hznY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sd9w2iJGPhdhOyfTnjJSXZB3iF2eT6c3/tLK7QKXorl3YG894yIRz5YpiHKOvqQ32n4ijeeBw9FbQzGVCwtmm7UphfeQkCui15udXnkKA7J+yfURW6ZAVY2OUy7hzr3noKXzINzNZObgG4lt0Iv+ladDb7E2mxsqPO8vtc9IQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAlsL51Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F728C4AF54;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=7tls/dbZLtpEqzrMx1gGjWfMhZOgychxmGds7O6hznY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aAlsL51QLzqn7d2ryzrUNcR4fWz1KlhSDksiSyqCGtWEPolsv7Pp66tb+fsH4LkkX
	 tCevhSiGZvljWdgmXsLXuEpdzMvCrD9LZdk+XLrbBd+621/mOmO+JpWNrah+OzbkvI
	 fmMhih5UDBQFWSgyIgccPVDZkodrKVU43K4SYad92NUQv1n8dPLbi4aS4z+AZkY7bt
	 nipfNuNeZuZD8PRTVIkn4RGxi1ZUrYFwgOyjQQ72P+SU791A6oKssATOUbbr2EB3yf
	 Z9JEOkbBOblfXmGusY0Wn1H6edtlocRy6BxQOmkGCYLf8MnBIc0VKmbKhN4dAICfag
	 fOO7f5RLmE6lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9AC282DE;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:29 +0000
Subject: [PATCH 12/18] Input: adp5585: Add Analog Devices ADP5585/89
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-12-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=9142;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=F4e8yqUhSMjQO6ishzh/MCwUFayQhIqzfoE+Wv1l4n4=;
 b=I4UwMEVGLiteHGMCq1ySGA3ukZxME7fv63p79XouLVkuzjJxcvx1+c0Ko9UT0N63QpwkiORrU
 qZMfQ4Pxw7nC1BcrJfSjFXqqrRbcPL+FULpqpHo6tNBaMsM1ehK89zB
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
index 74964ea4e18794884db68b7a741426d2892f4274..e4afef16ae832a08301dbc81866dfc3a70b06910 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ L:	linux-pwm@vger.kernel.org
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
2.48.1



