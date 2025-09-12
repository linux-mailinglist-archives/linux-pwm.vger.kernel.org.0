Return-Path: <linux-pwm+bounces-7300-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AAB54831
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF2A7A35DF
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDE261B72;
	Fri, 12 Sep 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP3Drm2M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0614241663;
	Fri, 12 Sep 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670326; cv=none; b=RAjbAZ8GmCVK5VIL8+lS/zwNTuzyDkEQPMMsxxqgRelsm9ASRs4uHwa42MPiPFtUXDQ87ZWrsQFWmOs+YPLbbdSQ7FerguDpgNRK6jB0v+V3dE2XEI7raZySNzTVbVj8moB8tU01Fl+ECmpgDQFo6cSzZ5O0TFc8vl3o8oax1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670326; c=relaxed/simple;
	bh=zr4igsr8oFeCiBW9+aaQVL2zxhxlT/E+EeXpT4KWGCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgpWQItEbJeSRXkH2pgqLyAXAlXOfibrO2R6mBYWYLLDabKhIz72/wkQdn2xdrQ2k8rMRRZkX6mto0Z2TMId0FzGbZhSM99OUyxb0gFbvKnhE6oUK23AV9WZGmZTvhSog2+Bko9BiS/Vjvh3BN7I2dHsvd1oJ0zc+s//+WUgrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP3Drm2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B770FC4CEF1;
	Fri, 12 Sep 2025 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757670326;
	bh=zr4igsr8oFeCiBW9+aaQVL2zxhxlT/E+EeXpT4KWGCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mP3Drm2MCi5c/EOK7gSIX8JcfxHCc3bqEEvkb54MJrsvBCr+UWSM9/7dGJtwEokcx
	 dtchJ88D6DchUOeXdYmDRfJZ75bC9edXf0vEHu9hBEqG3fs5Ds5fqd4/CCOAUKbRhV
	 +xKW81YPDjGQOlk6jPqmOKnu/FXOtCYzamvSX5BjyQ9Qq5w/+Qd3VSifgwsYcDQ4tl
	 MaGlegYreXTdjoSGYkdDM1MxUA4EpeYFPfELKHEb5d0N68S+E4RdcONpbhsJc+SF+A
	 KyZnhnWRZ4ZKnvAPXWLYCCpb35EoBpcKk658w/UPwmVKP4DCYWHcLsb+IF/4tNlymu
	 YPdSRa09hF1UA==
Date: Fri, 12 Sep 2025 11:45:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
Message-ID: <qdqla4f5nfccqg2vdwkshzo6znwfizqizsyhfs7ksp6znja7uv@u4uwzvx7pgn6>
References: <20250904210604.186893-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bx4cacmerglue3jb"
Content-Disposition: inline
In-Reply-To: <20250904210604.186893-1-marek.vasut+renesas@mailbox.org>


--bx4cacmerglue3jb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
MIME-Version: 1.0

Hello Marek,

On Thu, Sep 04, 2025 at 11:05:28PM +0200, Marek Vasut wrote:
> Convert the driver from legacy PWM apply ops to modern waveform ops.
> There is no functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Uwe Kleine-K=F6nig" <ukleinek@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Safeguard against wf->duty_length_ns > wf->period_length_ns
> ---
>  drivers/regulator/rpi-panel-v2-regulator.c | 53 +++++++++++++++++-----
>  1 file changed, 42 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/regulator/rpi-panel-v2-regulator.c b/drivers/regulat=
or/rpi-panel-v2-regulator.c
> index 30b78aa75ee38..eb4c4e3ead364 100644
> --- a/drivers/regulator/rpi-panel-v2-regulator.c
> +++ b/drivers/regulator/rpi-panel-v2-regulator.c
> @@ -35,24 +35,55 @@ static const struct regmap_config rpi_panel_regmap_co=
nfig =3D {
>  	.can_sleep =3D true,
>  };
> =20
> -static int rpi_panel_v2_pwm_apply(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> -				  const struct pwm_state *state)
> +static int rpi_panel_v2_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +						struct pwm_device *pwm,
> +						const struct pwm_waveform *wf,
> +						void *_wfhw)
>  {
> -	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> -	unsigned int duty;
> +	u8 *wfhw =3D _wfhw;
> +
> +	if (wf->duty_length_ns > wf->period_length_ns)
> +		*wfhw =3D 100;
> +	else
> +		*wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, 100, wf->period_leng=
th_ns);

If I understand correctly the device has a fixed period length but the
actual length is unknown and so assumed to be 100 ms, right?

In this case the right incarnation for .round_waveform_tohw() is:

/*
 * The device has a fixed but unknown period length. To have something
 * to work with, we're assuming this fixed length is 100 ms.
 */
#define RPI_PANEL_V2_PERIOD_NS 100000

static int rpi_panel_v2_pwm_round_waveform_tohw(...)
{
	u8 *wfhw =3D _wfhw;

	if (wf->period_length_ns =3D=3D 0) {
		*wfhw =3D 0;
		return 0;
	}

	if (wf->duty_length_ns >=3D RPI_PANEL_V2_PERIOD_NS)
		*wfhw =3D 100;
	else
		*wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, 100, RPI_PANEL_V2_PERIO=
D_NS);

	if (wf->period_length_ns < RPI_PANEL_V2_PERIOD_NS)
		return 1;
	else
		return 0;
}

Extra points are awarded if you come up with a nice name for the plain
100 in here, maybe RPI_PANEL_V2_DUTY_STEPS?

Best regards
Uwe

--bx4cacmerglue3jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjD67EACgkQj4D7WH0S
/k5IxggAmOsqibUsxYYJGyq8oIKpR2r1k73zJ5A8alctw77tLRk5qQ1pIOluqyZ7
gfQCEEJ6ywfJHYNRbtsDj8pAnMGXV0VQhyTA9l7U6umua1ANZLA4wnLUKcG2CScA
FtLiSU3qAgf1CzXeugFTn15kZt641v2im92oeYW2IMzZ0fksh+SDcmJnZxed1/Xs
gdqDL369JW1Z0GaXH8Fhgpj+PLungONCGSxUtOE23FFImhzrh6UllNPWri4yTtHi
iJFrp9m1XyIB1ll6PmwuX2+bMpAJ/a2yMCWpasih14NQt2D0cne61g40jenedFw3
c5+ZyKu9rGC4RTY2hAKL7DAbvRzG2g==
=1NrA
-----END PGP SIGNATURE-----

--bx4cacmerglue3jb--

