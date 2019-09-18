Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C365B6970
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 19:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfIRRcj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387818AbfIRRci (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Sep 2019 13:32:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D79D821928;
        Wed, 18 Sep 2019 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568827958;
        bh=E9DwEf7R8b/H/w/pY582iNh72DFD9zpZbpy6YjCJtCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHEiwH/r63UQYy4j6Uf8KGGtFbl4pyX4olLMK84c3ybxPXAShOU6AW7FSUIC76wh0
         9foNamqzWle3Cgmi0S2/zX1D7GQgiwPMUPGJzBJkTKl0OzQP4UHOYYHcX9YiMaCUCb
         5WhDtUwJ68hJrzzVaxE139BLp3UdDCgJMgSlHHEU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 5/8] dt-bindings: watchdog: Convert Samsung SoC watchdog bindings to json-schema
Date:   Wed, 18 Sep 2019 19:31:38 +0200
Message-Id: <20190918173141.4314-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918173141.4314-1-krzk@kernel.org>
References: <20190918173141.4314-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert Samsung S3C/S5P/Exynos watchdog bindings to DT schema format
using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Indent example with four spaces (more readable),
2. Remove unneeded timeout-sec description.
---
 .../bindings/watchdog/samsung-wdt.txt         | 35 ----------
 .../bindings/watchdog/samsung-wdt.yaml        | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
deleted file mode 100644
index 46dcb48e75b4..000000000000
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* Samsung's Watchdog Timer Controller
-
-The Samsung's Watchdog controller is used for resuming system operation
-after a preset amount of time during which the WDT reset event has not
-occurred.
-
-Required properties:
-- compatible : should be one among the following
-	- "samsung,s3c2410-wdt" for S3C2410
-	- "samsung,s3c6410-wdt" for S3C6410, S5PV210 and Exynos4
-	- "samsung,exynos5250-wdt" for Exynos5250
-	- "samsung,exynos5420-wdt" for Exynos5420
-	- "samsung,exynos7-wdt" for Exynos7
-
-- reg : base physical address of the controller and length of memory mapped
-	region.
-- interrupts : interrupt number to the cpu.
-- samsung,syscon-phandle : reference to syscon node (This property required only
-	in case of compatible being "samsung,exynos5250-wdt" or "samsung,exynos5420-wdt".
-	In case of Exynos5250 and 5420 this property points to syscon node holding the PMU
-	base address)
-
-Optional properties:
-- timeout-sec : contains the watchdog timeout in seconds.
-
-Example:
-
-watchdog@101d0000 {
-	compatible = "samsung,exynos5250-wdt";
-	reg = <0x101D0000 0x100>;
-	interrupts = <0 42 0>;
-	clocks = <&clock 336>;
-	clock-names = "watchdog";
-	samsung,syscon-phandle = <&pmu_syscon>;
-};
diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
new file mode 100644
index 000000000000..3ea3c9fe8390
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/samsung-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC Watchdog Timer Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |+
+  The Samsung's Watchdog controller is used for resuming system operation
+  after a preset amount of time during which the WDT reset event has not
+  occurred.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s3c2410-wdt                   # for S3C2410
+      - samsung,s3c6410-wdt                   # for S3C6410, S5PV210 and Exynos4
+      - samsung,exynos5250-wdt                # for Exynos5250
+      - samsung,exynos5420-wdt                # for Exynos5420
+      - samsung,exynos7-wdt                   # for Exynos7
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  samsung,syscon-phandle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the PMU system controller node (in case of Exynos5250
+      and Exynos5420).
+
+  timeout-sec:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5250-wdt
+              - samsung,exynos5420-wdt
+    then:
+      required:
+        - samsung,syscon-phandle
+
+examples:
+  - |
+    watchdog@101d0000 {
+        compatible = "samsung,exynos5250-wdt";
+        reg = <0x101D0000 0x100>;
+        interrupts = <0 42 0>;
+        clocks = <&clock 336>;
+        clock-names = "watchdog";
+        samsung,syscon-phandle = <&pmu_syscon>;
+    };
-- 
2.17.1

