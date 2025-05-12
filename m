Return-Path: <linux-pwm+bounces-5902-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9C2AB3744
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE3B188E7EB
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD11294A0D;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4fJLfkA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB52949E5;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=JYYtzBRd/SXvgNpGw54yPp70XS2zm/znVqjR2xb2w+GCzkG62ORI1cRrlb98DVs7Cjuf5igsZVlIzf6usIQdpsYsSJz3XuAKIApex+49DEz5WvOfEHJgSlG9OJKJo0xSqfGVik0cgUCPqIhkAy49s5qXNvzL0phQAiZl2H1ehk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=Rv+NxkFp9fP7zROhrxxLovAPtxbvD/1vaUttLKKo8b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8MCcucPam/DHT1gPbPqY9afi+whScTJ5ZfQHp0Va84yrFHBt+GjtIX2lLJz6XgSmxpWmCcs5d7N+qvefTMP2xLeys21cUBVRpsbM/fxLt6qdUXTZgeN4DM85Mier5jgl4DwsTw2g2/+eaB6Lew+G5QBspk3/VlF0EUle6tdY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4fJLfkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D78BCC113CF;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=Rv+NxkFp9fP7zROhrxxLovAPtxbvD/1vaUttLKKo8b0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I4fJLfkAkvFDIRclyt3BDJgRMUHl/0eig9Q25AMYqW2y7LjOyWzL8D0n4fIScQSTS
	 MPwm6HCJV3/kuZ0n9kU5j9mkaRZRFeD59UT4SpYKeMKk26p11tlP2CHtKnA0nG9261
	 MK7Q9b8Y0PLd3E27WixmMHV/NvvgOhFCk1LUErCUO17VCwUVcb2dsqrurUWjJmna0O
	 iOVXR207juXJSqxCxg/lVqBH7/JW0TRo9VbvsUexUmB3VL/o+BngwZKsKZ1+kYCw82
	 InGFVaHdIVDNbKmMC1BL5vza2Ae3ICJsty61w6Tw6E6HdiVJkAGb+kBZzaftJH0TmQ
	 2wlCc86o6lwPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE83FC3ABD4;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:00 +0100
Subject: [PATCH v3 08/22] mfd: adp5585: add support for adp5589
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-8-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=8627;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7qn1pDEf2sTXJl+c3cm0c/bVSfL9pSKfy2RjaXpglzM=;
 b=TWxCFplEKaic4WWNCC3bq62E9fHJ/E8Y1LlN/i/0FSjOiQD17+VxP4Rdhni1ot17O0sjnp+nr
 4hLvdYftnf5D8AfzfYF2i8NIbq3dXgdgHqaxUKztH4IYht3XZM6ylKa
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
programmable logic, reset generator, and PWM generator.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 119 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/adp5585.h |  10 ++++
 2 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 874aed7d7cfe052587720d899096c995c19667af..d593d21920c960f397a79f1b3f5c7118fedea73a 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -29,6 +29,11 @@ static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
 	MFD_CELL_NAME("adp5585-pwm"),
 };
 
+static const struct mfd_cell adp5589_devs[] = {
+	MFD_CELL_NAME("adp5589-gpio"),
+	MFD_CELL_NAME("adp5589-pwm"),
+};
+
 static const struct regmap_range adp5585_volatile_ranges[] = {
 	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
 };
@@ -38,6 +43,15 @@ static const struct regmap_access_table adp5585_volatile_regs = {
 	.n_yes_ranges = ARRAY_SIZE(adp5585_volatile_ranges),
 };
 
+static const struct regmap_range adp5589_volatile_ranges[] = {
+	regmap_reg_range(ADP5585_ID, ADP5589_GPI_STATUS_C),
+};
+
+static const struct regmap_access_table adp5589_volatile_regs = {
+	.yes_ranges = adp5589_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(adp5589_volatile_ranges),
+};
+
 /*
  * Chip variants differ in the default configuration of pull-up and pull-down
  * resistors, and therefore have different default register values:
@@ -81,6 +95,54 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
 	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
+static const u8 adp5589_regmap_defaults_00[ADP5589_MAX_REG + 1] = {
+	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const u8 adp5589_regmap_defaults_01[ADP5589_MAX_REG + 1] = {
+	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
+	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
+};
+
+static const u8 adp5589_regmap_defaults_02[ADP5589_MAX_REG + 1] = {
+	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x18 */ 0x00, 0x41, 0x01, 0x00, 0x11, 0x04, 0x00, 0x00,
+	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct regmap_config adp5589_regmap_config_template = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ADP5589_MAX_REG,
+	.volatile_table = &adp5589_volatile_regs,
+	.cache_type = REGCACHE_MAPLE,
+	.num_reg_defaults_raw = ADP5589_MAX_REG + 1,
+};
+
 static const struct regmap_config adp5585_regmap_config_template = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -93,7 +155,10 @@ static const struct regmap_config adp5585_regmap_config_template = {
 static int adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
 				      struct regmap_config *regmap_config)
 {
-	*regmap_config = adp5585_regmap_config_template;
+	if (adp5585->info->id == ADP5585_MAN_ID_VALUE)
+		*regmap_config = adp5585_regmap_config_template;
+	else
+		*regmap_config = adp5589_regmap_config_template;
 
 	switch (adp5585->info->regmap_type) {
 	case ADP5585_REGMAP_00:
@@ -105,6 +170,15 @@ static int adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
 	case ADP5585_REGMAP_04:
 		regmap_config->reg_defaults_raw = adp5585_regmap_defaults_04;
 		return 0;
+	case ADP5589_REGMAP_00:
+		regmap_config->reg_defaults_raw = adp5589_regmap_defaults_00;
+		return 0;
+	case ADP5589_REGMAP_01:
+		regmap_config->reg_defaults_raw = adp5589_regmap_defaults_01;
+		return 0;
+	case ADP5589_REGMAP_02:
+		regmap_config->reg_defaults_raw = adp5589_regmap_defaults_02;
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -114,6 +188,7 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 			    struct mfd_cell **devs)
 {
 	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
+	const struct mfd_cell *cells;
 
 	if (device_property_present(dev, "#pwm-cells"))
 		has_pwm = 1;
@@ -129,10 +204,15 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 	if (!*devs)
 		return -ENOMEM;
 
+	if (adp5585->info->id == ADP5585_MAN_ID_VALUE)
+		cells = adp5585_devs;
+	else
+		cells = adp5589_devs;
+
 	if (has_pwm)
-		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_PWM];
+		(*devs)[rc++] = cells[ADP5585_DEV_PWM];
 	if (has_gpio)
-		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_GPIO];
+		(*devs)[rc++] = cells[ADP5585_DEV_GPIO];
 
 	return rc;
 }
@@ -176,7 +256,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to read device ID\n");
 
-	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
+	id &= ADP5585_MAN_ID_MASK;
+	if (id != adp5585->info->id)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
@@ -225,14 +306,32 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
 
 static struct adp5585_info adp5585_info = {
 	.regmap_type = ADP5585_REGMAP_00,
+	.id = ADP5585_MAN_ID_VALUE,
 };
 
 static struct adp5585_info adp5585_02_info = {
 	.regmap_type = ADP5585_REGMAP_02,
+	.id = ADP5585_MAN_ID_VALUE,
 };
 
 static struct adp5585_info adp5585_04_info = {
 	.regmap_type = ADP5585_REGMAP_04,
+	.id = ADP5585_MAN_ID_VALUE,
+};
+
+static struct adp5585_info adp5589_info = {
+	.regmap_type = ADP5589_REGMAP_00,
+	.id = ADP5589_MAN_ID_VALUE,
+};
+
+static struct adp5585_info adp5589_01_info = {
+	.regmap_type = ADP5589_REGMAP_01,
+	.id = ADP5589_MAN_ID_VALUE,
+};
+
+static struct adp5585_info adp5589_02_info = {
+	.regmap_type = ADP5589_REGMAP_02,
+	.id = ADP5589_MAN_ID_VALUE,
 };
 
 static const struct of_device_id adp5585_of_match[] = {
@@ -251,6 +350,18 @@ static const struct of_device_id adp5585_of_match[] = {
 	}, {
 		.compatible = "adi,adp5585-04",
 		.data = &adp5585_04_info,
+	}, {
+		.compatible = "adi,adp5589-00",
+		.data = &adp5589_info,
+	}, {
+		.compatible = "adi,adp5589-01",
+		.data = &adp5589_01_info,
+	}, {
+		.compatible = "adi,adp5589-02",
+		.data = &adp5589_02_info,
+	}, {
+		.compatible = "adi,adp5589",
+		.data = &adp5589_info,
 	},
 	{ /* sentinel */ }
 };
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 4b48614970a811a8a95116faa20e58ea4f19ede6..5e19e38d4eac563275b01c3ec613ea62eba9d6c6 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -117,16 +117,26 @@
 #define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
 #define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
 
+/* ADP5589 */
+#define		ADP5589_MAN_ID_VALUE		0x10
+#define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_INT_EN			0x4e
+#define ADP5589_MAX_REG			ADP5589_INT_EN
+
 struct regmap;
 
 enum adp5585_regmap_type {
 	ADP5585_REGMAP_00,
 	ADP5585_REGMAP_02,
 	ADP5585_REGMAP_04,
+	ADP5589_REGMAP_00,
+	ADP5589_REGMAP_01,
+	ADP5589_REGMAP_02,
 };
 
 struct adp5585_info {
 	enum adp5585_regmap_type regmap_type;
+	unsigned int id;
 };
 
 struct adp5585_dev {

-- 
2.49.0



