Return-Path: <linux-pwm+bounces-6586-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E3AEDBBE
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5231610AF
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF20284B33;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1tQvzfW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E2283FF9;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284366; cv=none; b=eGDZFeSf06aNDV89lB6NlD8ZplA/5QGixu96acjCxeot8OOCSJAOB2vosV+/9HXy4zoaiHzNpXjmWaNqxdvVzjXa5hEnYjOTJa7v9KrWBwPH38lRBhB6zDbqzpfV0VzUGa6i1NhhBCVKKlw2yvkbTkVG8cpLJrbV666ZFyzgS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284366; c=relaxed/simple;
	bh=eEc8rkC5jiL7//R3Hi4CSaKwVGq6Cd0SG8QWSD8rLlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7p/YtunPhiPnedPYADANB6KqIcXwD0IAYRPSXVB6cuw2Dd9WR5+LrJPIOfIXgJRT4pq7YV/CzvtHfhbRZpjJAM1rrGo6kwbz9Swxxe29pZMrtkb6iCEkSLgsASbvliICVZp3jvJcyUKGoMC9TblkjXb/6MWXpRXTTFl1JGMuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1tQvzfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ACCAC4CEF9;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284365;
	bh=eEc8rkC5jiL7//R3Hi4CSaKwVGq6Cd0SG8QWSD8rLlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b1tQvzfWVuK30Ort4vs7ARR7m2hj6NqDBxFySUgTDstrASxhUgSNGl+3BNcpbnszj
	 eiCcO1KUqOxUKj5B86NbUAEaFgw1zOlQegW7nABEuc6dcAnE9oJzGho4eMUflZCuv5
	 dvAmpDD/qVQEAYkSnsvUJrTT7B6m8/8muUJ5MqypqXgF8TaNHbmDlxUr6OGlz+C9C2
	 qc5CdTIpap6le4UrlIODABlPh8qC/AZlwrKnr3YUaBiPX1UNYRTWZQg4tCEhPWQ9uG
	 z3R0ACHRy1Nxu5F4PGMHvpsYR7Ct+rUqu7Dp5QQ5/uZUbeX7CLwQtYtuQgtCUZSwqx
	 x/+gT/9ZGAM+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0BC8302F;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:52:57 +0100
Subject: [PATCH v6 06/20] mfd: adp5585: Refactor how regmap defaults are
 handled
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-6-a0f392a0ba91@analog.com>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
In-Reply-To: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=5861;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SjmOxQdFLSFVyJz/dSxFXjslYnvVTJtuMSj/yF1ljns=;
 b=Fgq8e1fMoy6mfRddV19uXmrlE5aASQ5Y22bE6N3dsRdh+L7TnLry3n80PLvwzGLia4X4uNBPy
 fbdAbUK5N8xBGmffhzQn/8epoYQfujvOBZzWxuWNe5ciA7kCJZ4ykSu
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The only thing changing between variants is the regmap default
registers. Hence, instead of having a regmap configuration for every
variant (duplicating lots of fields), add a chip info type of structure
with a regmap ID to identify which defaults to use and populate
regmap_config at runtime given a template plus the id. Also note that
between variants, the defaults can be the same which means the chip info
structure can be used in more than one compatible.

This will also make it simpler adding new chips with more variants.

Also note that the chip info structures are deliberately not const as
they will also contain lots of members that are the same between the
different devices variants and so we will fill those at runtime.

Changes in v6:
 - Use sizeof(*regmap_config);
 - Remove unneeded comment.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 80 +++++++++++++++++++++++----------------------
 include/linux/mfd/adp5585.h | 11 +++++++
 2 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index c764f481875831ff55bccb8cdc59421719afbedd..4d92b63629289c816bc46b70d3171ce16b1ee33e 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -81,42 +81,36 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
 	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-enum adp5585_regmap_type {
-	ADP5585_REGMAP_00,
-	ADP5585_REGMAP_02,
-	ADP5585_REGMAP_04,
+static const u8 *adp5585_regmap_defaults[ADP5585_MAX] = {
+	[ADP5585_00] = adp5585_regmap_defaults_00,
+	[ADP5585_01] = adp5585_regmap_defaults_00,
+	[ADP5585_02] = adp5585_regmap_defaults_02,
+	[ADP5585_03] = adp5585_regmap_defaults_00,
+	[ADP5585_04] = adp5585_regmap_defaults_04,
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
+static const struct regmap_config adp5585_regmap_config_template = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ADP5585_MAX_REG,
+	.volatile_table = &adp5585_volatile_regs,
+	.cache_type = REGCACHE_MAPLE,
+	.num_reg_defaults_raw = ADP5585_MAX_REG + 1,
 };
 
+static struct regmap_config *adp5585_fill_regmap_config(const struct adp5585_dev *adp5585)
+{
+	struct regmap_config *regmap_config;
+
+	regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
+				     sizeof(*regmap_config), GFP_KERNEL);
+	if (!regmap_config)
+		return ERR_PTR(-ENOMEM);
+
+	regmap_config->reg_defaults_raw = adp5585_regmap_defaults[adp5585->variant];
+	return regmap_config;
+}
+
 static int adp5585_add_devices(struct device *dev)
 {
 	int ret;
@@ -147,7 +141,7 @@ static void adp5585_osc_disable(void *data)
 
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
-	const struct regmap_config *regmap_config;
+	struct regmap_config *regmap_config;
 	struct adp5585_dev *adp5585;
 	unsigned int id;
 	int ret;
@@ -157,8 +151,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, adp5585);
+	adp5585->dev = &i2c->dev;
+
+	adp5585->variant = (enum adp5585_variant)(uintptr_t)i2c_get_match_data(i2c);
+	if (!adp5585->variant)
+		return -ENODEV;
+
+	regmap_config = adp5585_fill_regmap_config(adp5585);
+	if (IS_ERR(regmap_config))
+		return PTR_ERR(regmap_config);
 
-	regmap_config = i2c_get_match_data(i2c);
 	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
@@ -212,19 +214,19 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
 static const struct of_device_id adp5585_of_match[] = {
 	{
 		.compatible = "adi,adp5585-00",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+		.data = (void *)ADP5585_00,
 	}, {
 		.compatible = "adi,adp5585-01",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+		.data = (void *)ADP5585_01,
 	}, {
 		.compatible = "adi,adp5585-02",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_02],
+		.data = (void *)ADP5585_02,
 	}, {
 		.compatible = "adi,adp5585-03",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
+		.data = (void *)ADP5585_03,
 	}, {
 		.compatible = "adi,adp5585-04",
-		.data = &adp5585_regmap_configs[ADP5585_REGMAP_04],
+		.data = (void *)ADP5585_04,
 	},
 	{ /* sentinel */ }
 };
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 016033cd68e46757aca86d21dd37025fd354b801..c56af8d8d76c4ebc0ede1ee4769ca059de29f53c 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -119,8 +119,19 @@
 
 struct regmap;
 
+enum adp5585_variant {
+	ADP5585_00 = 1,
+	ADP5585_01,
+	ADP5585_02,
+	ADP5585_03,
+	ADP5585_04,
+	ADP5585_MAX
+};
+
 struct adp5585_dev {
+	struct device *dev;
 	struct regmap *regmap;
+	enum adp5585_variant variant;
 };
 
 #endif

-- 
2.50.0



