Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC52A0D8B
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 19:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgJ3ShP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 14:37:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42697 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgJ3ShO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 14:37:14 -0400
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6D742C0002;
        Fri, 30 Oct 2020 18:37:10 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 1/4] dt-bindings: microchip: atmel,at91rm9200-tcb: add atmel,tcb-pwm
Date:   Fri, 30 Oct 2020 19:36:55 +0100
Message-Id: <20201030183658.1007395-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201030183658.1007395-1-alexandre.belloni@bootlin.com>
References: <20201030183658.1007395-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Move the TCB pwm nodes under their parent. This removes the need for the
tc-block property as there is now a child-parent relationship between the
TC channel and the TC block.

Move the documentation to the main file.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v2:
 - rework commit message
 - use enum for the pwm node reg values as suggested by Rob.

 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt | 16 ---------
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 34 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
deleted file mode 100644
index 985fcc65f8c4..000000000000
--- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Atmel TCB PWM controller
-
-Required properties:
-- compatible: should be "atmel,tcb-pwm"
-- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
-  the cells format. The only third cell flag supported by this binding is
-  PWM_POLARITY_INVERTED.
-- tc-block: The Timer Counter block to use as a PWM chip.
-
-Example:
-
-pwm {
-	compatible = "atmel,tcb-pwm";
-	#pwm-cells = <3>;
-	tc-block = <1>;
-};
diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 55fffae05dcf..597d67fba92f 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -59,6 +59,7 @@ patternProperties:
         items:
           - enum:
               - atmel,tcb-timer
+              - atmel,tcb-pwm
               - microchip,tcb-capture
       reg:
         description:
@@ -68,10 +69,35 @@ patternProperties:
 
         minItems: 1
         maxItems: 3
+    required:
+      - compatible
+      - reg
+
+  "^pwm@[0-2]$":
+    description: The timer block channels that are used as PWMs.
+    $ref: ../../pwm/pwm.yaml#
+    type: object
+    properties:
+      compatible:
+        const: atmel,tcb-pwm
+      reg:
+        description:
+          TCB channel to use for this PWM.
+        enum: [ 0, 1, 2 ]
+
+      "#pwm-cells":
+        description:
+          The only third cell flag supported by this binding is
+          PWM_POLARITY_INVERTED.
+        const: 3
 
     required:
       - compatible
       - reg
+      - "#pwm-cells"
+
+    additionalProperties: false
+
 
 allOf:
   - if:
@@ -158,7 +184,13 @@ examples:
                         compatible = "atmel,tcb-timer";
                         reg = <1>;
                 };
-        };
+
+                pwm@2 {
+                        compatible = "atmel,tcb-pwm";
+                        reg = <2>;
+                        #pwm-cells = <3>;
+                };
+         };
     /* TCB0 Capture with QDEC: */
         timer@f800c000 {
                 compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
-- 
2.26.2

