Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE9515B27
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Apr 2022 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiD3ICu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Apr 2022 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiD3ICt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Apr 2022 04:02:49 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B30391571;
        Sat, 30 Apr 2022 00:59:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,187,1647270000"; 
   d="scan'208";a="118453218"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Apr 2022 16:59:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.1])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 159AA40065B7;
        Sat, 30 Apr 2022 16:59:22 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [RFC 1/5] dt-bindings: pwm: Add RZ/G2L GPT binding
Date:   Sat, 30 Apr 2022 08:59:11 +0100
Message-Id: <20220430075915.5036-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220430075915.5036-1-biju.das.jz@bp.renesas.com>
References: <20220430075915.5036-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add device tree bindings for the RZ/G2L General PWM Timer (GPT).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
new file mode 100644
index 000000000000..0e44c0fbe04a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rzg2l-gpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L General PWM Timer (GPT)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
+          - renesas,r9a07g054-gpt  # RZ/V2L
+      - const: renesas,rzg2l-gpt
+
+  reg:
+    # base address and length of the registers block for the PWM.
+    maxItems: 1
+
+  '#pwm-cells':
+    # should be 2. See pwm.yaml in this directory for a description of
+    # the cells format.
+    const: 2
+
+  interrupts:
+    items:
+      - description: GTCCRA input capture/compare match
+      - description: GTCCRB input capture/compare
+      - description: GTCCRC compare match
+      - description: GTCCRD compare match
+      - description: GTCCRE compare match
+      - description: GTCCRF compare match
+      - description: GTADTRA compare match
+      - description: GTADTRB compare match
+      - description: GTCNT overflow/GTPR compare match
+      - description: GTCNT underflow
+
+  interrupt-names:
+    items:
+      - const: ccmpa
+      - const: ccmpb
+      - const: cmpc
+      - const: cmpd
+      - const: cmpe
+      - const: cmpf
+      - const: adtrga
+      - const: adtrgb
+      - const: ovf
+      - const: unf
+
+  clocks:
+    # clock phandle and specifier pair.
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+  - resets
+
+allOf:
+  - $ref: pwm.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpt4: pwm@10048400 {
+        compatible = "renesas,r9a07g044-gpt", "renesas,rzg2l-gpt";
+        reg = <0x10048400 0xa4>;
+        interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 272 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 273 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 274 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 275 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 276 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 278 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "ccmpa", "ccmpb", "cmpc", "cmpd",
+                          "cmpe", "cmpf", "adtrga", "adtrgb",
+                          "ovf", "unf";
+        clocks = <&cpg CPG_MOD R9A07G044_GPT_PCLK>;
+        power-domains = <&cpg>;
+        resets = <&cpg 523 R9A07G044_GPT_RST_C>;
+        #pwm-cells = <2>;
+    };
-- 
2.25.1

