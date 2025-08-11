Return-Path: <linux-pwm+bounces-7007-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F596B21893
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07727A27D9
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E54227E83;
	Mon, 11 Aug 2025 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXvqeIII"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22421FF3C;
	Mon, 11 Aug 2025 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952484; cv=none; b=hVBGD2m503JW4Au2M4Fwqbo+rk/uVUzQLzd9+jmkOhXPK+/hy5Hf9VoO7C7pcrqraBHJ5qdo9wtBelk9QOa5SxCFR+oqbRo+HCF+J0F5rjFJJFPNY3m5O7O14gcz5KfshRk/+8mkLmXL0BQsgGlqDsCdvWt1vrXqchmnGBGuhM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952484; c=relaxed/simple;
	bh=jvjzZq0bkuqjMW0H8s8YCSoJvL3jWoXr90/T8GKdPCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fU3bD/5y0Pxu1xn9tyZiod6d1DAXq7sdJUWNjUJsE1K8j6BgxMC1GRjUM97sDKIZZ6gu2Q9Y8+seXQKdAyqnSIabQ63CQ4ykwYoxsjO6dWil6kO4Qwpy9Xa/LA9b/W/nzl9LIpbfL1U7pDmmCmGdgGGXpBy05MEN71z0wSiwyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXvqeIII; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458ba079338so37743245e9.1;
        Mon, 11 Aug 2025 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952481; x=1755557281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqI122usjZRSFS1Z3VRf+ltsntZcMEhFFJ/iSXUc8qI=;
        b=lXvqeIII0tv7NNnmsb0xjMlhuBn8jbP0HJFLLGoEONM+2bwawqe5Ggb5OOaSJBVmoJ
         nA4sJsuZpEUsTeVYD2Ygx6HRg47bL5VlzfijvaTtPcTlPukOYiPXnqVV+PW5DBzBNs46
         pM9iYtiYXrcV6it/XIEKV3yk9h+biL9cCG1BrZqZAbWMzHwnQsRL7TqKIkWi9oqY5pda
         QGBB3lPL3TfnLXhVcuXbc8sK1re8xrij4wmSmOCn3G6lDxH6N5/FPzhQ77hMTCPmJvW1
         YGH46ILAcBWioqJzLWCBDpTNZdDDtK/KDsgWkObU1KeexVzxhEvR70Zk6SWjXGU7vv6W
         I0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952481; x=1755557281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqI122usjZRSFS1Z3VRf+ltsntZcMEhFFJ/iSXUc8qI=;
        b=RykCUBKDq5TezyXqyM7vh0wt761MgYVPxCSLDFG2nbEJaTw/sIHyNquAMChz23QpeS
         PtGOv2XBCcxEDtM6V2qHlWTiRw6sdUt0uWJ2PFU2tEEGsR1FPe9PvT45bJeN9ADJy8AJ
         ZUi/ACfizFBTr2Xk3uw2A/JUqY1AB6SxnkKBj3BAV2HZ7Uxau077GjfALxYxxmvCjKZI
         mPd4upuxQiPxOLqEvFFbWONIr6v1qNOJynDipcgr6YOxcQe5AFwqzHq3n+cq36ngze7q
         CKwYjbKKzY07fY2wostDHuHw4Z/8rogjJOwGAXRYm5J8tR39fJtMBbWLT5X72bw2w/pY
         cKPw==
X-Forwarded-Encrypted: i=1; AJvYcCUT3w44eEAdcLtF4MN2dmfvQxGVNMc7UPL8BKpPtzToliJOcOB6EsIi+jZMk5qPHfyy4pf7uU8gDYyd@vger.kernel.org, AJvYcCV+bKB2UMw0AMMEgH3oDbOU33K+l1WB7zK38VkgzHXDjLaqk1u9r7I//On4I9+Lq5mdnw7hKCOvwLPz6go=@vger.kernel.org, AJvYcCVteWsOxxXJqnGReemh9+sIibypaVfH8a1nwG7rbsoUAl7o+jxpjCueRh+64CmTGJ43avlWyn0rFXPJwN0=@vger.kernel.org, AJvYcCX9+i+dscKZBLu41/EYq4qA9TA5MlKjsJHShrr4fy3qWa0ySoA+A7DT3qxh+bWjF9QmSWn5t5F31+9f@vger.kernel.org, AJvYcCXvJVFlEBo0oC/rZnUuwnkCzrbJSEqsMvIDuNVFZSw5TwjIXwOeR29pqJMOzVpdqD9iounGlNkDqKkO@vger.kernel.org
X-Gm-Message-State: AOJu0YxvL5XIqMVS5XDQr8lfv6Nq4lQiJaSWMgaKgMSfIqHYpqNUQWLA
	HMkN5BTu8cQ54UK94+sIIKngsI3+C217I/szp0YfRszdPCpneeC3eka6h05xybk=
X-Gm-Gg: ASbGncuyFdis/HBP8BdRJ8im4Tj2dsk0ljYx66XuFyGekRLOF6X0TnAeXSLVIrTKnyu
	NWZMrE7qIoDsovbwU1nhgNY+ji+4gwo25daSyR4HOiExYGiGIX2qwWc0WenAVAoH3cZ6Ou8ImnY
	ddN0xOBoo5vXtyWip+D6ovmERHdrC2DfYRDjMtlKv33vFmRJjoWp7s/tZHAQ19GMxAaWKe8bEbX
	/oEN/0yOLp8pIGZ1F4szE0wRRuNtXBbq1zEW695+72m58NSUtR1SgdSpuRunDfQrCbhOZf78aQ0
	EjOtbnJJ4kBP1D6VpsCt9x3ianMIykYqRLqtF8dh0l8Rletp8mZtzpBrSQ1tCUVeuwQquszJDN7
	0zVmVlbR3AFVto3I3OFSyBmLK1CZLogkwsp8lxXfCSWL8C7Q=
X-Google-Smtp-Source: AGHT+IGmrUmvkaTCi7+h+K3nrilFgGoEjlvUoTRaXe9AQnbTOgTVBgryhE8j99oYqnDVPzwHCU5fnw==
X-Received: by 2002:a05:600c:47d4:b0:459:e002:8b1e with SMTP id 5b1f17b1804b1-45a10dd53ebmr6459555e9.13.1754952480633;
        Mon, 11 Aug 2025 15:48:00 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:48:00 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: peter.ujfalusi@gmail.com,
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
Subject: [PATCH 2/8] mfd: dt-bindings: ti,twl6040: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:33 +0200
Message-Id: <20250811224739.53869-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL6040 MFD
to the modern YAML DT schema format. This adds formal validation
and improves documentation.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/mfd/ti,twl6040.yaml   | 155 ++++++++++++++++++
 .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
 2 files changed, 155 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
new file mode 100644
index 000000000..305dc1676
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
+description: |
+  The TWL6040s are 8-channel high quality low-power audio codecs providing audio,
+  vibra and GPO functionality on OMAP4+ platforms.
+  They are connected to the host processor via i2c for commands, McPDM for audio
+  data and commands.
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
+  twl6040,audpwron-gpio:
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
+        description: Optional override for the VDDVIBL default voltage in microvolts.
+
+      vddvibr_uV:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Optional override for the VDDVIBR default voltage in microvolts.
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
+  - twl6040,audpwron-gpio
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
+        twl6040,audpwron-gpio = <&gpio4 31 0>;
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


