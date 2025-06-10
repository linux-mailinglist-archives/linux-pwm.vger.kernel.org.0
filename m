Return-Path: <linux-pwm+bounces-6285-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98026AD45AA
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 00:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A488F7A42C5
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972C285401;
	Tue, 10 Jun 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pSpZ0ApC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O0VLt9FX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD4283C9C;
	Tue, 10 Jun 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593332; cv=none; b=NR8RkeRwZK2tMvL19iF2+9w227wuF8I1UrJEBc12cgO85itDWUz/r12zLWAW3Pmcp26JpmyMv8+KWDtRZwvj1lfMSS4zutlOQMI+fKutyMt3fUMyHRgl/SxmTmzum/TpBz5XaVn7B4CxXWkvcn64bQIg+NkTRZvbZPahDIkGTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593332; c=relaxed/simple;
	bh=iayzfM/Ju6LeDQF4aXAHBQMkzRViPd3vVHDR5mUjaBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhIfeDhe9PNV5Ddb2WzYO+vJhWkL5+nQSftCHQrGAxr2Vz2DDJbx1bGkoTSeDX64G8ntUr+Cd/lhFwUE7yZwQQzXwfji8kQGUK0REXtd7h2oVkOgaFGzA75XYDThHqv7PYEk4bpqgzQIADJD/zqKtwG9B2NKoXYvRzYMhAn4DNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pSpZ0ApC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O0VLt9FX; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bH2xX6jS7z9sQ7;
	Wed, 11 Jun 2025 00:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749593329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cNXb8i2F6QBDXkGyRYfV4fYYuteazUju+U31ouNe6Sc=;
	b=pSpZ0ApCx2a1MCjGTk5RFXKdLRSr91zhySIYoXYRgvTPcrZdyZYflK4flYRMt7bpUQEoIc
	JKLDiqq1hekLy58INCiHpkknnFyUlf5IXTKbuaeunfOj7YLNMhrbB/jij5HatJq7wTSiq+
	kGk4ab9asFlSviNGw8q9Zzm+EnykVcCqu9s8B43hZDz5ZBbUrEBRs/7KvRj4efTO+lOVMV
	bEmlvpYCrJnuMgQJTC1mloFrFJh4MoBlElBBVZSdeleif4n6vmySx9jpueflNSpkECQuH6
	xeugl583eqdR66DQJ3cHGHSTMnBQJ3wlYFjw/9kC92qY4smbZc1cbtWkZCCK3g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749593326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cNXb8i2F6QBDXkGyRYfV4fYYuteazUju+U31ouNe6Sc=;
	b=O0VLt9FX2HqZ0/OHHGHvPqSLgfObNAm00xPJPU+Ka2EYeHlh1Dfdhsj973vs//xZ/0O/BW
	P+tFB917u8519pz0FJEswZoqWT29Zl88GJ3G9I+gc1NcAB8Zncq2M6G43q0+8T6YTvV7fC
	Q0FMrezNjhqiLwoaKLtSVZfOewWO7O3jurROPrP2QvEJU01UvFXqoI/KDyFEQON4rBqrwH
	FBI7IZmZj1TkakkxqdcS1PP+HSQiJFcataZHSzF6u7W0HzWUJ5sSuB6U3ZCeEex5mC3AtO
	BXWRmFCJTHLtpLopcXlcUvatF/iMXfjNZGiEwz8mipD6ROlLXcXsP/L8q1NTMw==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Document Argon40
Date: Wed, 11 Jun 2025 00:07:25 +0200
Message-ID: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bd2b90a43737c1aeba9
X-MBO-RS-META: 8oadupbxxdzicnyjkn31qapfnbqnpps4

Argon 40 Technologies Limited is a SBC expansion board vendor.
Document the prefix. For details see https://argon40.com .

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
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..e5e5bd34136a 100644
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


