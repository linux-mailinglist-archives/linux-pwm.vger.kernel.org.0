Return-Path: <linux-pwm+bounces-8186-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO0LBpN2qWl77wAAu9opvQ
	(envelope-from <linux-pwm+bounces-8186-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:26:59 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6D2119A2
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653F730AD186
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875E39D6FB;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdfs+4PC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3539A7EC;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713415; cv=none; b=VGR90J3NSoQ6QaDya8UOhKBugBUxVPVGp2KJ9xd2gFUAx44HIGy6BMHNX82cqi2sNNAv9e/bTr5UweE0tesGMgdwgey8MrkVqwG+4W3S0k9V6RwFJJOnpPDMB7u0HnZ/RXKaAfImTSGzJmazrPs9EuWv5VBFyYbaPeqnUx5todU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713415; c=relaxed/simple;
	bh=MRMcRh6OYKlvw86W26MLmjms1YLqtLMi4wr68wds6UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFMRh8rLhfPhJfqCto1UYv2PyL/abAAUXz6XwIRSWPoqYkgQco8w/Q6r0vYklksicrPtcXd6Ce75whWF9pmeYxI3/eprpRW8u0hzTsMtMAibiwpHohiGPDP7bnaCB+jxfnLDWuqevtuL9fiOmXtBkZ6WeJMoJY81M5Cddih6Oxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdfs+4PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43081C2BC87;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772713415;
	bh=MRMcRh6OYKlvw86W26MLmjms1YLqtLMi4wr68wds6UU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bdfs+4PCSKnuT1+OluZ50TWpc2guMBpUSOGLrOfRlDRGCLTvXP+AQmbt8vyHIftEK
	 hAHYcKNhGuqZ/cYR77WYQlJH9xLWHBijSE0jNqeSiVeylbb3BI5diNLob4zDfzJ3ra
	 GYFnO4S73sJuPJqL67GFNejHKBI7nkE/WBw1QarWn8Sh7OqX+RvyAQcM389cjiMeZw
	 s3hq8XJ647YAyWiH9R+AWTxBTl2evLaWb++wq2elAGtbI4c50sej4b0Jd54EwlQlRO
	 D2mIxlva/EaubFNiJTIZHutktyZOYwYfa84r3xHLcD/98UA32j2QhHBExa8HW21LI5
	 GtNFl0fw5FO3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CACAF30956;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 05 Mar 2026 14:23:27 +0200
Subject: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691 family
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772713413; l=10122;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=lsINb5qT8O5iLIY36KaeYf7LKPIGXET2nXgZufTpeWU=;
 b=AX6kACPh4Wvnmru2wcsCLTF6WOCvYBofqGrkbFkq7sq110JY0cEdluBcLZ8ecbDNgBQO5Fp40
 f5SRk0xp+VjCk3/6ncUahK1V/DW/u+pp26YpMZL7vytcaDrbDsoaCfu
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: B4E6D2119A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8186-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,devicetree.org:url,analog.com:replyto,analog.com:email,analog.com:url,analog.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Radu Sabau <radu.sabau@analog.com>

Add YAML bindings and dt-bindings header for the Analog Devices AD4691
family of multichannel SAR ADCs (AD4691, AD4692, AD4693, AD4694).

The binding describes five operating modes selectable via the
adi,spi-mode property, optional PWM/clock for CNV Clock and CNV Burst
modes, GPIO pins, voltage supplies and the trigger-source interface for
SPI Engine offload operation.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 278 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +
 include/dt-bindings/iio/adc/adi,ad4691.h           |  13 +
 3 files changed, 299 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
new file mode 100644
index 000000000000..b0d8036184b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
@@ -0,0 +1,278 @@
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
+  an SPI-compatible serial interface. The family supports multiple operating
+  modes including CNV Clock Mode, CNV Burst Mode, Autonomous Mode, SPI Burst
+  Mode, and Manual Mode.
+
+  The driver supports both standard SPI and SPI Engine (offload) operation.
+
+  Datasheets:
+    * https://www.analog.com/en/products/ad4692.html
+    * https://www.analog.com/en/products/ad4691.html
+    * https://www.analog.com/en/products/ad4694.html
+    * https://www.analog.com/en/products/ad4693.html
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
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4]
+    description: |
+      Selects the ADC operating mode:
+        0 - CNV Clock Mode: External PWM drives CNV pin, samples at PWM rate.
+        1 - CNV Burst Mode: PWM triggers burst cycles, internal oscillator
+            drives conversions within each burst.
+        2 - Autonomous Mode: Internal oscillator drives conversions, software
+            starts/stops via register write.
+        3 - SPI Burst Mode: Similar to Autonomous Mode but optimized for
+            SPI burst reads.
+        4 - Manual Mode: CNV is directly tied to SPI CS. Each SPI transfer
+            triggers a conversion and returns previous result (pipelined).
+
+  vio-supply:
+    description: I/O voltage supply (1.71V to 1.89V or VDD).
+
+  vref-supply:
+    description:
+      External reference voltage supply (2.4V to 5.25V). Mutually exclusive
+      with vrefin-supply.
+
+  vrefin-supply:
+    description:
+      Internal reference buffer input supply. Mutually exclusive with
+      vref-supply.
+
+  reset-gpios:
+    description: GPIO connected to the RESET pin (active high).
+    maxItems: 1
+
+  gp0-gpios:
+    description:
+      GPIO connected to the GP0 pin. Required for non-offload operation to
+      receive DATA_READY or BUSY interrupts. For SPI Engine offload, this
+      is optional as the trigger is provided by the SPI offload subsystem.
+    maxItems: 1
+
+  gp1-gpios:
+    description: GPIO connected to the GP1 pin.
+    maxItems: 1
+
+  gp2-gpios:
+    description: GPIO connected to the GP2 pin.
+    maxItems: 1
+
+  gp3-gpios:
+    description: GPIO connected to the GP3 pin.
+    maxItems: 1
+
+  clocks:
+    description: Reference clock for PWM timing in CNV Clock and CNV Burst modes.
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref_clk
+
+  pwms:
+    description:
+      PWM connected to the CNV pin. Required for CNV Clock Mode and CNV Burst
+      Mode to control conversion timing.
+    maxItems: 1
+
+  pwm-names:
+    items:
+      - const: cnv
+
+  interrupts:
+    description:
+      Interrupt from the GP0 pin configured as DATA_READY or BUSY. Required
+      for non-offload operation in all modes except Manual Mode (mode 4),
+      where CNV is tied to CS and no DATA_READY signal is generated.
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: DRDY
+
+  '#trigger-source-cells':
+    description: |
+      For SPI Engine offload operation, this node acts as a trigger source.
+      Two cells are required:
+        - First cell: Trigger event type (0 = BUSY, 1 = DATA_READY)
+        - Second cell: GPIO pin number (only 0 = GP0 is supported)
+
+      Macros are available in dt-bindings/iio/adc/adi,ad4691.h:
+        AD4691_TRIGGER_EVENT_BUSY, AD4691_TRIGGER_EVENT_DATA_READY
+        AD4691_TRIGGER_PIN_GP0
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - adi,spi-mode
+  - vio-supply
+  - reset-gpios
+
+allOf:
+  # vref-supply and vrefin-supply are mutually exclusive, one is required
+  - oneOf:
+      - required:
+          - vref-supply
+      - required:
+          - vrefin-supply
+
+  # AD4694 (20-bit) does not support Manual Mode
+  - if:
+      properties:
+        compatible:
+          const: adi,ad4694
+    then:
+      properties:
+        adi,spi-mode:
+          enum: [0, 1, 2, 3]
+
+  # CNV Clock Mode and CNV Burst Mode require PWM and clock
+  - if:
+      properties:
+        adi,spi-mode:
+          enum: [0, 1]
+    then:
+      required:
+        - clocks
+        - clock-names
+        - pwms
+        - pwm-names
+
+  # Non-Manual modes (0-3) without SPI offload require a DRDY interrupt.
+  # Offload configurations expose '#trigger-source-cells' instead.
+  - if:
+      properties:
+        adi,spi-mode:
+          enum: [0, 1, 2, 3]
+      not:
+        required:
+          - '#trigger-source-cells'
+    then:
+      required:
+        - interrupts
+        - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/adc/adi,ad4691.h>
+
+    /* Example: AD4692 in CNV Clock Mode with standard SPI */
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
+            adi,spi-mode = <0>; /* CNV Clock Mode */
+
+            vio-supply = <&vio_supply>;
+            vref-supply = <&vref_5v>;
+
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+            gp0-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+
+            clocks = <&ref_clk>;
+            clock-names = "ref_clk";
+
+            pwms = <&pwm_gen 0 0>;
+            pwm-names = "cnv";
+
+            interrupts = <12 4>;
+            interrupt-names = "DRDY";
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/adc/adi,ad4691.h>
+
+    /* Example: AD4692 in Manual Mode with SPI Engine offload */
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
+            adi,spi-mode = <4>; /* Manual Mode */
+
+            vio-supply = <&vio_supply>;
+            vrefin-supply = <&vrefin_supply>;
+
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/adc/adi,ad4691.h>
+
+    /* Example: AD4691 in Autonomous Mode with SPI Engine offload trigger */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4691";
+            reg = <0>;
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <40000000>;
+
+            adi,spi-mode = <2>; /* Autonomous Mode */
+
+            vio-supply = <&vio_supply>;
+            vref-supply = <&vref_5v>;
+
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+            gp0-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+
+            #trigger-source-cells = <2>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..9994d107d88d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1484,6 +1484,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
 F:	drivers/iio/adc/ad4170-4.c
 
+ANALOG DEVICES INC AD4691 DRIVER
+M:	Radu Sabau <radu.sabau@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+F:	include/dt-bindings/iio/adc/adi,ad4691.h
+
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
diff --git a/include/dt-bindings/iio/adc/adi,ad4691.h b/include/dt-bindings/iio/adc/adi,ad4691.h
new file mode 100644
index 000000000000..294b03974f48
--- /dev/null
+++ b/include/dt-bindings/iio/adc/adi,ad4691.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_ADI_AD4691_H
+#define _DT_BINDINGS_ADI_AD4691_H
+
+/* Trigger event types */
+#define AD4691_TRIGGER_EVENT_BUSY	0
+#define AD4691_TRIGGER_EVENT_DATA_READY	1
+
+/* Trigger GPIO pin selection */
+#define AD4691_TRIGGER_PIN_GP0		0
+
+#endif /* _DT_BINDINGS_ADI_AD4691_H */

-- 
2.43.0



