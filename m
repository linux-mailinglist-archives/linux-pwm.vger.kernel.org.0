Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AAE521E55
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbiEJP1I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbiEJP0B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 11:26:01 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D474BE6B49;
        Tue, 10 May 2022 08:11:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,214,1647270000"; 
   d="scan'208";a="119261216"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 May 2022 00:11:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.112])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3B007400A0E7;
        Wed, 11 May 2022 00:11:19 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Date:   Tue, 10 May 2022 16:11:05 +0100
Message-Id: <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add device tree bindings for the RZ/G2L Port Output Enable for GPT (POEG).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../soc/renesas/renesas,rzg2l-poeg.yaml       | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
new file mode 100644
index 000000000000..5737dbf3fa45
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/renesas/renesas,rzg2l-poeg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description:
+  The output pins of the general PWM timer (GPT) can be disabled by using
+  the port output enabling function for the GPT (POEG). Specifically,
+  either of the following ways can be used.
+  * Input level detection of the GTETRGA to GTETRGD pins.
+  * Output-disable request from the GPT.
+  * Register settings.
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - power-domains
+  - resets
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
+        reg = <0x10049400 0x4>;
+        interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A07G044_POEG_D_CLKP>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_POEG_D_RST>;
+    };
-- 
2.25.1

