Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560695F55E4
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Oct 2022 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJENzg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Oct 2022 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJENzc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Oct 2022 09:55:32 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56546527E;
        Wed,  5 Oct 2022 06:55:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.95,159,1661785200"; 
   d="scan'208";a="135457108"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Oct 2022 22:55:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.36])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D6F0D4006190;
        Wed,  5 Oct 2022 22:55:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Date:   Wed,  5 Oct 2022 14:55:16 +0100
Message-Id: <20221005135518.876913-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005135518.876913-1-biju.das.jz@bp.renesas.com>
References: <20221005135518.876913-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
channels and one 32-bit timer channel. It supports the following
functions
 - Counter
 - Timer
 - PWM

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
RFC->v1:
 * Modelled counter and pwm as a single device that handles
   multiple channels.
 * Moved counter and pwm bindings to respective subsystems
 * Dropped 'bindings' from MFD binding title.
 * Updated the example
 * Changed the compatible names.
---
 .../counter/renesas,rz-mtu3-counter.yaml      |  30 ++
 .../bindings/mfd/renesas,rz-mtu3.yaml         | 290 ++++++++++++++++++
 .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
 3 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml

diff --git a/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml b/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml
new file mode 100644
index 000000000000..c8b86ef254b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/renesas,rz-mtu3-counter.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/renesas,rz-mtu3-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L MTU3a Counter Module
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  This module is part of the rz-mtu3 multi-function device. For more
+  details see ../mfd/renesas,rz-mtu3.yaml.
+
+  There are two phase counting modes: 16-bit phase counting mode in which MTU1
+  and MTU2 operate independently, and cascade connection 32-bit phase counting
+  mode in which MTU1 and MTU2 are cascaded.
+
+  In phase counting mode, the phase difference between two external input clocks
+  is detected and the corresponding TCNT is incremented or decremented.
+
+properties:
+  compatible:
+    const: renesas,rz-mtu3-counter
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
new file mode 100644
index 000000000000..0413d22704c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
@@ -0,0 +1,290 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/renesas,rz-mtu3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  This hardware block pconsisting of eight 16-bit timer channels and one
+  32- bit timer channel. It supports the following specifications:
+    - Pulse input/output: 28 lines max.
+    - Pulse input 3 lines
+    - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clocks
+      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combination
+      (when LWA = 1))
+    - Operating frequency Up to 100 MHz
+    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
+        - Waveform output on compare match
+        - Input capture function (noise filter setting available)
+        - Counter-clearing operation
+        - Simultaneous writing to multiple timer counters (TCNT)
+          (excluding MTU8).
+        - Simultaneous clearing on compare match or input capture
+          (excluding MTU8).
+        - Simultaneous input and output to registers in synchronization with
+          counter operations           (excluding MTU8).
+        - Up to 12-phase PWM output in combination with synchronous operation
+          (excluding MTU8)
+    - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
+        - Buffer operation specifiable
+    - [MTU1, MTU2]
+        - Phase counting mode can be specified independently
+        - 32-bit phase counting mode can be specified for interlocked operation
+          of MTU1 and MTU2 (when TMDR3.LWA = 1)
+        - Cascade connection operation available
+    - [MTU3, MTU4, MTU6, and MTU7]
+        - Through interlocked operation of MTU3/4 and MTU6/7, the positive and
+          negative signals in six phases (12 phases in total) can be output in
+          complementary PWM and reset-synchronized PWM operation.
+        - In complementary PWM mode, values can be transferred from buffer
+          registers to temporary registers at crests and troughs of the timer-
+          counter values or when the buffer registers (TGRD registers in MTU4
+          and MTU7) are written to.
+        - Double-buffering selectable in complementary PWM mode.
+    - [MTU3 and MTU4]
+        - Through interlocking with MTU0, a mode for driving AC synchronous
+          motors (brushless DC motors) by using complementary PWM output and
+          reset-synchronized PWM output is settable and allows the selection
+          of two types of waveform output (chopping or level).
+    - [MTU5]
+        - Capable of operation as a dead-time compensation counter.
+    - [MTU0/MTU5, MTU1, MTU2, and MTU8]
+        - 32-bit phase counting mode specifiable by combining MTU1 and MTU2 and
+          through interlocked operation with MTU0/MTU5 and MTU8.
+    - Interrupt-skipping function
+        - In complementary PWM mode, interrupts on crests and troughs of counter
+          values and triggers to start conversion by the A/D converter can be
+          skipped.
+    - Interrupt sources: 43 sources.
+    - Buffer operation:
+        - Automatic transfer of register data (transfer from the buffer
+          register to the timer register).
+    - Trigger generation
+        - A/D converter start triggers can be generated
+        - A/D converter start request delaying function enables A/D converter
+          to be started with any desired timing and to be synchronized with
+          PWM output.
+    - Low power consumption function
+        - The MTU3a can be placed in the module-stop state.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
+          - renesas,r9a07g054-mtu3  # RZ/V2L
+      - const: renesas,rz-mtu3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: MTU0.TGRA input capture/compare match
+      - description: MTU0.TGRB input capture/compare match
+      - description: MTU0.TGRC input capture/compare match
+      - description: MTU0.TGRD input capture/compare match
+      - description: MTU0.TCNT overflow
+      - description: MTU0.TGRE compare match
+      - description: MTU0.TGRF compare match
+      - description: MTU1.TGRA input capture/compare match
+      - description: MTU1.TGRB input capture/compare match
+      - description: MTU1.TCNT overflow
+      - description: MTU1.TCNT underflow
+      - description: MTU2.TGRA input capture/compare match
+      - description: MTU2.TGRB input capture/compare match
+      - description: MTU2.TCNT overflow
+      - description: MTU2.TCNT underflow
+      - description: MTU3.TGRA input capture/compare match
+      - description: MTU3.TGRB input capture/compare match
+      - description: MTU3.TGRC input capture/compare match
+      - description: MTU3.TGRD input capture/compare match
+      - description: MTU3.TCNT overflow
+      - description: MTU4.TGRA input capture/compare match
+      - description: MTU4.TGRB input capture/compare match
+      - description: MTU4.TGRC input capture/compare match
+      - description: MTU4.TGRD input capture/compare match
+      - description: MTU4.TCNT overflow/underflow
+      - description: MTU5.TGRU input capture/compare match
+      - description: MTU5.TGRV input capture/compare match
+      - description: MTU5.TGRW input capture/compare match
+      - description: MTU6.TGRA input capture/compare match
+      - description: MTU6.TGRB input capture/compare match
+      - description: MTU6.TGRC input capture/compare match
+      - description: MTU6.TGRD input capture/compare match
+      - description: MTU6.TCNT overflow
+      - description: MTU7.TGRA input capture/compare match
+      - description: MTU7.TGRB input capture/compare match
+      - description: MTU7.TGRC input capture/compare match
+      - description: MTU7.TGRD input capture/compare match
+      - description: MTU7.TCNT overflow/underflow
+      - description: MTU8.TGRA input capture/compare match
+      - description: MTU8.TGRB input capture/compare match
+      - description: MTU8.TGRC input capture/compare match
+      - description: MTU8.TGRD input capture/compare match
+      - description: MTU8.TCNT overflow
+      - description: MTU8.TCNT underflow
+
+  interrupt-names:
+    items:
+      - const: tgia0
+      - const: tgib0
+      - const: tgic0
+      - const: tgid0
+      - const: tgiv0
+      - const: tgie0
+      - const: tgif0
+      - const: tgia1
+      - const: tgib1
+      - const: tgiv1
+      - const: tgiu1
+      - const: tgia2
+      - const: tgib2
+      - const: tgiv2
+      - const: tgiu2
+      - const: tgia3
+      - const: tgib3
+      - const: tgic3
+      - const: tgid3
+      - const: tgiv3
+      - const: tgia4
+      - const: tgib4
+      - const: tgic4
+      - const: tgid4
+      - const: tgiv4
+      - const: tgiu5
+      - const: tgiv5
+      - const: tgiw5
+      - const: tgia6
+      - const: tgib6
+      - const: tgic6
+      - const: tgid6
+      - const: tgiv6
+      - const: tgia7
+      - const: tgib7
+      - const: tgic7
+      - const: tgid7
+      - const: tgiv7
+      - const: tgia8
+      - const: tgib8
+      - const: tgic8
+      - const: tgid8
+      - const: tgiv8
+      - const: tgiu8
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
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "counter":
+    $ref: ../counter/renesas,rz-mtu3-counter.yaml
+
+  "pwm":
+    $ref: ../pwm/renesas,rz-mtu3-pwm.yaml
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mtu3: timer@10001200 {
+      compatible = "renesas,r9a07g044-mtu3", "renesas,rz-mtu3";
+      reg = <0x10001200 0xb00>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 181 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 185 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 186 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 192 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 201 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 202 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
+      interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0", "tgiv0", "tgie0",
+                        "tgif0",
+                        "tgia1", "tgib1", "tgiv1", "tgiu1",
+                        "tgia2", "tgib2", "tgiv2", "tgiu2",
+                        "tgia3", "tgib3", "tgic3", "tgid3", "tgiv3",
+                        "tgia4", "tgib4", "tgic4", "tgid4", "tgiv4",
+                        "tgiu5", "tgiv5", "tgiw5",
+                        "tgia6", "tgib6", "tgic6", "tgid6", "tgiv6",
+                        "tgia7", "tgib7", "tgic7", "tgid7", "tgiv7",
+                        "tgia8", "tgib8", "tgic8", "tgid8", "tgiv8", "tgiu8";
+      clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
+      power-domains = <&cpg>;
+      resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
+
+      counter {
+        compatible = "renesas,rz-mtu3-counter";
+      };
+
+      pwm {
+        compatible = "renesas,rz-mtu3-pwm";
+        #pwm-cells = <2>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
new file mode 100644
index 000000000000..29d7d0fdf7f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rz-mtu3-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM driver for the RZ/G2L multi-function timer pulse unit 3 (MTU3a)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  This module is part of the RZ/G2L MTU3a multi-function device. For more
+  details see ../mfd/renesas,rz-mtu3.yaml.
+
+  The module supports PWM mode{1,2}, Reset-synchronized PWM mode and
+  complementary PWM mode{1,2,3}.
+
+  In complementary PWM mode, six positive-phase and six negative-phase PWM
+  waveforms (12 phases in total) with dead time can be output by
+  combining MTU{3,4} and MTU{6,7}.
+
+  The pwm channels corresponding to each hardware channels.
+  0  - MTU0.MTIOC0A PWM mode 1
+  1  - MTU0.MTIOC0C PWM mode 1
+  2  - MTU1.MTIOC1A PWM mode 1
+  3  - MTU2.MTIOC2A PWM mode 1
+  4  - MTU3.MTIOC3A PWM mode 1
+  5  - MTU3.MTIOC3C PWM mode 1
+  6  - MTU4.MTIOC4A PWM mode 1
+  7  - MTU4.MTIOC4C PWM mode 1
+  8  - MTU6.MTIOC6A PWM mode 1
+  9  - MTU6.MTIOC6C PWM mode 1
+  10 - MTU7.MTIOC7A PWM mode 1
+  11 - MTU7.MTIOC7C PWM mode 1
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: renesas,rz-mtu3-pwm
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.25.1

