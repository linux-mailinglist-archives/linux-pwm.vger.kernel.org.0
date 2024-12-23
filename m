Return-Path: <linux-pwm+bounces-4461-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B709FB322
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7191634DA
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264A1B86F7;
	Mon, 23 Dec 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WHZUpT10"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFB1B4148;
	Mon, 23 Dec 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972229; cv=none; b=B+sSaBqhMVtgtIW2/ECCTeVASu7Jetk2IPeO8s0hA4qEtuZX7aGxKSNc6Fxgq/plfF8f92Xf7McInwJkCBbgmqgr9LduDAWQAJOujgSOQx5ptaBkzoT+69DFIdZzAXsSIMQpF8tlqxyN2ddlO5jLI1jJDPArn7BtCAkMs2TI+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972229; c=relaxed/simple;
	bh=CZiV42ZWY3zvMjvpv8bsipxgqWNMfYqajRQcsEttWuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvnSk80lJycinxUmJcxN/F8ozqfyyHGCYY1+0jnkqqKAb+uArlJ+WEkerQGBIGKEqmLs/0egrIwAHwZGwOkuCJC7H0DpplT7rUdNHLHcy+PIN2QDAX47z0NzLbNyl8yVmR8MLC7hWY1XNIZ0GpRmz2lrXo0XMk6fRJRD+/oHcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WHZUpT10; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D34460008;
	Mon, 23 Dec 2024 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734972220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhRAXpMS4GzNSWTa+/F4Gj3z8L9Pwz1FtYS+mLdeAUM=;
	b=WHZUpT10flBdgtDElqw7pecfD6NElmZa+Jk19mZ7ZDklltgsdkbfTYYXvOwiHb4oOElQRD
	Azc1AB3269h0kCHg84Av3Eo3Hmci4VL35XQUIfrlhI3KCQ+TXF3agjYGpmG52EwoOixON5
	cPGKEHBCDT6D23kaVGG1sGFYZDkhUiabx309HYwjwH/nOX3GUsyrMuPOmxc1jgGvTJ9F8F
	TC2iGhdVIeEQyinp9SakIh1enrHTfx9ox/YZt4EzWp7Idx7uy8u3/VXSJDuPIEkSNhu3LI
	h1sf0RtxzQlXXB2uSrzpv2UONvuNIMajWo8nhgjgzjc16Ced6M8nOlP8YqdFag==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 23 Dec 2024 17:42:33 +0100
Subject: [PATCH v2 1/7] dt-bindings: mfd: gpio: Add MAX7360
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-mdb-max7360-support-v2-1-37a8d22c36ed@bootlin.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
In-Reply-To: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734972218; l=5227;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=CZiV42ZWY3zvMjvpv8bsipxgqWNMfYqajRQcsEttWuY=;
 b=P8BEZ72ZQEzP4FsSqyqzppANK1XnhpwzdXMkfIUP6cnbtnIT8U+lrjS7H7UNIEzW/C6Nfw4nm
 F/SOxtISxSuDIzM7fXcSzF4yw/G7F/oogCuQcZZpSbYABQCIY4gXuCp
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add device tree bindings for Maxim Integrated MAX7360 device with
support for keypad, rotary, gpios and pwm functionalities.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../bindings/gpio/maxim,max7360-gpio.yaml          |  80 +++++++++++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 107 +++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
new file mode 100644
index 000000000000..6e6133ce6e68
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
@@ -0,0 +1,80 @@
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
+    description: |
+      Bit field, each bit disables constant-current output of the associated
+      GPIO, starting from the least significant bit for the first GPIO.
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
+      #gpio-cells = <0x2>;
+      ngpios = <8>;
+      maxim,constant-current-disable = <0x06>;
+
+      interrupt-controller;
+      #interrupt-cells = <0x2>;
+      };
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
new file mode 100644
index 000000000000..1f761707070a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
@@ -0,0 +1,107 @@
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
+    minItems: 2
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
+      };
+    };

-- 
2.39.5


