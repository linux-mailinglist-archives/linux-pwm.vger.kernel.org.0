Return-Path: <linux-pwm+bounces-5918-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F9CAB377E
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E9319E151C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26B383A5;
	Mon, 12 May 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H98yMLC6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FB2951DB;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053540; cv=none; b=X4p236xXZ5bnt/IR3TMMQUcmJ7tHmvYrttvJVGCsHFwJuy8sWBHh/JPxj+CrJUsBqLFRdENyPBHdLYyM49l/KARAzOm80+22n16PQuyXORsGAkQM+Nliek10+yaUHONUcAJ6fhswNEQq3cvUMOw4cUGPewcRt1Qq8SuxXB13saI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053540; c=relaxed/simple;
	bh=9pI7TDIzBeTDNXjeuoImE6pIAEtmx1yMC34/Lq1dOrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOFV3DYzFrDfAB7mEPmM8IXvyJFOjffuQweSpK1uxPjqh/NuEQkjbgfR4lDrK+F8KWWjx+67DfDpP09H5+NjgJ7ZykliJtve4kX9LkK/cQCDpFVpFb/KImPVluu+wH+raQ6RZuAiN0vsuLS0vGqm+JKomfuy3eQgynhvMqOfYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H98yMLC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 940EAC4CEFE;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=9pI7TDIzBeTDNXjeuoImE6pIAEtmx1yMC34/Lq1dOrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H98yMLC6bZ8g1cxf2PSXsrtw+lPUcqhiBLfIdxOYP4uHpFTKHlwfOTQIgjNDqqaSl
	 29fDCkGJP+XlPftwq1BdfheST4MIgDMlg8HJUSae1hrlapuoDiepnQr0eI3Izf4kZj
	 yFHEDN95N/0UZHZUq/Q30r8wnEWJsgDa9v0Blu4priAQQ+7vddNJc0qGD4ClleMy34
	 S3QM3v6DVLkMt70RnZxrD9PCgT6BhDwigvILv55eQYC+cZKzBIpynz+FuAhbeV/SqF
	 Kc//MMZduOWLjrwkTxJAzhe6b/kDgynefNCdyu/nvA3qnsFP+71hfQZFa/YqzjYBy/
	 TdIf3POMUd4DA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B204C3ABCD;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:13 +0100
Subject: [PATCH v3 21/22] mfd: adp5585: add support for a reset pin
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-21-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=1527;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tFAINTSoMBnF/ZmEAfpC4hVQDXmxCmyzkOry/geHrT8=;
 b=g8s7nFQP21zeOxkinuEvv2rhlHsyuC6IQnojYR1oyjiGZg+zS+aw46WEiwTUdtp8/0RkqpPmY
 V5MxDoGQDkeA1d0gylEKZiNNSUOQ6RD1VOrvGliHEsWtzhDWwmQTxYx
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
index 88401668f30e06ac201175470eeaf6216f3121d9..0fbe1f7f2582408b2e1b99f629182ceebce73fd7 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/mfd/core.h>
 #include <linux/mod_devicetable.h>
@@ -712,6 +713,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_config regmap_config;
 	struct adp5585_dev *adp5585;
+	struct gpio_desc *gpio;
 	struct mfd_cell *devs;
 	unsigned int id;
 	int ret, n_devs;
@@ -730,6 +732,20 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
+	/*
+	 * Note the timings are not documented anywhere in the DS. They are just
+	 * reasonable values that work...
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



