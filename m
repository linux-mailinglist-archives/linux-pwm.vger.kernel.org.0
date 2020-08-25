Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD9252090
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHYTiA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 15:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYTh4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:37:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1000C20825;
        Tue, 25 Aug 2020 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384275;
        bh=6idM7c5GeTkd4WF/BwiDQ4VtDP0G4md0yVL4AgXqZC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKmfdSDG2vq082YwyLlJ8m7u9I6E1jjOvA/Uwz/CqGicy7yQUYyQWkKQ3QlO0PLvV
         z2pbZFtDKBFbAp0KraAjNZV0eWLG8Auj8PgDnyFz9YCxiGB9b0JXJYm3s7tFo1hJF6
         tHLZ3reDn5SKa9azGV1BHhg24NBpKVU84tPciRPA=
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
Subject: [PATCH v3 14/19] dt-bindings: arm: fsl: Fix Toradex Colibri i.MX 8 binding
Date:   Tue, 25 Aug 2020 21:35:31 +0200
Message-Id: <20200825193536.7332-15-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Toradex Colibri i.MX 8 Evaluation board has two Toradex compatibles
so it needs separate entry.  This fixes dtbs_check warning:

  arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dt.yaml: /:
    compatible: ['toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x', 'fsl,imx8qxp'] is not valid under any of the given schemas (Possible causes of the failure):
    arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dt.yaml: /: compatible: ['toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x', 'fsl,imx8qxp'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 37592e7bfee9..377fc2a4c159 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -379,7 +379,13 @@ properties:
               - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
               - toradex,colibri-imx8x         # Colibri iMX8X Module
+          - const: fsl,imx8qxp
+
+      - description: Toradex Colibri i.MX8 Evaluation Board
+        items:
+          - enum:
               - toradex,colibri-imx8x-eval-v3 # Colibri iMX8X Module on Colibri Evaluation Board V3
+          - const: toradex,colibri-imx8x
           - const: fsl,imx8qxp
 
       - description:
-- 
2.17.1

