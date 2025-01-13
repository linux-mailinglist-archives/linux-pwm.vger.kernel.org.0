Return-Path: <linux-pwm+bounces-4596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE7A0B734
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E022D163235
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBCC231A37;
	Mon, 13 Jan 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F3njNEED"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C322AE7E;
	Mon, 13 Jan 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772192; cv=none; b=J6WiKgvkm5+ct2Z5TXQkzxpQriHfxcIjCEciz8MpCFIIAIxWDvzJwgP2JwAdpGW3mc7m3p2XOG5zzhBq1UColxzxhcrI+hYhZko9noPKwOO54/LtsfWr82AM9yGKfIfxEqNkvnGFrn1igYxfRMn4+voiVAlmV856Rivp31NS/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772192; c=relaxed/simple;
	bh=ODglhPFVnVDN8BVGkHDVoqefXYYgnyBsrHtnytIzUrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsXn2i+c09+E37I2WR3nNWF7y0bZFZCy9prgrBZPrjE1oAyHMqmS7PMRMVo8wwuSDZwQiZMT+31iVCl0WLQPnaC2zab4rMdBL4zQsn1UW+dIpIQ7oRVmiPCcEjNW8VQu0vBa7PUsuCoadl615xuEom79+CNkBjX+nWGOwQ8hP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F3njNEED; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C7A124000C;
	Mon, 13 Jan 2025 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736772187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w54nrKtmVpJfltBl3RujGp31pqn4kM3sN6PJMGjGl1Q=;
	b=F3njNEEDVP7zwiV+YOLRH8vLlcvjcRPVG5HRKl1SwopNH6c4clNpclkyETYPgSEYmzzOPW
	tjwH2cSF3uowbe7c23KVlfhjt1Z+eUSDfyTgX9+f1jmL0UY/Hd37d6jbVtLEwPve3Aaa48
	xzJkRhf9jPR55NCP/uvY7V/kQbakKUauEQ+S2BGu/aoyuukgaIqHsJWwOVaIFuE54sM3DL
	Py/fOdj6+49jK9CWBnJ6zf0CcaxkIC1KmO7gIqo62Y4wC4nl81OtCz1EuJqqZreL+yFo8U
	ZTIA7ejx774+KMiE+wNR0mScBrRoyTCJEJkbjvj7JnjfP7dWwcUu8OFZ96ZuMA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 13 Jan 2025 13:42:25 +0100
Subject: [PATCH v3 1/7] dt-bindings: mfd: gpio: Add MAX7360
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mdb-max7360-support-v3-1-9519b4acb0b1@bootlin.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
In-Reply-To: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736772185; l=6813;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ODglhPFVnVDN8BVGkHDVoqefXYYgnyBsrHtnytIzUrU=;
 b=2lS3OIy428EVwKiB5/sLfwGQPUHoun7zGs+glc1ZG0cyPi4eqBZY7/dTt3KF5tVGLem6En+3n
 aI1BlIvQ3uYC5BSTHjfI7eRExwaJJsIcPwm1WWz8oXAQfW43kCggQqJ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add device tree bindings for Maxim Integrated MAX7360 device with
support for keypad, rotary, gpios and pwm functionalities.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../bindings/gpio/maxim,max7360-gpio.yaml          |  90 +++++++++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 140 +++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
new file mode 100644
index 000000000000..95e9ccd455c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/maxim,max7360-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX7360 GPIO controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+
+description: |
+  Maxim MAX7360 GPIO controller, in MAX7360 chipset
+  https://www.analog.com/en/products/max7360.html
+
+  The device provide two series of GPIOs, referred here as GPIOs and GPOs.
+
+  PORT0 to PORT7 pins can be used as GPIOs, with support for interrupts and
+  constant-current mode. These pins will also be used by the torary encoder and
+  PWM functionalities.
+
+  COL2 to COL7 pins can be used as GPOs, there is no input capability. COL pins
+  will be partitionned, with the first pins being affected to the keypad
+  functionality and the last ones as GPOs. This partioning must be described
+  here using the ngpios property.
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
+  maxim,constant-current-disable:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Bit field, each bit disables constant-current output of the associated
+      GPIO, starting from the least significant bit for the first GPIO.
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
+else:
+  properties:
+    interrupt-controller: false
+    maxim,constant-current-disable: false
+
+    ngpios:
+      maximum: 6
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio {
+      compatible = "maxim,max7360-gpio";
+
+      gpio-controller;
+      #gpio-cells = <2>;
+      ngpios = <8>;
+      maxim,constant-current-disable = <0x06>;
+
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
new file mode 100644
index 000000000000..7c50bab8c6d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max7360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX7360 Keypad, Rotary encoder, PWM and GPIO controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+
+description: |
+  Maxim MAX7360 device, with following functions:
+    - keypad controller
+    - rotary controller
+    - GPIO and GPO controller
+    - PWM controller
+
+  https://www.analog.com/en/products/max7360.html
+
+allOf:
+  - $ref: /schemas/input/matrix-keymap.yaml#
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max7360
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: inti
+      - const: intk
+
+  keypad-debounce-delay-ms:
+    description: Keypad debounce delay in ms
+    minimum: 9
+    maximum: 40
+    default: 9
+
+  autorepeat: true
+
+  rotary-debounce-delay-ms:
+    description: Rotary encoder debounce delay in ms
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  linux,axis:
+    description: The input subsystem axis to map to this rotary encoder.
+
+  "#pwm-cells":
+    const: 3
+
+  gpio:
+    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
+    description: >
+      PORT0 to PORT7 general purpose input/output pins configuration.
+
+  gpo:
+    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
+    description: >
+      COL2 to COL7 general purpose output pins configuration.
+      Allows to use unused keypad columns as outputs.
+      The MAX7360 has 8 column lines and 6 of them can be used as GPOs. Value
+      of ngpios must be coherent with the value of keypad,num-columns, as their
+      sum must not exceed the number of physical lines.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - linux,keymap
+  - linux,axis
+  - "#pwm-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      io-expander@38 {
+        compatible = "maxim,max7360";
+        reg = <0x38>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <23 IRQ_TYPE_LEVEL_LOW>,
+                     <24 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-names = "inti", "intk";
+
+        keypad,num-rows = <8>;
+        keypad,num-columns = <4>;
+        linux,keymap = <
+          MATRIX_KEY(0x00, 0x00, KEY_F5)
+          MATRIX_KEY(0x01, 0x00, KEY_F4)
+          MATRIX_KEY(0x02, 0x01, KEY_F6)
+          >;
+        keypad-debounce-delay-ms = <10>;
+        autorepeat;
+
+        rotary-debounce-delay-ms = <2>;
+        linux,axis = <0>; /* REL_X */
+
+        #pwm-cells = <3>;
+
+        max7360_gpio: gpio {
+          compatible = "maxim,max7360-gpio";
+
+          gpio-controller;
+          #gpio-cells = <2>;
+          ngpios = <8>;
+          maxim,constant-current-disable = <0x06>;
+
+          interrupt-controller;
+          #interrupt-cells = <0x2>;
+        };
+
+        max7360_gpo: gpo {
+          compatible = "maxim,max7360-gpo";
+
+          gpio-controller;
+          #gpio-cells = <2>;
+          ngpios = <4>;
+        };
+      };
+    };

-- 
2.39.5


