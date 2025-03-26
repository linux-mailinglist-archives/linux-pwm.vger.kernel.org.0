Return-Path: <linux-pwm+bounces-5288-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87CA715FF
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 12:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6933B62FE
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCAF1DDC12;
	Wed, 26 Mar 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxcEXp+q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B01DDC2C;
	Wed, 26 Mar 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989504; cv=none; b=BseEasOa5g+fZVDl/ehPFfhwNmOfolQXJQGh/WK/4nInFNQcPfqHWYvBKnAcUWY8ds4RnBedChZmGnK6+z8Tq9bMSlnENOS1ePGhLbwvSHkMrCJEUR3GxR9JMfv8o3qdLPEBCeY2wumVdTgWFuYqXV2vmBTnk5dLkcJ2J/VhV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989504; c=relaxed/simple;
	bh=IDlQ1pxue6ivR6VV71fMEuxnvU0Ny+O/VjCAHOK8J34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoncoC8ZlNYGQj5Fq9XgO5d1yJkVVZEFmUd4b4AlUDjdCDyY5ASR8hSlqiVRlbmZD7YGCp6hsWOrpTZavBJ/vX44DriRwDCKztJA9DlyyJsBQvEDRmx/6LqOljbU0wm+VnjHfZBdEDrCBxQC++i8v6Dkyl/s9NSUxqhvFVayJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxcEXp+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F968C4CEE2;
	Wed, 26 Mar 2025 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989504;
	bh=IDlQ1pxue6ivR6VV71fMEuxnvU0Ny+O/VjCAHOK8J34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxcEXp+qKRnTXEJt95LjmCsudiz/X07xCwCivfrS/7yo+ugNyNUczt1FtN5uCzsD3
	 d9Av49Lyf2wwszBnfhqUofGj/PYZk8YEiIzLH3bho+dV2xGvqf1KHfKuNIoXe0UJr2
	 CctRAwo5Haq8kVdPhxQqyop+9M9xrYSuEEqktSHOg9E33FbUZCrNnhG/sJ3nV4CqVd
	 oaY29Y1FmOnZN5SCd6dYWb20PQnJZWLfwiYpgcVaI/12ZB+FaWgqrCDB59zee0LIiJ
	 wMYnnkiefPcHWA5tIbYxUJOBzsD5YFxLOyiSrUkjS7SND2ZdhWY1F4z5rf/7QKMAnx
	 d2a6Q7JkGivmw==
Date: Wed, 26 Mar 2025 12:45:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] pwm: ehrpwm: ensure clock and runtime PM are
 enabled if hardware is active
Message-ID: <lhqi2eqfj5eyc67yriezvwwiyusenyohvqzbfrwjkjfjvxxb7a@xwvhrgmer4a7>
References: <20250207213234.1026-1-rafael.v.volkmer@gmail.com>
 <20250207213424.1117-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ttpxce4gkzgjb3i3"
Content-Disposition: inline
In-Reply-To: <20250207213424.1117-1-rafael.v.volkmer@gmail.com>


--ttpxce4gkzgjb3i3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] pwm: ehrpwm: ensure clock and runtime PM are
 enabled if hardware is active
MIME-Version: 1.0

Hello Rafael,

On Fri, Feb 07, 2025 at 06:34:24PM -0300, Rafael V. Volkmer wrote:
> During probe, if the hardware is already active, it is not guaranteed
> that the clock is enabled. To address this, ehrpwm_pwm_probe() now
> checks whether the PWM is enabled and ensures that the necessary
> resources are initialized.
>=20
> Changes:
> - Call ehrpwm_get_state() during probe to check if the PWM is active.
> - If the PWM is enabled, call clk_prepare_enable() to ensure the clock
> is active.
> - If the clock is successfully enabled, call pm_runtime_get_sync() to
> manage power state.
> - Handle failure cases by properly disabling and unpreparing the clock.

This is too detailed, just drop the changes list.

> This ensures that the driver correctly handles cases where the hardware
> is already in use at the time of initialization, preventing potential
> failures due to uninitialized resources.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 52527136c507..30beaf7d1721 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -633,8 +633,10 @@ static int ehrpwm_pwm_probe(struct platform_device *=
pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct ehrpwm_pwm_chip *pc;
> +	struct pwm_state state;
>  	struct pwm_chip *chip;
>  	struct clk *clk;
> +	bool tbclk_enabled;
>  	int ret;
> =20
>  	chip =3D devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
> @@ -676,6 +678,18 @@ static int ehrpwm_pwm_probe(struct platform_device *=
pdev)
>  		return ret;
>  	}
> =20
> +	ehrpwm_get_state(chip, &chip->pwms[0], &state);

ehrpwm_get_state() does some things that are not needed here given that
you only evaluate state.enabled. I suggest to just read the one (or
two?) registers you need to determine if the PWM is on.

> +	if (state.enabled =3D=3D true) {
> +		ret =3D clk_prepare_enable(pc->tbclk);

pc->tbclk is already prepared, so clk_enable() should be enough. After
all this should match what ehrpwm_pwm_enable() does.

> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret, "clk_prepare_enable() failed");
> +			goto err_pwmchip_remove;
> +		}
> +
> +		tbclk_enabled =3D true;
> +	}
> +
>  	ret =3D pwmchip_add(chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> @@ -685,10 +699,22 @@ static int ehrpwm_pwm_probe(struct platform_device =
*pdev)
>  	platform_set_drvdata(pdev, chip);
>  	pm_runtime_enable(&pdev->dev);
> =20
> +	if (state.enabled =3D=3D true) {
> +		ret =3D pm_runtime_get_sync(&pdev->dev);
> +		if (ret < 0) {
> +			dev_err_probe(&pdev->dev, ret, "pm_runtime_get_sync() failed");
> +			clk_disable_unprepare(pc->tbclk);
> +			goto err_pwmchip_remove;
> +		}

It feels a bit strange to do this here. I think technically it's fine
here, but doing pm_runtime_get_sync() before pwmchip_add() would make
that a bit clearer.

> +	}
> +
>  	return 0;
> =20
> +err_pwmchip_remove:
> +	pwmchip_remove(chip);
>  err_clk_unprepare:
> -	clk_unprepare(pc->tbclk);
> +	if (tbclk_enabled)
> +		clk_unprepare(pc->tbclk);

I think this is wrong an keeping the unconditional clk_unprepare() is
right. Might be easier to convert the driver to use
devm_clk_get_enabled().

Best regards
Uwe

--ttpxce4gkzgjb3i3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfj6LsACgkQj4D7WH0S
/k6QfwgAlGnueFvwoFNQOQPepk1zo9DerzX7xNnwYpc2tDjtAAyiaG2NoL8FWBAy
HtzE5a2fY5GebeD6O1cLPd4GWkIvLBjhVGmAZN29yyGoeUVvTydet8QXEARSAa5V
wNotfZAs4Jvod0IhIFAUD0PTQDOSrTu+Tyvg8ranSM26H9EDU7RdascBp8oeDGcA
7EZZqO62jSMYSeFLuYbhwQkAQgDe4Zr2gdGenV+RI01E33OYEZzIPlm3mFMxrPFx
1bQHbk0MzLIlQBIrPE+vf3RXp++lFkufwJgJ7Oue7Q4dR/I4nIriyy/iLU33t+wd
iPJOpkODSWGwFDAgtoLQVq1S3SxVhA==
=C9jI
-----END PGP SIGNATURE-----

--ttpxce4gkzgjb3i3--

