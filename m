Return-Path: <linux-pwm+bounces-7073-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE0CB289E4
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 04:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3BBB63D4B
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 02:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823BE1C4A20;
	Sat, 16 Aug 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ3TQs8L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3431B3925;
	Sat, 16 Aug 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310703; cv=none; b=Gwxh5TRbhK5QzSXyrGgYvcMxfq1LrcxCZihI6eMvLJEaTGEE+SqvxfHg+6U3by5a49e6eANCP4RTi4WrlxsinDOvk2qH/vZO20hoqlWBRgRyyTzh3wWAeWhn3PvP/RPm0CsfyQM2qtVib6Q2vhG7xpYen/AjhTwphB2lNkgaQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310703; c=relaxed/simple;
	bh=EM29FsRGqIxFFvtqqat5TZ+FjW5uguU1/OmrFAhkcJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ld31CUQabQvqYTnSlmFO7SaDSxo0CChqj53b764oEIBpVyyafslC4ylF59o2vKvfANSTA3juN2O9uojP2m+Bq1+VSdNUeB3HLIy7KMNb+J/3fvBYWDfQxEOFDWXhLsiWlnsVqHukIHX4AgALFvkO0sFF+K5yHy86643ZiGqczkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ3TQs8L; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9dc5c2f0eso1556094f8f.1;
        Fri, 15 Aug 2025 19:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310698; x=1755915498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOO0HBYS0opU+SY86AqpGaDJz3ELoTgglgKZi026/yo=;
        b=FZ3TQs8LS2fC+t0DnCaZTkxEcphuYnU5aTWuFLF9L8tRicAPxlmNLcdL+mYEqlW1xM
         rq0lz0BvauwBvh8rco8JX+zIbbxIKuPxRaTW0X5r3SfmpAkqo7l5eth29dzTQz5hiS4G
         jOfw3ECsVwYXg8rFEt9OetpM21bn8oeX6dT1VVHAH5mMcsm0VHlswmTOrr2uBN+ij2ay
         BEBd8ffn2hijsDRbhvd6FwRb5G7wiajXUlBD8QbvjlYYort8h6VMQhSqsPghOTYimXhL
         uvXqkLYv3k5pYs2gUFeyx5bR5AJh2N1Q6XOzMEe2B1kGI1cZ+Zb0QajcYIimQLgaM8RO
         fGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310698; x=1755915498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOO0HBYS0opU+SY86AqpGaDJz3ELoTgglgKZi026/yo=;
        b=oqNWCux/UzPHv883CxuQ3hir9bgPfieSJrriOb7pJVQMgZ3zWeprr/Mh9Mrqogrm08
         v7DUZT9uoKDe4kdiVDZaUkNjtxOE2APrGCVWJ35Z9T0xuwKttlycEb2unMcS/tsiRM/p
         BPlyfSNcX6dyBQaOGcBoLCBxcm5kcrj0vn8ciaaUPTrTzdIpliyb9+3rw6lsg+noAD6g
         t4m7rx73LjKEiRLkj053wf16ADw6FCSUuwwLyO2lxs8hs1T87StRYar1YpxL2OG+UY/n
         8he+kMfHth4x58snjQH9r90T/n817u8zuf0fLJvooX01mfz7GgXd4IBJ9oBEEnCIG41T
         V1kA==
X-Forwarded-Encrypted: i=1; AJvYcCUISSohtgfxuhKzFjGOTWxwwmGKxYO43vcsrJFUuJ1rl+JlSeLRpnj3jY7AtwCESV0zZvIUInKOLdmx@vger.kernel.org, AJvYcCUJl4HiZ2kjnemumN6y9jQg9OXD8kvWTbIKupe2g83QxOYi3GJzAJBGnAXvalRAWFFuYe3p7/tsVVIU@vger.kernel.org, AJvYcCVz+u8XGw66WH1RqmjLzyG9pZ02r+mx+hy9DQV1uTV+dpWbL5YF+tO0K7oDTX0UFKMg2WnZp7E5YNHedFo=@vger.kernel.org, AJvYcCWj8Baq02GXAARvfLkANKX+zpuG1C2j+Ky2UkDoQyMYEwpYx2eYb5Xtw0CoY5M2U+ItOLEgzmwO1aLM@vger.kernel.org, AJvYcCWt8aQd2Q2Ubj2W0QaJYq/kot/YjebaUb/CibRsZyMU83LQlZUQh3jR0kFwCGWGhXpkeXJ7Y5TZr5uZsw==@vger.kernel.org, AJvYcCXDbcTULIqnTvtlrJCjGzJ2mFSqx9FPFRuCn8nmDriS8sGVw+fGI6pmdS0FcNKBLbwDxuAL1+Vfx7v3Yw==@vger.kernel.org, AJvYcCXTr5InERRLjADXoMijt7IN9IeuiN6DpOyZ+MN4tLZnS8A63UwKLFvp56OqG52ph185qTjDuWkSLABDZ7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzQ43Q/61P38pMaO6k+XYCmzn5ubIFhOqwdoqhSZmWT584Rxo
	uCANmUVnvndcGuUf0wv36uLvCqelDZrublXiBWdLTu2JnCIJNiAiAZPmRvE3hnc=
X-Gm-Gg: ASbGncuiC74v8V0OF/HK3enDq7/oh/1oulQ45NHkQ0q8hvIMzCT9+9TDaSjnSgYOJiT
	kVIMwjnFCZ0jXDrHg0F3Fp2YITuh3VU9uZDwdOtTc3UHFaIjfKJxXLb5aIwgDRznsP65ID0fY/z
	rp7uOT3Gg3i5elk1tYK9fXTvWN7Kf4nohcGGsHxwY8Me6fvS9YAWpjH308wQJPGpvpzZpGV816j
	mgg7WAfT6uoZfPV5RtbiYxEU+7UEluJW56tpbU6USB35If4TlVQntNIWlmfJBzAY0Ra0A5CvTQp
	CvTtQ2MdhBY+EQ4wld0fXCSRaQMRLrlK+uOGH8huZHEJmcsNAJqh0ScRGMJ+b9IBoUl0knUxRy0
	2d/4LlGBhvxTLhCPKkDui57qlzmCrA3rzlfhW1/0ujgMj3UfTUpN8I9Blxg==
X-Google-Smtp-Source: AGHT+IHjs7ef2KeCtD4dRaJIa6kr4DCONO9sMn6dSkdPTJPZjsWUn/7FHMSOW7fJAW/etvtTdmmnPQ==
X-Received: by 2002:a05:600c:19d1:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-45a26e1f0c3mr6172265e9.0.1755310698276;
        Fri, 15 Aug 2025 19:18:18 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm58712535e9.17.2025.08.15.19.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:17 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andreas@kemnade.info,
	peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	tiwai@suse.com,
	conor+dt@kernel.org,
	lee@kernel.org,
	ukleinek@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	aaro.koskinen@iki.fi,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v3 1/6] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
Date: Sat, 16 Aug 2025 04:15:18 +0200
Message-Id: <20250816021523.167049-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the TI TWL family Device Tree binding to include additional
subnodes for TWL4030, TWL6030, and TWL6032 devices.

The simple power and PWM bindings (ti,twl4030-power, ti,twl-pwm, and
ti,twl-pwmled) are now defined directly within this binding.

Other child node definitions (audio, gpio, keypad, usb, etc.) are also
added to the schema. These additions fix 'unevaluated properties'
errors found during dtbs_check for boards like the omap3-beagle
and improve the binding's overall completeness.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v3:
 - New patch to consolidate simple bindings (power, pwm) and add
   definitions for all child nodes to fix dtbs_check validation
   errors found in v2.
---
 .../devicetree/bindings/mfd/ti,twl.yaml       | 191 ++++++++++++++++++
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 -----
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 4 files changed, 191 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index f162ab60c..b0f1cb7b5 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -76,6 +76,98 @@ allOf:
           properties:
             compatible:
               const: ti,twl4030-wdt
+
+        audio:
+          type: object
+          $ref: /schemas/sound/ti,twl4030-audio.yaml#
+          unevaluatedProperties: false
+
+        keypad:
+          type: object
+          $ref: /schemas/input/ti,twl4030-keypad.yaml#
+          unevaluatedProperties: false
+
+        pwm:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          unevaluatedProperties: false
+          description: |
+            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
+          properties:
+            compatible:
+              enum:
+                - ti,twl4030-pwm
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          unevaluatedProperties: false
+          description: |
+            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
+          properties:
+            compatible:
+              enum:
+                - ti,twl4030-pwmled
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+
+        'twl4030-usb':
+          type: object
+          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#
+          unevaluatedProperties: false
+
+        gpio:
+          type: object
+          $ref: /schemas/gpio/ti,twl4030-gpio.yaml#
+          unevaluatedProperties: false
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
+                "ti,twl4030-power": Standard power control.
+                "ti,twl4030-power-reset": Recommended for OMAP3530 and similar SoCs
+                  that require a special configuration for warm reset to work correctly.
+                "ti,twl4030-power-idle": Loads the TI-recommended configuration for
+                  idle modes into the PMIC.
+                "ti,twl4030-power-idle-osc-off": Uses the recommended idle configuration
+                  but also shuts down the external oscillator. This may not work on all
+                  boards depending on the oscillator wiring.
+              enum:
+                - ti,twl4030-power
+                - ti,twl4030-power-reset
+                - ti,twl4030-power-idle
+                - ti,twl4030-power-idle-osc-off
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
@@ -115,6 +207,44 @@ allOf:
           properties:
             compatible:
               const: ti,twl6030-gpadc
+
+        pwm:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          unevaluatedProperties: false
+          description: |
+            TWL6030 series: LED PWM (mainly used as charging indicator LED)
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwm
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          unevaluatedProperties: false
+          description: |
+            TWL6030 series: LED PWM (mainly used as charging indicator LED)
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwmled
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+
+        'twl6030-usb':
+          type: object
+          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#
+          unevaluatedProperties: false
+
   - if:
       properties:
         compatible:
@@ -154,6 +284,43 @@ allOf:
             compatible:
               const: ti,twl6032-gpadc
 
+        pwm:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          unevaluatedProperties: false
+          description: |
+            TWL6030 series: LED PWM (mainly used as charging indicator LED)
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwm
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/pwm.yaml#
+          unevaluatedProperties: false
+          description: |
+            TWL6030 series: LED PWM (mainly used as charging indicator LED)
+          properties:
+            compatible:
+              enum:
+                - ti,twl6030-pwmled
+            '#pwm-cells':
+              const: 2
+          required:
+            - compatible
+            - '#pwm-cells'
+
+        'twl6030-usb':
+          type: object
+          $ref: /schemas/usb/ti,twlxxxx-usb.yaml
+          unevaluatedProperties: false
+
 properties:
   compatible:
     description:
@@ -271,6 +438,16 @@ examples:
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
 
@@ -325,6 +502,20 @@ examples:
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


