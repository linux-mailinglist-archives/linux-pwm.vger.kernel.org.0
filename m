Return-Path: <linux-pwm+bounces-5903-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D9FAB3742
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C6E3A608E
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F5294A18;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHzA5f8C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD72949EB;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=KKO1knSQQz2gGDzyYROcI3rJi0+TZ2lpOxkS3ziEXUY6lX5v4zePmDnNVTOVeTvvcVlAmxTu5PtFo1P8TMSLZ+wGzcz9vVusfouWy74uIrd7GldiMxX+kcc7g4C0s05SQdV08/GEqEmalKDlabAFoTCXU2ezO5J9ftqEA7fwkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=1e7BO/+k+0jqq6UUzqzcr/UxUPcuJOlgOKNLiTCR4rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL/i9TVbu23bv4QgntSBZcS6PoaHTOi0KqN6wwhewMSGfH4DSCztuUWj78VigRKaJM4In/mEE0/g7jfWi5h6aOPyLWD/m55sqrK29nLtdEMIbl/d1aj+i++xRdxrD2+frqcBOvTwt0lC954/zUYSD3Z7MWALvDUrYzHvkmv5xmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHzA5f8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7986C4CEFA;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=1e7BO/+k+0jqq6UUzqzcr/UxUPcuJOlgOKNLiTCR4rc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XHzA5f8Ci28Z0Zg3YG5meKwxEZ07Q32GTZKjZ9uyh6QG4HefDV3SjtIqZVeTS/WL/
	 Efpits5i5b+0Pgvmn375WYBrIyNAaj0o5gw9Ip/JMLVXyxWB+WjSuoYHY0XRYVTNgK
	 ovIt+GCzy6b8cH7hMVJVavxHwEdQNqckpO1nudV2SuIeK3qW5ko+wMfnW/MPC7GvLG
	 8N1sg4UQymIUQGb8wgXbMH9PmDkxZCy3SH7nCaCFdCgulu2hdkZZuafUAzMIeDNiZU
	 BrB2ge2nkS9B54WAL1an0sBjuE2ndvbqdDkTSekjKd8pplnoVykEn4iDiQlZ/+/CSC
	 Qf4HD1I8wMwCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE424C3ABCD;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:38:59 +0100
Subject: [PATCH v3 07/22] mfd: adp5585: refactor how regmap defaults are
 handled
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-7-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=6031;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=INJMj4dmm5rb6ZcFd629hLh9WSgmUhj1hwXrpUObZGg=;
 b=L655VQ/vKuHr7UdbvAEuFMga7AdMmagOO9x4ieQKzhUNDkV0C18QlGF4pkpAkpSJe5IR20M4I
 8g3F875ePjMDFo9LpT4rPSV5fxi2TuJjPJJSHxNXaaoUqg/aS9d1iGQ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The only thing changing between variants is the regmap default
registers. Hence, instead of having a regmap condig for every variant
(duplicating lots of fields), add a chip info type of structure with a
regmap id to identify which defaults to use and populate regmap_config
at runtime given a template plus the id. Also note that between
variants, the defaults can be the same which means the chip info
structure can be used in more than one compatible.

This will also make it simpler adding new chips with more variants.

Also note that the chip info structures are deliberately not const as
they will also contain lots of members that are the same between the
different devices variants and so we will fill those at runtime.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 94 +++++++++++++++++++++++++--------------------
 include/linux/mfd/adp5585.h | 11 ++++++
 2 files changed, 64 insertions(+), 41 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 19d4a0ab1bb4c261e82559630624059529765fbd..874aed7d7cfe052587720d899096c995c19667af 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -81,41 +81,34 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
 	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-enum adp5585_regmap_type {
-	ADP5585_REGMAP_00,
-	ADP5585_REGMAP_02,
-	ADP5585_REGMAP_04,
+static const struct regmap_config adp5585_regmap_config_template = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ADP5585_MAX_REG,
+	.volatile_table = &adp5585_volatile_regs,
+	.cache_type = REGCACHE_MAPLE,
+	.num_reg_defaults_raw = ADP5585_MAX_REG + 1,
 };
 
-static const struct regmap_config adp5585_regmap_configs[] = {
-	[ADP5585_REGMAP_00] = {
-		.reg_bits = 8,
-		.val_bits = 8,
-		.max_register = ADP5585_MAX_REG,
-		.volatile_table = &adp5585_volatile_regs,
-		.cache_type = REGCACHE_MAPLE,
-		.reg_defaults_raw = adp5585_regmap_defaults_00,
-		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_00),
-	},
-	[ADP5585_REGMAP_02] = {
-		.reg_bits = 8,
-		.val_bits = 8,
-		.max_register = ADP5585_MAX_REG,
-		.volatile_table = &adp5585_volatile_regs,
-		.cache_type = REGCACHE_MAPLE,
-		.reg_defaults_raw = adp5585_regmap_defaults_02,
-		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_02),
-	},
-	[ADP5585_REGMAP_04] = {
-		.reg_bits = 8,
-		.val_bits = 8,
-		.max_register = ADP5585_MAX_REG,
-		.volatile_table = &adp5585_volatile_regs,
-		.cache_type = REGCACHE_MAPLE,
-		.reg_defaults_raw = adp5585_regmap_defaults_04,
-		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
-	},
-};
+static int adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
+				      struct regmap_config *regmap_config)
+{
+	*regmap_config = adp5585_regmap_config_template;
+
+	switch (adp5585->info->regmap_type) {
+	case ADP5585_REGMAP_00:
+		regmap_config->reg_defaults_raw = adp5585_regmap_defaults_00;
+		return 0;
+	case ADP5585_REGMAP_02:
+		regmap_config->reg_defaults_raw = adp5585_regmap_defaults_02;
+		return 0;
+	case ADP5585_REGMAP_04:
+		regmap_config->reg_defaults_raw = adp5585_regmap_defaults_04;
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
 
 static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 			    struct mfd_cell **devs)
@@ -153,7 +146,7 @@ static void adp5585_osc_disable(void *data)
 
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
-	const struct regmap_config *regmap_config;
+	struct regmap_config regmap_config;
 	struct adp5585_dev *adp5585;
 	struct mfd_cell *devs;
 	unsigned int id;
@@ -165,8 +158,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, adp5585);
 
-	regmap_config = i2c_get_match_data(i2c);
-	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	adp5585->info = i2c_get_match_data(i2c);
+	if (!adp5585->info)
+		return -ENODEV;
+
+	ret = adp5585_fill_regmap_config(adp5585, &regmap_config);
+	if (ret)
+		return ret;
+
+	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
 				     "Failed to initialize register map\n");
@@ -223,22 +223,34 @@ static int adp5585_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
 
+static struct adp5585_info adp5585_info = {
+	.regmap_type = ADP5585_REGMAP_00,
+};
+
+static struct adp5585_info adp5585_02_info = {
+	.regmap_type = ADP5585_REGMAP_02,
+};
+
+static struct adp5585_info adp5585_04_info = {
+	.regmap_type = ADP5585_REGMAP_04,
+};
+
 static const struct of_device_id adp5585_of_match[] = {
 	{
 		.compatible = "adi,adp5585-00",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+		.data = &adp5585_info,
 	}, {
 		.compatible = "adi,adp5585-01",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+		.data = &adp5585_info,
 	}, {
 		.compatible = "adi,adp5585-02",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_02],
+		.data = &adp5585_02_info,
 	}, {
 		.compatible = "adi,adp5585-03",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+		.data = &adp5585_info,
 	}, {
 		.compatible = "adi,adp5585-04",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_04],
+		.data = &adp5585_04_info,
 	},
 	{ /* sentinel */ }
 };
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 016033cd68e46757aca86d21dd37025fd354b801..4b48614970a811a8a95116faa20e58ea4f19ede6 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -119,8 +119,19 @@
 
 struct regmap;
 
+enum adp5585_regmap_type {
+	ADP5585_REGMAP_00,
+	ADP5585_REGMAP_02,
+	ADP5585_REGMAP_04,
+};
+
+struct adp5585_info {
+	enum adp5585_regmap_type regmap_type;
+};
+
 struct adp5585_dev {
 	struct regmap *regmap;
+	const struct adp5585_info *info;
 };
 
 #endif

-- 
2.49.0



