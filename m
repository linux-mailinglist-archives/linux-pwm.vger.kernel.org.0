Return-Path: <linux-pwm+bounces-6600-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B8AAEDBEF
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FF11897991
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC0285C9F;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZZJTbAh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D680285079;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284366; cv=none; b=qPcerXJeIB2u+v3p5A352lPmYV2eGFmtzm3xSGYD1h7DrFjUOaBPeLKHEV3uQ++GFCUaF2GLjP7a3yqxFIbnUyZoBVSnW2K71qAvaoHrQEypXIErhIppfgNKcOWffzQIEAmvN9uhVQgJaU9TDd4iwfxZDfD/T2cpE1clsmZS+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284366; c=relaxed/simple;
	bh=n7IfybdreFFu9Z1UbOn7l3K91l8Xmbuv9f2TzS/VHzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3ZS3gc6SJyF3s7dauvMfKw9l0EJKwEP6rR1wL8mcOsMcmSYgztiJ7QobXG9jK73CaUsBs92p6A2kNxgi0sZ6MBUp3GcNPdfTsDZjRuyhGOb7xAqjVCj/yNBFZ5QqBJEeHzzi5q13g90syUYn7MlY6JJkr72teKnNP1yxMvWUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZZJTbAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56723C4AF18;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284366;
	bh=n7IfybdreFFu9Z1UbOn7l3K91l8Xmbuv9f2TzS/VHzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TZZJTbAhqCnR9Y5MX6cEeZmq7/815FX7t4wtCnQ6m8TE0EK2zO9VnX4fCw3nQ4ESp
	 1cARjlKHLpM7Gpoq0HVaCrq82/ozevg3nTJiKlU1WwIFeyezqKfdzbVtR++4kxDFk/
	 9xxFxowEVa9bIZtr/gUwVDHWkCm0WbhQKrkA389n1YKOzgbvwmZqGDrcVB3KeyEium
	 9JMfrLBTGf6YHAzWzAzzNsmIwglqEfGfcazKOCoaE3C31vypmaYZRR65xQjHhVqKDV
	 p5T2OJ98iNrjUzDRPFWpMckUhAnmd7Y/JgVNuXUGp7yFpkhB3/wWZvqnpYnIt9zpKC
	 rZywDrvoeadHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49781C83033;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:53:09 +0100
Subject: [PATCH v6 18/20] mfd: adp5585: Support getting vdd regulator
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-18-a0f392a0ba91@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=1087;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=x/mc8NclA80MCHF0JDZl1lnL1soLtt2QZ9mBVZ2A8xU=;
 b=qesuR8bNax19aAOUadW4u9yUw9c1KbxolkphPxA1YQgpcF0jWmgbN5rEe2PfeRKtJO0ghYvDb
 +xHly3ITyA6Cayg+pPm3FlXC7uGEMFEU1aw/Jmg8mfMayTUQhF9kET8
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure we get and enable the VDD supply (if available).

Changes in v6:
 - Removed new line added by mistake.

Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 8f0fd737442611e00e61ea992dd6437dbaf31292..11a26f668653439378f9eb31d053c45772a940d0 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 enum {
@@ -709,6 +710,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(regmap_config))
 		return PTR_ERR(regmap_config);
 
+	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
+	if (ret)
+		return ret;
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
2.50.0



