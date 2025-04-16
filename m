Return-Path: <linux-pwm+bounces-5532-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8BA8B82A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11ED51902BA0
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62D248862;
	Wed, 16 Apr 2025 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dL0enLZP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C572475F7;
	Wed, 16 Apr 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804979; cv=none; b=eH8EGhGSc7Xn+PFS8NpKg21EI6qUbEvoHHc5QJdhfXgb18B7U/QZ4kxyP+TRHlnYR50vb+MxKD99YA6EmKqZEtjmJ9W8PmmOf+hu/2n1QAVnoh84alI1iVzGc1TvMm+XqYVq0ISLUTisevD8YTCnqLdIXc3ht0sxfO9l1XIKWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804979; c=relaxed/simple;
	bh=HtFDLhPzcyHbKcIfsvzrKJi3kvbFoXZ8Cs8iUVo1V/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JScXnzT8a8wOQYkobJF14sDOenSyQs+2rgcmjoY95rPoRMuO6SVLuU7bn88zWs02mWSm6fXx1yxzMAzYOiV2dgaD9IIawhw6TWvHqpBGAC51kc14QMEU0S2FylDhQTJPgMAzAOjE88I6wKOK+3DqE+Q1G7TdzCZkPf6okPLpWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dL0enLZP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744804975;
	bh=HtFDLhPzcyHbKcIfsvzrKJi3kvbFoXZ8Cs8iUVo1V/0=;
	h=From:To:Cc:Subject:Date:From;
	b=dL0enLZPStpWCW93CKMPvLqU1feJEdiAJON4Te0Hy0QgPXYCtxpceS6oyXgRxHftT
	 P+l1Pmhlhn+e/8cUuDqU2yxK06+aWO9s7OlpNG3XxTFaes1egqPxf0D2bmQRs5+KCB
	 LxN1XRaY7FW3ZlO5GSPrafZWqLLGl52IrTzYendWXXPl0ESmzGwiSFDh2Kn+TkaMSk
	 8pvnG2AZ+juTZlTEwVT7+qB1El8jr98j2NpFANDRgPO8d2UzAi42YEsu7oB7h2muW5
	 Q0qYAA0eightWbuid5Hb6a7/3qiEgCaaRY3+k2Bsf485nKVwbh7d+YTRr2QWmR5JhA
	 2guQJmAQlQJbg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF16317E3624;
	Wed, 16 Apr 2025 14:02:54 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ukleinek@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	jitao.shi@mediatek.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] dt-bindings: pwm: mediatek,pwm-disp: Add compatible for MT6893
Date: Wed, 16 Apr 2025 14:02:53 +0200
Message-ID: <20250416120253.147977-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the Display Controller PWM IP found in
the MediaTek Dimensity 1200 (MT6893) SoC, which is compatible with
the one found in MT8183.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index 195e4371196b..68ef30414325 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -27,6 +27,7 @@ properties:
           - const: mediatek,mt8173-disp-pwm
       - items:
           - enum:
+              - mediatek,mt6893-disp-pwm
               - mediatek,mt8186-disp-pwm
               - mediatek,mt8188-disp-pwm
               - mediatek,mt8192-disp-pwm
-- 
2.49.0


