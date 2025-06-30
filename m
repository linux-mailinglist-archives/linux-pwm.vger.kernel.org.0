Return-Path: <linux-pwm+bounces-6601-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66227AEDC02
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91E1176576
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184C285CAE;
	Mon, 30 Jun 2025 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL3lqLzC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6E285412;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284366; cv=none; b=XwEdC1yK64HQ4p5ZX8/p9vFfGfYz4aoXNwpd3udfs5wYFO6/i/25yNwIQF8SbLslfS9y0NJvp0elAShsswmhC43895RGVtyZVRO7b2ddLDBLxwUpUGfOUFac7CTua6lzx0I1hkSyIKvh/TutPGO78t09Q9pyC+1gRmQPyWkgaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284366; c=relaxed/simple;
	bh=nFZOQexnNjnUMXtGPF7ep9n0MIVjVa8TN2/NZxxIAd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGDlIPt6shkOWOE7Ggu0FbaZYVIyqTMCRXKG5+WoRRYjCwfDjgC7GFxndfEe6n6LfSq2mq7AfjLArMICRCXHyVnuzbKP6RrB+/OriZ+sM160TvrYLs9EgvMGD2E4hPJWbiVk+Z4zJEwA2i2gEh0gPdbXR7HKUY+gbzsXSecGBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL3lqLzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B471C4CEF6;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284366;
	bh=nFZOQexnNjnUMXtGPF7ep9n0MIVjVa8TN2/NZxxIAd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FL3lqLzC+MQ+WZK7Bc05sS7xo7u03E0blBiQHHwAYBxezh9VS4Zaal2cNEtdib+mW
	 XQOvsTVQQqP4xcF239IIARn74S24b5Wr8Xc3pGxbV20GHU1FxobOV+mwmCePwYYlas
	 PG62ywEtoOoj781MmuhT+MGr1hU6NUNtVPNYbCRg6jjqdi71CvIHtOLzwZhOEfHAav
	 UuDrLZJ2KnV/7s3HBvT7z+5PECYZlor+7XO4KrG0L4JZzIzQphhT3Ju35utDM6MuDJ
	 NOkjJV55jRrBc9bxVeTU+yO9sq0OnLT637S1Dxm29fDbnKv5ZnOGYGuTqBSJ3bZAcv
	 VOGETAShamufg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B8EC8302F;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:53:11 +0100
Subject: [PATCH v6 20/20] mfd: adp5585: Add support for a reset pin
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-20-a0f392a0ba91@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=1501;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mo45c0YcZpaHsHxCU2xPefftxnua9GwC2/0PBDuFfIU=;
 b=w9qqEVYe1DCLUB/Au+QawoAJxdOWuNowpU1r5yG6miF1ipXK2pLicpAjOhPlVi5UpCDr0AhjG
 dKtsaWqOr1kAiU8f7eoUpCqyurBU4WqNAD4ZMT/sVS2fIzc1fPzl2tw
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
index 11a26f668653439378f9eb31d053c45772a940d0..58f7cebe2ea4f2c68f64370449f5fbce8a2f14ed 100644
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
@@ -690,6 +691,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_config *regmap_config;
 	struct adp5585_dev *adp5585;
+	struct gpio_desc *gpio;
 	unsigned int id;
 	int ret;
 
@@ -714,6 +716,20 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
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
2.50.0



