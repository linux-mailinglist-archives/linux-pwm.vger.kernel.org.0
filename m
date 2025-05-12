Return-Path: <linux-pwm+bounces-5898-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A433AB3734
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EECE1686E9
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABAD293757;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO7I+AHK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD154268FEF;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=snE7jILY89YAl7DEt1UMlGBvPQkJZmKzbE05kRLLjT/WdpgBxCnW6idXKrTUzwKFGszd8UXvfaK3hs50dARkvKoZ4uTQfwHQHczwlJeM+Cso6eOKYguDCutNvFRa7w7H/aoIxj5NGDlg1V9DQPJcjk4+Zu45hTzkbRofMq7EkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=cuvafvFaZO541iA/E3CfTdzj7W1Wn4e4p01axUPK54E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6GzP2lWtQ9RQo2jpp6hlwbJ1+DtvUL2FwUYoJLfWz96Igpa6u+UPlfoY709u8uUCiYHUK6smynAIvgIfpUCY30devew1RYWB49xX+yqivfaFtgvnpoXZNMePz4r0Io14YIDnbnSf9xg5hPLP2Bubks95N3/yXNAIOTO2js1XDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO7I+AHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D52C4CEF2;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=cuvafvFaZO541iA/E3CfTdzj7W1Wn4e4p01axUPK54E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DO7I+AHK3XrJvyPH7sR2pB8mu/r29MWxbmxitp6lMRN4NVXPpXl9RuJ7nMtmsA+3y
	 v/RJsljkwiPpM8kLFq8vOqc4RDrAFkI+V6vU6oqWRT3HC7zjiFF4i70h0nP1IZOvNv
	 Ru3O+UcrpxUHjjRb41YjJcOrLOfto9ZbqtWxWTnPnPaD9kMJpvoAGII+pRnHNyjgOP
	 WdEGe039zss7k9fPnQRfTJOCpq0g0so+6vXkLO7W2Iouw7hQwY9Cyt4RvUUAXLMujD
	 EATzToIIZYMqPkegol68z7PDm0YjRjPLlAUunkh86ddgptEmg6C+sVwtDkHhGS1zgr
	 ByEdPlkzs5hLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E1C3ABC3;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:38:55 +0100
Subject: [PATCH v3 03/22] mfd: adp5585: enable oscilator during probe
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-3-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=1487;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mybnMMBTKtLDHzpuhMVeYjCasyTrQngKx8uZaX1S1OY=;
 b=2T4/8jY8H8wXOk32QQvO0IaORXzzoiC4QcU2KmLV2MbIq+S1jtfschlqwpauc955xpbQUArt/
 UIhvlcc8vI/A+DQfDKYS/w/kfvsraZXNnKrR0gqG9RuNTnbnAD2NFAp
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure to enable the oscillator in the top device. This will allow to
not control this in the child PWM device as that would not work with
future support for keyboard matrix where the oscillator needs to be
always enabled (and so cannot be disabled by disabling PWM).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 02f9e8c1c6a1d8b9516c060e0024d69886e9fb7a..d693b1ead05128e02f671ca465f9c72cab3b3395 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -143,6 +143,13 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 	return rc;
 }
 
+static void adp5585_osc_disable(void *data)
+{
+	const struct adp5585_dev *adp5585 = data;
+
+	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
+}
+
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	const struct regmap_config *regmap_config;
@@ -176,6 +183,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (n_devs < 0)
 		return n_devs;
 
+	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
+			      ADP5585_OSC_EN);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
+	if (ret)
+		return ret;
+
 	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
 				   devs, n_devs, NULL, 0, NULL);
 	if (ret)

-- 
2.49.0



