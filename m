Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A7378EDB
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhEJNcG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 09:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbhEJM02 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 08:26:28 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E846C05BD08
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 05:18:44 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f937:4595:45ff:bcbf])
        by baptiste.telenet-ops.be with bizsmtp
        id 30Je250054jQ7kl010JexP; Mon, 10 May 2021 14:18:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4rt-004QlE-GY; Mon, 10 May 2021 14:18:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4rt-00HQPt-0h; Mon, 10 May 2021 14:18:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: timer: renesas,tpu: Convert to json-schema
Date:   Mon, 10 May 2021 14:18:35 +0200
Message-Id: <1c33e62c3a74979c3ca9580176e6cf89384caea9.1620648868.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620648868.git.geert+renesas@glider.be>
References: <cover.1620648868.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the Renesas H8/300 Timer Pulse Unit Device Tree binding
documentation to json-schema.

Correct clock-names, as "peripheral_clk" is the name of the supplier,
and all users use "fck".

Note that there are two different bindings for the TPU, both using
"renesas,tpu": this one for using the TPU as a clock source (used on
H8/300), and a second use for using the TPU as a PWM controller (used on
ARM).  To avoid conflicts, both bindings are marked with the appropriate
"select" logic, to check for the absence respectively presence of the
"#pwm-cells" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2:
  - Drop unneeded "'#pwm-cells': true" from "select" section in
    renesas,tpu-pwm.yaml,
  - Add Reviewed-by.

I have listed Sato-san as the maintainer, as he wrote the original
driver and bindings.
Sato-san: Please scream if this is inappropriate ;-)
---
 .../bindings/pwm/renesas,tpu-pwm.yaml         |  9 +++
 .../devicetree/bindings/timer/renesas,tpu.txt | 21 -------
 .../bindings/timer/renesas,tpu.yaml           | 56 +++++++++++++++++++
 3 files changed, 65 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 7c99e42ad780c2cd..81ccb2110162c3eb 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -9,6 +9,15 @@ title: Renesas R-Car Timer Pulse Unit PWM Controller
 maintainers:
   - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
 
+select:
+  properties:
+    compatible:
+      contains:
+        const: renesas,tpu
+  required:
+    - compatible
+    - '#pwm-cells'
+
 properties:
   compatible:
     items:
diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.txt b/Documentation/devicetree/bindings/timer/renesas,tpu.txt
deleted file mode 100644
index 1d46f9de4feb8a84..0000000000000000
--- a/Documentation/devicetree/bindings/timer/renesas,tpu.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Renesas H8/300 Timer Pulse Unit
-
-The TPU is a 16bit timer/counter with configurable clock inputs and
-programmable compare match.
-This implementation support only cascade mode.
-
-Required Properties:
-
-  - compatible: must contain "renesas,tpu"
-  - reg: base address and length of the registers block in 2 channel.
-  - clocks: a list of phandle, one for each entry in clock-names.
-  - clock-names: must contain "peripheral_clk" for the functional clock.
-
-
-Example:
-	tpu: tpu@ffffe0 {
-		compatible = "renesas,tpu";
-		reg = <0xffffe0 16>, <0xfffff0 12>;
-		clocks = <&pclk>;
-		clock-names = "peripheral_clk";
-	};
diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
new file mode 100644
index 0000000000000000..01554dff23d8a954
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/renesas,tpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas H8/300 Timer Pulse Unit
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description:
+  The TPU is a 16bit timer/counter with configurable clock inputs and
+  programmable compare match.
+  This implementation supports only cascade mode.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: renesas,tpu
+    '#pwm-cells': false
+  required:
+    - compatible
+
+properties:
+  compatible:
+    const: renesas,tpu
+
+  reg:
+    items:
+      - description: First channel
+      - description: Second channel
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    tpu: tpu@ffffe0 {
+            compatible = "renesas,tpu";
+            reg = <0xffffe0 16>, <0xfffff0 12>;
+            clocks = <&pclk>;
+            clock-names = "fck";
+    };
-- 
2.25.1

