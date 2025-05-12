Return-Path: <linux-pwm+bounces-5899-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F08AB3733
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC3C1887F73
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32787293B44;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+IIA+78"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B9268FF6;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=tcPky3HjWBvpo1lEws750VI+C/nU3TCQtj36HNHo6On5CKl3+lLaAIBdN0tMTSlvB2lrzS7VxXWsXZODNqgMlk4vkk05tvmREpp/GF50jqHlFHI+73rgklY8aUlXPOFZ9tXOuc7pTqfXXodysot/oe4I6B70neU14Ogfnc3u4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=7SB1nWJUzZH85+8x2KyDOKYUgduw8cHVeqOtxjcejtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAmyiNFBZ7/nsAScQ+DcGAKtvPXfPZqmcgyWKT4rQiW9ZiofzEWhSJeQk47oPjMs3wdTYLj3of5OwXR+xFyghIDBD38hDc6GUudmGw148TERq+rpd7zqMepeSVLLhskReh4FNV9C7tnE28KudaU83oIfy1Dn0RaQyKxJS4hwiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+IIA+78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78B25C4CEED;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=7SB1nWJUzZH85+8x2KyDOKYUgduw8cHVeqOtxjcejtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O+IIA+78SSqdUC35vGNgMeLEQ0+Ih6VJyaGtNW7CM3B2BmUd+S/iJJ1nTCKw9hTwT
	 41lrWkUOJruj60AqMXDPrI760/8u0H0QsAWiAu3dI93EhEEwvdFzsGte6MaDDe7lzy
	 tsubLzEhPHdh3q/DimBlxi4w6rnFwD73ssiTOhksadiMsKLmAuDeg+s26DIaxy+v+s
	 Ovek1wdD5afo6W7rbAR4GCfyf0qYXkFh5XcdI+XQMoKJthhowW0LbMeRhr8vY7MZJA
	 zlDr4zkCKm1YF4TPp17MwIIAArKbVpFCn6BG3NW4WGCAxnvkCs7nz4kGH9U9NHlvJF
	 XlSda8640maXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF07C3ABD4;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:38:54 +0100
Subject: [PATCH v3 02/22] mfd: adp5585: only add devices given in FW
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-2-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=2562;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=p1qFaXq/Tlp65PC7izdwLK8ARXRCtU7DhWNOoYI6ohQ=;
 b=2h4pLETaeUA42Tl62ZzpSKm/Xsp/92O/UM+yFjjc9lD+otCcXJrEkbpQnMcC8rw4YVs1aAvpY
 KFdi+0mTnCqB71QLbVuogrncPfYC+NpTwIn3DqVC6kWHffYmZWfDdBQ
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
 drivers/mfd/adp5585.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 160e0b38106a6d78f7d4b7c866cb603d96ea673e..02f9e8c1c6a1d8b9516c060e0024d69886e9fb7a 100644
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
@@ -110,12 +116,40 @@ static const struct regmap_config adp5585_regmap_configs[] = {
 	},
 };
 
+static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
+			    struct mfd_cell **devs)
+{
+	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
+
+	if (device_property_present(dev, "#pwm-cells"))
+		has_pwm = 1;
+
+	if (device_property_present(dev, "#gpio-cells"))
+		has_gpio = 1;
+
+	if (!has_pwm && !has_gpio)
+		return -ENODEV;
+
+	*devs = devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct mfd_cell),
+			     GFP_KERNEL);
+	if (!*devs)
+		return -ENOMEM;
+
+	if (has_pwm)
+		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_PWM];
+	if (has_gpio)
+		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_GPIO];
+
+	return rc;
+}
+
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	const struct regmap_config *regmap_config;
 	struct adp5585_dev *adp5585;
+	struct mfd_cell *devs;
 	unsigned int id;
-	int ret;
+	int ret, n_devs;
 
 	adp5585 = devm_kzalloc(&i2c->dev, sizeof(*adp5585), GFP_KERNEL);
 	if (!adp5585)
@@ -138,9 +172,12 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
+	n_devs = adp5585_parse_fw(&i2c->dev, adp5585, &devs);
+	if (n_devs < 0)
+		return n_devs;
+
 	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
-				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
-				   NULL, 0, NULL);
+				   devs, n_devs, NULL, 0, NULL);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to add child devices\n");

-- 
2.49.0



