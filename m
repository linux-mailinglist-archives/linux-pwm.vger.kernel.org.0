Return-Path: <linux-pwm+bounces-6585-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F93AEDBB7
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACD0189384E
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24A284690;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEXOU9h/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809425F976;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284366; cv=none; b=R7MwuiWaNsSpNpyn0+46NhMeOdHPpVicnNRFU/HWMSjIWuJhxn188sOl5RcwAfCA9FdxcMJHTk5qh+PbNwLhFwUawGSbVJWC5xEibnWp+80NXtovIUHkNjwItR44+rWYA75XktoRFf5gLmQUXau9NiJC5h20vU8eNVLDdIk3LR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284366; c=relaxed/simple;
	bh=4PvbGlrI1P+giC0KvVcc0NiGRwA6ey+0tghLU2TBysI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzHIw8Q4wnDVIO3hOnD8lydMeGd09C5pl9JgnGrslIhNt4KElqY3IT5PFu4CO9IvkNTDhELkuw/bPPiLCq7nwIu609tkbRyPWRBU1UqyC4WCob7GJ3X9O3zNKHlZx7lewCIhLL/TD+cSFpyXTnGWsB2YTo36GfnX48V8QqrZWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEXOU9h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7303DC4CEF5;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284365;
	bh=4PvbGlrI1P+giC0KvVcc0NiGRwA6ey+0tghLU2TBysI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TEXOU9h/ejFYpaAuf6MGglSVJAgHMWVL7Ji6KpJwCmbdkcxH/twSrlRtHiqdUfmRP
	 daKE6cYgztPcPD4MbWWJzRrf22qd68INfuO8zjAnu23WfzlRSbAXSbW90Wspc+Pr6+
	 pyS+hVPNvrn482lRG4AF+xFH5lJDLQen01OmafUClDM5L5ioDwO+1hleYNahjSO+Eg
	 JR+Nt+01g8grGHZpAwMqMffa/AnrdAH8whzU+gcIJnqSFgm3u05/5xTT2UpHNkV67R
	 5GwhiolAl/MxkuNPcfydH638DHmNhRwh/9KohLLwSyAhhHo2om08mU7DTPVR0iCrYu
	 t2HEL9Xs1WWZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B42AC7EE2A;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:52:54 +0100
Subject: [PATCH v6 03/20] mfd: adp5585: Enable oscilator during probe
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-3-a0f392a0ba91@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=2443;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=F/DXXnAPAkUgV64qgRRmO7h2jG/qAQ82WBe+62i0xRU=;
 b=ipoQMw3RECRN9nilRAoS4GDR2xhrgJygmTm+whzNsy1k2R5hExRKo77P+qxzFM4oF9y5BuqlX
 wGCdSipYk9QDQaHTT3k5D/zRBtRI8KPnyAMk70ja5Cq6lSP55K00ZWh
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
 drivers/mfd/adp5585.c     | 19 +++++++++++++++++++
 drivers/pwm/pwm-adp5585.c |  5 -----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 53a46734f2d022ec54b3efc2ebbf389357f8d85a..e4a75ae9b2696d5ca8dfe7882660ed08bcd5ba2d 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -137,6 +137,13 @@ static int adp5585_add_devices(struct device *dev)
 	return 0;
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
@@ -165,6 +172,18 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
+	/*
+	 * Enable the internal oscillator, as it's shared between multiple
+	 * functions.
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
2.50.0



