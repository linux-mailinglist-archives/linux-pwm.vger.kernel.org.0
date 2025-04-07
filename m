Return-Path: <linux-pwm+bounces-5357-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46EA7DC1D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 13:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794041708D7
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92DD23BCF3;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkv/MT6i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803F22FE08;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024921; cv=none; b=uZwyPWhFTOUxWssa3fOrNmv1LYfU+fWQ0GzLAX1fIT9ABt+NUfQihapuEaO/IG4NluCvoTGzbipsHfgn207iSjIDYpxfYFa46pNNejHsanBQVp8py00Vj1/fLxXzALq+qzDQNOHQC1CW1mxMK3L+UQT9+D5wK9WP9RePjYo1Rf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024921; c=relaxed/simple;
	bh=DIN/ETWrThOgBiv3E1D20hM7c3JilXwWgA7Q2jC/DCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GaWA9nfG/qZw34hU95IDdajeddH1CHoWUxvPB3NiBuknzVHNA73xdWiJrA2AWcATyMrf+dO5damnhRnVPYtA5O/LdgcJG+ef/j/9dPxQhTky5hPaO8sL9VGdpRV98V7Y9pBHpGbwQ6D/4Pgwev8IoDXYgAXe20Rct6AVn8B76/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkv/MT6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 306E5C4CEE7;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744024921;
	bh=DIN/ETWrThOgBiv3E1D20hM7c3JilXwWgA7Q2jC/DCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bkv/MT6iNW3jQSXrBJs1HaUJEYT8OVy51KoFb9t3wZOiQhI2oySsrvL7MH9KSxvQZ
	 +BnW0JAxr13lr/QxO8uFVmcxoXtc67wiAy/1FMs1Cm+JKuOGMCh0Tf+LB/hvba1V1w
	 C3udcSBltzW00WUnvRf2ctzYkKzq2RUCK3RwXmt25Rb6F1ilS/V9VOBzv4Bl9zMrDm
	 yW1mKtlU5uSvAzgPyZHVkQ6uFdyq2qpmpJdGPe1y2I218fY9be7TAKj3sUqg9yXhp3
	 nwYTqnXf+HJbOY3xXHl8D35dxcl0pVi5Ubfa+IlsmK6u13yuncnun+r3sdK4nTszCK
	 uW1SnvgWfSo2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D478C3601E;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 07 Apr 2025 13:21:51 +0200
Subject: [PATCH v9 1/2] dt-bindings: pwm: add support for MC33XS2410
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-mc33xs2410-v9-1-57adcb56a6e4@liebherr.com>
References: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
In-Reply-To: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744024920; l=3391;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=atZyh4aIY1QkrES663/EKCnuh1zQ/qQWrrz7fi0x2TM=;
 b=g5qpSEba1yYt+7zNqXRdVtdsPInXoGwJE79EZ+EHNrJOe5IHOnoVBYFxQPi9YBa82zJwItEzp
 uvH5hLdHzumBlCSITaEIMI/NpEtKDWv4gWoEFOIkePZMHzuFg4XX1nr
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Adding documentation for NXPs MC33XS2410 high side switch.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../devicetree/bindings/pwm/nxp,mc33xs2410.yaml    | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1729fe5c3dfb0dae0006913899a3b901986f43ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,mc33xs2410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: High-side switch MC33XS2410
+
+maintainers:
+  - Dimitri Fedrau <dima.fedrau@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: nxp,mc33xs2410
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  spi-cpha: true
+
+  spi-cs-setup-delay-ns:
+    minimum: 100
+    default: 100
+
+  spi-cs-hold-delay-ns:
+    minimum: 10
+    default: 10
+
+  spi-cs-inactive-delay-ns:
+    minimum: 300
+    default: 300
+
+  reset-gpios:
+    description:
+      GPIO connected to the active low reset pin.
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  pwm-names:
+    items:
+      - const: di0
+      - const: di1
+      - const: di2
+      - const: di3
+
+  pwms:
+    description:
+      Direct inputs(di0-3) are used to directly turn-on or turn-off the
+      outputs.
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      The external clock can be used if the internal clock doesn't meet
+      timing requirements over temperature and voltage operating range.
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Logic supply voltage
+
+  vspi-supply:
+    description:
+      Supply voltage for SPI
+
+  vpwr-supply:
+    description:
+      Power switch supply
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+       pwm@0 {
+           compatible = "nxp,mc33xs2410";
+           reg = <0x0>;
+           spi-max-frequency = <4000000>;
+           spi-cpha;
+           spi-cs-setup-delay-ns = <100>;
+           spi-cs-hold-delay-ns = <10>;
+           spi-cs-inactive-delay-ns = <300>;
+           reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+           #pwm-cells = <3>;
+           pwm-names = "di0", "di1", "di2", "di3";
+           pwms = <&pwm0 0 1000000>,
+                  <&pwm1 0 1000000>,
+                  <&pwm2 0 1000000>,
+                  <&pwm3 0 1000000>;
+           interrupt-parent = <&gpio0>;
+           interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+           clocks = <&clk_ext_fixed>;
+           vdd-supply = <&reg_3v3>;
+           vspi-supply = <&reg_3v3>;
+           vpwr-supply = <&reg_24v0>;
+       };
+    };

-- 
2.39.5



