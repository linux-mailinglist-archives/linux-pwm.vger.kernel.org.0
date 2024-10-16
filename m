Return-Path: <linux-pwm+bounces-3676-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D89A06A6
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 12:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE22E285A5C
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17821206975;
	Wed, 16 Oct 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So7ochwn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21620696E;
	Wed, 16 Oct 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073306; cv=none; b=UrS8BvQsukP7Ym+yP8qOdQsb1WOj3N0D4EJIAGo6cgTleTC+QJqU0uRTFlvQlLhX9WnD4DX/hQEjN0LcbOTCCmwuhc3we1Qcn1mzNLqWevgtpiNzNGeQqHkAPqZjTDjqZs/AJUojHtwauqE0J94CFBrnOERdd8e5qC+ZD/dz72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073306; c=relaxed/simple;
	bh=gkmBN15VmJ7XhF8wlo5CJPi8/ZAowgy4Brqo0iLFSVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtG+0DQ8cB1WKGksjlAG5EXmKr6qw3QiLZxJNLai75r3CL7fZVBlaHlW75X9HCj+W8ICSn5/xdVyUKMApRVwQKdAjsoGHWfl/Lt+QABG1+hWWww9gj3QbS996zjVtnaf8UI1QoG74ArAxd19A6L2yPp8L/E0gFw9LloSEaf27n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So7ochwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F573C4CEC5;
	Wed, 16 Oct 2024 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729073305;
	bh=gkmBN15VmJ7XhF8wlo5CJPi8/ZAowgy4Brqo0iLFSVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=So7ochwnQg+bCQGI3nGcumfQYT9J0NVQZqSyssNSjgOUidMRjDwf+Avlyhv/q/NDL
	 jv+wLGmUZMDVoR1d2MawUDMDNRljAInbVXx4AZ47pmQQRyyoRLEKv+ud6GStP19qC3
	 ETkw8QwkxamtegTXQUss9w2dxfdLGxr/7ruwUABZMvb8ukXYweikDMlvtvg1swZ0dw
	 nMg261H/jIoHSjMWhWOhBQfcpvo9DV/C1pWXifzLkoidITnVp7q5EoYuzLeS/OrFcP
	 53ZVr9epEmrTyAM5Px+PE8y/KsH02i5mE0jYhCSa9GXcBekQClv16B0YgUmIHK8rCb
	 jIo4HHhLS9b7A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 16 Oct 2024 12:07:32 +0200
Subject: [PATCH v7 4/6] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-en7581-pinctrl-v7-4-4ff611f263a7@kernel.org>
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
In-Reply-To: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
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

From: Christian Marangi <ansuelsmth@gmail.com>

Add support for Airoha EN7581 GPIO System Controller which provide a
register map for controlling the GPIO, pinctrl and PWM of the SoC via
dedicated pinctrl and pwm child nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4a81ed82ef34dc2b99594098584cc77f67f276c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/airoha,en7581-gpio-sysctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 GPIO System Controller
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  Airoha EN7581 SoC GPIO system controller which provided a register map
+  for controlling the GPIO, pins and PWM of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: airoha,en7581-gpio-sysctl
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  pinctrl:
+    type: object
+    $ref: /schemas/pinctrl/airoha,en7581-pinctrl.yaml
+    description:
+      Child node definition for EN7581 Pin controller
+
+  pwm:
+    type: object
+    $ref: /schemas/pwm/airoha,en7581-pwm.yaml
+    description:
+      Child node definition for EN7581 PWM controller
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    system-controller@1fbf0200 {
+      compatible = "airoha,en7581-gpio-sysctl", "syscon", "simple-mfd";
+      reg = <0x1fbf0200 0xc0>;
+
+      pinctrl {
+        compatible = "airoha,en7581-pinctrl";
+
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        mmc-pins {
+          mux {
+            function = "emmc";
+            groups = "emmc";
+          };
+        };
+
+        mdio-pins {
+          mux {
+            function = "mdio";
+            groups = "mdio";
+          };
+
+          conf {
+            pins = "gpio2";
+            output-enable;
+          };
+        };
+      };
+
+      pwm {
+        compatible = "airoha,en7581-pwm";
+
+        #pwm-cells = <3>;
+      };
+    };

-- 
2.47.0


