Return-Path: <linux-pwm+bounces-7243-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F07B40F5E
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 23:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98463A45AD
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF3D350844;
	Tue,  2 Sep 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBR7ss7n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7784039;
	Tue,  2 Sep 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848570; cv=none; b=ju2MAd+vvTVz74PA9cpj/WOmKzMuwFZb3+xNoIuiyznt9YNxuleI36gAvFI0YjOi9eXjyfeJtL6t71eovpc7ZmA0x3zrGgGqb3JNJwHixbtY5nUj6WTphyytU9Uk/1zNlgfrBqk+uM8zketp5vt4ZMZ5xzqEdZ+3HcuMIobyVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848570; c=relaxed/simple;
	bh=EZxlGKTX0H5kessk/Ht2RwHDcD9Badc1OzG0bs1xumA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQJiCq8s/v7TjC+MWmxvVtrxA2FQEINMCnwmbbQOTbLVdaHtVXZi61fyRFzIQdop1kfD1f6N4SDrqR09HntAxOuYtJyxKlvmLrhOHMdpS3KYFokHEaGV7Nv6r08Li6xiSw+MHcA/TuMvfAsyGVCu28h7TZGkAd8RFkvJm5FK+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBR7ss7n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so16956155e9.2;
        Tue, 02 Sep 2025 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848567; x=1757453367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zO4HjeCrOISXZJlWiM9FBrdzfDeCFxXx2k4+Z/Wy3RM=;
        b=WBR7ss7nhYMl1zks75dGBDQViN6lS4viADkmki+GjuSWCRX8tW6O/E7AVaVRLP08k5
         7Q0hWWfpkoh1DSXLVuppctrYBRoDoZ/qafJgJ5LuimU6utCpCdjadscTMUI4sid2j4n0
         +6M0c6aEW7pV85Ul707lqFWP06TGbRRTG6lNUBkyILgDl5oQ6o9Lw2e/r1s86MHP1x7X
         jWgQEAh64Ja+UmHhqkA96tWNt0WTmH6gohqt/crry3b2cbNBqNLstXap/rhAwMKDLgA2
         uHoebMO8KMgVFEq+EANQfd950FmVR5Mt9xPaWqatgB6a1BfYuB+xz60PBaYdaA+mA2rO
         +7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848567; x=1757453367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO4HjeCrOISXZJlWiM9FBrdzfDeCFxXx2k4+Z/Wy3RM=;
        b=MVZMBu/ibgH8Ib7GHJvR/RR5hfHlZboijMb1qsZsSPLYfSf36+n8JBIkXKFyuPqlfu
         k/2fNt+EenA6/APd4y3JlZwcPDRUwZnUuilh6ovEo0nu1eKd7OGSQp6AMmCfcyigYPkH
         6DUnu9QaC/s8VMKPWpJXfp98zCvcga3oyHmEE5adayJorb4BgGCMeeE/DAkAVoBiBp27
         CgEoQnQrljm4H4d2+rq5oR/1YMsOQoyTGVffU9i9FDl08WGVcq5YxUDsugXrWNz8KNX2
         efEffrnoIaAxUQyTqJavcc+cN1lzit6DFyxqpUhBm8fdfd9jVJHggeIQLhPjdarIExn1
         XBvw==
X-Forwarded-Encrypted: i=1; AJvYcCVHxboSJzDSunwUzaLXGHr3W8HSkyzXQfZorQkYiZ1AifqCKatVY5vKc2/FVtHgoi1OQqTrWpBxsRXGBC0t@vger.kernel.org, AJvYcCVi6Gn3qH8/xoZdUSBYjDwawC2cPfP9zMgZ9PvTbeHrP86nZCdujjMHCd8WHaXwEKWbZgR8qDic+GKC@vger.kernel.org, AJvYcCWeBPph9bDS1X75mjqw+jveGwoMMS064hSLU0BH8k2pQJ/DapS1JY2EKezkJTYr235XzA0M9ltN3CaY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66x0O6tFG0eJBatHtmHL6tasIEA4JK8f4ecRYmH6DsHuG+Sk6
	Fo5CN96e3NKEfE9lB6F0omPEB1WBTe7GYZNDzi/cEoFu/E4u0V92wUY=
X-Gm-Gg: ASbGncuIfUl/OaCVs9uA1xCeALeX7Wlk6jndWLUvgfMPSQDKzgNo2enaoBH2xU2QTES
	p8Cahs34ma0rDz47jdShSxlSDm8aEv/4QXali0oDuSKglrmb9j5EVsE9x5DQSTURq9JJ6tycvr+
	/sHt62rQ8w9DhjKFy/tnSSlV7n+kWh3993aiKCrWKpKmZwit0WiKi65ocad06DXtDdppdrfpyaC
	Sd7xRZKIgCNTl4h8X0F0Tx0EYDbzUuijeWc4HzlTqZPb1NtXvNZ0J9MaZjXv02HRRH9jl7iwUHR
	H2Odv6mLduvcyB+hxOU+7IALweCtsQzqIXMueZjx9WSXkWmU8VAaVb5/53R92usqYrx6s4qaSV1
	N3H3HxPXdMjwz9XaPnj2ja1Da+eLdqUkwOyZonQOqUGqEMm0x00w=
X-Google-Smtp-Source: AGHT+IG0deGv61kh0jZMa+aYBded7+4j0TmirKkWGpEYzZqrbh/39kOqDtc9WiBQh75zVmPKyspdYw==
X-Received: by 2002:a05:600c:4fcd:b0:45b:7185:9e5 with SMTP id 5b1f17b1804b1-45b85525cddmr117491975e9.5.1756848566551;
        Tue, 02 Sep 2025 14:29:26 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:7287:75b3:5214:63cf:2c39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm211255195e9.19.2025.09.02.14.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:29:26 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: lee@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andreas@kemnade.info
Cc: conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v5] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
Date: Tue,  2 Sep 2025 23:29:21 +0200
Message-Id: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the main TI TWL-family binding to be self-contained and to fix
pre-existing validation errors.

Following maintainer feedback, the simple power and PWM bindings are
now defined directly within this file, and their legacy .txt files
are removed.

To ensure future patches are bisectable, child nodes whose bindings
are in other patches (audio, keypad, usb, etc.) are now defined using
a flexible 'additionalProperties: true' pattern. This removes hard
dependencies between the MFD and subsystem bindings.

The complete dtbs_check for this binding is clean except for two
warnings originating from pre-existing bugs in the OMAP DTS files,
for which fixes have already been submitted separately [1][2].

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v5:
  - Restructured the entire binding to define properties at the top
    level instead of if/then blocks, per maintainer feedback.
  - Added specific compatible enums for new child nodes instead of a
    generic 'compatible: true'.
  - Set 'unevaluatedProperties: false' for 'pwm' and 'pwmled' nodes to
    enforce strict validation.
  - Expanded 'power' node compatible enum to include all board-specific
    compatible strings (used in existing device trees, e.g. OMAP3-based
    boards) for more complete coverage.
  - Corrected the schema for the 'power' node compatible to properly
    handle single and fallback entries.

Changes in v4:
  - Reworked binding to be independent and bisectable per maintainer
    feedback by using 'additionalProperties: true' for child nodes.
  - Added board-specific compatibles to the 'power' node enum.
  - Added definitions for 'clocks' and 'clock-names' properties.
  - Renamed 'twl6030-usb' child node to 'usb-comparator' to match
    existing Device Tree usage (twl6030.dtsi).
  - Fixed some spelling/grammar erros in the description.

Changes in v3:
  - New patch to consolidate simple bindings (power, pwm) and add
    definitions for all child nodes to fix dtbs_check validation
    errors found in v2.

Changes in v2:
  - This patch is split from larger series [3] per maintainer feedback.
  - Added missing sub-node definitions, resolving dtbs_check errors.

[1] https://lore.kernel.org/all/20250822222530.113520-1-jihed.chaibi.dev@gmail.com/
[2] https://lore.kernel.org/all/20250822225052.136919-1-jihed.chaibi.dev@gmail.com/
[3] https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
---
 .../devicetree/bindings/mfd/ti,twl.yaml       | 159 +++++++++++++++++-
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 ------
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 4 files changed, 157 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index f162ab60c09..397eed9b628 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -11,9 +11,9 @@ maintainers:
 
 description: |
   The TWLs are Integrated Power Management Chips.
-  Some version might contain much more analog function like
+  Some versions might contain much more analog functionality like
   USB transceiver or Audio amplifier.
-  These chips are connected to an i2c bus.
+  These chips are connected to an I2C bus.
 
 allOf:
   - if:
@@ -181,6 +181,12 @@ properties:
   "#clock-cells":
     const: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
   charger:
     type: object
     additionalProperties: true
@@ -198,6 +204,131 @@ properties:
       interrupts:
         maxItems: 1
 
+  audio:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: ti,twl4030-audio
+
+  keypad:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: ti,twl4030-keypad
+
+  pwm:
+    type: object
+    $ref: /schemas/pwm/pwm.yaml#
+    unevaluatedProperties: false
+    description:
+      PWM controllers (PWM1 and PWM2 on TWL4030, PWM0 and PWM1 on TWL6030/32).
+    properties:
+      compatible:
+        enum:
+          - ti,twl4030-pwm
+          - ti,twl6030-pwm
+      '#pwm-cells':
+        const: 2
+    required:
+      - compatible
+      - '#pwm-cells'
+
+  pwmled:
+    type: object
+    $ref: /schemas/pwm/pwm.yaml#
+    unevaluatedProperties: false
+    description:
+      PWM controllers connected to LED terminals (PWMA and PWMB on TWL4030,
+      LED PWM on TWL6030/32, mainly used as charging indicator LED).
+    properties:
+      compatible:
+        enum:
+          - ti,twl4030-pwmled
+          - ti,twl6030-pwmled
+      '#pwm-cells':
+        const: 2
+    required:
+      - compatible
+      - '#pwm-cells'
+
+  twl4030-usb:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: ti,twl4030-usb
+
+  usb-comparator:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: ti,twl6030-usb
+
+  gpio:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: ti,twl4030-gpio
+
+  power:
+    type: object
+    description:
+      The power management module inside the TWL4030 provides several
+      facilities to control the power resources, including power scripts.
+      For now, the binding only supports the complete shutdown of the
+      system after poweroff.
+      Board-specific compatible strings may be used for platform-specific
+      power configurations.
+      A board-specific compatible string (e.g., ti,twl4030-power-n900) may
+      be paired with a generic fallback (generally for power saving mode).
+    additionalProperties: false
+    properties:
+      compatible:
+        oneOf:
+          - enum:
+              - ti,twl4030-power
+              - ti,twl4030-power-reset
+              - ti,twl4030-power-idle
+              - ti,twl4030-power-idle-osc-off
+              # Add all board-specific compatibles for completeness
+              - ti,twl4030-power-omap3-sdp
+              - ti,twl4030-power-omap3-ldp
+              - ti,twl4030-power-omap3-evm
+              - ti,twl4030-power-beagleboard-xm
+              - ti,twl4030-power-n900
+          - items:
+              - enum:
+                  - ti,twl4030-power
+                  - ti,twl4030-power-reset
+                  - ti,twl4030-power-idle
+                  - ti,twl4030-power-idle-osc-off
+                  # Add all board-specific compatibles for completeness
+                  - ti,twl4030-power-omap3-sdp
+                  - ti,twl4030-power-omap3-ldp
+                  - ti,twl4030-power-omap3-evm
+                  - ti,twl4030-power-beagleboard-xm
+                  - ti,twl4030-power-n900
+              - enum:
+                  # Fallback (for power saving mode)
+                  - ti,twl4030-power-idle
+                  - ti,twl4030-power-idle-osc-off
+      ti,system-power-controller:
+        type: boolean
+        deprecated: true
+        description:
+          DEPRECATED. The standard 'system-power-controller'
+          property on the parent node should be used instead.
+      ti,use_poweroff:
+        type: boolean
+        deprecated: true
+        description: DEPRECATED, to be removed.
+    required:
+      - compatible
+
 patternProperties:
   "^regulator-":
     type: object
@@ -271,6 +402,16 @@ examples:
           compatible = "ti,twl6030-vmmc";
           ti,retain-on-reset;
         };
+
+        pwm {
+          compatible = "ti,twl6030-pwm";
+          #pwm-cells = <2>;
+        };
+
+        pwmled {
+          compatible = "ti,twl6030-pwmled";
+          #pwm-cells = <2>;
+        };
       };
     };
 
@@ -325,6 +466,20 @@ examples:
         watchdog {
           compatible = "ti,twl4030-wdt";
         };
+
+        power {
+          compatible = "ti,twl4030-power";
+        };
+
+        pwm {
+          compatible = "ti,twl4030-pwm";
+          #pwm-cells = <2>;
+        };
+
+        pwmled {
+          compatible = "ti,twl4030-pwmled";
+          #pwm-cells = <2>;
+        };
       };
     };
 ...
diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
deleted file mode 100644
index 3d19963312c..00000000000
--- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Texas Instruments TWL family (twl4030) reset and power management module
-
-The power management module inside the TWL family provides several facilities
-to control the power resources, including power scripts. For now, the
-binding only supports the complete shutdown of the system after poweroff.
-
-Required properties:
-- compatible : must be one of the following
-	"ti,twl4030-power"
-	"ti,twl4030-power-reset"
-	"ti,twl4030-power-idle"
-	"ti,twl4030-power-idle-osc-off"
-
-The use of ti,twl4030-power-reset is recommended at least on
-3530 that needs a special configuration for warm reset to work.
-
-When using ti,twl4030-power-idle, the TI recommended configuration
-for idle modes is loaded to the tlw4030 PMIC.
-
-When using ti,twl4030-power-idle-osc-off, the TI recommended
-configuration is used with the external oscillator being shut
-down during off-idle. Note that this does not work on all boards
-depending on how the external oscillator is wired.
-
-Optional properties:
-
-- ti,system-power-controller: This indicates that TWL4030 is the
-  power supply master of the system. With this flag, the chip will
-  initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
-  system poweroffs.
-
-- ti,use_poweroff: Deprecated name for ti,system-power-controller
-
-Example:
-&i2c1 {
-	clock-frequency = <2600000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
-
-		twl_power: power {
-			compatible = "ti,twl4030-power";
-			ti,use_poweroff;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
deleted file mode 100644
index d97ca1964e9..00000000000
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Texas Instruments TWL series PWM drivers
-
-Supported PWMs:
-On TWL4030 series: PWM1 and PWM2
-On TWL6030 series: PWM0 and PWM1
-
-Required properties:
-- compatible: "ti,twl4030-pwm" or "ti,twl6030-pwm"
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Example:
-
-twl_pwm: pwm {
-	compatible = "ti,twl6030-pwm";
-	#pwm-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
deleted file mode 100644
index 31ca1b032ef..00000000000
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Texas Instruments TWL series PWM drivers connected to LED terminals
-
-Supported PWMs:
-On TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
-On TWL6030 series: LED PWM (mainly used as charging indicator LED)
-
-Required properties:
-- compatible: "ti,twl4030-pwmled" or "ti,twl6030-pwmled"
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Example:
-
-twl_pwmled: pwmled {
-	compatible = "ti,twl6030-pwmled";
-	#pwm-cells = <2>;
-};
-- 
2.39.5


