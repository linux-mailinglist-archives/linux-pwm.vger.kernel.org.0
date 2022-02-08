Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD264AE1FA
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Feb 2022 20:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385812AbiBHTMq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Feb 2022 14:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385766AbiBHTMq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 14:12:46 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1633C0612C3;
        Tue,  8 Feb 2022 11:12:44 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644347563;
        bh=pAhVUDR2FbTJNBzkusBnWlExSCWLtCQWgLA7UncdeUg=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=HkT3vyyAJ3ft7qF+IsgG3hBdwZec2ZsJzk6mkI/rzyAwY8FF1cRi20RCcE7f7ushq
         juoAzGN7wVtz4BfLjjz7fx5xhXaF/zC6cosc7ihd31UVoa54JMmj+riiMTHjSTUouS
         yOijuB1w824vBZv/dDXyaN6FuvbiwL8xjlPlyGdnOT2SNkZxqDdCay9fAxRCWttqdq
         UX/P7LdojG3CXnRJfTcfRG+LHMK7XoCWxmn4DeuQtRxSiFeBOI7Y2lhLJYKgvksd+R
         i8R2jbjnW2keyU818f4irgE35xBNSPu59/UYWhsxdnASjBTdEzMzIFyYe62+aknp4U
         n7shAXPfbq/ww==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v6 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Tue,  8 Feb 2022 20:12:35 +0100
Message-Id: <20220208191236.660172-2-sven@svenschwermer.de>
In-Reply-To: <20220208191236.660172-1-sven@svenschwermer.de>
References: <20220208191236.660172-1-sven@svenschwermer.de>
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
    Changes in v6:
    * Fix device tree binding schema
    
    Changes in v5:
    * (no changes)
    
    Changes in v4:
    * (no changes)
    
    Changes in v3:
    * Remove multi-led unit name

 .../bindings/leds/leds-pwm-multicolor.yaml    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
new file mode 100644
index 000000000000..f7ce29c8ae63
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -0,0 +1,69 @@
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
+  multi-led:
+    type: object
+    patternProperties:
+      "^led-[0-9a-z]+$":
+        type: object
+        $ref: common.yaml#
+        properties:
+          pwms:
+            maxItems: 1
+          pwm-names: true
+          color: true
+        required:
+          - pwms
+          - color
+        additionalProperties: false
+required:
+  - compatible
+allOf:
+  - $ref: leds-class-multicolor.yaml#
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
2.35.1

