Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50D1D286B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgENHDy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 03:03:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44246 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgENHDy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 14 May 2020 03:03:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB4881A0148;
        Thu, 14 May 2020 09:03:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C4481A0132;
        Thu, 14 May 2020 09:03:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AE84F402B4;
        Thu, 14 May 2020 15:03:39 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, p.zabel@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] dt-bindings: pwm: Convert imx pwm to json-schema
Date:   Thu, 14 May 2020 14:54:18 +0800
Message-Id: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the imx pwm binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.txt  | 27 ---------
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 66 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
deleted file mode 100644
index 22f1c3d..0000000
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Freescale i.MX PWM controller
-
-Required properties:
-- compatible : should be "fsl,<soc>-pwm" and one of the following
-   compatible strings:
-  - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
-  - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
-- reg: physical base address and length of the controller's registers
-- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
-  in this directory for a description of the cells format.
-- clocks : Clock specifiers for both ipg and per clocks.
-- clock-names : Clock names should include both "ipg" and "per"
-See the clock consumer binding,
-	Documentation/devicetree/bindings/clock/clock-bindings.txt
-- interrupts: The interrupt for the pwm controller
-
-Example:
-
-pwm1: pwm@53fb4000 {
-	#pwm-cells = <3>;
-	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
-	reg = <0x53fb4000 0x4000>;
-	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
-		 <&clks IMX5_CLK_PWM1_HF_GATE>;
-	clock-names = "ipg", "per";
-	interrupts = <61>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
new file mode 100644
index 0000000..4b62af2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/imx-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX PWM controller
+
+maintainers:
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+properties:
+  "#pwm-cells":
+    description: |
+      Should be 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
+      in this directory for a description of the cells format.
+    enum:
+      - 2
+      - 3
+
+  compatible:
+    enum:
+      - fsl,imx1-pwm
+      - fsl,imx27-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC PWM ipg clock
+      - description: SoC PWM per clock
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: per
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx5-clock.h>
+
+    pwm@53fb4000 {
+        #pwm-cells = <3>;
+        compatible = "fsl,imx27-pwm";
+        reg = <0x53fb4000 0x4000>;
+        clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
+                 <&clks IMX5_CLK_PWM1_HF_GATE>;
+        clock-names = "ipg", "per";
+        interrupts = <61>;
+    };
-- 
2.7.4

