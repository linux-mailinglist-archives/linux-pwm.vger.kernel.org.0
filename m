Return-Path: <linux-pwm+bounces-4887-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57CA35CF8
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8553E1892331
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E9263F5D;
	Fri, 14 Feb 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YA0s2APU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925525A623;
	Fri, 14 Feb 2025 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533821; cv=none; b=r+yq3XLskUQL0JQHF/65BlX1YUVuOCcmFDo44rz2XrUO3DHZypXTHBh+jlq8C1s+hKnCcAeqm9kNbZ4XdQV0aUP5PWIcec4cAUZLLhN0csqHQnrBh47G7q/UZo2zZdzgnyKmh9/8RJShdLJqPFHQS9eoABsqi9QzDML3wkfq/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533821; c=relaxed/simple;
	bh=4iN68doD3fuxmdxwZZOCLGLep9xA7tPWi7Ap13zkwBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVOZyJktrZ4Xu+JFzVQkLTPrU1HJM1BAKQLF2bsPEzqy/7B4q6wuDjGBZzKSnNKcjvsS4jHbx3/2gxAzU4+RQZdBaDiUL1uvxVi+SDKCdcovVfTbPaB5V/3PywpGmX77jO7cr7EJW272Q6cXV/vT+yYn6YMvFbHkgrnW8Ev3GfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YA0s2APU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 603D543315;
	Fri, 14 Feb 2025 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdVQYpsk+S3y1cmSBqy5oKwPS+bnRUAOfytj1CpgdKA=;
	b=YA0s2APUsrSChhVJ0dtfkDKxt8MsP+Ta4WYrKiChOeV90qon9vr2bCP9jZbqvkE5XkMmFJ
	eItEBvqc3Q91dVnxvmeGAF6YmMtnHMUDuTsxTDLia7PjgoPTrRjow16xKvR0FLgOh/xjwl
	ynO2Yg5Gr65JuLOvTzpqNW+HuUUHuHqH6Tyv9xLWKAsqctGvPNWWwqgUVtBOlYXzIVowxc
	c+5RFW4SuKlYTIuDYkM2IKR78VnXPUTxsQIBw2vH0P63z0czna/L3dmhMyjX8yP3q+kXol
	AWzM14wqVncUzZWnCF4H9XbuoSTrOcLazBcbfmig2dt69CR3vPwfvvLhZ+UWpg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Feb 2025 12:49:51 +0100
Subject: [PATCH v4 01/10] dt-bindings: mfd: gpio: Add MAX7360
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-mdb-max7360-support-v4-1-8a35c6dbb966@bootlin.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
In-Reply-To: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
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
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=6853;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=4iN68doD3fuxmdxwZZOCLGLep9xA7tPWi7Ap13zkwBA=;
 b=MiqBcqTYxprBR3aTieH/Hn5c56g2HISIhRM1q8vJjhnXpakA/pVZxNgycSTwv00Z5Wf51QOg4
 Vn4Kn1rZmj6AqS0OwsAs152iOEIjrcJ3xqe0/UY3GWeWNYzxF7f/ypo
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheejtdfffeegfeelleektedvgefgteegtdejtedutdevteegtdeileefgfdviefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdprghnrghlohhgrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add device tree bindings for Maxim Integrated MAX7360 device with
support for keypad, rotary, gpios and pwm functionalities.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../bindings/gpio/maxim,max7360-gpio.yaml          |  91 ++++++++++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 139 +++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
new file mode 100644
index 000000000000..bdaed7917051
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
@@ -0,0 +1,91 @@
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
+    maximum: 6
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
+      required:
+        - ngpios
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
index 000000000000..4b93a3dd8ae4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
@@ -0,0 +1,139 @@
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
+    description: The input subsystem axis to map to this rotary encoder.
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
+    description:
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
+          ngpios = <4>;
+        };
+      };
+    };

-- 
2.39.5


