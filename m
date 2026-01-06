Return-Path: <linux-pwm+bounces-7854-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD4CF7F34
	for <lists+linux-pwm@lfdr.de>; Tue, 06 Jan 2026 12:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39EE03048BA7
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jan 2026 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24541328B49;
	Tue,  6 Jan 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcz3AnU2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F8309F19;
	Tue,  6 Jan 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694981; cv=none; b=Zn8wjN2XhgL953TgIodWDeEqlUPsOEhspl2dcCdL5rFaVyQbuwhRS/du6ZrCsOkG1MGcBewlin1a8HaYAX+nbp5q/zarMP05PVplWx7hm2Rt3Z87lpEnioz+xHeF49/iDrwqATn9aKHqKZdo7COoY/wMBxSXng8M4BdtAzAis8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694981; c=relaxed/simple;
	bh=coo59hx6eOu0vGs3Mvf5pYDqS+tTCWWQ6cQTmjAtPpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6C/2X8PHQzwCVkfWeeYlwkji/Iuz4YSRGAWq6eKHgXEbFF4Uqlpxqm7Az3N4EiG8dLRvqHVwaJjxHn7hv3TEbXHMilcKQQe6Qs3PmaBuaHmVQ0Aosq4kuUy/6VKPuWkfm+BZjSKOP6Ug6gMfjk6VgAu/o210QqR1wh6xHMe1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcz3AnU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB1BC116C6;
	Tue,  6 Jan 2026 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767694980;
	bh=coo59hx6eOu0vGs3Mvf5pYDqS+tTCWWQ6cQTmjAtPpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mcz3AnU23rCd7g3gAAoHuH2oXu847Aljn2Lu4uQGu+fOUwY98XYRy56C4NQ2xr/6H
	 n3fDnSqJiEiZTRkdxhwqdYAz7+f70bW/89W3L6qv6lHSXbZ/jSXNbb8zzzdGDhX8mg
	 d+hwEDGyB4Psr9wOQEs3oB0le+O72YKBXNM75qXJrXXaTnZRkgoC7dlmZTSNFuJTo4
	 FR7DSFp7QCbJSZEF2w83sGjnfzva4fij8UUB/Ds/Tx8PsEwbCl02XICAcwFwHB6tAa
	 9h2RV1+kXH6cDZtyAy07bcKSF6827rsrcl0Bp1RybJHH+TBtyItACp4/+Cd7uYIkXE
	 tOzIc1SD/c60w==
Date: Tue, 6 Jan 2026 11:22:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Message-ID: <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3>
References: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adci6bclvlmizahh"
Content-Disposition: inline
In-Reply-To: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com>


--adci6bclvlmizahh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
MIME-Version: 1.0

Hello Sean,

On Tue, Jan 06, 2026 at 08:01:57AM +0100, Sean Nyekjaer wrote:
> After commit 7346e7a058a2 ("pwm: stm32: Always do lazy disabling"),
> polarity changes are ignored. Updates to the TIMx_CCER CCxP bits are
> ignored by the hardware when the master output is enabled via the
> TIMx_BDTR MOE bit.
>=20
> Handle polarity changes by temporarily disabling the PWM when required,
> in line with apply() implementations used by other PWM drivers.
>=20
> Fixes: 7346e7a058a2 ("pwm: stm32: Always do lazy disabling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> This patch is only applicable for stable tree's <=3D 6.12
> How to explicitly state that and what is the procedure?

I haven't checked in detail yet but I wonder if the problem also exists
in newer kernels. Also I think that changing the polarity with the
hardware on happend before 7346e7a058a2; in that case you blamed the
wrong commit.

So even if we decide to apply a small targetted fix for the issue you
report to stable without an equivalent commit in mainline (due to the
rework the driver saw in v6.13-rc1~157^2~9^2~3 ("pwm: stm32:
Implementation of the waveform callbacks")), I refuse to do that if the
problem still exists in mainline.

> ---
>  drivers/pwm/pwm-stm32.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index eb24054f9729734da21eb96f2e37af03339e3440..d5f79e87a0653e1710d46e6bf=
9268a59638943fe 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -452,15 +452,23 @@ static int stm32_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> =20
>  	enabled =3D pwm->state.enabled;
> =20
> +	if (state->polarity !=3D pwm->state.polarity) {
> +		if (enabled) {
> +			stm32_pwm_disable(priv, pwm->hwpwm);
> +			enabled =3D false;
> +		}
> +
> +		ret =3D stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (!state->enabled) {
>  		if (enabled)
>  			stm32_pwm_disable(priv, pwm->hwpwm);
>  		return 0;
>  	}
> =20
> -	if (state->polarity !=3D pwm->state.polarity)
> -		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
> -
>  	ret =3D stm32_pwm_config(priv, pwm->hwpwm,
>  			       state->duty_cycle, state->period);
>  	if (ret)

I would prefer the following change:

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index eb24054f9729..5f118c20f1ca 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -452,12 +452,16 @@ static int stm32_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
=20
 	enabled =3D pwm->state.enabled;
=20
-	if (!state->enabled) {
+	/* The hardware must be disabled to honor polarity changes. */
+	if (!state->enabled || state->polarity !=3D pwm->state.polarity) {
 		if (enabled)
 			stm32_pwm_disable(priv, pwm->hwpwm);
-		return 0;
+		enabled =3D false;
 	}
=20
+	if (!state->enabled)
+		return 0;
+
 	if (state->polarity !=3D pwm->state.polarity)
 		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
=20
Maybe it's just me, but I think the resulting code is simpler with this
hunk.

I have hardware using this driver, will set it up later this week for
testing.

Best regards
Uwe

--adci6bclvlmizahh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlc4n4ACgkQj4D7WH0S
/k4PPQgAmawyHAcyv863JANknfAFeEAdQkQ06D1C/9LZyoVJJ7f5ozR8gwqQ+WDj
MyfVx+Te/oM2rj8Hz94OPihbcEo2aM0VVmWPgcthdcHGBGGPf907/Emts0L9TZi9
vWQIGys5Mc8DSJWB71krKZSngEEIup8AVQqoUxQIkLRTai7wPr5dH4P/BSe/eXRi
OgD+EV4ToZQUQl2VnaHakcqKTiDsE5C1KFFCnKwKhHT0YfdYb89BbjT6U9uKL/kc
BezmtEMe3rKH33czeKLwnKX0WXXCxY7zbHNgsA/Ukr5ZvrrUmlp/3Z+2n9xnnIGe
qEl/4av0tDgRaS2c+bcGCpfoYo8BJA==
=dPiB
-----END PGP SIGNATURE-----

--adci6bclvlmizahh--

