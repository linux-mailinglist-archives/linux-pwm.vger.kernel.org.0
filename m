Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F347A49C7EB
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 11:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiAZKtB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 05:49:01 -0500
Received: from mail.schwermer.no ([49.12.228.226]:59198 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiAZKtA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jan 2022 05:49:00 -0500
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643194132;
        bh=NoDUEgEmfpw41FaGqwKbbio8hiZgl4yOqNJ8C7uWAPc=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=o+wH8Cpr5nfA5pp+yueg6brGS04PDqot/S/C05VRQOYu0vGUG2oVHmnaO55QPtFXY
         ZJB9m6PGrmJW935QGg2Brf85NYiPnvDrxgB69D5wYvCw1Mj0QsXpFLk4BBAYNnLdu8
         bkZ3Fp3qyfSwqSGbDMKc5DrNH6K+UP9sFWqEAiIsEvX9w6sHCBPKWX6uF0vhdQnZ6F
         doPKk3GdWAFft/5vWMv5kt1wN+NqZQnHbdOGtwkuGx/zNkKAO+eAb0rLz9MuHijd+v
         YvPuRm5Ps0wp3njyOFgPJ9JB4Iz21JGqONHlHuaGu9DUQh1KwBnDozZY2nIMjUESq9
         lS1dd0fthFzsA==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
Subject: [PATCH v3 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Wed, 26 Jan 2022 11:48:43 +0100
Message-Id: <20220126104844.246068-2-sven@svenschwermer.de>
In-Reply-To: <20220126104844.246068-1-sven@svenschwermer.de>
References: <20220126104844.246068-1-sven@svenschwermer.de>
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

Notes:
    Changes in v3:
    * Remove multi-led unit name

 .../bindings/leds/leds-pwm-multicolor.yaml    | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
new file mode 100644
index 000000000000..5a7ed5e1bb9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -0,0 +1,75 @@
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
+        required:
+          - pwms
+          - color
+
+required:
+  - compatible
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
2.35.0

