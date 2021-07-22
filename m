Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB13D21AE
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 12:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhGVJYP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 05:24:15 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:39310 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhGVJXx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Jul 2021 05:23:53 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id B0981440E49;
        Thu, 22 Jul 2021 13:01:29 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 3/4] dt-bindings: pwm: add IPQ6018 binding
Date:   Thu, 22 Jul 2021 13:01:09 +0300
Message-Id: <70f0522a9394e9da2f31871442d47f6ad0ff41aa.1626948070.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
References: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v6:

  Device node is child of TCSR; remove phandle (Rob Herring)

  Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
    Andersson, Kathiravan T)

v4: Update the binding example node as well (Rob Herring's bot)

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

v2: Make #pwm-cells const (Rob Herring)
---
 .../devicetree/bindings/pwm/ipq-pwm.yaml      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
new file mode 100644
index 000000000000..ee2bb03a1223
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ6018 PWM controller
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+properties:
+  "#pwm-cells":
+    const: 2
+
+  compatible:
+    const: qcom,ipq6018-pwm
+
+  offset:
+    description: |
+      Offset of PWM register in the TCSR block.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: core
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-rates
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        tcsr: syscon@1937000 {
+            compatible = "syscon", "simple-mfd";
+            reg = <0x0 0x01937000 0x0 0x21000>;
+
+            pwm: pwm {
+                #pwm-cells = <2>;
+                compatible = "qcom,ipq6018-pwm";
+                offset = <0xa010>;
+                clocks = <&gcc GCC_ADSS_PWM_CLK>;
+                clock-names = "core";
+                assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+                assigned-clock-rates = <100000000>;
+                status = "disabled";
+            };
+        };
+    };
-- 
2.30.2

