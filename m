Return-Path: <linux-pwm+bounces-6466-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E211AE2AAB
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 19:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA83C1799CB
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A3255E40;
	Sat, 21 Jun 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mrqofd5a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c6GGJiS/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4DC254AFF;
	Sat, 21 Jun 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526493; cv=none; b=njRC1PucE3FPmvKjPxV/UvCFrTHKO8ZqNNmMgPlwqkJ6exOyYKhPO4sGQqqW8piW/5V1N71OY69og+TdSjFzXvtJZ6upxWYuF9tvHuN7jJbbrLFrURrUlsuZMpXWKYxtPPOxvWCy3/xYq8RhuRae5li6vICD82suC3T3kW6yudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526493; c=relaxed/simple;
	bh=6OfSQkNcSyiSvVGdeXL6Mxy95R0Si8VjjdDQJA+oXz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FtTdawo3/bfS0qQwsiJ+I73aQe5xCV+KsxKiYVAsdTGUVH9JqmKIWbyuRPtsC4BzGh8lxr80drAlEAH7kMCJcTmrMSdNZ8h/edk+cVRxWlWPotWMaQowSqmytzztyoJHEzKlBGp4gFkRUd4YWJqf/AoMwevGQ7daY8hUEQN4eCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mrqofd5a; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c6GGJiS/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bPh2r0pSQz9sdP;
	Sat, 21 Jun 2025 19:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EBo8Yvi2pAsyzwGSvE1lFTcdfv+hUDHZF7BIADWHYKk=;
	b=mrqofd5aDvqC0YyyBdCiShLPcX8mJl4CoYZOXwsOpMLxpbHFdE3v9xRYaiIiQZtj/+66W1
	ANKa2jgp1fID11cBD9AlszQeutXytNF/T4llLw5CEBdTz8Dh9XcrSunyr4IYWWUzeGHKwt
	acPfqvuK9qtovd7V+E+uy9JJXlu/9ttluITA+eRNidbLcJmEbQdQY3KZQRwRUcKydj8VKP
	Pl698CcXuvKw2i+umE5tXoCU4KzzojnIv4IxHdBDyTJbKEGQk9eRnSZ43rza/nnh9ZWdgg
	KF2rkSyX/Je4WmdMUTu8iADAX7cu32oKGoiHhGZfpDzgX4yWTGFVSkI62Cfu9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EBo8Yvi2pAsyzwGSvE1lFTcdfv+hUDHZF7BIADWHYKk=;
	b=c6GGJiS/nSUzyEJ7hTBPxKM0yZat3uDLrPjvS8kUm0729ZFcOkgMab2e0jLKkTZevr+k1k
	NYs6bz8Z4I0kDroZELwICkwbdhLAQertaEmLxI3Ips8cupG8L+Q35Vk4r3kWCqAYxwbMeh
	vx1LvmprjWNtnDEGX2PIrTWJ7N0ieXWyCyGf+ASd3hM17a8HkKt9xNt7RLJWzHFqJ3Dkmh
	nNp5WFnehDoo4JOUpxyyFhKuFKIHenmtrvGFWKXNYR7L8g7VmaTycXIoLD+0o9Q5sa3LJv
	WwdzyrVZBLTu5BDZX7JXzo/a8xG/kxRdHeIQ4NpAcQimunJTP/fYHownjw/cqQ==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Document Argon40
Date: Sat, 21 Jun 2025 19:19:54 +0200
Message-ID: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xib36718z9gszb94s7a7oeyjy8fhghn6
X-MBO-RS-ID: 129546e7473ccc60d7f
X-Rspamd-Queue-Id: 4bPh2r0pSQz9sdP

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


