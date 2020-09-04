Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1425DD8A
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgIDPYr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 11:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730991AbgIDPYm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD344207EA;
        Fri,  4 Sep 2020 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233082;
        bh=7ETwMr2woIdl6WmCKhWye9ZYfEI514T+ZyzZWn5CT8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoWZJaagfp5IWcPyqFJnSqZN1o7c6hZJr4jH2FTrJjHMmkX8nZUQuGncGh6Z/hRW/
         CxGHmJjgGM3959BM0hTZqSyUX3MTb6EGY/8QlKZFq3ybiJQws+x21A+nas/DmLp9YQ
         DOxRgVxFOM6i/y2A621fDktzdpgHjO2OqAPf8dMM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 05/14] dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M compatibles
Date:   Fri,  4 Sep 2020 17:23:55 +0200
Message-Id: <20200904152404.20636-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
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

