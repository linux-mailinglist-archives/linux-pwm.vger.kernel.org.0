Return-Path: <linux-pwm+bounces-6389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC099ADBE21
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 02:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA47716ABBF
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 00:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD814E2E2;
	Tue, 17 Jun 2025 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="egH4I9Lr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SrKEc3Jh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94A1494DB;
	Tue, 17 Jun 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120159; cv=none; b=JvVp8mkHpcBePRC0OU52hy5Hv9H0SHfP8EDfRQRM4O/EQ5VsZqTkQrxAqCun+gK+04E04CRIQ92IdyNOaudMYpsPcADXrUml8djF3Sv3kkkw08zKza+3k3wqzhXs/crbSR7xoZkrMSaSpoFzfb5da3t8oBArLWL/ZptO4zCPLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120159; c=relaxed/simple;
	bh=cUsHRhDhRUZkpg9kblm/H1MwHaKU2gn9eRp/9HCmzj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAiynRdAMJsPyyeD1XccCW2x7rksR+7x8MVn/ZPZff0rGkMY88l1NMlfag4FijlMd3jactaj/sPdjytVWqzCkyDFF8OmkUg4Y8zkxqG/gmyMoPx5adYfOcOO35yGh9urTPfMNTO0Gd0x0PRCToUtY/mi2c7nPPB2HyilfsYmHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=egH4I9Lr; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SrKEc3Jh; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bLnmr0lm3z9sWS;
	Tue, 17 Jun 2025 02:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750120156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6AfJ6q2l1xTQkzXIphq9dVeNUU5URa1obSC0K+F/1Q=;
	b=egH4I9Lrws7W9HnzlZ8YD/F4bBVZPZzOwM9FUudB+cdqd88R+oMyjaBxqGAqu8P6OCMorF
	B5jaOYEQLJbuahq51bQXHanOMIyuOQ1oDzV4b/goVai4QD/0aW31bxvQS4XxKvR5KQVavi
	qLhbSoR6Sq1pPsb7QiMiPq+GDFUtmkCRGF6dxbelKcDgC1000Fw81KilMNaXq0+LyWcFDY
	7t8GW6ITkbJ1abHaKtOiNrxxdgV28P+x3cGZp9ANIyQdyset0iGv9N8k1TdZ35yeIypfsk
	P6a/McpnoGOFbOTmiWhlNNV/GcMv2+3PTFiFSjdGOWkz6VqPoWR5m/B5yZzk5Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750120153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6AfJ6q2l1xTQkzXIphq9dVeNUU5URa1obSC0K+F/1Q=;
	b=SrKEc3Jhm9UDjZ6YjBoxDwK6HunGhgR7BhgIXWO2GQXFX8Q5l2lKdK2zDlyXBUqOUokccQ
	wcn+EPvYWGvpQjeUQ6Cy+Uz/N7HSePs0iN7KWPwEjcaRJsdYnOBhHsLZMD3Qh+LTcHg/e9
	fv98ouHcM1eCLkDm6CyCjn889N1AngK/kSRSEayK/UI1zsBv8rHHHEHKOTkr7MRptoRAXU
	YQ2kgFkGbiUwSCXP9C0TG3SmwcdVwB819wXHxqKyVW4+kEcRUkAsftc2LpAiUWHWDapg2c
	MbUR4RptIfVtdiCO80ALSDg/tLNot3f3JUHB8EnzhvGvjT32T8jqQknkfK8ZaQ==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Document Argon40
Date: Tue, 17 Jun 2025 02:28:00 +0200
Message-ID: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k7woxbp5xtxa88iw9uoyjfedoro9bsjg
X-MBO-RS-ID: d3a3f91d5b60f889dc3

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


