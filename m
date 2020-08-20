Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0EF24C811
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHTW4C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 18:56:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:42711 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTW4A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2020 18:56:00 -0400
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0469A100003;
        Thu, 20 Aug 2020 22:55:55 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/4] dt-bindings: microchip: atmel,at91rm9200-tcb: add atmel,tcb-pwm
Date:   Fri, 21 Aug 2020 00:55:43 +0200
Message-Id: <20200820225546.2246517-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
References: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Move the TCB pwm nodes under their parent and move its documentation to the
main file.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Cc: Rob Herring <robh+dt@kernel.org>

 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt | 16 ----------
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 31 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 17 deletions(-)
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
index 55fffae05dcf..a51adfdb58f6 100644
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
@@ -68,11 +69,33 @@ patternProperties:
 
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
+
+        maxItems: 1
+      "#pwm-cells":
+        description:
+          The only third cell flag supported by this binding is
+          PWM_POLARITY_INVERTED.
+        const: 3
 
     required:
       - compatible
       - reg
 
+
 allOf:
   - if:
       properties:
@@ -158,7 +181,13 @@ examples:
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

