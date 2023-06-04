Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F6C7215E6
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Jun 2023 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFDJuy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 4 Jun 2023 05:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDJux (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 4 Jun 2023 05:50:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA939DF;
        Sun,  4 Jun 2023 02:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479C160C4C;
        Sun,  4 Jun 2023 09:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D41C433EF;
        Sun,  4 Jun 2023 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685872251;
        bh=IgRN8Lu8fQwHnW6QBReccrez4UTFIqy7/PxHxvotA+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgcyXvalCKCV5LticVpRbbuyR84124r30m/DjsEVG3jFZzwilFfE5UOo2DLiTBq+S
         4RswMKDjLfr5Pz89xfjdc7Saz1glBPbC++F12NFGRsEFG1RmlfFMAsGZu8GigvV9Xm
         wm8QGh+I6JknY3FIJT8rQv1qj2kbuV3b0gPRaPUY4KWAWloJ+XH0zfdx9fTsR1Llb3
         DyBg1JhyAAy3vH4xtjk38g5AJu2cKbfZC7yxyJc/h9zL9SwO7ZzAaOrE8y8GRH1VrF
         6Lf87ZVHk6IIhZliXVYiW5c0BZMCrCer3RyDHMrWrxKw99Qq/kan0iq3AK90pwTc6x
         lm9+lPpNBexZA==
Date:   Sun, 4 Jun 2023 17:50:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8qxp: add adma_pwm in adma
Message-ID: <20230604095038.GA4199@dragon>
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
 <20230424082108.26512-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424082108.26512-2-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 24, 2023 at 10:21:08AM +0200, Alexander Stein wrote:
> Add PWM device and the corresponding clock gating device in adma subsystem.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Looks good to me.  I will pick it up after dt-bindings one gets
accepted/picked first.

Shawn

> ---
> * New in v2
> 
>  .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> index 2dce8f2ee3ea..7d5f96c99020 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -124,6 +124,19 @@ lpuart3: serial@5a090000 {
>  		status = "disabled";
>  	};
>  
> +	adma_pwm: pwm@5a190000 {
> +		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +		reg = <0x5a190000 0x1000>;
> +		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&adma_pwm_lpcg 1>,
> +			 <&adma_pwm_lpcg 0>;
> +		clock-names = "ipg", "per";
> +		assigned-clocks = <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates = <24000000>;
> +		#pwm-cells = <2>;
> +		power-domains = <&pd IMX_SC_R_LCD_0_PWM_0>;
> +	};
> +
>  	spi0_lpcg: clock-controller@5a400000 {
>  		compatible = "fsl,imx8qxp-lpcg";
>  		reg = <0x5a400000 0x10000>;
> @@ -220,6 +233,18 @@ uart3_lpcg: clock-controller@5a490000 {
>  		power-domains = <&pd IMX_SC_R_UART_3>;
>  	};
>  
> +	adma_pwm_lpcg: clock-controller@5a590000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5a590000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>,
> +			 <&dma_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "adma_pwm_lpcg_clk",
> +				     "adma_pwm_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_LCD_0_PWM_0>;
> +	};
> +
>  	i2c0: i2c@5a800000 {
>  		reg = <0x5a800000 0x4000>;
>  		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.34.1
> 
