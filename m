Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474825DD8F
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgIDPYj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 11:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730938AbgIDPYh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:37 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5552084D;
        Fri,  4 Sep 2020 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233077;
        bh=v4kspojzNvFxtIF19ahKwZXqd6Y9OL3DS8cTRXDb9qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7iZ9wUQJIOXCrS8Q/zfdNYzy5666J8kslGAxJ2kaesaLs6cIEvHykP9AgV35fqYG
         Rr/V6umH7EEeuBZw/1fohrgXRkmeky2fJrfqCa0zW/jLeUAzK4Rl055vvzWwajE2eg
         oo1CnqGzgSuo+lMG36bsogYz47AZtQYWgrSKeip8=
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
Subject: [PATCH v3 04/14] dt-bindings: serial: fsl-lpuart: Fix compatible matching
Date:   Fri,  4 Sep 2020 17:23:54 +0200
Message-Id: <20200904152404.20636-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The i.MX 8QXP DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
    compatible: ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
    From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
    compatible: Additional items are not allowed ('fsl,imx7ulp-lpuart' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Remove moved compatibles.

Changes since v1:
1. New patch.
---
 .../devicetree/bindings/serial/fsl-lpuart.yaml  | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index e82c2cf9fef7..bd21060d26e0 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -14,13 +14,16 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,vf610-lpuart
-      - fsl,ls1021a-lpuart
-      - fsl,ls1028a-lpuart
-      - fsl,imx7ulp-lpuart
-      - fsl,imx8qxp-lpuart
-      - fsl,imx8qm-lpuart
+    oneOf:
+      - enum:
+          - fsl,vf610-lpuart
+          - fsl,ls1021a-lpuart
+          - fsl,ls1028a-lpuart
+          - fsl,imx7ulp-lpuart
+          - fsl,imx8qm-lpuart
+      - items:
+          - const: fsl,imx8qxp-lpuart
+          - const: fsl,imx7ulp-lpuart
 
   reg:
     maxItems: 1
-- 
2.17.1

