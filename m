Return-Path: <linux-pwm+bounces-3417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C098C46B
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 19:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A943B22198
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8F1CC158;
	Tue,  1 Oct 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH0/Y1qj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCB191F81;
	Tue,  1 Oct 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803811; cv=none; b=rH3LfMo68ekwLKFde8xHYRGRVINUxUfr+bdbwmzwOEj/DAg65vB6EyDqiZlwqgWVmALTEYifzFiz7ZVbrKR/8wWMHzkCq3DTmihX4EkENr2PLDlvnlB+aJK8kFm1443vcINKGbhVui3SqwcgjwkbUfPnzrolWPNKrc+WoOQnW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803811; c=relaxed/simple;
	bh=WcNrIcXShBDZ73rKxXuuHmBcBczHBwXefG+qZ+ja9o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJD4VVGBM5TR6sGUhM12Gtw8Y+6QSoOjOUpr41loz/s0cFNk3Ki2i9Phi6N+S127gyzDyUw90HZlbDSOUhoqT4mDkuwnCRNxK5IdWKp0tc7XCCZaE1N7DmFN0ou8WXy9UmglRuzuK0twiQ7rnfbVtmRt1dCKwO0+se/ufkLXDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH0/Y1qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DB6C4CEC6;
	Tue,  1 Oct 2024 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727803809;
	bh=WcNrIcXShBDZ73rKxXuuHmBcBczHBwXefG+qZ+ja9o4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jH0/Y1qjiFnEZ0d8BXzoBZapdus3KsTzxOrT8IWRxfEwkHY1r7oFDUS+yL7u+cV3k
	 g/eQuSfET9hazel2fDVsEmjWlQdA1MYd7DdzsFreZflwAeNPBaMtJy1rfL/CrlWXzg
	 ivuYLrDm7F57dn4aifH4FAeCcebhCHWfTh8JiQiq++sEkbz8NoDJV+OSKuqVAZRhRy
	 8RY4R5KGFe61XhthtQWF9hGpVg3qPvZoPXFxdOpIlwWaSNksfiXPmbS+UOliDHms6F
	 XV9zn5olg4gUz7Y1xQLrD/QHGw6kFuzHdT6UkzUTRb1s1yhiH/Kd+eFHxHNW+VN1Er
	 +ROiWdrdPYUEQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 01 Oct 2024 19:29:30 +0200
Subject: [PATCH v5 1/5] dt-bindings: arm: airoha: Add the chip-scu node for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-en7581-pinctrl-v5-1-dc1ce542b6c6@kernel.org>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
In-Reply-To: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
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
X-Mailer: b4 0.14.1

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
index 000000000000..67c449d804c2
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
2.46.2


