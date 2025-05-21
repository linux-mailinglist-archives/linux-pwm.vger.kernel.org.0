Return-Path: <linux-pwm+bounces-6056-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693ECABF53C
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE71E1BC31C3
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0187279324;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxVy0tP3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8952741A9;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=B2l4k2sBTmKJZsNUes/og5JfcWeqcuJg0ZrFMwNjd9gtATse0AEV+M7tJ78u79EtgpdC9ZvX7PCYKvEmuiOOUtyAEFSml60dHNxcDHq+T47egdTgGioIgGchfPxPVvZVnRzGLqJscNu5Y1t8Z6yyIv/vvxcIqKN24qqhc/YNqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=BX8Wg/FWu9hKCCgOmaiDEi91ln/IfazQ+YTfbqQFHdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkopVtJs9tid9x1Wy9YtG6cIz150Idb8m1Yiea8c/YdgUzN5TwqySAqVXOJGGWT04iGN+1CIzORqHVLyx9NaW15h1vhPjZfnihFNVulaP64rUnW8teH38Pbl6hk7INa0TUW3nFjex2ct5Y/uWQpW27HK8FtN8eI1Yre9bDAtado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxVy0tP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D6BEC4AF14;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832589;
	bh=BX8Wg/FWu9hKCCgOmaiDEi91ln/IfazQ+YTfbqQFHdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sxVy0tP3s1UZ7keCsmAktWXMr6V+s63p6XLqEeoQJ6gQM5BqbpGu4HH7yyCl8CLsL
	 N4Nt44QoXvo41L+LsMWpF0fUjIjPhQP49pjyDJGvDhqGhvWrKmlPEHnkuILXwMsk1i
	 Ms5RggJ6N1xKGCUTl3zq9AAaRWvmq1O44tKEyy2lbOqhqlP/5aXGaX2fJXk6aJnX2J
	 wWgFyUI5b0JbDIhNAKruqgu66UEvN6T9py27QzMtFFpkqT6FWWiG2j3AcFFOMyabUr
	 OAsy0BGvjyt6FthRiaS0LiuDSOhjJtBPdPsnY8ZrLDAxnI//rkZNWrINcBV8KGmB2h
	 ttN0sVRPJMu5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34764C54E71;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:03:08 +0100
Subject: [PATCH v4 18/20] mfd: adp5585: support getting vdd regulator
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-18-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=953;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ECrqfs75aV73lVCEhCx23/27fcILAFWXOdDurxKe3R4=;
 b=40L8MgUgFvGQ3R/fe/TEc19W6HrNBriA3nvY9hEokwa8qCVNJn9gS0QQ8MkR0qbWQtcYOAjar
 BVKZws+ofgqB9t2tc2IfdIhCdwAqX6pkNcwv82bzYpvcUKDJDChxxGR
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
index 122e2c95385f8d5cbd7839db78dda77ad7ba4ae4..e8b9a0ef4ee654ac1abc4042152fe0933f1d9f0d 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 enum {
@@ -713,6 +714,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
+	if (ret)
+		return ret;
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
2.49.0



