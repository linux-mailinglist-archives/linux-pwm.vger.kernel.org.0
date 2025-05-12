Return-Path: <linux-pwm+bounces-5907-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D5AB3756
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71090188E08F
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D22951C3;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN3Rag4b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BC268FEF;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=ZlLRVOw0LfEBZ3Pon9zV4CAxh3WCkMWr9uDzDuiWexFSVd5vKUuXts65rOKJ5p239s2CPchvH9LJpM/fUFDx3V6wjqWwZZ/lZQ5bV2MRkYq1nWejbBEsRT/vXD/AF3ZCZ76m4z8xG4/p0UpIO0YyrL6Koy+OmJBvshg3uG7UNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=+Z3OgcG6NmhI75pB7CsrfTUkC3dm5VDcThrvlhuUgEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFWYlhjYylFal2L2dljYIdeEQUIHB/5GKhYPd9oipzEGzAnB/kjaqTlJ6oVEof//51ohWbEoM4Oer7pBnEMRd6U0PeJ5uIi9EJDXYuDp156RcnVCNRVQ7da1cxZ2f4dVMnZYc8p1hqAsq33RHj3bPvkemAuziuepTJ5jC3af5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN3Rag4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3EF0C4CEEF;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=+Z3OgcG6NmhI75pB7CsrfTUkC3dm5VDcThrvlhuUgEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LN3Rag4bQYAG39iEgDkGd3Z8jMxMEOWmxx4TeeS81Ix0mCMGeXOTnjk+Xl7mKEM9O
	 O642ELfQeCJWKmGpqBSWt7NJtZFFcb2jRfvrmDhOCG90ECbl4K+X7CJkbyHMjw1wDT
	 Ek9MAFZe6pP0m0a/VA4dATeYEs4FtY0Co1Md0VB9f2hf709EJy80/iBjAH6wnUdo8L
	 ymkOQ2Rm7U4WlHDLT9hViby5zScNrFZ9ZVJm6b/B7k3ZwY2Cy+UdIpPzuAhIuaWaD2
	 q/1kJ8KQW7AHKc2amEBWM7ZtIwpb2XV25FPi7rwLw9ez58jdZ9IjTMZVXjLHomZrOp
	 k0DwTDj3N1vPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE1CC3ABCD;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:02 +0100
Subject: [PATCH v3 10/22] gpio: adp5585: add support for the adp5589
 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-10-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=11933;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pDuHcDXnmAw/iceQ1sHJQHg+5ypOq2Bt4+F0Sm6mJag=;
 b=sjlAQqoiTsUkj3SHjlVPJtCS1LnOxLF5Nv90UQUzv2yiX0lZDAbFsk+pOm08yp/0eV5f21LR2
 wiCPaS8isXDCBGCj+sJnSsEje9DsYJq2Y34u5TFaUBL5aDfzQD7Prd+
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

While at it move ADP558X_GPIO_MAX defines to the main header file and
rename them. That information will be needed by the top level device in
a following change.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/gpio-adp5585.c | 151 ++++++++++++++++++++++++++++++++++----------
 include/linux/mfd/adp5585.h |  18 +++---
 2 files changed, 126 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index d5c0f1b267c82a5002b50cbb7a108166439e4785..cdf107742579cb44d73cc030646358ba5a23fd97 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2022 NXP
  * Copyright 2024 Ideas on Board Oy
+ * Copyright 2025 Analog Devices, Inc.
  */
 
 #include <linux/device.h>
@@ -14,57 +15,106 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-#define ADP5585_GPIO_MAX	11
+/*
+ * Bank 0 covers pins "GPIO 1/R0" to "GPIO 6/R5", numbered 0 to 5 by the
+ * driver, and bank 1 covers pins "GPIO 7/C0" to "GPIO 11/C4", numbered 6 to
+ * 10. Some variants of the ADP5585 don't support "GPIO 6/R5". As the driver
+ * uses identical GPIO numbering for all variants to avoid confusion, GPIO 5 is
+ * marked as reserved in the device tree for variants that don't support it.
+ */
+#define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
+#define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
+
+/*
+ * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by the
+ * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 to
+ * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 16 to 18.
+ */
+#define ADP5589_BANK(n)			((n) >> 3)
+#define ADP5589_BIT(n)			BIT((n) & 0x7)
+
+struct adp5585_gpio_chip {
+	int (*bank)(unsigned int off);
+	int (*bit)(unsigned int off);
+	unsigned int max_gpio;
+	unsigned int debounce_dis_a;
+	unsigned int rpull_cfg_a;
+	unsigned int gpo_data_a;
+	unsigned int gpo_out_a;
+	unsigned int gpio_dir_a;
+	unsigned int gpi_stat_a;
+	bool has_bias_hole;
+};
 
 struct adp5585_gpio_dev {
 	struct gpio_chip gpio_chip;
+	const struct adp5585_gpio_chip *info;
 	struct regmap *regmap;
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
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
 	unsigned int val;
 
-	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
+	regmap_read(adp5585_gpio->regmap, info->gpio_dir_a + info->bank(off), &val);
 
-	return val & bit ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+	return val & info->bit(off) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
 
 static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned int off)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
 
-	return regmap_clear_bits(adp5585_gpio->regmap,
-				 ADP5585_GPIO_DIRECTION_A + bank, bit);
+	return regmap_clear_bits(adp5585_gpio->regmap, info->gpio_dir_a + info->bank(off),
+				 info->bit(off));
 }
 
 static int adp5585_gpio_direction_output(struct gpio_chip *chip, unsigned int off, int val)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	unsigned int bank = info->bank(off);
+	unsigned int bit = info->bit(off);
 	int ret;
 
-	ret = regmap_update_bits(adp5585_gpio->regmap,
-				 ADP5585_GPO_DATA_OUT_A + bank, bit,
-				 val ? bit : 0);
+	ret = regmap_update_bits(adp5585_gpio->regmap, info->gpo_data_a + bank,
+				 bit, val ? bit : 0);
 	if (ret)
 		return ret;
 
-	return regmap_set_bits(adp5585_gpio->regmap,
-			       ADP5585_GPIO_DIRECTION_A + bank, bit);
+	return regmap_set_bits(adp5585_gpio->regmap, info->gpio_dir_a + bank,
+			       bit);
 }
 
 static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	unsigned int bank = info->bank(off);
+	unsigned int bit = info->bit(off);
 	unsigned int reg;
 	unsigned int val;
 
@@ -79,8 +129,8 @@ static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
 	 * .direction_input(), .direction_output() or .set() operations racing
 	 * with this.
 	 */
-	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
-	reg = val & bit ? ADP5585_GPO_DATA_OUT_A : ADP5585_GPI_STATUS_A;
+	regmap_read(adp5585_gpio->regmap, info->gpio_dir_a + bank, &val);
+	reg = val & bit ? info->gpo_data_a : info->gpi_stat_a;
 	regmap_read(adp5585_gpio->regmap, reg + bank, &val);
 
 	return !!(val & bit);
@@ -90,17 +140,17 @@ static int adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off,
 				  int val)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
-	return regmap_update_bits(adp5585_gpio->regmap,
-				  ADP5585_GPO_DATA_OUT_A + bank,
+	return regmap_update_bits(adp5585_gpio->regmap, info->gpo_data_a + info->bank(off),
 				  bit, val ? bit : 0);
 }
 
 static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
 				 unsigned int off, unsigned int bias)
 {
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
 	unsigned int bit, reg, mask, val;
 
 	/*
@@ -108,8 +158,10 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
 	 * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4 bits
 	 * after R5.
 	 */
-	bit = off * 2 + (off > 5 ? 4 : 0);
-	reg = ADP5585_RPULL_CONFIG_A + bit / 8;
+	bit = off * 2;
+	if (info->has_bias_hole)
+		bit += (off > 5 ? 4 : 0);
+	reg = info->rpull_cfg_a + bit / 8;
 	mask = ADP5585_Rx_PULL_CFG_MASK << (bit % 8);
 	val = bias << (bit % 8);
 
@@ -119,22 +171,22 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
 static int adp5585_gpio_set_drive(struct adp5585_gpio_dev *adp5585_gpio,
 				  unsigned int off, enum pin_config_param drive)
 {
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
 	return regmap_update_bits(adp5585_gpio->regmap,
-				  ADP5585_GPO_OUT_MODE_A + bank, bit,
+				  info->gpo_out_a + info->bank(off), bit,
 				  drive == PIN_CONFIG_DRIVE_OPEN_DRAIN ? bit : 0);
 }
 
 static int adp5585_gpio_set_debounce(struct adp5585_gpio_dev *adp5585_gpio,
 				     unsigned int off, unsigned int debounce)
 {
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
 	return regmap_update_bits(adp5585_gpio->regmap,
-				  ADP5585_DEBOUNCE_DIS_A + bank, bit,
+				  info->debounce_dis_a + info->bank(off), bit,
 				  debounce ? 0 : bit);
 }
 
@@ -175,6 +227,7 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
 static int adp5585_gpio_probe(struct platform_device *pdev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct adp5585_gpio_dev *adp5585_gpio;
 	struct device *dev = &pdev->dev;
 	struct gpio_chip *gc;
@@ -186,6 +239,10 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 
 	adp5585_gpio->regmap = adp5585->regmap;
 
+	adp5585_gpio->info = (const struct adp5585_gpio_chip *)id->driver_data;
+	if (!adp5585_gpio->info)
+		return -ENODEV;
+
 	device_set_of_node_from_dev(dev, dev->parent);
 
 	gc = &adp5585_gpio->gpio_chip;
@@ -199,7 +256,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->can_sleep = true;
 
 	gc->base = -1;
-	gc->ngpio = ADP5585_GPIO_MAX;
+	gc->ngpio = adp5585_gpio->info->max_gpio;
 	gc->label = pdev->name;
 	gc->owner = THIS_MODULE;
 
@@ -211,8 +268,34 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct adp5585_gpio_chip adp5585_gpio_chip_info = {
+	.bank = adp5585_gpio_bank,
+	.bit = adp5585_gpio_bit,
+	.debounce_dis_a = ADP5585_DEBOUNCE_DIS_A,
+	.rpull_cfg_a = ADP5585_RPULL_CONFIG_A,
+	.gpo_data_a = ADP5585_GPO_DATA_OUT_A,
+	.gpo_out_a = ADP5585_GPO_OUT_MODE_A,
+	.gpio_dir_a = ADP5585_GPIO_DIRECTION_A,
+	.gpi_stat_a = ADP5585_GPI_STATUS_A,
+	.max_gpio = ADP5585_PIN_MAX,
+	.has_bias_hole = true,
+};
+
+static const struct adp5585_gpio_chip adp5589_gpio_chip_info = {
+	.bank = adp5589_gpio_bank,
+	.bit = adp5589_gpio_bit,
+	.debounce_dis_a = ADP5589_DEBOUNCE_DIS_A,
+	.rpull_cfg_a = ADP5589_RPULL_CONFIG_A,
+	.gpo_data_a = ADP5589_GPO_DATA_OUT_A,
+	.gpo_out_a = ADP5589_GPO_OUT_MODE_A,
+	.gpio_dir_a = ADP5589_GPIO_DIRECTION_A,
+	.gpi_stat_a = ADP5589_GPI_STATUS_A,
+	.max_gpio = ADP5589_PIN_MAX,
+};
+
 static const struct platform_device_id adp5585_gpio_id_table[] = {
-	{ "adp5585-gpio" },
+	{ "adp5585-gpio", (kernel_ulong_t)&adp5585_gpio_chip_info },
+	{ "adp5589-gpio", (kernel_ulong_t)&adp5589_gpio_chip_info },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, adp5585_gpio_id_table);
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index c8fa9684ecd3e869ab1fed7f257a340bfa4602f9..7865943e71ed17d63c1b9f30001bb93ab3aa6684 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -107,23 +107,23 @@
 
 #define ADP5585_MAX_REG			ADP5585_INT_EN
 
-/*
- * Bank 0 covers pins "GPIO 1/R0" to "GPIO 6/R5", numbered 0 to 5 by the
- * driver, and bank 1 covers pins "GPIO 7/C0" to "GPIO 11/C4", numbered 6 to
- * 10. Some variants of the ADP5585 don't support "GPIO 6/R5". As the driver
- * uses identical GPIO numbering for all variants to avoid confusion, GPIO 5 is
- * marked as reserved in the device tree for variants that don't support it.
- */
-#define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
-#define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
+#define ADP5585_PIN_MAX			11
 
 /* ADP5589 */
 #define		ADP5589_MAN_ID_VALUE		0x10
+#define ADP5589_GPI_STATUS_A		0x16
 #define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_RPULL_CONFIG_A		0x19
+#define ADP5589_DEBOUNCE_DIS_A		0x27
+#define ADP5589_GPO_DATA_OUT_A		0x2a
+#define ADP5589_GPO_OUT_MODE_A		0x2d
+#define	ADP5589_GPIO_DIRECTION_A	0x30
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
+#define ADP5589_PIN_MAX			19
+
 struct regmap;
 
 enum adp5585_regmap_type {

-- 
2.49.0



