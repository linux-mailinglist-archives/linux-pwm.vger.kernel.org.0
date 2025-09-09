Return-Path: <linux-pwm+bounces-7278-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF1B4FE3E
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 15:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DDE5E091E
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1B3431E2;
	Tue,  9 Sep 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUNS3aBv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A3342CB6;
	Tue,  9 Sep 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425765; cv=none; b=oqhVvs3CshdeTCPuY0RDbVvphs5x5hIK41BDryV3Gx/sjVwH+2tj2HlEu3GPvsVW8APPguY7JOKMpoghtNYntPaC2e/DJmaWkRnxmW5gHKgodyqBNWwxQ5DFAxms7YXedDw6oNjuQiy7ICoLF+j1jN2E0368/V9Rowns/MeFbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425765; c=relaxed/simple;
	bh=49gZNr2H7kccNqE5XR78ZGc2FVHa7pQDJF9bw7z2c/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7gES1ixVHh2iTribllgNkO1f0QQjApjkOWjHTgMyCZBjvogI0FcxL9ARgTQZNiUqhJ11NYcNaHOH9oYEKir+rZOS4zCNg8Bwuz/PLJnGdeCw7Fu8Lg2w8NV5m64wPGZ00YHyCHADQkVfmLyAEN3eTrjOanutRPLjf8R6HVA2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUNS3aBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2CAC4CEF7;
	Tue,  9 Sep 2025 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757425764;
	bh=49gZNr2H7kccNqE5XR78ZGc2FVHa7pQDJF9bw7z2c/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUNS3aBv17s4mfY42cI+aghlpnercgKfmDtnImYtucNS6mqCKtDfNjOg7amxH+TCK
	 lcRE+yACfehHA02LBH75TsHgCypy4X7IrXAltdoQE1cU+5/lT/mA6gHsaxgtTnb13f
	 M2UTl1+Lq722rHyS6+Ti0VxP+8qZk+dOau/p9c2RMWfY78/iVUO2mzjsLyG6DLb12X
	 ocIzKXKbBHI9TBREkqbp1DPYZNq4GU6GIPzALkARqLgs+PPfAdwldPFrV/44sYB6DM
	 ykflOQV27hBIj8dmdVDne81ZDm2DHnJLUWiGMnW57Tl6x1WVcoQEL3UdT8IZrpFW2T
	 N1nep5yJQq4EA==
Date: Tue, 9 Sep 2025 15:49:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <7zae3uaz5wdk2ktmg44aqdnfjglklqujtktslvlye3ssd3xvbv@qwwjiip6kgfo>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <n6rltuxqwybh2mwzz3hxi3tzix2c7q3mbovscobzzmkj6puo6w@gc3qnchjlagq>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5ajcr2dlqwa72tk"
Content-Disposition: inline
In-Reply-To: <n6rltuxqwybh2mwzz3hxi3tzix2c7q3mbovscobzzmkj6puo6w@gc3qnchjlagq>


--d5ajcr2dlqwa72tk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
MIME-Version: 1.0

Hello Michael,

On Fri, Aug 01, 2025 at 08:32:20AM +0200, Uwe Kleine-K=F6nig wrote:
> Hallo Michael,
>=20
> On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
> > index 237d3d3f3bb1a..5924e0b9f01e7 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -518,13 +518,6 @@ static int pwm_backlight_probe(struct platform_dev=
ice *pdev)
> >  	if (!state.period && (data->pwm_period_ns > 0))
> >  		state.period =3D data->pwm_period_ns;
> > =20
> > -	ret =3D pwm_apply_might_sleep(pb->pwm, &state);
> > -	if (ret) {
> > -		dev_err_probe(&pdev->dev, ret,
> > -			      "failed to apply initial PWM state");
> > -		goto err_alloc;
> > -	}
> > -
> >  	memset(&props, 0, sizeof(struct backlight_properties));
> > =20
> >  	if (data->levels) {
> > @@ -582,6 +575,15 @@ static int pwm_backlight_probe(struct platform_dev=
ice *pdev)
> >  	pb->lth_brightness =3D data->lth_brightness * (div_u64(state.period,
> >  				pb->scale));
> > =20
> > +	state.duty_cycle =3D compute_duty_cycle(pb, data->dft_brightness, &st=
ate);
> > +
> > +	ret =3D pwm_apply_might_sleep(pb->pwm, &state);
> > +	if (ret) {
> > +		dev_err_probe(&pdev->dev, ret,
> > +			      "failed to apply initial PWM state");
> > +		goto err_alloc;
> > +	}
> > +
>=20
> I wonder why the PWM is updated at all in .probe(). Wouldn't it be the
> natural thing to keep the PWM configured as it was (in its reset default
> state or how the bootloader set it up)?
>=20
> Orthogonal to your change, while looking at the driver I wondered about:
>=20
>         bl =3D backlight_device_register(dev_name(&pdev->dev), &pdev->dev=
, pb,
>                                        &pwm_backlight_ops, &props);
>         if (IS_ERR(bl)) {
>                 ret =3D dev_err_probe(&pdev->dev, PTR_ERR(bl),
>                                     "failed to register backlight\n");
>                 goto err_alloc;
>         }
>=20
>         if (data->dft_brightness > data->max_brightness) {
>                 dev_warn(&pdev->dev,
>                          "invalid default brightness level: %u, using %u\=
n",
>                          data->dft_brightness, data->max_brightness);
>                 data->dft_brightness =3D data->max_brightness;
>         }
>=20
>         bl->props.brightness =3D data->dft_brightness;
>         bl->props.power =3D pwm_backlight_initial_power_state(pb);
>         backlight_update_status(bl);
>=20
> Shoudn't setting data->dft_brightness, bl->props.brightness and
> bl->props.power better happen before backlight_device_register()? Also
> calling backlight_update_status() after backlight_device_register()
> seems wrong to me, I'd claim the backend driver shouldn't call that.

Do you intend to work on this orthogonal feedback? If not, I'll put it
on my todo list.

Best regards
Uwe

--d5ajcr2dlqwa72tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjAMFsACgkQj4D7WH0S
/k4BWQgAuXV/ULnAxDCQ3VIqXyMJPZ9q/2BOe6oUyBZUls9TN9oBBE97kCYQT03v
nY/10hGSr8Pf3XZ/VJfXQX7LCV/Scc0U0Ufz2Pwtb01s7zERx4SgBlHW9k/a4IB8
UQ/BmYixfkuQoVFsNhjzgsyzR0Yul5abMKBwWme86iu3L4PWWzs0Nt8p0otOV5Yw
HabxoMBQTTVx2MvK8u9tWB3xkinIzXxVDowWKB7FR7kQpcoCxy6XJnAI0BSwDvNV
8YywwiaiNGdecrHj0vBDY7yTPiiT8BKAi1H3SiwFdn3cO//lnhbqzNHntPQ1N67V
ZoGfcECUaGfqJL2w5nsRXewnLty7qA==
=YVsb
-----END PGP SIGNATURE-----

--d5ajcr2dlqwa72tk--

