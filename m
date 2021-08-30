Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEA3FB4BF
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Aug 2021 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhH3Lrm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Aug 2021 07:47:42 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:51046 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236532AbhH3Lri (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Aug 2021 07:47:38 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 10592440E45;
        Mon, 30 Aug 2021 14:46:32 +0300 (IDT)
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
Subject: [PATCH v8 3/4] dt-bindings: pwm: add IPQ6018 binding
Date:   Mon, 30 Aug 2021 14:46:26 +0300
Message-Id: <8238dfb5d5e4a40a995f047db36d9a7240431de5.1630323987.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
References: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
This series does not convert the TCSR binding documentation to YAML. As
a result, this commit adds new a dt_binding_check warning:

/example-0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-ipq 6018', 'syscon', 'simple-mfd']

If that is a blocker to IPQ6018 PWM support, so be it. Patches will wait
for someone else to push them further.

v8:

  Add size cell to 'reg' (Rob)

v7:

  Use 'reg' instead of 'offset' (Rob)

  Drop 'clock-names' and 'assigned-clock*' (Bjorn)

  Use single cell address/size in example node (Bjorn)

  Move '#pwm-cells' lower in example node (Bjorn)

  List 'reg' as required

v6:

  Device node is child of TCSR; remove phandle (Rob Herring)

  Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
    Andersson, Kathiravan T)

v4: Update the binding example node as well (Rob Herring's bot)

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

v2: Make #pwm-cells const (Rob Herring)
---
 .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
new file mode 100644
index 000000000000..96bc63e336bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
@@ -0,0 +1,52 @@
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
+  reg:
+    description: Offset of PWM register in the TCSR block.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+
+    tcsr: syscon@1937000 {
+        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
+        reg = <0x01937000 0x21000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        pwm: pwm@a010 {
+            compatible = "qcom,ipq6018-pwm";
+            reg = <0xa010 0x20>;
+            clocks = <&gcc GCC_ADSS_PWM_CLK>;
+            assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+            assigned-clock-rates = <100000000>;
+            #pwm-cells = <2>;
+        };
+    };
-- 
2.33.0

