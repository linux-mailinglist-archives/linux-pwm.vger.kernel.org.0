Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0200F49B760
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 16:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbiAYPPH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 10:15:07 -0500
Received: from mail.schwermer.no ([49.12.228.226]:55552 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581761AbiAYPNH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 10:13:07 -0500
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643123561;
        bh=xn4v1imwBzu7dBC5S7YAuueOOjuSA0KRe5PsRFU7bfo=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=MC1giXrhTK+BFxva8JOtg8m3VWaqZFt35OH3EY6v0NSCB/s+tYqmMOz4+3/EYXtdb
         q2t20VGGojdKgeSXVbsdYFHer/NYtXLI6MPahaI3lfRJNAigKIla8CHdyodRp5FLRT
         4p1xdPPsvxbVmkNdpJ+GgJD2Zp0sAF26xhBH+lygiLOMA4Miyr39eHfv90J1lLujBV
         fyWoWfs7VRt1Q001mZ7nBPN9xxMg1XUHJV7sQM3wTNuT5VjdnrAZtAfvzB/6YPQkKd
         44Q30FOonXMDmBlT2YDWiDLqerJFPENtXFpYgv7LTnmkXf5dN/DJK8JXNt+xniyKsf
         JL348lcw/J2AA==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, post@lespocky.de
Subject: [RFC PATCH v2 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Tue, 25 Jan 2022 16:12:25 +0100
Message-Id: <20220125151226.31049-2-sven@svenschwermer.de>
In-Reply-To: <20220125151226.31049-1-sven@svenschwermer.de>
References: <20220125151226.31049-1-sven@svenschwermer.de>
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
 .../bindings/leds/leds-pwm-multicolor.yaml    | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
new file mode 100644
index 000000000000..b82b26f2e140
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -0,0 +1,76 @@
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

