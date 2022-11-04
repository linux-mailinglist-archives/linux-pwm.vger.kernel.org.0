Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4549E619B52
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Nov 2022 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiKDPTv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Nov 2022 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiKDPTr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Nov 2022 11:19:47 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91075656F;
        Fri,  4 Nov 2022 08:19:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.96,137,1665414000"; 
   d="scan'208";a="139000238"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2022 00:19:46 +0900
Received: from localhost.localdomain (unknown [10.226.93.164])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 47B184006A8E;
        Sat,  5 Nov 2022 00:19:42 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L POEG binding
Date:   Fri,  4 Nov 2022 15:19:34 +0000
Message-Id: <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221104151935.1783791-1-biju.das.jz@bp.renesas.com>
References: <20221104151935.1783791-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add device tree bindings for the RZ/G2L Port Output Enable for GPT (POEG).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Removed Rb tag from Rob as there are some changes introduced.
 * Added companion property, so that poeg can link with gpt device
 * Documented renesas,id, as identifier for POEGG{A,B,C,D}.
 * Updated the example.
v1->v2:
 * Updated the description.
REF->v1:
 * Modelled as pincontrol as most of its configuration is intended to be
   static.
 * Updated reg size in example.
---
 .../bindings/pinctrl/renesas,rzg2l-poeg.yaml  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
new file mode 100644
index 000000000000..8adf01682de5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-poeg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  The output pins(GTIOCxA and GTIOCxB) of the general PWM timer (GPT) can be
+  disabled by using the port output enabling function for the GPT (POEG).
+  Specifically, either of the following ways can be used.
+  * Input level detection of the GTETRGA to GTETRGD pins.
+  * Output-disable request from the GPT.
+  * SSF bit setting(ie, by setting POEGGn.SSF to 1)
+
+  The state of the GTIOCxA and the GTIOCxB pins when the output is disabled,
+  are controlled by the GPT module.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-poeg  # RZ/G2{L,LC}
+          - renesas,r9a07g054-poeg  # RZ/V2L
+      - const: renesas,rzg2l-poeg
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  companion:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of a companion.
+
+  renesas,id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+    description: |
+      POEG group index. Valid values are:
+        <0> : POEG group A (default)
+        <1> : POEG group B
+        <2> : POEG group C
+        <3> : POEG group D
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - power-domains
+  - resets
+  - renesas,id
+  - companion
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    poeggd: poeg@10049400 {
+        compatible = "renesas,r9a07g044-poeg", "renesas,rzg2l-poeg";
+        reg = <0x10049400 0x400>;
+        interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A07G044_POEG_D_CLKP>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_POEG_D_RST>;
+        renesas,id = <3>;
+        companion = <&gpt>;
+    };
-- 
2.25.1

