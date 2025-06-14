Return-Path: <linux-pwm+bounces-6365-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3CCAD9DB9
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D790B7AE204
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F182E7648;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux0kWrYu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6A2E6D0F;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=iZcYHXMJqpAc2tdCRY+P8acQJ6/KNl0aivw4qIXs8dujqtaw3YxouRNNUyixpPAiuXCxlA3CUTk6LCAV7c1+KmPAIEOmDLHpBv4h8QS4mhmWrGOLNhyEaFDZkmIYCAJtZ2kbFXhaM54LgScuj3Aefncze5VmIKjgPmxaXyjxzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=M3B8KLYfy6NhXa8X31FFzSD2gB0yQZDOaXYMmw/7ezk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oc52w/4SDqRdFD7B/EZxg8I0xqjMMCw68AeucUxkX4BD+00lIP91zS4UJgS6bQtYP6k+w7/Ck57luUTn8iQ8LSZVhRID3FXnDXHcdEY0zR/8aY2Dqq43r3jj/sBb7b98nmfvtrcymj54tgzj0qv0QEbXgNzUNYx8QSjv1OPVqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux0kWrYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C71C4CEF4;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911830;
	bh=M3B8KLYfy6NhXa8X31FFzSD2gB0yQZDOaXYMmw/7ezk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ux0kWrYuLBfx0rFXkgg5NNBH6XPaweok4XXvNqvmuzwhrq7RdDCgDmhn44MISTH66
	 tL7fGwSmPt/bEBLASEYCrczn0QF3CfDyUkxJh6eduK3TNL8OKFNQd2s6VEIermzlVm
	 oBGlp6Vu5wPTr+MZo/DLyDMkwkGK0wnFdW4aLVMWrDtvfVMwFCm3MD3061UwsotSp9
	 kX54PcwbgndTsjBdjAgRkiHOwiXfeuk2R+1OtQbnwfwzt/E6u8wqQiEDe3bbvXmaM8
	 exL3p//zYd5a8vu3nqRdL+SMCHX/Z+XQXeLPqT31zklO4Mhv+HWE3petdO+BRKPsLW
	 K07XWusJFTI1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CADDC71153;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:35:55 +0100
Subject: [PATCH v5 04/20] mfd: adp5585: make use of MFD_CELL_NAME()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-4-7e9d84906268@analog.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
In-Reply-To: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=1034;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7YDK4W0KgBcwWAzPlRAEVBEURpqe5ZQ5VnnkXjuoddA=;
 b=gjSyR5dJSaFr6bcHpdAO5ijoB9Q8N2d4WzOytlNqkFSqGSEKN053XzfVedfnzH4Kg2zHw2qCm
 vBzJn705hTjCTD5UN13An1LWKquT2HvfPCtm2s+Yq8OsUTAJI/PNE1O
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use the helper macro. No functional change intended...

Whilst we're at it, now seems like a good time to update the Copyright.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index e4a75ae9b2696d5ca8dfe7882660ed08bcd5ba2d..c764f481875831ff55bccb8cdc59421719afbedd 100644
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



