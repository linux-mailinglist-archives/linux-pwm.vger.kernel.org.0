Return-Path: <linux-pwm+bounces-5915-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED9AB3772
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAFF1688BD
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2D2957AC;
	Mon, 12 May 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXs0jhC5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1A295511;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053540; cv=none; b=uCxX6PXR01xDRofZD4vwqgq0WXNTQok00qNwD3GeVp1WeeKZJgJlUJ1LG5dRsa5o1XRICskOmIneWaJAtcG77scOHpS0oX9VKQMYgp88c6n/wWj/BxwRRwZOhgHKu85TX3RgmlNP2TM3pposUD6qYuK8BYd5QF/0a11PZfKkYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053540; c=relaxed/simple;
	bh=b3QpbHDoX+KSKhGr1oHIV9UzBf4xMsgrZHQ0d7I2XII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qb6HDZBLeHAJi9OQlqaVNb8fabyajvMc0ZitXxqYOwQ9LHo6i89bvGRdPV3wtvCFSvRRzzjWgZFACxSnwRr8jDuQoTz9N9uA3A+vhaBDFPbydB+93aTuuFyW4b6UPhBK1HfyEXSkrSfKbe5OHx4z4QiryGrxU6mSohRBJje1+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXs0jhC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB68EC4CEF7;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=b3QpbHDoX+KSKhGr1oHIV9UzBf4xMsgrZHQ0d7I2XII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QXs0jhC5JG6e7b0BCRdmyq8AwnATbJ6GUaTbma1u4dWZ4/lp7G1dMhN87LyS+dM5D
	 3y1yMpZbrkVpH6dyeEPuMY4ntEF9Tu0FQ36QrXBo7FxZlUIrvSCvxfhNOz5u3YnUYh
	 Op5oz0aSit7e0hxFEBLG0akraPs1860cUQ0Wjm0Zp/zJPhTWzzI2lHA89Xvh51BfCn
	 EyvHedtTF6kaWkEZMso74rV6wgMAS2p+GVp/EC8xDr7wwVqf/f2l0rnnQ3vFZlQsZ6
	 qNwxxiUNzo3Q5b7pd0Z0GNcqGLAFlTk/P6OGRxQ62893iaGLckCxs3ONunrOjnAN7M
	 ItFdPHQufZZxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C6EC3ABD4;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:14 +0100
Subject: [PATCH v3 22/22] pwm: adp5585: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-22-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=739;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7qqRv2NdSBhPS6hh0D7Nz9u+Cn76QfW1seayq7g6/eY=;
 b=m76GUvHoTQlZX5KCbaOfpmAJncrdRkO1u7jE9HGDp0wCD87D3ER3qdJhrhF6kVIjLuXh1rkjV
 vO9qmQCKn9WDjYtyKrb+OvWiEiBCjg7H2rR6OeYuWhEcDN55erJyePv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Explicitly include mod_devicetable.h for struct platform_device_id.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/pwm/pwm-adp5585.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index f26054c19c2e154d05780af09aee1b2431eba2eb..93d0294d048abfe1a009161025e658b58b669cd9 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/adp5585.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>

-- 
2.49.0



