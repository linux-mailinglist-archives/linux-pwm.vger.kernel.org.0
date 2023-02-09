Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53769095D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Feb 2023 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBIM5L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Feb 2023 07:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBIM5K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Feb 2023 07:57:10 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E00072E826;
        Thu,  9 Feb 2023 04:57:07 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,283,1669042800"; 
   d="scan'208";a="149037941"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Feb 2023 21:57:07 +0900
Received: from localhost.localdomain (unknown [10.226.92.132])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4C03A43191AC;
        Thu,  9 Feb 2023 21:57:04 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: pwm: Add RZ/V2M PWM binding
Date:   Thu,  9 Feb 2023 12:56:53 +0000
Message-Id: <20230209125656.191905-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209125656.191905-1-biju.das.jz@bp.renesas.com>
References: <20230209125656.191905-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add device tree bindings for the RZ/V2{M, MA} PWM Timer (PWM).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3->v4:
 * No change
v2->v3:
 * Added Rb tag from Geert.
v1->v2:
 * Added Rb tag from Krzysztof and the keep the Rb tag as the below changes
   are trivial
 * Updated the description for APB clock
 * Added resets required property
 * Updated the example with resets property
---
 .../bindings/pwm/renesas,rzv2m-pwm.yaml       | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
new file mode 100644
index 000000000000..ddeed7550923
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rzv2m-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2{M, MA} PWM Timer (PWM)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  The RZ/V2{M, MA} PWM Timer (PWM) composed of 16 channels. It supports the
+  following functions
+  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
+  * The frequency division ratio for internal counter operation is selectable
+    as PWM_CLK divided by 1, 16, 256, or 2048.
+  * The period as well as the duty cycle is adjustable.
+  * The low-level and high-level order of the PWM signals can be inverted.
+  * The duty cycle of the PWM signal is selectable in the range from 0 to 100%.
+  * The minimum resolution is 20.83 ns.
+  * Three interrupt sources: Rising and falling edges of the PWM signal and
+    clearing of the counter
+  * Counter operation and the bus interface are asynchronous and both can
+    operate independently of the magnitude relationship of the respective
+    clock periods.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a09g011-pwm  # RZ/V2M
+          - renesas,r9a09g055-pwm  # RZ/V2MA
+      - const: renesas,rzv2m-pwm
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB clock
+      - description: PWM clock
+
+  clock-names:
+    items:
+      - const: apb
+      - const: pwm
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
+  - clock-names
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
+    #include <dt-bindings/clock/r9a09g011-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pwm8: pwm@a4010400 {
+        compatible = "renesas,r9a09g011-pwm", "renesas,rzv2m-pwm";
+        reg = <0xa4010400 0x80>;
+        interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+                 <&cpg CPG_MOD R9A09G011_PWM8_CLK>;
+        clock-names = "apb", "pwm";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+        #pwm-cells = <2>;
+    };
-- 
2.25.1

