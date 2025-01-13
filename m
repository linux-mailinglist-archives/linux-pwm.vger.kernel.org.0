Return-Path: <linux-pwm+bounces-4601-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E7A0B74E
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 13:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2354188718B
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1D023A589;
	Mon, 13 Jan 2025 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mhVuEPDS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A222C324;
	Mon, 13 Jan 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772196; cv=none; b=tuS5xqb1W03Ou47z4ifMTNYlOtolLUibvnL7m8wtjr8sWwqAQrr9R0WJrTaNlxGK8T9XB4I1DwC+kAaE+/2GqVP1j1LcWmDcwJWvAiQEMeLpq7nSH2En3oc8Oq8ovw9/axuAoF57PFIfjSat4Kq9JTYU1uIOwk7tIkarIGcoEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772196; c=relaxed/simple;
	bh=ysH8rifAznFpMajeLd2CoDqVx7EKnEvxFzDb/Z04HwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szB0TH2m2WUn7M0pD4Xn4UazeS+TXhn7hXPbJexEy8Y2vrVitJ6AGVfYenhJ/MbAH/F/NXI2s4bMsgn1AqA53BL8v3+rmmTeKuLY+FedaURJ5rac5xYO+23rc849/3PTG+NmYSLpOBmEmzQjTZUYwek2DXvHuROlXnMLxdFfPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mhVuEPDS; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BCEE240009;
	Mon, 13 Jan 2025 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736772190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUSZb5toqZoVilmgX+WdmXSWj9ZsXU9hW8HK+4X34+0=;
	b=mhVuEPDSYwjqA82tw5wU0qZ2Gl2mSq0Y+rCMHAwOusQrreRD9BZ79pfD92h/vpHib3TmVM
	DB0z6wW+OWR7gOzR/6wscpXUHur1ONqJ/BOCgdD3nOpXRTjcmfN86UU81EosE7+ea4hBJ/
	XWbBTG0ESl1ujO/YObTJSfpD3+uStNtZJ9/FCGGYRylYkSA5eN6yEsHPi876WV2elbBTy5
	dk3Npnf+3MYv12WSi7BT3D0u5KS/bNpYv6NOFHRK6oRQ0nLX5z4jRleKwb96YWULLegF0p
	lO7ReWIrztOpwKxcylofJIcEY+PALVIpFn2zZ0/g3C6H/SrZ0+GQKllWi3eFwA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 13 Jan 2025 13:42:29 +0100
Subject: [PATCH v3 5/7] input: keyboard: Add support for MAX7360 keypad
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mdb-max7360-support-v3-5-9519b4acb0b1@bootlin.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
In-Reply-To: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736772185; l=10430;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ysH8rifAznFpMajeLd2CoDqVx7EKnEvxFzDb/Z04HwU=;
 b=2QD5IVzmdSNzA/KNP+RVtExJFhy+FFYZUXqYgMnK6XDlTUzXIsoqOeuMWoBqQQqg8RxlYayAY
 VaEZTYUqlLPC5h92HFHALDe2i63pQMXmBHFtqf0CauIBeXAh2cPc1zk
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 keypad controller, providing
support for up to 64 keys, with a matrix of 8 columns and 8 rows.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/input/keyboard/Kconfig          |  12 ++
 drivers/input/keyboard/Makefile         |   1 +
 drivers/input/keyboard/max7360-keypad.c | 284 ++++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 721ab69e84ac..bba029f65cfa 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -421,6 +421,18 @@ config KEYBOARD_MAX7359
 	  To compile this driver as a module, choose M here: the
 	  module will be called max7359_keypad.
 
+config KEYBOARD_MAX7360
+	tristate "Maxim MAX7360 Key Switch Controller"
+	select INPUT_MATRIXKMAP
+	depends on I2C
+	depends on MFD_MAX7360
+	help
+	  If you say yes here you get support for the keypad controller on the
+	  Maxim MAX7360 I/O Expander.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called max7360_keypad.
+
 config KEYBOARD_MPR121
 	tristate "Freescale MPR121 Touchkey"
 	depends on I2C
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 1e0721c30709..b49d32d4003d 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
+obj-$(CONFIG_KEYBOARD_MAX7360)		+= max7360-keypad.o
 obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
 obj-$(CONFIG_KEYBOARD_MT6779)		+= mt6779-keypad.o
 obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
diff --git a/drivers/input/keyboard/max7360-keypad.c b/drivers/input/keyboard/max7360-keypad.c
new file mode 100644
index 000000000000..f42a0663a6ab
--- /dev/null
+++ b/drivers/input/keyboard/max7360-keypad.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Bootlin
+ *
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+struct max7360_keypad {
+	struct input_dev *input;
+	unsigned int rows;
+	unsigned int cols;
+	unsigned int debounce_ms;
+	int irq;
+	struct regmap *regmap;
+	unsigned short keycodes[MAX7360_MAX_KEY_ROWS * MAX7360_MAX_KEY_COLS];
+};
+
+static irqreturn_t max7360_keypad_irq(int irq, void *data)
+{
+	struct max7360_keypad *max7360_keypad = data;
+	unsigned int val;
+	unsigned int row, col;
+	unsigned int release;
+	unsigned int code;
+	int error;
+
+	do {
+		error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
+				    &val);
+		if (error) {
+			dev_err(&max7360_keypad->input->dev,
+				"Failed to read max7360 FIFO");
+			return IRQ_NONE;
+		}
+
+		/* FIFO overflow: ignore it and get next event. */
+		if (val == MAX7360_FIFO_OVERFLOW)
+			dev_warn(&max7360_keypad->input->dev,
+				 "max7360 FIFO overflow");
+	} while (val == MAX7360_FIFO_OVERFLOW);
+
+	if (val == MAX7360_FIFO_EMPTY) {
+		dev_dbg(&max7360_keypad->input->dev,
+			"Got a spurious interrupt");
+
+		return IRQ_NONE;
+	}
+
+	row = FIELD_GET(MAX7360_FIFO_ROW, val);
+	col = FIELD_GET(MAX7360_FIFO_COL, val);
+	release = val & MAX7360_FIFO_RELEASE;
+
+	code = MATRIX_SCAN_CODE(row, col, MAX7360_ROW_SHIFT);
+
+	dev_dbg(&max7360_keypad->input->dev,
+		"key[%d:%d] %s\n", row, col, release ? "release" : "press");
+
+	input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
+	input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code],
+			 !release);
+	input_sync(max7360_keypad->input);
+
+	return IRQ_HANDLED;
+}
+
+static int max7360_keypad_open(struct input_dev *pdev)
+{
+	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
+	int error;
+
+	/*
+	 * Somebody is using the device: get out of sleep.
+	 */
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
+				  MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
+	if (error) {
+		dev_err(&max7360_keypad->input->dev,
+			"Failed to write max7360 configuration\n");
+		return error;
+	}
+
+	return 0;
+}
+
+static void max7360_keypad_close(struct input_dev *pdev)
+{
+	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
+	int error;
+
+	/*
+	 * Nobody is using the device anymore: go to sleep.
+	 */
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
+				  MAX7360_CFG_SLEEP, ~MAX7360_CFG_SLEEP);
+	if (error)
+		dev_err(&max7360_keypad->input->dev,
+			"Failed to write max7360 configuration\n");
+}
+
+static int max7360_keypad_hw_init(struct max7360_keypad *max7360_keypad)
+{
+	unsigned int val;
+	int error;
+
+	val = max7360_keypad->debounce_ms - MAX7360_DEBOUNCE_MIN;
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_DEBOUNCE,
+				  MAX7360_DEBOUNCE,
+				  FIELD_PREP(MAX7360_DEBOUNCE, val));
+	if (error) {
+		return dev_err_probe(&max7360_keypad->input->dev, error,
+			"Failed to write max7360 debounce configuration\n");
+	}
+
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_INTERRUPT,
+				  MAX7360_INTERRUPT_TIME_MASK,
+				  FIELD_PREP(MAX7360_INTERRUPT_TIME_MASK, 1));
+	if (error) {
+		return dev_err_probe(&max7360_keypad->input->dev, error,
+			"Failed to write max7360 keypad interrupt configuration\n");
+	}
+
+	return 0;
+}
+
+static int max7360_keypad_parse_dt(struct platform_device *pdev,
+				   struct max7360_keypad *max7360_keypad,
+				   bool *autorepeat)
+{
+	int error;
+
+	error = matrix_keypad_parse_properties(pdev->dev.parent,
+					       &max7360_keypad->rows,
+					       &max7360_keypad->cols);
+	if (error)
+		return error;
+
+	if (!max7360_keypad->rows || !max7360_keypad->cols ||
+	    max7360_keypad->rows > MAX7360_MAX_KEY_ROWS ||
+	    max7360_keypad->cols > MAX7360_MAX_KEY_COLS) {
+		dev_err(&pdev->dev,
+			"Invalid number of columns or rows (%ux%u)\n",
+			max7360_keypad->cols, max7360_keypad->rows);
+		return -EINVAL;
+	}
+
+	*autorepeat = device_property_read_bool(pdev->dev.parent, "autorepeat");
+
+	max7360_keypad->debounce_ms = MAX7360_DEBOUNCE_MIN;
+	error = device_property_read_u32(pdev->dev.parent,
+					 "keypad-debounce-delay-ms",
+					 &max7360_keypad->debounce_ms);
+	if (error == -EINVAL) {
+		dev_info(&pdev->dev, "Using default keypad-debounce-delay-ms: %u\n",
+			 max7360_keypad->debounce_ms);
+	} else if (error < 0) {
+		dev_err(&pdev->dev,
+			"Failed to read keypad-debounce-delay-ms property\n");
+		return error;
+	} else if (max7360_keypad->debounce_ms < MAX7360_DEBOUNCE_MIN ||
+		   max7360_keypad->debounce_ms > MAX7360_DEBOUNCE_MAX) {
+		dev_err(&pdev->dev,
+			"Invalid keypad-debounce-delay-ms: %u, should be between %u and %u.\n",
+			max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN,
+			MAX7360_DEBOUNCE_MAX);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int max7360_keypad_probe(struct platform_device *pdev)
+{
+	struct max7360_keypad *max7360_keypad;
+	struct input_dev *input;
+	bool autorepeat;
+	int error;
+	int irq;
+
+	if (!pdev->dev.parent)
+		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");
+
+	irq = platform_get_irq_byname(to_platform_device(pdev->dev.parent),
+				      "intk");
+	if (irq < 0)
+		return irq;
+
+	max7360_keypad = devm_kzalloc(&pdev->dev, sizeof(*max7360_keypad),
+				      GFP_KERNEL);
+	if (!max7360_keypad)
+		return -ENOMEM;
+
+	max7360_keypad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!max7360_keypad->regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Could not get parent regmap\n");
+
+	error = max7360_keypad_parse_dt(pdev, max7360_keypad, &autorepeat);
+	if (error)
+		return error;
+
+	input = devm_input_allocate_device(pdev->dev.parent);
+	if (!input)
+		return -ENOMEM;
+
+	max7360_keypad->input = input;
+
+	input->id.bustype = BUS_I2C;
+	input->name = pdev->name;
+	input->open = max7360_keypad_open;
+	input->close = max7360_keypad_close;
+
+	error = matrix_keypad_build_keymap(NULL, NULL,
+					   MAX7360_MAX_KEY_ROWS,
+					   MAX7360_MAX_KEY_COLS,
+					   max7360_keypad->keycodes, input);
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Failed to build keymap\n");
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	if (autorepeat)
+		__set_bit(EV_REP, input->evbit);
+
+	input_set_drvdata(input, max7360_keypad);
+
+	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					  max7360_keypad_irq,
+					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					  "max7360-keypad", max7360_keypad);
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Failed to register interrupt\n");
+
+	error = input_register_device(input);
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Could not register input device\n");
+
+	platform_set_drvdata(pdev, max7360_keypad);
+
+	error = max7360_keypad_hw_init(max7360_keypad);
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Failed to initialize max7360 keypad\n");
+
+	device_init_wakeup(&pdev->dev, true);
+	error = dev_pm_set_wake_irq(&pdev->dev, irq);
+	if (error)
+		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n",
+			 error);
+
+	return 0;
+}
+
+static void max7360_keypad_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+}
+
+static struct platform_driver max7360_keypad_driver = {
+	.driver = {
+		.name	= MAX7360_DRVNAME_KEYPAD,
+	},
+	.probe		= max7360_keypad_probe,
+	.remove		= max7360_keypad_remove,
+};
+module_platform_driver(max7360_keypad_driver);
+
+MODULE_DESCRIPTION("MAX7360 Keypad driver");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_ALIAS("platform:" MAX7360_DRVNAME_KEYPAD);
+MODULE_LICENSE("GPL");

-- 
2.39.5


