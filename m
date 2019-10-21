Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC9DF28A
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfJUQLB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 12:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfJUQLB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Oct 2019 12:11:01 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5ED2084B;
        Mon, 21 Oct 2019 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571673738;
        bh=x3DZeADFnnRoLnhNTWxmX1HBbTzDnaIwqp/8ZaBzgjk=;
        h=From:To:Cc:Subject:Date:From;
        b=diiUm3G9bTEbBnzryrGvrmiChQQlzHKCAWwNI84RzWHhdhFUT9i7/QReQ42jHaGJa
         kmwZ3GLMUpNMlPGVKsiaU8wNspY7/jkQsMg6/HfJFx0CIeVmvH/kYocYKKBpMsFgR3
         N7UjkFL/yO2JFqMSLZGZvkdwnDQlctsDk4lyx9fk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: pwm: Convert PWM bindings to json-schema
Date:   Mon, 21 Oct 2019 18:02:06 +0200
Message-Id: <20191021160207.18026-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert generic PWM controller bindings to DT schema format using
json-schema.  The consumer bindings are provided by dt-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Paul Walmsley <paul.walmsley@sifive.com>

---

Changes since v3:
1. Remove pwm-consumers.yaml as they do not give anything new except
   description.
2. Leave pwm.txt with consumers description.
3. Add acks.

Changes since v2:
1. Change also pwm-sprd.txt

Changes since v1:
1. Indent example with four spaces (more readable),
2. Change pattern for pwm nodes,
3. Remove $ref from #cells.
---
 .../bindings/display/bridge/ti,sn65dsi86.txt  |  2 +-
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
 Documentation/devicetree/bindings/pwm/pwm.txt | 11 +------
 .../devicetree/bindings/pwm/pwm.yaml          | 29 +++++++++++++++++++
 .../bindings/pwm/renesas,pwm-rcar.yaml        |  2 +-
 .../bindings/pwm/renesas,tpu-pwm.yaml         |  2 +-
 .../devicetree/bindings/pwm/spear-pwm.txt     |  2 +-
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt  |  2 +-
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  2 +-
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  2 +-
 .../devicetree/bindings/pwm/vt8500-pwm.txt    |  2 +-
 .../devicetree/bindings/timer/ingenic,tcu.txt |  2 +-
 40 files changed, 68 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm.yaml

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
index c8501530173c..69cae11d80a6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -9,7 +9,7 @@ Required properties:
    - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
    - "mediatek,mt8516-pwm": found on mt8516 SoC.
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
index 8556263b8502..084886bd721e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -57,13 +57,4 @@ Example with optional PWM specifier for inverse polarity
 2) PWM controller nodes
 -----------------------
 
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
+See pwm.yaml.
diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
new file mode 100644
index 000000000000..fa4f9de92090
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
+        compatible = "nvidia,tegra20-pwm";
+        reg = <0x7000a000 0x100>;
+        #pwm-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 272a4df4a9d1..945c14e1be35 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -39,7 +39,7 @@ properties:
     maxItems: 1
 
   '#pwm-cells':
-    # should be 2. See pwm.txt in this directory for a description of
+    # should be 2. See pwm.yaml in this directory for a description of
     # the cells format.
     const: 2
 
diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 4908f004651b..4969a954993c 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 1
 
   '#pwm-cells':
-    # should be 3. See pwm.txt in this directory for a description of
+    # should be 3. See pwm.yaml in this directory for a description of
     # the cells format. The only third cell flag supported by this binding is
     # PWM_POLARITY_INVERTED.
     const: 3
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

