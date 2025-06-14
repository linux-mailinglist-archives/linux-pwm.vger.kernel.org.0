Return-Path: <linux-pwm+bounces-6358-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6835EAD9DA0
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4F189E057
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB762E6138;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTTCCcP2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD472E2F02;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=Rf97fRmDZV5Pq7oyT2mKxjrcLqtZZIzeJPKFnGx3vAjTQC/TRhmXPamDmEootbF5LkhmU872RMjPqPTfMXnB73dMDXrpwtG1bywmWHuxclAaL9ix3owg9Ho762nDOxWmY42mGeQ8wmiAdl+2pBFS5dhUovjqn2I1/2HUfWnG+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=pwEf5oQ6f0UJUkQD/DkRxND9r59SouE6zysoycmymhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WktX+bEYpaSIIkXEPxbQXP7Vpdr964swBaoIFU7V70JDkOORYpRtdk5yD+LEnrJ39V1A0dYR+c2GS/nJG/XcyfkjzO1XrCTwxZrFMGt0VY7gZFKr8D/zu3jLhSQO5cnOM+tEzmwtvIoZzIm6aEXYfzkLCTKWZEWJo204iN26nrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTTCCcP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE991C116D0;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911830;
	bh=pwEf5oQ6f0UJUkQD/DkRxND9r59SouE6zysoycmymhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KTTCCcP24OvfzRK5i7ccMMtWrMS3PF2O6aC54G07U/n2iDO5F3YFsWF6T9qosmIJ7
	 OpRAvbvCa9u+oY4p8QcP1mxHqUypZAnuKD8fjBPv8zdfV4RyO+wyFwSyRpr49hNKWH
	 U8zd2TLtN/RKPmJCOAPlc/JUNDtXi5Q2mRY5SJ5otiqPTf4/QOsMCSE8/bFsGNwadi
	 /yDIR1zEZIN3N4zolGp0xxL3LHZVE8p4vy/lvw998eyeVFIEU+NUA23ewx+FGx/2zD
	 8rDbWcbGRpyuY0hcrzL2Zm7iFDF8SAH2+Q35KLUmdbggoVCc/q18Q4CFM+92jB6TTG
	 VL77RonKoyOCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D0C71153;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:36:00 +0100
Subject: [PATCH v5 09/20] gpio: adp5585: add support for the adp5589
 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-9-7e9d84906268@analog.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
In-Reply-To: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=11930;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tHn1+0SSnZFyuiAwBLKwEVgSUKg//zQNSaTBjp7vr3Y=;
 b=hBbA2PM+llwlDqIRYhWRmnu44S7QlxQcl9dIon8joFe4TvwZRm2N7XzUKu/CcvRcyR3bz4UYc
 96hJl8P45idDAuTcOVgQyPGXGyLYq+7zzAepJvfkS4G3xi5JkjlkLVB
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
index 6ecb90a6276c0f8f2c983c62c7268505d74b6583..d26f722cf31af5416eefecab5e542e66b01321f6 100644
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
+#define		ADP5589_GPIO_DIRECTION_A	0x30
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
+#define ADP5589_PIN_MAX			19
+
 struct regmap;
 
 enum adp5585_variant {

-- 
2.49.0



