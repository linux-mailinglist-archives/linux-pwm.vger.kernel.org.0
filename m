Return-Path: <linux-pwm+bounces-4405-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506619F7F67
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A07A2B11
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53123228389;
	Thu, 19 Dec 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DciEccms"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76685226172;
	Thu, 19 Dec 2024 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625320; cv=none; b=bZ0pBv2OhBvW8rLTsuvIl0gbdWfxIZhzXJzDg3/nMgAOR//4ug7eKm8dTzV5rsXAWpQHUbwkWiDP8SKxvKZQQMCwejFk9mduYdxnGnEJFmTmOmi5XlkCeIsILul2C3MlTvq8bfkQ8+YaSnPEv15jpxxP0luzM27x/sFegUgTmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625320; c=relaxed/simple;
	bh=Qs1lXdR3k4hh5hqJDPaLH7psb2FueYZC74dIRlcG+8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KzMbVXt/fb1nGCMj/d6ARVkrqX9lPng5tY5hpf+tHdpsALqpLkfpXd/1SEnkh0aKH2RkaHckXxT1ie1NUYdN+dDx4rrjIu2XpXT4f0nc2NTFDxcr07rWISyc/tAbA4uZW2T5WUbF0w340syWp+QLKxGBiPhRavDnNyRbaOu7h78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DciEccms; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 418FC60009;
	Thu, 19 Dec 2024 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734625310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h31lyABGlYGYdph3DUXih1SNot88N+ffTqw66rva9/s=;
	b=DciEccms/7F/3YzSdPpzpcuxkpEfz0t2W4m9Y7mx4CT2YPYwzHnktZzNXfBjNz21CWGz/u
	LQ2CtQtXFcdXgrSXgdOHJRV9sgEplUCE/5o8FNTMvIpXRPDLfy+F6G2ihnrk11EelUpn6O
	f9C0IyVFPYYEbEtet0uA2FOcwEN/vMX/97RCiG8SgVUpG2M9PurtZcPomwe/iMHCvxUp6x
	wwxa0XPKBoageV6zMe1VcHzY1o6qrUSobHpf7fFY1an/ZKRwyTM6evGNCAbJ8Xj5O1uihE
	zU7Icj+c98YK1GIlKSXnhuRYXFLm2+fPUsiD0nLHnOCedRBtoF2rEiEHhJJAQg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 19 Dec 2024 17:21:19 +0100
Subject: [PATCH 2/8] dt-bindings: Add MAX7360 subdevices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-mdb-max7360-support-v1-2-8e8317584121@bootlin.com>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
In-Reply-To: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734625307; l=7491;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Qs1lXdR3k4hh5hqJDPaLH7psb2FueYZC74dIRlcG+8Q=;
 b=tSuhYavHF7GT3CZ1THiMbRIustPw4CMj9MIV/4fHTCqcjTqobpVHSEJWUoGMUNQLZBXd5vi6l
 gRNCp945UCFBxthmnr2hvx2idlWCBo1iWzBWB6eYF27BwEg48u/clSL
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add device tree bindings for Maxim Integrated MAX7360 MFD functions:
keypad, rotary, gpios and pwm.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../devicetree/bindings/gpio/max7360-gpio.yaml     | 96 ++++++++++++++++++++++
 .../devicetree/bindings/input/max7360-keypad.yaml  | 67 +++++++++++++++
 .../devicetree/bindings/input/max7360-rotary.yaml  | 52 ++++++++++++
 .../devicetree/bindings/pwm/max7360-pwm.yaml       | 35 ++++++++
 4 files changed, 250 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
new file mode 100644
index 000000000000..3c006dc0380b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/max7360-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX7360 GPIO controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+
+description: |
+  Maxim MAX7360 GPIO controller, in MAX7360 MFD
+  https://www.analog.com/en/products/max7360.html
+
+properties:
+  compatible:
+    enum:
+      - maxim,max7360-gpio
+      - maxim,max7360-gpo
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  ngpios:
+    minimum: 0
+    maximum: 8
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    description: The interrupt line the device is connected to.
+    maxItems: 1
+
+  constant-current-disable:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Bit field, each bit disables constant-current output of the
+                 associated GPIO.
+
+
+required:
+  - compatible
+  - gpio-controller
+  - ngpios
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - maxim,max7360-gpio
+then:
+  required:
+    - interrupt-controller
+    - interrupts
+else:
+  properties:
+    interrupt-controller: false
+    interrupts: false
+    constant-current-disable: false
+
+    ngpios:
+      maximum: 6
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    max7360_gpo: max7360_gpo {
+            compatible = "maxim,max7360-gpo";
+            gpio-controller;
+            #gpio-cells = <0x2>;
+            ngpios = <4>;
+    };
+
+    max7360_gpio: max7360_gpio {
+            compatible = "maxim,max7360-gpio";
+
+            gpio-controller;
+            #gpio-cells = <0x2>;
+            ngpios = <8>;
+            constant-current-disable = <0x06>;
+
+            interrupt-controller;
+            #interrupt-cells = <0x2>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+    };
diff --git a/Documentation/devicetree/bindings/input/max7360-keypad.yaml b/Documentation/devicetree/bindings/input/max7360-keypad.yaml
new file mode 100644
index 000000000000..8bc3c841465b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max7360-keypad.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/max7360-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX7360 Keypad Controller
+
+maintainers:
+  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+
+description: |
+  Maxim MAX7360 Keypad Controller, in MAX7360 MFD
+  https://www.analog.com/en/products/max7360.html
+
+allOf:
+  - $ref: matrix-keymap.yaml#
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max7360-keypad
+
+  interrupts:
+    description: The interrupt line the device is connected to.
+    maxItems: 1
+
+  debounce-delay-ms:
+    description: Debounce delay in ms
+    minimum: 9
+    maximum: 40
+    default: 9
+
+  linux,input-no-autorepeat:
+    description: If present, the keys will not autorepeat when pressed
+
+required:
+  - compatible
+  - interrupts
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/input/input.h>
+
+    max7360_keypad {
+      compatible = "maxim,max7360-keypad";
+
+      keypad,num-rows = <8>;
+      keypad,num-columns = <4>;
+
+      linux,keymap = <
+        MATRIX_KEY(0x00, 0x00, KEY_F5)
+        MATRIX_KEY(0x01, 0x00, KEY_F4)
+        MATRIX_KEY(0x02, 0x01, KEY_F6)
+        >;
+
+      interrupt-parent = <&gpio1>;
+      interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+
+      debounce-delay-ms = <10>;
+      linux,input-no-autorepeat;
+    };
diff --git a/Documentation/devicetree/bindings/input/max7360-rotary.yaml b/Documentation/devicetree/bindings/input/max7360-rotary.yaml
new file mode 100644
index 000000000000..19afa8344249
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max7360-rotary.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/max7360-rotary.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX7360 Rotary Encoder
+
+maintainers:
+  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+
+description: |
+  Maxim MAX7360 Rotary Encoder, in MAX7360 MFD
+  https://www.analog.com/en/products/max7360.html
+
+properties:
+  compatible:
+    enum:
+      - maxim,max7360-rotary
+
+  interrupts:
+    description: The interrupt line the device is connected to.
+    maxItems: 1
+
+  debounce-delay-ms:
+    description: Debounce delay in ms
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  linux,axis:
+    description: The input subsystem axis to map to this rotary encoder.
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    max7360_rotary: max7360_rotary {
+      compatible = "maxim,max7360-rotary";
+
+      debounce-delay-ms = <2>;
+      linux,axis = <0>; /* REL_X */
+
+      interrupt-parent = <&gpio1>;
+      interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/max7360-pwm.yaml b/Documentation/devicetree/bindings/pwm/max7360-pwm.yaml
new file mode 100644
index 000000000000..68d48969e542
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/max7360-pwm.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/max7360-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX7360 PWM controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+
+description: |
+  Maxim MAX7360 PWM controller, in MAX7360 MFD
+  https://www.analog.com/en/products/max7360.html
+
+properties:
+  compatible:
+    enum:
+      - maxim,max7360-pwm
+
+  "#pwm-cells":
+    const: 2
+
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    max7360_pwm: max7360_pwm {
+      compatible = "maxim,max7360-pwm";
+      #pwm-cells = <2>;
+    };

-- 
2.39.5


