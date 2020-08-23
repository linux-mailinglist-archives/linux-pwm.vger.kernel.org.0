Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278A24EEAA
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Aug 2020 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHWQT3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Aug 2020 12:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgHWQQk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 Aug 2020 12:16:40 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E8020767;
        Sun, 23 Aug 2020 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199398;
        bh=D0lGql3068l0qoya1++oR3DiMvBwPOUE4frjDG+x5vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/E0sV3kwDQRaFmn8EdN7bwjcXjd8MTgJEGTp73HqPVT4rQNhHCoD8KfzDzzcKy2z
         sqZzm5CLgq76fFj0BdYO9NbFl8Ku8n7GzzdFGj0jMqiVQBQDD1FZgG5+dPPjkEWNIu
         6wPmKkb/QE93ZeTgXR+Rg8/vErI34DbgrE9UBs2Y=
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
Subject: [PATCH 09/22] dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
Date:   Sun, 23 Aug 2020 18:15:37 +0200
Message-Id: <20200823161550.3981-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible:0: 'fsl,imx8mm-gpmi-nand' is not one of ['fsl,imx23-gpmi-nand', 'fsl,imx28-gpmi-nand', 'fsl,imx6q-gpmi-nand', 'fsl,imx6sx-gpmi-nand', 'fsl,imx7d-gpmi-nand']
    From schema: Documentation/devicetree/bindings/mtd/gpmi-nand.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible: ['fsl,imx8mm-gpmi-nand', 'fsl,imx7d-gpmi-nand'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible: Additional items are not allowed ('fsl,imx7d-gpmi-nand' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/mtd/gpmi-nand.yaml     | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 3201372b7f85..28ff8c581837 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -20,12 +20,18 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-gpmi-nand
-      - fsl,imx28-gpmi-nand
-      - fsl,imx6q-gpmi-nand
-      - fsl,imx6sx-gpmi-nand
-      - fsl,imx7d-gpmi-nand
+    oneOf:
+      - enum:
+          - fsl,imx23-gpmi-nand
+          - fsl,imx28-gpmi-nand
+          - fsl,imx6q-gpmi-nand
+          - fsl,imx6sx-gpmi-nand
+          - fsl,imx7d-gpmi-nand
+      - items:
+          - enum:
+              - fsl,imx8mm-gpmi-nand
+              - fsl,imx8mn-gpmi-nand
+          - const: fsl,imx7d-gpmi-nand
 
   reg:
     items:
-- 
2.17.1

