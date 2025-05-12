Return-Path: <linux-pwm+bounces-5905-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6957AB3750
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C301716B98D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F189294A1F;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1vgwn4T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED612949EA;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=NrFuqkNnpF9ojXvkqG2Uck70G9GwfcTX/gPTJeQ7eo+lILcX3qfYFQYNQfBCRP4PPrZKUXy6L4qzZZASCOa2DW1SLH6YRfKVHpoo0XH9WxLPPVkNaXZskLC3u8OfBHGi6SyFDMgVc7axa8WeCSWuw2YW+AvIy8NX3F+1viTvvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=bEBviV3hv1OvFeMK9McYkJU59fHVaEaxJ4SplLt/zLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTECl40Jb3O6EcFns7eME1O8dd2GmgYpLlI1iO9f0Tlga9OjQrLsdSB6hjuL4roeJUIdgY0uRsPRSB5ZFatd0cwTzcJX4hTBY40+2ovgNCfx6lfxf0NwQPN97Y5SyY+YLxsOx3u+h/i0AxDHK1nvkzJndEwl6DG0puoa5y267dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1vgwn4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6FE3C4CEF6;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=bEBviV3hv1OvFeMK9McYkJU59fHVaEaxJ4SplLt/zLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H1vgwn4ThequWLnt/Q5P/qAREhAffbuwpBMb9Lhatxauh2TeqqZXNt3671XgYbStb
	 D4e+m84WE7fo3D6iaqiNH818vdniMoYYLrv87E9HudK9yIXsB21BnFgajOs89gcmnN
	 Wo0HuB2FKY0qLb6ImnG74PKiToNtlII1B9mDMdk2RDKXk+D9bd6VOKXQk8ZWh8I8gU
	 pSM7qMpfgofC/EayBLji6iAjSj/hAxSgsJVpY/lR/0QTglE4xzhSk5upBOvwj5VCRB
	 hmEanG6L6sgVDOV9VENbZnLGByMzD6AxetnPFOPhpjI30ExqXhqbyvNHHQBxCR64PF
	 REOw8s3z3VZMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B10EC3ABD4;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:38:57 +0100
Subject: [PATCH v3 05/22] mfd: adp5585: make use of MFD_CELL_NAME()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-5-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=959;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=GWe9/8fAPCSEa4r1+q+yyPZLpcny3SV+deYSV6vKdE4=;
 b=QABy5J25tL3+O63YdaeXjUs7OiAkhU6Z4P3uZF5Apc0joI69NNMzCxgFJU5vfPrGV1AR/WDml
 b3ofi3uBhNtDhYrTJu64F5txzIZZ2J3wSmDqxfRddAoy8QErZrmoKwI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use the helper macro. No functional change intended...

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index d693b1ead05128e02f671ca465f9c72cab3b3395..19d4a0ab1bb4c261e82559630624059529765fbd 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2022 NXP
  * Copyright 2024 Ideas on Board Oy
+ * Copyright 2025 Analog Devices Inc.
  */
 
 #include <linux/array_size.h>
@@ -24,8 +25,8 @@ enum {
 };
 
 static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
-	{ .name = "adp5585-gpio", },
-	{ .name = "adp5585-pwm", },
+	MFD_CELL_NAME("adp5585-gpio"),
+	MFD_CELL_NAME("adp5585-pwm"),
 };
 
 static const struct regmap_range adp5585_volatile_ranges[] = {

-- 
2.49.0



