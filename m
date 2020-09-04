Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1306325DD54
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgIDPZX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 11:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbgIDPZP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 11:25:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDCF20829;
        Fri,  4 Sep 2020 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233114;
        bh=98AU22xTYMCZ0QAZTXK9ChSrXEOj0TuIT22qgKEeDKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjl+iSmQKDcuFKuJWoCO2KfDCopCbpvL/j6GNIQ56/n5nI6trH4Mvd5TovdpW1bVv
         nH4RMK4IfSteEnnKQ6qlPsMbzkwxl2DIdMLXTOeS/eIHdJvAIfUqERAA8KE3TsJO7i
         qUuqc3539Tq4VNzRPHXzyvE3JsJTmxuaTymnXfpg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 12/14] dt-bindings: mtd: gpmi-nand: Fix matching of clocks on different SoCs
Date:   Fri,  4 Sep 2020 17:24:02 +0200
Message-Id: <20200904152404.20636-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Driver requires different amount of clocks for different SoCs.  Describe
these requirements properly to fix dtbs_check warnings like:

    arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Do not require order of clocks (use pattern).
---
 .../devicetree/bindings/mtd/gpmi-nand.yaml    | 76 +++++++++++++++----
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 28ff8c581837..e08e0a50929e 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -9,9 +9,6 @@ title: Freescale General-Purpose Media Interface (GPMI) binding
 maintainers:
   - Han Xu <han.xu@nxp.com>
 
-allOf:
-  - $ref: "nand-controller.yaml"
-
 description: |
   The GPMI nand controller provides an interface to control the NAND
   flash chips. The device tree may optionally contain sub-nodes
@@ -58,22 +55,10 @@ properties:
   clocks:
     minItems: 1
     maxItems: 5
-    items:
-      - description: SoC gpmi io clock
-      - description: SoC gpmi apb clock
-      - description: SoC gpmi bch clock
-      - description: SoC gpmi bch apb clock
-      - description: SoC per1 bch clock
 
   clock-names:
     minItems: 1
     maxItems: 5
-    items:
-      - const: gpmi_io
-      - const: gpmi_apb
-      - const: gpmi_bch
-      - const: gpmi_bch_apb
-      - const: per1_bch
 
   fsl,use-minimum-ecc:
     type: boolean
@@ -107,6 +92,67 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: "nand-controller.yaml"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx23-gpmi-nand
+              - fsl,imx28-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+        clock-names:
+          items:
+            - const: gpmi_io
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6q-gpmi-nand
+              - fsl,imx6sx-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+            - description: SoC gpmi apb clock
+            - description: SoC gpmi bch clock
+            - description: SoC gpmi bch apb clock
+            - description: SoC per1 bch clock
+        clock-names:
+          items:
+            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
+            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
+            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
+            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
+            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx7d-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+            - description: SoC gpmi bch apb clock
+        clock-names:
+          minItems: 2
+          maxItems: 2
+          items:
+            - pattern: "^gpmi_(io|bch_apb)$"
+            - pattern: "^gpmi_(io|bch_apb)$"
+
 examples:
   - |
     nand-controller@8000c000 {
-- 
2.17.1

