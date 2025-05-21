Return-Path: <linux-pwm+bounces-6041-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD21ABF559
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B103A5846
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E226560D;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK+iVQ+B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A202AE90;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832588; cv=none; b=RfNXbpQ6cNoL5w5o+z9d9rosNSdKQhMFOrqNIZiVOTokYAfKhX3B7uHBDJoZ7AUd1DnFRc2+nj5fttzib++KyGOL2A90+BQG+Fh41TKAulj1+Jt8zdbm28cnkgkZGzO5QiInFNgIbMkaqutD1R0mn5G/TeNuYBfb3bvRIjqqYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832588; c=relaxed/simple;
	bh=GBi36R9hW0zw2IkpPUS+VIpfCR1bDRxMW6EOkIPpIRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPcIq4EOEml3FseG9d4LJ2Zm4JhBLkx2DIaBZe4wPmGW43CnlG0RmfIHfs//Gg1D+QE9iV5hKU5YDv+A/0w0h/3X+GrRkD6K2y5EPqmbSdx8l+5Iu1JohofUY/KozVWLi616/mOGxT7Pxnat2A7XcIfWWlyWoemuwgrOcgHWGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK+iVQ+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 533ACC4CEF4;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832588;
	bh=GBi36R9hW0zw2IkpPUS+VIpfCR1bDRxMW6EOkIPpIRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VK+iVQ+BARGs4fUC6x5sAVWfYKaStqU6IU5+KQD1DuNt3t6KIdx7qqSBby7kmW0Rc
	 hu2ncNDqiNlqFl3LLrCc/i0ZuCiptVaZUH8wkM/4njydq02cMMtBEFyr8KVXuRs2xQ
	 dTdyYvRBgGJVdSATiJtvgbcsFJBInRWCvKFz/MRhBT2HqQhfUlvnGNWutqeDACzeYj
	 fOWPiAev8uEVvB5JaM7vH8wQ7BKRC6Fn+AGxyuemBjZdrbS7Ht/dn5eBy1gJu2bNXV
	 Hay6SIWyKAXaLZ27s8mcRRpD0PYBubedfcwWo7thxkzSennDHtLwG+TlYXkKx8JexD
	 Y4FwtV5xlIJvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7CBC3ABC9;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:02:54 +0100
Subject: [PATCH v4 04/20] mfd: adp5585: make use of MFD_CELL_NAME()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-4-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832588; l=959;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=lWJD4WSbbbXIDQFlsGUw2j1/tWcmQ+L/pW1P3Qzf3s8=;
 b=tqGyHpFbEEb9Uo/27+9LFnSapZV5D01DxD02izZ0O4nhV/HenPk3GHL8uiSotuzWyWNqCTQhH
 XzCBGm/25K4CZwMfrr37amYMxIEuxvXvXuUE+g8rLR3NAJqCdxpWr15
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
index f3b74f7d6040413d066eb6dbaecfa3d5e6ee06bd..179dc284833ae8f39eefc6787dd2c7158dfd3ad7 100644
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



