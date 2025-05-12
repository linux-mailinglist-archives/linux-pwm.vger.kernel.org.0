Return-Path: <linux-pwm+bounces-5913-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809EAB3767
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756A418979D7
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E0229552D;
	Mon, 12 May 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMu7WpYV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CC2951BF;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=a6OxiZnJSTZJU01/3hanmR758ohSETTW6BMYE3ewo14G/pmjiHqvEKvQk+OiM3yysxbXnkHea1gwYRYVzRZWKkn00dlEy/SV01SzFw0Z2Wnv9mlrU/8Jz3BruCXqqzhFmjBkqud4Mv11R0lF+EgBlNcFUIrSJ4vFPY9Q2wTm/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=vOIrluvlQ7ZLWh3hxRkyQbPmkpVlDw8znE/IzDp9zEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/r/5l/1hnkdjUyFrMrqakcopxwyQVq/a79fzIvN6LtRDD4Ott77frVwdrx5Gmkq5fo+tOW1+K3WQ/ecmhXdKdbTVHLv+7Lfi0BhKTf0HQN1OwjbpXqWoNfRf/6wFaTWKdUNJ4d2dqpBbVlOZFPZ0mcLwoTrtwFSeqJWRhDvogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMu7WpYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A5AAC4CEF3;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=vOIrluvlQ7ZLWh3hxRkyQbPmkpVlDw8znE/IzDp9zEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uMu7WpYVnH4aRb108St/u78oj32KH9oo45UJw3BgWuC++unBB82eG6Y08mKER/cG/
	 Gp5cHw+POaiBw52Z1R8qPY6fyxNlsqKQ1cXbGlMlGTQBfWllJgtg0fVQzP9skdeg9R
	 CAhy+WH3JiQ+1GlQLte1pc203GsiQN3tFdJJGUAw8wqaB+YmoTZR7BrRzqMr61etXP
	 fz4ljAZeo5bFqRxV6NA8oSQlA/g9FDiICxo1/Hiexpk63gbPpC8j7KyuXx6rHV5TQW
	 PwxjjdyWlUTYH+INFZa2Cbw+KIeBnJEpVAMbJo9uT1gvL5XTYCOtP/Xnx2H/n41cax
	 qS8jK9vFG/OSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70660C3ABD8;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:11 +0100
Subject: [PATCH v3 19/22] mfd: adp5585: support getting vdd regulator
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-19-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=953;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wqzqThYWrYKLst/qVIq/X2YalpHAmEzY7JXmv7tPUU0=;
 b=3vqVtRYJnz8yH02dfbcP7y577M911tuc83iesNaW+FlGpv3Rvf7q8bK/0uSa/4AfSftklraLO
 P6AxLeXkkpFB8A20UD7YRl3HYEfQgwdkpFPRWplvxb2/BAEs8NXDPzw
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
index 5a4a24593a83271e8a8df40022b73dfa9c15a114..88401668f30e06ac201175470eeaf6216f3121d9 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -16,6 +16,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 enum {
@@ -725,6 +726,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
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



