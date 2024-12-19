Return-Path: <linux-pwm+bounces-4409-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323889F7F87
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AE3189121A
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74601229B10;
	Thu, 19 Dec 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oSZPluGl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E657228381;
	Thu, 19 Dec 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625323; cv=none; b=fv328ixsI88iaiejFviV8ZKae9nE/vGdp+sQv2+thqlpjHKYLmFtdmp51cszhsY+gEQFXibONJFqKdZ/ZAg1iWaMw5m6cQHkwqQmp8otFTOBokKGgZBZF15PUgiclkjM/xYDkc2/QFYV9hJH4zUbT6G8tYr0T3DNXMCLEO68JHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625323; c=relaxed/simple;
	bh=NKKK6m3TELHnW2cRSo1Kk+Wj76SXFUJ2uWnoCjAZsFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0fN0QPHPL2psuZKsv9/UJQAMUH1xshOjaTNFczT7A0Jb8YamAiudJFd+qepPn4Cx5sUgB2GegG5Hhb1IT7MgEfqeuEU6YH2usiXlSbjz78DfkcXUjv6+xu0or3R2yiUWK/QwGas6gG5i4dmVbWwkCZBz1Jo7SNVLZemn75hwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oSZPluGl; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D78860006;
	Thu, 19 Dec 2024 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734625313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5XRZr3gsIuLzCYmmgqzJoRUGlzpyX2inEBWBRXtQkk=;
	b=oSZPluGlYajSX6Rc9a6dCYLRuNR/Fv1qtQgRa0Zg+szhf9S9WLeE8s7zlBLVOeQTAIR+mK
	vI1yl8wNbevHG8bhiELkrDmrn1n3/ExbZHT95CgnbtMod6kpdCqZBu+jtL+ARLnlWs1FWG
	2aEsAMmMItGO2THmYt0n+3+t5v5SF5gNi+m78FG8t5prGnA2Cb1eOQ5/DaIxENoosF4urv
	Iek3IvILqEHxHuynH/DXUvldxFuwxjiPmM8q14CepOfUXgFe7CWl81OApVeILZUg/0XA1G
	TpBixykAsgD+56xaaTDFRXnlo66LJnelpQ41HAj0ftZ3nV5XHeoZW/ytWro+ng==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 19 Dec 2024 17:21:23 +0100
Subject: [PATCH 6/8] input: keyboard: Add support for MAX7360 keypad
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-mdb-max7360-support-v1-6-8e8317584121@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734625307; l=10712;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=NKKK6m3TELHnW2cRSo1Kk+Wj76SXFUJ2uWnoCjAZsFY=;
 b=MIoi6JqektC3LUFRkKSZy4fwOY7p7XcJXe3y1wg59QwGkLbCr7h/OU7KQ8EE98YK12HqF4qyO
 GBlimW0tJa2B7i4mrkjjDRKWLd1BOqQHGOYJ5Dfiu7lBcEvdWUCD+HW
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 keypad controller, providing
support for up to 64 keys, with a matrix of 8 columns and 8 rows.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/input/keyboard/Kconfig          |  12 ++
 drivers/input/keyboard/Makefile         |   1 +
 drivers/input/keyboard/max7360-keypad.c | 297 ++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)

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
index 000000000000..fbc51c89dba1
--- /dev/null
+++ b/drivers/input/keyboard/max7360-keypad.c
@@ -0,0 +1,297 @@
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
+	bool no_autorepeat;
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
+	int ret;
+
+	ret = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
+	if (!ret && val == MAX7360_FIFO_OVERFLOW) {
+		/* FIFO overflow: ignore it and get next event. */
+		dev_err(&max7360_keypad->input->dev, "max7360 FIFO overflow");
+		ret = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
+				  &val);
+	}
+	if (ret) {
+		dev_err(&max7360_keypad->input->dev,
+			"Failed to read max7360 FIFO");
+		return ret;
+	}
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
+	int ret;
+
+	/*
+	 * Somebody is using the device: get out of sleep.
+	 */
+	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
+				MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
+	if (ret) {
+		dev_err(&max7360_keypad->input->dev,
+			"Failed to write max7360 configuration");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void max7360_keypad_close(struct input_dev *pdev)
+{
+	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
+	int ret;
+
+	/*
+	 * Nobody is using the device anymore: go to sleep.
+	 */
+	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
+				MAX7360_CFG_SLEEP, ~MAX7360_CFG_SLEEP);
+	if (ret) {
+		dev_err(&max7360_keypad->input->dev,
+			"Failed to write max7360 configuration");
+	}
+}
+
+static int max7360_keypad_hw_init(struct max7360_keypad *max7360_keypad)
+{
+	unsigned int val;
+	int ret;
+
+	val = max7360_keypad->debounce_ms - MAX7360_DEBOUNCE_MIN;
+	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_DEBOUNCE,
+				MAX7360_DEBOUNCE,
+				FIELD_PREP(MAX7360_DEBOUNCE, val));
+	if (ret) {
+		dev_err(&max7360_keypad->input->dev,
+			"Failed to write max7360 debounce configuration");
+		return ret;
+	}
+
+	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_INTERRUPT,
+				MAX7360_INTERRUPT_TIME_MASK,
+				FIELD_PREP(MAX7360_INTERRUPT_TIME_MASK, 1));
+	if (ret) {
+		dev_err(&max7360_keypad->input->dev,
+			"Failed to write max7360 keypad interrupt configuration");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max7360_keypad_parse_dt(struct platform_device *pdev,
+				   struct max7360_keypad *max7360_keypad)
+{
+	bool no_autorepeat;
+	int ret;
+
+	ret = matrix_keypad_parse_properties(&pdev->dev, &max7360_keypad->rows,
+					     &max7360_keypad->cols);
+	if (ret)
+		return ret;
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
+	max7360_keypad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!max7360_keypad->regmap) {
+		dev_err(&pdev->dev, "Could not get parent regmap\n");
+		return -ENODEV;
+	}
+
+	no_autorepeat = of_property_read_bool(pdev->dev.of_node,
+					      "linux,input-no-autorepeat");
+	max7360_keypad->no_autorepeat = no_autorepeat;
+
+	max7360_keypad->debounce_ms = MAX7360_DEBOUNCE_MIN;
+	ret = of_property_read_u32(pdev->dev.of_node, "debounce-delay-ms",
+				   &max7360_keypad->debounce_ms);
+	if (ret == -EINVAL) {
+		dev_info(&pdev->dev, "Using default debounce-delay-ms: %u\n",
+			 max7360_keypad->debounce_ms);
+	} else if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to read debounce-delay-ms property\n");
+		return ret;
+	} else if (max7360_keypad->debounce_ms < MAX7360_DEBOUNCE_MIN ||
+		   max7360_keypad->debounce_ms > MAX7360_DEBOUNCE_MAX) {
+		dev_err(&pdev->dev,
+			"Invalid debounce-delay-ms: %u, should be between %u and %u.\n",
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
+	unsigned long flags;
+	int irq;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	max7360_keypad = devm_kzalloc(&pdev->dev, sizeof(*max7360_keypad),
+				      GFP_KERNEL);
+	if (!max7360_keypad)
+		return -ENOMEM;
+
+	ret = max7360_keypad_parse_dt(pdev, max7360_keypad);
+	if (ret)
+		return ret;
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocate input device\n");
+
+	max7360_keypad->input = input;
+
+	input->id.bustype = BUS_I2C;
+	input->name = pdev->name;
+	input->dev.parent = &pdev->dev;
+
+	input->open = max7360_keypad_open;
+	input->close = max7360_keypad_close;
+
+	ret = matrix_keypad_build_keymap(NULL, NULL,
+					 MAX7360_MAX_KEY_ROWS,
+					 MAX7360_MAX_KEY_COLS,
+					 max7360_keypad->keycodes, input);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to build keymap\n");
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	if (!max7360_keypad->no_autorepeat)
+		__set_bit(EV_REP, input->evbit);
+
+	input_set_drvdata(input, max7360_keypad);
+
+	flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					max7360_keypad_irq, flags,
+					"max7360-keypad", max7360_keypad);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register interrupt: %d\n", ret);
+
+	ret = input_register_device(input);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Could not register input device: %d\n",
+				     ret);
+
+	platform_set_drvdata(pdev, max7360_keypad);
+
+	device_init_wakeup(&pdev->dev, true);
+	ret = dev_pm_set_wake_irq(&pdev->dev, irq);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n", ret);
+
+	ret = max7360_keypad_hw_init(max7360_keypad);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to initialize max7360 keypad\n");
+
+	return 0;
+}
+
+static void max7360_keypad_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id max7360_keypad_of_match[] = {
+	{ .compatible = "maxim,max7360-keypad", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max7360_keypad_of_match);
+#endif
+
+static struct platform_driver max7360_keypad_driver = {
+	.driver = {
+		.name	= "max7360-keypad",
+		.of_match_table = of_match_ptr(max7360_keypad_of_match),
+	},
+	.probe		= max7360_keypad_probe,
+	.remove		= max7360_keypad_remove,
+};
+module_platform_driver(max7360_keypad_driver);
+
+MODULE_DESCRIPTION("MAX7360 Keypad driver");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_ALIAS("platform:max7360-keypad");
+MODULE_LICENSE("GPL");

-- 
2.39.5


