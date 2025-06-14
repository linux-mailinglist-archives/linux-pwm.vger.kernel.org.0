Return-Path: <linux-pwm+bounces-6371-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D351AD9DCF
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA9A173191
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070BA2E7F35;
	Sat, 14 Jun 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPzjjRdQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15B2E763E;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=EHoS0SUsaC5DTD9MuV5nBGfquY3zmqVyfUT3eDu3X2PRFalpjtnP4Y8+zatNL8w9HF+iwJOXl5SigOuM6zGB/z4F9MojgS1UXt4iNWtLo/MiUPH1+xWMAKzgO9PYLGBluvR7mM14nSzKXdn4Yo7Pl+/JwxXG9m1gZeZRni6EPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=gqzuVzoAcoLMlqnde1DPNYsbEP4wBW42R1IzeJJN0Ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUkY7wzvq5ZHXBMHBOXwWE36aREpG0UNF/+r/E8ogtr4z/m2d5o92Wnry4aFCePxt1TaLx0mvCeo4tiG5XnFza67m0aU5OtsQ8pbJrzq7y5vDbcB2Gb3YHP+3PTFN9WR+ycGZxF8gzMtu6G3AqH5UQJqpDcTiGluc4w7QR0PIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPzjjRdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8414AC4CEEB;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911831;
	bh=gqzuVzoAcoLMlqnde1DPNYsbEP4wBW42R1IzeJJN0Ss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZPzjjRdQMJk/evsxSz5FKviRMXwLcb/OR9UVYnm4RTHvELi5oyE1vhRwpmHSO8URq
	 N2hPEXIqelD2a5VrQ5F9/wuAu3Lj1SMQ1J/KIY2y2y0rotS8hoq8ONvRMq4ag8g881
	 2ykULMCVW62aF6UjFkQWFxwt18pYcPutKiPBEUmL91vh1aCFT+FOYuDqqtW2uahlBK
	 ndGUJqcT5qIHwb2gFPD+syVujX/NKfi4s8TIiz3YWOqcFuLE4Y/JaSyTcwZyOThccr
	 LpVKfJrg5ycyJnnX4U+pGEltIZqz9hemQsgrU58ToIfktYcB4Bk6EVQU8nv2VeK+SW
	 /1oVvUh+0D6uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E57C7115A;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:36:11 +0100
Subject: [PATCH v5 20/20] mfd: adp5585: add support for a reset pin
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-20-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=1501;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=crfo1L2pahKRVWGjCu62YKRA70uwp/eYBp6lSfb2ZXg=;
 b=YpVCDSwn/NhAMpqywvkSiSAH3Gcf+rqYezhvawl2t3ErttcxBcJsCKdbA/Bw2oK56cZtRih8X
 JksiYk6XFiiCqjDkSQJHPU6ei2S3jBfpZ86fkQmEBRti8ur6Kjoxy4y
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
 drivers/mfd/adp5585.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index e4a725b9e1475be03cd26898faa7a7bb8de4319b..f6dcdb632667120f4c6ce54812dc18083ca5d15f 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/mfd/core.h>
 #include <linux/mod_devicetable.h>
@@ -691,6 +692,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_config *regmap_config;
 	struct adp5585_dev *adp5585;
+	struct gpio_desc *gpio;
 	unsigned int id;
 	int ret;
 
@@ -715,6 +717,20 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
+	/*
+	 * Note the timings are not documented anywhere in the datasheet. They are just
+	 * reasonable values that work.
+	 */
+	if (gpio) {
+		fsleep(30);
+		gpiod_set_value_cansleep(gpio, 0);
+		fsleep(60);
+	}
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
2.49.0



