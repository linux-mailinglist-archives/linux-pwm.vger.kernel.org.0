Return-Path: <linux-pwm+bounces-7045-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52AB26704
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACB63B1980
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23F30100C;
	Thu, 14 Aug 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxR9A70Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF23009F7;
	Thu, 14 Aug 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177716; cv=none; b=sjJ6jMW5u8Uk97cnKSKuKyxbkduWEJYT/qkthksmx3WE+4DjIvhy2O6/QuGVq5xB0H9b+BwfInqlXWSoqFR4vxZuClw4u7Pqe1Xv8sOTQAYpGNTxcD02cBJWqULgvwQEjKyMV7wsetaxr64syg+vMXOFhp01wj4otNkycM5Avpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177716; c=relaxed/simple;
	bh=YB8gx+mS5u1dIxyZz+GFs2Q1IPHnHTO12wo/rlhuhWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1MOagjXRCKaKSsI4YXZqSQNt+2t59GEYrz/OkwXWn8y1w04xHjKVdmygPhPDX4VWZe/1qlg/vrAYXe3rlzFCJFfzjZqGpPXxIba8fHLi0l0zRFS6T6YnR5UhN0JEYQJwE/lol1afAS1ddgwZb6r0LlTU4hGxT06Y1pvQsYNfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxR9A70Y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so6203015e9.2;
        Thu, 14 Aug 2025 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177712; x=1755782512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fJmbIv+TtvIhbfGERIJn/WGPFWhZmJ8+BYKnvffDX8=;
        b=PxR9A70Y97q7rosC6GiwXHYePfqg10K8mQqic6C+8FGfO7c7QdR0HlGYvb4UngSy02
         wZD4yvTmRkDygnKTK+VWmms6UExDT/yMbXmkpoDMirQmfxSy22buw8hHnbILuu3dJgc5
         fbBKc1LelWQQbtFwlPFXJaUtoqvfdViDeYTB7exnURoynryJuodW2y2z9Ez3HeUMIvX1
         S72a/L7M9g88qlEuueCUfFf/Pky76lfevkTwodPKhphlazrjrr/LW+ImfFv2Fy16Zo13
         VI3Selnzvj9PVxlNGlJ0HPRuyk6Qa8cvP399nLWzymLKpUjvc06vnFFCYAiGrnpqLHu5
         BQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177712; x=1755782512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fJmbIv+TtvIhbfGERIJn/WGPFWhZmJ8+BYKnvffDX8=;
        b=esnPlgdb0oA0kWmz75skClwpNER3Cdq8fWwmbDGQy8BCAnSDTJ1nK6jz5AKXVCvspR
         cmnbjKsiVPLGCPC04SpJa43k7eZ1f9CWPvqJ65JeccVoIGgOvZCit0wD15CL44UBODs8
         FBB2cjdvbrTR0FQbvPpjp2qSrBQnrxVqdX5oq5nmMw1BPRrB7Okkq+UNsgzoGd/vnbH1
         aBR/BBsTgYfiKWRAYN2nu4fKivhOWCJICyyfy5RDEPcZ9Cb72vlwpWHdC1tlDt0g9Smv
         eHIcRE8OGEVFHk9ABcp/awD0u3SaDvKuSaYv74KVkxy7K6PUk3j9ycZ2dbAytlccoPC3
         TnkA==
X-Forwarded-Encrypted: i=1; AJvYcCVzHvuRBuj6+yzRtcwLaZChC4vjKZCJF8/2eoPwn1DcG7lFCwofKVo2FCWm1wSDckdKBht8Z7LKkx81QYY=@vger.kernel.org, AJvYcCWTFSQyYGzW6wXP11azrj7+RiQdFbWEdl9WkB0EYMCaZrzOCR2uiKA6xpWHwRXVMbLfIkguHwcmeHSQ@vger.kernel.org, AJvYcCWf+XsH+W7qGesRpbLmkAPMqfFsj5rc08oE0Ia5rxhia/1nW68H22wF+QvIiZfJzw9BWt9iSz9AkDL1tbk=@vger.kernel.org, AJvYcCX3Choe5OWeJL0QdtIr6/xyE8/G+M4wMo0yRHBhTM8Ze2CwTG+pFUkm748GFc6BOri0YsK2EIYG72SI@vger.kernel.org, AJvYcCXd8q79slrgTEwqGfAUbZny879gi9JKQH//5IS2lx92dE1mf6ypAc4mv0FO+Y0kZEx9Fwwg+NPXYita@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9fZCG5+z9o7Od3r4hOlJCaTmxYl+MBPr6JMUwTFTbtR4UfwJ
	U4uVHqTteL49fLd+7NQwr5C3EAMUx6ciwRHB94rCxW1L74Kaf8yYPP2NvvSN
X-Gm-Gg: ASbGnctPoWdJfVIzQt9Y/rw2hujgMi5O7scFhJz/U8A1zWnfTLAbIrqwxVOhLxtNcZa
	SfkYVYy+pdrnlXJfXrfG7259wN45unwAW1UsL7JlBTReS+GxIhaMujh7n0q1PYoayYQ7mW3tFRG
	MSqmkLbdRUXSWSpfNPku4ZF5VxczepEXymyvS7Y1JsRY4n9U9wcUiSxb0AyiTqqXs06MpIv5QDe
	4MhgGbMuUfk/b1vx0FEGESok0nicFnImwie+PdKpSvpgZsDRSDKtW+TQQ7xNk5ypINv7e3OOkA4
	yiPThKjtsWilboDVS9CX5PkY0ncCipoaPMY8hp8aVKsv4g7N1/NoaeDshgsod8gNv3bdN5Ionxz
	G+mQxk3b3CfVPsTnZnAKS2VxDhBRYPREPGnDx8ubfoI1l/VRM5QZdHDzmHqChYKMjjBWxRF+qXk
	0h8diXD/N63hxolgoHvRMzRg==
X-Google-Smtp-Source: AGHT+IFiL+1Umnq+fmKeKNZMcktyIW0wkdHd0uXEMP4yqlT4LWOeF3NNGRX5nUW9RkO4906ovxoWgg==
X-Received: by 2002:a5d:5d09:0:b0:3b5:f0af:4bb0 with SMTP id ffacd0b85a97d-3b9e417d8bamr2571123f8f.23.1755177711455;
        Thu, 14 Aug 2025 06:21:51 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:21:50 -0700 (PDT)
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
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v2 2/9] mfd: dt-bindings: ti,twl6040: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:22 +0200
Message-Id: <20250814132129.138943-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL6040 MFD to the modern YAML
DT schema format. This adds formal validation and improves documentation
for the TWL6040/TWL6041 audio codec, which provides audio, vibra, and GPO
functionality on OMAP4+ platforms.

Changes in v2:
- Renamed twl6040,audpwron-gpio to ti,audpwron-gpio for consistency
  with TI naming, this fixes the dt_binding_check vendor name  error.
- Minor description clarifications for improved readability.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/mfd/ti,twl6040.yaml   | 155 ++++++++++++++++++
 .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
 2 files changed, 155 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
new file mode 100644
index 000000000..7365e4c04
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,twl6040.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL6040/TWL6041 Audio Codec
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  The TWL6040s are 8-channel high quality low-power audio codecs providing
+  audio, vibra and GPO functionality on OMAP4+ platforms.
+  They are connected to the host processor via i2c for commands, McPDM for
+  audio data and commands.
+
+properties:
+  compatible:
+    enum:
+      - ti,twl6040
+      - ti,twl6041
+
+  reg:
+    const: 0x4b
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 1
+
+  '#clock-cells':
+    description: TWL6040 is a provider of PDMCLK which is used by McPDM.
+    const: 0
+
+  ti,audpwron-gpio:
+    description: The GPIO specifier for the audio power-on line.
+    maxItems: 1
+
+  vio-supply:
+    description: Regulator for the VIO supply.
+
+  v2v1-supply:
+    description: Regulator for the V2V1 supply.
+
+  enable-active-high:
+    type: boolean
+    description: If present, powers on the device during boot.
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum: [clk32k, mclk]
+
+  # Vibra functionality :
+
+  vddvibl-supply:
+    description: Regulator for the left vibra motor supply.
+
+  vddvibr-supply:
+    description: Regulator for the right vibra motor supply.
+
+  vibra:
+    type: object
+    description: Node for vibra motor configuration parameters.
+    properties:
+      ti,vibldrv-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the left driver.
+
+      ti,vibrdrv-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the right driver.
+
+      ti,viblmotor-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the left motor.
+
+      ti,vibrmotor-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the right motor.
+
+      vddvibl_uV:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Optional override for the VDDVIBL default voltage (in uV).
+
+      vddvibr_uV:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Optional override for the VDDVIBR default voltage (in uV).
+    required:
+      - ti,vibldrv-res
+      - ti,vibrdrv-res
+      - ti,viblmotor-res
+      - ti,vibrmotor-res
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio-controller
+  - '#gpio-cells'
+  - '#clock-cells'
+  - ti,audpwron-gpio
+  - vio-supply
+  - v2v1-supply
+  - vddvibl-supply
+  - vddvibr-supply
+  - vibra
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      twl6040: twl@4b {
+        compatible = "ti,twl6040";
+        reg = <0x4b>;
+
+        interrupts = <0 119 4>;
+        interrupt-parent = <&gic>;
+
+        gpio-controller;
+        #gpio-cells = <1>;
+        #clock-cells = <0>;
+        ti,audpwron-gpio = <&gpio4 31 0>;
+
+        vio-supply = <&v1v8>;
+        v2v1-supply = <&v2v1>;
+        enable-active-high;
+
+        /* regulators for vibra motor */
+        vddvibl-supply = <&vbat>;
+        vddvibr-supply = <&vbat>;
+
+        vibra {
+          /* Vibra driver, motor resistance parameters */
+          ti,vibldrv-res = <8>;
+          ti,vibrdrv-res = <3>;
+          ti,viblmotor-res = <10>;
+          ti,vibrmotor-res = <10>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/twl6040.txt b/Documentation/devicetree/bindings/mfd/twl6040.txt
deleted file mode 100644
index dfd8683ed..000000000
--- a/Documentation/devicetree/bindings/mfd/twl6040.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Texas Instruments TWL6040 family
-
-The TWL6040s are 8-channel high quality low-power audio codecs providing audio,
-vibra and GPO functionality on OMAP4+ platforms.
-They are connected to the host processor via i2c for commands, McPDM for audio
-data and commands.
-
-Required properties:
-- compatible : "ti,twl6040" for twl6040, "ti,twl6041" for twl6041
-- reg: must be 0x4b for i2c address
-- interrupts: twl6040 has one interrupt line connecteded to the main SoC
-- gpio-controller:
-- #gpio-cells = <1>: twl6040 provides GPO lines.
-- #clock-cells = <0>; twl6040 is a provider of pdmclk which is used by McPDM
-- twl6040,audpwron-gpio: Power on GPIO line for the twl6040
-
-- vio-supply: Regulator for the twl6040 VIO supply
-- v2v1-supply: Regulator for the twl6040 V2V1 supply
-
-Optional properties, nodes:
-- enable-active-high: To power on the twl6040 during boot.
-- clocks: phandle to the clk32k and/or to mclk clock provider
-- clock-names: Must be "clk32k" for the 32K clock and "mclk" for the MCLK.
-
-Vibra functionality
-Required properties:
-- vddvibl-supply: Regulator for the left vibra motor
-- vddvibr-supply: Regulator for the right vibra motor
-- vibra { }: Configuration section for vibra parameters containing the following
-	     properties:
-- ti,vibldrv-res: Resistance parameter for left driver
-- ti,vibrdrv-res: Resistance parameter for right driver
-- ti,viblmotor-res: Resistance parameter for left motor
-- ti,viblmotor-res: Resistance parameter for right motor
-
-Optional properties within vibra { } section:
-- vddvibl_uV: If the vddvibl default voltage need to be changed
-- vddvibr_uV: If the vddvibr default voltage need to be changed
-
-Example:
-&i2c1 {
-	twl6040: twl@4b {
-		compatible = "ti,twl6040";
-
-		interrupts = <0 119 4>;
-		interrupt-parent = <&gic>;
-		twl6040,audpwron-gpio = <&gpio4 31 0>;
-
-		vio-supply = <&v1v8>;
-		v2v1-supply = <&v2v1>;
-		enable-active-high;
-
-		/* regulators for vibra motor */
-		vddvibl-supply = <&vbat>;
-		vddvibr-supply = <&vbat>;
-
-		vibra {
-			/* Vibra driver, motor resistance parameters */
-			ti,vibldrv-res = <8>;
-			ti,vibrdrv-res = <3>;
-			ti,viblmotor-res = <10>;
-			ti,vibrmotor-res = <10>;
-		};
-	};
-};
-
-/include/ "twl6040.dtsi"
-- 
2.39.5


