Return-Path: <linux-pwm+bounces-7688-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CCC81978
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 17:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B020347300
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081DD25A2BB;
	Mon, 24 Nov 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7BoMFTX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA121A285;
	Mon, 24 Nov 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001945; cv=none; b=mVZEi2HffEyQSlEAEL2l1cok6Gs15I8RNOz80DqrDU6iKBUHdKZ3GzRQt2gA+KPPssva/3u8dFjiOz5qsHQTw6r+Hnm5HgyrEWCp12d1PETsyVCeaOud2Kmc2jK1HI+lEcs6O50bugh8jikE6TqSW5XWB1E+tEeNWS8Y8Nt1PbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001945; c=relaxed/simple;
	bh=voDZieryvn9LANZkkANxItsAwggAb8NAOD35MvQ5m54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6fdtK7alK68Yv2mZn+er60Mb18Ga7qEP3oAMYdzsIY4E3+ab1pFMHPY5hWR4wI1zp8NBQKhsRGneInUn/mW9mGB9QNgq1bdflNVjE1ZXAmVZFJmL5j/vjLusDpPizxQ/ST/nBxTgQdCiUYv4HEnOHKggN/THcTgod/t3OQ9PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7BoMFTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E94C4CEF1;
	Mon, 24 Nov 2025 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001945;
	bh=voDZieryvn9LANZkkANxItsAwggAb8NAOD35MvQ5m54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7BoMFTXCri5txCP5y54mnBNr45Z/MJsIGtyFzcwHotgKIBW7Iturs8MDmGCotYZ3
	 4PsLW76c7ZL0x+QUtctGjNzZr1Rogcp2TJnd9DzYiIvtw+rMh1072vRz/3uWmM6vbN
	 Kvq5Zwa9Yt916C4OrwgenUYgrGtxibDpMB0yyNgNiWPji4Jf8Ud5XUN1O4RlIdY6bm
	 SGPVpIQt4f5q5/P3LFL7yuvMLhDkHC1amVZeX1WlRPiYythlsBFLxmXGrvqovQM6bh
	 nixFHTrwq4I9sfy90F3NkmyGvf/GYGePdsdWGNELobAnLnDZYu0EU2ekXnvimuEIlk
	 EENJZI20ayCKg==
Date: Mon, 24 Nov 2025 17:32:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v5] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Message-ID: <cl3ggzh4sbounylnasm3hp2l2eusloxbv5uw7wxjwc7u47uobw@n24k6buqchu4>
References: <20251121133654.364688-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ys5mvvtwga6hrkb"
Content-Disposition: inline
In-Reply-To: <20251121133654.364688-1-biju.das.jz@bp.renesas.com>


--5ys5mvvtwga6hrkb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
MIME-Version: 1.0

Hello Biju,

On Fri, Nov 21, 2025 at 01:36:51PM +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The rzg2l_gpt_config() test the rzg2l_gpt->period_tick variable. This
> check is not valid, if enabling of a channel happens after disabling all
> the channels as it test against the cached value. Therefore, reinitialize
> the variable rzg2l_gpt->period_tick to 0 in rzg2l_gpt_disable(), when
> all the logical channels of a hardware channel is disabled, and also don't
> allow to set the cached value in rzg2l_gpt_config(), if the other channel
> is not enabled.
>=20
> Cc: stable@kernel.org
> Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v4->v5:
>  * Updated commit description and code comment to give more details on why
>    reinitialising the cached value to zero
>  * Added a check in rzg2l_gpt_config(), to prevent setting the cached val=
ue, if
>    the other channel is not enabled.
> v3->v4:
>  * Split the patch as separate from [1] for easy merging.
>  * Updated commit description
>  * Added comments about the fix in rzg2l_gpt_disable()
> v3:
>  * New patch
>=20
> [1] https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.rene=
sas.com/#t
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 360c8bf3b190..38ad03ded9ce 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -190,8 +190,17 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip =
*rzg2l_gpt,
>  	/* Stop count, Output low on GTIOCx pin when counting stops */
>  	rzg2l_gpt->channel_enable_count[ch]--;
> =20
> -	if (!rzg2l_gpt->channel_enable_count[ch])
> +	if (!rzg2l_gpt->channel_enable_count[ch]) {
>  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> +		/*
> +		 * The rzg2l_gpt_config() test the rzg2l_gpt->period_tick
> +		 * variable. This check is not valid, if enabling of a channel
> +		 * happens after disabling all the channels as it test against
> +		 * the cached value. Therefore, reinitialize the variable
> +		 * rzg2l_gpt->period_tick to 0.
> +		 */
> +		rzg2l_gpt->period_ticks[ch] =3D 0;
> +	}
> =20
>  	/* Disable pin output */
>  	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0=
);
> @@ -271,10 +280,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	 * in use with different settings.
>  	 */
>  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> -		if (period_ticks < rzg2l_gpt->period_ticks[ch])
> -			return -EBUSY;
> -		else
> -			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> +		u8 other_sub_ch =3D sub_ch ? (pwm->hwpwm - 1) : (pwm->hwpwm + 1);

I think this is the same as the simpler

	u8 other_sub_ch =3D pwm->hwpwm ^ 1;

which might not be too magic when put in an inline function next to
rzg2l_gpt_subchannel().

> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, other_sub_ch)) {
> +			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> +				return -EBUSY;
> +			else
> +				period_ticks =3D rzg2l_gpt->period_ticks[ch];

Do you need to set rzg2l_gpt->period_ticks[ch] to zero in the disable
function given that it's only used if the other channel is enabled?

> +		}
>  	}
> =20
>  	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);

Best regards
Uwe

--5ys5mvvtwga6hrkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkkiJQACgkQj4D7WH0S
/k7eCgf+J+hqUFH015giyfs23TgEBTWyBsXCSqxJppChT6Mpk39BZuLAGhWkd5mN
O9Zx/Q6S8OThQcJgz5QUjglWpvUigigAKmRIHdUefYTHJZxPsbwTzaSogRXYEPO3
lCJ0rCtjqlfn/Tgq8Eibu+3tcna1YSA5JguMmFMoSeAydcHRwL5hR446EwpfAreN
usbmFJ/XJcojJCBRTMYao5j9oP1b4udsXy3y+jQ/lMtrC3SG8hYIizuIQRG6Uj51
6Mhk/FEMKT0EAdEpbrCWsr6Zm/N3lUnYhMRUJElVj4m4+Xpc+vvsWmQLd6pueE+l
mIQTK8IPbtK4oSECfiafuySjU+NSzw==
=amZa
-----END PGP SIGNATURE-----

--5ys5mvvtwga6hrkb--

