Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1F396CF2
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 07:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFAFqF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 01:46:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40698 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAFqE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 01:46:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1515iHk2118019;
        Tue, 1 Jun 2021 00:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622526257;
        bh=1MJks7OKX6RoN9YTaQDyoCwUIvW15izw1WNsptA+9DU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TjwyQQ/jPwfg66S5yzwL7StM1+nuWabts6WRgXgfjxg6pJGEqUcVwhTdebFUpG2Wx
         oBc0jNMsgPi+7hENgpbYHWjdGmoOhhBrghWui8ARj4gqR4gtygLXrnW4kd3E1WVBQr
         jOsYHhLUoMszNELSPy8pPcfl5XHjDgoBTShfoAsk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1515iH0i046957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 00:44:17 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 00:44:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 00:44:17 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1515i3P4091502;
        Tue, 1 Jun 2021 00:44:10 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
Date:   Tue, 1 Jun 2021 11:14:01 +0530
Message-ID: <20210601054402.2223-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601054402.2223-1-lokeshvutla@ti.com>
References: <20210601054402.2223-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the tiehrpwm binding to DT schema format using json-schema.
Along with this conversion the following changes are included:
- 'clock' and 'clock-names' properties are marked as required as
   driver fails to probe without these properties
- Dropped ti,am33xx-ehrpwm as it is no longer applicable.
- 'power-domains' property is introduced and marked as optional.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt  | 50 ---------------
 .../devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
deleted file mode 100644
index c7e28f6d28be..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-TI SOC EHRPWM based PWM controller
-
-Required properties:
-- compatible: Must be "ti,<soc>-ehrpwm".
-  for am33xx  - compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
-  for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
-  for am654   - compatible = "ti,am654-ehrpwm", "ti-am3352-ehrpwm";
-  for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
-  for dra746 - compatible = "ti,dra746-ehrpwm", "ti-am3352-ehrpwm";
-- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
-  the cells format. The only third cell flag supported by this binding is
-  PWM_POLARITY_INVERTED.
-- reg: physical base address and size of the registers map.
-
-Optional properties:
-- clocks: Handle to the PWM's time-base and functional clock.
-- clock-names: Must be set to "tbclk" and "fck".
-
-Example:
-
-ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
-	compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
-	#pwm-cells = <3>;
-	reg = <0x48300200 0x100>;
-	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
-	clock-names = "tbclk", "fck";
-};
-
-ehrpwm0: pwm@48300200 { /* EHRPWM on am4372 */
-	compatible = "ti,am4372-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
-	#pwm-cells = <3>;
-	reg = <0x48300200 0x80>;
-	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
-	clock-names = "tbclk", "fck";
-	ti,hwmods = "ehrpwm0";
-};
-
-ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
-	compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
-	#pwm-cells = <3>;
-	reg = <0x1f00000 0x2000>;
-};
-
-ehrpwm0: pwm@4843e200 { /* EHRPWM on dra746 */
-	compatible = "ti,dra746-ehrpwm", "ti,am3352-ehrpwm";
-	#pwm-cells = <3>;
-	reg = <0x4843e200 0x80>;
-	clocks = <&ehrpwm0_tbclk>, <&l4_root_clk_div>;
-	clock-names = "tbclk", "fck";
-};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
new file mode 100644
index 000000000000..84a8d6d38cee
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-tiehrpwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI SOC EHRPWM based PWM controller
+
+maintainers:
+  - Vignesh R <vigneshr@ti.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,am3352-ehrpwm
+      - items:
+          - enum:
+              - ti,da850-ehrpwm
+              - ti,am4372-ehrpwm
+              - ti,dra746-ehrpwm
+              - ti,am654-ehrpwm
+          - const: ti,am3352-ehrpwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+    description: |
+      See pwm.yaml in this directory for a description of the cells format.
+      The only third cell flag supported by this binding is PWM_POLARITY_INVERTED.
+
+  clock-names:
+    items:
+      - const: tbclk
+      - const: fck
+
+  clocks:
+    maxItems: 2
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
+        compatible = "ti,am3352-ehrpwm";
+        #pwm-cells = <3>;
+        reg = <0x48300200 0x100>;
+        clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+        clock-names = "tbclk", "fck";
+    };
-- 
2.31.1

