Return-Path: <linux-pwm+bounces-5499-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D394A8A1A3
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7607189D074
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E2129B78F;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+xv3RGG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA229B76D;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728560; cv=none; b=WpZX3E0Reum1Tp9hu+OfOQbxG20VCVsCs9/XVNxjHq+fkMcIZEIUAAwmqW/dU2IVyu79hhCEQxjNO92KzVPl2MHM1sPL7WlFEfcwbkaaK0KfpKJKl8kUuR5yHikXNgnlxjPcHmVoxFi2LN7jNUreFjZ+nko740yTGltRMK96yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728560; c=relaxed/simple;
	bh=Td4wW3Hy3Yh+DQ7BKi7+4Q+bVEwo6cYtA+dajAupgQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KclPWT1ce4yEZ/D2jbH/B6gBUDN36V7RlTcLqvb8pTjEcFlRy+ZMWhxnLSo+9Z/T/vWMZvszj/woInn7uH9IeEtU5BbgMfxzv8kzBufwYVrmtw7SZlgDBiVA/Cn4rdRARRwhUFmnnD8paYEesIgAGEdtucujiB3CoPXWuhfLSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+xv3RGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 584FAC4CEF2;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=Td4wW3Hy3Yh+DQ7BKi7+4Q+bVEwo6cYtA+dajAupgQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U+xv3RGGfDLmcHxtXhfkMHMj3w9ZrD7Y9Ex7z9ALiNdOQpyvoQCkZeUpz3HeYYQGh
	 M/3tGsElUXAmGGKQcmxP6N4E5wLuxZoHJqKi0H7/6Q0Nf5rTxbgKLCkD91ZORqDfqe
	 e52WOU4WvzrMBNuGuW4iJizflG7+F4nYBJoxHGMDsOx/SQ65aCgBlm7CRX/QTxSt3Q
	 FgA8/CQp/m/xcYRgJn/08E45pmdP1Ei538R1+FBAoQHNRXZNXv6RmW6nstzyn6qmP6
	 ngtP12kqfPdxKjeCSHF7kB2YRCtScWEdzaMQ5+n53D5rgIK9rv7A0MRVHUUe7wiJJX
	 Htb7bQJBi0mUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE48C369AB;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:20 +0100
Subject: [PATCH v2 04/17] mfd: adp5585: make use of MFD_CELL_NAME()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-4-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728559; l=932;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0kJzqnAeuAQSRegsuk2cy/H4KUD6hhlPLmzzHmhsyqM=;
 b=ZzLThclVm012R6w/bEHxMcSLg3xSeVTVE4K+rhb0ILpfrjLNajWUJ//2HRL1Ej5pWfVdxuB5R
 almo/mWfewjCfGlebBOA1b9iCBi+ne1K8xj+Z3yygSXfxiIYqaQ8CEy
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
2.49.0



