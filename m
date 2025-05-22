Return-Path: <linux-pwm+bounces-6084-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19152AC0B46
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B18C4E5FB5
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1327428C03D;
	Thu, 22 May 2025 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R9Pg0Vr0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D928B7DB;
	Thu, 22 May 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915616; cv=none; b=j2YxzmmlNmixWwNuCcjhFzqoaSlrZr79hOgx4litfIiZSTeEAt7lx/axyCIB4XTm24sPrCFxcijtYApVQk64k9BxXsbP0fs/O2OK3Erb+r18f1tNtZV0AGEmKIlqDTVU84LN4YfTXbDGr0/nIjyOGu5/69RsQl0rhRJZRk2MmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915616; c=relaxed/simple;
	bh=JI3737qpZV5i/n/DYPnkPTfd1V/ujAG4pR1TJ/4gbgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNcvphH+7vFXXrPW/MskKjE+srPKQXbu8NFij4lk2wedzdpuKqe07B4Yp4PX5rgI6R152LZEmCpnPeX/+niiaszpubWmsoF+0jWTm8MT2UX+24RRd66rXl8rh8lLYW3ER2b/DVFMjKdrqss4M90Vhhiewj7BQWvFGcSyXPcYbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R9Pg0Vr0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDE051FCF1;
	Thu, 22 May 2025 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747915612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGf57HS6QUeaCcFUW+/oTiK0us3RHmT+M6Av6twgbrQ=;
	b=R9Pg0Vr0ua70txpQ9r7BF2m4jDUHr4BkYu4HGmclL6zbtC42AFEU5wEtTsF+JDeGw3c9Ws
	3c0Mha9VNj8D+Ob4KE42VIDlGgYEZn4ibmNKVCoXQQ0+3v2u+f+uJe6lqEVIRGAVpQCLUq
	wT2M9vQfg++6WqCnpF+TwM3tM8ZFLfFCZtl2sl6zzwes0kR64Eap/P2p35A9CxqXOVP3K+
	SVHGfx3sNYHFWkoQ38ctbzs2p607vDNkRuLZujvxFgKYWI0+JNWq732VZm+xl0qqylk86W
	wKm/FGTUK1sngsNEnvr2D1aRLRulL+gomGDaH9FLA4KHkh5DUbyCDmm9EEr0KA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 22 May 2025 14:06:24 +0200
Subject: [PATCH v9 09/11] input: keyboard: Add support for MAX7360 keypad
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-mdb-max7360-support-v9-9-74fc03517e41@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747915601; l=11626;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=JI3737qpZV5i/n/DYPnkPTfd1V/ujAG4pR1TJ/4gbgo=;
 b=7poqdLzCGIQPqDBGWhu5JeXQskjoFyC611bkLXTPErSiTLSyIZJQwZ592Smc7412HTiLYl4iB
 SlG8ymfmganA8prbRPcb3o0zu/uthNqZrllqmV5ZtRIYDtuH21xKsFc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehleduucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheps
 ghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 keypad controller, providing
support for up to 64 keys, with a matrix of 8 columns and 8 rows.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/input/keyboard/Kconfig          |  12 ++
 drivers/input/keyboard/Makefile         |   1 +
 drivers/input/keyboard/max7360-keypad.c | 308 ++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 721ab69e84ac..93b5cccf6892 100644
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
+	  To compile this driver as a module, choose M here: the module will be
+	  called max7360_keypad.
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
index 000000000000..6bae00e7888b
--- /dev/null
+++ b/drivers/input/keyboard/max7360-keypad.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
+ *
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/mod_devicetable.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
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
+	struct device *dev = max7360_keypad->input->dev.parent;
+	unsigned int val;
+	unsigned int row, col;
+	unsigned int release;
+	unsigned int code;
+	int error;
+
+	error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
+	if (error) {
+		dev_err(dev, "Failed to read MAX7360 FIFO");
+		return IRQ_NONE;
+	}
+
+	/* FIFO overflow: ignore it and get next event. */
+	if (val == MAX7360_FIFO_OVERFLOW) {
+		dev_warn(dev, "max7360 FIFO overflow");
+		error = regmap_read_poll_timeout(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
+						 val, val != MAX7360_FIFO_OVERFLOW, 0, 1000);
+		if (error) {
+			dev_err(dev, "Failed to empty MAX7360 FIFO");
+			return IRQ_NONE;
+		}
+	}
+
+	if (val == MAX7360_FIFO_EMPTY) {
+		dev_dbg(dev, "Got a spurious interrupt");
+
+		return IRQ_NONE;
+	}
+
+	row = FIELD_GET(MAX7360_FIFO_ROW, val);
+	col = FIELD_GET(MAX7360_FIFO_COL, val);
+	release = val & MAX7360_FIFO_RELEASE;
+
+	code = MATRIX_SCAN_CODE(row, col, get_count_order(max7360_keypad->cols));
+
+	dev_dbg(dev, "key[%d:%d] %s\n", row, col, release ? "release" : "press");
+
+	input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
+	input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code], !release);
+	input_sync(max7360_keypad->input);
+
+	return IRQ_HANDLED;
+}
+
+static int max7360_keypad_open(struct input_dev *pdev)
+{
+	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
+	struct device *dev = max7360_keypad->input->dev.parent;
+	int error;
+
+	/* Somebody is using the device: get out of sleep. */
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
+				  MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
+	if (error)
+		dev_err(dev, "Failed to write max7360 configuration: %d\n", error);
+
+	return error;
+}
+
+static void max7360_keypad_close(struct input_dev *pdev)
+{
+	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
+	struct device *dev = max7360_keypad->input->dev.parent;
+	int error;
+
+	/* Nobody is using the device anymore: go to sleep. */
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG, MAX7360_CFG_SLEEP, 0);
+	if (error)
+		dev_err(dev, "Failed to write max7360 configuration: %d\n", error);
+}
+
+static int max7360_keypad_hw_init(struct max7360_keypad *max7360_keypad)
+{
+	struct device *dev = max7360_keypad->input->dev.parent;
+	unsigned int val;
+	int error;
+
+	val = max7360_keypad->debounce_ms - MAX7360_DEBOUNCE_MIN;
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_DEBOUNCE,
+				  MAX7360_DEBOUNCE,
+				  FIELD_PREP(MAX7360_DEBOUNCE, val));
+	if (error)
+		return dev_err_probe(dev, error,
+				     "Failed to write max7360 debounce configuration\n");
+
+	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_INTERRUPT,
+				  MAX7360_INTERRUPT_TIME_MASK,
+				  FIELD_PREP(MAX7360_INTERRUPT_TIME_MASK, 1));
+	if (error)
+		return dev_err_probe(dev, error,
+				     "Failed to write max7360 keypad interrupt configuration\n");
+
+	return 0;
+}
+
+static int max7360_keypad_build_keymap(struct max7360_keypad *max7360_keypad)
+{
+	struct input_dev *input_dev = max7360_keypad->input;
+	struct device *dev = input_dev->dev.parent->parent;
+	struct matrix_keymap_data keymap_data;
+	const char *propname = "linux,keymap";
+	unsigned int max_keys;
+	int error;
+	int size;
+
+	size = device_property_count_u32(dev, propname);
+	if (size <= 0) {
+		dev_err(dev, "missing or malformed property %s: %d\n", propname, size);
+		return size < 0 ? size : -EINVAL;
+	}
+
+	max_keys = max7360_keypad->cols * max7360_keypad->rows;
+	if (size > max_keys) {
+		dev_err(dev, "%s size overflow (%d vs max %u)\n", propname, size, max_keys);
+		return -EINVAL;
+	}
+
+	u32 *keys __free(kfree) = kmalloc_array(size, sizeof(*keys), GFP_KERNEL);
+	if (!keys)
+		return -ENOMEM;
+
+	error = device_property_read_u32_array(dev, propname, keys, size);
+	if (error) {
+		dev_err(dev, "failed to read %s property: %d\n", propname, error);
+		return error;
+	}
+
+	keymap_data.keymap = keys;
+	keymap_data.keymap_size = size;
+	error = matrix_keypad_build_keymap(&keymap_data, NULL,
+					   max7360_keypad->rows, max7360_keypad->cols,
+					   max7360_keypad->keycodes, max7360_keypad->input);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int max7360_keypad_parse_fw(struct device *dev,
+				   struct max7360_keypad *max7360_keypad,
+				   bool *autorepeat)
+{
+	int error;
+
+	error = matrix_keypad_parse_properties(dev->parent, &max7360_keypad->rows,
+					       &max7360_keypad->cols);
+	if (error)
+		return error;
+
+	if (!max7360_keypad->rows || !max7360_keypad->cols ||
+	    max7360_keypad->rows > MAX7360_MAX_KEY_ROWS ||
+	    max7360_keypad->cols > MAX7360_MAX_KEY_COLS) {
+		dev_err(dev, "Invalid number of columns or rows (%ux%u)\n",
+			max7360_keypad->cols, max7360_keypad->rows);
+		return -EINVAL;
+	}
+
+	*autorepeat = device_property_read_bool(dev->parent, "autorepeat");
+
+	max7360_keypad->debounce_ms = MAX7360_DEBOUNCE_MIN;
+	error = device_property_read_u32(dev->parent, "keypad-debounce-delay-ms",
+					 &max7360_keypad->debounce_ms);
+	if (error == -EINVAL) {
+		dev_info(dev, "Using default keypad-debounce-delay-ms: %u\n",
+			 max7360_keypad->debounce_ms);
+	} else if (error < 0) {
+		dev_err(dev, "Failed to read keypad-debounce-delay-ms property\n");
+		return error;
+	}
+
+	if (!in_range(max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN,
+		      MAX7360_DEBOUNCE_MAX - MAX7360_DEBOUNCE_MIN)) {
+		dev_err(dev, "Invalid keypad-debounce-delay-ms: %u, should be between %u and %u.\n",
+			max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN, MAX7360_DEBOUNCE_MAX);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int max7360_keypad_probe(struct platform_device *pdev)
+{
+	struct max7360_keypad *max7360_keypad;
+	struct device *dev = &pdev->dev;
+	struct input_dev *input;
+	struct regmap *regmap;
+	bool autorepeat;
+	int error;
+	int irq;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
+
+	irq = fwnode_irq_get_byname(dev_fwnode(dev->parent), "intk");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	max7360_keypad = devm_kzalloc(dev, sizeof(*max7360_keypad), GFP_KERNEL);
+	if (!max7360_keypad)
+		return -ENOMEM;
+
+	max7360_keypad->regmap = regmap;
+
+	error = max7360_keypad_parse_fw(dev, max7360_keypad, &autorepeat);
+	if (error)
+		return error;
+
+	input = devm_input_allocate_device(dev);
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
+	error = max7360_keypad_build_keymap(max7360_keypad);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to build keymap\n");
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	if (autorepeat)
+		__set_bit(EV_REP, input->evbit);
+
+	input_set_drvdata(input, max7360_keypad);
+
+	error = devm_request_threaded_irq(dev, irq, NULL, max7360_keypad_irq,
+					  IRQF_ONESHOT,
+					  "max7360-keypad", max7360_keypad);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to register interrupt\n");
+
+	error = input_register_device(input);
+	if (error)
+		return dev_err_probe(dev, error, "Could not register input device\n");
+
+	error = max7360_keypad_hw_init(max7360_keypad);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to initialize max7360 keypad\n");
+
+	device_init_wakeup(dev, true);
+	error = dev_pm_set_wake_irq(dev, irq);
+	if (error)
+		dev_warn(dev, "Failed to set up wakeup irq: %d\n", error);
+
+	return 0;
+}
+
+static void max7360_keypad_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
+
+static struct platform_driver max7360_keypad_driver = {
+	.driver = {
+		.name	= "max7360-keypad",
+	},
+	.probe		= max7360_keypad_probe,
+	.remove		= max7360_keypad_remove,
+};
+module_platform_driver(max7360_keypad_driver);
+
+MODULE_DESCRIPTION("MAX7360 Keypad driver");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5


