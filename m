Return-Path: <linux-pwm+bounces-6862-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A5B0E1A6
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 18:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14C63A1FED
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3DE27B50F;
	Tue, 22 Jul 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EiWdBSat"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D92185E4A;
	Tue, 22 Jul 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201448; cv=none; b=ltOZCHmyfjBAs+W9i8X0FQF8kO2zorirDZdaZrx9a0Qem/R/p9zK4sHMw/GFI9Mzvix51+z4FmzEIKXHMF+Im0qqOwRC+V0dZdaOXFGWlj9ZABSzWNJRgUmcA+2NC13Lgn27cURKPzulsljhoL0AwyFTDmY9CDKgqo2IF/XqrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201448; c=relaxed/simple;
	bh=wprZAh4BLREySU3+zEXoQ34/ISWzpqaxjbFXM1cNUzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DmvYNLtB+yQYy98/dZT4mIM8EbwwfpGcurN8OlQJpBz3I13flsE/D49f7nNGScNbKwx2zCftHqGSSJgZOwtT16EG1Ac3DB2RsDdcwfrBAKZ2UXRCtqnKt3j0zUwcG9ZFRDZZnCDTekuCI+uh616r0wILA5om0CxdtAxt+M2lRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EiWdBSat; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79427442BC;
	Tue, 22 Jul 2025 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753201443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBVnORInjejJx4XhdEI/Ybeem6+PgF2XxE1ECVXz2Tw=;
	b=EiWdBSattn1gU+vvA8S1ASAbOxRPVXN/aTPzNuwQRVWcS75cU/Ymr//UYqhGEDdugKN+IG
	Ffc9pmQnsOi/aKoGekRmfU/eKk8cvlGap08Y2xcRXGMKgejHYCcI3e7SA20k+/iu4CkRX8
	k2t6p7YF9DrGlDs4LTSj7Km1PDCPYRcCzacVGRW2ULC3F4YlZXFKJBAr/zY4qWA80ZCaJv
	irYa38I0zGdBtKHF9FhAPFpqq80ZbfgYTEWYvx3qfSw/NWnHOKd8w1tqxawnNwmJDp2ky3
	bekR0J8yOiX8Ehm5DFcoHu/oLV9gycuVM/fgL/zXsjBYye1u6DgxnFf2/TJDxA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 22 Jul 2025 18:23:45 +0200
Subject: [PATCH v12 01/10] dt-bindings: mfd: gpio: Add MAX7360
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-mdb-max7360-support-v12-1-3747721a8d02@bootlin.com>
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
In-Reply-To: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753201440; l=8461;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=wprZAh4BLREySU3+zEXoQ34/ISWzpqaxjbFXM1cNUzI=;
 b=0dZV2GKG77C/hqni/fB6rSz2JapPWkl4mhCZtXwBLfECg1qXY8H68vgKenjjH9nUPg8K9xo2i
 40FYPyfeV+XBCC8uNxRGDeG0fcd8LzluWuBpLj+dFEvcy+760V7IjsK
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheejtdfffeegfeelleektedvgefgteegtdejtedutdevteegtdeileefgfdviefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdprghnrghlohhgrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepm
 hifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add device tree bindings for Maxim Integrated MAX7360 device with
support for keypad, rotary, gpios and pwm functionalities.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 +++++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 191 +++++++++++++++++++++
 2 files changed, 274 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
new file mode 100644
index 000000000000..c5c3fc4c816f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
@@ -0,0 +1,83 @@
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
+  The device provides two series of GPIOs, referred here as GPIOs and GPOs.
+
+  PORT0 to PORT7 pins can be used as GPIOs, with support for interrupts and
+  constant-current mode. These pins will also be used by the rotary encoder and
+  PWM functionalities.
+
+  COL2 to COL7 pins can be used as GPOs, there is no input capability. COL pins
+  will be partitioned, with the first pins being affected to the keypad
+  functionality and the last ones as GPOs.
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
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  maxim,constant-current-disable:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bit field, each bit disables constant-current output of the associated
+      GPIO, starting from the least significant bit for the first GPIO.
+    maximum: 0xff
+
+required:
+  - compatible
+  - gpio-controller
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max7360-gpio
+        ngpios: false
+    then:
+      required:
+        - interrupt-controller
+    else:
+      properties:
+        interrupt-controller: false
+        maxim,constant-current-disable: false
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
+      maxim,constant-current-disable = <0x06>;
+
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
new file mode 100644
index 000000000000..3fc920c8639d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
@@ -0,0 +1,191 @@
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
+  rotary-debounce-delay-ms:
+    description: Rotary encoder debounce delay in ms
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  linux,axis:
+    $ref: /schemas/input/rotary-encoder.yaml#/properties/linux,axis
+
+  rotary-encoder,relative-axis:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Register a relative axis rather than an absolute one.
+
+  rotary-encoder,steps:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 24
+    description:
+      Number of steps in a full turnaround of the
+      encoder. Only relevant for absolute axis. Defaults to 24 which is a
+      typical value for such devices.
+
+  rotary-encoder,rollover:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Automatic rollover when the rotary value becomes
+      greater than the specified steps or smaller than 0. For absolute axis only.
+
+  "#pwm-cells":
+    const: 3
+
+  gpio:
+    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
+    description:
+      PORT0 to PORT7 general purpose input/output pins configuration.
+
+  gpo:
+    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
+    description: >
+      COL2 to COL7 general purpose output pins configuration. Allows to use
+      unused keypad columns as outputs.
+
+      The MAX7360 has 8 column lines and 6 of them can be used as GPOs. GPIOs
+      numbers used for this gpio-controller node do correspond to the column
+      numbers: values 0 and 1 are never valid, values from 2 to 7 might be valid
+      depending on the value of the keypad,num-column property.
+
+patternProperties:
+  '-pins$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: /schemas/pinctrl/pincfg-node.yaml
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: '^(PORT[0-7]|ROTARY)$'
+        minItems: 1
+        maxItems: 8
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [gpio, pwm, rotary]
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - linux,keymap
+  - linux,axis
+  - "#pwm-cells"
+  - gpio
+  - gpo
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
+        rotary-encoder,relative-axis;
+
+        #pwm-cells = <3>;
+
+        max7360_gpio: gpio {
+          compatible = "maxim,max7360-gpio";
+
+          gpio-controller;
+          #gpio-cells = <2>;
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
+        };
+
+        backlight_pins: backlight-pins {
+          pins = "PORT2";
+          function = "pwm";
+        };
+      };
+    };

-- 
2.39.5


