Return-Path: <linux-pwm+bounces-2875-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B393855F
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A201C20928
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AA61684A4;
	Sun, 21 Jul 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SmHDLavg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0C1DFE1;
	Sun, 21 Jul 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721577672; cv=none; b=EnDtFHxPBcQhIzRVGYNGIPWFXfpxGyA9rtS9vUjPB//QIamhLpwn9Jc/DmY/6JxlxOh0gkJQiz/xzj38U9e4J626bGnC1zkoIiFqpKcweRqYculzNxeYoKOHyjn/ESHM+uKjoAyt8/1XwdTWOfgcVaIVtIprzdYgDk2WZniu5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721577672; c=relaxed/simple;
	bh=AjGOHNrcbUkES1BHSLfifOFPW26U1lQsP9UPuHrjplo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnyD9teUJtE+klcA7MhHbAuXintyX04sxpio6xXkagt2+CLt5aPQPAQhUQJqsCEkx6h9UlqQ3pzpvwFSJiz2oeB++sPBdbjtbc7RJI+iE1CZmS4GBaNH+AhRAjQIMZ4ADwmhpPF1cr3fSSkg0RpNHfOaYneDukVhXkOZqVClQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SmHDLavg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF13A226;
	Sun, 21 Jul 2024 18:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721577627;
	bh=AjGOHNrcbUkES1BHSLfifOFPW26U1lQsP9UPuHrjplo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmHDLavgGZMrEDDXOcJgglGTYgS8LnExOeaI7FDJS8fq57okZRd47ljsl+19F6wRD
	 uVfAiqBdTGREszazw5SDi6eGuzf6oBlyewH1Wr0KQIuRXHaAsJRVWNIw9Ju3yMD7y9
	 ez8Yn5X640gYnPTfF/6unSchZR8qbW/r0ZVhsrDM=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: [PATCH v6 1/4] dt-bindings: mfd: Add Analog Devices ADP5585
Date: Sun, 21 Jul 2024 19:00:46 +0300
Message-ID: <20240721160049.20470-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240721160049.20470-1-laurent.pinchart@ideasonboard.com>
References: <20240721160049.20470-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADP5585 is a 10/11 input/output port expander with a built in keypad
matrix decoder, programmable logic, reset generator, and PWM generator.
These bindings model the device as an MFD, and support the GPIO expander
and PWM functions.

These bindings support the GPIO and PWM functions.

Drop the existing adi,adp5585 and adi,adp5585-02 compatible strings from
trivial-devices.yaml. They have been added there by mistake as the
driver that was submitted at the same time used different compatible
strings. We can take them over safely.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
I've limited the bindings to GPIO and PWM as I lack hardware to design,
implement and test the rest of the features the chip supports.

Changes since v5:

- Fix gpio-reserved-ranges definition

Changes since v4:

- Drop the right comment in trivial-devices.yaml

Changes since v3:

- Fix prefix and drop redundant text in subject line
- Rename node in example from mfd@ to io-expander@

Changes since v2:

- Drop gpio property from required
- Drop second example

Changes since v1:

- Squash "dt-bindings: trivial-devices: Drop adi,adp5585 and
  adi,adp5585-02" into this patch
- Merge child nodes into parent node
---
 .../devicetree/bindings/mfd/adi,adp5585.yaml  | 92 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 -
 MAINTAINERS                                   |  7 ++
 3 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
new file mode 100644
index 000000000000..f9c069f8534b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADP5585 Keypad Decoder and I/O Expansion
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+description:
+  The ADP5585 is a 10/11 input/output port expander with a built in keypad
+  matrix decoder, programmable logic, reset generator, and PWM generator.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - adi,adp5585-00  # Default
+          - adi,adp5585-01  # 11 GPIOs
+          - adi,adp5585-02  # No pull-up resistors by default on special pins
+          - adi,adp5585-03  # Alternate I2C address
+          - adi,adp5585-04  # Pull-down resistors on all pins by default
+      - const: adi,adp5585
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-reserved-ranges: true
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - "#pwm-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,adp5585-01
+    then:
+      properties:
+        gpio-reserved-ranges: false
+    else:
+      properties:
+        gpio-reserved-ranges:
+          maxItems: 1
+          items:
+            items:
+              - const: 5
+              - const: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        io-expander@34 {
+            compatible = "adi,adp5585-00", "adi,adp5585";
+            reg = <0x34>;
+
+            vdd-supply = <&reg_3v3>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-reserved-ranges = <5 1>;
+
+            #pwm-cells = <3>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 0a419453d183..8a6056323545 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -38,10 +38,6 @@ properties:
           - ad,adm9240
             # AD5110 - Nonvolatile Digital Potentiometer
           - adi,ad5110
-            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
-          - adi,adp5585
-            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
-          - adi,adp5585-02
             # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
           - adi,adp5589
             # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
diff --git a/MAINTAINERS b/MAINTAINERS
index 958e935449e5..4fe8bd8752a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -526,6 +526,13 @@ F:	drivers/leds/leds-adp5520.c
 F:	drivers/mfd/adp5520.c
 F:	drivers/video/backlight/adp5520_bl.c
 
+ADP5585 GPIO EXPANDER, PWM AND KEYPAD CONTROLLER DRIVER
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+L:	linux-gpio@vger.kernel.org
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
+
 ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
-- 
Regards,

Laurent Pinchart


