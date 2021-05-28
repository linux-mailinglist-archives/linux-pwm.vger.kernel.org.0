Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624F6393C9B
	for <lists+linux-pwm@lfdr.de>; Fri, 28 May 2021 06:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhE1FAR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 May 2021 01:00:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50948 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhE1FAQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 May 2021 01:00:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14S4wZdv069165;
        Thu, 27 May 2021 23:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622177915;
        bh=u0xVOj8QY88CY3HHK41dwx4rZLKyf5aV5Tezwk+tDAU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BAJhcqXDbKZM3bKU8b2OaNg8SgtHP+5FeFrgl/6dqsSlzcRIBB0wfF0ilDplq69Ak
         6UA0h24JIyjP5Xwu51pqAYyr6AXfs749fucLK954gGJSdd3+IL1qOd6owQHUq3xSSk
         6T668/EFyy0LhdO8RbFS3HS2RcpYNKrRB6Y3aDrk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14S4wZwr081422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 23:58:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 23:58:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 23:58:35 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14S4wInB088708;
        Thu, 27 May 2021 23:58:31 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 3/4] dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
Date:   Fri, 28 May 2021 10:28:16 +0530
Message-ID: <20210528045817.16618-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528045817.16618-1-lokeshvutla@ti.com>
References: <20210528045817.16618-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the tiehrpwm binding to DT schema format using json-schema.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt  | 49 --------------
 .../devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
deleted file mode 100644
index 8eae48c9c5cd..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-TI SOC EHRPWM based PWM controller
-
-Required properties:
-- compatible: Must be "ti,<soc>-ehrpwm".
-  for am33xx  - compatible = "ti,am3352-ehrpwm";
-  for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm";
-  for am654   - compatible = "ti,am654-ehrpwm", "ti-am3352-ehrpwm";
-  for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm";
-  for dra746 - compatible = "ti,dra746-ehrpwm", "ti-am3352-ehrpwm";
-- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
-  the cells format. The only third cell flag supported by this binding is
-  PWM_POLARITY_INVERTED.
-- reg: physical base address and size of the registers map.
-- clocks: Handle to the PWM's time-base and functional clock.
-- clock-names: Must be set to "tbclk" and "fck".
-
-Example:
-
-ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
-	compatible = "ti,am3352-ehrpwm";
-	#pwm-cells = <3>;
-	reg = <0x48300200 0x100>;
-	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
-	clock-names = "tbclk", "fck";
-};
-
-ehrpwm0: pwm@48300200 { /* EHRPWM on am4372 */
-	compatible = "ti,am4372-ehrpwm", "ti,am3352-ehrpwm";
-	#pwm-cells = <3>;
-	reg = <0x48300200 0x80>;
-	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
-	clock-names = "tbclk", "fck";
-};
-
-ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
-	compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
-	#pwm-cells = <3>;
-	reg = <0x1f00000 0x2000>;
-	clocks = <&psc1 17>, <&ehrpwm_tbclk>;
-	clock-names = "fck", "tbclk";
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

