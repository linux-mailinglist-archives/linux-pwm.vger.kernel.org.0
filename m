Return-Path: <linux-pwm+bounces-7258-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D5AB471A2
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 17:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0463A32D1
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753A25A326;
	Sat,  6 Sep 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoyZjQYj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989171F460B;
	Sat,  6 Sep 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170803; cv=none; b=LwhMehrLn/N+uoR21urBCqhkUlnZFQuHtDf3lszekOXXQ+2u/KvRpTUoJGuoSfljNJWzvriCESEqctwdIbuZckrlFXxF2S2aw53OgPV1T4ix9FZgBDR+0foAnDs0TObzPuGKQe24uH+qEOcWmBowpD/+pyI6JxTnmLE+3tvV56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170803; c=relaxed/simple;
	bh=tfBwefHQdd41/cbOVfQ5bevnktvEzMDG0Q2xvCwvuJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUosnnY0e1xG8pnXvj4y1uxdQpPhWMfZONBZSjYjbRSrDw4keeFKAY1SWkBahYFK2i0DRglyBUn5LrME59Ev1o3GDc+AmWWmsdNYkifasY6Ul3AFIo6IpuJS4+JtKiBbWnzAvQfzgSGoZJYYYTHV4VWL4NcZjJd2G5CMBl9Jq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoyZjQYj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb5492350so19575685e9.1;
        Sat, 06 Sep 2025 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757170799; x=1757775599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv+v5PCgJuqVLW5ARhT6YKPko1T4XvuwmtHAjKnSEyA=;
        b=GoyZjQYj6p2GS1wHIede9cCiCcCtdT+OA128u4xwgbib59HYsMTeJAgXO/fJxmd5ka
         N08vFWpLVeYaX8gQPet+T8SW2azNHadG9ciogWHlCqhrk4KBps8STCERLlgg/i/8c8kG
         NkQ+7+TM9g+2Rmsg+h0i7bXVOyKs79WkIrSpA7oVmpPeNIXKlM4ePQRi5Kp8Jj+mTjSe
         3lnOkawQEGJkNDoE58Y9j98Gzipg5GFOtEqruo5tst3wjRdNptaYo1jZIDSQsTrk1aE4
         Az6V5uRPWFfETyKRp7ME/9FVcGuRnyYNf3hvod2Co+ml7BYI6+Lsx6hgb5Bwsu7fwjWu
         vODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757170799; x=1757775599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv+v5PCgJuqVLW5ARhT6YKPko1T4XvuwmtHAjKnSEyA=;
        b=KAMzWIho3z9kL5UpR4AUfe68VaaHv3Joi3NhmBAkpwrm7DFUnbfI3R0IibrZfuWXtr
         nO5BqA+jN2LDP/0/w57VW3h06GOcDjtNLtKbDgBiekVvelNypElAhfoNfwWsvmwXNc3k
         y+NzVl92l2eE4UAtsZNBTtm4M/trqSQBrkIBI1/9zyd2XNq00BJqMaxhTUZHxNfJ6NBu
         1X9xOY25qUHPW22zSd0bYbsRd/H8RlCWyQ0v2eY52cXkelE06W2/xEy3GaNHcGbkkbNI
         nBEsljK8ar/4Wf3LNIr9NOtkQ3x2dihEfx71c2fg3PKohq/K46u2oEe2SfeRgZYsyDvU
         WHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6iRhpapUSX0fG0oxbnCD54n6O87dG/jn3n24+SqGSlg/ww8ALrpzTo9BmqgGkeZVdU1XNY6UYixKR@vger.kernel.org, AJvYcCV0Vh3p5wT6gX5UBp7FO3Udm6rh3YhbELYZw2uZyA6iieFw5GxnbM0kIObqjDtYCmpa1Hqe1C6GHD/6@vger.kernel.org, AJvYcCXP5Z/KLR7EvEDavZKZFDS7UAkHoAp8XVDkuLVlh+zQjDSRIFgNRk5gc/0UKX5Savs1b+dfJNuYULmehh8J@vger.kernel.org, AJvYcCXs8YTIMiYLCIPMK1B4ePmE2LYcJ7pYYPV/bAAlg/fP1yO2KTU0bBjxa+UaqmKgzh2yb4SUrQxUnPuOEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcZ+5tbvCoNa3Kwi5GdEoytgLeN0voGehKn2Ic7q7tP/8FqWz
	/8vE/ECUm9fS0l7JYnzUzGaTZ2eAN5CnV3MuI4SfP/R7iNrxx4URrqkTq3s81/E=
X-Gm-Gg: ASbGnct7pB+StqsLmqVelLuPFMOO1q0Vnwhx3YsWMfvT0S3CH+u5rUCj9RXkTXpaKGI
	vJ58DnKCK05iqa+YjFCLCki2DO0se1U7W2ZllWkxDKXTt0uOSY3ZTCeHAg8EnlZp7Ebn3/XZGPt
	BZY8nkDANfxDnNendg98I98txeXkcSZv3eN1Umha0RKEcTwPpfNewaYGGHaL3Zpn+SuW/0inHOz
	nA2yYl4YVTlH29hO4f2DqCNFKhcdQ0nk4bxQeXu5hHV800rpQWMdnkETH/DbTCEFXGlhdk8C6hT
	yz/RX1CTmLJm9WYtzPuQ9ihVs+4QWydpz2cS296WKs4g24k5gC5ULn4mwjVwdHXQiCeTap9cupw
	FzTXrIdUJlFm7jB0g/sTb6/RmMEqpCHEY5tHAs77B3lPwJRI=
X-Google-Smtp-Source: AGHT+IE5xG19n3sDe4WdqeKJ/9P9DTDKtYu9TlLm45KSc/s68L2fMTuPukD9d2kyAlBWWlf3osUSCA==
X-Received: by 2002:a05:600c:3b21:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-45dddeb8ee7mr21095305e9.11.1757170798445;
        Sat, 06 Sep 2025 07:59:58 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:143f:cf9:d8da:f38a:fb6d:ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm35106544f8f.50.2025.09.06.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:59:58 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: robh@kernel.org,
	andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v6 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
Date: Sat,  6 Sep 2025 16:59:03 +0200
Message-Id: <20250906145905.93845-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
References: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
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
Changes in v6:
  - Refactored the ti,twl4030-power compatible schema to be much stricter,
    removing obsolete board-specific compatibles (-n900, -beagleboard-xm),
    that were added in v5. The schema now only permits specific, valid
    fallback combinations. This change is supported by subsequent patches
    in the same series (2/3) & (3/3), which update the affected DTS files.
  - Enforced the presence of the compatible property on all relevant
    sub-nodes by adding 'required: - compatible', closing a key validation
    loophole.
  - Applied various formatting cleanups for readability and correctness.

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
 .../devicetree/bindings/mfd/ti,twl.yaml       | 221 +++++++++++++++++-
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 4 files changed, 210 insertions(+), 93 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index f162ab60c09..cfabd6f31ce 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -9,11 +9,13 @@ title: Texas Instruments TWL family
 maintainers:
   - Andreas Kemnade <andreas@kemnade.info>
 
-description: |
+description: >
   The TWLs are Integrated Power Management Chips.
-  Some version might contain much more analog function like
+
+  Some versions might contain much more analog functionality like
   USB transceiver or Audio amplifier.
-  These chips are connected to an i2c bus.
+
+  These chips are connected to an I2C bus.
 
 allOf:
   - if:
@@ -62,6 +64,7 @@ allOf:
         pwrbutton:
           type: object
           additionalProperties: false
+
           properties:
             compatible:
               const: ti,twl4030-pwrbutton
@@ -73,9 +76,11 @@ allOf:
         watchdog:
           type: object
           additionalProperties: false
+
           properties:
             compatible:
               const: ti,twl4030-wdt
+
   - if:
       properties:
         compatible:
@@ -107,14 +112,18 @@ allOf:
       properties:
         charger:
           type: object
+
           properties:
             compatible:
               const: ti,twl6030-charger
+
         gpadc:
           type: object
+
           properties:
             compatible:
               const: ti,twl6030-gpadc
+
   - if:
       properties:
         compatible:
@@ -143,22 +152,26 @@ allOf:
       properties:
         charger:
           type: object
+
           properties:
             compatible:
               items:
                 - const: ti,twl6032-charger
                 - const: ti,twl6030-charger
+
         gpadc:
           type: object
+
           properties:
             compatible:
               const: ti,twl6032-gpadc
 
 properties:
   compatible:
-    description:
-      TWL4030 for integrated power-management/audio CODEC device used in OMAP3
-      based boards
+    description: >
+      TWL4030 for integrated power-management/audio CODEC device used in
+      OMAP3 based boards.
+
       TWL6030/32 for integrated power-management used in OMAP4 based boards
     enum:
       - ti,twl4030
@@ -181,28 +194,189 @@ properties:
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
+
     properties:
       compatible: true
+
     required:
       - compatible
 
   rtc:
     type: object
     additionalProperties: false
+
     properties:
       compatible:
         const: ti,twl4030-rtc
       interrupts:
         maxItems: 1
 
+  audio:
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: ti,twl4030-audio
+
+    required:
+      - compatible
+
+  keypad:
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: ti,twl4030-keypad
+
+    required:
+      - compatible
+
+  pwm:
+    type: object
+    $ref: /schemas/pwm/pwm.yaml#
+    unevaluatedProperties: false
+    description:
+      PWM controllers (PWM1 and PWM2 on TWL4030, PWM0 and PWM1 on TWL6030/32).
+
+    properties:
+      compatible:
+        enum:
+          - ti,twl4030-pwm
+          - ti,twl6030-pwm
+
+      '#pwm-cells':
+        const: 2
+
+    required:
+      - compatible
+      - '#pwm-cells'
+
+  pwmled:
+    type: object
+    $ref: /schemas/pwm/pwm.yaml#
+    unevaluatedProperties: false
+    description: >
+      PWM controllers connected to LED terminals (PWMA and PWMB on TWL4030.
+
+      LED PWM on TWL6030/32, mainly used as charging indicator LED).
+
+    properties:
+      compatible:
+        enum:
+          - ti,twl4030-pwmled
+          - ti,twl6030-pwmled
+
+      '#pwm-cells':
+        const: 2
+
+    required:
+      - compatible
+      - '#pwm-cells'
+
+  twl4030-usb:
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: ti,twl4030-usb
+
+    required:
+      - compatible
+
+  usb-comparator:
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: ti,twl6030-usb
+
+    required:
+      - compatible
+
+  gpio:
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: ti,twl4030-gpio
+
+    required:
+      - compatible
+
+  power:
+    type: object
+    additionalProperties: false
+    description: >
+      The power management module inside the TWL4030 provides several
+      facilities to control the power resources, including power scripts.
+
+      For now, the binding only supports the complete shutdown of the
+      system after poweroff.
+
+      Board-specific compatible strings may be used for platform-specific
+      power configurations.
+
+      A board-specific compatible string (e.g., ti,twl4030-power-omap3-evm)
+      may be paired with a generic fallback (generally for power saving mode).
+
+    properties:
+      compatible:
+        oneOf:
+          # Case 1: A single compatible string is provided.
+          - enum:
+              - ti,twl4030-power
+              - ti,twl4030-power-reset
+              - ti,twl4030-power-idle
+              - ti,twl4030-power-idle-osc-off
+              - ti,twl4030-power-omap3-sdp
+              - ti,twl4030-power-omap3-ldp
+              - ti,twl4030-power-omap3-evm
+
+          # Case 2: The specific, valid fallback for 'idle-osc-off'.
+          - items:
+              - const: ti,twl4030-power-idle-osc-off
+              - const: ti,twl4030-power-idle
+
+          # Case 3: The specific, valid fallback for 'omap3-evm'.
+          - items:
+              - const: ti,twl4030-power-omap3-evm
+              - const: ti,twl4030-power-idle
+
+      ti,system-power-controller:
+        type: boolean
+        deprecated: true
+        description: >
+          DEPRECATED. The standard 'system-power-controller'
+          property on the parent node should be used instead.
+
+      ti,use_poweroff:
+        type: boolean
+        deprecated: true
+        description: DEPRECATED, to be removed.
+
+    required:
+      - compatible
+
 patternProperties:
   "^regulator-":
     type: object
     unevaluatedProperties: false
     $ref: /schemas/regulator/regulator.yaml
+
     properties:
       compatible: true
       regulator-initial-mode:
@@ -211,12 +385,13 @@ patternProperties:
                  # with low power consumption with low load current capability
           - 0x0e # Active mode, the regulator can deliver its nominal output
                  # voltage with full-load current capability
+
       ti,retain-on-reset:
-        description:
-          Does not turn off the supplies during warm
-          reset. Could be needed for VMMC, as TWL6030
-          reset sequence for this signal does not comply
-          with the SD specification.
+        description: >
+          Does not turn off the supplies during warm reset.
+
+          Could be needed for VMMC, as TWL6030 reset sequence for
+          this signal does not comply with the SD specification.
         type: boolean
 
 unevaluatedProperties: false
@@ -271,6 +446,16 @@ examples:
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
 
@@ -325,6 +510,20 @@ examples:
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


