Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58D7E1EDA
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Nov 2023 11:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFKs6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Nov 2023 05:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjKFKs4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2023 05:48:56 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE340BD
        for <linux-pwm@vger.kernel.org>; Mon,  6 Nov 2023 02:48:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzx9w-0007kV-3g; Mon, 06 Nov 2023 11:48:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzx9u-0070Nx-Vz; Mon, 06 Nov 2023 11:48:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzx9u-00DZ6f-Mb; Mon, 06 Nov 2023 11:48:42 +0100
Date:   Mon, 6 Nov 2023 11:48:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arm64: dts: freescale: imx8-ss-lsio: Fix #pwm-cells
Message-ID: <20231106104842.ooxzow6slw575xrs@pengutronix.de>
References: <20231106095205.231210-1-alexander.stein@ew.tq-group.com>
 <20231106095205.231210-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oz2nobh3znr42n5o"
Content-Disposition: inline
In-Reply-To: <20231106095205.231210-3-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oz2nobh3znr42n5o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[again Cc -=3D Philippe Schenker]

On Mon, Nov 06, 2023 at 10:52:04AM +0100, Alexander Stein wrote:
> i.MX8QM/QXP supports inverted PWM output, thus #pwm-cells needs to be set
> to 3.
>=20
> Fixes: a05c329644d81 ("arm64: dts: freescale: imx8-ss-lsio: add support f=
or lsio_pwm0-3")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64=
/boot/dts/freescale/imx8-ss-lsio.dtsi
> index 49ad3413db948..7e510b21bbac5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> @@ -29,7 +29,7 @@ lsio_pwm0: pwm@5d000000 {
>  			 <&pwm0_lpcg 1>;
>  		assigned-clocks =3D <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;
>  		assigned-clock-rates =3D <24000000>;
> -		#pwm-cells =3D <2>;
> +		#pwm-cells =3D <3>;
>  		interrupts =3D <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>  		status =3D "disabled";
>  	};
> @@ -42,7 +42,7 @@ lsio_pwm1: pwm@5d010000 {
>  			 <&pwm1_lpcg 1>;
>  		assigned-clocks =3D <&clk IMX_SC_R_PWM_1 IMX_SC_PM_CLK_PER>;
>  		assigned-clock-rates =3D <24000000>;
> -		#pwm-cells =3D <2>;
> +		#pwm-cells =3D <3>;
>  		interrupts =3D <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>  		status =3D "disabled";
>  	};
> @@ -55,7 +55,7 @@ lsio_pwm2: pwm@5d020000 {
>  			 <&pwm2_lpcg 1>;
>  		assigned-clocks =3D <&clk IMX_SC_R_PWM_2 IMX_SC_PM_CLK_PER>;
>  		assigned-clock-rates =3D <24000000>;
> -		#pwm-cells =3D <2>;
> +		#pwm-cells =3D <3>;
>  		interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>  		status =3D "disabled";
>  	};
> @@ -68,7 +68,7 @@ lsio_pwm3: pwm@5d030000 {
>  			 <&pwm3_lpcg 1>;
>  		assigned-clocks =3D <&clk IMX_SC_R_PWM_3 IMX_SC_PM_CLK_PER>;
>  		assigned-clock-rates =3D <24000000>;
> -		#pwm-cells =3D <2>;
> +		#pwm-cells =3D <3>;
>  		interrupts =3D <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  		status =3D "disabled";
>  	};

Even without patch #1 this is a good change. There are no usages of the
lsio_pwm* handles as of today's next. So no consumers need adaption.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oz2nobh3znr42n5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVIxIkACgkQj4D7WH0S
/k40nAf/QSWz/OiLCpPMO4U/eFmLBdCl3/nDYgwvGMIW2vFrimwdjICw7PQSQlLI
5XgN15jx1vhgkWCg1a68515xVC0I9yaD1klXNs2UyuP/Nrk2Q+3dcNpFYPDf9ivU
96qHk9Qa3thyDyypICQcyXhfjaY4DrYNrG21sxdotLRvInDuT/oaHPxFom9zSbSs
QEgsOHcjPoWIjE/qbRQH8RuHmYys/uI5b/Pg+ckIsMX9EHwRD9pfdKTDDVk3BciP
irKXUONM9s69zdUNBc3/cHn6/WzUE2uHf/1CfJUrlt0nurAVbHYwifcrHu1ja602
9eVWL3/UEEpTR27J960Yg+V5f3yeZQ==
=KdPw
-----END PGP SIGNATURE-----

--oz2nobh3znr42n5o--
