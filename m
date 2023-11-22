Return-Path: <linux-pwm+bounces-140-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1A7F44B9
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 12:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F171C208C7
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D52111A;
	Wed, 22 Nov 2023 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq7hj2Y6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A31DFE7
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 11:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2EDC433C7;
	Wed, 22 Nov 2023 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700651665;
	bh=PNxMxyBLvFrW4CyQkjkhff3t3XWgbfP+g9tudnvbQXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xq7hj2Y6ZYz0RLuGBjo6LS5d73GFEouXFX4F6EFohh5wvyCTny4vOK8a9ouEOwNT/
	 0Dy5DANOoQwajAOOGZxkeFm/JeO0Y4AKyob7IfhW98xd7W0Z+RjK9zKqVEe2/kKWKD
	 7BP+ngTMUiZkin2zGrjxuGbk3gYmtJR/t1PkyoTy17yvUtefrMsfWpZbVOv44uqlDE
	 T3VMwvNlm31xfN06gqDEBo60y7XsQM0lVazTtsiQJmEl7WJ1STtq/XH5gtyil7NmQO
	 wEDb0m4V6fcCiF5+NU9TTJZkxeRoqSXqjDXEdYPKlki0yaeZ5mvMvwUjsmPi50w8Wx
	 9H9hxR8c7nmjg==
Date: Wed, 22 Nov 2023 11:14:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 070/108] pwm: microchip-core: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231122-endanger-extenuate-97ef77b117da@spud>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-71-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SXnJvv4kOgRYNGEg"
Content-Disposition: inline
In-Reply-To: <20231121134901.208535-71-u.kleine-koenig@pengutronix.de>


--SXnJvv4kOgRYNGEg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:50:12PM +0100, Uwe Kleine-K=F6nig wrote:
> This prepares the pwm-microchip-core driver to further changes of the pwm=
 core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-microchip-core.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip=
-core.c
> index c0c53968f3e9..6e0c2cbfc120 100644
> --- a/drivers/pwm/pwm-microchip-core.c
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -54,7 +54,6 @@
>  #define MCHPCOREPWM_TIMEOUT_MS	100u
> =20
>  struct mchp_core_pwm_chip {
> -	struct pwm_chip chip;
>  	struct clk *clk;
>  	void __iomem *base;
>  	struct mutex lock; /* protects the shared period */
> @@ -65,7 +64,7 @@ struct mchp_core_pwm_chip {
> =20
>  static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chi=
p *chip)
>  {
> -	return container_of(chip, struct mchp_core_pwm_chip, chip);
> +	return pwmchip_priv(chip);
>  }

I know this is likely a coccinelle job, but can we now delete things
like to_mchp_core_pwm() if there's a standard helper for this now?

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>  static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> @@ -447,13 +446,15 @@ MODULE_DEVICE_TABLE(of, mchp_core_of_match);
> =20
>  static int mchp_core_pwm_probe(struct platform_device *pdev)
>  {
> +	struct pwm_chip *chip;
>  	struct mchp_core_pwm_chip *mchp_core_pwm;
>  	struct resource *regs;
>  	int ret;
> =20
> -	mchp_core_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_=
KERNEL);
> -	if (!mchp_core_pwm)
> -		return -ENOMEM;
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, 16, sizeof(*mchp_core_pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	mchp_core_pwm =3D to_mchp_core_pwm(chip);
> =20
>  	mchp_core_pwm->base =3D devm_platform_get_and_ioremap_resource(pdev, 0,=
 &regs);
>  	if (IS_ERR(mchp_core_pwm->base))
> @@ -470,9 +471,7 @@ static int mchp_core_pwm_probe(struct platform_device=
 *pdev)
> =20
>  	mutex_init(&mchp_core_pwm->lock);
> =20
> -	mchp_core_pwm->chip.dev =3D &pdev->dev;
> -	mchp_core_pwm->chip.ops =3D &mchp_core_pwm_ops;
> -	mchp_core_pwm->chip.npwm =3D 16;
> +	chip->ops =3D &mchp_core_pwm_ops;
> =20
>  	mchp_core_pwm->channel_enabled =3D readb_relaxed(mchp_core_pwm->base + =
MCHPCOREPWM_EN(0));
>  	mchp_core_pwm->channel_enabled |=3D
> @@ -485,7 +484,7 @@ static int mchp_core_pwm_probe(struct platform_device=
 *pdev)
>  	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
>  	mchp_core_pwm->update_timestamp =3D ktime_get();
> =20
> -	ret =3D devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
> +	ret =3D devm_pwmchip_add(&pdev->dev, chip);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "Failed to add pwmchip\n");
> =20
> --=20
> 2.42.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--SXnJvv4kOgRYNGEg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV3ijQAKCRB4tDGHoIJi
0uH/AQD4m6PopEGhG9YwIxM6lYeFLIA8mpHBwkgQVVUzTKCrDAEAlBGTd+DJ67Hy
YWE5VSVNkHRXkYGOW3wz25bwwjzb/Ao=
=A3wH
-----END PGP SIGNATURE-----

--SXnJvv4kOgRYNGEg--

