Return-Path: <linux-pwm+bounces-6646-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C026BAEFC69
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CA91899249
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E0278157;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9jc314v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1E277C8A;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380311; cv=none; b=El9lFSrH6OoHRWIM+SI/1FHMxTP94RJsctXPLSIY4zn+vyGNvf6HFNgXtkWDuu+w/5SlzIflDoCfNleei2mOrTQCNohhrfgcXXZ7cbT2qX0uTkC3U5Lb5uy+LxjpQaMDu7baeg+kJdBfqWe3am2/Zzwp76yX6NZsuW2l84N6BHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380311; c=relaxed/simple;
	bh=2SuUBgQ7ktXJ27BCyU93JWwxT5+HEcEpsC9CAr8rRV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDD8KVkqdvHaJNhMolLflGiocbMNueGi3Bi43yRlmDE1O5hNe0CDFAwHO7nT7lWStCDeisAQaTRghp/+0CgeAd8RveWKD7xkXWfJogsm/9s1X3iXz9UnX9Crb0fHJXJFaho6UCVneKT+s39eDn/iqUBp5XIX3ePo2PdJ3p95z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9jc314v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE884C116D0;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380311;
	bh=2SuUBgQ7ktXJ27BCyU93JWwxT5+HEcEpsC9CAr8rRV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j9jc314vP9qfNPasVE3kLz0zK+HtedHzP1R/71i7H489vAIBcBYZA5uGZ+/Po/pRX
	 utO1pW7VmVEtVZ3oVdgdIqFoXEJlSVcMuwXQr+SPlW4SEcY2QYcffOSnAONmhM7cSi
	 u2/AiyPq+Twe4RfdR2EzXdKYDIpa7P1B4eeZQWtfxbTymvt3hfhVN1By7pAl6GL7Xr
	 NBzhtQFjaFyca/TOxCjzEkp773kX4VjLfWXtJ8AgApVnsztIqHMz2Qt+eYKc/TEA0C
	 NiJHcE/W6HnMD5jgjdGzADPb0YZXwxN1swiJFFhlFhRRKmunDNV2skAGwvEhxpccNI
	 KIE11p0kBzb5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A47C8303A;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 01 Jul 2025 15:32:02 +0100
Subject: [PATCH v7 07/20] mfd: adp5585: Add support for adp5589
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-dev-adp5589-fw-v7-7-b1fcfe9e9826@analog.com>
References: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
In-Reply-To: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751380320; l=9101;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=RJt07nEki9HKnMs3jvuPES7fZWUGCpZJ2fFKJRnKBF0=;
 b=ZzUGMivCMCQvwTxlcr4qsjqrnX70mzNexLoEMnulJ/sg51z0Z2PRpz2/rUddKnLZsGWDSp+Y+
 k82/6UU0UCvDiwSSR5JxmVJS8kT57uu0GsEpLzT503vJvxpqy4JFWsi
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
index 4d92b63629289c816bc46b70d3171ce16b1ee33e..00996571ef900bece2d634cd9d05394fa04d550a 100644
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
@@ -81,12 +95,54 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
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
 static const u8 *adp5585_regmap_defaults[ADP5585_MAX] = {
 	[ADP5585_00] = adp5585_regmap_defaults_00,
 	[ADP5585_01] = adp5585_regmap_defaults_00,
 	[ADP5585_02] = adp5585_regmap_defaults_02,
 	[ADP5585_03] = adp5585_regmap_defaults_00,
 	[ADP5585_04] = adp5585_regmap_defaults_04,
+	[ADP5589_00] = adp5589_regmap_defaults_00,
+	[ADP5589_01] = adp5589_regmap_defaults_01,
+	[ADP5589_02] = adp5589_regmap_defaults_02,
 };
 
 static const struct regmap_config adp5585_regmap_config_template = {
@@ -98,33 +154,69 @@ static const struct regmap_config adp5585_regmap_config_template = {
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
-				     sizeof(*regmap_config), GFP_KERNEL);
+	switch (adp5585->variant) {
+	case ADP5585_00:
+	case ADP5585_01:
+	case ADP5585_02:
+	case ADP5585_03:
+	case ADP5585_04:
+		adp5585->id = ADP5585_MAN_ID_VALUE;
+		regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
+					     sizeof(*regmap_config), GFP_KERNEL);
+		break;
+	case ADP5589_00:
+	case ADP5589_01:
+	case ADP5589_02:
+		adp5585->id = ADP5589_MAN_ID_VALUE;
+		regmap_config = devm_kmemdup(adp5585->dev, &adp5589_regmap_config_template,
+					     sizeof(*regmap_config), GFP_KERNEL);
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
@@ -157,7 +249,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (!adp5585->variant)
 		return -ENODEV;
 
-	regmap_config = adp5585_fill_regmap_config(adp5585);
+	regmap_config = adp5585_fill_variant_config(adp5585);
 	if (IS_ERR(regmap_config))
 		return PTR_ERR(regmap_config);
 
@@ -171,7 +263,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to read device ID\n");
 
-	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
+	id &= ADP5585_MAN_ID_MASK;
+	if (id != adp5585->id)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
@@ -187,7 +280,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
-	return adp5585_add_devices(&i2c->dev);
+	return adp5585_add_devices(adp5585);
 }
 
 static int adp5585_suspend(struct device *dev)
@@ -227,6 +320,18 @@ static const struct of_device_id adp5585_of_match[] = {
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
2.50.0



