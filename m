Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7325203C
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHYTgg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 15:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHYTgc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:36:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC7820897;
        Tue, 25 Aug 2020 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384191;
        bh=wlqBmIZakjThWfsNYNSXRzUys0EPXws/z1mqU2+A+80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKNaAevsmSyPGRzDQ+92XeeGVni0MwuQAhfDjyIxdLQr1siYERZDAaFHkVDPBp259
         4q4O+8S87Y5L13uVzqOwf/sxPly7eH2dDdO0cdp/NQKfy8IaAW+84PVrynfjnwqI6h
         ldMPBAUFmkcT3xRmq3x3jtrZwF3nzTbOPUzwWybk=
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
Subject: [PATCH v3 04/19] dt-bindings: gpio: fsl-imx-gpio: Add power-domains
Date:   Tue, 25 Aug 2020 21:35:21 +0200
Message-Id: <20200825193536.7332-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Parse also optional power-domains property to fix dtbs_check warnings
like:

  arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: gpio@5d080000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
    From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index 620a52f944e8..de0b9b5f6a70 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -53,6 +53,9 @@ properties:
 
   gpio-ranges: true
 
+  power-domains:
+    maxItems: 1
+
 patternProperties:
   "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
     type: object
-- 
2.17.1

