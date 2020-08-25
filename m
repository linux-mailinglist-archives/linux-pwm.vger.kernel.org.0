Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B326F252086
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHYThv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 15:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYTht (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:37:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095A420782;
        Tue, 25 Aug 2020 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384268;
        bh=OoQ624Ud80Jq3oGh656Du4RZ9GVBa/ezQWHcHZ54lfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgxVhFe56sAR2ZQl+G0xYXx/WRHuIR47ojXVftzGlLI2EXBsC4NP8YxlZNMv261xd
         BXaSIIapZ2l3r7SlREhD4MXMzE3gTkNwWqIvESrqsakJievrfm+b3CpHrRBexLlxNM
         UkcaQJhiOaeoemQdXLac9N2ddgjrH7+WmsMWgwms=
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
Subject: [PATCH v3 13/19] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M compatibles
Date:   Tue, 25 Aug 2020 21:35:30 +0200
Message-Id: <20200825193536.7332-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DTSes with new i.MX 8M SoCs use two compatibles so update the binding to
fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000: compatible:1: 'syscon' was expected
    From schema: Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
    compatible: ['fsl,imx8mn-ocotp', 'fsl,imx8mm-ocotp', 'syscon'] is too long

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
    compatible: Additional items are not allowed ('syscon' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Remove moved compatibles.
---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 1c9d7f05f173..5a7284737229 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -19,21 +19,29 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - fsl,imx6q-ocotp
-          - fsl,imx6sl-ocotp
-          - fsl,imx6sx-ocotp
-          - fsl,imx6ul-ocotp
-          - fsl,imx6ull-ocotp
-          - fsl,imx7d-ocotp
-          - fsl,imx6sll-ocotp
-          - fsl,imx7ulp-ocotp
-          - fsl,imx8mq-ocotp
-          - fsl,imx8mm-ocotp
-          - fsl,imx8mn-ocotp
-          - fsl,imx8mp-ocotp
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx6q-ocotp
+              - fsl,imx6sl-ocotp
+              - fsl,imx6sx-ocotp
+              - fsl,imx6ul-ocotp
+              - fsl,imx6ull-ocotp
+              - fsl,imx7d-ocotp
+              - fsl,imx6sll-ocotp
+              - fsl,imx7ulp-ocotp
+              - fsl,imx8mq-ocotp
+              - fsl,imx8mm-ocotp
+          - const: syscon
+      - items:
+          - enum:
+              - fsl,imx8mn-ocotp
+              # i.MX8MP not really compatible with fsl,imx8mm-ocotp, however
+              # the code for getting SoC revision depends on fsl,imx8mm-ocotp
+              # compatible.
+              - fsl,imx8mp-ocotp
+          - const: fsl,imx8mm-ocotp
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.17.1

