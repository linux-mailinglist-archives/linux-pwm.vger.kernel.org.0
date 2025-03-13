Return-Path: <linux-pwm+bounces-5154-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C6A5F775
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328023BE3A6
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6C267F7B;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBXrK3mZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5B267B85;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875557; cv=none; b=i9kZgM2BYvDpUv9fqy0/7sSQ8rgII8aqY/B9l5rN6ghJ8EF40Xg0lbsGsKLYTyoiMChjAplOGrp5d3E1q0KwFvxJSTZiEmqaXVx/rrFD3y8NSXtz7gWUTogSVe8tDRzEzCCSIKmIGvRmHNfc797B98VM1GOjp/uO6BA5CrbhlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875557; c=relaxed/simple;
	bh=L2j6c3iMZcaEN043NF199YD6t+IQz08DVL9/1v7GFyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYIrzzQ4ZLngiMkZ/OIZ5r4md51hlVVlR2M2x0csEod/RxGDh2x9HiQ2AQDXDoZ6z3B9yhxsId/Khx8Klosgyma5yVmgXcsNLQYDSoCiQhJ1GBrgQGz688ArR8ThKCuJPdSKTgpgzuLtxSwF9lNSxrFiXl7BAPWQXzha3Z83u+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBXrK3mZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83847C4CEF6;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875557;
	bh=L2j6c3iMZcaEN043NF199YD6t+IQz08DVL9/1v7GFyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dBXrK3mZ/sqGWQ/z4t6vE1kwphX9ACmWf5SDfSH9mCR36oxNdPxwcbPJvcP2ggULQ
	 RxoMUVDEObbi2p7Y9uRmCWuIUbn2rr4hDP98qCeaoX7IQtuTrr09UYXpa6vJlHfVs/
	 6rkTdpmqZcfldfCr1Em9K/pTExYFT1wNOq4ySrEdqulVMhDBecfo1mv66CnSXj6Q5H
	 puTI8KkOAHjJtKHnPu/YGhWIT/ArM/lkTgEhA+dHq6XJDOYp8r6bHF+PHl9Jdzg9hi
	 RDvtAL6b2yqWHWQ6KrHQal3v1QBSxpDsBPaKiCWXJXGoPGxDV+CFZQ+f/813ajL11L
	 4a4hyHQalBKMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A749C28B2E;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:21 +0000
Subject: [PATCH 04/18] mfd: adp5585: make use of MFD_CELL_NAME()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-4-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=932;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+JLyImFSoRH3lvKr/gEYTk2vs6Sm7XLKXpixPxLmI3c=;
 b=JY/B9Ia3Hwuv98iBqooJxp4jaGNBG5RbWgvwUuFl6K/xkM0nq30C/WBUYqjycc1GK8b2J3vuN
 BhJjJD9uE57A+CSdMEkUIUK0yw/BkSPjGUoLII9VhHFArhcONNCX+X+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use the helper macro. No functional change intended...

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index f17b5f2474cac6a403556694066f438288264a49..fafe3ad93ea196e1eb8e79fecba58f36f12167eb 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2022 NXP
  * Copyright 2024 Ideas on Board Oy
+ * Copyright 2025 Analog Devices Inc.
  */
 
 #include <linux/array_size.h>
@@ -18,8 +19,10 @@
 #include <linux/types.h>
 
 static const struct mfd_cell adp5585_devs[] = {
-	{ .name = "adp5585-gpio", },
-	{ .name = "adp5585-pwm", },
+	MFD_CELL_NAME("adp5585-keys"),
+	MFD_CELL_NAME("adp5585-gpio"),
+	MFD_CELL_NAME("adp5585-pwm"),
+
 };
 
 static const struct regmap_range adp5585_volatile_ranges[] = {

-- 
2.48.1



