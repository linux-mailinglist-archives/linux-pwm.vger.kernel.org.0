Return-Path: <linux-pwm+bounces-6042-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABAFABF55C
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F033AB92B
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10826E141;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTeEVaEw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A602D613;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832588; cv=none; b=kgT+5KSCA/jD5cepeTqkKQpS6FinHt20mEfpWBntinujKEDq8LUIszNIG7ws+cka8vu7ouVPkSvAHlzBcA27yVyZqqIblXoZqznqw4kN0mPeg99ljiuAHox6pGifvA3/CUcdPF9FYPWiQJOHcetCSYBRUM0ZfIYFatFBZRCZKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832588; c=relaxed/simple;
	bh=whYTG49rTSiuXYuG42MKeByYKbj2LCEIYPvAKuk5MkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJldOsSJUiMyGSdftYDiHKMA4NGDG6F0yIK9HTwY/fRctqt6td/09eF0fGAP8AEWLdJ62ivCCpmMxmcGyK7e9L7MXODtbLyaghZsGtDU0b3y52BA34kBvI6rOHh5aQtQkutb3ftej3eSJBLUX4vkx1pCWVmXxshOa7O9hXhnsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTeEVaEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48584C4CEF3;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832588;
	bh=whYTG49rTSiuXYuG42MKeByYKbj2LCEIYPvAKuk5MkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oTeEVaEwcqAMXmMu0D4j2/JwZXkTX34NF6aNEgu6DC3xmWEv6pf4z0KNUbP1nWZc6
	 tSReOG323++l+WTQst04ZV6jduuoZ8IezEPa+qwtQsGNDBzDfVAyYAbnaeklA7m1aE
	 rcAV61uSTGi1KHtQ/uk7aj7cN2xkTEPEJCJmFJpy6I4QmmoJq3HlapvRmmoAe2UkD/
	 G7pIu8pPwB9nBW/D54yqvfM8Q3By0eO61urR4Z9atB33byfebQeeDFK1lEPjRHBZuw
	 S0UKGxaKpdHmY3xQ2tuFZNJ/IxI6p7lsJ6HzHXEogyEyYoeSYem+UeJ3vnoILeyf/r
	 TpQRwe28Jfurw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED34C54E71;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:02:53 +0100
Subject: [PATCH v4 03/20] mfd: adp5585: enable oscilator during probe
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-3-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832588; l=2656;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=X8wJ0og1/UdO6FQO5wOb+T/KdrMRjk4FpWN8n5bX/qo=;
 b=xoBf3sqi9Z9/TuT1lweAtjYtsSF2XJnblE/pC1q/4KUJK2/NK3T7lXcsBkd9HSLWPfhI7SxMS
 VKuk/iXsfDpBap/IEPYVcDDSKAGTYjUzcvH5WcWJ9zBimydNPNaAFmG
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

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c     | 23 +++++++++++++++++++++++
 drivers/pwm/pwm-adp5585.c |  5 -----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 806867c56d6fb4ef1f461af26a424a3a05f46575..f3b74f7d6040413d066eb6dbaecfa3d5e6ee06bd 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -147,6 +147,13 @@ static int adp5585_add_devices(struct device *dev)
 	return ret;
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
@@ -175,6 +182,22 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
+	/*
+	 * Enable the internal oscillator, as it's shared between multiple
+	 * functions.
+	 *
+	 * As a future improvement, power consumption could possibly be
+	 * decreased in some use cases by enabling and disabling the oscillator
+	 * dynamically based on the needs of the child drivers.
+	 */
+	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
+	if (ret)
+		return ret;
+
 	return adp5585_add_devices(&i2c->dev);
 }
 
diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index 40472ac5db6410a33e4f790fe8e6c23b517502be..c8821035b7c1412a55a642e6e8a46b66e693a5af 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -62,7 +62,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 	int ret;
 
 	if (!state->enabled) {
-		regmap_clear_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
 		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
 		return 0;
 	}
@@ -100,10 +99,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 	if (ret)
 		return ret;
 
-	ret = regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
-	if (ret)
-		return ret;
-
 	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
 }
 

-- 
2.49.0



