Return-Path: <linux-pwm+bounces-6356-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF7AD9D9D
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1538189E126
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FFF2E3381;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHulA6Z8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B762E175B;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=XrgvIY8jOKQOxq8a3K670Zy5/ZZQeODSWz6DKH9elzttm7cygV7lbhgZCqQo2F1q8h1NdO6WLEL/Znc7LltXIqAxv1I7Q7K5OWS7qfT3SpGKqa/UL8fw23+p8FYyMrQplZW0BlzazyP2yZnUZ5186Im1N+uHwPLvrFdCj1e0OwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=Bt3OEOto8lAcYnM9DYxtEIKs3Atwy/5CwYl8GkBHLtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEt2t3NE6K4Wysta6e3xeyV9dkRBqOD0gpnlCHwHrIKvD/bRD43jazAXbUMiawCXac9GQV7ETqIgr/tTsPNrLn71TiJ4I1odYcDBcG1jnmQniyDbpsr3vujaMgSjLRUsqVsoo/WDJfhrm/rSBNOWZoVmHPgRyMM2q9GzW1Lx66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHulA6Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F892C4CEFE;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911830;
	bh=Bt3OEOto8lAcYnM9DYxtEIKs3Atwy/5CwYl8GkBHLtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SHulA6Z8LMxiAmXj3VxBP9QYpyJpovFr18sh+xFGN2Kbo5itakWr4YXci7+j21XPp
	 K3xl+wvnpRCpnD+sNoThzFy0tAWZ+4jjdBp4dne+ETDpGRSPvRpkE1phoUsPfKsrkz
	 MbnxMGeaMApAtv8vrkd/tDAm/s/TRGklN33iV/OopTb9Lo+qIUip1ebGU9Q9H78RGa
	 dSJcxtC5KDGYPDGWQx+QCA1ZGoi4lbKQ2h+Q775W4Sy/RTYYZMQElLYVM/oTcRx3Um
	 BiVK96uT8RjY8wTy13dj5KO+Abl/sVyt4Ml9wSKmVnFGBnvoWVOYxEMuAm8CASdHzm
	 EdHw4kmGB+Cfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96501C71150;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:35:58 +0100
Subject: [PATCH v5 07/20] mfd: adp5585: add support for adp5589
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-7-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=9231;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=eZr02PEXA/7hDFxZnRmfaiD13lpJf2zBp0hhPPQAvmg=;
 b=WBA4Ad77H10Ti+3poFIH6icdy5X6L5aTnqVGhixgEjasT/rpJJ8OHUiSKK9ji7AU84zMBHNrw
 XhRbfMZWS1zCvnJ+h+HvU6QIL1cICXv5GnwRMlbvfOAOAs/+OvKn7ab
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
 drivers/mfd/adp5585.c       | 123 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/mfd/adp5585.h |  10 ++++
 2 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index ec88adbace92791f10953fc2bbb463fc59557bd6..54506e5b07dc505f51d3f21cc30adc55c191fc39 100644
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
@@ -81,6 +95,45 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
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
 /* -1 since the enum starts at 1 for error checking in i2c_get_match_data() */
 static const u8 *adp5585_regmap_defaults[ADP5585_MAX] = {
 	[ADP5585_00] = adp5585_regmap_defaults_00,
@@ -88,6 +141,9 @@ static const u8 *adp5585_regmap_defaults[ADP5585_MAX] = {
 	[ADP5585_02] = adp5585_regmap_defaults_02,
 	[ADP5585_03] = adp5585_regmap_defaults_00,
 	[ADP5585_04] = adp5585_regmap_defaults_04,
+	[ADP5589_00] = adp5589_regmap_defaults_00,
+	[ADP5589_01] = adp5589_regmap_defaults_01,
+	[ADP5589_02] = adp5589_regmap_defaults_02,
 };
 
 static const struct regmap_config adp5585_regmap_config_template = {
@@ -99,33 +155,69 @@ static const struct regmap_config adp5585_regmap_config_template = {
 	.num_reg_defaults_raw = ADP5585_MAX_REG + 1,
 };
 
-static struct regmap_config *adp5585_fill_regmap_config(const struct adp5585_dev *adp5585)
+static const struct regmap_config adp5589_regmap_config_template = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ADP5589_MAX_REG,
+	.volatile_table = &adp5589_volatile_regs,
+	.cache_type = REGCACHE_MAPLE,
+	.num_reg_defaults_raw = ADP5589_MAX_REG + 1,
+};
+
+static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp5585)
 {
 	struct regmap_config *regmap_config;
 
-	regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
-				     sizeof(struct regmap_config), GFP_KERNEL);
+	switch (adp5585->variant) {
+	case ADP5585_00:
+	case ADP5585_01:
+	case ADP5585_02:
+	case ADP5585_03:
+	case ADP5585_04:
+		adp5585->id = ADP5585_MAN_ID_VALUE;
+		regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
+					     sizeof(struct regmap_config), GFP_KERNEL);
+		break;
+	case ADP5589_00:
+	case ADP5589_01:
+	case ADP5589_02:
+		adp5585->id = ADP5589_MAN_ID_VALUE;
+		regmap_config = devm_kmemdup(adp5585->dev, &adp5589_regmap_config_template,
+					     sizeof(struct regmap_config), GFP_KERNEL);
+		break;
+	default:
+		return ERR_PTR(-ENODEV);
+	}
+
 	if (!regmap_config)
 		return ERR_PTR(-ENOMEM);
 
 	regmap_config->reg_defaults_raw = adp5585_regmap_defaults[adp5585->variant];
+
 	return regmap_config;
 }
 
-static int adp5585_add_devices(struct device *dev)
+static int adp5585_add_devices(const struct adp5585_dev *adp5585)
 {
+	struct device *dev = adp5585->dev;
+	const struct mfd_cell *cells;
 	int ret;
 
+	if (adp5585->id == ADP5585_MAN_ID_VALUE)
+		cells = adp5585_devs;
+	else
+		cells = adp5589_devs;
+
 	if (device_property_present(dev, "#pwm-cells")) {
 		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
-					   &adp5585_devs[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
+					   &cells[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
 		if (ret)
 			return dev_err_probe(dev, ret, "Failed to add PWM device\n");
 	}
 
 	if (device_property_present(dev, "#gpio-cells")) {
 		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
-					   &adp5585_devs[ADP5585_DEV_GPIO], 1, NULL, 0, NULL);
+					   &cells[ADP5585_DEV_GPIO], 1, NULL, 0, NULL);
 		if (ret)
 			return dev_err_probe(dev, ret, "Failed to add GPIO device\n");
 	}
@@ -158,7 +250,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (!adp5585->variant)
 		return -ENODEV;
 
-	regmap_config = adp5585_fill_regmap_config(adp5585);
+	regmap_config = adp5585_fill_variant_config(adp5585);
 	if (IS_ERR(regmap_config))
 		return PTR_ERR(regmap_config);
 
@@ -172,7 +264,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to read device ID\n");
 
-	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
+	id &= ADP5585_MAN_ID_MASK;
+	if (id != adp5585->id)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
@@ -188,7 +281,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
-	return adp5585_add_devices(&i2c->dev);
+	return adp5585_add_devices(adp5585);
 }
 
 static int adp5585_suspend(struct device *dev)
@@ -228,6 +321,18 @@ static const struct of_device_id adp5585_of_match[] = {
 	}, {
 		.compatible = "adi,adp5585-04",
 		.data = (void *)ADP5585_04,
+	}, {
+		.compatible = "adi,adp5589-00",
+		.data = (void *)ADP5589_00,
+	}, {
+		.compatible = "adi,adp5589-01",
+		.data = (void *)ADP5589_01,
+	}, {
+		.compatible = "adi,adp5589-02",
+		.data = (void *)ADP5589_02,
+	}, {
+		.compatible = "adi,adp5589",
+		.data = (void *)ADP5589_00,
 	},
 	{ /* sentinel */ }
 };
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index c56af8d8d76c4ebc0ede1ee4769ca059de29f53c..70e58122a36a7321dc95d095b806f06fa57c97c9 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -117,6 +117,12 @@
 #define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
 #define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
 
+/* ADP5589 */
+#define		ADP5589_MAN_ID_VALUE		0x10
+#define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_INT_EN			0x4e
+#define ADP5589_MAX_REG			ADP5589_INT_EN
+
 struct regmap;
 
 enum adp5585_variant {
@@ -125,6 +131,9 @@ enum adp5585_variant {
 	ADP5585_02,
 	ADP5585_03,
 	ADP5585_04,
+	ADP5589_00,
+	ADP5589_01,
+	ADP5589_02,
 	ADP5585_MAX
 };
 
@@ -132,6 +141,7 @@ struct adp5585_dev {
 	struct device *dev;
 	struct regmap *regmap;
 	enum adp5585_variant variant;
+	unsigned int id;
 };
 
 #endif

-- 
2.49.0



