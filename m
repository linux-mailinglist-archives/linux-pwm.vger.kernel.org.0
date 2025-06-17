Return-Path: <linux-pwm+bounces-6397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0E0ADC611
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 11:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DCE1898E56
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE9292B2D;
	Tue, 17 Jun 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qfSr0y9L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DZnRJYzp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F895292B22;
	Tue, 17 Jun 2025 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152060; cv=none; b=RkLoiBhPXifusLvY2dXklUellH+2MoFnOWvtesZbX7wbxGSbY9AL5K7GWNqtPnDQpTYc5p2T2uzdP9Zf5pS1ZZKtCiqU+KwBt4gygT2Q8Nm2hAY5wOEYIJc6BH4ZomwivulFxba5kRmhOY2PTcuhhoAkH0cDnPRw93f7U0FJicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152060; c=relaxed/simple;
	bh=cUsHRhDhRUZkpg9kblm/H1MwHaKU2gn9eRp/9HCmzj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fAITOAF92do9rf6O3VS/jmSnf2YyXiIx3npFA5lk9uOzNzmKIBQsPkfG/968D+dCUHt4vWAfHZQt2cm1bHCuK0axtmP1EBSzXOVi2RD3HuvyIYN2AiP832acqtALmdOtymuYSY7btPnetTg14oNBzEiu3uFuCJtfmEfNnzqlqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qfSr0y9L; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DZnRJYzp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bM1ZH0qMwz9scC;
	Tue, 17 Jun 2025 11:20:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750152055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6AfJ6q2l1xTQkzXIphq9dVeNUU5URa1obSC0K+F/1Q=;
	b=qfSr0y9Lv0Gt4mbE9MSI028j8/3P+XGE0e8kUdqvNJUbrc2kJlxUFCZCUWQXwR/VGZQMi4
	6IinmMwB9IQLykP2LyxtYeCDjFJSnY0bPhNfUbZHbSrHyRdCBqr4Wy+7tcDSk75lY5ljal
	cpq75Dz73RhC1naE9r9zi2PXG1qy/EYPr3cwpVyZqpb0hNIDPfid9F0uWnrk6Qskvh0PwI
	4RPt4JVZn3wNFzTtzHhchylcI7gUpRRAZ8VYsBSRLQ52DJ3JQ9VXf9fMyekxOTqLLBjazO
	gXeFmVpNXWX4Rru46QcdU41D2GH06Hf1fnWB/X9pBW/dsvpCJiFYMeYM195BhQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750152052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6AfJ6q2l1xTQkzXIphq9dVeNUU5URa1obSC0K+F/1Q=;
	b=DZnRJYzpkMtqTxOrqk5DNq7vfo6B1KQuddGCESzf9fSM9FCfHh7SQC6NljdLCSDrUjoukB
	V1w44D0WV59FBPE3WRldQGE2xurS6hpFFWHs+0xSCpKTWMZ2sukOtPEuKL0GJA+1upPj43
	BflOFPpYsoshf9netu7b7znQ/VatHvkS3UVfeyeJkUDYhPt5WtNOE8mMWTVmYHehvALYS1
	4es6F7qps1YDMQ9ScaOkPSUqln4Rq2iuwpqv0zp/SlQaqIHHUMhz82TBDSDtqXe5caiGmL
	dC1p52kC7x6mmUtw54Jby69HLzYR+ujVvl4o785l/e3/edqrLooE5AAVwFgGFA==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Document Argon40
Date: Tue, 17 Jun 2025 11:19:34 +0200
Message-ID: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: d954ba514zwjqyrit5eawbcz5x4kxwtp
X-MBO-RS-ID: 2f40c214a487ccd4916

Argon 40 Technologies Limited is a SBC expansion board vendor.
Document the prefix. For details see https://argon40.com .

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Add AB from Conor
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 3f23f6f93b62..27e2ad136931 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -149,6 +149,8 @@ patternProperties:
     description: Arctic Sand
   "^arcx,.*":
     description: arcx Inc. / Archronix Inc.
+  "^argon40,.*":
+    description: Argon 40 Technologies Limited
   "^ariaboard,.*":
     description: Shanghai Novotech Co., Ltd. (Ariaboard)
   "^aries,.*":
-- 
2.47.2


