Return-Path: <linux-pwm+bounces-3036-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA7955C61
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Aug 2024 14:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4612FB2110D
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Aug 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E1182A0;
	Sun, 18 Aug 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzSOWCKu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097217BA9;
	Sun, 18 Aug 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723982620; cv=none; b=LSN0zKS47pq1Fm5VTh78gPyJvHAZ8w61g+GvfEPsCxC0lOobb4ZT7aZYdv2jUG7dPwVSXLMwWjeQ+6ZUSnPjvNRk32h+i3m2YK5824teMHD8fvbGn4+RkgG20wKDZVlayx/0Nl2GVPgF9WUzKKfT5Bxp+BHJ9KkBXg2j8necj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723982620; c=relaxed/simple;
	bh=JRyNTg0BGW3/QLQuzTD0wSUydNEf34YgmH0Ssm2r2Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBxI2M7GOzPjkchuMwO9t0tMGXnwvJNn5anpCV0V57wLOQBUp3bJ57/VC0fkLHDIijv9GLEGORT/V7T5J5AOjJhyaRwkz3DJitj+8zqgmGiysVCX0QIQ78cf2Ur8IuGxrT3CM6zgc0XhvXqkjB1xu/XLGryxRSQY/q3NYeFTKiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzSOWCKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF60C4AF09;
	Sun, 18 Aug 2024 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723982620;
	bh=JRyNTg0BGW3/QLQuzTD0wSUydNEf34YgmH0Ssm2r2Sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QzSOWCKuzqxlttzDn9Pnts5NLIy94NmDhghqf7hBGQoNKHBH28ArCwSr7F40B4h0n
	 TRbSPajNlJ7nrxnIcaBbO8dr9XabZs7rruxIr0edslL0LydBrrvHyyExNhW9HeGUSp
	 1flU8+3ANbJZBgmnm4xHviefdDEy0OgYmUrZS+OmG3yWmuI2w/QEcfb3Z2vHanWzXz
	 Mfkt/FEcYJtOoFH1PGn4T1aEToXpKleyykygY1DCiyh35XucT39b/TDmUnC3FcxP3P
	 rx+0tB6UA97qZrJBeH1VxwNxtws4tNT4tG3qfbuyjxl+3AMz7KAu2ecI8euhMqsF5E
	 r8X8+W+HPoevw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 18 Aug 2024 14:03:26 +0200
Subject: [PATCH v3 1/2] dt-bindings: pwm: Document Airoha EN7581 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240818-airoha-pwm-drv-v3-1-e398f3e41916@kernel.org>
References: <20240818-airoha-pwm-drv-v3-0-e398f3e41916@kernel.org>
In-Reply-To: <20240818-airoha-pwm-drv-v3-0-e398f3e41916@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, angelogioacchino.delregno@collabora.com, 
 ansuelsmth@gmail.com, benjamin.larsson@genexis.eu, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.0

From: Christian Marangi <ansuelsmth@gmail.com>

Document required property for the Airoha EN7581 PWM. The device
requires 3 different address for the sgpio, flash and cycle config.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
new file mode 100644
index 000000000000..52470668f90e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 PWM
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: airoha,en7581-pwm
+
+  reg:
+    items:
+      - description: sgpio config address
+      - description: flash config address
+      - description: cycle config address
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@1fbf0224 {
+        compatible = "airoha,en7581-pwm";
+        reg = <0x1fbf0224 0x10>,
+              <0x1fbf0238 0x28>,
+              <0x1fbf0298 0x8>;
+        #pwm-cells = <3>;
+    };

-- 
2.46.0


