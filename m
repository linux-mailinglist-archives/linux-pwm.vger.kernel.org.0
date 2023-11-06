Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E907E1EE5
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Nov 2023 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjKFKtr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Nov 2023 05:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFKtq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2023 05:49:46 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421ABA1
        for <linux-pwm@vger.kernel.org>; Mon,  6 Nov 2023 02:49:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzxAl-00082W-Vi; Mon, 06 Nov 2023 11:49:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzxAl-0070O8-Fi; Mon, 06 Nov 2023 11:49:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzxAl-00DZCD-6J; Mon, 06 Nov 2023 11:49:35 +0100
Date:   Mon, 6 Nov 2023 11:49:35 +0100
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
Subject: Re: [PATCH 3/3] arm64: dts: freescale: imx8-ss-dma: Fix #pwm-cells
Message-ID: <20231106104935.z6w3amuyv4ra4tvg@pengutronix.de>
References: <20231106095205.231210-1-alexander.stein@ew.tq-group.com>
 <20231106095205.231210-4-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zirwezzrlcwpmgjo"
Content-Disposition: inline
In-Reply-To: <20231106095205.231210-4-alexander.stein@ew.tq-group.com>
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


--zirwezzrlcwpmgjo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Cc -=3D Philippe Schenker]

On Mon, Nov 06, 2023 at 10:52:05AM +0100, Alexander Stein wrote:
> i.MX8QXP supports inverted PWM output, thus #pwm-cells needs to be set
> to 3.
>=20
> Fixes: f1d6a6b991ef9 ("arm64: dts: imx8qxp: add adma_pwm in adma")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/=
boot/dts/freescale/imx8-ss-dma.dtsi
> index ce66d30a4839b..b0bb77150adcc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -149,7 +149,7 @@ adma_pwm: pwm@5a190000 {
>  		clock-names =3D "ipg", "per";
>  		assigned-clocks =3D <&clk IMX_SC_R_LCD_0_PWM_0 IMX_SC_PM_CLK_PER>;
>  		assigned-clock-rates =3D <24000000>;
> -		#pwm-cells =3D <2>;
> +		#pwm-cells =3D <3>;
>  		power-domains =3D <&pd IMX_SC_R_LCD_0_PWM_0>;
>  	};

Even without patch #1 this is a good change. There are no usages of the
adma_pwm handle as of today's next. So no consumers need adaption.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zirwezzrlcwpmgjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVIxL4ACgkQj4D7WH0S
/k7bdAf+LItZtATGir/92wmfaAhs4AnfAIsBPqMDs9WdiO0EZ3WrGeq2fQhHEpcO
dWTunRR9fD4ZM7J5x1fwXB8nZqbjldIAXLnnrpDcyjeKUMCG+Hhv5Y0fy46b/oN6
rOQpqAzrmDmS03sN39YPYDdsjn3IU3c/oUlN5R5zEPU5hKqS4OJHnqpKYjEz9AWj
VRm15xIjvRb27HrxAk73iAvH+sYKHIdb3e2z9U5Mw08Ld/+OH5+hAYm2xv/4Lted
s1UEkDUMfny2/xQ5UV5tZ1koQx+SEfr15UbbGSeTk6HSrhYUIy5OHpyYM9sd1k5S
LPiIF9QlTJ//sMBGR3b4/s8vJNwWVw==
=vbOj
-----END PGP SIGNATURE-----

--zirwezzrlcwpmgjo--
