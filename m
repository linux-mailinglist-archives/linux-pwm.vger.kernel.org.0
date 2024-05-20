Return-Path: <linux-pwm+bounces-2193-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE148CA303
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 22:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE451C2162C
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42C139CF8;
	Mon, 20 May 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RlALjiGU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1313958B;
	Mon, 20 May 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235197; cv=none; b=ayWImph2yJnn8UcifSxCNpi7NOGWAjih45jXKEdj/pFMmrdFpJU3pE6Tm90ccj0OXrQdFVGlW3AVmQd8BHcaNtmmE5GW7Swi84T+4+qpU6VDIR426Vf1bG/831xFHfg9/J0aXPLdfqB1j1Z1S+RIda7tqH8skK6qPbeB5VxEUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235197; c=relaxed/simple;
	bh=bvqH2VGBWZ/am0ARAWuB70w1rkZaIjolzu7wdeNlU+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMD5Rq6wIF2H8cx0KMXoa3EwaGGzRbHRqlSvZ/If48+kcsI8dC6QlU8ze3bHOH4jpbhqX7eP5EauRusmX+nJ3Fh0GsZTrL0beyW0dtVjpVCSR1kbuZlJmBC6N87VTbJeBuk8UqlyFgfW4NDrGGSsadkqb+Ca3NwwX2zUIXWEfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RlALjiGU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 02320FD6;
	Mon, 20 May 2024 21:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716235182;
	bh=bvqH2VGBWZ/am0ARAWuB70w1rkZaIjolzu7wdeNlU+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RlALjiGUW2i9f4kOygS6wA7SF/zkUtTOxtGbYR7aP+5NQY7cpihYSQfnNQhxDnt2i
	 KgT9X2SKjtRHlEu1J3MTRC+nSaSKTbBjA29ROPfzDxT+ngqpsbPGZrCsLQCf2iPOEq
	 SFBJMvbW85pgfCj5s4MT6D19Gvofk5vyzo9q9xDU=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 2/5] dt-bindings: Add bindings for the Analog Devices ADP5585
Date: Mon, 20 May 2024 22:59:38 +0300
Message-ID: <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
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

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
I've limited the bindings to GPIO and PWM as I lack hardware to design,
implement and test the rest of the features the chip supports.
---
 .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
 .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++++++++++++
 .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
 MAINTAINERS                                   |   7 ++
 4 files changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml

diff --git a/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
new file mode 100644
index 000000000000..210e4d53e764
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADP5585 GPIO Expander
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+description: |
+  The Analog Devices ADP5585 has up to 11 GPIOs represented by a "gpio" child
+  node of the parent MFD device. See
+  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further details as
+  well as an example.
+
+properties:
+  compatible:
+    const: adi,adp5585-gpio
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-reserved-ranges: true
+
+required:
+  - compatible
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
new file mode 100644
index 000000000000..217c038b2842
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -0,0 +1,117 @@
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
+description: |
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
+  gpio:
+    $ref: /schemas/gpio/adi,adp5585-gpio.yaml
+
+  pwm:
+    $ref: /schemas/pwm/adi,adp5585-pwm.yaml
+
+required:
+  - compatible
+  - reg
+  - gpio
+  - pwm
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,adp5585-01
+    then:
+      properties:
+        gpio:
+          properties:
+            gpio-reserved-ranges: false
+    else:
+      properties:
+        gpio:
+          properties:
+            gpio-reserved-ranges:
+              items:
+                - const: 5
+                - const: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mfd@34 {
+            compatible = "adi,adp5585-00", "adi,adp5585";
+            reg = <0x34>;
+
+            gpio {
+                compatible = "adi,adp5585-gpio";
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-reserved-ranges = <5 1>;
+            };
+
+            pwm {
+                compatible = "adi,adp5585-pwm";
+                #pwm-cells = <3>;
+            };
+        };
+    };
+
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mfd@34 {
+            compatible = "adi,adp5585-01", "adi,adp5585";
+            reg = <0x34>;
+
+            vdd-supply = <&reg_3v3>;
+
+            gpio {
+                compatible = "adi,adp5585-gpio";
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            pwm {
+                compatible = "adi,adp5585-pwm";
+                #pwm-cells = <3>;
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml b/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
new file mode 100644
index 000000000000..351a9d5da566
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/adi,adp5585-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADP5585 PWM Generator
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+description: |
+  The Analog Devices ADP5585 generates a PWM output with configurable frequency
+  and duty cycle represented by a "pwm" child node of the parent MFD device.
+  See Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further
+  details as well as an example.
+
+allOf:
+  - $ref: /schemas/pwm/pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,adp5585-pwm
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - "#pwm-cells"
+
+additionalProperties: false
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 28e20975c26f..afecdb82e783 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -497,6 +497,13 @@ F:	drivers/leds/leds-adp5520.c
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


