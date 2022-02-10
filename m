Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2A4B07A8
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Feb 2022 08:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiBJH7N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Feb 2022 02:59:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiBJH7M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Feb 2022 02:59:12 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D321089;
        Wed,  9 Feb 2022 23:59:14 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644479952;
        bh=J8F3m3MfMBL87hYkNA5n8avSHQNP2ERH7sQGKRw9gWw=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=sfqiK9Zyb7iigZ7KU6OqBJEGc2zvNs06Es26cbntoJQwa+JDcOh+Rp6IPtbQfoAEX
         rPpdzYmd89iGIn1/KmakDZcUf66EMixSr1tg5jGLSDoRFOVHQ2hv42wr+A1nK7l6cz
         OnsR/zbSsS42hynTnS5J1yA5ahBOFmJmo/GSu5kOIdmPvUmLvbsmZ9NqHiLIGmVU8E
         rfF1ra7fJ7ntnstBwmCAisMeu1Lr5IIhYCx4WzXa/pDN5fh2NIOyVVT2Eyt23C03Pw
         2Ih00McCl9jPqO+RYsUFBTA5V98t87gtOsItKlYZ8Xn0opGtwg9dYeRUHT6CrqmP57
         cH+cSJtSLi69g==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v7 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Thu, 10 Feb 2022 08:59:07 +0100
Message-Id: <20220210075908.120496-2-sven@svenschwermer.de>
In-Reply-To: <20220210075908.120496-1-sven@svenschwermer.de>
References: <20220210075908.120496-1-sven@svenschwermer.de>
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
---

Notes:
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

