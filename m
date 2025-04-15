Return-Path: <linux-pwm+bounces-5497-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79971A8A1A2
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6D8189AB39
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDC829B784;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knTRAHNe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C3C29B76B;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728560; cv=none; b=sbPys9MM5IDQT4Q6pH93eGGv/Deo19zIADkD5Oz2Xs9/2UoQ6IvFVeADPhcNtzardJZWmdWRKXc2GLvdKF/o4IiHjLpOojLIYRFNn8swZgBxihG3tKuIMYs+DeG9VTZqKjWS0Fb58j6P1Y1M4nZNgZZPXnyvIMqsYKm+GZfMTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728560; c=relaxed/simple;
	bh=rLn0yCnCMtxYmTQlgKBvmj60HZfLQgZ4sobAUNp/SKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHjpA5hECZ6Qf+Bm9keZkl7pla0lqwYH9T+YGyOT8bUWNE4qf6Lma4Arm79aH9syFi/DPd5ObXY8x92mSk9J6UARyzm/dLWJUF/e9yitPWiCxOSCD84rGA6Oa8l1oTTeQFfAYEjZjazniffPMEyCmgSJl3C7h9qDsEjLSFo4K8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knTRAHNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FBA8C4CEF9;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=rLn0yCnCMtxYmTQlgKBvmj60HZfLQgZ4sobAUNp/SKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=knTRAHNeBESEs4jntpiRg7xgQni1uw0KA4pUcUIv5LD0Hau6xNh5pvM1Vozg6/kRN
	 Eg7+2kN2q4Mex9kjaxgayvVhsRZtICaFhniZ17cV42dT8e0bClPJk2KjtIYJ8/uPGg
	 xmxxpI49RBCS4r9yVpELrsn3DfEygr/93W9S9A1YpgvyVwjqMLF6bC8Y+V7Apcle+C
	 fARdTxJcOqOocHoIp+YKonhO5SFMBSeghOlU+Z7er1PRw4VZ3JquogjN0LhPLE81Ra
	 u9e48Xc+3xJ1EFGAdjpcQ5LMSEJtdWZEjdnuBr+ESFYQ3qT1JBwG/RB45sNoFPfK7n
	 sqXdfylyiZK/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86578C369BD;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:23 +0100
Subject: [PATCH v2 07/17] gpio: adp5585: add support for the ad5589
 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-7-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728560; l=9249;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dhOobqAdoEg5vowYXwvlopJTrVq+rE29macO+WfMrlo=;
 b=NPdwKzFXvw/wJ77ViAHccMl95xnzYbI9UR22fP4x8t3W8gwAn/YYLtjK2i5angpN366ChzJli
 XHVYYhung9XAEeyXRhqTtb7qGHAb5GGzE2ObAQp3tgvpagZz0moBRsV
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/gpio-adp5585.c | 121 ++++++++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index d5c0f1b267c82a5002b50cbb7a108166439e4785..d8f8d5513d7f6a9acf5bdecccacc89c4615ce237 100644
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
@@ -90,17 +121,19 @@ static int adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off,
 				  int val)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
-	unsigned int bank = ADP5585_BANK(off);
-	unsigned int bit = ADP5585_BIT(off);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	unsigned int bank = adp5585_gpio->info->bank(off);
+	unsigned int bit = adp5585_gpio->info->bit(off);
 
-	return regmap_update_bits(adp5585_gpio->regmap,
-				  ADP5585_GPO_DATA_OUT_A + bank,
+	return regmap_update_bits(adp5585_gpio->regmap, regs->gpo_data_a + bank,
 				  bit, val ? bit : 0);
 }
 
 static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
 				 unsigned int off, unsigned int bias)
 {
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
 	unsigned int bit, reg, mask, val;
 
 	/*
@@ -108,8 +141,10 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
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
 
@@ -119,22 +154,24 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
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
 
@@ -175,6 +212,7 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
 static int adp5585_gpio_probe(struct platform_device *pdev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct adp5585_gpio_dev *adp5585_gpio;
 	struct device *dev = &pdev->dev;
 	struct gpio_chip *gc;
@@ -185,6 +223,11 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adp5585_gpio->regmap = adp5585->regmap;
+	adp5585_gpio->regs = adp5585->info->regs;
+
+	adp5585_gpio->info = (const struct adp5585_gpio_chip *)id->driver_data;
+	if (!adp5585_gpio->info)
+		return -ENODEV;
 
 	device_set_of_node_from_dev(dev, dev->parent);
 
@@ -199,7 +242,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->can_sleep = true;
 
 	gc->base = -1;
-	gc->ngpio = ADP5585_GPIO_MAX;
+	gc->ngpio = adp5585->info->max_cols + adp5585->info->max_rows;
 	gc->label = pdev->name;
 	gc->owner = THIS_MODULE;
 
@@ -211,8 +254,20 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
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
2.49.0



