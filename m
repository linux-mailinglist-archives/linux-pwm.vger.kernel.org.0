Return-Path: <linux-pwm+bounces-3617-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6617B99B765
	for <lists+linux-pwm@lfdr.de>; Sun, 13 Oct 2024 00:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0331F21C1B
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD019993B;
	Sat, 12 Oct 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ6VwWxc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485714A084;
	Sat, 12 Oct 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770895; cv=none; b=fqpahi7zBoHqXn/vGDb8sSjOpoETRm9Vy/A5Itijx0ZS8x2xRj2NVdGvyQmSsy1j8f0G/OXQwby9lNh6SyrPbF7DB+u6Y0FmzToMpgK02k2IkdQgFmDqgCC7X68NnVWwdI7Qn9wrkvwSQsDgHfYlKs67LwY+C8j/oMQtFZ+uohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770895; c=relaxed/simple;
	bh=PHnsXDPgonSGur7LNFvBXgYxGpnNy03h+D9rXnrfuM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gj/33TR33A89mhC9egvLZNuMnTPYwInZTG4ze9i3iF1B0DwglXJGIqlvcYjb55IGmHkwfcQunCIGtKRP09gSPzJqoHnyE3Nr/sak7QEIZEfgdZu7dEbH+eyqMLQsWK12MmykWaReLE5d3UIQh0Ruy7Gs6grQijeLYvTuKTgE7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ6VwWxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFB8C4CEC6;
	Sat, 12 Oct 2024 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728770894;
	bh=PHnsXDPgonSGur7LNFvBXgYxGpnNy03h+D9rXnrfuM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fZ6VwWxcxiJFm3toWynDnVVn/2JLUpwSrMC9jiVIsRav6D6o3KFpg/Xgt/YkIs0Df
	 XquD1Iu7EBIWa/qIc4mBVU1gcuUxAaIpuhvg1hyoe8I7rC8XyIKwiK/l2Z4At8kDmJ
	 EOXSz9A0MUqwCxJlOLcC9W4Bzhs6tP08ciLHrTDMkQaMS1qzaX5SV8bjBlupiv8vbq
	 y9EHiaMd3pQZBXusmr2Szv+ilxWqHnIYYpUfZFZo16fbEL9naj3Ibb/hqCOesgYCCm
	 Q9W0jwhT0IfHVTpsv75fpobTIkuKxUlfGw5fSIm2Ph9eKfsP9SoCbDwKcvSElqllWs
	 g3FPu1H3mj0/g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 13 Oct 2024 00:07:07 +0200
Subject: [PATCH v6 1/6] dt-bindings: arm: airoha: Add the chip-scu node for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-en7581-pinctrl-v6-1-2048e2d099c2@kernel.org>
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org>
In-Reply-To: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.2

This patch adds the chip-scu document bindings for EN7581 SoC.
The airoha chip-scu block provides a configuration interface for clock,
io-muxing and other functionalities used by multiple controllers (e.g.
clock, pinctrl, ecc.) on EN7581 SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/arm/airoha,en7581-chip-scu.yaml       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..67c449d804c22b6b8268c9840995fe2584349b58
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/airoha,en7581-chip-scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Chip SCU Controller for EN7581 SoC
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The airoha chip-scu block provides a configuration interface for clock,
+  io-muxing and other functionalities used by multiple controllers (e.g. clock,
+  pinctrl, ecc) on EN7581 SoC.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - airoha,en7581-chip-scu
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      syscon@1fa20000 {
+        compatible = "airoha,en7581-chip-scu", "syscon";
+        reg = <0x0 0x1fa20000 0x0 0x388>;
+      };
+    };

-- 
2.47.0


