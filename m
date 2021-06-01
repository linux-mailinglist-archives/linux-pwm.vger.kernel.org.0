Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94640396CE6
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhFAFmX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 01:42:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41386 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAFmW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 01:42:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1515eZvn066733;
        Tue, 1 Jun 2021 00:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622526035;
        bh=oe3qOSUySI1FPT8Q3sfm0yDK7hd3d3yAYJNwWwfqhFs=;
        h=From:To:CC:Subject:Date;
        b=vfHy8P16kXhUAXr7PGONojnsztkfTtROE7rMWJdG7TyALcBpIxgMwpdZyZWo/JBwR
         ocZn05YxVHw3j92mBFOGq9Nj44NesXb/WjbBo5TZoslzW0hP+bVb2aATwNfU+YE4uo
         2Ubskwza3tdRkClJvk3uII33IIGEsnxStd+55urA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1515eZa8041330
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 00:40:35 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 00:40:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 00:40:35 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1515eUbd091363;
        Tue, 1 Jun 2021 00:40:31 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3] arm: dts: ti: drop usage of redundant compatible
Date:   Tue, 1 Jun 2021 11:10:29 +0530
Message-ID: <20210601054029.1839-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
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
Changes since v2:
- Split from ehrpwm yaml conversion series:
  https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=489981
- Dropped documentation update in this patch.

 arch/arm/boot/dts/am33xx-l4.dtsi |  9 +++------
 arch/arm/boot/dts/am437x-l4.dtsi | 18 ++++++------------
 arch/arm/boot/dts/da850.dtsi     |  6 ++----
 3 files changed, 11 insertions(+), 22 deletions(-)

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

