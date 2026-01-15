Return-Path: <linux-pwm+bounces-7906-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0257D23A1B
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 10:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E40E230573F6
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052E35CB9E;
	Thu, 15 Jan 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEnl69bU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE382357A3B;
	Thu, 15 Jan 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469787; cv=none; b=YhLdqY8HTLOVg2v4AX4lKGo5Q0WuQLHvWShZJ5IKDBuTiSGWeWtbHpb7wLFEu8He7MB6BeT6mCRRZo79GG75/bwcckJN1kSgJWyt7dYZ5TnRaP75zpj2FG5Yl1fIriyQY47GcKqEi0n9YTBwXj83NeRThcqe5MFFRixkhIM6MvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469787; c=relaxed/simple;
	bh=f72U/wCXjwulYI3pBGU7Hk+ytVTUHLWM8EJRa8rHwBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQk1g3oj2D/6XssKPkvdieYa6iLaeannWOYQOwMd2tZsTpUZzN3Wl1KVf1NmAwg/w2VQL/mU+96LckZjtw7Id1JQECdEwArD22l7vw16tG51APCYFHKYJWcnwkX12XodG1D1AHmJxPkWhGP30Bt74xY4FG7pABbQwt95k+440pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEnl69bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E39C16AAE;
	Thu, 15 Jan 2026 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768469787;
	bh=f72U/wCXjwulYI3pBGU7Hk+ytVTUHLWM8EJRa8rHwBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEnl69bUOneJ/FW0jcRXCFsSALd3zjMODhVcPOR5EyQF7bOibWjSTzSnLDe7F5qcQ
	 /AQFoBE+pv3aNxKTAAedhaOj6PeR+FxJISfOZK6ckkhUII0iTvneBmkIVafE+lMeug
	 IscaR6XwCpHvk75kaJZUaumlwGW6drMD8qfvy1wfaN3887TooFUwvTEetprzUYlhNO
	 wIP+BthV9DZREPLHoJdTAZNSY/tf7JfNDi/41PUhPy/Xs+leAoLufTIlDr2LQH8EZh
	 GCoV+ADrdCCQgmgQXqWdQHQT5V7emomQC6q0wuXmD1v2gr1l5H4UxZGwH/5m90U/Q5
	 lxJ1c5g9WVsFQ==
Date: Thu, 15 Jan 2026 10:36:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 6/9] pwm: tiehrpwm: factor out AQ force codes and
 polarity presets
Message-ID: <sxdlmeurozq4laahoe2aonkw5jzpjxleafg7o7iji3cp6rlfea@6h4w2vcn55lh>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
 <20251128003634.247529-7-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2s2z7wmxi2jlp5ad"
Content-Disposition: inline
In-Reply-To: <20251128003634.247529-7-rafael.v.volkmer@gmail.com>


--2s2z7wmxi2jlp5ad
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 6/9] pwm: tiehrpwm: factor out AQ force codes and
 polarity presets
MIME-Version: 1.0

On Thu, Nov 27, 2025 at 09:36:31PM -0300, Rafael V. Volkmer wrote:
> Introduce named constants for the Action-Qualifier force action codes
> and use them to build the CAU/CAD/CBU/CBD/PRD/ZRO bitfield helpers
> instead of repeating hard-coded numeric values in each field.
>=20
> While at it, split the channel polarity presets into explicit up-count
> and down-count variants for both channels. This keeps the resulting
> AQCTL programming unchanged but makes the configuration easier to read
> and extend.
>=20
> No functional change intended.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 85 +++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 41af1bf74cbb..e8bcf1ffa770 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -52,33 +52,78 @@
>  #define TIEHRPWM_AQSFRC				0x1A
>  #define TIEHRPWM_AQCSFRC			0x1C
> =20
> +/* Action-Qualifier force action codes (per 2-bit field) */
> +#define TIEHRPWM_AQCTL_FRCLOW			0x1
> +#define TIEHRPWM_AQCTL_FRCHIGH			0x2
> +#define TIEHRPWM_AQCTL_FRCTOGGLE		0x3

while renaming the constants, and given that there are to AQCTL
registers (AQCTLA and AQCTLB), I suggest to use AQCTLx as register
identifier.

> +/* Action-Qualifier bitfields for compare/period/zero events */
>  #define TIEHRPWM_AQCTL_CBU_MASK			GENMASK(9, 8)
> -#define TIEHRPWM_AQCTL_CBU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, 1)
> -#define TIEHRPWM_AQCTL_CBU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, =
2)
> -#define TIEHRPWM_AQCTL_CBU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK=
, 3)
> +#define TIEHRPWM_AQCTL_CBU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, \
> +						TIEHRPWM_AQCTL_FRCLOW)

I think it's fine to skip the linebreak here and yield lines >80 char.
If you want to keep the linebreak, please align the continuing line to
the opening (.

> +#define TIEHRPWM_AQCTL_CBU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, \
> +						TIEHRPWM_AQCTL_FRCHIGH)
> +#define TIEHRPWM_AQCTL_CBU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK=
, \
> +						TIEHRPWM_AQCTL_FRCTOGGLE)
> +
> +#define TIEHRPWM_AQCTL_CBD_MASK			GENMASK(11, 10)
> +#define TIEHRPWM_AQCTL_CBD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CBD_MASK, \
> +						TIEHRPWM_AQCTL_FRCLOW)
> +#define TIEHRPWM_AQCTL_CBD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CBD_MASK, \
> +						TIEHRPWM_AQCTL_FRCHIGH)
> +#define TIEHRPWM_AQCTL_CBD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CBD_MASK=
, \
> +						TIEHRPWM_AQCTL_FRCTOGGLE)
> =20
>  #define TIEHRPWM_AQCTL_CAU_MASK			GENMASK(5, 4)
> -#define TIEHRPWM_AQCTL_CAU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, 1)
> -#define TIEHRPWM_AQCTL_CAU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, =
2)
> -#define TIEHRPWM_AQCTL_CAU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK=
, 3)
> +#define TIEHRPWM_AQCTL_CAU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, \
> +						TIEHRPWM_AQCTL_FRCLOW)
> +#define TIEHRPWM_AQCTL_CAU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, \
> +						TIEHRPWM_AQCTL_FRCHIGH)
> +#define TIEHRPWM_AQCTL_CAU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK=
, \
> +						TIEHRPWM_AQCTL_FRCTOGGLE)
> +
> +#define TIEHRPWM_AQCTL_CAD_MASK			GENMASK(7, 6)
> +#define TIEHRPWM_AQCTL_CAD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CAD_MASK, \
> +						TIEHRPWM_AQCTL_FRCLOW)
> +#define TIEHRPWM_AQCTL_CAD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CAD_MASK, \
> +						TIEHRPWM_AQCTL_FRCHIGH)
> +#define TIEHRPWM_AQCTL_CAD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CAD_MASK=
, \
> +						TIEHRPWM_AQCTL_FRCTOGGLE)
> =20
>  #define TIEHRPWM_AQCTL_PRD_MASK			GENMASK(3, 2)
> -#define TIEHRPWM_AQCTL_PRD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, 1)
> -#define TIEHRPWM_AQCTL_PRD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, =
2)
> -#define TIEHRPWM_AQCTL_PRD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK=
, 3)
> +#define TIEHRPWM_AQCTL_PRD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, \
> +						TIEHRPWM_AQCTL_FRCLOW)
> +#define TIEHRPWM_AQCTL_PRD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, \
> +						TIEHRPWM_AQCTL_FRCHIGH)
> +#define TIEHRPWM_AQCTL_PRD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK=
, \
> +						TIEHRPWM_AQCTL_FRCTOGGLE)
> =20
>  #define TIEHRPWM_AQCTL_ZRO_MASK			GENMASK(1, 0)
> -#define TIEHRPWM_AQCTL_ZRO_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, 1)
> -#define TIEHRPWM_AQCTL_ZRO_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, =
2)
> -#define TIEHRPWM_AQCTL_ZRO_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK=
, 3)
> +#define TIEHRPWM_AQCTL_ZRO_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, \
> +						TIEHRPWM_AQCTL_FRCLOW)
> +#define TIEHRPWM_AQCTL_ZRO_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, \
> +						TIEHRPWM_AQCTL_FRCHIGH)
> +#define TIEHRPWM_AQCTL_ZRO_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK=
, \
> +						TIEHRPWM_AQCTL_FRCTOGGLE)
> +
> +/* Action-Qualifier polarity presets for up-count mode */
> +#define TIEHRPWM_AQCTL_CHA_UP_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
> +						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
> +#define TIEHRPWM_AQCTL_CHA_UP_POLINVERSE	(TIEHRPWM_AQCTL_CAU_FRCHIGH | \
> +						TIEHRPWM_AQCTL_ZRO_FRCLOW)
> +#define TIEHRPWM_AQCTL_CHB_UP_POLNORMAL		(TIEHRPWM_AQCTL_CBU_FRCLOW | \
> +						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
> +#define TIEHRPWM_AQCTL_CHB_UP_POLINVERSE	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
> +						TIEHRPWM_AQCTL_ZRO_FRCLOW)
> =20
> -#define TIEHRPWM_AQCTL_CHANA_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
> +/* Action-Qualifier polarity presets for down-count mode */
> +#define TIEHRPWM_AQCTL_CHA_DN_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
>  						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
> -#define TIEHRPWM_AQCTL_CHANA_POLINVERSED	(TIEHRPWM_AQCTL_CAU_FRCHIGH | \
> +#define TIEHRPWM_AQCTL_CHA_DN_POLINVERSE	(TIEHRPWM_AQCTL_CAU_FRCHIGH | \
>  						TIEHRPWM_AQCTL_ZRO_FRCLOW)
> -#define TIEHRPWM_AQCTL_CHANB_POLNORMAL		(TIEHRPWM_AQCTL_CBU_FRCLOW | \
> +#define TIEHRPWM_AQCTL_CHB_DN_POLNORMAL		(TIEHRPWM_AQCTL_CBU_FRCLOW | \
>  						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
> -#define TIEHRPWM_AQCTL_CHANB_POLINVERSED	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
> +#define TIEHRPWM_AQCTL_CHB_DN_POLINVERSE	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
>  						TIEHRPWM_AQCTL_ZRO_FRCLOW)
> =20
>  #define TIEHRPWM_AQSFRC_RLDCSF_MASK		GENMASK(7, 6)
> @@ -262,9 +307,9 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		aqctl_mask =3D TIEHRPWM_AQCTL_CBU_MASK;
> =20
>  		if (polarity =3D=3D PWM_POLARITY_INVERSED)
> -			aqctl_val =3D TIEHRPWM_AQCTL_CHANB_POLINVERSED;
> +			aqctl_val =3D TIEHRPWM_AQCTL_CHB_UP_POLINVERSE;

When I worked on the driver I wondered if these constants are really
helpful or if explicit spelling out would be more readable, i.e.

	aqctl_val =3D TIEHRPWM_AQCTL_CBU_FRCHIGH | TIEHRPWM_AQCTL_ZRO_FRCLOW;

>  		else
> -			aqctl_val =3D TIEHRPWM_AQCTL_CHANB_POLNORMAL;
> +			aqctl_val =3D TIEHRPWM_AQCTL_CHB_UP_POLNORMAL;
> =20
>  		/* if duty_cycle is big, don't toggle on CBU */
>  		if (duty_cycles > period_cycles)
> @@ -278,9 +323,9 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		aqctl_mask =3D TIEHRPWM_AQCTL_CAU_MASK;
> =20
>  		if (polarity =3D=3D PWM_POLARITY_INVERSED)
> -			aqctl_val =3D TIEHRPWM_AQCTL_CHANA_POLINVERSED;
> +			aqctl_val =3D TIEHRPWM_AQCTL_CHA_UP_POLINVERSE;
>  		else
> -			aqctl_val =3D TIEHRPWM_AQCTL_CHANA_POLNORMAL;
> +			aqctl_val =3D TIEHRPWM_AQCTL_CHA_UP_POLNORMAL;
> =20
>  		/* if duty_cycle is big, don't toggle on CAU */
>  		if (duty_cycles > period_cycles)
> --=20
> 2.43.0

Apart from the comments, I think the patch is an improvement.

Best regards
Uwe

--2s2z7wmxi2jlp5ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlotRYACgkQj4D7WH0S
/k4VhwgAtgMa3Bm4730z846YvYBvrLGbdAwyalyV0Yiu6WayEx2ya1nKZf/zvbGv
ATti2yE2MUemaowislUUvPAcitH4WCLY4hMb8eWiRuMviYFP7Kgl028KgobHNqEn
CotYrRSeRyfbBTccvMHPwHk0WcaCFTWy0UWDS9Bmzmks+LjpqzGfZ5PGMV01J0BC
L4x4cwxbJcPEycwg27wQYxbTZ7owMnHv3SzOBP4AqtaUP9xZuWJEh+gTHPzrqlAN
fmsmiVgwuc8KIz2AE9F8hKL0RFGpVWVZq2neWNQG+SrRDiHK0A6Rj4FLgUI3APB/
tbEPvuoVEVOtrIHK0pRzgz1zGmo03g==
=iYSx
-----END PGP SIGNATURE-----

--2s2z7wmxi2jlp5ad--

