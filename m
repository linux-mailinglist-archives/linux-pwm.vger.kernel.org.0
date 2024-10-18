Return-Path: <linux-pwm+bounces-3721-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149169A3F5A
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BC01C234EA
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C51D5CDB;
	Fri, 18 Oct 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO+du4mL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C11E49F;
	Fri, 18 Oct 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257578; cv=none; b=Bp0WWOn1yeNcTYbKtfn8ze3yy0h4C9igb9b9Wfs3IXylyhks+TzmxFSM8nnAqgKK3dybqLGBRym32Min2QcF9uC94tpdQUY+jDEfvWZ7IAqFNj1yN8dH5GhSEYhquNScNzZKd2txsmQRLhmeJQ0S+rnr4YqMex1NfyFughvwKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257578; c=relaxed/simple;
	bh=GrfG1jDQUfa9fYmjYVqIGLJiprqJM7qjHzBVK8Ve3Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M85GQf2+EeIZvFa0nT60UsOXPxVn9+T/tAXrqPK4W1Ww3WGAvnsF9osNKRaZPIn3dEgeBY4q/lc2Sgq1yOOPJXk+4FUvBhyEwhrfq09duQ1W/Px6Unx2OW3F6N9r4WmcS4QPHjjL6oPpyeW0A15Ui1ND2bFbhWgQH9ih1g+6cSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO+du4mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C23C4CEC3;
	Fri, 18 Oct 2024 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729257578;
	bh=GrfG1jDQUfa9fYmjYVqIGLJiprqJM7qjHzBVK8Ve3Pw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vO+du4mLbOsj1bOV2j/ImQP2ynxt5IceQWXJfobk1xM2EiZ+72/Zf5fqilZgg5SWg
	 4/7AwLDU3VLT113fBnyIOwpWTo9yKgwXL46pFiOGN+szwUygBFmdyhZJONvZyCk1J9
	 k6U/2mCc2axD8wnP4E+P/Q44i+3eOL0+U2yIMQR/bzKngPGUr7ktsJirLLvjTCPa+6
	 iJ+7ukwgTt/jY5g0Qm4VP0B/S0+AW+T4TemUT895d5EjPOvshPdaAYvO3MXRLsRNC1
	 nLD7pNwzyr2knJl1AzGK/twBydaD8iEnYVjNkWYViZ/o5TeBtVP/A5eDkSiKPCuXzG
	 1qtpjtD/wuc+g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 18 Oct 2024 15:19:03 +0200
Subject: [PATCH v8 2/6] dt-bindings: pinctrl: airoha: Add EN7581 pinctrl
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-en7581-pinctrl-v8-2-b676b966a1d1@kernel.org>
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
In-Reply-To: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce device-tree binding documentation for Airoha EN7581 pinctrl
controller.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/pinctrl/airoha,en7581-pinctrl.yaml    | 400 +++++++++++++++++++++
 1 file changed, 400 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/airoha,en7581-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/airoha,en7581-pinctrl.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b2601d698dcd41c3ef32af547ea41be0d6904ae6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/airoha,en7581-pinctrl.yaml
@@ -0,0 +1,400 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/airoha,en7581-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Pin Controller
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The Airoha's EN7581 Pin controller is used to control SoC pins.
+
+properties:
+  compatible:
+    const: airoha,en7581-pinctrl
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+  - interrupts
+  - gpio-controller
+  - "#gpio-cells"
+  - interrupt-controller
+  - "#interrupt-cells"
+
+patternProperties:
+  '-pins$':
+    type: object
+
+    patternProperties:
+      '^mux(-|$)':
+        type: object
+
+        description:
+          pinmux configuration nodes.
+
+        $ref: /schemas/pinctrl/pinmux-node.yaml
+
+        properties:
+          function:
+            description:
+              A string containing the name of the function to mux to the group.
+            enum: [pon, tod_1pps, sipo, mdio, uart, i2c, jtag, pcm, spi,
+                   pcm_spi, i2s, emmc, pnand, pcie_reset, pwm, phy1_led0,
+                   phy2_led0, phy3_led0, phy4_led0, phy1_led1, phy2_led1,
+                   phy3_led1, phy4_led1]
+
+          groups:
+            description:
+              An array of strings. Each string contains the name of a group.
+
+        required:
+          - function
+          - groups
+
+        allOf:
+          - if:
+              properties:
+                function:
+                  const: pon
+            then:
+              properties:
+                groups:
+                  enum: [pon]
+          - if:
+              properties:
+                function:
+                  const: tod_1pps
+            then:
+              properties:
+                groups:
+                  enum: [pon_tod_1pps, gsw_tod_1pps]
+          - if:
+              properties:
+                function:
+                  const: sipo
+            then:
+              properties:
+                groups:
+                  enum: [sipo, sipo_rclk]
+          - if:
+              properties:
+                function:
+                  const: mdio
+            then:
+              properties:
+                groups:
+                  enum: [mdio]
+          - if:
+              properties:
+                function:
+                  const: uart
+            then:
+              properties:
+                groups:
+                  items:
+                    enum: [uart2, uart2_cts_rts, hsuart, hsuart_cts_rts,
+                           uart4, uart5]
+                  maxItems: 2
+          - if:
+              properties:
+                function:
+                  const: i2c
+            then:
+              properties:
+                groups:
+                  enum: [i2c1]
+          - if:
+              properties:
+                function:
+                  const: jtag
+            then:
+              properties:
+                groups:
+                  enum: [jtag_udi, jtag_dfd]
+          - if:
+              properties:
+                function:
+                  const: pcm
+            then:
+              properties:
+                groups:
+                  enum: [pcm1, pcm2]
+          - if:
+              properties:
+                function:
+                  const: spi
+            then:
+              properties:
+                groups:
+                  items:
+                    enum: [spi_quad, spi_cs1]
+                  maxItems: 2
+          - if:
+              properties:
+                function:
+                  const: pcm_spi
+            then:
+              properties:
+                groups:
+                  items:
+                    enum: [pcm_spi, pcm_spi_int, pcm_spi_rst, pcm_spi_cs1,
+                           pcm_spi_cs2_p156, pcm_spi_cs2_p128, pcm_spi_cs3,
+                           pcm_spi_cs4]
+                  maxItems: 7
+          - if:
+              properties:
+                function:
+                  const: i2c
+            then:
+              properties:
+                groups:
+                  enum: [i2s]
+          - if:
+              properties:
+                function:
+                  const: emmc
+            then:
+              properties:
+                groups:
+                  enum: [emmc]
+          - if:
+              properties:
+                function:
+                  const: pnand
+            then:
+              properties:
+                groups:
+                  enum: [pnand]
+          - if:
+              properties:
+                function:
+                  const: pcie_reset
+            then:
+              properties:
+                groups:
+                  enum: [pcie_reset0, pcie_reset1, pcie_reset2]
+          - if:
+              properties:
+                function:
+                  const: pwm
+            then:
+              properties:
+                groups:
+                  enum: [gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6,
+                         gpio7, gpio8, gpio9, gpio10, gpio11, gpio12, gpio13,
+                         gpio14, gpio15, gpio16, gpio17, gpio18, gpio19,
+                         gpio20, gpio21, gpio22, gpio23, gpio24, gpio25,
+                         gpio26, gpio27, gpio28, gpio29, gpio30, gpio31,
+                         gpio36, gpio37, gpio38, gpio39, gpio40, gpio41,
+                         gpio42, gpio43, gpio44, gpio45, gpio46, gpio47]
+          - if:
+              properties:
+                function:
+                  const: phy1_led0
+            then:
+              properties:
+                groups:
+                  enum: [gpio33, gpio34, gpio35, gpio42]
+          - if:
+              properties:
+                function:
+                  const: phy2_led0
+            then:
+              properties:
+                groups:
+                  enum: [gpio33, gpio34, gpio35, gpio42]
+          - if:
+              properties:
+                function:
+                  const: phy3_led0
+            then:
+              properties:
+                groups:
+                  enum: [gpio33, gpio34, gpio35, gpio42]
+          - if:
+              properties:
+                function:
+                  const: phy4_led0
+            then:
+              properties:
+                groups:
+                  enum: [gpio33, gpio34, gpio35, gpio42]
+          - if:
+              properties:
+                function:
+                  const: phy1_led1
+            then:
+              properties:
+                groups:
+                  enum: [gpio43, gpio44, gpio45, gpio46]
+          - if:
+              properties:
+                function:
+                  const: phy2_led1
+            then:
+              properties:
+                groups:
+                  enum: [gpio43, gpio44, gpio45, gpio46]
+          - if:
+              properties:
+                function:
+                  const: phy3_led1
+            then:
+              properties:
+                groups:
+                  enum: [gpio43, gpio44, gpio45, gpio46]
+          - if:
+              properties:
+                function:
+                  const: phy4_led1
+            then:
+              properties:
+                groups:
+                  enum: [gpio43, gpio44, gpio45, gpio46]
+
+        additionalProperties: false
+
+      '^conf(-|$)':
+        type: object
+
+        description:
+          pinconf configuration nodes.
+
+        $ref: /schemas/pinctrl/pincfg-node.yaml
+
+        properties:
+          pins:
+            description:
+              An array of strings. Each string contains the name of a pin.
+            items:
+              enum: [uart1_txd, uart1_rxd, i2c_scl, i2c_sda, spi_cs0, spi_clk,
+                     spi_mosi, spi_miso, gpio0, gpio1, gpio2, gpio3, gpio4,
+                     gpio5, gpio6, gpio7, gpio8, gpio9, gpio10, gpio11, gpio12,
+                     gpio13, gpio14, gpio15, gpio16, gpio17, gpio18, gpio19,
+                     gpio20, gpio21, gpio22, gpio23, gpio24, gpio25, gpio26,
+                     gpio27, gpio28, gpio29, gpio30, gpio31, gpio32, gpio33,
+                     gpio34, gpio35, gpio36, gpio37, gpio38, gpio39, gpio40,
+                     gpio41, gpio42, gpio43, gpio44, gpio45, gpio46,
+                     pcie_reset0, pcie_reset1, pcie_reset2]
+            minItems: 1
+            maxItems: 58
+
+          bias-disable: true
+
+          bias-pull-up: true
+
+          bias-pull-down: true
+
+          input-enable: true
+
+          output-enable: true
+
+          output-low: true
+
+          output-high: true
+
+          drive-open-drain: true
+
+          drive-strength:
+            description:
+              Selects the drive strength for MIO pins, in mA.
+            enum: [2, 4, 6, 8]
+
+        required:
+          - pins
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pinctrl {
+      compatible = "airoha,en7581-pinctrl";
+
+      interrupt-parent = <&gic>;
+      interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+      gpio-controller;
+      #gpio-cells = <2>;
+
+      interrupt-controller;
+      #interrupt-cells = <2>;
+
+      pcie1-rst-pins {
+        conf {
+          pins = "pcie_reset1";
+          drive-open-drain = <1>;
+        };
+      };
+
+      pwm-pins {
+        mux {
+          function = "pwm";
+          groups = "gpio18";
+        };
+      };
+
+      spi-pins {
+        mux {
+          function = "spi";
+          groups = "spi_quad", "spi_cs1";
+        };
+      };
+
+      uart2-pins {
+        mux {
+          function = "uart";
+          groups = "uart2", "uart2_cts_rts";
+        };
+      };
+
+      uar5-pins {
+        mux {
+          function = "uart";
+          groups = "uart5";
+        };
+      };
+
+      mmc-pins {
+        mux {
+          function = "emmc";
+          groups = "emmc";
+        };
+      };
+
+      mdio-pins {
+        mux {
+          function = "mdio";
+          groups = "mdio";
+        };
+
+        conf {
+          pins = "gpio2";
+          output-enable;
+        };
+      };
+    };

-- 
2.47.0


