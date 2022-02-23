Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27624C1C7C
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Feb 2022 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiBWTqq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Feb 2022 14:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiBWTqp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Feb 2022 14:46:45 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC414B1F8;
        Wed, 23 Feb 2022 11:46:16 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1645645574;
        bh=P0tMMt9R/eXzGbDcuMZHOpkIK7L6pAAugPc6ndoWwF8=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=vFj5T2M8glxPNt1PboqqsaS9bbpbNgLlOOGayRiC+MMq3AiV9OQnYFZAlomlTwwFl
         gACAaL3r/rIxdl9ypFLbZd2KODHrGjYITjpzQI+z39ZqdhYlFxDHGIFblV6qrfS112
         FsfE/45RhJfjY6oU+771DaIwwgb0vsJrKF8kSDRAcKKcLFa1gdDw3XS4q0TJltuNll
         e4t9fu6FL4tKiZRZvSKBuXMEuA5mzF9rarFm7rn+WpqUG6YG32VVsgxX8xUH0HNInh
         U7ZmVMQQJBwMmm6vN0s78DyOB/ASpzo0rb3kdwBs9BRFykXrVG59YH0kxhYB6mZ0Ud
         tvu7fSvbT+j3g==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v8 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Wed, 23 Feb 2022 20:45:40 +0100
Message-Id: <20220223194541.826572-3-sven@svenschwermer.de>
In-Reply-To: <20220223194541.826572-1-sven@svenschwermer.de>
References: <20220223194541.826572-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

This allows to group multiple PWM-connected monochrome LEDs into
multicolor LEDs, e.g. RGB LEDs.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v8:
    * (no changes)
    
    Changes in v7:
    * Added newlines
    * Reorder slightly
    * Rename top-level node in example
    
    Changes in v6:
    * Fix device tree binding schema
    
    Changes in v5:
    * (no changes)
    
    Changes in v4:
    * (no changes)
    
    Changes in v3:
    * Remove multi-led unit name

 .../bindings/leds/leds-pwm-multicolor.yaml    | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
new file mode 100644
index 000000000000..6625a528f727
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -0,0 +1,79 @@
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
+  compatible:
+    const: pwm-leds-multicolor
+
+  multi-led:
+    type: object
+
+    patternProperties:
+      "^led-[0-9a-z]+$":
+        type: object
+        $ref: common.yaml#
+
+        additionalProperties: false
+
+        properties:
+          pwms:
+            maxItems: 1
+
+          pwm-names: true
+
+          color: true
+
+        required:
+          - pwms
+          - color
+
+required:
+  - compatible
+
+allOf:
+  - $ref: leds-class-multicolor.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+        compatible = "pwm-leds-multicolor";
+
+        multi-led {
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
2.35.1

