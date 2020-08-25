Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36A252024
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 21:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHYTgH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 15:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYTgG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:36:06 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F89220825;
        Tue, 25 Aug 2020 19:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384166;
        bh=zp5go9e7i/qv1aP2GIDJh42E7oLFhoX9VV8nN5lMI+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUcNYK5rkOGP+ncveeXAiCUst53nEMRE9csWGgktTbJxGw0iTLjjSiEtz7A6E1bnh
         HJr7hEUoMlmDjsFOoyIfXzHK483LqWn9qcGhP+F4aT/DAb3rC6q1g6qHQWNMbXOuS2
         rd4o8+VIKBNxDsVQchTRHwIF7u3d56Xe1eaI//BU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 01/19] dt-bindings: gpio: fsl-imx-gpio: Add i.MX 8 compatibles
Date:   Tue, 25 Aug 2020 21:35:18 +0200
Message-Id: <20200825193536.7332-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

