Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82F24EE79
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Aug 2020 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHWQSh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Aug 2020 12:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgHWQRc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:32 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723892075B;
        Sun, 23 Aug 2020 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199451;
        bh=FgDauWijE2v2zG1uUmpQp0k3ggKYFyDzL5p9qK38cTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQKrnvwOPFy36zo9ouWkzK/k66jZBtwE1DCl0+FuKAc2CgHeyOrQ5moiyAj1WqiAY
         uF7zNC19Jf2QR/TpzqOO7bPHGqzuKaCiNASOMBvMr2UgOvStlsr8RD5J0BczCkYabW
         byjfqz7daDcQ65RwP0IJAkDuLqXYySK83JNx8+8Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 20/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from UART
Date:   Sun, 23 Aug 2020 18:15:48 +0200
Message-Id: <20200823161550.3981-20-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The UART on i.MX 8QXP has its own compatible described in bindings
and used in the driver (with its own quirks).  Remove additional
fsl,imx7ulp-lpuart compatible to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
    compatible: ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
    From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
    compatible: Additional items are not allowed ('fsl,imx7ulp-lpuart' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index e46faac1fe71..61bccb69f09e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -257,7 +257,7 @@
 		};
 
 		adma_lpuart0: serial@5a060000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			compatible = "fsl,imx8qxp-lpuart";
 			reg = <0x5a060000 0x1000>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_IPG_CLK>,
@@ -268,7 +268,7 @@
 		};
 
 		adma_lpuart1: serial@5a070000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			compatible = "fsl,imx8qxp-lpuart";
 			reg = <0x5a070000 0x1000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART1_IPG_CLK>,
@@ -279,7 +279,7 @@
 		};
 
 		adma_lpuart2: serial@5a080000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			compatible = "fsl,imx8qxp-lpuart";
 			reg = <0x5a080000 0x1000>;
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART2_IPG_CLK>,
@@ -290,7 +290,7 @@
 		};
 
 		adma_lpuart3: serial@5a090000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			compatible = "fsl,imx8qxp-lpuart";
 			reg = <0x5a090000 0x1000>;
 			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART3_IPG_CLK>,
-- 
2.17.1

