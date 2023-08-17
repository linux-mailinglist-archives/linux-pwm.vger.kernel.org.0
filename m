Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8B77F1BF
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Aug 2023 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjHQIEK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Aug 2023 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbjHQIDe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Aug 2023 04:03:34 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FCB2D7B;
        Thu, 17 Aug 2023 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692259403; x=1723795403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4P7tpRGW5q4XoGYaMtzXxey1EvyzRfYaU+GmMtoXMY=;
  b=ZNjz7kffQvwJ7ktyS/Xq8aDpwLC7xuOi2oqGhdmTZNKIUrjtJwas5QOK
   2PQUcprj+ivn4wrM0B857J7ER/c8IRCFcgnqpwj1pOa0Ec9NjJ1oQwqhl
   UKim9cGzpFHsPClNnjOI9h2kJtWTDEGy6+bJCaqbOsT1am4QKkFH1tAaA
   WIGycPg9u3jveVbJDl2ME08TcRelCiWCg31Dq1cMpX3ZTGRn5tSR8TQ2r
   sScZnyI2bXWQqpG4Zqd24gvvfPssjns6/hTzrFzPrK8WgHq3+LG0eFx/5
   94AMjGiSp0MMTD5tC4fzgUJOYaF9YcmeaIiQpa0Zn6uAHF1Sk9EEjrPjb
   g==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684792800"; 
   d="scan'208";a="32487371"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Aug 2023 10:03:21 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id EF914280075;
        Thu, 17 Aug 2023 10:03:20 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
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
Date:   Thu, 17 Aug 2023 10:03:20 +0200
Message-ID: <8261600.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230604095038.GA4199@dragon>
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com> <20230424082108.26512-2-alexander.stein@ew.tq-group.com> <20230604095038.GA4199@dragon>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Shawn,

Am Sonntag, 4. Juni 2023, 11:50:38 CEST schrieb Shawn Guo:
> On Mon, Apr 24, 2023 at 10:21:08AM +0200, Alexander Stein wrote:
> > Add PWM device and the corresponding clock gating device in adma
> > subsystem.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> Looks good to me.  I will pick it up after dt-bindings one gets
> accepted/picked first.

Did this get missed accidentally? Patch 1 was picked by Thierry already.

Best regards,
Alexander

> Shawn
>=20
> > ---
> > * New in v2
> >=20
> >  .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi index
> > 2dce8f2ee3ea..7d5f96c99020 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> > @@ -124,6 +124,19 @@ lpuart3: serial@5a090000 {
> >=20
> >  		status =3D "disabled";
> >  =09
> >  	};
> >=20
> > +	adma_pwm: pwm@5a190000 {
> > +		compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> > +		reg =3D <0x5a190000 0x1000>;
> > +		interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks =3D <&adma_pwm_lpcg 1>,
> > +			 <&adma_pwm_lpcg 0>;
> > +		clock-names =3D "ipg", "per";
> > +		assigned-clocks =3D <&clk IMX_SC_R_LCD_0_PWM_0=20
IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates =3D <24000000>;
> > +		#pwm-cells =3D <2>;
> > +		power-domains =3D <&pd IMX_SC_R_LCD_0_PWM_0>;
> > +	};
> > +
> >=20
> >  	spi0_lpcg: clock-controller@5a400000 {
> >  =09
> >  		compatible =3D "fsl,imx8qxp-lpcg";
> >  		reg =3D <0x5a400000 0x10000>;
> >=20
> > @@ -220,6 +233,18 @@ uart3_lpcg: clock-controller@5a490000 {
> >=20
> >  		power-domains =3D <&pd IMX_SC_R_UART_3>;
> >  =09
> >  	};
> >=20
> > +	adma_pwm_lpcg: clock-controller@5a590000 {
> > +		compatible =3D "fsl,imx8qxp-lpcg";
> > +		reg =3D <0x5a590000 0x10000>;
> > +		#clock-cells =3D <1>;
> > +		clocks =3D <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>,
> > +			 <&dma_ipg_clk>;
> > +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names =3D "adma_pwm_lpcg_clk",
> > +				     "adma_pwm_lpcg_ipg_clk";
> > +		power-domains =3D <&pd IMX_SC_R_LCD_0_PWM_0>;
> > +	};
> > +
> >=20
> >  	i2c0: i2c@5a800000 {
> >  =09
> >  		reg =3D <0x5a800000 0x4000>;
> >  		interrupts =3D <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


