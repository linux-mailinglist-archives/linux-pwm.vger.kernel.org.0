Return-Path: <linux-pwm+bounces-6058-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B4ABF551
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB45C7A69B7
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A505F27978E;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTL3C+0i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B62AE90;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=L4+PUCFBTWjfcwIueJqPQCnXEHUYkpipJRuyCJrJ2+E1SExovyA0PSpM/DUhtr0Ege2qQmJ9uynlFWILgPoXkzMNdEm3eAKcanI3kIq9RjyZZA6XY8Xk/Sv8uA1X5M3Nz1v9YLy+YJb6+lEfkT4EythgVRQM5MwhUQa/S690fxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=gJ/fkn6UgWiBmXBCFBdVJu8hc+IpRaY6WBVn0Jh6JAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6KZYvR6Cx5O7/opfNN3adQSjBfOPvjpJK7nh5Jk3wqUNmr53TJFrPktUzj06SVDyloXKNH7ynwNPcsNUm9Y3nuae6k8LJWP0+wMMZFNXmvwYCkgHiHEhRa8ixe64iIyinvhCDkpJZRqKt/N3iM/i/nWtVjeux/IT7fWsRHKkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTL3C+0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CA41C4CEFA;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832589;
	bh=gJ/fkn6UgWiBmXBCFBdVJu8hc+IpRaY6WBVn0Jh6JAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aTL3C+0iNGNxz7n3+PNfXcVTy7dSgN68Shz73nfY+0bZP24pCQBcMtvPNKpN5sy+k
	 LQ+yDCwPVY0aUqrRwfcwS5i190w2l5rKhMJepqbYYl0qeqE1okg8eAxcoeOjbsODxv
	 /HeE+q+lWUcp5+lfVd+FzsAgN+O/oH2NU2KPTJzx+2waE1I4y5PlPrCpCwRp8LCptj
	 ad/HtkBwJxmw076m/Bni3zCvTp/pKJVvutk2egCaQngP8dTJwwiMQDQxKjtR/dq9QC
	 yb3x3RcvMm+zUMnH+fmjWDmqTWR+eX0buYJWd/gczVxCZolnoUGMvzBHTcJYynPjwu
	 nm+Msb3K5ExRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD6C3ABC9;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:03:06 +0100
Subject: [PATCH v4 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-16-f2c988d7a7a0@analog.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
In-Reply-To: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=13651;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=LOe+7NPr9pPIP5PTIvjO/QeeS3bFdHFC5ZIwq0fLO5I=;
 b=cHRGNCEQ8d+v8kAnOdfpmCs7HhAZumwoEw0rCLhabqeimmmM4N7eeKDb+90GAHDJF+L5FIRr8
 T3S9vQraFhYA5WKGDhO6yJIaWd0vpnZZCo6if6YsgJi7XzndsKWNDjd
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
 drivers/input/keyboard/Kconfig        |  11 +
 drivers/input/keyboard/Makefile       |   1 +
 drivers/input/keyboard/adp5585-keys.c | 371 ++++++++++++++++++++++++++++++++++
 4 files changed, 384 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0737dcb2e41119426f1d8fbaec829cc90ed0bf64..18838ba19e5edbbe352a470c4e177c6d24136d83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -550,6 +550,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
 F:	drivers/gpio/gpio-adp5585.c
+F:	drivers/input/keyboard/adp5585-keys.c
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
index 0000000000000000000000000000000000000000..e7ace33a320dd7685deb4e06bf593df16f3f6337
--- /dev/null
+++ b/drivers/input/keyboard/adp5585-keys.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices ADP5585 Keys driver
+ *
+ * Copyright (C) 2025 Analog Devices, Inc.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/find.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/mfd/adp5585.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+/* As needed for the matrix parsing code */
+#define ADP5589_MAX_KEYMAPSIZE		123
+
+struct adp5585_kpad_chip {
+	u8 key_ev_min;
+	u8 key_ev_max;
+	u8 max_rows;
+	u8 max_cols;
+};
+
+struct adp5585_kpad {
+	const struct adp5585_kpad_chip *info;
+	struct notifier_block nb;
+	struct input_dev *input;
+	unsigned short keycode[ADP5589_MAX_KEYMAPSIZE];
+	struct device *dev;
+	unsigned long keypad;
+	int row_shift;
+};
+
+static int adp5585_keys_validate_events(const struct adp5585_kpad *kpad,
+					const u32 *events, u32 n_events)
+{
+	unsigned int ev;
+	u32 row, col;
+
+	for (ev = 0; ev < n_events; ev++) {
+		if (events[ev] < kpad->info->key_ev_min ||
+		    events[ev] > kpad->info->key_ev_max)
+			continue;
+
+		/*
+		 * if the event is to be generated by the keymap, we need to make
+		 * sure that the pins are part of it!
+		 */
+		row = (events[ev] - 1) / kpad->info->max_cols;
+		col = (events[ev] - 1) % kpad->info->max_cols;
+
+		if (test_bit(row, &kpad->keypad) &&
+		    test_bit(col + kpad->info->max_rows, &kpad->keypad))
+			continue;
+
+		return dev_err_probe(kpad->dev, -EINVAL,
+				     "Invalid unlock/reset event(%u) not used in the keypad\n",
+				     events[ev]);
+	}
+
+	return 0;
+}
+
+static int adp5585_keys_check_special_events(const struct adp5585_dev *adp5585,
+					     const struct adp5585_kpad *kpad)
+{
+	int error;
+
+	error = adp5585_keys_validate_events(kpad, adp5585->unlock_keys,
+					     adp5585->nkeys_unlock);
+	if (error)
+		return error;
+
+	error = adp5585_keys_validate_events(kpad, adp5585->reset1_keys,
+					     adp5585->nkeys_reset1);
+	if (error)
+		return error;
+
+	return adp5585_keys_validate_events(kpad, adp5585->reset2_keys,
+					    adp5585->nkeys_reset2);
+}
+
+static void adp5585_keys_pins_free(void *data)
+{
+	struct adp5585_kpad *kpad = data;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(kpad->dev->parent);
+	unsigned int pin;
+
+	for_each_set_bit(pin, &kpad->keypad, adp5585->n_pins)
+		clear_bit(pin, adp5585->pin_usage);
+}
+
+static int adp5585_keys_parse_fw(const struct adp5585_dev *adp5585,
+				 struct adp5585_kpad *kpad)
+{
+	struct device *dev = kpad->dev;
+	u32 cols = 0, rows = 0, pin;
+	int error, n_pins;
+
+	/*
+	 * We do not check for errors (or no value) since the input device is
+	 * only added if this property is present in the first place.
+	 */
+	n_pins = device_property_count_u32(dev, "adi,keypad-pins");
+	if (n_pins > adp5585->n_pins)
+		return dev_err_probe(dev, -EINVAL,
+				     "Too many keypad pins (%d) defined (max=%d)\n",
+				     n_pins, adp5585->n_pins);
+
+	unsigned int *keypad_pins __free(kfree) = kcalloc(n_pins, sizeof(*keypad_pins),
+							  GFP_KERNEL);
+	if (!keypad_pins)
+		return -ENOMEM;
+
+	error = device_property_read_u32_array(dev, "adi,keypad-pins",
+					       keypad_pins, n_pins);
+	if (error)
+		return error;
+
+	/*
+	 * We can add the action here since it makes the code easier and nothing
+	 * "bad" will happen out of it. Worst case, it will be a no-op and no
+	 * bit will set.
+	 */
+	error = devm_add_action_or_reset(dev, adp5585_keys_pins_free, kpad);
+	if (error)
+		return error;
+
+	for (pin = 0; pin < n_pins; pin++) {
+		if (keypad_pins[pin] >= adp5585->n_pins)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid keypad pin(%u) defined\n",
+					     keypad_pins[pin]);
+
+		if (test_and_set_bit(keypad_pins[pin], adp5585->pin_usage))
+			return dev_err_probe(dev, -EBUSY,
+					     "Keypad pin(%u) already used\n",
+					     keypad_pins[pin]);
+
+		__set_bit(keypad_pins[pin], &kpad->keypad);
+	}
+
+	/*
+	 * Note that given that we get a mask (and the HW allows it), we
+	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
+	 * However, for the matrix parsing functions we need to pass the
+	 * number of rows/cols as the maximum row/col used plus 1. This
+	 * pretty much means we will also have holes in our SW keypad.
+	 */
+
+	rows = find_last_bit(&kpad->keypad, kpad->info->max_rows) + 1;
+	if (rows == kpad->info->max_rows + 1)
+		return dev_err_probe(dev, -EINVAL,
+				     "Now rows defined in the keypad!\n");
+
+	cols = find_last_bit(&kpad->keypad, kpad->info->max_cols + kpad->info->max_rows);
+	if (cols < kpad->info->max_rows)
+		return dev_err_probe(dev, -EINVAL,
+				     "No columns defined in the keypad!\n");
+
+	cols = cols + 1 - kpad->info->max_rows;
+
+	error = matrix_keypad_build_keymap(NULL, NULL, rows, cols,
+					   kpad->keycode, kpad->input);
+	if (error)
+		return error;
+
+	kpad->row_shift = get_count_order(cols);
+
+	if (device_property_read_bool(kpad->dev, "autorepeat"))
+		__set_bit(EV_REP, kpad->input->evbit);
+
+	error = adp5585_keys_check_special_events(adp5585, kpad);
+	if (error)
+		return error;
+
+	return 0
+}
+
+static int adp5585_keys_setup(const struct adp5585_dev *adp5585,
+			      struct adp5585_kpad *kpad)
+{
+	unsigned long keys_bits, start = 0, nbits = kpad->info->max_rows;
+	const struct adp5585_regs *regs = adp5585->regs;
+	unsigned int i = 0, max_cols = kpad->info->max_cols;
+	int error;
+
+	/*
+	 * Take care as the below assumes max_rows is always less or equal than
+	 * 8 which is true for the supported devices. If we happen to add
+	 * another device we need to make sure this still holds true. Although
+	 * adding a new device is very unlikely.
+	 */
+	do {
+		keys_bits = bitmap_read(&kpad->keypad, start, nbits);
+		if (keys_bits) {
+			error = regmap_write(adp5585->regmap, regs->pin_cfg_a + i,
+					     keys_bits);
+			if (error)
+				return error;
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
+	} while (start < kpad->info->max_rows + kpad->info->max_cols);
+
+	return 0;
+}
+
+static int adp5585_keys_ev_handle(struct notifier_block *nb, unsigned long key,
+				  void *data)
+{
+	struct adp5585_kpad *kpad = container_of(nb, struct adp5585_kpad, nb);
+	unsigned long key_press = (unsigned long)data;
+	unsigned int row, col, code;
+
+	/* make sure the event is for us */
+	if (key < kpad->info->key_ev_min || key > kpad->info->key_ev_max)
+		return NOTIFY_DONE;
+
+	/*
+	 * Unlikely but lets be on the safe side! We do not return any error
+	 * because the event was indeed for us but with some weird value. So,
+	 * we still want the caller know that the right handler was called.
+	 */
+	if (!key)
+		return NOTIFY_BAD;
+
+	row = (key - 1) / (kpad->info->max_cols);
+	col = (key - 1) % (kpad->info->max_cols);
+	code = MATRIX_SCAN_CODE(row, col, kpad->row_shift);
+
+	dev_dbg_ratelimited(kpad->dev, "report key(%lu) r(%d) c(%d) code(%d)\n",
+			    key, row, col, kpad->keycode[code]);
+
+	input_report_key(kpad->input, kpad->keycode[code], key_press);
+	input_sync(kpad->input);
+
+	return NOTIFY_STOP;
+}
+
+static void adp5585_keys_unreg_notifier(void *data)
+{
+	struct adp5585_kpad *kpad = data;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(kpad->dev->parent);
+
+	blocking_notifier_chain_unregister(&adp5585->event_notifier,
+					   &kpad->nb);
+}
+
+static int adp5585_keys_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct adp5585_kpad *kpad;
+	unsigned int revid;
+	const char *phys;
+	int error;
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
+
+	kpad->input = devm_input_allocate_device(dev);
+	if (!kpad->input)
+		return -ENOMEM;
+
+	kpad->info = (const struct adp5585_kpad_chip *)id->driver_data;
+	if (!kpad->info)
+		return -ENODEV;
+
+	error = regmap_read(adp5585->regmap, ADP5585_ID, &revid);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to read device ID\n");
+
+	phys = devm_kasprintf(dev, GFP_KERNEL, "%s/input0", pdev->name);
+	if (!phys)
+		return -ENOMEM;
+
+	kpad->input->name = pdev->name;
+	kpad->input->phys = phys;
+
+	kpad->input->id.bustype = BUS_I2C;
+	kpad->input->id.vendor = 0x0001;
+	kpad->input->id.product = 0x0001;
+	kpad->input->id.version = revid & ADP5585_REV_ID_MASK;
+
+	device_set_of_node_from_dev(dev, dev->parent);
+
+	error = adp5585_keys_parse_fw(adp5585, kpad);
+	if (error)
+		return error;
+
+	error = adp5585_keys_setup(adp5585, kpad);
+	if (error)
+		return error;
+
+	kpad->nb.notifier_call = adp5585_keys_ev_handle;
+	error = blocking_notifier_chain_register(&adp5585->event_notifier,
+						 &kpad->nb);
+	if (error)
+		return error;
+
+	error = devm_add_action_or_reset(dev, adp5585_keys_unreg_notifier, kpad);
+	if (error)
+		return error;
+
+	error = input_register_device(kpad->input);
+	if (error)
+		return dev_err_probe(dev, error,
+				     "Failed to register input device\n");
+
+	return 0;
+}
+
+static const struct adp5585_kpad_chip adp5585_kpad_chip_info = {
+	.max_rows = 6,
+	.max_cols = 5,
+	.key_ev_min = ADP5585_ROW5_KEY_EVENT_START,
+	.key_ev_max = ADP5585_ROW5_KEY_EVENT_END,
+};
+
+static const struct adp5585_kpad_chip adp5589_kpad_chip_info = {
+	.max_rows = 8,
+	.max_cols = 11,
+	.key_ev_min = ADP5589_KEY_EVENT_START,
+	.key_ev_max = ADP5589_KEY_EVENT_END,
+};
+
+static const struct platform_device_id adp5585_keys_id_table[] = {
+	{ "adp5585-keys", (kernel_ulong_t)&adp5585_kpad_chip_info },
+	{ "adp5589-keys", (kernel_ulong_t)&adp5589_kpad_chip_info },
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



