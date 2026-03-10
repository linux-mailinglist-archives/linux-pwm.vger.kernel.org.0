Return-Path: <linux-pwm+bounces-8220-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDj1OTs4sGkKhQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8220-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2026 16:26:51 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A72535B1
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2026 16:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9BFF325B0C4
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2026 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F30C2E8897;
	Tue, 10 Mar 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrD4brEu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B52E1747;
	Tue, 10 Mar 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153149; cv=none; b=uxFgPi9QNHDXvPuHvCNgKrEhSt9kDN71mOXTfmSbL0niLml9p69byGqLIX6UOsNxZDrDreATHRdSGwxB4L43i+36JMIrNxkyso3rtW9gyZzw4VaHhJKus6hi0d5gyP90dnrjb46ZhHBL0szyMvKlwEZYhvYTJKXEUbQLqnpqyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153149; c=relaxed/simple;
	bh=GI5A6sIDTkRHuW8a/SgtskqxywWH7KKoxYkTh0qrVok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+7QhdDCKJ1jh/MgtBTgmTgUHqwWyCFU/OsK9K+MsZUCuIBVNjA1MaiKLPM/ebDFLulrZaan6CnKwv3gcrEcn5VjPlXAYo787z4nJMxRZZAj2V5zqaCcsnmlEt3UEhSOdEa/EupGOEfl9qGCyFDxRl2b9XYphFmztH+7xsHqFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrD4brEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 061DAC2BC86;
	Tue, 10 Mar 2026 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773153149;
	bh=GI5A6sIDTkRHuW8a/SgtskqxywWH7KKoxYkTh0qrVok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nrD4brEuF29d2wupLzr69zWPKb5HLsyEOPDdGRCbTmcHTzT3N/2PhaKdf0VBKJXpn
	 p9zdLYdCpvBPjMgdEXMb7h+ewXNN/7165voqn+/a701gUPVBLeTPW4r91cae3GcZ8D
	 FQkV566wccNpQJ43eA6VJBEuC7pjwxQJ9OoVfM8xp8mKcseD2kXrGc/HcU5f04tenD
	 s9Vm6ytmjrOHgBML/lAv76T7S9q1l48+zIRPKreClxnbJsDLsYtoO6IGb+GhYC4mt1
	 Upha/P9+ufeuurALK32lXq56fsOLpJ1WpvvhEodbwSyxCMHEXskTyzZeK3smff3klg
	 Cxw07GeGtnncw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FB6EB105D;
	Tue, 10 Mar 2026 14:32:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Tue, 10 Mar 2026 16:32:22 +0200
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260310-ad4692-multichannel-sar-adc-driver-v2-1-d9bb8aeb5e17@analog.com>
References: <20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com>
In-Reply-To: <20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773153147; l=7296;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=oJ+skzTO+ldVyCAp6LzsSaIW3BVvqyXV5zmKWF0Z/GQ=;
 b=D8lAzbPQKVzrDR2n/+ls243qCuQhUt/LfQ0SrmxeYVQ3wsxaJfNeVr8qu5QRnyCs3MZll1CZw
 nWDbc+FTB5FCnV0m9bitXLZzuKE/Zf9cy8Mfb+oDZsJzkH8Gzg7EEk2
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 5C7A72535B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8220-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.0.0.0:email,devicetree.org:url,analog.com:replyto,analog.com:email,analog.com:url,analog.com:mid]
X-Rspamd-Action: no action

From: Radu Sabau <radu.sabau@analog.com>

Add DT bindings for the Analog Devices AD4691 family of multichannel
SAR ADCs (AD4691, AD4692, AD4693, AD4694).

The binding describes the hardware connections: an optional PWM on
the CNV pin selects CNV Clock Mode; when absent, Manual Mode is used
with CNV tied to SPI CS. GPIO pins, voltage supplies, and the
trigger-source interface for SPI Engine offload operation are also
described.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 180 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +
 include/dt-bindings/iio/adc/adi,ad4691.h           |  13 ++
 3 files changed, 201 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
new file mode 100644
index 000000000000..a9301e0ca851
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
+  an SPI-compatible serial interface. The ADC supports CNV Clock Mode,
+  where an external PWM drives the CNV pin, and Manual Mode, where CNV
+  is directly tied to the SPI chip-select.
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
+  vio-supply:
+    description: I/O voltage supply (1.71V to 1.89V or VDD).
+
+  vref-supply:
+    description: External reference voltage supply (2.4V to 5.25V).
+
+  vrefin-supply:
+    description: Internal reference buffer input supply.
+
+  reset-gpios:
+    description: GPIO connected to the RESET pin (active high).
+    maxItems: 1
+
+  clocks:
+    description: Reference clock for PWM timing in CNV Clock Mode.
+    maxItems: 1
+
+  pwms:
+    description:
+      PWM connected to the CNV pin. When present, selects CNV Clock Mode where
+      the PWM drives the conversion rate. When absent, Manual Mode is used
+      (CNV tied to SPI CS).
+    maxItems: 1
+
+  pwm-names:
+    items:
+      - const: cnv
+
+  interrupts:
+    description:
+      Interrupt line connected to the ADC GP0 pin. GP0 must be physically
+      wired to an interrupt-capable input on the SoC. The ADC asserts GP0 as
+      DATA_READY at end of conversion, used both for non-offload CNV Clock Mode
+      operation and for SPI Engine offload triggering via '#trigger-source-cells'.
+      Not used in Manual Mode, where CNV is tied to SPI CS and no DATA_READY
+      signal is generated.
+    maxItems: 1
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
+  # CNV Clock Mode requires a reference clock.
+  - if:
+      required:
+        - pwms
+    then:
+      required:
+        - clocks
+
+  # CNV Clock Mode (pwms present) without SPI offload requires a DRDY interrupt.
+  # Offload configurations expose '#trigger-source-cells' instead.
+  - if:
+      required:
+        - pwms
+      not:
+        required:
+          - '#trigger-source-cells'
+    then:
+      required:
+        - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* Example: AD4692 in CNV Clock Mode (pwms present) with standard SPI */
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
+            vio-supply = <&vio_supply>;
+            vref-supply = <&vref_5v>;
+
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+
+            clocks = <&ref_clk>;
+
+            pwms = <&pwm_gen 0 0>;
+            pwm-names = "cnv";
+
+            interrupts = <12 4>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* Example: AD4692 in Manual Mode (no pwms) with SPI Engine offload */
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
+            vio-supply = <&vio_supply>;
+            vrefin-supply = <&vrefin_supply>;
+
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
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



