Return-Path: <linux-pwm+bounces-5493-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C1A8A195
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA347A42B3
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EEC29A3DB;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAgHKZkA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541E20ADD6;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728559; cv=none; b=IybJ7tBr6NklUKueWdDRKOEiXnEkpDpo+9r0OdEwFoVh0vhG7J1RsoeeclZcjgZQhiaFVv2/eshZclo7KFwh9ERnVI3ExTZ82mQmLjLI9n+k5R8gDBhPq0MFpnWWdDi/a69PHg5xc5dNZPP3OpaHuvLFvMrALEtb1NchfQLNcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728559; c=relaxed/simple;
	bh=tCLUDJBBZRusjFbUccJ5PsocSRcXrEt0fYuxnj8grt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/gp1cS5RiaP2oUxUHYS+HLZEX4PV5/l/6aIejgOSi3yH1ZRAmd6ZasUaD15LL+coc5Rci/ZYuzj2UqIxUWwjcn78kgB0zHoX34GY0GyZ1GpW5CEoQgxGXTxxzlk/NfQ8/iAe2W0n5m4pEJlWA+7xklsoV81WXi1uiqtnDduQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAgHKZkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EFACC4CEEC;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=tCLUDJBBZRusjFbUccJ5PsocSRcXrEt0fYuxnj8grt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NAgHKZkAgSruq8a51WFVTChJECVZMWmuvOTsb3wzadDhdHhdr+a4ZwUEZ9SSp2S/e
	 c8v5YpNyk/DvY8+0VFSdqxiSua/EzGU61FalPQCYjSjfrnvFC8+xf8feLjz0Liy3Ql
	 xtu6h+qxqHFnR7u4vreSVpFb/LjqHLwScmupv8hEFptslHJvEqjmxhDcdftqBr9xds
	 rN+smtKYUGdq1YAXr6n/+Or1mt80qqgiK9r56TT69zywA9/GTEPrA6CjFeDxgkzIzh
	 MCAEOfHC0jWvE6CzZIR+RqiRMx5FSeETywNtQxFwY+Tq23SnvTvv2safCdv6sym3RU
	 hzSKjOpUTuSWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3349AC369BD;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:18 +0100
Subject: [PATCH v2 02/17] mfd: adp5585: enable oscilator during probe
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-2-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728559; l=1542;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0tQ31SANYeFcAJsuV7bmOjiF8K0Yi3KIUJPgQunhZHU=;
 b=tQSR/7XDPiNbDTOb4PirNnhZGuBdhopkN3+ooPCV7NZP2blgafm65gjRHSzfGNSwhlOQdtXiI
 cXY8GnPGl8KC6ndrUwgrjkNcyn1EdjaT9mAIUOEnlNdDPhCrZiWc9Jh
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
index 160e0b38106a6d78f7d4b7c866cb603d96ea673e..f17b5f2474cac6a403556694066f438288264a49 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -110,6 +110,13 @@ static const struct regmap_config adp5585_regmap_configs[] = {
 	},
 };
 
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
@@ -138,6 +145,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
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
 				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
 				   NULL, 0, NULL);

-- 
2.49.0



