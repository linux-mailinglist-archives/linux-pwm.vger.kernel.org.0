Return-Path: <linux-pwm+bounces-6478-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BBEAE3F2E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 14:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0B17915B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE125BEE8;
	Mon, 23 Jun 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R+nrE6pT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D89248F41;
	Mon, 23 Jun 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680087; cv=none; b=WUydXwaxJKHVRv9GumMiIwrPa/ZDph8lZqkZiREzUh+vZYd1lk8mLrw8Lvh0EZQTLKieVh5griWao3VXlBcCcHpwdwTpO3urssPoj9PyQDP3cyu3VRpZMZz/rBvbiWKCCDwJnkHGaQxjxxc8x82O9rwgekqm7kCplzuGoFImENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680087; c=relaxed/simple;
	bh=vL7vsZnHZXjhrnXm1+pOHRiqQJaLYZAMfyW8Ay4L6Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDS2BJ72v8QetL38IbgLzH9WBoY0XchEd6zbTkOrtNWMvBJidGerA9pYn651yq5Q7mBudDKyTVqRpMX+Vjq0dV/G7QAyLgo8/Ofl7QjQvQSZulom34Ogjsz5I6RkRjD53KqvJk4I+YZ4IrGYiC8+LuebEebN6S2bDpEx7FrXJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R+nrE6pT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680083;
	bh=vL7vsZnHZXjhrnXm1+pOHRiqQJaLYZAMfyW8Ay4L6Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+nrE6pTnZW3Qec8oxp/sYkd8N6AQksyP99/7xe66jIVWPB6+vD3CPyw5zJ+LCMWC
	 2DpRHq+OVAJs1OdyJBDq+d1HjXTPTR8mOaFslfe3q4W8JbFdVoU1SVUhZIRV3hlAYt
	 XnFF/Cm30MTtDQeeQpIKAEs9HmT3jr8bjy2SqLIaXCdBwSQlhaW8sT+LSBgiCtQTh6
	 ogDiGa0qt3mP4A+urCPeVammDnVLwCHbuXxhdjcGHuai9yv+HDLSH9LVLQoWk0Th2d
	 TUjDOFFDxn3B9iy7blvaNEEuD3GDwarTsn6qTb1Yi5Cswb32+N86J4069+GAqzTzjv
	 He0XDdaljhutA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 374A017E10D5;
	Mon, 23 Jun 2025 14:01:23 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ukleinek@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	john@phrozen.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 1/3] dt-bindings: pwm: mediatek,mt2712-pwm: Add support for MT6991/MT8196
Date: Mon, 23 Jun 2025 14:01:16 +0200
Message-ID: <20250623120118.109170-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120118.109170-1-angelogioacchino.delregno@collabora.com>
References: <20250623120118.109170-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible strings for the MediaTek Dimensity 9400 MT6991 and
for the MT8196 Chromebook SoC, having the same PWM IP v3.0.2.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
index d515c09e1021..fc31758a40b0 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - mediatek,mt2712-pwm
           - mediatek,mt6795-pwm
+          - mediatek,mt6991-pwm
           - mediatek,mt7622-pwm
           - mediatek,mt7623-pwm
           - mediatek,mt7628-pwm
@@ -32,6 +33,10 @@ properties:
           - enum:
               - mediatek,mt8195-pwm
           - const: mediatek,mt8183-pwm
+      - items:
+          - enum:
+              - mediatek,mt8196-pwm
+          - const: mediatek,mt6991-pwm
 
   reg:
     maxItems: 1
-- 
2.49.0


