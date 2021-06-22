Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69B3AFE70
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jun 2021 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFVH5j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Jun 2021 03:57:39 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57285 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFVH5i (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Jun 2021 03:57:38 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 725BB440583;
        Tue, 22 Jun 2021 10:55:09 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Tue, 22 Jun 2021 10:55:01 +0300
Message-Id: <bf56a9968149a7a70e6ef747ff054ee3728b467c.1624348502.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f97c32aa98c9cdd977fac22cd504ad97448949e9.1624348502.git.baruch@tkos.co.il>
References: <f97c32aa98c9cdd977fac22cd504ad97448949e9.1624348502.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

v2: Make #pwm-cells const (Rob Herring)
---
 .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
new file mode 100644
index 000000000000..bc3299be3fc6
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
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: core
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
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
+        pwm@1941010 {
+            #pwm-cells = <2>;
+            compatible = "qcom,pwm-ipq6018";
+            reg = <0x0 0x1941010 0x0 0x20>;
+            clocks = <&gcc GCC_ADSS_PWM_CLK>;
+            clock-names = "core";
+        };
+    };
-- 
2.30.2

