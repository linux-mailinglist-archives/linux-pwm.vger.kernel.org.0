Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB22D25DD89
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgIDPYs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 11:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730993AbgIDPYr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:47 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCE920770;
        Fri,  4 Sep 2020 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233086;
        bh=85RKMTmKECIMFM6DGRK+YX/4QokPxJS+EKnA8zzJN1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPRO3QqFu2PYgg6UY4MmE1tLVsH2LS6zKrpnuJRGkPidYM9DGoujYsBN/jmljDqPK
         S3BlGPyw++TbsH0MPLmALrU4qZv+IOMIGR6g7iXVpVpNgBR3Tdq1vyFoA0wI1OlmFX
         MIPZKtWGqBSM0X/jYuJbbpwTw3VHs4AARoShEoGc=
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
Subject: [PATCH v3 06/14] dt-bindings: reset: fsl,imx7-src: Add i.MX 8M compatibles
Date:   Fri,  4 Sep 2020 17:23:56 +0200
Message-Id: <20200904152404.20636-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

