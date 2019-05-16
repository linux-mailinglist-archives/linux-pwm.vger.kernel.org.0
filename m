Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB4206AF
	for <lists+linux-pwm@lfdr.de>; Thu, 16 May 2019 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEPMI4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 May 2019 08:08:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35971 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfEPMI4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 May 2019 08:08:56 -0400
X-Originating-IP: 80.215.79.199
Received: from localhost (unknown [80.215.79.199])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 17805E000E;
        Thu, 16 May 2019 12:08:49 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: pwm: Convert Allwinner PWM to a schema
Date:   Thu, 16 May 2019 14:08:48 +0200
Message-Id: <20190516120848.25007-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Allwinner SoCs have a PWM controller supported in Linux, with a
matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 57 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-sun4i.txt     | 24 --------
 2 files changed, 57 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
new file mode 100644
index 000000000000..0ac52f83a58c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/allwinner,sun4i-a10-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 PWM Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#pwm-cells":
+    const: 3
+
+  compatible:
+    oneOf:
+      - const: allwinner,sun4i-a10-pwm
+      - const: allwinner,sun5i-a10s-pwm
+      - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun7i-a20-pwm
+      - const: allwinner,sun8i-h3-pwm
+      - items:
+          - const: allwinner,sun8i-a83t-pwm
+          - const: allwinner,sun8i-h3-pwm
+      - items:
+          - const: allwinner,sun50i-a64-pwm
+          - const: allwinner,sun5i-a13-pwm
+      - items:
+          - const: allwinner,sun50i-h5-pwm
+          - const: allwinner,sun5i-a13-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: pwm@1c20e00 {
+        compatible = "allwinner,sun7i-a20-pwm";
+        reg = <0x01c20e00 0xc>;
+        clocks = <&osc24M>;
+        #pwm-cells = <3>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
deleted file mode 100644
index 2a1affbff45e..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Allwinner sun4i and sun7i SoC PWM controller
-
-Required properties:
-  - compatible: should be one of:
-    - "allwinner,sun4i-a10-pwm"
-    - "allwinner,sun5i-a10s-pwm"
-    - "allwinner,sun5i-a13-pwm"
-    - "allwinner,sun7i-a20-pwm"
-    - "allwinner,sun8i-h3-pwm"
-    - "allwinner,sun50i-a64-pwm", "allwinner,sun5i-a13-pwm"
-    - "allwinner,sun50i-h5-pwm", "allwinner,sun5i-a13-pwm"
-  - reg: physical base address and length of the controller's registers
-  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
-    the cells format.
-  - clocks: From common clock binding, handle to the parent clock.
-
-Example:
-
-	pwm: pwm@1c20e00 {
-		compatible = "allwinner,sun7i-a20-pwm";
-		reg = <0x01c20e00 0xc>;
-		clocks = <&osc24M>;
-		#pwm-cells = <3>;
-	};
-- 
2.21.0

