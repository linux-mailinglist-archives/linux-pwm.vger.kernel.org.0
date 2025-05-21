Return-Path: <linux-pwm+bounces-6061-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C622ABF558
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F8D7A95F4
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27427C179;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHj4L4Xr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A0274FC4;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=FGa3zn7SfuxgRbEuy2jREUQZJtHYXQTliRCgCTJAcIZVj1QblMRtXt/UA0Ra3Q0cvZOH76CWz3fOMLpmgBweTkn3dyNQpfIY7yvoRmWGOA+cL5G/eO+pN2PKswDA+UfxfbyiO+K+C6leQE5RHnlVGJ1Ickj8EzzG6FC2SMxT5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=WyPLnEXhfwySw2iAcKwtYQ66R/7RyIN9OzOf04gSfBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUAHX6wk+RCUGfK6RcvBny6joH65vrkZrL3+5ITyq5KU4clGdQO2tUqoTufwWCR9dqe4vh5wSoJ11m364yyeHCdbKI2fwfghT/pKmSK/kPgah/saJ7d0dWNLg/6We1fncR++FDxriOUFgsd+7m3J5T3U5otapt3WBigdHgY+A7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHj4L4Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53FACC4AF09;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832589;
	bh=WyPLnEXhfwySw2iAcKwtYQ66R/7RyIN9OzOf04gSfBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fHj4L4XruTxkntKZF88lbdx4NNePuNPcFEyezGzJTqUZxB04TV3xHVWt7qnVLytaw
	 t8bepzDo68ZWcBlbiqJVfxOKUV8vftJ9rEGSpd9FoATp6ccIFAr0jGnnK6lh1GNh+a
	 RDXliaHijHZtrL2mDX0x+YQaQk86tTq1Z59ms3GAjNNmuQ1sadBuu8Td0xQ1BYSdmI
	 LAx0Qpcc9L/e3/kiWVxAFURIe0sEUj1KUCgj2/ni7xFMf+tFoC+tAmyTJr9M9K4KsQ
	 yfkPvXZfy9tPBQi9OuyvtXHMbSKhcrHa8BBBodT/gdB9uUfn6zIBeNLNlZXja3tHkE
	 k219ng8mPa9jA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B2C54ED1;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:03:10 +0100
Subject: [PATCH v4 20/20] mfd: adp5585: add support for a reset pin
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-20-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=1494;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=I4VY/9poNwSdsVpeDT0XePKG84hzWFHXfJYt/VQ2EfE=;
 b=iDmMo7mYgRVbEt/4lrsZft+aWe1qmLukm9dxMxpSmBAJKDxwURfT6WY2KJGBCpqgAwuDXSIUB
 B9j1Nl1EBbZDbNVjYg5XQ9lRQYuxF3kSUriUFm/hlJ1Ua2WugZM1VFq
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
index e8b9a0ef4ee654ac1abc4042152fe0933f1d9f0d..164da0b804c4fce4e3af1ac0c2813020a77f4938 100644
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
@@ -697,6 +698,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_config regmap_config;
 	struct adp5585_dev *adp5585;
+	struct gpio_desc *gpio;
 	unsigned int id;
 	int ret;
 
@@ -718,6 +720,20 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
+	/*
+	 * Note the timings are not documented anywhere in the DS. They are just
+	 * reasonable values that work.
+	 */
+	if (gpio) {
+		fsleep(30);
+		gpiod_set_value_cansleep(gpio, 0);
+		fsleep(60);
+	}
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
2.49.0



