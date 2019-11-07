Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E97F3850
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2019 20:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfKGTPH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Nov 2019 14:15:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11972 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbfKGTPH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Nov 2019 14:15:07 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7JCB0Y028444;
        Thu, 7 Nov 2019 20:14:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=BXNhl4d/3xFleZS5uFtYUWRtk9Cxxb8LfL1afLU96e8=;
 b=qeZq0KnUS+9t9T6B8unBZ/JHt/PQOyw5cwhFS+RGavrDoa5gISrgSjHfTZaL5PHO5vH7
 gvBhAz+etc+ziLvkNF/zChF6pVN1eGgKU3YFMS8qKyF49AqGr0gzHcydwqN4D3gA5vFf
 HkoPcSDGjMhoqTIYy1m+cLLwhNnoDxWBkd8mIO6Rf4sLCfquteYH1IMlJpYgIJzdgB4o
 nWv7vuDhOytVPKAT0vitDeb4ETfOpRIlMp+RuapnvyTK6YGonHzjLRI9u7YQgFJsu2cv
 gvmGOg1fW86X1hlWnoqK87+MC+ajd50OeHVRU1HunuhHPBNwb0jtpPSnequPvfLp4JPI KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w41vmqa18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 20:14:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9EECD10002A;
        Thu,  7 Nov 2019 20:14:32 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 678B72B188E;
        Thu,  7 Nov 2019 20:14:32 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 7 Nov 2019
 20:14:32 +0100
Received: from localhost (10.129.6.249) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 7 Nov 2019 20:14:31
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
Subject: [PATCH v2] dt-bindings: mfd: Convert stm32 timers bindings to json-schema
Date:   Thu, 7 Nov 2019 20:14:25 +0100
Message-ID: <20191107191425.22273-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.249]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the STM32 timers binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- merge all (mfd, iio, pwm, counter) bindings in one file
- fix typo and trailing spaces
- rework dmas and dma-names properties to allow schemas like:
  ch1 , ch2, ch4
  ch2, up, com
- use patternProperties to describe timer subnode
- improve st,breakinput property definition to be able to check the values
  inside de tuple
 .../bindings/counter/stm32-timer-cnt.txt           |  31 -----
 .../bindings/iio/timer/stm32-timer-trigger.txt     |  25 ----
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 155 +++++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt       |  73 ----------
 .../devicetree/bindings/pwm/pwm-stm32.txt          |  38 -----
 5 files changed, 155 insertions(+), 167 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

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
diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
new file mode 100644
index 000000000000..e8bd80038fa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/st,stm32-timers.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Timers bindings
+
+description: |
+  This hardware block provides 3 types of timer along with PWM functionality:
+    - advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
+      prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
+    - general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
+      programmable prescaler and PWM outputs.
+    - basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+properties:
+  compatible:
+    const: st,stm32-timers
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: int
+
+  reset:
+    maxItems: 1
+
+  dmas:
+    minItems: 1
+    maxItems: 7
+
+  dma-names:
+    items:
+      - enum: [ ch1, ch2, ch3, ch4, up, trig, com ]
+    minItems: 1
+    maxItems: 7
+    additionalItems: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  pwm:
+    type: object
+
+    properties:
+      compatible:
+        const: st,stm32-pwm
+
+      "#pwm-cells":
+        const: 3
+
+      st,breakinput:
+        description: |
+          One or two <index level filter> to describe break input configurations.
+
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-matrix
+          - items:
+              items:
+                - description: |
+                    "index" indicates on which break input (0 or 1) the configuration should be applied.
+                  enum: [ 0 , 1]
+                - description: |
+                    "level" gives the active level (0=low or 1=high) of the input signal for this configuration
+                  enum: [ 0, 1 ]
+                - description: |
+                    "filter" gives the filtering value (up to 15) to be applied.
+                  maximum: 15
+
+    required:
+      - "#pwm-cells"
+      - compatible
+
+patternProperties:
+  "^timer@[0-9]+$":
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - st,stm32-timer-trigger
+          - st,stm32h7-timer-trigger
+
+      reg:
+        maxItems: 1
+        description: identify trigger hardware block.
+
+    required:
+      - compatible
+      - reg
+
+  counter:
+    type: object
+
+    properties:
+      compatible:
+        const: st,stm32-timer-counter
+
+    required:
+      - compatible
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    timers2: timers@40000000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "st,stm32-timers";
+      reg = <0x40000000 0x400>;
+      clocks = <&rcc TIM2_K>;
+      clock-names = "int";
+      dmas = <&dmamux1 18 0x400 0x1>,
+             <&dmamux1 19 0x400 0x1>,
+             <&dmamux1 20 0x400 0x1>,
+             <&dmamux1 21 0x400 0x1>,
+             <&dmamux1 22 0x400 0x1>;
+      dma-names = "ch1", "ch2", "ch3", "ch4", "up";
+      pwm {
+        compatible = "st,stm32-pwm";
+        #pwm-cells = <3>;
+        st,breakinput = <0 1 5>;
+      };
+      timer@0 {
+        compatible = "st,stm32-timer-trigger";
+        reg = <0>;
+      };
+      counter {
+        compatible = "st,stm32-timer-counter";
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
deleted file mode 100644
index 15c3b87f51d9..000000000000
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-STM32 Timers driver bindings
-
-This IP provides 3 types of timer along with PWM functionality:
-- advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
-  prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
-- general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
-  programmable prescaler and PWM outputs.
-- basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
-
-Required parameters:
-- compatible: must be "st,stm32-timers"
-
-- reg:			Physical base address and length of the controller's
-			registers.
-- clock-names:		Set to "int".
-- clocks: 		Phandle to the clock used by the timer module.
-			For Clk properties, please refer to ../clock/clock-bindings.txt
-
-Optional parameters:
-- resets:		Phandle to the parent reset controller.
-			See ../reset/st,stm32-rcc.txt
-- dmas:			List of phandle to dma channels that can be used for
-			this timer instance. There may be up to 7 dma channels.
-- dma-names:		List of dma names. Must match 'dmas' property. Valid
-			names are: "ch1", "ch2", "ch3", "ch4", "up", "trig",
-			"com".
-
-Optional subnodes:
-- pwm:			See ../pwm/pwm-stm32.txt
-- timer:		See ../iio/timer/stm32-timer-trigger.txt
-- counter:		See ../counter/stm32-timer-cnt.txt
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
-		pwm {
-			compatible = "st,stm32-pwm";
-			pinctrl-0	= <&pwm1_pins>;
-			pinctrl-names	= "default";
-		};
-
-		timer@0 {
-			compatible = "st,stm32-timer-trigger";
-			reg = <0>;
-		};
-
-		counter {
-			compatible = "st,stm32-timer-counter";
-			pinctrl-names = "default";
-			pinctrl-0 = <&tim1_in_pins>;
-		};
-	};
-
-Example with all dmas:
-	timer@40010000 {
-		...
-		dmas = <&dmamux1 11 0x400 0x0>,
-		       <&dmamux1 12 0x400 0x0>,
-		       <&dmamux1 13 0x400 0x0>,
-		       <&dmamux1 14 0x400 0x0>,
-		       <&dmamux1 15 0x400 0x0>,
-		       <&dmamux1 16 0x400 0x0>,
-		       <&dmamux1 17 0x400 0x0>;
-		dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig", "com";
-		...
-		child nodes...
-	};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
deleted file mode 100644
index a8690bfa5e1f..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-STMicroelectronics STM32 Timers PWM bindings
-
-Must be a sub-node of an STM32 Timers device tree node.
-See ../mfd/stm32-timers.txt for details about the parent node.
-
-Required parameters:
-- compatible:		Must be "st,stm32-pwm".
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
-			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
-- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
-			bindings defined in pwm.txt.
-
-Optional parameters:
-- st,breakinput:	One or two <index level filter> to describe break input configurations.
-			"index" indicates on which break input (0 or 1) the configuration
-			should be applied.
-			"level" gives the active level (0=low or 1=high) of the input signal
-			for this configuration.
-			"filter" gives the filtering value to be applied.
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
-		pwm {
-			compatible = "st,stm32-pwm";
-			#pwm-cells = <3>;
-			pinctrl-0	= <&pwm1_pins>;
-			pinctrl-names	= "default";
-			st,breakinput = <0 1 5>;
-		};
-	};
-- 
2.15.0

