Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B97D0D62
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Oct 2023 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376863AbjJTKht convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 20 Oct 2023 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376775AbjJTKht (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Oct 2023 06:37:49 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479EED5A;
        Fri, 20 Oct 2023 03:37:46 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 92D2224E13F;
        Fri, 20 Oct 2023 18:37:44 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Oct
 2023 18:37:44 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 20 Oct 2023 18:37:43 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v6 1/4] dt-bindings: pwm: Add OpenCores PWM module
Date:   Fri, 20 Oct 2023 18:37:38 +0800
Message-ID: <20231020103741.557735-2-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020103741.557735-1-william.qiu@starfivetech.com>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation to describe OpenCores Pulse Width Modulation
controller driver.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../bindings/pwm/opencores,pwm-ocores.yaml    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
new file mode 100644
index 000000000000..0f6a3434f155
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/opencores,pwm-ocores.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OpenCores PWM controller
+
+maintainers:
+  - William Qiu <william.qiu@starfivetech.com>
+
+description:
+  OpenCores PTC ip core contains a PWM controller. When operating in PWM mode, the PTC core
+  generates binary signal with user-programmable low and high periods. All PTC counters and
+  registers are 32-bit.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - opencores,pwm-ocores
+      - starfive,jh71x0-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@12490000 {
+        compatible = "opencores,pwm-ocores";
+        reg = <0x12490000 0x10000>;
+        clocks = <&clkgen 181>;
+        resets = <&rstgen 109>;
+        #pwm-cells = <3>;
+    };
-- 
2.34.1

