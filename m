Return-Path: <linux-pwm+bounces-8748-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGeQBugu82m0yAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8748-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 12:28:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A824A0D37
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 12:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D41E30048F7
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105DF3FFAAA;
	Thu, 30 Apr 2026 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY89LZox"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5D3AEF27;
	Thu, 30 Apr 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544207; cv=none; b=fBdt0opOUh4cULBT3PZiMBiX2aSK+33o/2qjuecZq5uYh2+T9Ekd2541ZgK5deRl5Qud2IQWGmyP/RDuOhOOM/JhW2DYmH0Bk8qiRO2sj3o6Ldi7+dhnxtJWGqDHlVKmCLfyEBcjfhGSE89WNVZHvXd+GCd70CBfszSPUChOSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544207; c=relaxed/simple;
	bh=SzXoHeZ2JO2A1v0yMh2lz7VOrjVQVBsKdfKse2SbmaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELaWCImvPrxKqdOkCe9PqMQHDh1l/66zPg2b+zmKc36PlLs9/QWEr1v/CpvOFpzoq8vJsUJIxy82scGFOtOofymIvaFy1804GtS1bQCoxFdKUKgX/Kg0iYbOJ+d7KkMCLza3JSiPjKNP61waSA7FEzCtkIBVQnjp7Mx8eDqc7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY89LZox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84941C2BCC4;
	Thu, 30 Apr 2026 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777544207;
	bh=SzXoHeZ2JO2A1v0yMh2lz7VOrjVQVBsKdfKse2SbmaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SY89LZoxqbPx/0NzMvjCpclkPjKp7rCPCg/jVoMv2eLKEju+fW69CYBox0JZAsi2Q
	 updeypErgdJVJdmryuyE+0zyEmvWQZnx2BauDqi4BD2JImB3Xu0+2g8W/w9R3BHO7S
	 MKN4R6ULlpAcgR99N1g+J3SpN48TdbqKpxwFCJuGqhAEHAS/INDdjpblv9yGbz4eqr
	 r64Js+b8s8wJq4LvWmLJR1Ao32yucjQce/Eos/b5HfJo38p+0+QZ9mHz3AvqVRGESU
	 U5LR2dLhDiGH1OAmkKaqiVMKJ7hilL5FSrjyN6qLoAAO4wvfQ3+NK3kIiF6RlFc5jw
	 ApumQ0khl9M2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72664FF8875;
	Thu, 30 Apr 2026 10:16:47 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 30 Apr 2026 13:16:43 +0300
Subject: [PATCH v9 1/6] dt-bindings: iio: adc: add AD4691 family
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-ad4692-multichannel-sar-adc-driver-v9-1-33e439e4fb87@analog.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777544205; l=7809;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=in2Pz2zrVtt7NdRLvF8Xhl9sdHh3Xa8lcwA/A28P4+k=;
 b=TutOXnWw7x1c6qBxtjhfUfKxum4kUFQhafVvQLVyjGMQijKvEJ8SbJZZPHriqUYXSJWVya/zd
 nXPJPv1ye7AD2jTelodsckKq60lggikT9xVFJVSgK0hiAXwaZzW/Xv9
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 98A824A0D37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8748-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.812];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,analog.com:mid,analog.com:email,analog.com:replyto,analog.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,devicetree.org:url]

From: Radu Sabau <radu.sabau@analog.com>

Add DT bindings for the Analog Devices AD4691 family of multichannel
SAR ADCs (AD4691, AD4692, AD4693, AD4694).

The binding describes the hardware connections:

- Power domains: avdd-supply (required), vio-supply, ref-supply or
  refin-supply (external reference; the REFIN path enables the
  internal reference buffer). Digital core VDD is supplied either
  externally via vdd-supply, or generated by the on-chip LDO fed
  from ldo-in-supply; the two are mutually exclusive and one must
  be present.

- Optional PWM on the CNV pin selects CNV Burst Mode; when absent,
  Manual Mode is assumed with CNV tied to SPI CS.

- An optional reset GPIO (reset-gpios) for hardware reset.

- Up to four GP pins (gp0..gp3) usable as interrupt sources,
  identified in firmware via interrupt-names "gp0".."gp3".

- gpio-controller with #gpio-cells = <2> for GP pin GPIO usage.

- #trigger-source-cells = <1>: one cell selecting the GP pin number
  (0-3) used as the SPI offload trigger source.

Two binding examples are provided: CNV Burst Mode with SPI offload
(DMA data acquisition driven by DATA_READY on a GP pin), and Manual
Mode for CPU-driven triggered-buffer or single-shot capture.

The four variants are not compatible with each other: AD4691/AD4692 have
16 analog input channels while AD4693/AD4694 have 8, and AD4691/AD4693
top out at 500 kSPS while AD4692/AD4694 reach 1 MSPS. These differences
in channel count and maximum sample rate require distinct compatible
strings so the driver can select the correct channel configuration and
rate limits.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 180 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 187 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
new file mode 100644
index 000000000000..af28a0c1cfa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4691.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4691 Family Multichannel SAR ADCs
+
+maintainers:
+  - Radu Sabau <radu.sabau@analog.com>
+
+description: |
+  The AD4691 family are high-speed, low-power, multichannel successive
+  approximation register (SAR) analog-to-digital converters (ADCs) with
+  an SPI-compatible serial interface. The ADC supports CNV Burst Mode,
+  where an external PWM drives the CNV pin, and Manual Mode, where CNV
+  is directly tied to the SPI chip-select.
+
+  Datasheets:
+    * https://www.analog.com/en/products/ad4691.html
+    * https://www.analog.com/en/products/ad4692.html
+    * https://www.analog.com/en/products/ad4693.html
+    * https://www.analog.com/en/products/ad4694.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4691
+      - adi,ad4692
+      - adi,ad4693
+      - adi,ad4694
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 40000000
+
+  spi-cpol: true
+  spi-cpha: true
+
+  avdd-supply:
+    description: Analog power supply (4.5V to 5.5V).
+
+  vdd-supply:
+    description:
+      External 1.8V digital core supply. When present, the internal LDO is
+      disabled (LDO_EN = 0). Mutually exclusive with ldo-in-supply.
+
+  ldo-in-supply:
+    description:
+      LDO input supply (2.4V to 5.5V). When present and vdd-supply is absent,
+      the internal LDO generates 1.8V VDD from this input (LDO_EN = 1).
+      Mutually exclusive with vdd-supply.
+
+  vio-supply:
+    description: I/O voltage supply (1.71V to 1.89V or VDD).
+
+  ref-supply:
+    description: External reference voltage supply (2.4V to 5.25V).
+
+  refin-supply:
+    description: Internal reference buffer input supply.
+
+  reset-gpios:
+    description:
+      GPIO line controlling the hardware reset pin (active-low).
+    maxItems: 1
+
+  pwms:
+    description:
+      PWM connected to the CNV pin. When present, selects CNV Burst Mode where
+      the PWM drives the conversion rate. When absent, Manual Mode is used
+      (CNV tied to SPI CS).
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt lines connected to the ADC GP pins. Each GP pin can be
+      physically wired to an interrupt-capable input on the SoC.
+    maxItems: 4
+
+  interrupt-names:
+    description: Names of the interrupt lines, matching the GP pin names.
+    minItems: 1
+    maxItems: 4
+    items:
+      enum:
+        - gp0
+        - gp1
+        - gp2
+        - gp3
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  '#trigger-source-cells':
+    description:
+      This node can act as a trigger source. The single cell in a consumer
+      reference specifies the GP pin number (0-3) used as the trigger output.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - vio-supply
+
+allOf:
+  # vdd-supply and ldo-in-supply are mutually exclusive, one is required:
+  # either an external 1.8V VDD is provided or the internal LDO is fed from
+  # ldo-in-supply to generate VDD.
+  - oneOf:
+      - required:
+          - vdd-supply
+      - required:
+          - ldo-in-supply
+  # ref-supply and refin-supply are mutually exclusive, one is required
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    /* AD4692 in CNV Burst Mode with SPI offload */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4692";
+            reg = <0>;
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <40000000>;
+
+            avdd-supply = <&avdd_supply>;
+            ldo-in-supply = <&avdd_supply>;
+            vio-supply = <&vio_supply>;
+            ref-supply = <&ref_5v>;
+
+            reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+
+            pwms = <&pwm_gen 0 0>;
+
+            #trigger-source-cells = <1>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    /* AD4692 in Manual Mode (CNV tied to SPI CS) */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4692";
+            reg = <0>;
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <31250000>;
+
+            avdd-supply = <&avdd_supply>;
+            ldo-in-supply = <&avdd_supply>;
+            vio-supply = <&vio_supply>;
+            refin-supply = <&refin_supply>;
+
+            reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..438ca850fa1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1484,6 +1484,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
 F:	drivers/iio/adc/ad4170-4.c
 
+ANALOG DEVICES INC AD4691 DRIVER
+M:	Radu Sabau <radu.sabau@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>

-- 
2.43.0



