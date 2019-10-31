Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D53EB04C
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2019 13:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfJaMbS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 31 Oct 2019 08:31:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbfJaMbR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Oct 2019 08:31:17 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VCQsTm029332;
        Thu, 31 Oct 2019 13:30:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0Hh4of25kloH1WraPyDwx8oHjxU7GW8p1ddlRNtYxmg=;
 b=AVP1lXul65MYbAjaHrK0INCHPVyaXsHBJAWuaj3QpOUQqLedaPFm/97wWAI/FKujS98t
 Q1lOVFYlAC2OWFTEt5X/1Z+nNocqPIlD+g1Uw6/p/2yZxTik8GkFXWe2k8O2Vm3g0j5O
 KihoUkBFSeQCQlSYY/3BPzPPDGKgBbCknkRglCilPyVdO9u2+fCL6GNZYWoZPBhySzro
 yBVhi3zeWE7JEd7dsJ5sKDLhD4Q0TWu5A+ITP4btONKfVexLcjfgZAfd5vXXPq1ZGCNk
 tc/ecyZjERoLK+FGAUCAWq4TUZSOQl834+2xqor2/YpSVE5sN/NBKZxSKKP7dTOk8cZM AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vxwhussf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 13:30:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BCD07100038;
        Thu, 31 Oct 2019 13:30:52 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB6322B7837;
        Thu, 31 Oct 2019 13:30:52 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 13:30:52 +0100
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct 2019 13:30:52
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <lee.jones@linaro.org>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <benjamin.gaignard@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger bindings to json-schema
Date:   Thu, 31 Oct 2019 13:30:38 +0100
Message-ID: <20191031123040.26316-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191031123040.26316-1-benjamin.gaignard@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_05:2019-10-30,2019-10-31 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the STM32 IIO trigger binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++++++++++++++
 .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ------------
 2 files changed, 44 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
new file mode 100644
index 000000000000..1c8c8b55e8cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Timers IIO timer bindings
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+properties:
+  $nodemane:
+    pattern: "^timer@[0-9]+$"
+    type: object
+
+    description:
+      must be a sub-node of an STM32 Timer device tree node
+
+    properties:
+      compatible:
+        oneOf:
+          - const: st,stm32-timer-trigger
+          - const: st,stm32h7-timer-trigger
+            
+      reg: true
+
+    required:
+      - compatible
+      - reg
+
+examples:
+  - |
+    timers2: timer@40000000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      timer@0 {
+        compatible = "st,stm32-timer-trigger";
+        reg = <0>;
+      };
+    };
+    
+...
diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
deleted file mode 100644
index b8e8c769d434..000000000000
--- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-STMicroelectronics STM32 Timers IIO timer bindings
-
-Must be a sub-node of an STM32 Timers device tree node.
-See ../mfd/stm32-timers.txt for details about the parent node.
-
-Required parameters:
-- compatible:	Must be one of:
-		"st,stm32-timer-trigger"
-		"st,stm32h7-timer-trigger"
-- reg:		Identify trigger hardware block.
-
-Example:
-	timers@40010000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "st,stm32-timers";
-		reg = <0x40010000 0x400>;
-		clocks = <&rcc 0 160>;
-		clock-names = "int";
-
-		timer@0 {
-			compatible = "st,stm32-timer-trigger";
-			reg = <0>;
-		};
-	};
-- 
2.15.0

