Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD24B6976
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbfIRRcz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 13:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387890AbfIRRcx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Sep 2019 13:32:53 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0F221920;
        Wed, 18 Sep 2019 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568827970;
        bh=bzdMlVuxcLV0UyKPiNchuzEiaOKNsJB+A7E9U0LDlpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0yowP3KQjRQm4ccyQnIKqPZwDMosmKn0kWAAfCaNzU4mMgfVj/oSvaAeRvJBplo6
         7lUp0Ru9ew9P26KpbZCy5IW15/69X0HR7uZsOBZ2TJQJOf2GKPvFICxvF4J+FOnVFd
         DOexEOWa3Q0gLWIrIzSZTySWMLhDAo4Siok7PnVo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 7/8] dt-bindings: pwm: Convert PWM bindings to json-schema
Date:   Wed, 18 Sep 2019 19:31:40 +0200
Message-Id: <20190918173141.4314-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918173141.4314-1-krzk@kernel.org>
References: <20190918173141.4314-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert generic PWM bindings to DT schema format using json-schema.  The
consumer bindings are split to separate file.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Indent example with four spaces (more readable),
2. Change pattern for pwm nodes,
3. Remove $ref from #cells.
---
 .../devicetree/bindings/clock/pwm-clock.txt   |  2 +-
 .../bindings/display/bridge/ti,sn65dsi86.txt  |  2 +-
 .../devicetree/bindings/display/ssd1307fb.txt |  2 +-
 .../bindings/leds/backlight/pwm-backlight.txt |  2 +-
 .../devicetree/bindings/leds/leds-pwm.txt     |  2 +-
 .../devicetree/bindings/mfd/max77693.txt      |  2 +-
 .../bindings/pwm/atmel-hlcdc-pwm.txt          |  2 +-
 .../devicetree/bindings/pwm/atmel-pwm.txt     |  2 +-
 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt |  2 +-
 .../bindings/pwm/brcm,bcm7038-pwm.txt         |  2 +-
 .../bindings/pwm/brcm,iproc-pwm.txt           |  2 +-
 .../devicetree/bindings/pwm/brcm,kona-pwm.txt |  2 +-
 .../devicetree/bindings/pwm/img-pwm.txt       |  2 +-
 .../devicetree/bindings/pwm/imx-pwm.txt       |  2 +-
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt   |  2 +-
 .../bindings/pwm/lpc1850-sct-pwm.txt          |  2 +-
 .../devicetree/bindings/pwm/mxs-pwm.txt       |  2 +-
 .../bindings/pwm/nvidia,tegra20-pwm.txt       |  2 +-
 .../bindings/pwm/nxp,pca9685-pwm.txt          |  2 +-
 .../devicetree/bindings/pwm/pwm-bcm2835.txt   |  2 +-
 .../devicetree/bindings/pwm/pwm-berlin.txt    |  2 +-
 .../bindings/pwm/pwm-consumers.yaml           | 76 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt   |  2 +-
 .../devicetree/bindings/pwm/pwm-hibvt.txt     |  2 +-
 .../devicetree/bindings/pwm/pwm-lp3943.txt    |  2 +-
 .../devicetree/bindings/pwm/pwm-mediatek.txt  |  2 +-
 .../devicetree/bindings/pwm/pwm-meson.txt     |  2 +-
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt  |  2 +-
 .../bindings/pwm/pwm-omap-dmtimer.txt         |  2 +-
 .../devicetree/bindings/pwm/pwm-rockchip.txt  |  2 +-
 .../devicetree/bindings/pwm/pwm-sifive.txt    |  2 +-
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt  |  2 +-
 .../devicetree/bindings/pwm/pwm-stm32.txt     |  2 +-
 .../devicetree/bindings/pwm/pwm-tiecap.txt    |  2 +-
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt  |  2 +-
 .../devicetree/bindings/pwm/pwm-zx.txt        |  2 +-
 Documentation/devicetree/bindings/pwm/pwm.txt | 69 -----------------
 .../devicetree/bindings/pwm/pwm.yaml          | 29 +++++++
 .../bindings/pwm/renesas,pwm-rcar.txt         |  2 +-
 .../bindings/pwm/renesas,tpu-pwm.txt          |  4 +-
 .../devicetree/bindings/pwm/spear-pwm.txt     |  2 +-
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt  |  2 +-
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  2 +-
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  2 +-
 .../devicetree/bindings/pwm/vt8500-pwm.txt    |  2 +-
 .../bindings/regulator/pwm-regulator.txt      |  2 +-
 .../devicetree/bindings/timer/ingenic,tcu.txt |  2 +-
 47 files changed, 150 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm.yaml

diff --git a/Documentation/devicetree/bindings/clock/pwm-clock.txt b/Documentation/devicetree/bindings/clock/pwm-clock.txt
index 83db876b3b90..8a791b6d76a9 100644
--- a/Documentation/devicetree/bindings/clock/pwm-clock.txt
+++ b/Documentation/devicetree/bindings/clock/pwm-clock.txt
@@ -3,7 +3,7 @@ Binding for an external clock signal driven by a PWM pin.
 This binding uses the common clock binding[1] and the common PWM binding[2].
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/pwm/pwm.txt
+[2] Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
 
 Required properties:
 - compatible : shall be "pwm-clock".
diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
index 0a3fbb53a16e..8ec4a7f2623a 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
@@ -21,7 +21,7 @@ Optional properties:
 - #gpio-cells    : Should be two. The first cell is the pin number and
                    the second cell is used to specify flags.
                    See ../../gpio/gpio.txt for more information.
-- #pwm-cells : Should be one. See ../../pwm/pwm.txt for description of
+- #pwm-cells : Should be one. See ../../pwm/pwm.yaml for description of
                the cell formats.
 
 - clock-names: should be "refclk"
diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 27333b9551b3..da9b28153a3c 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -37,7 +37,7 @@ Optional properties:
   - solomon,area-color-enable: Display uses color mode
   - solomon,low-power. Display runs in low power mode
 
-[0]: Documentation/devicetree/bindings/pwm/pwm.txt
+[0]: Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
 
 Examples:
 ssd1307: oled@3c {
diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 64fa2fbd98c9..8dbbadd3af96 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -28,7 +28,7 @@ Optional properties:
                             having to list out every possible value in the
                             brightness-level array.
 
-[0]: Documentation/devicetree/bindings/pwm/pwm.txt
+[0]: Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
 
 Example:
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.txt b/Documentation/devicetree/bindings/leds/leds-pwm.txt
index 6c6583c35f2f..aeaa250668d5 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm.txt
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.txt
@@ -11,7 +11,7 @@ LED sub-node properties:
   specify the period time to be used: <&phandle id period_ns>;
 - pwm-names : (optional) Name to be used by the PWM subsystem for the PWM device
   For the pwms and pwm-names property please refer to:
-  Documentation/devicetree/bindings/pwm/pwm.txt
+  Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
 - max-brightness : Maximum brightness possible for the LED
 - active-low : (optional) For PWMs where the LED is wired to supply
   rather than ground.
diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Documentation/devicetree/bindings/mfd/max77693.txt
index a3c60a7a3be1..1e6318695eb2 100644
--- a/Documentation/devicetree/bindings/mfd/max77693.txt
+++ b/Documentation/devicetree/bindings/mfd/max77693.txt
@@ -38,7 +38,7 @@ Optional properties:
 	 PWM properties should be named "pwms". And number of cell is different
 	 for each pwm device.
 	 To get more information, please refer to documentation.
-	[*] refer Documentation/devicetree/bindings/pwm/pwm.txt
+	[*] refer Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
 
 - charger : Node configuring the charger driver.
   If present, required properties:
diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
index cfda0d57d302..afa501bf7f94 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
@@ -10,7 +10,7 @@ Required properties:
  - pinctrl-0: should contain the pinctrl states described by pinctrl
    default.
  - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
-   bindings defined in pwm.txt in this directory.
+   bindings defined in pwm.yaml in this directory.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
index 591ecdd39c7b..fbb5325be1f0 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
@@ -7,7 +7,7 @@ Required properties:
     - "atmel,sama5d2-pwm"
     - "microchip,sam9x60-pwm"
   - reg: physical base address and length of the controller's registers
-  - #pwm-cells: Should be 3. See pwm.txt in this directory for a
+  - #pwm-cells: Should be 3. See pwm.yaml in this directory for a
     description of the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
index 8031148bcf85..985fcc65f8c4 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
@@ -2,7 +2,7 @@ Atmel TCB PWM controller
 
 Required properties:
 - compatible: should be "atmel,tcb-pwm"
-- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
 - tc-block: The Timer Counter block to use as a PWM chip.
diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
index d9254a6da5ed..0e662d7f6bd1 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
@@ -4,7 +4,7 @@ Required properties:
 
 - compatible: must be "brcm,bcm7038-pwm"
 - reg: physical base address and length for this controller
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description
   of the cells format
 - clocks: a phandle to the reference clock for this block which is fed through
   its internal variable clock frequency generator
diff --git a/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
index 21f75bbd6dae..655f6cd4ef46 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
@@ -6,7 +6,7 @@ Required Properties :
 - compatible: must be "brcm,iproc-pwm"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle + clock specifier pair for the external clock
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a
   description of the cells format.
 
 Refer to clocks/clock-bindings.txt for generic clock consumer properties.
diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
index 8eae9fe7841c..c42eecfc81ed 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
@@ -6,7 +6,7 @@ Required Properties :
 - compatible: should contain "brcm,kona-pwm"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle + clock specifier pair for the external clock
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a
   description of the cells format.
 
 Refer to clocks/clock-bindings.txt for generic clock consumer properties.
diff --git a/Documentation/devicetree/bindings/pwm/img-pwm.txt b/Documentation/devicetree/bindings/pwm/img-pwm.txt
index fade5f26fcac..9db6de97317d 100644
--- a/Documentation/devicetree/bindings/pwm/img-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/img-pwm.txt
@@ -8,7 +8,7 @@ Required properties:
   - clock-names: Must include the following entries.
     - pwm: PWM operating clock.
     - sys: PWM system interface clock.
-  - #pwm-cells: Should be 2. See pwm.txt in this directory for the
+  - #pwm-cells: Should be 2. See pwm.yaml in this directory for the
 	description of the cells format.
   - img,cr-periph: Must contain a phandle to the peripheral control
 	syscon node which contains PWM control registers.
diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index c61bdf8cd41b..22f1c3d8b773 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -6,7 +6,7 @@ Required properties:
   - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
   - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.txt
+- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.yaml
   in this directory for a description of the cells format.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
index 3ba958d764ff..5bf20950a24e 100644
--- a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -3,7 +3,7 @@ Freescale i.MX TPM PWM controller
 Required properties:
 - compatible : Should be "fsl,imx7ulp-pwm".
 - reg: Physical base address and length of the controller's registers.
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of the cells format.
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of the cells format.
 - clocks : The clock provided by the SoC to drive the PWM.
 - interrupts: The interrupt for the PWM controller.
 
diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
index 36e49d4325cd..43d9f4f08a2e 100644
--- a/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
@@ -7,7 +7,7 @@ Required properties:
     See ../clock/clock-bindings.txt for details.
   - clock-names: Must include the following entries.
     - pwm: PWM operating clock.
-  - #pwm-cells: Should be 3. See pwm.txt in this directory for the description
+  - #pwm-cells: Should be 3. See pwm.yaml in this directory for the description
     of the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
index 96cdde5f6208..1b06f86a7091 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
@@ -3,7 +3,7 @@ Freescale MXS PWM controller
 Required properties:
 - compatible: should be "fsl,imx23-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
 - fsl,pwm-number: the number of PWM devices
 
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index c57e11b8d937..0a69eadf44ce 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -10,7 +10,7 @@ Required properties:
   - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
   - "nvidia,tegra186-pwm": for Tegra186
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
 - clocks: Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index f84ec9d291ea..f21b55c95738 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -3,7 +3,7 @@ NXP PCA9685 16-channel 12-bit PWM LED controller
 
 Required properties:
   - compatible: "nxp,pca9685-pwm"
-  - #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+  - #pwm-cells: Should be 2. See pwm.yaml in this directory for a description of
     the cells format.
     The index 16 is the ALLCALL channel, that sets all PWM channels at the same
     time.
diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
index 8cf87d1bfca5..f5753b3f79df 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
@@ -6,7 +6,7 @@ Required properties:
 - clocks: This clock defines the base clock frequency of the PWM hardware
   system, the period and the duty_cycle of the PWM signal is a multiple of
   the base period.
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
   the cells format.
 
 Examples:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
index 82cbe16fcbbc..f01e993a498a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible: should be "marvell,berlin-pwm"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle to the input clock
-- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
   the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml b/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
new file mode 100644
index 000000000000..39c844fe6338
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-consumers.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Specifying PWM information for devices
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  PWM properties should be named "pwms". The exact meaning of each pwms
+  property must be documented in the device tree binding for each device.
+  An optional property "pwm-names" may contain a list of strings to label
+  each of the PWM devices listed in the "pwms" property. If no "pwm-names"
+  property is given, the name of the user node will be used as fallback.
+
+  Drivers for devices that use more than a single PWM device can use the
+  "pwm-names" property to map the name of the PWM device requested by the
+  pwm_get() call to an index into the list given by the "pwms" property.
+
+properties:
+  pwms:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Phandle to PWM controller node and pwm-specifier (controller specific).
+      pwm-specifier typically encodes the chip-relative PWM number and the PWM
+      period in nanoseconds.
+      Optionally, the pwm-specifier can encode a number of flags (defined in
+      <dt-bindings/pwm/pwm.h>) in a third cell:
+        - PWM_POLARITY_INVERTED: invert the PWM signal polarity
+
+  pwm-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      A list of strings to label each of the PWM devices listed in the "pwms"
+      property. If no "pwm-names" property is given, the name of the user node
+      will be used as fallback.
+
+required:
+  - pwms
+
+dependencies:
+  pwm-names: [ pwms ]
+
+examples:
+  - |
+    // The following example could be used to describe a PWM-based
+    // backlight device:
+
+    pwm: pwm {
+      #pwm-cells = <2>;
+    };
+
+    bl: backlight {
+      pwms = <&pwm 0 5000000>;
+      pwm-names = "backlight";
+    };
+
+    // Note that in the example above, specifying the "pwm-names" is redundant
+    // because the name "backlight" would be used as fallback anyway.
+
+  - |
+    // Example with optional PWM specifier for inverse polarity
+
+    #include <dt-bindings/pwm/pwm.h>
+
+    pwm2: pwm {
+      #pwm-cells = <3>;
+    };
+
+    backlight {
+      pwms = <&pwm2 0 5000000 PWM_POLARITY_INVERTED>;
+      pwm-names = "backlight";
+    };
diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
index 576ad002bc83..36532cd5ab25 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -21,7 +21,7 @@ Required properties:
   - "fsl,vf610-ftm-pwm" for PWM compatible with the one integrated on VF610
   - "fsl,imx8qm-ftm-pwm" for PWM compatible with the one integrated on i.MX8QM
 - reg: Physical base address and length of the controller's registers
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
   the cells format.
 - clock-names: Should include the following module clock source entries:
     "ftm_sys" (module clock, also can be used as counter clock),
diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
index daedfef09bb6..54dbc2a0e648 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
@@ -10,7 +10,7 @@ Required properties:
 - reg: physical base address and length of the controller's registers.
 - clocks: phandle and clock specifier of the PWM reference clock.
 - resets: phandle and reset specifier for the PWM controller reset.
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
   the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-lp3943.txt b/Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
index 7bd9d3b12ce1..f214305a8f5e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
@@ -2,7 +2,7 @@ TI/National Semiconductor LP3943 PWM controller
 
 Required properties:
   - compatible: "ti,lp3943-pwm"
-  - #pwm-cells: Should be 2. See pwm.txt in this directory for a
+  - #pwm-cells: Should be 2. See pwm.yaml in this directory for a
                 description of the cells format.
                 Note that this hardware limits the period length to the
                 range 6250~1600000.
diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 991728cb46cb..8caf01d0dd5e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -7,7 +7,7 @@ Required properties:
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
  - reg: physical base address and length of the controller's registers.
- - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
+ - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
    the cell format.
  - clocks: phandle and clock specifier of the PWM reference clock.
  - clock-names: must contain the following, except for MT7628 which
diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 891632354065..bd02b0a1496f 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -10,7 +10,7 @@ Required properties:
                          or "amlogic,meson-g12a-ee-pwm"
                          or "amlogic,meson-g12a-ao-pwm-ab"
                          or "amlogic,meson-g12a-ao-pwm-cd"
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
   the cells format.
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
index 6f8af2bcc7b7..0521957c253f 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -6,7 +6,7 @@ Required properties:
    - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
    - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
  - reg: physical base address and length of the controller's registers.
- - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
+ - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
    the cell format.
  - clocks: phandle and clock specifier of the PWM reference clock.
  - clock-names: must contain the following:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
index 5ccfcc82da08..d722ae3be363 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible: Shall contain "ti,omap-dmtimer-pwm".
 - ti,timers: phandle to PWM capable OMAP timer. See timer/ti,timer.txt for info
   about these timers.
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
   the cells format.
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index 2c5e52a5bede..f70956dea77b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -14,7 +14,7 @@ Required properties:
    - For newer hardware (rk3328 and future socs): specified by name
      - "pwm": This is used to derive the functional clock.
      - "pclk": This is the APB bus clock.
- - #pwm-cells: must be 2 (rk2928) or 3 (rk3288). See pwm.txt in this directory
+ - #pwm-cells: must be 2 (rk2928) or 3 (rk3288). See pwm.yaml in this directory
    for a description of the cell format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
index 36447e3c9378..3d1dd7b06efc 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -17,7 +17,7 @@ Required properties:
   Please refer to sifive-blocks-ip-versioning.txt for details.
 - reg: physical base address and length of the controller's registers
 - clocks: Should contain a clock identifier for the PWM's parent clock.
-- #pwm-cells: Should be 3. See pwm.txt in this directory
+- #pwm-cells: Should be 3. See pwm.yaml in this directory
   for a description of the cell format.
 - interrupts: one interrupt per PWM channel
 
diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
index 6521bc44a74e..4cecb8e456b6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -8,7 +8,7 @@ See ../mfd/stm32-lptimer.txt for details about the parent node.
 Required parameters:
 - compatible:		Must be "st,stm32-pwm-lp".
 - #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
-			bindings defined in pwm.txt.
+			bindings defined in pwm.yaml.
 
 Optional properties:
 - pinctrl-names: 	Set to "default". An additional "sleep" state can be
diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
index a8690bfa5e1f..f390a5ba3d3a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -9,7 +9,7 @@ Required parameters:
 - pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
 			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
 - #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
-			bindings defined in pwm.txt.
+			bindings defined in pwm.yaml.
 
 Optional parameters:
 - st,breakinput:	One or two <index level filter> to describe break input configurations.
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index b9a1d7402128..c7c4347a769a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -8,7 +8,7 @@ Required properties:
   for dra746 - compatible = "ti,dra746-ecap", "ti,am3352-ecap";
   for 66ak2g - compatible = "ti,k2g-ecap", "ti,am3352-ecap";
   for am654  - compatible = "ti,am654-ecap", "ti,am3352-ecap";
-- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
 - reg: physical base address and size of the registers map.
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 31c4577157dd..c7e28f6d28be 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -7,7 +7,7 @@ Required properties:
   for am654   - compatible = "ti,am654-ehrpwm", "ti-am3352-ehrpwm";
   for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
   for dra746 - compatible = "ti,dra746-ehrpwm", "ti-am3352-ehrpwm";
-- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
 - reg: physical base address and size of the registers map.
diff --git a/Documentation/devicetree/bindings/pwm/pwm-zx.txt b/Documentation/devicetree/bindings/pwm/pwm-zx.txt
index a6bcc75c9164..3c8fe7aa8269 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-zx.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-zx.txt
@@ -7,7 +7,7 @@ Required properties:
  - clock-names: "pclk" for PCLK, "wclk" for WCLK to the PWM controller.  The
    PCLK is for register access, while WCLK is the reference clock for
    calculating period and duty cycles.
- - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+ - #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
    the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
deleted file mode 100644
index 8556263b8502..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-Specifying PWM information for devices
-======================================
-
-1) PWM user nodes
------------------
-
-PWM users should specify a list of PWM devices that they want to use
-with a property containing a 'pwm-list':
-
-	pwm-list ::= <single-pwm> [pwm-list]
-	single-pwm ::= <pwm-phandle> <pwm-specifier>
-	pwm-phandle : phandle to PWM controller node
-	pwm-specifier : array of #pwm-cells specifying the given PWM
-			(controller specific)
-
-PWM properties should be named "pwms". The exact meaning of each pwms
-property must be documented in the device tree binding for each device.
-An optional property "pwm-names" may contain a list of strings to label
-each of the PWM devices listed in the "pwms" property. If no "pwm-names"
-property is given, the name of the user node will be used as fallback.
-
-Drivers for devices that use more than a single PWM device can use the
-"pwm-names" property to map the name of the PWM device requested by the
-pwm_get() call to an index into the list given by the "pwms" property.
-
-The following example could be used to describe a PWM-based backlight
-device:
-
-	pwm: pwm {
-		#pwm-cells = <2>;
-	};
-
-	[...]
-
-	bl: backlight {
-		pwms = <&pwm 0 5000000>;
-		pwm-names = "backlight";
-	};
-
-Note that in the example above, specifying the "pwm-names" is redundant
-because the name "backlight" would be used as fallback anyway.
-
-pwm-specifier typically encodes the chip-relative PWM number and the PWM
-period in nanoseconds.
-
-Optionally, the pwm-specifier can encode a number of flags (defined in
-<dt-bindings/pwm/pwm.h>) in a third cell:
-- PWM_POLARITY_INVERTED: invert the PWM signal polarity
-
-Example with optional PWM specifier for inverse polarity
-
-	bl: backlight {
-		pwms = <&pwm 0 5000000 PWM_POLARITY_INVERTED>;
-		pwm-names = "backlight";
-	};
-
-2) PWM controller nodes
------------------------
-
-PWM controller nodes must specify the number of cells used for the
-specifier using the '#pwm-cells' property.
-
-An example PWM controller might look like this:
-
-	pwm: pwm@7000a000 {
-		compatible = "nvidia,tegra20-pwm";
-		reg = <0x7000a000 0x100>;
-		#pwm-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
new file mode 100644
index 000000000000..aad99d505bb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM controllers (providers)
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "^pwm(@.*|-[0-9a-f])*$"
+
+  "#pwm-cells":
+    description:
+      Number of cells in a PWM specifier.
+
+required:
+  - "#pwm-cells"
+
+examples:
+  - |
+    pwm: pwm@7000a000 {
+      compatible = "nvidia,tegra20-pwm";
+      reg = <0x7000a000 0x100>;
+      #pwm-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index fbd6a4f943ce..a29137869f7a 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -20,7 +20,7 @@ Required Properties:
  - "renesas,pwm-r8a77990": for R-Car E3
  - "renesas,pwm-r8a77995": for R-Car D3
 - reg: base address and length of the registers block for the PWM.
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
 - clocks: clock phandle and specifier pair.
 - pinctrl-0: phandle, referring to a default pin configuration node.
diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
index 848a92b53d81..966994968069 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -19,11 +19,11 @@ Required Properties:
   - reg: Base address and length of each memory resource used by the PWM
     controller hardware module.
 
-  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  - #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
     the cells format. The only third cell flag supported by this binding is
     PWM_POLARITY_INVERTED.
 
-Please refer to pwm.txt in this directory for details of the common PWM bindings
+Please refer to pwm-consumers.yaml in this directory for details of the common PWM bindings
 used by client devices.
 
 Example: R8A7740 (R-Mobile A1) TPU controller node
diff --git a/Documentation/devicetree/bindings/pwm/spear-pwm.txt b/Documentation/devicetree/bindings/pwm/spear-pwm.txt
index b486de2c3fe3..95894128b62f 100644
--- a/Documentation/devicetree/bindings/pwm/spear-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/spear-pwm.txt
@@ -5,7 +5,7 @@ Required properties:
   - "st,spear320-pwm"
   - "st,spear1340-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
index cb209646bf13..f401316e0248 100644
--- a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
@@ -7,7 +7,7 @@ subdevices of the STMPE MFD device.
 Required properties:
 - compatible: should be:
   - "st,stmpe-pwm"
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
index 4e32bee11201..d97ca1964e94 100644
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
@@ -6,7 +6,7 @@ On TWL6030 series: PWM0 and PWM1
 
 Required properties:
 - compatible: "ti,twl4030-pwm" or "ti,twl6030-pwm"
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
index 9f4b46090782..31ca1b032ef0 100644
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
+++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
@@ -6,7 +6,7 @@ On TWL6030 series: LED PWM (mainly used as charging indicator LED)
 
 Required properties:
 - compatible: "ti,twl4030-pwmled" or "ti,twl6030-pwmled"
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
index a76390e6df2e..4fba93ce1985 100644
--- a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
@@ -3,7 +3,7 @@ VIA/Wondermedia VT8500/WM8xxx series SoC PWM controller
 Required properties:
 - compatible: should be "via,vt8500-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
 - clocks: phandle to the PWM source clock
diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
index 3d78d507e29f..252edcc2e381 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
@@ -27,7 +27,7 @@ Required properties:
 --------------------
 - compatible:		Should be "pwm-regulator"
 
-- pwms:			PWM specification (See: ../pwm/pwm.txt)
+- pwms:			PWM specification (See: ../pwm/pwm-consumers.yaml)
 
 Only required for Voltage Table Mode:
 - voltage-table: 	Voltage and Duty-Cycle table consisting of 2 cells
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
index 5a4b9ddd9470..0c7bd51c19eb 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
@@ -42,7 +42,7 @@ Required properties:
 - compatible: Must be one of:
   * ingenic,jz4740-pwm
   * ingenic,jz4725b-pwm
-- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of the cell
+- #pwm-cells: Should be 3. See ../pwm/pwm.yaml for a description of the cell
   format.
 - clocks: List of phandle & clock specifiers for the TCU clocks.
 - clock-names: List of name strings for the TCU clocks.
-- 
2.17.1

