Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21C717938
	for <lists+linux-pwm@lfdr.de>; Wed, 31 May 2023 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjEaH5Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 May 2023 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjEaH47 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 May 2023 03:56:59 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A16D173B;
        Wed, 31 May 2023 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685519761; x=1717055761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FS2roWGat0mA6b4IgEeq1guiQgG3htuXfzj9dNEmIw=;
  b=XCGMBeJpPJ5ZO0Phr0fSjMuvD1o+tuzBt4mhYop/JdPvgRkf3z0xT/0c
   1KGb4KAAGQ78JlIQQaHyMcA6l5RiQ3dYfoXQJvUTTV4REL4g//BnfahZX
   GTEdidwbtT9kF8tCF5Okq4/co8yicYMGYnk8bQkbaFOBJOqhcpnX80RdC
   j5Hqi66JacyQrhKVDRywyjhludf1GT6YP1bdn0aXzDZkLpohFDMTVS+kz
   Tqhdiqc3G7RlVw/g72XdR+h+vXMTx2i1GsQHqN0aGiB0iwr9n3CguZBt+
   umSVHmuzEx3Q76dpnslOnwrxuV90DJ5E+Wclk5UQG2AnuNyY9aQeKsYXb
   A==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681164000"; 
   d="scan'208";a="31185786"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 May 2023 09:55:53 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 31 May 2023 09:55:54 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 31 May 2023 09:55:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685519753; x=1717055753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FS2roWGat0mA6b4IgEeq1guiQgG3htuXfzj9dNEmIw=;
  b=OoQa90CS6I6ZOIAkg4ArSC9cGdOtrrrEwemWNO00GWLDT+dgZrsj8vc0
   tEi+PLrwZByV6RS292Pz2VKdjQuM9Ek58jDWYZ2HIFIVt4rPIjpsYKYp+
   6gxBAaLzoYgF+CHJZBoXMAnB8xC/WXBa9z4LR834XrjSqfqwEExhPia1M
   1tkW2gv6z+kl3dHlYAAxBcCNLo9jBQRDEfWm1zy8TqD9kR1G8MYh7gGff
   +IJMtb5U2Ewe+ZQ51mb7aVqxQCcTG/XG3W+JiCjA3pvRhlaJXycQDTBVA
   K8YAJ5kRI2/hoBTwck8o1mU35I3fz9ZX6TWe9O6VH8VZH7vYbJ5V3xLVC
   g==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681164000"; 
   d="scan'208";a="31185785"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 May 2023 09:55:53 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9AA3B280099;
        Wed, 31 May 2023 09:55:53 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8qxp: add adma_pwm in adma
Date:   Wed, 31 May 2023 09:55:53 +0200
Message-ID: <2232211.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230424082108.26512-2-alexander.stein@ew.tq-group.com>
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com> <20230424082108.26512-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Am Montag, 24. April 2023, 10:21:08 CEST schrieb Alexander Stein:
> Add PWM device and the corresponding clock gating device in adma subsyste=
m.

Gentle ping.

Best regards,
Alexander

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> * New in v2
>=20
>  .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi index
> 2dce8f2ee3ea..7d5f96c99020 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -124,6 +124,19 @@ lpuart3: serial@5a090000 {
>  		status =3D "disabled";
>  	};
>=20
> +	adma_pwm: pwm@5a190000 {
> +		compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +		reg =3D <0x5a190000 0x1000>;
> +		interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&adma_pwm_lpcg 1>,
> +			 <&adma_pwm_lpcg 0>;
> +		clock-names =3D "ipg", "per";
> +		assigned-clocks =3D <&clk IMX_SC_R_LCD_0_PWM_0=20
IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		#pwm-cells =3D <2>;
> +		power-domains =3D <&pd IMX_SC_R_LCD_0_PWM_0>;
> +	};
> +
>  	spi0_lpcg: clock-controller@5a400000 {
>  		compatible =3D "fsl,imx8qxp-lpcg";
>  		reg =3D <0x5a400000 0x10000>;
> @@ -220,6 +233,18 @@ uart3_lpcg: clock-controller@5a490000 {
>  		power-domains =3D <&pd IMX_SC_R_UART_3>;
>  	};
>=20
> +	adma_pwm_lpcg: clock-controller@5a590000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5a590000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>,
> +			 <&dma_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "adma_pwm_lpcg_clk",
> +				     "adma_pwm_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_LCD_0_PWM_0>;
> +	};
> +
>  	i2c0: i2c@5a800000 {
>  		reg =3D <0x5a800000 0x4000>;
>  		interrupts =3D <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


