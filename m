Return-Path: <linux-pwm+bounces-6643-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71CAEFCA0
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034E33ADD61
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563992777E2;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdT1QigI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D582749CF;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380311; cv=none; b=oa61TDt5uEGLs7rMdksnAh1QQjHP49tuBYt+aqOJOYuemSybhRPmBZnukXa5NjDT4F0xrqGh5wSM1ewcMIv8//lXfz/Xx5ZWObwt5c9/bRmoz38iT8eJMs8rzcc3r2R5WRw5mtgK3UHoEnzbhoixjDYIFvjPNVLdkQ5+HX+m4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380311; c=relaxed/simple;
	bh=vNP+mrgrJAZMHw531H4u8Ygc8pvExi3q1XmKtOUhIbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxLy+ufiYntiTJkjncNsNi52gcQCBXEhB75qRmRATVqn7fAALKXD0YeY1PA1YggPQUcXUaCviMUW4Ob8afDSUvwW4s1C/v1T7eu/f/vH/tBgAGszbRcXHVnFAXl38SIsTa+kPYQZjCOAxj/sZ4jKYWXtxPZMxrXI5c1YH72HRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdT1QigI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFD93C4CEF8;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380310;
	bh=vNP+mrgrJAZMHw531H4u8Ygc8pvExi3q1XmKtOUhIbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KdT1QigIkt+fdA69bjkkVYstAa8xmr6rh4ghJVXp9HsG2bexqokPWAIh8mtZh5Yxm
	 x/JQJ7f398jJSLy4DId+7BDLSxJ71XlkxfAh5vNFk+P2TBQsZ9aOopq/3B7IAEhqj3
	 AI5CBNpJBBJR+8WEzV/LO33WAsy/qS5Pi4lVhfUZqaDIufNPVmXraYXmrS1gzpeC/4
	 k8UwODv974u57sCINdnUd///X1XSmjhfNWjlmjRh1kmBc+UGpdbCpgeRCTxKX5tOKQ
	 tlsm0y/Qp4H6KNJGFCRN/zx4+Vy4vxqtMiluCVuoQLb2aGJC4qWW2uSDUXJIt9IRjg
	 urReRB86rsjOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E32C8303F;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 01 Jul 2025 15:31:59 +0100
Subject: [PATCH v7 04/20] mfd: adp5585: Make use of MFD_CELL_NAME()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-dev-adp5589-fw-v7-4-b1fcfe9e9826@analog.com>
References: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
In-Reply-To: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751380320; l=1034;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pXcCAmFfaChQV3ckrSF4YqRKZaSBLDGsMZr3VL8581A=;
 b=bc8WypvqQ5vswyEAmxaXWRMTwoj8UFlEwJODKzN0N4xvlV8SHFwmElOXHJ4+ZGtoS8FNb5CFb
 hfLgWEGziNyBb+5Gm+qnVJbBaMv1CSBHWqeaa87dih7I9FwazEtXs4M
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
2.50.0



