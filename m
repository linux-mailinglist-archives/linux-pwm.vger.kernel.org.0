Return-Path: <linux-pwm+bounces-6593-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E0AEDBE4
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DC01896B1B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75813285070;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf+JwTFn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA8284B2F;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284366; cv=none; b=IFfuuqaol7cRmofucN4H6BV4udmB7qN6MX9aylVNfQXdKx78G3TKE81tVHcrzgJnmiz9jJz4TTt0+DDDUjEh5Djhgwv5bX1j5J8J1DrqGvtNbq/0wHmpc0dBZfvJEMIS+a5OXlg4LMoyi4OEfgC0FkQqQ7OQSv7u+wELsp7nhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284366; c=relaxed/simple;
	bh=FB/+Jwyeg9c6SqzBV1qspx/0rP/63bu1i+qu5v/pgTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pp6YH0Wxv35OSAPHnINYg8VuFwWDrLN7Uk1sRzRe/uODrzQdA3qQg1umHhGuc08Xmlyc6I9SgYh5ehPbqOyKYitjeYqR88UfP/qInThkML83uf9w2PnDU94jHf2GYZ0HrMXkBYspeLeydjMyh+6F8bMTWmg067bBtSP2Ly/Yvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf+JwTFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6207C4CEF6;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284365;
	bh=FB/+Jwyeg9c6SqzBV1qspx/0rP/63bu1i+qu5v/pgTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Sf+JwTFnqBsRoduhq4bImhauYssXEPHKd6V4S1GbRbE/B6fAiWamRJLse1+PyBz4Y
	 wP0//aQijKOaPJFiHGhWP23i/3A83un7FoSfqLY+hZ2OoryBtrGODfo03LVYBoegoU
	 XZYLvo8H8G0EV/Xn98ujvXwKk7zumvFmknjraskRiS2YKKE+NwhZEwkzqovqvFs3Hj
	 tHA9v88GCCd/vq9qqPlPXNK4wPKb7mKf3NkwbOpIyBwi8bVIC/hKnRA3iMbxFDn/gV
	 JZ61+blhMv+KGHsnKnT3qEWORIK9ceLlEzoulNuH7oBiGVxHI0yCrVsCNCuZiFsP/W
	 Nbnz39i1mCdiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACBC7EE2A;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:52:59 +0100
Subject: [PATCH v6 08/20] mfd: adp5585: Add a per chip reg struture
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-8-a0f392a0ba91@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=2942;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JIBUmnMl1mN7KNjDMWXdwdkyiw75v+fDjUWNAjKvsFg=;
 b=wkWq3jZG6MNYaq4enD/qUVmHJ5Rj4+56NYYnxTRMrg6NV/H3IvZd4fcVGIZdrnSxWX6ilRzTx
 8zmHvh73/sNBOM4NQ1zyQzQulvLjSi42SnJdlYiIw4whqHM9LxjNC5u
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
index 00996571ef900bece2d634cd9d05394fa04d550a..ae12372bdde9141034b28731e22758948438cb31 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -163,6 +163,14 @@ static const struct regmap_config adp5589_regmap_config_template = {
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
@@ -174,6 +182,7 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	case ADP5585_03:
 	case ADP5585_04:
 		adp5585->id = ADP5585_MAN_ID_VALUE;
+		adp5585->regs = &adp5585_regs;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
 					     sizeof(*regmap_config), GFP_KERNEL);
 		break;
@@ -181,6 +190,7 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	case ADP5589_01:
 	case ADP5589_02:
 		adp5585->id = ADP5589_MAN_ID_VALUE;
+		adp5585->regs = &adp5589_regs;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5589_regmap_config_template,
 					     sizeof(*regmap_config), GFP_KERNEL);
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
2.50.0



