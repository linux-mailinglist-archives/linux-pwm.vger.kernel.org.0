Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ABD252068
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 21:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHYThS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 15:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgHYThQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:37:16 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA582075F;
        Tue, 25 Aug 2020 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384235;
        bh=rOlkyLq/MJZ1DAenvWhfuxACksm2nB3ySP8n+l1ST3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvXktDJpjhhw0EWhLxqSsFJ6IOM1gQ3Htm7yyJ6Ag937D5wrX2EnnoMF5YUp7AeEA
         3FDALBAU+qT3cyJz/vC+HoTsYXwxzSaEaFCNL4Nvza3++5pufG1XxrSNM0uzC/xl+/
         8Gm3XNQkXO1ADTR239k9AUaPWQV9zsGATnVi63Qs=
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
Subject: [PATCH v3 09/19] dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
Date:   Tue, 25 Aug 2020 21:35:26 +0200
Message-Id: <20200825193536.7332-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

