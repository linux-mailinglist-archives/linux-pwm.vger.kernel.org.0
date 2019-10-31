Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0744EB040
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2019 13:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJaMbR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 31 Oct 2019 08:31:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53926 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbfJaMbR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Oct 2019 08:31:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VCRQ5U030921;
        Thu, 31 Oct 2019 13:30:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=RgvneSBRTilulYhN5amimgSanJ3OY7+cEr1+3gGNZwE=;
 b=AXFvmehUqvWgmAijEaStt+aCSiGdbb364k2EzKh67ktuGnrJlA7J56zQlRpeEereshnM
 4ds9IfY053aIy6FwVBvyefxPpPKbxsswu5mK2s5+wmwIedmdoYHZRiovbCIUW06XUSbn
 4O4ld/G22W4FMSURAFibeLWWZld3aIk5cN8YAV3uW+8M2IU8OBtdD2FaFtSLrj+EuIXs
 yUB4AQXxnwSravd6ko1xEbqdkPfBKQTSBHbDkWxzxTFnzQV4Mlnu1aM7kS+IV8hbTSNe
 3ptJnBFFMCJVprjQ0tmeThdTtMjNU5XLeps0z+o6qg2AbOTiIzNynmxSBOluG82rvIps YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vxwrnsrb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 13:30:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ACBAA100034;
        Thu, 31 Oct 2019 13:30:50 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98F0E2B7837;
        Thu, 31 Oct 2019 13:30:50 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 13:30:50 +0100
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct 2019 13:30:50
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
Subject: [PATCH 1/4] dt-bindings: counter: Convert stm32 counter bindings to json-schema
Date:   Thu, 31 Oct 2019 13:30:37 +0100
Message-ID: <20191031123040.26316-2-benjamin.gaignard@st.com>
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

Convert the STM32 counter binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/counter/st,stm32-timer-cnt.yaml       | 38 ++++++++++++++++++++++
 .../bindings/counter/stm32-timer-cnt.txt           | 31 ------------------
 2 files changed, 38 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml
 delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

diff --git a/Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml b/Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml
new file mode 100644
index 000000000000..56192d613601
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/st,stm32-timer-cnt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Timers quadrature bindings
+
+description:
+  STM32 Timer provides quadrature encoder to detect angular position
+  and direction of rotary elements, from IN1 and IN2 input signals.
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+properties:
+  counter:
+    type: object
+
+    description:
+      must be a sub-node of an STM32 Timer device tree node
+
+    properties:
+      compatible:
+        const: st,stm32-timer-counter
+            
+    required:
+      - compatible
+
+examples:
+  - |
+    counter {
+      compatible = "st,stm32-timer-counter";
+    };
+
+...
+
diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
deleted file mode 100644
index c52fcdd4bf6c..000000000000
--- a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-STMicroelectronics STM32 Timer quadrature encoder
-
-STM32 Timer provides quadrature encoder to detect
-angular position and direction of rotary elements,
-from IN1 and IN2 input signals.
-
-Must be a sub-node of an STM32 Timer device tree node.
-See ../mfd/stm32-timers.txt for details about the parent node.
-
-Required properties:
-- compatible:		Must be "st,stm32-timer-counter".
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
-			to set CH1/CH2 pins in mode of operation for STM32
-			Timer input on external pin.
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
-		counter {
-			compatible = "st,stm32-timer-counter";
-			pinctrl-names = "default";
-			pinctrl-0 = <&tim1_in_pins>;
-		};
-	};
-- 
2.15.0

