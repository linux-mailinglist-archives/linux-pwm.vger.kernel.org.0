Return-Path: <linux-pwm+bounces-6658-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C630AEFC8E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7607A6E92
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33593277CAE;
	Tue,  1 Jul 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbo3242W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7311279333;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380312; cv=none; b=INwp00MzIH3AiC+1yInKTTQfYTp/2xemezpCRIqJERCrI4hqjko/XSgZytdL05CnypWq616T1/wkItHs/eZ8121jmz5cPEAa0Mpzw4VdQHz6Jyg6KiUtmLWhBNy5q5nUVP1gof6x9D3ApPV1d+ahI5k/EMMo/xQEOMT4h146Dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380312; c=relaxed/simple;
	bh=al4yOIO0plm4yDOTy/jrLNir9ebCG5gSc1WlG3CS6AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2hZXmRGYkD5+iR6saLcfNLhIIGk5P5EhIXBcDvXraNimW1wo185jR3kSiQmcMWhLJatL/nBTalkn4AEtY7XGMFEMXD+T9v7viWhfaw3lw4QtpqPGq6iSfNYNVH3nyOMyxBtKET1KAdAZ7PZAR/9HbE+Kv7PtbcRbT0wwT9EHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbo3242W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A68BC2BCB7;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380311;
	bh=al4yOIO0plm4yDOTy/jrLNir9ebCG5gSc1WlG3CS6AY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rbo3242WaKOXw3Ow5bZ5pN7bkobrp+EklUlpSRhLNNX2P1iu3YJT78VoxO0cw9kZv
	 1nw+unxY9rqyEEBM5ASLbTnrefKpPBeQ05RJfdBVHLE7PCwq99Z16zep8nVYGLXv/m
	 AKEQFMjNEIQXNNyCLswmtIJj2vMP7eYdYNiv2vvjKpOumHLB0HcGt70shpB9m4/CMU
	 1CDrbT98mswQMiAIAsgiM4eNEHoG1YWWjbQsyKDFdeq5n15Fx0sAsr9Q4TZs9c1YrF
	 tPHlPuyThKNYnjQNrbZumGvsQOl/UZs1jZjuPher5y1vq1sffPRhbqCdzf0DBCcF4a
	 TmhlgcwEeoq3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90646C7EE30;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 01 Jul 2025 15:32:13 +0100
Subject: [PATCH v7 18/20] mfd: adp5585: Support getting vdd regulator
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-dev-adp5589-fw-v7-18-b1fcfe9e9826@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751380320; l=1090;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gJg36NNZceTXtSFjislowLSrc6NrrWQ56HdLaQcQDpw=;
 b=n0ozIryBRX8i2rdO9m9Qf97maJYsNOVLrfuq8WGje3sjj+20s65eQ94Yb4PGYhOl3WNoBWORd
 wVVECV4yCa9Dp4AU6nH0y9YOtYSPZyBjd+gG/8G7BrGVNxSANHZxv5w
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
Changes in v6:
 - Removed new line added by mistake.
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



