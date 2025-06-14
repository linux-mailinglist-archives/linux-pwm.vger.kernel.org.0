Return-Path: <linux-pwm+bounces-6369-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3257AD9DD5
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2E9189E2B0
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F32E3385;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcqmBbhr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE462E6D3B;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=kt6BZ/XssPslqOfg/n22883/Wj5iYxgWJBprt+ZLpkIPNHb9kgHxSQe8f/7pgGol/lxWsj6df4exGQlzajf56LIf+n3EtmLiHkRogesltGh70CcsxFbep7bkG6oz6zfYdrjUpMbyDgibaF6kxaVbwBMwehdUGOf1H9ZfhkbNy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=mLiaGU+SIn/Mgx1V/hSp9Hj1WK2nwp0MgZOKdibIj6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLo7PjmtuABlEdGy9mmVjECBq3l76L/RIbwN7JBEvyz5P51gJhIXbsnFQv8pk2iJS6O9TLOyt/x7qT9gYy4PoKLLN3+tvbiCGoV6ExIHhKgc3Mm1mjHRy4ROgGY0oswfqBwhthcUtFVXaaizo8a1w7IVKVjaALKiJESE+vNkKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcqmBbhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 654B6C4AF15;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911831;
	bh=mLiaGU+SIn/Mgx1V/hSp9Hj1WK2nwp0MgZOKdibIj6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dcqmBbhrHzXfydh6G/jKrZbk6UCn/Toy6IW3+yzm19BWlyKI890tAN3o1mO76ic4t
	 1jl1fdrVcamY2oP5U0xtHhEmmMzWzisaV6bg1owzjIgcfi4IGRNQyXO3kQt5V91c1x
	 o2Fch39oxGcngOGrfpJcmQ/hAdUDeDGkSKTmoeALFfD8unt7BAGWbCy3Sjeumbvc5y
	 AufXaw1tK4JAKSKMdi8UmpN4BziTsVhxYLVmYcqSqLkY4NWTMTKIFcZbSAc2CEfXbu
	 qD1r2KhiCrI5DH3hw/m5kPJ1S8yGzxPuXbyijzR/uCfwTeA3xPevEMjxELQlJAkBiH
	 duZ680h31HOag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A57BC71155;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:36:09 +0100
Subject: [PATCH v5 18/20] mfd: adp5585: support getting vdd regulator
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-18-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=1292;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YHxZoknRry0Hvk65sFGbz6N2xfvPc6b8ZJ/D4iQv1WE=;
 b=0hM2FsIW6Az+gChfSNnyXhFkFS73Ok6JojvajuTuwM37Q8I9Hj+36R8H3GefYF4TgUIp6Yjxf
 jx8qmSVylyKBtXZApkm/XEbl+j+QdqzudGDMj1ruFXNMtGYRAxnBZgZ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure we get and enable the VDD supply (if available).

Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 3a53bc895e60e6a10f797aebcc29b722906ff087..e4a725b9e1475be03cd26898faa7a7bb8de4319b 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 enum {
@@ -710,6 +711,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(regmap_config))
 		return PTR_ERR(regmap_config);
 
+	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
+	if (ret)
+		return ret;
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
@@ -726,6 +731,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 				     "Invalid device ID 0x%02x\n", id);
 
 	adp5585->pin_usage = devm_bitmap_zalloc(&i2c->dev, adp5585->n_pins, GFP_KERNEL);
+
 	if (!adp5585->pin_usage)
 		return -ENOMEM;
 

-- 
2.49.0



