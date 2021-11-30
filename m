Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA0463D23
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Nov 2021 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbhK3RsH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Nov 2021 12:48:07 -0500
Received: from bzq-84-110-109-230.red.bezeqint.net ([84.110.109.230]:41409
        "EHLO mx.tkos.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234300AbhK3RsG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 12:48:06 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 8A5A9440EEB;
        Tue, 30 Nov 2021 19:38:04 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1638293884;
        bh=gxx34wJXdvcMHb4Y8X0BxXRv5pleeDIt1UIt5DzKPbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OL1vONVf5Op7eXLA9HTRUPb/DOEMHsaZV+SmtNB6miX4vGgpXYfwdNhryfgiAR5UD
         8ZDuXEWCSmnJV3TlaktX4blLIH19L9xj/Bs8jz3QRWPyCNUC05dR8MKCqYsXvY4/B9
         S4RpnsaJmCq8FblGoKN/Q7JzNJHUckKOdwAp/7Rub2fE0cYYLwqNDgF/naP1nCntf6
         JNeZhLL9HeWLeylbc2dd/mLZ2KWiF9sRDbutSYS16UxlIVRfdO05fh/4W2siTJyDMV
         Ywder0rE6364FQwcYgJxTo5TfyrboxU165pYj/e8bIWkhebU7AXoCgF+2aZH14Yxz/
         4YydgLk1MasqQ==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Tue, 30 Nov 2021 19:37:29 +0200
Message-Id: <62ec6016400e80ee379c07ef2c80abbf7f60bbe2.1638293850.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il>
References: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

v9:

  Add 'ranges' property to example (Rob)

  Drop label in example (Rob)

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
 .../devicetree/bindings/pwm/ipq-pwm.yaml      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
new file mode 100644
index 000000000000..857086ad539e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
@@ -0,0 +1,53 @@
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
+    syscon@1937000 {
+        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
+        reg = <0x01937000 0x21000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x1937000 0x21000>;
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

