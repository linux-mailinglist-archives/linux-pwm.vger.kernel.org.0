Return-Path: <linux-pwm+bounces-3004-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A351D94E247
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2024 18:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68121C20A8B
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2024 16:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D31537A2;
	Sun, 11 Aug 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGp+drT5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEB14B950;
	Sun, 11 Aug 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394103; cv=none; b=MQvvwyTP7LJOpK6w+xzGJDbx3KZANwAlqvubcAdkfcbtz1JH6yf2Q/74i5DMBY1maxUL/xB6r+UwUAW5B3jSQjTIz9Zfsuy6hnVKRgnmxA4WQUZL9flJ37SaxZH1hSEjERDc3QX6sNgJor+qAg/GQXr91+oxFKwW5ZOkr7hFwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394103; c=relaxed/simple;
	bh=wJFMhbCv/bZOQ/BXJquP/1bxIHtfQajOUmGI1FVYbnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoBWBv1RFpYgb2F0UtKeDkj9DsUV0IuiDL3IS26EQS7pfJF8zONn793Nd6TdWwa1zYx3XCbFKa1wg4yXs3NsKLmjDUAqzNOge7czXj5SMbBEFOslmu3nDg9gkiZLi7zcVMXYRqIVf4oyK2RyhqqoB/c7f4ZQh4/ovQ3N6/uC4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGp+drT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E409FC32786;
	Sun, 11 Aug 2024 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723394102;
	bh=wJFMhbCv/bZOQ/BXJquP/1bxIHtfQajOUmGI1FVYbnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGp+drT5SYfbdlqabf1aF/ZQBjTHEHCeBaWJ5xZEJeIwTOQPWLQl/SLLyWi3cKmLo
	 +5GhYK+sDBogAfdkMTI+uKdgL0w1c+uJ6DB9IyjyMZieohymwetKk02sTuQZ1PvzU0
	 jxU3ZMFRMuq/bJG5SDJJRJiBBQHmed/VErg3n2Z7Kfw8zUzH1RH3QE1SwynPLDfLDj
	 xOyBazrhi0rrCEc8pfzAuYxArNr2PAR8wWhVnWyLBerb3Xv5HLAP9/muETnqZmmZ9P
	 Oh8wyDv9tYOF6i1LrZT1jaVGB0QjDrTWwSUNynM1Cf7pduAAiFFTJ6eWkdP7AUbwwM
	 hvxfUzN1OUX/w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: pwm: Document Airoha EN7581 PWM
Date: Sun, 11 Aug 2024 18:34:31 +0200
Message-ID: <bd0528c45c2e2efb799b59ce503ab8fed196df07.1723393857.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723393857.git.lorenzo@kernel.org>
References: <cover.1723393857.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Marangi <ansuelsmth@gmail.com>

Document required property for the Airoha EN7581 PWM. The device
requires 3 different address for the sgpio, flash and cycle config.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/pwm/airoha,en7581-pwm.yaml       | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml

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


