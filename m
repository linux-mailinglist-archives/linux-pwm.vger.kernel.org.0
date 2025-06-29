Return-Path: <linux-pwm+bounces-6571-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE37AED18E
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 00:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C795C3B3304
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Jun 2025 22:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2023D289;
	Sun, 29 Jun 2025 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fSqGtMmr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RZbj5Pq5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A11DD0EF;
	Sun, 29 Jun 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751234897; cv=none; b=ZfgjXbp2G3goL+GARjWRhLurBnMmaz61gBdZXAOBU9Rbgwh/OlqwQeun1dJRssuXSOEu7lkIvHXmFO6Zt4Se+Wp7jQHc/m6DK8RpHtY0K4k4VgUIPgU7a6sPCqF8umZapshxIB8HnAC/oFUg1sxfVgw4bO4w9MN2WSf2D8BuAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751234897; c=relaxed/simple;
	bh=IqmtNMiSUP8mH+rdUojloyJ4DbIFexlyLlfKKr7qEdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YXb++TIypJflX+dBdCrVlk6OucSmrvC1JjQNhK+zna99O46rpnF1iKrwsZ+HgWZEolxxHqcTyp4pVZAqd9SPpx9KHOSAqWdziGuOWtmM0xI47KUvrGPdcx/eloIseqeJZnGADlAKKhev8TQm0xgS8FuvQyDRlzBiPVDo5j0Nzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fSqGtMmr; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RZbj5Pq5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bVk262Xd5z9t72;
	Mon, 30 Jun 2025 00:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1751234894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=goP7CNuKRv4eXGEdm8Fir/TiSwkU8B896oNpAWx4js4=;
	b=fSqGtMmrdXXxwU9U8xsA7vOZey0eeQk1HTbEJ7w5imkpWxKvwJk0Q4kdXfSpi8zPpOTkTs
	2qc7v2bQQqFtJXoIQkhbB4ftqh83t0tfMto3Taz2sMoXu3iI2LXqXICpa/NjeWJNbggp4k
	ehIlxxQK0cbJhl5oNXW0d56tdHKH9tsoChGnEn/CenUCiLIzlad9/AbI1/grdizEBGYBjX
	qu+hEm2DEaj2woDX8jplWenSc/ZC+d0DFt8dKEEGV35+sKB13ISjmLgOt1doy1cF77qnU6
	aIMzZf3GVTHpKKF10h8IzNBdGpQh/qfZyNpTQ8TFc/7HpKRTmp2jmtsOuYOzhA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1751234892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=goP7CNuKRv4eXGEdm8Fir/TiSwkU8B896oNpAWx4js4=;
	b=RZbj5Pq5zGaA0Kltgv0NyZrMzEXYrJ4sIMvKTW3tSm5IiyIx5jIvDTG4UmcLMKNYpWSaJ1
	RCfoE49EMtqsrwyYIgLiM2RrQaI6jCyaXzLmB2kEvpvvEQeb5aGGnEH8fGgD0VNcAGmWJC
	KSCwBzz/0Pp6735q0bMu9Whv7fxgrikFm9yKmf6qJss990r62ZQjdukfBqURuqDqY8bdXO
	EfRDUjQQiig64DzP2juXppYCRkNUbkXgXQTZ6OlxELSot6G82c5zVbdfOfZCtdkqOuf+yh
	j3AFUmaAFXODehgaCtZ9/1KGcnY+uMBIuUq7Nma+4BcpcgMzzRysFvGTYarBlA==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Document Argon40
Date: Mon, 30 Jun 2025 00:07:18 +0200
Message-ID: <20250629220757.936212-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d9f8c6c5207c9b59db9
X-MBO-RS-META: y43iepzpn8cd4nd4co7yepnzpuaxykxa

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
V3: No change
V4: No change
V5: No change
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


