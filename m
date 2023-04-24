Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D466EC7C6
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Apr 2023 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjDXIVU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Apr 2023 04:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDXIVT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Apr 2023 04:21:19 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F310C;
        Mon, 24 Apr 2023 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682324478; x=1713860478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JAX1fjmfBWI5Iew7C17ekaAOJQ1f2iQJMkxaSn3l/sg=;
  b=VVUDe1WedeLrORTtciCS9BL3XMrL8AgeX3E7yFarzcCSaDGXPjmZW1PC
   MEF19sGj6/BzLzHCOmQ4X0HJGTs28yxKmlws2DxpPvf81cDaDVQec2mid
   pAt/ramMmmiZwrmVD9xorONJkvv0IdR5xom9+6KO0Qa3zFi+bg+75xsWu
   WGcxhYDlJbUg4/t0WgV8pjq9T0WTrfr6ofdQlho3PuGNx+Xx+RuysabkH
   FiuKbUW8RcohocHc5jpqov0jwnWnKrfVOr+ma7tc95h7cZyb4AONVHHMR
   iCRVmWXCOhoFw/tt4MWbULuv1A+2oLaYFe5gwAIaL82YwnydMzZQBf7SS
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,222,1677538800"; 
   d="scan'208";a="30508609"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Apr 2023 10:21:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 24 Apr 2023 10:21:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 24 Apr 2023 10:21:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682324475; x=1713860475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JAX1fjmfBWI5Iew7C17ekaAOJQ1f2iQJMkxaSn3l/sg=;
  b=YrhEMgMJAW1I+JkWNqsmUBg5HvW2rtLG/QPsgUI6MsX7udGQeCIX7hOc
   JMhnIa4PAvNfUkYoDIeU7jHJC6hzGSt4ZuuOKtnJHWoddBhMGgRpItD2S
   j+dEHJ/JSXrsXtHan/IP9lJINgCofGeT4+gENbMClez4YBrpIGjz8jZYd
   qS/XlariHQeHINSJbKxgZaQtQX23taB4gUyP4B3dmAsbklSMCpUuPTmkr
   LrLksp57HyOo2yfcj92Uxke3E+lWKx8o+oPxNlHwthh5vvxG4uHrdNZ4Z
   aMB7z+Iijw0vebgsyK3yJj4K86xNPgSgsvPZ8hYeZURD5usqqTZ7GTboK
   g==;
X-IronPort-AV: E=Sophos;i="5.99,222,1677538800"; 
   d="scan'208";a="30508607"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Apr 2023 10:21:14 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 78F35280072;
        Mon, 24 Apr 2023 10:21:14 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: imx8qxp: add adma_pwm in adma
Date:   Mon, 24 Apr 2023 10:21:08 +0200
Message-Id: <20230424082108.26512-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add PWM device and the corresponding clock gating device in adma subsystem.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
* New in v2

 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 2dce8f2ee3ea..7d5f96c99020 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -124,6 +124,19 @@ lpuart3: serial@5a090000 {
 		status = "disabled";
 	};
 
+	adma_pwm: pwm@5a190000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x5a190000 0x1000>;
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_pwm_lpcg 1>,
+			 <&adma_pwm_lpcg 0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		power-domains = <&pd IMX_SC_R_LCD_0_PWM_0>;
+	};
+
 	spi0_lpcg: clock-controller@5a400000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a400000 0x10000>;
@@ -220,6 +233,18 @@ uart3_lpcg: clock-controller@5a490000 {
 		power-domains = <&pd IMX_SC_R_UART_3>;
 	};
 
+	adma_pwm_lpcg: clock-controller@5a590000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a590000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "adma_pwm_lpcg_clk",
+				     "adma_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LCD_0_PWM_0>;
+	};
+
 	i2c0: i2c@5a800000 {
 		reg = <0x5a800000 0x4000>;
 		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

