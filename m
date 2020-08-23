Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14824EE68
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Aug 2020 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHWQSR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Aug 2020 12:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgHWQRl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:41 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9218120767;
        Sun, 23 Aug 2020 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199460;
        bh=om9ESAnTN0kLIHeSYqTWxWWUBVqyKQ5oPt5eaHUA+2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoaAR81iHPTZTaeVWIysT1dgDiueIU1wsfTlQmwilaHTXOgNAp2Kiv1ZDYbmTEZyi
         DbkAGv4UahUvhmnSz7YofRG8QUC2usXaH+ng4qRtMnjpwEwJ0MYFy+B7fPsiKiAjUy
         4a6SBWOT+dxnoeMz6fUlewNe3Rk55M2pp2KWemUs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 22/22] arm64: dts: imx8mp: Remove i.MX7 compatible from DDR PMU
Date:   Sun, 23 Aug 2020 18:15:50 +0200
Message-Id: <20200823161550.3981-22-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The DDR PMU on i.MX 8MP has its own compatible described in bindings and
used in the driver (with its own quirks).  Remove additional
fsl,imx8m-ddr-pmu compatible to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dt.yaml: ddr-pmu@3d800000:
    compatible: ['fsl,imx8mq-ddr-pmu', 'fsl,imx8m-ddr-pmu'] is not valid under any of the given schemas (Possible causes of the failure):
    arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dt.yaml: ddr-pmu@3d800000: compatible: ['fsl,imx8mq-ddr-pmu', 'fsl,imx8m-ddr-pmu'] is too long
    From schema: Docmentation/devicetree/bindings/perf/fsl-imx-ddr.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9de2aa1c573c..e34eff19fcae 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -746,7 +746,7 @@
 		};
 
 		ddr-pmu@3d800000 {
-			compatible = "fsl,imx8mp-ddr-pmu", "fsl,imx8m-ddr-pmu";
+			compatible = "fsl,imx8mp-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.17.1

