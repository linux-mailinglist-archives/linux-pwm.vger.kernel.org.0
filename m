Return-Path: <linux-pwm+bounces-5160-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E65A5F789
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093E53BEA5E
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA86268C64;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tysgpgvg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BDB268C4B;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875558; cv=none; b=sYA9LwnV1Ns0SUfFneAGi6EB6IkBye5BV+MzPbbfgZAHsnIXoRVzNNVksawxrCSkPds2YzQI5nxHtTCyHM6Z9FQtfTTAUaqn/nGN1N3Zyo+tK17CAkV/1bum2eREQZ+uKL07HITl14oxRBhAq71KRCYzMr1Vl7B96yDNdyLPx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875558; c=relaxed/simple;
	bh=5JP+cDdGDswDwx7g92afORYwtD/xPpQe+hAqWjgN8JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjYdaNVC+vm5hUHZek1htPTRkz4ph2MiB1pekYImEwEXBOQSn2z/zb1wE2qaor0uCeoDyDPZTBFuykuGcAt4J42bpA+iR/d28g+7puHjj3+9PnR8koiICHSN7J4YGkJrnpdybW0eILQ9PYJZVKhh9qxeZGN5leZ1I3g4H354LLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tysgpgvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2DD6C4CEF0;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875557;
	bh=5JP+cDdGDswDwx7g92afORYwtD/xPpQe+hAqWjgN8JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tysgpgvg8g1jbsgoJmUSYE6nxqkQ7qyIOVtTtT/R5qtHlTs2mdhRwnJzro7pmg5ky
	 gyYqWpUxZGGlDYvGZ1L+aDVI76o0JOJfgK51a6LD2OPyK7yXTfmb0GVwoBtzK8UCs2
	 6m1oml/16ta1T1KfBKNU6F5IXTiLm2+VYDe+CkEOX1yrcadfVFZl8gzfq9oOFlOQJR
	 yJZ6NKmN6W4VmOJjxRKicIFf4EFuIvONI47Yr5xqvEfjRlAOudlh6pW+DXMWCCOMhi
	 psVDDIs96NQd+iVOGO8KwYpYZ8TKHkf3uUy4gbT0wFYGqeg9ZbevibOwGFFUHWC/Ud
	 bv7T97IVBK6Gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FBC282EC;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:24 +0000
Subject: [PATCH 07/18] gpio: adp5585: add support for the ad5589 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-7-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=9246;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=En/L9MCOHXbURTimhYsnktNaqCUSWhDUSGL0YSjg2b4=;
 b=GLsjrr6HEqHGMIJ06AjYlbAdVNkx4dcE2FlN1hmWi7lCe+hKlo8Vw2jqtlKhWU0b1sI8izUTw
 wdkIRfzPGTsDQAbBksHAbOrB7W6PNk9/RVUBuJ7CEVmsUXlw+8dFoRT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Support the adp5589 I/O expander which supports up to 19 pins. We need
to add a chip_info based struct since accessing register "banks"
and "bits" differs between devices.

Also some register addresses are different.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/gpio-adp5585.c | 120 ++++++++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index 000d31f09671022e27b9087f9f01593520535b12..fded9ff35a59fc1a0ce173c58dbd7b6af176958f 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2022 NXP
  * Copyright 2024 Ideas on Board Oy
+ * Copyright 2025 Analog Devices, Inc.
  */
 
 #include <linux/device.h>
@@ -14,21 +15,49 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-#define ADP5585_GPIO_MAX	11
+struct adp5585_gpio_chip {
+	unsigned int max_gpio;
+	int (*bank)(unsigned int off);
+	int (*bit)(unsigned int off);
+	bool has_bias_hole;
+};
 
 struct adp5585_gpio_dev {
 	struct gpio_chip gpio_chip;
+	const struct adp5585_gpio_chip *info;
 	struct regmap *regmap;
+	const struct adp5585_regs *regs;
 };
 
+static int adp5585_gpio_bank(unsigned int off)
+{
+	return ADP5585_BANK(off);
+}
+
+static int adp5585_gpio_bit(unsigned int off)
+{
+	return ADP5585_BIT(off);
+}
+
+static int adp5589_gpio_bank(unsigned int off)
+{
+	return ADP5589_BANK(off);
+}
+
+static int adp5589_gpio_bit(unsigned int off)
+{
+	return ADP5589_BIT(off);
+}
+
 static int adp5585_gpio_get_direction(struct gpio_chip *chip, unsigned int off)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 	unsigned int val;
 
-	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
+	regmap_read(adp5585_gpio->regmap, regs->gpio_dir_a + bank, &val);
 
 	return val & bit ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
@@ -36,35 +65,37 @@ static int adp5585_gpio_get_direction(struct gpio_chip *chip, unsigned int off)
 static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned int off)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
-	return regmap_clear_bits(adp5585_gpio->regmap,
-				 ADP5585_GPIO_DIRECTION_A + bank, bit);
+	return regmap_clear_bits(adp5585_gpio->regmap, regs->gpio_dir_a + bank,
+				 bit);
 }
 
 static int adp5585_gpio_direction_output(struct gpio_chip *chip, unsigned int off, int val)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 	int ret;
 
-	ret = regmap_update_bits(adp5585_gpio->regmap,
-				 ADP5585_GPO_DATA_OUT_A + bank, bit,
-				 val ? bit : 0);
+	ret = regmap_update_bits(adp5585_gpio->regmap, regs->gpo_data_a + bank,
+				 bit, val ? bit : 0);
 	if (ret)
 		return ret;
 
-	return regmap_set_bits(adp5585_gpio->regmap,
-			       ADP5585_GPIO_DIRECTION_A + bank, bit);
+	return regmap_set_bits(adp5585_gpio->regmap, regs->gpio_dir_a + bank,
+			       bit);
 }
 
 static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 	unsigned int reg;
 	unsigned int val;
 
@@ -79,8 +110,8 @@ static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
 	 * .direction_input(), .direction_output() or .set() operations racing
 	 * with this.
 	 */
-	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
-	reg = val & bit ? ADP5585_GPO_DATA_OUT_A : ADP5585_GPI_STATUS_A;
+	regmap_read(adp5585_gpio->regmap, regs->gpio_dir_a + bank, &val);
+	reg = val & bit ? regs->gpo_data_a : regs->gpi_stat_a;
 	regmap_read(adp5585_gpio->regmap, reg + bank, &val);
 
 	return !!(val & bit);
@@ -89,16 +120,19 @@ static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
 static void adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off, int val)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
-	regmap_update_bits(adp5585_gpio->regmap, ADP5585_GPO_DATA_OUT_A + bank,
+	regmap_update_bits(adp5585_gpio->regmap, regs->gpo_data_a + bank,
 			   bit, val ? bit : 0);
 }
 
 static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
 				 unsigned int off, unsigned int bias)
 {
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
 	unsigned int bit, reg, mask, val;
 
 	/*
@@ -106,8 +140,10 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
 	 * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4 bits
 	 * after R5.
 	 */
-	bit = off * 2 + (off > 5 ? 4 : 0);
-	reg = ADP5585_RPULL_CONFIG_A + bit / 8;
+	bit = off * 2;
+	if (info->has_bias_hole)
+		bit += (off > 5 ? 4 : 0);
+	reg = regs->rpull_cfg_a + bit / 8;
 	mask = ADP5585_Rx_PULL_CFG_MASK << (bit % 8);
 	val = bias << (bit % 8);
 
@@ -117,22 +153,24 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
 static int adp5585_gpio_set_drive(struct adp5585_gpio_dev *adp5585_gpio,
 				  unsigned int off, enum pin_config_param drive)
 {
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
 	return regmap_update_bits(adp5585_gpio->regmap,
-				  ADP5585_GPO_OUT_MODE_A + bank, bit,
+				  regs->gpo_out_a + bank, bit,
 				  drive == PIN_CONFIG_DRIVE_OPEN_DRAIN ? bit : 0);
 }
 
 static int adp5585_gpio_set_debounce(struct adp5585_gpio_dev *adp5585_gpio,
 				     unsigned int off, unsigned int debounce)
 {
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
 	return regmap_update_bits(adp5585_gpio->regmap,
-				  ADP5585_DEBOUNCE_DIS_A + bank, bit,
+				  regs->debounce_dis_a + bank, bit,
 				  debounce ? 0 : bit);
 }
 
@@ -173,6 +211,7 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
 static int adp5585_gpio_probe(struct platform_device *pdev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct adp5585_gpio_dev *adp5585_gpio;
 	struct device *dev = &pdev->dev;
 	struct gpio_chip *gc;
@@ -183,6 +222,11 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adp5585_gpio->regmap = adp5585->regmap;
+	adp5585_gpio->regs = adp5585->info->regs;
+
+	adp5585_gpio->info = (const struct adp5585_gpio_chip *)id->driver_data;
+	if (!adp5585_gpio->info)
+		return -ENODEV;
 
 	device_set_of_node_from_dev(dev, dev->parent);
 
@@ -197,7 +241,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->can_sleep = true;
 
 	gc->base = -1;
-	gc->ngpio = ADP5585_GPIO_MAX;
+	gc->ngpio = adp5585->info->max_cols + adp5585->info->max_rows;
 	gc->label = pdev->name;
 	gc->owner = THIS_MODULE;
 
@@ -209,8 +253,20 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct adp5585_gpio_chip adp5585_gpio_chip_info = {
+	.bank = adp5585_gpio_bank,
+	.bit = adp5585_gpio_bit,
+	.has_bias_hole = true,
+};
+
+static const struct adp5585_gpio_chip adp5589_gpio_chip_info = {
+	.bank = adp5589_gpio_bank,
+	.bit = adp5589_gpio_bit,
+};
+
 static const struct platform_device_id adp5585_gpio_id_table[] = {
-	{ "adp5585-gpio" },
+	{ "adp5585-gpio", (kernel_ulong_t)&adp5585_gpio_chip_info },
+	{ "adp5589-gpio", (kernel_ulong_t)&adp5589_gpio_chip_info },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, adp5585_gpio_id_table);

-- 
2.48.1



