Return-Path: <linux-pwm+bounces-3048-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00295869D
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42901F28066
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45118F2EF;
	Tue, 20 Aug 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO8wgfIU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608618EFDE;
	Tue, 20 Aug 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155977; cv=none; b=asM+IX0xeFdeh/Q8Ps/0Rn/syNowUUtCsyODJpt81GuB554mb7nOTQzl/7PlS42YgcMR+4aAyrZ9BmQPZ5EuFwJcl3vwdPQfIB/Gy1InW+pdUC8Dx43F2xI8rqJ0Z11PwopldxpV3G6s7VrkzHMaiQCqaHhU1k87sIvops2u7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155977; c=relaxed/simple;
	bh=JRyNTg0BGW3/QLQuzTD0wSUydNEf34YgmH0Ssm2r2Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNHvxCAnCcvtLofHXJrkyh+8RszUfsyaxzq1Ms8MeIoGM9lTc/DsE7jOVYyAXqo7WmoakAgipZp6HGCuNpEIE9MBGFjCBXhks4O5KJEkSG7AbBevCK8aKSa5mvV03QtFAa9doOHQPzMp3vrXhoQ3ML0V6SQ0tKjzLMZ8Xy0jrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO8wgfIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ED5C4AF09;
	Tue, 20 Aug 2024 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724155976;
	bh=JRyNTg0BGW3/QLQuzTD0wSUydNEf34YgmH0Ssm2r2Sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RO8wgfIUY81DnpadrE9+R1NMfG5RI0CNN82Wyg6nZzF1DaHpXYKx6PX2Rlc/gIki/
	 F17o5iwqE0xnY+LbcH23i3lVxit9OkIyXWUlQnd3ZUedRU2e4dXvGtgLeLY5wNO025
	 hIH7vYNHWIzma4xP4nZmhyoWB47LPnEJoqmn9QzO9PPGCwuvyKZ5yW+ux39V/7Rcy/
	 vF6uLyWHNidDSRBWBkx0wW+xcz6x46EQ1DU/UjRuTzxQJuJZzZGTKB7h+WKUr93ycy
	 mdQIUZT7xTdB+FLygNhz90iIrqlLFQc5p6UOIyzBap3+zNpqHkixR7zpqqEse6VNzP
	 bXH963wtyOe3A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 20 Aug 2024 14:12:15 +0200
Subject: [PATCH v4 1/2] dt-bindings: pwm: Document Airoha EN7581 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-airoha-pwm-drv-v4-1-2b1c2b760744@kernel.org>
References: <20240820-airoha-pwm-drv-v4-0-2b1c2b760744@kernel.org>
In-Reply-To: <20240820-airoha-pwm-drv-v4-0-2b1c2b760744@kernel.org>
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


