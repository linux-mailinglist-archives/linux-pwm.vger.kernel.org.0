Return-Path: <linux-pwm+bounces-6923-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F7B17CF3
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 08:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AC756826C
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1E01E9B1A;
	Fri,  1 Aug 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efcLyhlN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68035947;
	Fri,  1 Aug 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754029944; cv=none; b=nNwXFIpGATYKzzPq/DNBplyUMQEu6ZiXa3iJ6uQ0MWhcY9F9LELqZr95n5LPGT4z2Hxg0OOqFxLuRGc4LNy44CtrZp5zBlLIZxdRMCJ99wYm7TJySNfV79sxk4OFTikpc/zLO/lUMqmNCJDy4ZsPvc/r/Wp1xn3o7J7vNlm1tDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754029944; c=relaxed/simple;
	bh=eIiFUVgGSXBHvbSvziZE19G/3P8hn7IYoFtSy10Y8v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq4/leJr0953tnDUkvauBDq7jKDiK1PKq8qj8Wi4YQBZUf1/vtZNbDY/qZdWF/3uV5AP244ExX7ce+rrshmVpcmxOA/VUnPwBpt61ppvm0Tc4aTGxHyGJeuXUiYAA6BOLOeaf5C8Fr5qQ9CfonELf8g03m6A6ulDpqXCATFV5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efcLyhlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ECBC4CEE7;
	Fri,  1 Aug 2025 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754029943;
	bh=eIiFUVgGSXBHvbSvziZE19G/3P8hn7IYoFtSy10Y8v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efcLyhlNsbVd7SqXqitE7oWL6abcF0Eg3ZmL/kxC1QanPCyDdjF53z4dvU6BB1cL8
	 s+xVokoWHlLWz0isLkjgoM8GwNBqYhW51hA27JjcwHP24o0CGv++mZ13D/4B41mPLm
	 Kbji0kxUlO5Bv/qkvuZDTbnOABSBy3IWpZoeiOK5egmRNmbTp5cq6eIf6s3SBs4P3J
	 5KV+Y2IMOSANKJsCrceGISXa/LwQNnXOZl5hRxzZoSC0p6GWIW+rGwFCSbOhFO7IAP
	 ayaMfGMy3m2Ee33XKCb+dgEtR4aR6SSGUFb81VH/yKjCpP6P8q/L1W7pKh7mLUUaee
	 q5Gwp7XGUTH1Q==
Date: Fri, 1 Aug 2025 08:32:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <n6rltuxqwybh2mwzz3hxi3tzix2c7q3mbovscobzzmkj6puo6w@gc3qnchjlagq>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qtwimeejsuq2uv6"
Content-Disposition: inline
In-Reply-To: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>


--2qtwimeejsuq2uv6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
MIME-Version: 1.0

Hallo Michael,

On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 237d3d3f3bb1a..5924e0b9f01e7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -518,13 +518,6 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>  	if (!state.period && (data->pwm_period_ns > 0))
>  		state.period =3D data->pwm_period_ns;
> =20
> -	ret =3D pwm_apply_might_sleep(pb->pwm, &state);
> -	if (ret) {
> -		dev_err_probe(&pdev->dev, ret,
> -			      "failed to apply initial PWM state");
> -		goto err_alloc;
> -	}
> -
>  	memset(&props, 0, sizeof(struct backlight_properties));
> =20
>  	if (data->levels) {
> @@ -582,6 +575,15 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>  	pb->lth_brightness =3D data->lth_brightness * (div_u64(state.period,
>  				pb->scale));
> =20
> +	state.duty_cycle =3D compute_duty_cycle(pb, data->dft_brightness, &stat=
e);
> +
> +	ret =3D pwm_apply_might_sleep(pb->pwm, &state);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "failed to apply initial PWM state");
> +		goto err_alloc;
> +	}
> +

I wonder why the PWM is updated at all in .probe(). Wouldn't it be the
natural thing to keep the PWM configured as it was (in its reset default
state or how the bootloader set it up)?

Orthogonal to your change, while looking at the driver I wondered about:

        bl =3D backlight_device_register(dev_name(&pdev->dev), &pdev->dev, =
pb,
                                       &pwm_backlight_ops, &props);
        if (IS_ERR(bl)) {
                ret =3D dev_err_probe(&pdev->dev, PTR_ERR(bl),
                                    "failed to register backlight\n");
                goto err_alloc;
        }

        if (data->dft_brightness > data->max_brightness) {
                dev_warn(&pdev->dev,
                         "invalid default brightness level: %u, using %u\n",
                         data->dft_brightness, data->max_brightness);
                data->dft_brightness =3D data->max_brightness;
        }

        bl->props.brightness =3D data->dft_brightness;
        bl->props.power =3D pwm_backlight_initial_power_state(pb);
        backlight_update_status(bl);

Shoudn't setting data->dft_brightness, bl->props.brightness and
bl->props.power better happen before backlight_device_register()? Also
calling backlight_update_status() after backlight_device_register()
seems wrong to me, I'd claim the backend driver shouldn't call that.

Best regards
Uwe

--2qtwimeejsuq2uv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiMX3IACgkQj4D7WH0S
/k4ZKQf/Yc01XOQm1bWT/1IkKiUWknBWfZ5khsEyrY4ZPJkEnDgN46+6HC1kx1R1
1MFO30rtLFO8D3OFCI8meDxfrMzMcMXivCbx7L/PKRHynX7CcwgP2kV5Tw/DPwlr
QB++vOFZs7iy8XR4n5b9kXFChysXXI0nDL78sY9wuuTb48IdMJmceTJujlXIw7RX
4ln69h07AIZSf7bFY0kqnqomudJuWdSveBRCU8KPcAdR56cIC3wAxiHPdn4lSuMk
8QrojPSun2MiwEi0NJWvGC1rPcL/L09VqPk2QS3x9hUfjAgLyPOQ3lCSuOxbo4Q5
1EO/UUw6KGnWQ5CrvEuPpK+HHCTSww==
=s4Ev
-----END PGP SIGNATURE-----

--2qtwimeejsuq2uv6--

