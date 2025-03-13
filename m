Return-Path: <linux-pwm+bounces-5167-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71124A5F7A2
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BEB7ABF7A
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987532690E3;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpHwUlTM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D82268FF4;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=JfmD04oWFArrE/MQmUQx7aiRpMC936xFDxxti6nAc/cT0bTabRE0ehJ6PHSgG2b4u8NHlDHqGUR6joZWV4SdSuHbnmsv0z9Biu90YvdHA0w0bZfNKaCPkEgQkBaYcjag6NrSDfMa8KXBKgyVmm1IB21oVB3vTmFRg8HM5LHdc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=tt4Utqobtry0elLkZy/8b5K7bXpZf4SKtlf6QE2iyHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFQh1XQgh1IvhJ4eY7OwHutAvajZX0OmDFmiHBrW8YHQEMGfNhnpsA6V7bW/cCYUMLDBlamcp7l21ZN0f6gUfQoX9JWTSH9zswmaIsfSIx8qbUU4PuQ0raoQW+ee6dF6fRuQxaMs1NhHoBpMSVsGvosLLeGXIhJLJ640wLpyS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpHwUlTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90A70C4AF13;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=tt4Utqobtry0elLkZy/8b5K7bXpZf4SKtlf6QE2iyHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jpHwUlTMx8wrYMdV+VqVG6PjmFcO10IvcLqrm/pQP/SCdiRbbAxYrwRLBY+KiNhY/
	 7WaAeRjUBk4UP6AkvktpTBlfeVgScdlMmnNbBDg2QI3s1GMRC2wdAYscNga/EAmCxr
	 fEx/X80YSNmeVeIFIdgpegfUMUReN/LyXbPIi5yLlJbC3+rS3mtogRefmKSRfg+oeg
	 gXh9MRxZX4d9uFZ2PY2C9SLolobWkIs3sWidIZ5vEsIdcMbSQSyNUjDmfGIYQ2YaFS
	 o5X8SE9Lqb5njOBfq1cAWjvZ5URYkJ4vcCaqP4vRVSrXsL2Bb7pHs22UA6CUx5Uvp4
	 /+i7NJapG7bww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D038C282DE;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:33 +0000
Subject: [PATCH 16/18] mfd: adp5585: add support for a reset pin
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-16-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875562; l=1359;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FjlFHqph7I3VSZKc1cRPYbSwbj1DPL1FekJPsO/UbRs=;
 b=nbmzJMHYSHEI/3Jyqjaq0WzUemO9px1DIXtBLRv34BbbZhpb6GiX4/cMODjbx1Dys5b1pBq7y
 LRn4NSUcIQJDNcO4LgX1FxifvcHwNkO+JXlsOO2bVaNyPRm+7OAm5/c
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure to perform an Hardware reset during probe  if the pin is given
in FW.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 8f95a02661880477e5eddb4248e92ee1bc69d674..dd8c4221cacd5bbff3179c48015401279bbf3d33 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/mfd/core.h>
 #include <linux/minmax.h>
@@ -832,6 +833,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	const struct adp5585_info *info;
 	struct adp5585_dev *adp5585;
+	struct gpio_desc *gpio;
 	unsigned int id;
 	int ret;
 
@@ -853,6 +855,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
+	if (gpio) {
+		fsleep(30);
+		gpiod_set_value_cansleep(gpio, 0);
+		fsleep(60);
+	}
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
2.48.1



