Return-Path: <linux-pwm+bounces-2384-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4E9011DC
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2024 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDD82828BC
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4F17B420;
	Sat,  8 Jun 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cRBfYjJr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56917A918;
	Sat,  8 Jun 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856216; cv=none; b=a0DFrxPKkhhljBfz6WGz2eiNGr9hRWdDR6ETsSNhKpIvAnlRKQySGaSwanTQD9HrRjyVPPYMV6hQ9EyKdkI591Xy+ciXuTRoBdl1V3GcEqYBZzZxd2Wafzt/9ALvoAMoP9UatPE5bePsU8RO1oXBy12iFfQKerKU6Wn4//7Iq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856216; c=relaxed/simple;
	bh=oNrZo20bBA/jf1hcrp2F0Ww7Srg5QptpzKeHoilINBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhHBh4FEHTtGKmRFQN5IPHkPfjacBcirikaCmHaU7EZFglHg+SitKLk4xfexxLQpfKdl5HNSnnsG5XHyNFr8D3dCMRagWp6mvs/2BQnHee1uk/SLY8s+QWHj4HIYcugqNCw6gZsiwwZ9beoROXJE7sE0ZXavIkyKXh8YotAaeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cRBfYjJr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C050C1FA4;
	Sat,  8 Jun 2024 16:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717856203;
	bh=oNrZo20bBA/jf1hcrp2F0Ww7Srg5QptpzKeHoilINBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRBfYjJrhamwiJNJB+IKoBpRO37u1NDrOTKBFcmswgxA+hac25/25MJciker28oHR
	 o7nBi1c9fPJiukQZivJv4Wc/wXyAiIKF3NRhj02FZ856M+8V9Q83fBUP7r/9ao2QHC
	 hGE9UURE/COPUHcQA7JN+C/MEevYlJfLrg09O7gc=
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: mfd: Add Analog Devices ADP5585
Date: Sat,  8 Jun 2024 17:16:30 +0300
Message-ID: <20240608141633.2562-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
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

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
I've limited the bindings to GPIO and PWM as I lack hardware to design,
implement and test the rest of the features the chip supports.

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
index 0a419453d183..91e62df4b296 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -39,10 +39,6 @@ properties:
             # AD5110 - Nonvolatile Digital Potentiometer
           - adi,ad5110
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
-          - adi,adp5585
-            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
-          - adi,adp5585-02
-            # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
           - adi,adp5589
             # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
           - adi,lt7182s
diff --git a/MAINTAINERS b/MAINTAINERS
index 08a154941ea4..8ebdde3106d3 100644
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


