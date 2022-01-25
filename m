Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9906649B090
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574312AbiAYJiv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 04:38:51 -0500
Received: from mail.schwermer.no ([49.12.228.226]:54040 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573874AbiAYJel (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 04:34:41 -0500
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643102593;
        bh=lzXvkmM5klQyazDKfd5oiSRvvKpYE6wa/9zpt4EmyIs=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=kylaB1OVjLLpk6x8rW069cVa4uvEMKPHcN5lRnWEqBEchIxj62132pvpCn7AWBot4
         R/24L9FOzd5l0ZqjuGA0HvYHZDyDdxWJINMVLF4myDBEA930CfQCVPzah9Umx5R/SS
         kl2fy42TzjxQ6qNtWuRPfcihdlhIK3LG/iOUY0VmwHH71GkJX4oKYPUJ5hhCGpJNoL
         9ZlAFU3l6lQ/+FvrXeemREABNVYpscxai7SLiojj1A4GRjYclDceceAG/MmjlHIgr5
         HOV5hhOrkCCJRe44BcpqNBkNbxhBhaLKOIi+hK1/bOf15rfJqVp6NHEPx1qYYaSjEY
         1jBh/FWi9lr0Q==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Subject: [RFC PATCH 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Tue, 25 Jan 2022 10:22:38 +0100
Message-Id: <20220125092239.2006333-2-sven@svenschwermer.de>
In-Reply-To: <20220125092239.2006333-1-sven@svenschwermer.de>
References: <20220125092239.2006333-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

This allows to group multiple PWM-connected monochrome LEDs into
multicolor LEDs, e.g. RGB LEDs.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---
 .../bindings/leds/leds-pwm-multicolor.yaml    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
new file mode 100644
index 000000000000..8552a5498bdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-pwm-multicolor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Multi-color LEDs connected to PWM
+
+maintainers:
+  - Sven Schwermer <sven.schwermer@disruptive-technologies.com>
+
+description: |
+  This driver combines several monochrome PWM LEDs into one multi-color
+  LED using the multicolor LED class.
+
+properties:
+  compatible: pwm-leds-multicolor
+
+patternProperties:
+  '^multi-led@[0-9a-f]$':
+    type: object
+    allOf:
+      - $ref: leds-class-multicolor.yaml#
+
+    patternProperties:
+      "^led-[0-9a-z]+$":
+        type: object
+        properties:
+          pwms:
+            maxItems: 1
+
+          pwm-names: true
+
+          color:
+            $ref: common.yaml#/properties/color
+
+required:
+  - compatible
+  - pwms
+  - color
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    rgb-led {
+        compatible = "pwm-leds-multicolor";
+
+        multi-led@0 {
+          color = <LED_COLOR_ID_RGB>;
+          function = LED_FUNCTION_INDICATOR;
+          max-brightness = <65535>;
+
+          led-red {
+              pwms = <&pwm1 0 1000000>;
+              color = <LED_COLOR_ID_RED>;
+          };
+
+          led-green {
+              pwms = <&pwm2 0 1000000>;
+              color = <LED_COLOR_ID_GREEN>;
+          };
+
+          led-blue {
+              pwms = <&pwm3 0 1000000>;
+              color = <LED_COLOR_ID_BLUE>;
+          };
+        };
+    };
+
+...
-- 
2.35.0

