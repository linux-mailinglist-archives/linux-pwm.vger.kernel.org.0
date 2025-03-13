Return-Path: <linux-pwm+bounces-5164-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF70A5F7AF
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626CB19C3D6E
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9B268FE4;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvFp6xQ7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27378267B91;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=HLgj88mvdb32OheoFoKT+eOiY3ANkGgeDq0TQY1MuL7qIrWTLxtqr2OVcZqaenaSAy+1fl7aoj5DRdDfKWUPc15csmDfjnqGouxfHZwC47gm2papBpqRiuL6V7IYx6qdSlzkOgGPaCc5ijTDF2iByn7tSG5iVx7CKGnxdCVe9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=DOWRjEQd28uwnO0cH4/p2K3VZkyb7ycxqZy8dbXqttw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNu6YRKyRVKhBpijLEWef3p+cEwooxp3MsB/hpHRLVYkb6GPkzkEksjxwXbdQImUJdRt/W6Q2S6It8cDC+/PLITl/HJFgh6onzq1bxeZyYsvpRDDwkqybNpyKq5hIP0xt6kA4Ya+bhiWzAuMikklg53Rs8GgNsQxXDVQbl7xSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvFp6xQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 624CBC2BCF6;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=DOWRjEQd28uwnO0cH4/p2K3VZkyb7ycxqZy8dbXqttw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MvFp6xQ7TrCQJZ08MfQt6HmJM+iMq2P5LvXQWUUVkWqUrugXjfdGnTAfOZLFqolRK
	 IfKl8/60zdcUk/V+7dYTWmlUesXX8ivEA3M7JYocK4xw63PxtL8fdvPx8mpGF41Vcx
	 dnq+Vyjs0RLdqFwU3mQAPMgHOnhFbgLSdhENfWBBHzoM7X0yfvsKx/HYFevz+mN/Xw
	 VzjvM90rssRkioNSIzFBqaxIoTDWYLA+wyGLWRhIQpNVicKIiSq8QOJSaWB6hbH8H3
	 lWFx08uO0g1vYBkkoG5duxQhkWCP/TqnomyFdXqQPKUtoz7pYXr7LK0ff7aP9gAsMe
	 Ox9BUoWFCBjHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5684DC282EC;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:31 +0000
Subject: [PATCH 14/18] mfd: adp5585: support getting vdd regulator
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-14-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=1028;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=trpzpm4IMbeoKlpJzcTFH6plumlFIe+Jo8NI6LqOEKE=;
 b=9BrNzNjZ8ytgDtwKpf2aEtlVOlEt5myJIiByCaPzav+fDCKb1sV4h8KczvxGzXDhv+sPlJiCD
 glnRgsoMs8XAAT6gi6AmEY62RyVBloCuEt0+1OHiMQIqesS2EoB7cLP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure we get and enable the VDD supply (if available).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index a96de4e6a3a12e2c91528835c2061795e6ff3ed0..8f95a02661880477e5eddb4248e92ee1bc69d674 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 static const struct mfd_cell adp5585_devs[] = {
@@ -848,6 +849,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	adp5585->dev = &i2c->dev;
 	adp5585->irq = i2c->irq;
 
+	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
+	if (ret)
+		return ret;
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
2.48.1



