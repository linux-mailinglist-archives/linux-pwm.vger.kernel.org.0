Return-Path: <linux-pwm+bounces-7230-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B889FB3C609
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Aug 2025 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA80A27046
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Aug 2025 00:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417313FFD;
	Sat, 30 Aug 2025 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBGF/BRS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B54A01;
	Sat, 30 Aug 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756512877; cv=none; b=nlAGgk+Pz6zBZKiQb6W9gBrZVKndF7RcXTv1bsMbSK1S5MmkHHDzIMyxM8Ffj3ZYVr7sR0z+dA2KafulAV5eLiCxCjFOzRdoqf/y/2HI+ko9OMtjvKX11FwKHL8uTt/KUN3Cm6KZDRazik8K7AtiHDXetztuzWfz9DRHNDnXj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756512877; c=relaxed/simple;
	bh=QE73XP1t3Hpl0q3HXVv6V0I5PU/txnz2um+0xl9RtUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owP4uxpRSnLinbcQCvt/RiYMHC3+IltJ6SYpyRfbT1jkC3RBxULbXyvs1V9aNbw8NJBby4okzo/4BVVPnu1NSBIl7wbB4wlyyrRnTaRjcpBiGehmbGJ17uL2kkRUqbRD4s7IdCkL+VE1SnYTEWVFqT9vs8uxVPStxcnzfMq8+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBGF/BRS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7f8ea864d63so257706785a.0;
        Fri, 29 Aug 2025 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756512874; x=1757117674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaEiWgDoXcLcKVUYIJtLhSA1br1c7VK/2DaQrhZa+X4=;
        b=KBGF/BRSw8hs69YWY35fCVQVZNnCBd7Epyt9hPXfS2mm6FFZbDUcdhKIeaZlIG0BOt
         BV/t6cpv5gv6cPoSqW+HSHEbjv5018+cMa0pZRIwjrVjCpuOmOWoduSaxrLDebV17xD2
         WsDhVESDQlh0Lz9YNofqRhZTutGJhyRioo5BigT2VIMhCLxKbVs4CZMWLiOYg9oeivgX
         /i3r26rQ093bdMhUjRzrKocVfhNbQXqMPPKbKrjRB7U56zddy2tc+FXu77QLWcr1q+Ie
         DrFNiYjy2DB7Op65LQLBkQkt/i99Q7/ueXiVj1P+qNNIbwPSVyDQv8eVPwissA62b87l
         0TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756512874; x=1757117674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaEiWgDoXcLcKVUYIJtLhSA1br1c7VK/2DaQrhZa+X4=;
        b=LfBR5AqNr5hXcumXSWjHbkHRl6NqgRSC+6r7HnnAhRnIhnu9JZ7vU+A7NR3KVm+eda
         0qy6aYeJrcUDcgfHdOTFtD0+41lMLMm2KiniEVLojf31s3IPTfvqw+xPJr+1yGdRB9d7
         C5IdBZCg7KQ72hAQZuCVfQGq8pPzIqa9Qar04e2ePRPAHyS9x0aMUZCe8xHo111MiLaE
         75zcCZIUHNb4jJMCrXa9ue8whyWkik9XO1nnq3qmfzhqwJJ8Lga7gW0THJILC8b6lOCT
         RB3Lu77WV3oJvWOkxZ0RHmjsSagCdFaQlTkvk/rIifQLJfl2LZ2Y64ZWW0h6B2+OVpWP
         7LIg==
X-Forwarded-Encrypted: i=1; AJvYcCXQmfxHK+VIa6/EdY4Y1+RbiYtNsy4FmRs8Ndit07tdCVzGCUk/pdboa4RZRLKJHCdsiCIZ+v/1VCNCv0Fb@vger.kernel.org, AJvYcCXmhAOrI9k5tzI4Yl046bbkQyZCtICOWI4T01VH0CyONiAUO+/EqgTdYqYlLIlgHm3EBJXfKnLZCyYi@vger.kernel.org, AJvYcCXw2XhCH//OgqbUrdcMyLurxQCzOZEdO3D+R7wwbZLKd9BMI70OPVucSXhUbZAt7zWOLE0DJR/NP94L@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UOFzem0PE7DMysY0XYoLD95TxtfR2IQ2NPZLupcX8ls9MQxH
	rjS+Dl2PBYGjP/rHqcTp9JCdOccRf1VBRyEA/VH7dBXNhlnaTM6LDws=
X-Gm-Gg: ASbGncuS4RyTzYBG8+O/Uh0gb8xyErfzZ/v0liW39UffW4jNx8G4dBTT7z5xUI7r8w/
	3aoThQEM6Xla00nPtptxIdoIBZ2l8jeIj54X1gHh6V6ohYolYOpkmSyGg5xhnUHZzDGZQyOq3yE
	xz/MdZnF5IFhXDku/ign0pDTT/rht9yOmvSc45UgRu5fWWJRjw4kdzmRAdr79EKmW81xUSejEW0
	B9hlZSgWqyayB431UCt+uAIvYS1v/zau2uEfuq4Js+e7i9/UtG9bDTMBXvIvVX2Hc5gcnEQa9Ug
	D/N5TUDfck/B3wQYqX5hTrxnos3+67+pzZqvdx4MgN6TLuZsOHpShgD64v88ciDjM9lzFYRg6I5
	9jk0xWvKuDXBso5t1PyYWuLYGUfTOlDv6BwPDn3utuNJWYk93njTcUvHzKe0YdhQ/DGQA
X-Google-Smtp-Source: AGHT+IGfwEZIn9QX//x8HKT04T1l95pTBpXYwBOE2Qs2FAf+dyofGyL+tBj8/ViosIPosCRV9eLsdA==
X-Received: by 2002:a05:620a:1aa2:b0:7e7:40f1:8d35 with SMTP id af79cd13be357-7ff281d3301mr61236985a.30.1756512873838;
        Fri, 29 Aug 2025 17:14:33 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:145e:e2bf:35d7:e26d:ca60:c76f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc14849559sm268704185a.41.2025.08.29.17.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:14:33 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: lee@kernel.org,
	andreas@kemnade.info
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v4] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
Date: Sat, 30 Aug 2025 02:14:21 +0200
Message-Id: <20250830001421.126707-1-jihed.chaibi.dev@gmail.com>
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
 .../devicetree/bindings/mfd/ti,twl.yaml       | 208 +++++++++++++++++-
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 4 files changed, 206 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index f162ab60c..444e2b2b5 100644
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
@@ -76,6 +76,107 @@ allOf:
           properties:
             compatible:
               const: ti,twl4030-wdt
+
+        audio:
+          type: object
+          properties:
+            compatible: true
+          additionalProperties: true
+
+        keypad:
+          type: object
+          properties:
+            compatible: true
+          additionalProperties: true
+
+        pwm:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          description: PWM1 and PWM2
+          properties:
+            compatible:
+              enum:
+                - ti,twl4030-pwm
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+          additionalProperties: true
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          description: PWMA and PWMB (connected to LEDA & LEDB terminals)
+          properties:
+            compatible:
+              enum:
+                - ti,twl4030-pwmled
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+          additionalProperties: true
+
+        twl4030-usb:
+          type: object
+          properties:
+            compatible: true
+          additionalProperties: true
+
+        gpio:
+          type: object
+          properties:
+            compatible: true
+          additionalProperties: true
+
+        power:
+          type: object
+          additionalProperties: false
+          description:
+            The power management module inside the TWL4030 provides several facilities
+            to control the power resources, including power scripts. For now, the
+            binding only supports the complete shutdown of the system after poweroff.
+          properties:
+            compatible:
+              description: |
+                The compatible string determines the specific power configuration.
+                Multiple compatible strings may be used to specify fallback configurations.
+                "ti,twl4030-power": Standard power control.
+                "ti,twl4030-power-reset": Recommended for OMAP3530 and similar SoCs
+                  that require a special configuration for warm reset to work correctly.
+                "ti,twl4030-power-idle": Loads the TI-recommended configuration for
+                  idle modes into the PMIC.
+                "ti,twl4030-power-idle-osc-off": Uses the recommended idle configuration
+                  but also shuts down the external oscillator. This may not work on all
+                  boards depending on the oscillator wiring.
+                Board-specific compatible strings may also be used.
+              maxItems: 2
+              items:
+                enum:
+                  - ti,twl4030-power
+                  - ti,twl4030-power-reset
+                  - ti,twl4030-power-idle
+                  - ti,twl4030-power-idle-osc-off
+                  - ti,twl4030-power-beagleboard-xm
+                  - ti,twl4030-power-omap3-evm
+                  - ti,twl4030-power-n900
+
+            ti,system-power-controller:
+              type: boolean
+              deprecated: true
+              description: |
+                DEPRECATED. The standard 'system-power-controller' property
+                on the parent node should be used instead.
+
+            ti,use_poweroff:
+              type: boolean
+              deprecated: true
+
+          required:
+            - compatible
+
   - if:
       properties:
         compatible:
@@ -115,6 +216,43 @@ allOf:
           properties:
             compatible:
               const: ti,twl6030-gpadc
+
+        pwm:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          description: PWM0 and PWM1
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwm
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+          additionalProperties: true
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          description: LED PWM (mainly used as charging indicator LED)
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwmled
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+          additionalProperties: true
+
+        usb-comparator:
+          type: object
+          properties:
+            compatible: true
+          additionalProperties: true
+
   - if:
       properties:
         compatible:
@@ -154,6 +292,42 @@ allOf:
             compatible:
               const: ti,twl6032-gpadc
 
+        pwm:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          description: PWM0 and PWM1
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwm
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+          additionalProperties: true
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          description: LED PWM (mainly used as charging indicator LED)
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwmled
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+          additionalProperties: true
+
+        usb-comparator:
+          type: object
+          properties:
+            compatible: true
+          additionalProperties: true
+
 properties:
   compatible:
     description:
@@ -181,6 +355,12 @@ properties:
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
@@ -271,6 +451,16 @@ examples:
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
 
@@ -325,6 +515,20 @@ examples:
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
index 3d1996331..000000000
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
index d97ca1964..000000000
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
index 31ca1b032..000000000
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


