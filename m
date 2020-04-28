Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578041BB827
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2020 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD1Hxu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Apr 2020 03:53:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37117 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgD1Hxt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Apr 2020 03:53:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 80A095C022F;
        Tue, 28 Apr 2020 03:53:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 03:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZPB1hC2KG5pqxR0AOhhwZaeUt+5
        oFtswYv6gIhtQcvk=; b=ZBnCEL8go8qe1oAOd9Zt9BOKRiQfydtlzVup/5/KW82
        ChAqOh+rkdwzt91dFzPtFer/+OsQeLrO4owOWYhweqR15jwy4/DcAfycrKvMKZKV
        717aiWU6D4G7/xo56yNih/yjTqHzd8FMFMNEH7VOKIug5mcg4wgu50raA94utCj1
        hcW7OljeCPQcSVyynTj4s72aeiQT9cfOQFiJp0WbBAAFsDBzJQq54RYFuvr317Fq
        a0PaiRQl8H9BPK090IuQDXW/iy5/Aol0T6jJOQ25NNVFVkYe7YBa0XzzDfHBpI+H
        wtsbsC1mvztAPK8IT/Bj4cY0Ez+JIE+bJBN2QsgDgmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZPB1hC
        2KG5pqxR0AOhhwZaeUt+5oFtswYv6gIhtQcvk=; b=2uEqZ6z/t9bAOFZM/cRHRw
        Pvz05NUDRFepI166pCa5B6bFjUQSiy/Kiu7hA7hDHUEYGvXSjcWN1H3Kvwf8LXhA
        luKFaZb21J1bDo/RrODGyli+2V9I2UypsPC90xqH0jRtbXL9C4mdWjsdTuVKAK8O
        MqATCTOKBckD1yXuwZvrNMbgTCeSGTyI5ui3UvyWfLC+n0Mf8IX/XijvJFU2IIsu
        XOk3sCiK8URzoO5r3NILbnKSdQ52PufAVTJSlZNKdcafnjRRlAvIPt/8Y1mrQxNL
        9G0vOuSvRX8absxHQrEoTaGWTW3psf0K3iDYqmcRd0lMHh+LEXqoZJCkoK67XPXA
        ==
X-ME-Sender: <xms:C-GnXrtFziZhvCvgN2bZrBk2hOgEqQnGuTw5-5L1DhLv7CX0k5CkxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedtgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:C-GnXoMcYGXFoTMHJi-tlyoWneC9bs6drcru-P-PIQe-6WvcZPdpNQ>
    <xmx:C-GnXnVVfGaxHXpZg8Ex9yWuf0sIv7oCJHk9wHNcM839UwSQ4jUjJA>
    <xmx:C-GnXrW2IZIcL-80XmCsnn7d1Xno45tNUuZX95VOrOjq7754Sb-p4w>
    <xmx:DOGnXl1ZpTtwuB0YBdGniaZR-3yXiTpMWuGBz8u6-DWDeA85GprxRQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AB64C3065E9C;
        Tue, 28 Apr 2020 03:53:47 -0400 (EDT)
Date:   Tue, 28 Apr 2020 09:53:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Peter Vasil <peter.vasil@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sun4i: direct clock output support for Allwinner A64
Message-ID: <20200428075346.xjzmmvios64emg5z@gilmour.lan>
References: <20200426101122.98318-1-peter.vasil@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sjnuyyybmloorp7b"
Content-Disposition: inline
In-Reply-To: <20200426101122.98318-1-peter.vasil@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sjnuyyybmloorp7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 26, 2020 at 12:11:22PM +0200, Peter Vasil wrote:
> Allwinner A64 is capable of a direct clock output on PWM (see A64
> User Manual chapter 3.10). Add support for this in the sun4i PWM
> driver and adjust compatibility in sun50i-a64 base device tree.
>=20
> Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++----
>  drivers/pwm/pwm-sun4i.c                       | 9 +++++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 31143fe64d91..c334fd106854 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -1069,8 +1069,7 @@ gic: interrupt-controller@1c81000 {
>  		};
> =20
>  		pwm: pwm@1c21400 {
> -			compatible =3D "allwinner,sun50i-a64-pwm",
> -				     "allwinner,sun5i-a13-pwm";
> +			compatible =3D "allwinner,sun50i-a64-pwm";
>  			reg =3D <0x01c21400 0x400>;
>  			clocks =3D <&osc24M>;
>  			pinctrl-names =3D "default";
> @@ -1252,8 +1251,7 @@ r_ir: ir@1f02000 {
>  		};
> =20
>  		r_pwm: pwm@1f03800 {
> -			compatible =3D "allwinner,sun50i-a64-pwm",
> -				     "allwinner,sun5i-a13-pwm";
> +			compatible =3D "allwinner,sun50i-a64-pwm";

There's no need to remove that compatible, it's actually working as intende=
d..

>  			reg =3D <0x01f03800 0x400>;
>  			clocks =3D <&osc24M>;
>  			pinctrl-names =3D "default";
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 5c677c563349..18fbbe3277d0 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -352,6 +352,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_=
bypass =3D {
>  	.npwm =3D 1,
>  };
> =20
> +static const struct sun4i_pwm_data sun50i_a64_pwm_data =3D {
> +	.has_prescaler_bypass =3D true,
> +	.has_direct_mod_clk_output =3D true,
> +	.npwm =3D 1,
> +};
> +
>  static const struct sun4i_pwm_data sun50i_h6_pwm_data =3D {
>  	.has_prescaler_bypass =3D true,
>  	.has_direct_mod_clk_output =3D true,
> @@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] =
=3D {
>  	}, {
>  		.compatible =3D "allwinner,sun8i-h3-pwm",
>  		.data =3D &sun4i_pwm_single_bypass,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-a64-pwm",
> +		.data =3D &sun50i_a64_pwm_data,

Ie, if the OS only has support for the A13, then it will use it as an A13, =
and
if it has support for the A64 variant, then it can use some more advanced
features.

Maxime

--sjnuyyybmloorp7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfhCgAKCRDj7w1vZxhR
xWYNAP0XwagPq8Ucjl/id9ax9GqE/UVZAeVIhpIf1azXshxpKAEAjhQ3ptJzGoRq
WPVqQ9VSEdoRLsCRzcOfVK2X5rKvMQQ=
=sF/u
-----END PGP SIGNATURE-----

--sjnuyyybmloorp7b--
