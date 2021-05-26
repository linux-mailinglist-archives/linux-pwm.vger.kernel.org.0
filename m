Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468BA391289
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhEZIo4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 May 2021 04:44:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44602 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhEZIoz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 May 2021 04:44:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8hH7p050656;
        Wed, 26 May 2021 03:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622018597;
        bh=OoFhCptIPab1wWjNKqETXIysZNtoiUpz9z0Sf7DMLwI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rrgdliZoFsx+EeMb6Fb+r6cbcCFnUr2baarxK2xgQTHq30tzYDoRcg+islwITIMsi
         aDiWwxVfeLqiaoiAVUcvt1blkKha25E8wfi2paIQQZcbQphlZif1LPL3vtpjBhwt/V
         gZdcyaIv8YHtaf9Jz2WFAULJS+YTlOzeiUQcG+Z8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14Q8hHXL067034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 03:43:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 03:43:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 03:43:17 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8h75V049811;
        Wed, 26 May 2021 03:43:13 -0500
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
Subject: [PATCH 1/4] arm: dts: ti: drop usage of redundant compatible
Date:   Wed, 26 May 2021 14:13:03 +0530
Message-ID: <20210526084306.6534-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084306.6534-1-lokeshvutla@ti.com>
References: <20210526084306.6534-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 229110c1aa691 ("ARM: dts: am437x/am33xx/da850: Add new ECAP and
EPWM bindings") added ti,am3352-ehrpwm compatible which is similar to
ti,am33xx-ehrpwm but without out t,hwmod properties. But with commit
58bfbea5b1c68 ("ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP
and EPWM nodes") dropped support for all ti,hwmod for ehrpwm, but
missed deprecating ti,am33xx-ehrpwm compatible. So drop ti,am33xx-ehrpwm
from DT as it is no longer needed.

ti-ehrpwn driver still support ti,am33xx-ehrpwm in order to maintain
backward compatibility.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt   | 13 ++++++-------
 arch/arm/boot/dts/am33xx-l4.dtsi               |  9 +++------
 arch/arm/boot/dts/am437x-l4.dtsi               | 18 ++++++------------
 arch/arm/boot/dts/da850.dtsi                   |  6 ++----
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index c7e28f6d28be..e124e41418d8 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -2,10 +2,10 @@ TI SOC EHRPWM based PWM controller
 
 Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
-  for am33xx  - compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
-  for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
+  for am33xx  - compatible = "ti,am3352-ehrpwm";
+  for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm";
   for am654   - compatible = "ti,am654-ehrpwm", "ti-am3352-ehrpwm";
-  for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
+  for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm";
   for dra746 - compatible = "ti,dra746-ehrpwm", "ti-am3352-ehrpwm";
 - #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
@@ -19,7 +19,7 @@ Optional properties:
 Example:
 
 ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
-	compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
+	compatible = "ti,am3352-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x48300200 0x100>;
 	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
@@ -27,16 +27,15 @@ ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
 };
 
 ehrpwm0: pwm@48300200 { /* EHRPWM on am4372 */
-	compatible = "ti,am4372-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
+	compatible = "ti,am4372-ehrpwm", "ti,am3352-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x48300200 0x80>;
 	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
 	clock-names = "tbclk", "fck";
-	ti,hwmods = "ehrpwm0";
 };
 
 ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
-	compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
+	compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x1f00000 0x2000>;
 };
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 039a9ab4c7ea..fbf3458ab246 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -2017,8 +2017,7 @@ eqep0: counter@180 {
 				};
 
 				ehrpwm0: pwm@200 {
-					compatible = "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+					compatible = "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
@@ -2078,8 +2077,7 @@ eqep1: counter@180 {
 				};
 
 				ehrpwm1: pwm@200 {
-					compatible = "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+					compatible = "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
@@ -2139,8 +2137,7 @@ eqep2: counter@180 {
 				};
 
 				ehrpwm2: pwm@200 {
-					compatible = "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+					compatible = "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index e217ffc09770..e796b9bcc54e 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -1760,8 +1760,7 @@ ecap0: ecap@100 {
 
 				ehrpwm0: pwm@200 {
 					compatible = "ti,am4372-ehrpwm",
-						     "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+						     "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
@@ -1812,8 +1811,7 @@ ecap1: ecap@100 {
 
 				ehrpwm1: pwm@200 {
 					compatible = "ti,am4372-ehrpwm",
-						     "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+						     "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
@@ -1864,8 +1862,7 @@ ecap2: ecap@100 {
 
 				ehrpwm2: pwm@200 {
 					compatible = "ti,am4372-ehrpwm",
-						     "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+						     "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
@@ -1905,8 +1902,7 @@ epwmss3: epwmss@0 {
 
 				ehrpwm3: pwm@200 {
 					compatible = "ti,am4372-ehrpwm",
-						     "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+						     "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm3_tbclk>, <&l4ls_gclk>;
@@ -1946,8 +1942,7 @@ epwmss4: epwmss@0 {
 
 				ehrpwm4: pwm@48308200 {
 					compatible = "ti,am4372-ehrpwm",
-						     "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+						     "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm4_tbclk>, <&l4ls_gclk>;
@@ -1987,8 +1982,7 @@ epwmss5: epwmss@0 {
 
 				ehrpwm5: pwm@200 {
 					compatible = "ti,am4372-ehrpwm",
-						     "ti,am3352-ehrpwm",
-						     "ti,am33xx-ehrpwm";
+						     "ti,am3352-ehrpwm";
 					#pwm-cells = <3>;
 					reg = <0x200 0x80>;
 					clocks = <&ehrpwm5_tbclk>, <&l4ls_gclk>;
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 7cf31b6e48b7..afdf3d3747ce 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -574,8 +574,7 @@ mmc1: mmc@21b000 {
 			status = "disabled";
 		};
 		ehrpwm0: pwm@300000 {
-			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
-				     "ti,am33xx-ehrpwm";
+			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
@@ -584,8 +583,7 @@ ehrpwm0: pwm@300000 {
 			status = "disabled";
 		};
 		ehrpwm1: pwm@302000 {
-			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
-				     "ti,am33xx-ehrpwm";
+			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
-- 
2.31.1

