Return-Path: <linux-pwm+bounces-5412-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09406A829F1
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120029A1238
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D0270EAB;
	Wed,  9 Apr 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RhwA0AHe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED626F47B;
	Wed,  9 Apr 2025 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210616; cv=none; b=YQz7UVfZjbPyPlaoB/Q0jshH2/UbGFvYiKqP9NxLpAd6CHsYR3JUHhtKSYRCP6bUQbc1iU+q40xtIhSPOKLvSN4ddlEsPcjrO/Wnkc0nyF/77SC66hpHOriY9LJ6hCdhDlLpTE5FnSbBZFQ+0iK3SNP+sxr3OYP1KVuFbANcQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210616; c=relaxed/simple;
	bh=aJO8Mzk9jqoUgslMt5Ov3h4NkraRm02fXKDkQ4tTo/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wvv1LvPColGss5i+uIahU45lrtRTMi3KW1cIguqpxGy/kGFGQETMJlh82Xr2/PvM/iQjzqaslL9x+xwxa+wwPDXU0Gv9g6WQ2EMb53DWkOg0Qr8p1/JyCTWzIqKsQAhOfW47MpOIGadL93VfHfC8Q8zl4ucx8R9z6AMf0GTW1+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RhwA0AHe; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D076520452;
	Wed,  9 Apr 2025 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744210611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDZnlgkfrOjp1KMdtH8u5UsT+YGkGHfhd3XXCO5CdQU=;
	b=RhwA0AHe94Soxnm1nAvwVB1mK9pjcNd2GrWngltPbfGrn3aU1QLipiDrscOmv3dCy2iozg
	r/JvyfMZoeCTLKk7MJ10B22SVJ8Hqm9qt4jpw9Mom9+CHtMVAQveC92364GEkXftPLL0Q5
	7Tfroyq0u/0G3DemjLpdpbTxYBq/gUkDt0W66YWaPRbuysI8RxpZhtCgxCXJXOdHSnqNdX
	sStc33JdmXVZIrP5EU/bXmOXZhLDrUokRBACyjEqFbd5GNjs7ihq+OsmcwX33oRbsKebiZ
	IFedrm6QHjTmsQqsexikQ+kFkW6fqj6hR3vk5XGsg+ZzJnXI+PUbAAorE8KN/Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 09 Apr 2025 16:55:58 +0200
Subject: [PATCH v6 11/12] input: misc: Add support for MAX7360 rotary
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-mdb-max7360-support-v6-11-7a2535876e39@bootlin.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
In-Reply-To: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744210599; l=6184;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=aJO8Mzk9jqoUgslMt5Ov3h4NkraRm02fXKDkQ4tTo/A=;
 b=045QUsUquJqCkwMD89m3gBatHnGGB8L8+F6lnsGYgXcVhdlzvbmPQ4bdT0Fnkkq6sOKbp5/Ik
 QiXhkdrs22ZBqm4V1e5n6PHt2O37BdWgHYGvnYsjAi3AW7yKYmBa4cC
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeivdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgvs
 ehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add driver for Maxim Integrated MAX7360 rotary encoder controller,
supporting a single rotary switch.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/input/misc/Kconfig          |  10 +++
 drivers/input/misc/Makefile         |   1 +
 drivers/input/misc/max7360-rotary.c | 148 ++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index f5496ca0c0d2..0bc9d121c984 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -230,6 +230,16 @@ config INPUT_M68K_BEEP
 	tristate "M68k Beeper support"
 	depends on M68K
 
+config INPUT_MAX7360_ROTARY
+	tristate "Maxim MAX7360 Rotary Encoder"
+	depends on MFD_MAX7360
+	help
+	  If you say yes here you get support for the rotary encoder on the
+	  Maxim MAX7360 I/O Expander.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max7360_rotary.
+
 config INPUT_MAX77650_ONKEY
 	tristate "Maxim MAX77650 ONKEY support"
 	depends on MFD_MAX77650
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 6d91804d0a6f..c454fba3a3ae 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_INPUT_IQS7222)		+= iqs7222.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
+obj-$(CONFIG_INPUT_MAX7360_ROTARY)	+= max7360-rotary.o
 obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
 obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
diff --git a/drivers/input/misc/max7360-rotary.c b/drivers/input/misc/max7360-rotary.c
new file mode 100644
index 000000000000..c9630e79730a
--- /dev/null
+++ b/drivers/input/misc/max7360-rotary.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
+ *
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device/devres.h>
+#include <linux/dev_printk.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max7360.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+struct max7360_rotary {
+	u32 axis;
+	struct input_dev *input;
+	unsigned int debounce_ms;
+	struct regmap *regmap;
+};
+
+static irqreturn_t max7360_rotary_irq(int irq, void *data)
+{
+	struct max7360_rotary *max7360_rotary = data;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
+	if (ret < 0) {
+		dev_err(&max7360_rotary->input->dev,
+			"Failed to read rotary counter\n");
+		return IRQ_NONE;
+	}
+
+	if (val == 0) {
+		dev_dbg(&max7360_rotary->input->dev,
+			"Got a spurious interrupt\n");
+
+		return IRQ_NONE;
+	}
+
+	input_report_rel(max7360_rotary->input, max7360_rotary->axis, sign_extend32(val, 7));
+	input_sync(max7360_rotary->input);
+
+	return IRQ_HANDLED;
+}
+
+static int max7360_rotary_hw_init(struct max7360_rotary *max7360_rotary)
+{
+	int val;
+	int ret;
+
+	val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
+		FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;
+	ret = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
+	if (ret)
+		dev_err(&max7360_rotary->input->dev,
+			"Failed to set max7360 rotary encoder configuration\n");
+
+	return ret;
+}
+
+static int max7360_rotary_probe(struct platform_device *pdev)
+{
+	struct max7360_rotary *max7360_rotary;
+	struct device *dev = &pdev->dev;
+	struct input_dev *input;
+	struct regmap *regmap;
+	int irq;
+	int ret;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
+
+	irq = fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	max7360_rotary = devm_kzalloc(dev, sizeof(*max7360_rotary), GFP_KERNEL);
+	if (!max7360_rotary)
+		return -ENOMEM;
+
+	max7360_rotary->regmap = regmap;
+	device_property_read_u32(dev->parent, "linux,axis", &max7360_rotary->axis);
+	device_property_read_u32(dev->parent, "rotary-debounce-delay-ms",
+				 &max7360_rotary->debounce_ms);
+	if (max7360_rotary->debounce_ms > MAX7360_ROT_DEBOUNCE_MAX)
+		return dev_err_probe(dev, -EINVAL, "Invalid debounce timing: %u\n",
+				     max7360_rotary->debounce_ms);
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	max7360_rotary->input = input;
+
+	input->id.bustype = BUS_I2C;
+	input->name = pdev->name;
+	input->dev.parent = dev;
+
+	input_set_capability(input, EV_REL, max7360_rotary->axis);
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, max7360_rotary_irq,
+					IRQF_ONESHOT | IRQF_SHARED,
+					"max7360-rotary", max7360_rotary);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register interrupt\n");
+
+	ret = input_register_device(input);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not register input device\n");
+
+	ret = max7360_rotary_hw_init(max7360_rotary);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize max7360 rotary\n");
+
+	device_init_wakeup(dev, true);
+	ret = dev_pm_set_wake_irq(dev, irq);
+	if (ret)
+		dev_warn(dev, "Failed to set up wakeup irq: %d\n", ret);
+
+	return 0;
+}
+
+static void max7360_rotary_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+}
+
+static struct platform_driver max7360_rotary_driver = {
+	.driver = {
+		.name	= "max7360-rotary",
+	},
+	.probe		= max7360_rotary_probe,
+	.remove		= max7360_rotary_remove,
+};
+module_platform_driver(max7360_rotary_driver);
+
+MODULE_DESCRIPTION("MAX7360 Rotary driver");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5


