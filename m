Return-Path: <linux-pwm+bounces-7285-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EEB51D00
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 18:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B798189974B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBB33436F;
	Wed, 10 Sep 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjXQePhb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DE32A3EB;
	Wed, 10 Sep 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520447; cv=none; b=A4kx23Spwlz9jYup9dkI8azDy9uEqqxr8aPqojw3jhtyK41BInu2/yXsWKmnYB6NPBG8AUlIM4h1SdgtmpqmfOMqvbmMU3ZMAYL4/gwCasY4DgDobLM7Ojk6VWKPFMa0HsTXZcOCsE0wbpDWsE/j/1u6iVUMOV4CcQCb+Qx9DD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520447; c=relaxed/simple;
	bh=/e8n5H4jLC4oGzsgHKArwQGuc0Gh6y2AWir2r045kTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8DFoV9iYxfjtUndzXy3woWrgS0VEDpFc534OxUJkUyfNwenvDEeqaXIPQnezj19swoRB7FNV6oZzBdeKOOGfCSX5DiE8s5H+IuQqON1E1zCO/v/i/jSheIDw6svjReZmEsoqqoEhUduxmquwxdYYxZdE9KxQfWss7Ho0IS5rRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjXQePhb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b04ba3de760so550598166b.0;
        Wed, 10 Sep 2025 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520443; x=1758125243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRisyiGscdAE+KyEXvBVirtkrFqew6hVc6V464yXVdo=;
        b=bjXQePhbhq8gmmC/fUFPa5KS14mytzpLKHPz0A2MzS8OEilEUWudCBNwyEsdr4vNl7
         Z+BK/dOZGlwN8CwondoIW3zmrz94928X7sTnTYsmEswmwWE15t6oXteaEJ7yjg+BOPkL
         7Sj/HpvQvouZhNJ9VCuLv4gzPM5UShqvOZYx1YUKezYwMgRjTRpygKiFCfhyccsOv8QY
         pLc41QhXsKIri1oezVTmKQknoRPY9vnMaIh5nKa7P34iDF5BSj8eKT3lzdxnm57iaKtU
         s93wFWmnNrQCaxYF2BYei4YxbitU+nBF/eQABLgpTVTICwTZNWNkQISTdwvQU+OG+ehx
         xSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520443; x=1758125243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRisyiGscdAE+KyEXvBVirtkrFqew6hVc6V464yXVdo=;
        b=Vqu0HmW13oOqX/j50qyKO3TgttF3oF3Yl/fe2mYZcL+LyMpq2gXk6604GJYHHDii0t
         /Q6LrbMnDhEgTdy8s5Rg17v/m6NcoQflNAeclWmvLy8y1MtUUUbkm8IAWMf5AeFtSAjS
         kkM0Xe0r+dBG5b5xSIPpotw0sIZA/5E9PBGNRh6smauog9itqRGmEj+LwUie/F9WjG4z
         XWqmr8/n85rpe7/UdohTFMYinX/KZ0hF6HH5ueSuODH/2GgmKFHxX8w81xDTUhnUDtxK
         c3O7xiFwo7Hn+9qFXcbpWil4jvS/sbWCpPkfFJu6uI4ZLMSIoJs0DJ3SBJ+QzbP4WHM8
         w7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMkx/l/7OnHGZH+Gn3efOZtl7Th9kMFbZHx2emLtDC0CgvWdGo8LNqSeR8HczHGfXB3qy8Gjv/NROZ@vger.kernel.org, AJvYcCUmpsmgtCXGl6r1Ec8rm/hgp7rnBSBERUcY36PLznldjDVP9QeMWxv+MlXqbLp/BlWQmL6UloOMKFlnuqkH@vger.kernel.org, AJvYcCW++0XoFeIjJiz9bplzjtjeJ16m9eELS3HOUfWdEoY+sRnxq9VwlN9/CmXfsSAz/f7eQ3cmTWIFoE7/0A==@vger.kernel.org, AJvYcCWwMdzU66OYRvuWFvODhqg8PUGciasu4BN2ez+RlkSJ4mB55lt2iGFT/y0p+jW0Q3A178JDGsjQHEU2@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxt5nptvTU4QWaxmv8GM1TTGq2M1flA58X1IOkXl+Kq4s9tXh
	S5W1mwH/N+U/9p5vP2+vyFe9A3vD3iWTYFsr1HX7f3oGNqmhVpI99+s=
X-Gm-Gg: ASbGncvAo+zb4U+uHH32y0p2Dthvhd1vJjr0bTFbe8q7UXhNYU15Rs3MC717CAb1zoY
	a+7q1N8IqArvVg8gPvUmCj6W51nS1ydftRadygpz/tv6L+SsDukMMa8nt1fd0PqVbEYgapsQkxd
	4m5Th0HDT07kLa+xqoJp32hEvUWa4CSiNmC1qsvIoXTC526mSmqVlJIQC+Xz3GnxpQUEjIlDxZR
	C2ZWgwt7ujaCTRW9MM8c9+cQx9kTM579ufW7CB47WnU8grYLWG/YVKN3bASYe3QSX3usynJ3nBE
	5cPON1LJI9Xtv5LJHU0tmMJ7m4gB6Y6Ci2mKxe9DPf0bq1vGrQqis7yTQiCDn8l6WZIuuge/YY5
	9Vs0ndTus0X2V4veg+zZBxxAzFHPi9pZh9IzOyt5EAGSAdw==
X-Google-Smtp-Source: AGHT+IGp5BnwVcsMKXppu+LEcGVEDArvL+xSJcO6rAeLSMJwPtCJMKwYynqU2zCCDzPvvDotE/aTcw==
X-Received: by 2002:a17:906:7945:b0:af1:f259:254d with SMTP id a640c23a62f3a-b04b1401186mr1316051566b.8.1757520442675;
        Wed, 10 Sep 2025 09:07:22 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:229f:d114:32a:5671:8dbf:7357])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783047b9bsm189424766b.13.2025.09.10.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:07:21 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v7 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
Date: Wed, 10 Sep 2025 18:07:02 +0200
Message-Id: <20250910160704.115565-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the main TI TWL-family binding to be self-contained and to fix
pre-existing validation errors.

To ensure future patches are bisectable, child nodes whose bindings
are in other patches (audio, keypad, usb, etc.) are now defined using
a flexible 'additionalProperties: true' pattern. This removes hard
dependencies between the MFD and subsystem bindings.

The complete dtbs_check for this binding is clean except for two
warnings originating from pre-existing bugs in the OMAP DTS files,
for which fixes have already been submitted separately [1][2].

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v7:
  - Moved twl4030/twl6030-specific child node definitions (audio, usb..)
    into the conditional 'if/then' block to improve schema accuracy.

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
 .../devicetree/bindings/mfd/ti,twl.yaml       | 232 +++++++++++++++++-
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 4 files changed, 221 insertions(+), 93 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index f162ab60c09b..95238a10ecda 100644
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
@@ -73,9 +76,109 @@ allOf:
         watchdog:
           type: object
           additionalProperties: false
+
           properties:
             compatible:
               const: ti,twl4030-wdt
+
+        audio:
+          type: object
+          additionalProperties: true
+
+          properties:
+            compatible:
+              const: ti,twl4030-audio
+
+          required:
+            - compatible
+
+        keypad:
+          type: object
+          additionalProperties: true
+
+          properties:
+            compatible:
+              const: ti,twl4030-keypad
+
+          required:
+            - compatible
+
+        twl4030-usb:
+          type: object
+          additionalProperties: true
+
+          properties:
+            compatible:
+              const: ti,twl4030-usb
+
+          required:
+            - compatible
+
+        gpio:
+          type: object
+          additionalProperties: true
+
+          properties:
+            compatible:
+              const: ti,twl4030-gpio
+
+          required:
+            - compatible
+
+        power:
+          type: object
+          additionalProperties: false
+          description: >
+            The power management module inside the TWL4030 provides several
+            facilities to control the power resources, including power scripts.
+
+            For now, the binding only supports the complete shutdown of the
+            system after poweroff.
+
+            Board-specific compatible strings may be used for platform-specific
+            power configurations.
+
+            A board-specific compatible string (e.g., ti,twl4030-power-omap3-evm)
+            may be paired with a generic fallback (generally for power saving mode).
+
+          properties:
+            compatible:
+              oneOf:
+                # Case 1: A single compatible string is provided.
+                - enum:
+                    - ti,twl4030-power
+                    - ti,twl4030-power-reset
+                    - ti,twl4030-power-idle
+                    - ti,twl4030-power-idle-osc-off
+                    - ti,twl4030-power-omap3-sdp
+                    - ti,twl4030-power-omap3-ldp
+                    - ti,twl4030-power-omap3-evm
+
+                # Case 2: The specific, valid fallback for 'idle-osc-off'.
+                - items:
+                    - const: ti,twl4030-power-idle-osc-off
+                    - const: ti,twl4030-power-idle
+
+                # Case 3: The specific, valid fallback for 'omap3-evm'.
+                - items:
+                    - const: ti,twl4030-power-omap3-evm
+                    - const: ti,twl4030-power-idle
+
+            ti,system-power-controller:
+              type: boolean
+              deprecated: true
+              description: >
+                DEPRECATED. The standard 'system-power-controller'
+                property on the parent node should be used instead.
+
+            ti,use_poweroff:
+              type: boolean
+              deprecated: true
+              description: DEPRECATED, to be removed.
+
+          required:
+            - compatible
+
   - if:
       properties:
         compatible:
@@ -107,14 +210,29 @@ allOf:
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
+        usb-comparator:
+          type: object
+          additionalProperties: true
+
+          properties:
+            compatible:
+              const: ti,twl6030-usb
+
+          required:
+            - compatible
+
   - if:
       properties:
         compatible:
@@ -143,22 +261,37 @@ allOf:
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
 
+        usb-comparator:
+          type: object
+          additionalProperties: true
+
+          properties:
+            compatible:
+              const: ti,twl6030-usb
+
+          required:
+            - compatible
+
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
@@ -181,28 +314,80 @@ properties:
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
 patternProperties:
   "^regulator-":
     type: object
     unevaluatedProperties: false
     $ref: /schemas/regulator/regulator.yaml
+
     properties:
       compatible: true
       regulator-initial-mode:
@@ -211,12 +396,13 @@ patternProperties:
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
@@ -271,6 +457,16 @@ examples:
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
 
@@ -325,6 +521,20 @@ examples:
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
index 3d19963312ce..000000000000
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
index d97ca1964e94..000000000000
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
index 31ca1b032ef0..000000000000
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


