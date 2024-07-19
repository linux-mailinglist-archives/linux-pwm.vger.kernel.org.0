Return-Path: <linux-pwm+bounces-2860-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC1937D53
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FC51C2096B
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB9414885C;
	Fri, 19 Jul 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aV5QA1eP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5E147C76;
	Fri, 19 Jul 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421615; cv=none; b=LSyyB1gutIDryvZM+V11YIUy2SAtv2rQb8TOCgOnJmz7SvFNrSVdlHjp7GlVIk19xXMIpCccly33oQCUdVL4BYSHSve85fzyybTT8gHvq45aEOjY3mc31RO2vbqOWfpP+YWskFPyGfpxcaJeMOcbNn5q5KYlAxcPlG1HfbU8SbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421615; c=relaxed/simple;
	bh=wdxoGL7pDEwrMi5WYM/gz4zFwQgA6TrJDV4yAKbgiFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyIH08N4XAfzpEzmVr442/B1GUbGDUp5tEILBJC10kwzOkImGsLAV6bE+WtRZbHDmc9jb8KKd0uzYCaRYVLkZAeHMpE7R2W1DOpOlNvFf723smKLthtr/3WvaQx8nN3gvkkhdmDRuVsZqIxkHb5JBZQJjGY4dRMLI0XtDKv50J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aV5QA1eP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F4FF4AD;
	Fri, 19 Jul 2024 22:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721421565;
	bh=wdxoGL7pDEwrMi5WYM/gz4zFwQgA6TrJDV4yAKbgiFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aV5QA1ePu4dXoQ1PINwtLfWptkvi2+VK+FQvENjjZnqF6owVj09hKagdrJeLgrsRE
	 Z5+Jki5IgwYApiFcgUhpgRErOB0vSYeoUKpl28AewZt2w0OeLCaOvbA2IQTJoLObyH
	 xeH9krGrK91xsOwA2RW+TjtepVIjFrAdmOAZxfNo=
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
Subject: [PATCH v5 1/4] dt-bindings: mfd: Add Analog Devices ADP5585
Date: Fri, 19 Jul 2024 23:39:43 +0300
Message-ID: <20240719203946.22909-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
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
 .../devicetree/bindings/mfd/adi,adp5585.yaml  | 90 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 -
 MAINTAINERS                                   |  7 ++
 3 files changed, 97 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
new file mode 100644
index 000000000000..46487b9144f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -0,0 +1,90 @@
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
+          items:
+            - const: 5
+            - const: 1
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


