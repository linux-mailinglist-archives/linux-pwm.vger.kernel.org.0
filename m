Return-Path: <linux-pwm+bounces-5157-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB374A5F78D
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7265219C35DF
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEB2686A6;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAG1I6nl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE7267F7A;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875558; cv=none; b=uMkQzsF1rNd+dqDiu+oAXx/hNZ45G1kTX/ajnAzlRHX5FVk20Ijge+xFk1Enu2CHVJKNk7QGncGZeumPUYcLv+6+m5Qzm8RzvhmCQgZ1kkEsYw+HmA/3+DmN8aIYcWBvlas2GdTgc4ChxzO4/H+3HdAUYnmQDd/ouGUPnhfo6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875558; c=relaxed/simple;
	bh=o5yBWRYFffB+B6HFBigf6FuZSl3VOZCp/XCrSOcXnGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYmaW92J5krOOXVPoWKjjm2oNesooJfIcsKO0PL5nV+qWtMjGTVZSbz6U/lEk0q+cbnPRdtfDpMRex/PzOBHGSGIOx13Vmlivkad6NLpzMm/Ekv9N6yDGQxA35IyrwQXvXBmIDC1MgaY6ZLx1RRVQZbgKPbSHlIrjjhff0W/OPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAG1I6nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1699C113D0;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875557;
	bh=o5yBWRYFffB+B6HFBigf6FuZSl3VOZCp/XCrSOcXnGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KAG1I6nlgX67/lfcIx3oExTNcGUqlww4vy4cF7ouro2IhaEqG0EoI4T2YUGn1CwUs
	 hAXBxfO+1qkqPGneuS4Q+wE8TPO5TICK7iWYSOBIQ7KTpuYN4ppULtZ/sSq79431PY
	 WwMHa1Get/Kcf4SHWXDZu/UV2YR2yRcTQ9murPvGCUIxzKbv7v7iVjzptumVrI+9rz
	 eL/RGyZfGDd++Dz9JW+S0+hlRzrIZ0f748foi+Barhnf57FJciuc67OCLCYnDnWHnT
	 MCBZSjzQdgCPIOOCAZdZU9jhjBdWKPdM3UeLOSviBKEGUojpklvnMEGLiZeO1uYcHZ
	 S2OYuUbazjRqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B6EC282DE;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:23 +0000
Subject: [PATCH 06/18] mfd: adp5585: add support for adp5589
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-6-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=13307;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=B0MInnU7VvqcOXSj1PG2OiRKYWLWNMbXF/wxzsCpKPY=;
 b=1EAgWpkBZ6yerxkQOym0NzHpIMtqto6bV3RutrtHguSHxYTDp17VNldK2wPhMynoubqfdID3X
 FLHfk2J2RPPCG55zU2AF9EXO64/HuizvL5RbB95jXeN4gn19W0iXbel
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
programmable logic, reset generator, and PWM generator.

This patch adds the foundation to add support for the adp5589 gpio and pwm
drivers. Most importantly, we need to differentiate between some
registers addresses. It also hints to future keymap support.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 215 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/adp5585.h |  57 +++++++++++-
 2 files changed, 264 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index fafe3ad93ea196e1eb8e79fecba58f36f12167eb..2fedc1c7cd08a7b3a8c7188d3e7cdfdf3122a214 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -25,6 +25,13 @@ static const struct mfd_cell adp5585_devs[] = {
 
 };
 
+static const struct mfd_cell adp5589_devs[] = {
+	MFD_CELL_NAME("adp5589-keys"),
+	MFD_CELL_NAME("adp5589-gpio"),
+	MFD_CELL_NAME("adp5589-pwm"),
+
+};
+
 static const struct regmap_range adp5585_volatile_ranges[] = {
 	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
 };
@@ -34,6 +41,15 @@ static const struct regmap_access_table adp5585_volatile_regs = {
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
@@ -77,10 +93,52 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
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
 enum adp5585_regmap_type {
 	ADP5585_REGMAP_00,
 	ADP5585_REGMAP_02,
 	ADP5585_REGMAP_04,
+	ADP5589_REGMAP_00,
+	ADP5589_REGMAP_01,
+	ADP5589_REGMAP_02,
 };
 
 static const struct regmap_config adp5585_regmap_configs[] = {
@@ -111,6 +169,131 @@ static const struct regmap_config adp5585_regmap_configs[] = {
 		.reg_defaults_raw = adp5585_regmap_defaults_04,
 		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
 	},
+	[ADP5589_REGMAP_00] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = ADP5589_MAX_REG,
+		.volatile_table = &adp5585_volatile_regs,
+		.cache_type = REGCACHE_MAPLE,
+		.reg_defaults_raw = adp5589_regmap_defaults_00,
+		.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_00),
+	},
+	[ADP5589_REGMAP_01] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = ADP5589_MAX_REG,
+		.volatile_table = &adp5585_volatile_regs,
+		.cache_type = REGCACHE_MAPLE,
+		.reg_defaults_raw = adp5589_regmap_defaults_01,
+		.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_01),
+	},
+	[ADP5589_REGMAP_02] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = ADP5589_MAX_REG,
+		.volatile_table = &adp5585_volatile_regs,
+		.cache_type = REGCACHE_MAPLE,
+		.reg_defaults_raw = adp5589_regmap_defaults_02,
+		.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_02),
+	},
+};
+
+static const struct adp5585_regs adp5585_regs = {
+	.debounce_dis_a = ADP5585_DEBOUNCE_DIS_A,
+	.rpull_cfg_a = ADP5585_RPULL_CONFIG_A,
+	.gpo_data_a = ADP5585_GPO_DATA_OUT_A,
+	.gpo_out_a = ADP5585_GPO_OUT_MODE_A,
+	.gpio_dir_a = ADP5585_GPIO_DIRECTION_A,
+	.gpi_stat_a = ADP5585_GPI_STATUS_A,
+	.pwm_cfg = ADP5585_PWM_CFG,
+	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
+	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
+	.gen_cfg = ADP5585_GENERAL_CFG,
+	.ext_cfg = ADP5585_PIN_CONFIG_C,
+};
+
+static const struct adp5585_regs adp5589_regs = {
+	.debounce_dis_a = ADP5589_DEBOUNCE_DIS_A,
+	.rpull_cfg_a = ADP5589_RPULL_CONFIG_A,
+	.gpo_data_a = ADP5589_GPO_DATA_OUT_A,
+	.gpo_out_a = ADP5589_GPO_OUT_MODE_A,
+	.gpio_dir_a = ADP5589_GPIO_DIRECTION_A,
+	.gpi_stat_a = ADP5589_GPI_STATUS_A,
+	.pwm_cfg = ADP5589_PWM_CFG,
+	.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
+	.pwm_ont_low = ADP5589_PWM_ONT_LOW,
+	.gen_cfg = ADP5589_GENERAL_CFG,
+	.ext_cfg = ADP5589_PIN_CONFIG_D,
+};
+
+static const struct adp5585_info adp5585_info = {
+	.adp5585_devs = adp5585_devs,
+	.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+	.n_devs = ARRAY_SIZE(adp5585_devs),
+	.id = ADP5585_MAN_ID_VALUE,
+	.regs = &adp5585_regs,
+	.max_rows = ADP5585_MAX_ROW_NUM,
+	.max_cols = ADP5585_MAX_COL_NUM,
+};
+
+static const struct adp5585_info adp5585_01_info = {
+	.adp5585_devs = adp5585_devs,
+	.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+	.n_devs = ARRAY_SIZE(adp5585_devs),
+	.id = ADP5585_MAN_ID_VALUE,
+	.regs = &adp5585_regs,
+	.max_rows = ADP5585_MAX_ROW_NUM,
+	.max_cols = ADP5585_MAX_COL_NUM,
+};
+
+static const struct adp5585_info adp5585_02_info = {
+	.adp5585_devs = adp5585_devs,
+	.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_02],
+	.n_devs = ARRAY_SIZE(adp5585_devs),
+	.id = ADP5585_MAN_ID_VALUE,
+	.regs = &adp5585_regs,
+	.max_rows = ADP5585_MAX_ROW_NUM,
+	.max_cols = ADP5585_MAX_COL_NUM,
+};
+
+static const struct adp5585_info adp5585_04_info = {
+	.adp5585_devs = adp5585_devs,
+	.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_04],
+	.n_devs = ARRAY_SIZE(adp5585_devs),
+	.id = ADP5585_MAN_ID_VALUE,
+	.regs = &adp5585_regs,
+	.max_rows = ADP5585_MAX_ROW_NUM,
+	.max_cols = ADP5585_MAX_COL_NUM,
+};
+
+static const struct adp5585_info adp5589_info = {
+	.adp5585_devs = adp5589_devs,
+	.regmap_config = &adp5585_regmap_configs[ADP5589_REGMAP_00],
+	.n_devs = ARRAY_SIZE(adp5589_devs),
+	.id = ADP5589_MAN_ID_VALUE,
+	.regs = &adp5589_regs,
+	.max_rows = ADP5589_MAX_ROW_NUM,
+	.max_cols = ADP5589_MAX_COL_NUM,
+};
+
+static const struct adp5585_info adp5589_01_info = {
+	.adp5585_devs = adp5589_devs,
+	.regmap_config = &adp5585_regmap_configs[ADP5589_REGMAP_01],
+	.n_devs = ARRAY_SIZE(adp5589_devs),
+	.id = ADP5589_MAN_ID_VALUE,
+	.regs = &adp5589_regs,
+	.max_rows = ADP5589_MAX_ROW_NUM,
+	.max_cols = ADP5589_MAX_COL_NUM,
+};
+
+static const struct adp5585_info adp5589_02_info = {
+	.adp5585_devs = adp5589_devs,
+	.regmap_config = &adp5585_regmap_configs[ADP5589_REGMAP_02],
+	.n_devs = ARRAY_SIZE(adp5589_devs),
+	.id = ADP5589_MAN_ID_VALUE,
+	.regs = &adp5589_regs,
+	.max_rows = ADP5589_MAX_ROW_NUM,
+	.max_cols = ADP5589_MAX_COL_NUM,
 };
 
 static void adp5585_osc_disable(void *data)
@@ -122,7 +305,7 @@ static void adp5585_osc_disable(void *data)
 
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
-	const struct regmap_config *regmap_config;
+	const struct adp5585_info *info;
 	struct adp5585_dev *adp5585;
 	unsigned int id;
 	int ret;
@@ -133,8 +316,13 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, adp5585);
 
-	regmap_config = i2c_get_match_data(i2c);
-	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	info = i2c_get_match_data(i2c);
+	if (!info)
+		return -ENODEV;
+
+	adp5585->info = info;
+
+	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
 				     "Failed to initialize register map\n");
@@ -144,7 +332,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to read device ID\n");
 
-	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
+	id &= ADP5585_MAN_ID_MASK;
+	if (id != adp5585->info->id)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
@@ -158,8 +347,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return ret;
 
 	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
-				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
-				   NULL, 0, NULL);
+				   adp5585->info->adp5585_devs,
+				   adp5585->info->n_devs, NULL, 0, NULL);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to add child devices\n");
@@ -203,7 +392,19 @@ static const struct of_device_id adp5585_of_match[] = {
 		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
 	}, {
 		.compatible = "adi,adp5585-04",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_04],
+		.data = &adp5585_04_info,
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
index 016033cd68e46757aca86d21dd37025fd354b801..dffe1449de01dacf8fe78cf0e87d1f176d11f620 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -104,9 +104,11 @@
 #define		ADP5585_INT_CFG			BIT(1)
 #define		ADP5585_RST_CFG			BIT(0)
 #define ADP5585_INT_EN			0x3c
-
 #define ADP5585_MAX_REG			ADP5585_INT_EN
 
+#define ADP5585_MAX_ROW_NUM		6
+#define ADP5585_MAX_COL_NUM		5
+
 /*
  * Bank 0 covers pins "GPIO 1/R0" to "GPIO 6/R5", numbered 0 to 5 by the
  * driver, and bank 1 covers pins "GPIO 7/C0" to "GPIO 11/C4", numbered 6 to
@@ -117,10 +119,63 @@
 #define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
 #define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
 
+/* ADP5589 */
+#define		ADP5589_MAN_ID_VALUE		0x10
+#define ADP5589_GPI_STATUS_A		0x16
+#define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_RPULL_CONFIG_A		0x19
+#define ADP5589_DEBOUNCE_DIS_A		0x27
+#define ADP5589_GPO_DATA_OUT_A		0x2a
+#define ADP5589_GPO_OUT_MODE_A		0x2d
+#define	ADP5589_GPIO_DIRECTION_A	0x30
+#define ADP5589_PWM_OFFT_LOW		0x3e
+#define ADP5589_PWM_ONT_LOW		0x40
+#define ADP5589_PWM_CFG			0x42
+#define ADP5589_PIN_CONFIG_D		0x4C
+#define ADP5589_GENERAL_CFG		0x4d
+#define ADP5589_INT_EN			0x4e
+#define ADP5589_MAX_REG			ADP5589_INT_EN
+
+#define ADP5589_MAX_ROW_NUM		8
+#define ADP5589_MAX_COL_NUM		11
+
+/*
+ * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by the
+ * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 to
+ * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 16 to 18.
+ */
+#define ADP5589_BANK(n)			((n) >> 3)
+#define ADP5589_BIT(n)			BIT((n) & 0x7)
+
+struct adp5585_regs {
+	unsigned int debounce_dis_a;
+	unsigned int rpull_cfg_a;
+	unsigned int gpo_data_a;
+	unsigned int gpo_out_a;
+	unsigned int gpio_dir_a;
+	unsigned int gpi_stat_a;
+	unsigned int pwm_cfg;
+	unsigned int pwm_offt_low;
+	unsigned int pwm_ont_low;
+	unsigned int gen_cfg;
+	unsigned int ext_cfg;
+};
+
+struct adp5585_info {
+	const struct mfd_cell *adp5585_devs;
+	const struct regmap_config *regmap_config;
+	const struct adp5585_regs *regs;
+	unsigned int n_devs;
+	unsigned int id;
+	u8 max_rows;
+	u8 max_cols;
+};
+
 struct regmap;
 
 struct adp5585_dev {
 	struct regmap *regmap;
+	const struct adp5585_info *info;
 };
 
 #endif

-- 
2.48.1



