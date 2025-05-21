Return-Path: <linux-pwm+bounces-6051-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66CABF533
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA57A188E957
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634872741B2;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfSUGcJJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADC270570;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=p7Ffk0p2f6LV9KYx5Yxtu4TvTrnUYcNxRUEeN92BNBL5Xw6X7xp8hcZMdnwkh/0isxlb3YR9kXHl5NJ2jJN/n8NtuDr2+TFjO+N4XtgwLBkzDu3SrcXDrCqBjI2ehKg+iQwQBJ6fhf8YgqPLjsWClq3Pit2KfGZ+zC6FFSDwRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=I6dinAnyzvKU4BzR/KjMoBYN7tIyAnaQ2xER2mcaYKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7H1OYSJ/oKWMEsibfFRnrBZfZEmOjOO/CyS8lZrGtf4wn4q/6GhE2d6RoT7wtuyxzyfDn1qUbTMwGFe2k6bo9Hr+1+jaouz/fIe1ooy5DpfB4ZWPNUwUObnUVpeOgHitZEeY8q6GG85W3KNbYqZOPTLvaS8kQPpLmfbtQ5XuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfSUGcJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 861F0C4CEF6;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832588;
	bh=I6dinAnyzvKU4BzR/KjMoBYN7tIyAnaQ2xER2mcaYKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YfSUGcJJ8+FO5lrF1y3LDc22/H+YAhDaxcq0QIiEy1zjJF/FtONL1U1rFKyZHcyiS
	 LLWJMTkt9Lx14uZWJSehR64E/tHEofrDHVt4RUhqmT02OEk1Ni47R4u8/r2W4HG0cQ
	 W3XnP1RbJxZtTWZ5W2NeCiIWf1HZtCeB7QitGXVm6CjN+TUbKxrewdQUnrV4+gNw1q
	 lbG5REWyFZHL2mDSTtMp+DzaCuIl7ZtXa+LTHOWdwkeaHr8Pzkn6oPLgtdxABiTalm
	 qQHqeWJomGI2bnoVo79GTd6sNJphDDkV8jTswai38dA5PgXlN2O0H+sX5PmsP4aR75
	 tEhjnJlCJbPIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7AAC3ABC9;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:02:58 +0100
Subject: [PATCH v4 08/20] mfd: adp5585: add a per chip reg struture
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-8-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=2635;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XA1lWQuxb7kOwZlsBaXLIk7ho0x94HOHXp0Aq/+w5Qs=;
 b=Cq1wuLRhBG6mL4v41W1pogVMRTCSCBijPZRDyTwBB+uGLx25d4+C3+DflLtmuHVJ+agnFV7/b
 LZTB3H/0Tb4BE4x6JbSzWfOtiF2kD6HXOraScgMOwEhY3/C1LrFvGcl
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

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 10 ++++++++++
 include/linux/mfd/adp5585.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 53ac46365e56874a05855f1df1843717148f181a..e90d16389732f3d8790eb910acd82be2033eaa7e 100644
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
 static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
 				       struct regmap_config *regmap_config)
 {
@@ -175,12 +183,14 @@ static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
 	case ADP5585_04:
 		*regmap_config = adp5585_regmap_config_template;
 		adp5585->id = ADP5585_MAN_ID_VALUE;
+		adp5585->regs = &adp5585_regs;
 		break;
 	case ADP5589_00:
 	case ADP5589_01:
 	case ADP5589_02:
 		*regmap_config = adp5589_regmap_config_template;
 		adp5585->id = ADP5589_MAN_ID_VALUE;
+		adp5585->regs = &adp5589_regs;
 		break;
 	default:
 		return -ENODEV;
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 40c87981e5a24f8a175cc41e38b1495ed9f194e5..a20aa435100aaccb5ed22910933e1856409ba397 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -120,6 +120,7 @@
 /* ADP5589 */
 #define		ADP5589_MAN_ID_VALUE		0x10
 #define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
@@ -137,7 +138,12 @@ enum adp5585_variant {
 	ADP5585_MAX
 };
 
+struct adp5585_regs {
+	unsigned int ext_cfg;
+};
+
 struct adp5585_dev {
+	const struct adp5585_regs *regs;
 	struct regmap *regmap;
 	struct device *dev;
 	enum adp5585_variant variant;

-- 
2.49.0



