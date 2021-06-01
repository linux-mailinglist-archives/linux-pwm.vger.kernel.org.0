Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E1B39716E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhFAKaG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 06:30:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48824 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFAKaF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 06:30:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 151ASGof096776;
        Tue, 1 Jun 2021 05:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622543296;
        bh=LKrcvffVyfMxN9PDqDPsUOy9ilXYVbyQsO+/bhiKz+g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=e5vWk7pMWJ23DQXNFwvb+Kbngt1eioixnEGRKDeNNISZzg8KKZNe+iU3Q0uX4uTvX
         t9pgY8upP71CzWlI2fO2ZXZPylxZyMNfwZ38XvvxM1/vy+/a09KDKKnRbPA+Ik1C7L
         68ymvdG9GhJHdQc0TRgJ0apD0RXyNToSlDuK/gz8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 151ASG5C049674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 05:28:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 05:28:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 05:28:16 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 151AS56I063553;
        Tue, 1 Jun 2021 05:28:11 -0500
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
Subject: [PATCH 1/2] dt-bindings: pwm: pwm-tiecap: Convert to json schema
Date:   Tue, 1 Jun 2021 15:58:03 +0530
Message-ID: <20210601102804.22152-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601102804.22152-1-lokeshvutla@ti.com>
References: <20210601102804.22152-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the tiecap binding to DT schema format using json-schema.
Along with this conversion the following changes are included:
- 'clock' and 'clock-names' properties are marked required as
   driver fails to probe without these properties
- Dropped ti,am33xx-ecap as it is no longer applicable.
- 'power-domains' property is introduced and marked as optional.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../devicetree/bindings/pwm/pwm-tiecap.txt    | 51 ---------------
 .../devicetree/bindings/pwm/pwm-tiecap.yaml   | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
deleted file mode 100644
index c7c4347a769a..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-TI SOC ECAP based APWM controller
-
-Required properties:
-- compatible: Must be "ti,<soc>-ecap".
-  for am33xx - compatible = "ti,am3352-ecap", "ti,am33xx-ecap";
-  for am4372 - compatible = "ti,am4372-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
-  for da850  - compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
-  for dra746 - compatible = "ti,dra746-ecap", "ti,am3352-ecap";
-  for 66ak2g - compatible = "ti,k2g-ecap", "ti,am3352-ecap";
-  for am654  - compatible = "ti,am654-ecap", "ti,am3352-ecap";
-- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
-  the cells format. The PWM channel index ranges from 0 to 4. The only third
-  cell flag supported by this binding is PWM_POLARITY_INVERTED.
-- reg: physical base address and size of the registers map.
-
-Optional properties:
-- clocks: Handle to the ECAP's functional clock.
-- clock-names: Must be set to "fck".
-
-Example:
-
-ecap0: ecap@48300100 { /* ECAP on am33xx */
-	compatible = "ti,am3352-ecap", "ti,am33xx-ecap";
-	#pwm-cells = <3>;
-	reg = <0x48300100 0x80>;
-	clocks = <&l4ls_gclk>;
-	clock-names = "fck";
-};
-
-ecap0: ecap@48300100 { /* ECAP on am4372 */
-	compatible = "ti,am4372-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
-	#pwm-cells = <3>;
-	reg = <0x48300100 0x80>;
-	ti,hwmods = "ecap0";
-	clocks = <&l4ls_gclk>;
-	clock-names = "fck";
-};
-
-ecap0: ecap@1f06000 { /* ECAP on da850 */
-	compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
-	#pwm-cells = <3>;
-	reg = <0x1f06000 0x80>;
-};
-
-ecap0: ecap@4843e100 {
-	compatible = "ti,dra746-ecap", "ti,am3352-ecap";
-	#pwm-cells = <3>;
-	reg = <0x4843e100 0x80>;
-	clocks = <&l4_root_clk_div>;
-	clock-names = "fck";
-};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
new file mode 100644
index 000000000000..8717166dd05f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-tiecap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI SOC ECAP based APWM controller
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
+      - const: ti,am3352-ecap
+      - items:
+          - enum:
+              - ti,da850-ecap
+              - ti,am4372-ecap
+              - ti,dra746-ecap
+              - ti,k2g-ecap
+              - ti,am654-ecap
+          - const: ti,am3352-ecap
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
+    const: fck
+
+  clocks:
+    maxItems: 1
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
+    ecap0: pwm@48300100 { /* ECAP on am33xx */
+        compatible = "ti,am3352-ecap";
+        #pwm-cells = <3>;
+        reg = <0x48300100 0x80>;
+        clocks = <&l4ls_gclk>;
+        clock-names = "fck";
+    };
-- 
2.31.1

