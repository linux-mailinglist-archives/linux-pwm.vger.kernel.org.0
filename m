Return-Path: <linux-pwm+bounces-7051-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE1B2673A
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78792564D0A
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06B303CB2;
	Thu, 14 Aug 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJph/G7J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CD302778;
	Thu, 14 Aug 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177727; cv=none; b=qz8jK7TSn+GzmGQziTgf65n8qBF+5Nl8S87U+3+YohqWYfYmCSA0RM4mE5fTM/LVawDaLaF34JUIo+qlg7u5JEMQfe/bLhwgiMYZdP7oVeI5tNqnX/CIeNmnQJrBqzCWDr1o/y6NdK8M8LVMHVh/jWPAbCiJlSCrbW38AmrvMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177727; c=relaxed/simple;
	bh=ttF0rBMZYYb3PkLndM6PHBPM7PDCgmMp+SUcSU6Gcbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVrKNT1aECcNPbDIY+bNGY6vTq8o4Mxi3LcpENS/A1CbZiTl+3ejOC1i54nNNjhe3ynffymv8t/w8lsc0iFYgDGmW5QrH/R8Ib9WFejxMEZiUHbk1ZLn1+wT1u8ytJ26ouuPP8YQdJCD6unVqY7FKc0Phtp4S2jFVI2mJdFtYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJph/G7J; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9edfba75bso412219f8f.3;
        Thu, 14 Aug 2025 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177724; x=1755782524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPhvOj0vcqOs4hostSr3/eg4Eaucd/avEKAcPTcqmOw=;
        b=jJph/G7JqcKhJa2DhTc94UwsbkhpeTWaAdMUHvjFFMzU7g3tmEBnGR/RjCvofRIKIH
         6a4AAbu9ullpzwiOpAQCc1BM6Dp3dtsdhkd8k9E5MbWdhs09pY5rObhwHYsdJmdcBh3N
         q9m9egiCVmpmqjhZ1JAj42TwelFgDaE9GciQSxxLS3JYThADzBM5v+UkhalTFC+PXA0f
         FRJ32VnQa1tgTmLu1ArWz9pxF4AVUgYkhyVFsF4Olzx6Cp+pzu8Y5iqwIDO+VMbaBbC1
         CrO24bKnFA9m/3tp//ctkx2e5He3+4u20QS+jeB89axi19ZcJbTgR7muUoOGV8avWMqr
         L/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177724; x=1755782524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPhvOj0vcqOs4hostSr3/eg4Eaucd/avEKAcPTcqmOw=;
        b=XLpBw2clfZWScEZgyqziGvjG8mukXQr5GAj1MpKXnus+eg3H+Yvqi4jEbsxHIKcx1w
         VgLTARt+8HE5kTAWcX+7HdRf+vyNAZymZ2Ct2IZVYvmonXkfndKJNFS6yEKeqO+VbF09
         ii8FxDRrxbIoYh5Q2a2gdcGbNa12RQtp6NIDVNvnGRs4e944Y0tvqnoQONHPBAitH1hB
         ORqMX3IqIV7aa6F+iQWB0Sz2z+f1dTogxraOg6QLcJJBP9IJgH2+XHl7lRU7TC2bWGH9
         C5q5qyvQTAzXwH4Ts/YngCQ/WrdBnudSfszbHF9c/JDX0IBZ3l5mNZwArGJJqbvjdDVD
         311w==
X-Forwarded-Encrypted: i=1; AJvYcCVOEbqbISQF5hmsCosrfPtCF64L75ibZhVuKueFjEa+4cDir3XY8ludFx7dAd/3z0Vwmz8hj6lcLMJu@vger.kernel.org, AJvYcCVlYIEjY1lX3rkQo7r8ibsGJrF4laeKBq96L9T9d7s9gKiPdMEw5eGFEL8MzdLdI7++f94ef6JQeeZP9Dg=@vger.kernel.org, AJvYcCWJiCv7zI9aN+ZTibBciYtxhUtVfbb6Gi1xhbw64FR67vO5GCdwqjTaxqk1r+2O4dOUv45QhH32yDFPl4c=@vger.kernel.org, AJvYcCX6QtwMC6B4USNmoKbTMjA/7vyEd+vpYJM4ckh98ZfaVV15pcT8+6IUGFEiA0xMXUslo/t2CWJZCGYY@vger.kernel.org, AJvYcCXE+LROq1yG5euv2iLOmxzVM/NJnpPmu4Ij3NO2xNe7tBqn3MU2bVZYcpiHK6xE6PSeioMJLrfIi8c0@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLzfFEz+VB9fOhtu4LtWsUSj2NBG5pK7hqG/EoFrurAIbAE4k
	XyZuGgEwhdmKK6BbqUP/xnrzCDfhTjsBSisMWS8LR4OVb9ay8pWbovd0edX4
X-Gm-Gg: ASbGncsGZ2W1N1Yk3WOXZmOkz+cnMxzm6eo7FXvYIosdkiUex+aaCmZSETRTvSZTyK9
	S73qK43Ttj/uTezslhmpUc6JaPRmR4ikn0Sy0FeX0y5Q4wpuf0wXs5+oL9pguqNQEkCFf+CF+qX
	qeIdExPhvwlNk5vSk2lSOUX1s+r9yjYCYPrnbP8B+r2HWwQsnCMX1Nf5A0QkRxBznWJd40LTxio
	vZ8PsDDZNtIw46WkI2sxIhrObQ+IArPOUjBHm2UGdf6RywZm4JZEOt79xa/C/hNlHO2MAELN2VT
	3I1XAd5odduVQ1r0zUDTHVvcAo1yq8OeVzy+jliXLv5i+93YIhDjmrbIGSK6IL5UBgQcZ+wg6Hk
	a13Cot8SPwHLUyKM+5spgRGtGBkS2lglymrWI8HNMAKcEWnN1aJ4ZEZTWNfpJw6yyH15WQkku2i
	zpJI3R4qjyg0YmEBstWtFx5e3HgPonKpsJ
X-Google-Smtp-Source: AGHT+IEDiNwjwbKGhqrtPSNbm7ZvnFQK5iC/6/SqCP0SvFuwTlU0elXKRGvv48bAjGCVY6IX/E3vIQ==
X-Received: by 2002:a05:6000:144f:b0:3b7:9ae1:eb9 with SMTP id ffacd0b85a97d-3ba50cc8e1emr2060796f8f.23.1755177723440;
        Thu, 14 Aug 2025 06:22:03 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:22:02 -0700 (PDT)
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
Subject: [PATCH v2 8/9] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:28 +0200
Message-Id: <20250814132129.138943-9-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030/6030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

Changes in v2:
- Added '#phy-cells' property to support PHY framework integration.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/usb/ti,twlxxxx-usb.yaml          | 125 ++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   |  43 ------
 2 files changed, 125 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
new file mode 100644
index 000000000..48ff5b732
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,twlxxxx-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030/6030 USB PHY and Comparator
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description: |
+  Bindings for the USB PHY and comparator module found within the
+  TWL4030 and TWL6030 family of companion chips.
+
+  TWL6030: USB COMPARATOR
+  TWL4030: USB COMPARATOR & PHY
+
+  If a sibling node is compatible with "ti,twl4030-bci", the driver for
+  that node will query this device for USB power status.
+
+properties:
+  compatible:
+    enum:
+      - ti,twl4030-usb
+      - ti,twl6030-usb
+
+  interrupts:
+    description: |
+      Interrupts for ID and VBUS events.
+      For "ti,twl6030-usb", two interrupts must be specified:
+        - The first is the OTG interrupt for ID events (host mode).
+        - The second is the USB interrupt for VBUS events (device mode).
+      For "ti,twl4030-usb", one or two interrupts can be specified:
+        - The first is the OTG interrupt for both ID and VBUS events.
+        - The second is optional.
+    minItems: 1
+    maxItems: 2
+
+  usb-supply:
+    description:
+      Phandle to the VUSB regulator. For TWL6030, this should be the 'vusb'
+      regulator. For TWL6032 subclass, it should be the 'ldousb' regulator.
+
+  usb1v5-supply:
+    description: Phandle to the VUSB1V5 regulator (for TWL4030).
+
+  usb1v8-supply:
+    description: Phandle to the VUSB1V8 regulator (for TWL4030).
+
+  usb3v1-supply:
+    description: Phandle to the USB3V1 regulator (for TWL4030).
+
+  usb_mode:
+    description: |
+      The mode used by the PHY (TWL4030 ONLY) to connect to the controller:
+        1: ULPI mode
+        2: CEA2011_3PIN mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ti,twl6030-usb
+then:
+  required:
+    - usb-supply
+  properties:
+    interrupts:
+      minItems: 2
+else:
+  required:
+    - usb1v5-supply
+    - usb1v8-supply
+    - usb3v1-supply
+    - usb_mode
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        twl@48 {
+            reg = <0x48>;
+
+            usb_phy: twl4030-usb {
+                compatible = "ti,twl4030-usb";
+                interrupts = <10 4>;  // 1 interrupt: OTG (ID & VBUS events)
+                interrupt-parent = <&gic>;
+                usb1v5-supply = <&reg_vusb1v5>;
+                usb1v8-supply = <&reg_vusb1v8>;
+                usb3v1-supply  = <&reg_vusb3v1>;
+                usb_mode = <1>;
+                #phy-cells = <0>;
+            };
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        twl@48 {
+            reg = <0x48>;
+
+            usb_comp: twl6030-usb {
+                compatible = "ti,twl6030-usb";
+                interrupts = <4 4>, <10 4>;  // 2 interrupts: OTG & USB
+                interrupt-parent = <&gic>;
+                usb-supply = <&reg_vusb>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
deleted file mode 100644
index 17327a296..000000000
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-USB COMPARATOR OF TWL CHIPS
-
-TWL6030 USB COMPARATOR
- - compatible : Should be "ti,twl6030-usb"
- - interrupts : Two interrupt numbers to the cpu should be specified. First
-   interrupt number is the otg interrupt number that raises ID interrupts when
-   the controller has to act as host and the second interrupt number is the
-   usb interrupt number that raises VBUS interrupts when the controller has to
-   act as device
- - usb-supply : phandle to the regulator device tree node. It should be vusb
-   if it is twl6030 or ldousb if it is twl6032 subclass.
-
-twl6030-usb {
-	compatible = "ti,twl6030-usb";
-	interrupts = < 4 10 >;
-};
-
-Board specific device node entry
-&twl6030-usb {
-	usb-supply = <&vusb>;
-};
-
-TWL4030 USB PHY AND COMPARATOR
- - compatible : Should be "ti,twl4030-usb"
- - interrupts : The interrupt numbers to the cpu should be specified. First
-   interrupt number is the otg interrupt number that raises ID interrupts
-   and VBUS interrupts. The second interrupt number is optional.
- - <supply-name>-supply : phandle to the regulator device tree node.
-   <supply-name> should be vusb1v5, vusb1v8 and vusb3v1
- - usb_mode : The mode used by the phy to connect to the controller. "1"
-   specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
-
-If a sibling node is compatible "ti,twl4030-bci", then it will find
-this device and query it for USB power status.
-
-twl4030-usb {
-	compatible = "ti,twl4030-usb";
-	interrupts = < 10 4 >;
-	usb1v5-supply = <&vusb1v5>;
-	usb1v8-supply = <&vusb1v8>;
-	usb3v1-supply = <&vusb3v1>;
-	usb_mode = <1>;
-};
-- 
2.39.5


