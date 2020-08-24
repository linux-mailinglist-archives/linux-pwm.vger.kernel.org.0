Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826D9250215
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHXQ2o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 12:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgHXQ2Y (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 12:28:24 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0930820838;
        Mon, 24 Aug 2020 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286502;
        bh=Dm+3LfgmxlFk7lfKGosmt5pRH6F3QaIaaVYrmFBasII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuFPn4aT6Te0VuqnnyGE9NWf6d/MsVJ8SAoVWsp+FEq5nuN7uZg7JAMjaFh2ZN5sr
         wgcFSnsbHu5pDPwRJtFqXjAfECT2kb4jnKO0ebBVXZjf6+xe/ADgbbCyoFMZhLvuAO
         o7qv9zWX9hBdSdHg6p6Iq+8Za727fqox1S7T6I4g=
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
Subject: [PATCH v2 10/19] dt-bindings: reset: fsl,imx7-src: Add i.MX 8M compatibles
Date:   Mon, 24 Aug 2020 18:26:43 +0200
Message-Id: <20200824162652.21047-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: reset-controller@30390000:
    compatible:0: 'fsl,imx8mm-src' is not one of ['fsl,imx7d-src', 'fsl,imx8mq-src', 'fsl,imx8mp-src']
    From schema: Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: reset-controller@30390000:
    compatible:1: 'syscon' was expected

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: reset-controller@30390000:
    compatible: ['fsl,imx8mm-src', 'fsl,imx8mq-src', 'syscon'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/reset/fsl,imx7-src.yaml          | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml b/Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml
index 569cd3bd3a70..00430e2eabc8 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml
@@ -22,12 +22,19 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - fsl,imx7d-src
-          - fsl,imx8mq-src
-          - fsl,imx8mp-src
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx7d-src
+              - fsl,imx8mq-src
+              - fsl,imx8mp-src
+          - const: syscon
+      - items:
+          - enum:
+              - fsl,imx8mm-src
+              - fsl,imx8mn-src
+          - const: fsl,imx8mq-src
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.17.1

