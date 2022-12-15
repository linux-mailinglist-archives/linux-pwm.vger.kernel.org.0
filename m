Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F164E31F
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Dec 2022 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLOVc1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Dec 2022 16:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLOVcS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Dec 2022 16:32:18 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22CCF1CB37;
        Thu, 15 Dec 2022 13:32:17 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; 
   d="scan'208";a="143493758"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2022 06:32:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.26])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B674040062B3;
        Fri, 16 Dec 2022 06:32:12 +0900 (JST)
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
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/9] dt-bindings: pinctrl: renesas: Add RZ/G2L POEG binding
Date:   Thu, 15 Dec 2022 21:31:58 +0000
Message-Id: <20221215213206.56666-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
References: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4->v5:
 * Added Rb tag from Rob.
v3->v4:
 * Replaced companion->renesas,gpt for the phandle to gpt instance
 * Replaced renesas,id->renesas,poeg-id
 * Removed default from renesas,poeg-id as default for a required
   property doesn't make much sense.
 * Updated the example and required properties with above changes
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
index 000000000000..ab2d456c93e4
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
+  renesas,gpt:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to gpt instance that serves the pwm operation.
+
+  renesas,poeg-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+    description: |
+      POEG group index. Valid values are:
+        <0> : POEG group A
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
+  - renesas,poeg-id
+  - renesas,gpt
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
+        renesas,poeg-id = <3>;
+        renesas,gpt = <&gpt>;
+    };
-- 
2.25.1

