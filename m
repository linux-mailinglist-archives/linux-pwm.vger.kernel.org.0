Return-Path: <linux-pwm+bounces-5507-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C253AA8A1CC
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FEB441E50
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0629E07C;
	Tue, 15 Apr 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjF9XOWz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF929B76D;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728561; cv=none; b=QlzWrnNWj576ORUgHnJ42oi+FAJQfS6ZkbkA6z27N8Q4sVnplbINB4qQJcUdhleNl17TuTjHPFhhcy5UeekUV61ZibASFm3FktOo7NzYtP1cISjcvRBkqX7baGjRaP4XeBeaBmVHR7GeChEEtp9eUmYRjKx17EyA10zTIGHohLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728561; c=relaxed/simple;
	bh=crsEGvz1m8k2FjNEc+Qy8b+aWznTQrDr7Qb+3QKD4yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBj071R6avOoZm8wm6xBDZmuZq2vMigORE1aat8xJOcxRUGTQFX+tPsQWOwpODaEh5edoZ7W+XDKtOrFS6ZAZaf3VrQHlrxewFIUSDlSJoXKeO/VfK1rPg2wKfulKWA5Vth2fWoK58dT6D9VXvK9rKFV1JHjHw8FTE2TBB2IR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjF9XOWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DCA7C4CEEC;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728560;
	bh=crsEGvz1m8k2FjNEc+Qy8b+aWznTQrDr7Qb+3QKD4yU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hjF9XOWz87zZMMTNp+OZjZpCipzINW54y244H2Gh6gP++GblJDkZ2FWWzoeF5nu5P
	 hFvGZy8qCKoKBw/s2eWawNDRrW3cL5o15ZLUA8oRYlfSkdJB6ygEyNGVKQCLYTlLbz
	 k2SdYs0rfeG8dHlmSw0iCI2i2/C8utRz7M7jQmfbiWHcWkKUacdDnq/5mXymaPkjAc
	 fR7R4SHX4qPqt0ea/d1EHxt8bB13AICl8yhDLurz+1anp4L9J3+GQUnCVlaCQWguGs
	 4d/Jpu1nsf+FaJi6Gv1fpstKwI99C+DNh2oDDwTUskfeValco2m0btbYRFN5WxuLAQ
	 neUMLELSGgeJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC13C369C1;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:32 +0100
Subject: [PATCH v2 16/17] mfd: adp5585: add support for a reset pin
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-16-3a799c3ed812@analog.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728560; l=1359;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YXvB+ZSL0gZ4TQpg4/Gr7rz9RArZE2EGcmubpPAGy0c=;
 b=c7XdjNLWoVohdo+K7gcTPaJ5dYtAo7/Xwwh8fOzY6qtAOuLhu1jL12IQfKPYutOaaCRnsXoTA
 UoNtNj6O6TeBfW9lIip3xC+GP1YwGhi1nvj91grKr5LKet32SFr2rcd
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
index 667cc5bd0745f64eec60837ec3c00057af0cddeb..2af110fb28054c8ad6709a9a42cb21919be433e7 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/mfd/core.h>
 #include <linux/minmax.h>
@@ -833,6 +834,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	const struct adp5585_info *info;
 	struct adp5585_dev *adp5585;
+	struct gpio_desc *gpio;
 	unsigned int id;
 	int ret;
 
@@ -854,6 +856,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
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
2.49.0



