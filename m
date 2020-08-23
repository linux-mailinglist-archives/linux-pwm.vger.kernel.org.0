Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFB24EE1B
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Aug 2020 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHWQQD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Aug 2020 12:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgHWQQC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 Aug 2020 12:16:02 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685DC2072D;
        Sun, 23 Aug 2020 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199361;
        bh=lnBHoUXioLOrOWNKvWtcrwmt13u6QaY0trxOTodHtew=;
        h=From:To:Cc:Subject:Date:From;
        b=M4jcEMVojBCm6n6VI1JLybJ3HkimOMO74lwgXpcMV4RvKKHZeawHTgV8XtBvp9UtQ
         ULqXZ3K+wsEaxZPwJSqX2sGxr7+iuFaZhY48Xna/0DmrwbZmpnIbv+wrnX/1RoSgBl
         yb2ljxrWBvbfEbhd6Rk/f+zaCNTZCX+gnvm5j4Ys=
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
Subject: [PATCH 01/22] dt-bindings: gpio: fsl-imx-gpio: Add i.MX 8 compatibles
Date:   Sun, 23 Aug 2020 18:15:29 +0200
Message-Id: <20200823161550.3981-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DTSes with new i.MX 8 SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
    compatible:0: 'fsl,imx8mm-gpio' is not one of ['fsl,imx1-gpio', 'fsl,imx21-gpio', 'fsl,imx31-gpio', 'fsl,imx35-gpio', 'fsl,imx7d-gpio']
    From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
    compatible: ['fsl,imx8mm-gpio', 'fsl,imx35-gpio'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
    compatible: Additional items are not allowed ('fsl,imx35-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/gpio/fsl-imx-gpio.yaml           | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index 0b223abe8cfb..454db20c2d1a 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -11,12 +11,21 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx1-gpio
-      - fsl,imx21-gpio
-      - fsl,imx31-gpio
-      - fsl,imx35-gpio
-      - fsl,imx7d-gpio
+    oneOf:
+      - enum:
+          - fsl,imx1-gpio
+          - fsl,imx21-gpio
+          - fsl,imx31-gpio
+          - fsl,imx35-gpio
+          - fsl,imx7d-gpio
+      - items:
+          - enum:
+              - fsl,imx8mm-gpio
+              - fsl,imx8mn-gpio
+              - fsl,imx8mp-gpio
+              - fsl,imx8mq-gpio
+              - fsl,imx8qxp-gpio
+          - const: fsl,imx35-gpio
 
   reg:
     maxItems: 1
-- 
2.17.1

