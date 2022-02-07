Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DA4AB7C7
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 10:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiBGJkD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 04:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352869AbiBGJim (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 04:38:42 -0500
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 01:38:40 PST
Received: from mx.tkos.co.il (guitar.tcltek.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335BC043188;
        Mon,  7 Feb 2022 01:38:40 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 9C64B440883;
        Mon,  7 Feb 2022 11:30:37 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1644226238;
        bh=LG1R2ibEhTcQ8x9dNJ4eYSWnaeIYekcQQHT0CEdyRZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gI0ya3JNUqByCXZ+cvm21SUnGCYkfFvaPSmUiazlGd13B1OxQdxdjhUUuG8x84MjL
         qpTQEWb2uC2wldRSn1FJjfogqxGN+PTeX4kCnQ8PByMjoUDaShJzQX/ysq7SxdCg9F
         nvEPaDj8naW1uR493Q5CJR0j/L1JOl5Jq+kNx8EXQIA43URdZykPYJiAItYTdxEkEk
         6L4VztofVcv1qpNbRqwoq1OOFonbsrChgTHITM6zoSWw21wDgRsmBK7qSxOhV5kU4n
         Pm5NWNBaPOi8pCfDR73/PkvdXEojOyBrtCR6Tut2gh0ZRS0/rhUXsyJNyqNnfjz+AM
         ZkEOHF8fRTIRw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Mon,  7 Feb 2022 11:30:44 +0200
Message-Id: <dee024e7add1b2c919b23472c90391239a0a2572.1644226245.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
References: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
This series does not convert the TCSR binding documentation to YAML. As
a result, this commit adds a new dt_binding_check warning:

/example-0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-ipq 6018', 'syscon', 'simple-mfd']

If that is a blocker to IPQ6018 PWM support, so be it. Patches will wait
for someone else to push them further.

v10:

  No change

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
2.34.1

