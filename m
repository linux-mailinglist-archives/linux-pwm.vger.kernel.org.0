Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C4DF283
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 18:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJUQLA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 12:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfJUQK7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Oct 2019 12:10:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C85F20B7C;
        Mon, 21 Oct 2019 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571673743;
        bh=9vUKs8pCzKFuQ7qoUJr6IKkD/Ix0T+CpovzK7sscdoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnuG4tgpME3kPNjXMpUARMsvb9tqSSpIBym0ehdPKylfYMgiqTnXeo27b5jdwh9dq
         qlPWNYYo7/4HpfxKy1fzneHlbFxhhI5aYIHBVsgbpVpZ8Yz2PkRaBWPAY7U+tvf0qO
         wKup6EQVUm2LRfxMmfeWS9uEP6d4M11xqW+icQ0U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: pwm: Convert Samsung PWM bindings to json-schema
Date:   Mon, 21 Oct 2019 18:02:07 +0200
Message-Id: <20191021160207.18026-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021160207.18026-1-krzk@kernel.org>
References: <20191021160207.18026-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert Samsung PWM (S3C, S5P and Exynos SoCs) bindings to DT schema
format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Add reviewed-by.

Changes since v2:
1. Add additionalProperties: false.

Changes since v1:
1. Indent example with four spaces (more readable),
2. Fix samsung,pwm-outputs after review,
3. Remove double-quotes from clock names.
---
 .../devicetree/bindings/pwm/pwm-samsung.txt   |  51 --------
 .../devicetree/bindings/pwm/pwm-samsung.yaml  | 109 ++++++++++++++++++
 2 files changed, 109 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
deleted file mode 100644
index 5538de9c2007..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-* Samsung PWM timers
-
-Samsung SoCs contain PWM timer blocks which can be used for system clock source
-and clock event timers, as well as to drive SoC outputs with PWM signal. Each
-PWM timer block provides 5 PWM channels (not all of them can drive physical
-outputs - see SoC and board manual).
-
-Be aware that the clocksource driver supports only uniprocessor systems.
-
-Required properties:
-- compatible : should be one of following:
-    samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
-    samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
-    samsung,s5p6440-pwm - for 32-bit timers present on S5P64x0 SoCs
-    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
-			  Exynos4210 rev0 SoCs
-    samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
-                          Exynos4x12, Exynos5250 and Exynos5420 SoCs
-- reg: base address and size of register area
-- interrupts: list of timer interrupts (one interrupt per timer, starting at
-  timer 0)
-- clock-names: should contain all following required clock names:
-    - "timers" - PWM base clock used to generate PWM signals,
-  and any subset of following optional clock names:
-    - "pwm-tclk0" - first external PWM clock source,
-    - "pwm-tclk1" - second external PWM clock source.
-  Note that not all IP variants allow using all external clock sources.
-  Refer to SoC documentation to learn which clock source configurations
-  are available.
-- clocks: should contain clock specifiers of all clocks, which input names
-  have been specified in clock-names property, in same order.
-- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
-  the cells format. The only third cell flag supported by this binding is
-  PWM_POLARITY_INVERTED.
-
-Optional properties:
-- samsung,pwm-outputs: list of PWM channels used as PWM outputs on particular
-    platform - an array of up to 5 elements being indices of PWM channels
-    (from 0 to 4), the order does not matter.
-
-Example:
-	pwm@7f006000 {
-		compatible = "samsung,s3c6400-pwm";
-		reg = <0x7f006000 0x1000>;
-		interrupt-parent = <&vic0>;
-		interrupts = <23>, <24>, <25>, <27>, <28>;
-		clocks = <&clock 67>;
-		clock-names = "timers";
-		samsung,pwm-outputs = <0>, <1>;
-		#pwm-cells = <3>;
-	}
diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
new file mode 100644
index 000000000000..ea7f32905172
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-samsung.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC PWM timers
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |+
+  Samsung SoCs contain PWM timer blocks which can be used for system clock source
+  and clock event timers, as well as to drive SoC outputs with PWM signal. Each
+  PWM timer block provides 5 PWM channels (not all of them can drive physical
+  outputs - see SoC and board manual).
+
+  Be aware that the clocksource driver supports only uniprocessor systems.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
+      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
+      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
+      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
+      - samsung,exynos4210-pwm          # 32-bit, Exynos
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    description: |
+      Should contain all following required clock names:
+      - "timers" - PWM base clock used to generate PWM signals,
+      and any subset of following optional clock names:
+      - "pwm-tclk0" - first external PWM clock source,
+      - "pwm-tclk1" - second external PWM clock source.
+      Note that not all IP variants allow using all external clock sources.
+      Refer to SoC documentation to learn which clock source configurations
+      are available.
+    oneOf:
+      - items:
+        - const: timers
+      - items:
+        - const: timers
+        - const: pwm-tclk0
+      - items:
+        - const: timers
+        - const: pwm-tclk1
+      - items:
+        - const: timers
+        - const: pwm-tclk0
+        - const: pwm-tclk1
+
+  interrupts:
+    description:
+      One interrupt per timer, starting at timer 0.
+    minItems: 1
+    maxItems: 5
+
+  "#pwm-cells":
+    description:
+      The only third cell flag supported by this binding
+      is PWM_POLARITY_INVERTED.
+    const: 3
+
+  samsung,pwm-outputs:
+    description:
+      A list of PWM channels used as PWM outputs on particular platform.
+      It is an array of up to 5 elements being indices of PWM channels
+      (from 0 to 4), the order does not matter.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - uniqueItems: true
+      - items:
+          minimum: 0
+          maximum: 4
+
+required:
+  - clocks
+  - clock-names
+  - compatible
+  - interrupts
+  - "#pwm-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@7f006000 {
+        compatible = "samsung,s3c6400-pwm";
+        reg = <0x7f006000 0x1000>;
+        interrupt-parent = <&vic0>;
+        interrupts = <23>, <24>, <25>, <27>, <28>;
+        clocks = <&clock 67>;
+        clock-names = "timers";
+        samsung,pwm-outputs = <0>, <1>;
+        #pwm-cells = <3>;
+    };
-- 
2.17.1

