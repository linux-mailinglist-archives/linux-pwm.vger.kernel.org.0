Return-Path: <linux-pwm+bounces-6582-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3424AEDBB0
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F62A1713F8
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05B7283FF7;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4Rgfq5c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92454918;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284365; cv=none; b=PxcZ3QD1r03Tc1MCj75PYa5VCMkJyt8Z7cRScqMcpvfzXgoWKARPZ+nSBTxTvcY92bfntpYGYHSys4rtF5W+NuRirR+cLx+jSY3WA94VX6TiuLwcG9WD39dC/RrRJaZA8Iu++pyGqZRwhxUaF5OPkTn4VgjtezUf4c+1uQqOJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284365; c=relaxed/simple;
	bh=JiHYRMPGdiaiJDp2Yy2cbdzBFEz0+t64SK2Znk3Vw18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEXdl88i8vYAc1EN0dXpLzfCisdJIY0FZ67R/Tb+gVUYnRv1l3hkivPpUECquBl1qd1g+NJ+/oCDjIatESFMfvGpb++vCu0WA1bAdDMw61Bsb7rvTQ6AVFBNzIAKXUnRf1i0FJAFtcOFZ/T3F+qJnVgj/LAJmK8kkbEjxRuG0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4Rgfq5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66B57C4CEF0;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284365;
	bh=JiHYRMPGdiaiJDp2Yy2cbdzBFEz0+t64SK2Znk3Vw18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y4Rgfq5cqo3kXDJSRsRaZFwob7+dKKIQ9Gcj/WZyf5oSwUKsknisKJY5msRA40owI
	 MNAKnBSYIf2AGDKhGVjzF4YCfhvgWaT5QdLxJxFVHuNJqDfCxqGEzqH546cYVOrFxY
	 azT0JF/fIe3TeUw9be3Q4SyFGQP4vuOQE0dxl32XfGElijfSSNYjWrLFe5Ye9tuuLb
	 j4lxSujZ4g20PFT/HiLRsE4yblxV15jYutlUFTBq7MsX7oKrmP2nuZrkOOA9jODUj4
	 rkg/YZHI8x/GYHK6lgBBjOfav++GtiAD9JLiCpofISFNTOlPF9i9YzVt3bjBgs2Egb
	 8XG6Hbo+4WvOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE1DC8302E;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:52:53 +0100
Subject: [PATCH v6 02/20] mfd: adp5585: Only add devices given in FW
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-2-a0f392a0ba91@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=2284;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=soe5P9JSSfqBEOhKOq8V4GIoTzj5UMGmO8QTcPbpojY=;
 b=ldTUhKgNf3oEoIeX/hwN0Y/PNQms6bN4J+oLnumOoBmrJjsUWjOUvo3bRKZBevD+/aT/Y1f2y
 Yl67OpuFbl4Cmvmywho+69XjhaigcFSc8hPiGaWZcHaDH4nS1oVRYI/
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Not all devices (features) of the adp5585 device are mandatory to be
used in all platforms. Hence, check what's given in FW and dynamically
create the mfd_cell array to be given to devm_mfd_add_devices().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 160e0b38106a6d78f7d4b7c866cb603d96ea673e..53a46734f2d022ec54b3efc2ebbf389357f8d85a 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -17,7 +17,13 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-static const struct mfd_cell adp5585_devs[] = {
+enum {
+	ADP5585_DEV_GPIO,
+	ADP5585_DEV_PWM,
+	ADP5585_DEV_MAX
+};
+
+static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
 	{ .name = "adp5585-gpio", },
 	{ .name = "adp5585-pwm", },
 };
@@ -110,6 +116,27 @@ static const struct regmap_config adp5585_regmap_configs[] = {
 	},
 };
 
+static int adp5585_add_devices(struct device *dev)
+{
+	int ret;
+
+	if (device_property_present(dev, "#pwm-cells")) {
+		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+					   &adp5585_devs[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to add PWM device\n");
+	}
+
+	if (device_property_present(dev, "#gpio-cells")) {
+		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+					   &adp5585_devs[ADP5585_DEV_GPIO], 1, NULL, 0, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to add GPIO device\n");
+	}
+
+	return 0;
+}
+
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	const struct regmap_config *regmap_config;
@@ -138,14 +165,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
-	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
-				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
-				   NULL, 0, NULL);
-	if (ret)
-		return dev_err_probe(&i2c->dev, ret,
-				     "Failed to add child devices\n");
-
-	return 0;
+	return adp5585_add_devices(&i2c->dev);
 }
 
 static int adp5585_suspend(struct device *dev)

-- 
2.50.0



