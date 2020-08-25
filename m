Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410F925207B
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 21:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHYThn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 15:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgHYThl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:37:41 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B9B2076C;
        Tue, 25 Aug 2020 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384261;
        bh=oLRBjrakobO00fQoSHuH7N5PbZAoKW+gBHMvclqPiN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZYN9o640+VFHGKh1osxq8NjcnAVTCAs0ov9HzZBc6xlW9uvTt88RXvE/chPYzK1A
         8Z5yemHpf3GD/1tQGnMTagBv5e1hNVAhv3XYkXtJCM54QXePe9Xq2vdBnkl3U5MbXK
         CKWDGAtOnMYsoXLtfGVazUeI07XZvl30zs0l+7HU=
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
Subject: [PATCH v3 12/19] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching
Date:   Tue, 25 Aug 2020 21:35:29 +0200
Message-Id: <20200825193536.7332-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The i.MX 8 DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
    compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
    From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
    compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)

  arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
    compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Remove moved compatibles.

Changes since v1:
1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
---
 .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 10b45966f1b8..e71d13c2d109 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -21,23 +21,26 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx25-esdhc
-      - fsl,imx35-esdhc
-      - fsl,imx51-esdhc
-      - fsl,imx53-esdhc
-      - fsl,imx6q-usdhc
-      - fsl,imx6sl-usdhc
-      - fsl,imx6sx-usdhc
-      - fsl,imx6ull-usdhc
-      - fsl,imx7d-usdhc
-      - fsl,imx7ulp-usdhc
-      - fsl,imx8mq-usdhc
-      - fsl,imx8mm-usdhc
-      - fsl,imx8mn-usdhc
-      - fsl,imx8mp-usdhc
-      - fsl,imx8qm-usdhc
-      - fsl,imx8qxp-usdhc
+    oneOf:
+      - enum:
+          - fsl,imx25-esdhc
+          - fsl,imx35-esdhc
+          - fsl,imx51-esdhc
+          - fsl,imx53-esdhc
+          - fsl,imx6q-usdhc
+          - fsl,imx6sl-usdhc
+          - fsl,imx6sx-usdhc
+          - fsl,imx6ull-usdhc
+          - fsl,imx7d-usdhc
+          - fsl,imx7ulp-usdhc
+      - items:
+          - enum:
+              - fsl,imx8mm-usdhc
+              - fsl,imx8mn-usdhc
+              - fsl,imx8mp-usdhc
+              - fsl,imx8mq-usdhc
+              - fsl,imx8qxp-usdhc
+          - const: fsl,imx7d-usdhc
 
   reg:
     maxItems: 1
-- 
2.17.1

