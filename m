Return-Path: <linux-pwm+bounces-6050-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C4ABF534
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025A11896ABF
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01A272E77;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBu+oYXh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A39270567;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=RpZtd1/uAUc2G6KASLX07mPINCjdsSyLX2QIp98s8abQATpefwSuhKIi4n+OJBxvvLDnul7JWk14i+0IXggkVigfziqQotZMu+hU0JZYZiajU+How3kJl8S074kfazAdt4JKVnm6YksMYy6S/4gyRdoVMJn0JFkznnGrK7mc/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=crZN97wJcEkOw2Xc30SmINCPJxpGjvBBDUXBiGv6mKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epNsLXYjKo4F7nB1uMQBxMqSTLW5v8o+dZO1t/QTF31zqABnTxgwqDeMYLwQ9Ceb7bA7Gpfb2NU5ulsdqAEZwIIk5rpc1YwvJVhN6J5km/gOsFiH4zgK3HBPlPBEWR1574W6G72fh2fI/94v1/IWj4W9iBHbtzy87lyUG5u5i+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBu+oYXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 689C1C4CEF1;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832588;
	bh=crZN97wJcEkOw2Xc30SmINCPJxpGjvBBDUXBiGv6mKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oBu+oYXhFFO5qdQrGbPu/9ePsixEAW6mMjQmbbd4imQdUWur20aTqfxowpNHTRGWz
	 NYYWxPGg8mvPn9hHhQP4hLf3sBBBAKLQiP/SpqXSPyBNdG8Hwtu3GLFr7n8pA5I1bH
	 qnh/PejNIXTOrXbSvQ00SLTDc5ydAG0g2NXaXP0GX7tD0wKynpoixDRMsRkqbjn935
	 qKc5MNr5pA5HTIcx+E4LpPBuwKlJsoQcf8gWyugOQVVVZg+C7id/IlMw3Wff9ZhfSE
	 JxpgrHgjGm0l1tMyTRELL65/wZdzIcwMC/QCituwpFAnWLmO9cRiOUO3WWPNFtWSWl
	 Ym+ct7Z0Newtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654EDC54E92;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:02:56 +0100
Subject: [PATCH v4 06/20] mfd: adp5585: refactor how regmap defaults are
 handled
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-6-f2c988d7a7a0@analog.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
In-Reply-To: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=5705;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+bKRPRHDlB5UcRH6Y+ry0EWgZpgBRDClxWSUnGqJZE0=;
 b=gYczCTw9p7/GoJPHSI1pXb4smrf7B0zW1ynsJnAYuc/G6infEBGx6L5dv1HGYJRsyfkhI7BzC
 cmQxfRizV3ECoQLmiZy7CXRp8LxSd1/Pz2htX344JMnwozk6tdazF6w
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
 drivers/mfd/adp5585.c       | 74 +++++++++++++++++++++------------------------
 include/linux/mfd/adp5585.h | 10 ++++++
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 179dc284833ae8f39eefc6787dd2c7158dfd3ad7..672f3468bda5be6af85a5982c3626053b4cb59bf 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -81,42 +81,31 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
 	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-enum adp5585_regmap_type {
-	ADP5585_REGMAP_00,
-	ADP5585_REGMAP_02,
-	ADP5585_REGMAP_04,
+/* -1 since the enum starts at 1 for error checking in i2c_get_match_data()*/
+static const u8 *adp5585_regmap_defaults[ADP5585_MAX - 1] = {
+	[ADP5585_00 - 1] = adp5585_regmap_defaults_00,
+	[ADP5585_01 - 1] = adp5585_regmap_defaults_00,
+	[ADP5585_02 - 1] = adp5585_regmap_defaults_02,
+	[ADP5585_03 - 1] = adp5585_regmap_defaults_00,
+	[ADP5585_04 - 1] = adp5585_regmap_defaults_04,
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
 
+static void adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
+				       struct regmap_config *regmap_config)
+{
+	*regmap_config = adp5585_regmap_config_template;
+	regmap_config->reg_defaults_raw = adp5585_regmap_defaults[adp5585->variant - 1];
+}
+
 static void adp5585_remove_devices(void *dev)
 {
 	mfd_remove_devices(dev);
@@ -157,7 +146,7 @@ static void adp5585_osc_disable(void *data)
 
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
-	const struct regmap_config *regmap_config;
+	struct regmap_config regmap_config;
 	struct adp5585_dev *adp5585;
 	unsigned int id;
 	int ret;
@@ -168,8 +157,13 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, adp5585);
 
-	regmap_config = i2c_get_match_data(i2c);
-	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	adp5585->variant = (enum adp5585_variant)(uintptr_t)i2c_get_match_data(i2c);
+	if (!adp5585->variant)
+		return -ENODEV;
+
+	adp5585_fill_regmap_config(adp5585, &regmap_config);
+
+	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
 				     "Failed to initialize register map\n");
@@ -226,19 +220,19 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
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
index 016033cd68e46757aca86d21dd37025fd354b801..2813b20e638b6e73ef198e43af07ef29ff25f273 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -119,8 +119,18 @@
 
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
 	struct regmap *regmap;
+	enum adp5585_variant variant;
 };
 
 #endif

-- 
2.49.0



