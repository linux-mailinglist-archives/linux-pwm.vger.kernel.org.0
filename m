Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0178A250210
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgHXQ2Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 12:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgHXQ2J (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 12:28:09 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A0120738;
        Mon, 24 Aug 2020 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286488;
        bh=NxgEI35oyykqhboGx/XN/M8uVZEQeFJp9m/hyO8Zrz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTqczjKjHJ68aZnCriupqIDy8TROXvBw+2pPtLlrlOKEyMUyJywYCE7/2lYvNrxRw
         ha7HID//r9sRGPIYqiLmmZ8JbiUpGlnqTZhe8cbr/CYB3VHatZuJ2JkhoKQBM2XoH/
         Mwkr8XWX4EOf8VySp4knB+IW2IZIEeYqjHGpIxco=
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 08/19] dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M compatibles
Date:   Mon, 24 Aug 2020 18:26:41 +0200
Message-Id: <20200824162652.21047-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
    compatible:0: 'fsl,imx8mm-wdt' is not one of ['fsl,imx21-wdt']
    From schema: Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml

  arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
    compatible: ['fsl,imx8mm-wdt', 'fsl,imx21-wdt'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
    compatible: Additional items are not allowed ('fsl,imx21-wdt' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml     | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
index d96b93b11fad..991b4e33486e 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
@@ -14,8 +14,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx21-wdt
+    oneOf:
+      - const: fsl,imx21-wdt
+      - items:
+          - enum:
+              - fsl,imx8mm-wdt
+              - fsl,imx8mn-wdt
+              - fsl,imx8mp-wdt
+              - fsl,imx8mq-wdt
+          - const: fsl,imx21-wdt
 
   reg:
     maxItems: 1
-- 
2.17.1

