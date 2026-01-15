Return-Path: <linux-pwm+bounces-7908-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C7CD23E1B
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7AAC30C4DF8
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA022E406;
	Thu, 15 Jan 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCwTXVrJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAF35502E;
	Thu, 15 Jan 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471970; cv=none; b=Yhup0mnEdCmtWAdQb82jHrhvWZKzVCBLTCYW85eeDjZpu5mOCJRH+1EHgpHGNEdil/fEw+oKzRhoXd2atIF30hrBkemafof/hZl7OPeCjHGmcpg1fxriTanNLq6P84FG2KMpewznX5OAPpTzfTkNI/04iDFumKw/fhoENW2EW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471970; c=relaxed/simple;
	bh=b56RGhLOtRjjybNXQNgvNL72Y47QdshbNg6rQtKxVLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo+o0fedUyShOWV+mSzGZ82+Tv/+hYGQU7dqUQm+7g1fgNqDLzJJFN4d6O24pYRY6Phr9SZ0aOYffji9hzhIUhnqvzQqkGANq9gEIjsV7FbM8forAWxc3hddOa3xDRonFt8s3pqX8Tgq01tRn35gEIetdw6+iXx+00C18jqLLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCwTXVrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A13C16AAE;
	Thu, 15 Jan 2026 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768471970;
	bh=b56RGhLOtRjjybNXQNgvNL72Y47QdshbNg6rQtKxVLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCwTXVrJKq2DqL0aQJh5O7w2L/ZgGxkw0BaKNK/mLS15pU2EB8OleQ+cLmZh5er1+
	 qEXNmYHa4zk/N++2zEwmcqhpQPIPM3wwU1Xkecg/96czfsdcTWGHzhZ1y9YZ6x10Aa
	 xq/5sXrELWVVbdcRXbE7H2MPX5N1ZAgLMoTl6uw34T8QSBJKH6a647mEh//ZSuVhzM
	 PdiNUsEE3umcVUGoGGq58GVQZaUrkYjiB4Ke8UXQaB3hAbyGsy5CpivhTOSnp6DlMy
	 uxo1s+j+XRWXf8be7x1S604mMwTJWIRF86Nmxx0P5nYASh5MkOFuXzzgpJ8cLi7jke
	 x2lT6Q+sNzvFg==
Date: Thu, 15 Jan 2026 11:12:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
Message-ID: <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aa5bmvbnmoppupnu"
Content-Disposition: inline
In-Reply-To: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>


--aa5bmvbnmoppupnu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
MIME-Version: 1.0

On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
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

I would claim that this is a bug in the core if a driver sees such a wf
variable.

> V3: - Use PWM_BL_MASK as the maximum period length
> ---
> Note this now generates warnings:
> pwm pwmchip5: Wrong rounding: requested 162/255 [+0], result 19000/31000 =
[+0]

So the driver is wrong, see below.

> ---
>  drivers/regulator/rpi-panel-v2-regulator.c | 53 +++++++++++++++++-----
>  1 file changed, 42 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/regulator/rpi-panel-v2-regulator.c b/drivers/regulat=
or/rpi-panel-v2-regulator.c
> index 30b78aa75ee38..e5e12ff649804 100644
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
> +		*wfhw =3D PWM_BL_MASK;
> +	else
> +		*wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_MASK, wf->per=
iod_length_ns);

This is wrong. There was already a discussion about this in reply to v2.
I'll discard this patch from my queue and continue the v2 thread.

Best regards
Uwe

--aa5bmvbnmoppupnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlovZwACgkQj4D7WH0S
/k7sigf9HJJx5e1JMkOMuo9HfOkLSVR3uxUfSn5YyiNEco8qlh2Dse436Wn7rq7V
8NP7TpVvswhH1jgkoh2Wed2VaMRP+kVc5yOpL5swpeeX4V8aS9bUAESnUiaRlOIL
nH31FX463410PFiyw5FAloNZk0ocI99t1TkbF/GF9uBZO6wqhrtkVyFKzNeCOel5
J93s1EHfLUFhnNg7NBfXTKjNAYDkWoQnar8OcFy6qroq3Y/+E23uERUMxrFNYPWT
czlmXNQ3NzcGst8Wyi+cBqZpk6mI+S/w9MdtQVvxDAR2t2SWgQtjaFpTbcW37KqN
PObaYtzOYYC2wtbXB0izMfaUcaNLGA==
=3nFj
-----END PGP SIGNATURE-----

--aa5bmvbnmoppupnu--

