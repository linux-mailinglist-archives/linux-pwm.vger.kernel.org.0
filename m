Return-Path: <linux-pwm+bounces-6357-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59900AD9D9F
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79094189D9BF
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242C2E3395;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXqU8tix"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230922E2EF1;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=AlpwZLWYLe+CI+0rgV/6fXpb9M8VX7eFfoNkOe0mao482NljfzsErzXyAhY5HHyM/GmhkcD5aFuiuIsN89yQsWX0hziB0PUA9X8Ok4FokcION9MzU/9UZK/Eh2WmljZK2wpOlHnwkBnEJiP30Nr6vNClMdXOSjf27cIHo3Rjaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=TM/YleoWNqfiUAnTsGayFy7VS9UJCRMbArUvgJMX7Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xc+JDbHjhy0xw7YgsyAKqV6wq5NjckwAm1l4Dwqhf2s8rPbIi7nhgdELuJ00yQdXAH4kKPIANxBfxJi3G9VEmYD759e9gEhFCTt1wipbnuR/3qWR/6eyJLva3+APnhwe2QPrqr2nU/vAQvXQfmEA2O/B3Mw7iL/QqY370Qb55Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXqU8tix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0225C116C6;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911830;
	bh=TM/YleoWNqfiUAnTsGayFy7VS9UJCRMbArUvgJMX7Lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WXqU8tix/bkBPsyh+vRK6vsgUyAMP5zSyuE97Isf9XlVHlFWw8ku2rSoxV4xQjnYa
	 oLkszP3rrhKV+2NwRFGidACAnDZzoNpPw6B+jsRPKAnDEE1e1zPWKuABtNQrdys8SY
	 cZGIPHnsCwm4s9AKnEtzhQcATziBu81Qn0GzdXHZsfvOt3IGPeOFfis3QrviJanHQa
	 xdOLIyMRXSGN11iwz9p2a/g8va1c1RhSgb4CrdPeMoatUSplzRbbTdr+IUeZOpow1b
	 6pCj99bhXYe7u/BLIZa4QPI/A1hLn+9XlCley7xu0Dq6SeyXWj/hoNP8lhhjBWilcB
	 S5CmlvD7mHjCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CA6C71157;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:35:59 +0100
Subject: [PATCH v5 08/20] mfd: adp5585: add a per chip reg struture
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-8-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=2954;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=aHv0sgc3kzGQQnUWiT+5dfj17j4+zvtulsaM8Z2ayI8=;
 b=pRmVlYIIRpMJvA5ajZyimDu20N0Ra9c7tG7rwvdGSv9PfttzjDZVhWGtI/NNwGELXeAzK3B5B
 EwItGQMaSdtCbdJ8fs3VJ77rjHat8HeQ2HC5ZN8PjgkUNRDaA1kD/zL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

There are some differences in the register map between the devices.
Hence, add a register structure per device. This will be needed in
following patches.

On top of that adp5585_fill_regmap_config() is renamed and reworked so
that the current struct adp5585_info act as template (they indeed
contain all the different data between variants) which can then be
complemented depending on the device (as identified by the id register).
This is done like this since a lot of the data is pretty much the same
between variants of the same device.

Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 10 ++++++++++
 include/linux/mfd/adp5585.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 54506e5b07dc505f51d3f21cc30adc55c191fc39..95f1f7b553e651a3b24dee2e1c68a3bbaa38cced 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -164,6 +164,14 @@ static const struct regmap_config adp5589_regmap_config_template = {
 	.num_reg_defaults_raw = ADP5589_MAX_REG + 1,
 };
 
+static const struct adp5585_regs adp5585_regs = {
+	.ext_cfg = ADP5585_PIN_CONFIG_C,
+};
+
+static const struct adp5585_regs adp5589_regs = {
+	.ext_cfg = ADP5589_PIN_CONFIG_D,
+};
+
 static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp5585)
 {
 	struct regmap_config *regmap_config;
@@ -175,6 +183,7 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	case ADP5585_03:
 	case ADP5585_04:
 		adp5585->id = ADP5585_MAN_ID_VALUE;
+		adp5585->regs = &adp5585_regs;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
 					     sizeof(struct regmap_config), GFP_KERNEL);
 		break;
@@ -182,6 +191,7 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	case ADP5589_01:
 	case ADP5589_02:
 		adp5585->id = ADP5589_MAN_ID_VALUE;
+		adp5585->regs = &adp5589_regs;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5589_regmap_config_template,
 					     sizeof(struct regmap_config), GFP_KERNEL);
 		break;
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 70e58122a36a7321dc95d095b806f06fa57c97c9..6ecb90a6276c0f8f2c983c62c7268505d74b6583 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -120,6 +120,7 @@
 /* ADP5589 */
 #define		ADP5589_MAN_ID_VALUE		0x10
 #define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
@@ -137,9 +138,14 @@ enum adp5585_variant {
 	ADP5585_MAX
 };
 
+struct adp5585_regs {
+	unsigned int ext_cfg;
+};
+
 struct adp5585_dev {
 	struct device *dev;
 	struct regmap *regmap;
+	const struct adp5585_regs *regs;
 	enum adp5585_variant variant;
 	unsigned int id;
 };

-- 
2.49.0



