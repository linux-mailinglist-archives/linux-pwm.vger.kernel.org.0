Return-Path: <linux-pwm+bounces-6179-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7859AC8967
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 09:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA847A81A6
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B949213252;
	Fri, 30 May 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtVKjHMv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D32AE6F;
	Fri, 30 May 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591428; cv=none; b=p43wsagDwPzzP/nnzlpHHWcxeDkwvzPbcjIaeRwG25p79C3HF9XUArpbfHtsL6q7h5dHS/XbTl5qwTsB9UNkxg61kPXmJS6dSb8tsYFuZ+45be5Sjfv3K+gpM8tPf6NsRHVyAAnYRfP5W9O8ksI2xZcD/Om7fNGYRKLshlDRgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591428; c=relaxed/simple;
	bh=R/xRZCH14sMPQAqiO3CcAxy1OeVARVf6uPlM2WeOh40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuiHuj4pi89SYR2Geq7F2NWLxAl1B9G5TuiQsXV23R1QV8W+Z15K060kl9PH787XqaQf7nO/KCJsSYzITBEbeDbNd7zJ8mGimbLnXP3bu84vICdksR/L5ZGtN/iJ39FiiCo/Pn4buaSvJZ1SkBDRtAnHeCK7lkg86JRLNxxEFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtVKjHMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBCBC4CEE9;
	Fri, 30 May 2025 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748591428;
	bh=R/xRZCH14sMPQAqiO3CcAxy1OeVARVf6uPlM2WeOh40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtVKjHMvVjeZipMH2I69ghfgUOEMm0PtMSWpQ1BlDghOBjTmu6w5V/KDYw4wKb8fA
	 eMm4pGiksMyCd+Bzxnkbv/TZRxD0NMPQWUDbH9V4ihh3EtbbPRtKJQiziMFSFL9vZO
	 JjMpX7ob2hTwv1htsjnoWhFd9G3GNEWxPpuku9BnCZXP7vZbcWSsdobvKMB4CeFkOy
	 pkZF8hOgXadFTwF1XFfdcS3oTFBXAQ1pjTpiKh+bIgSwj5Mw/tGf3HvEBqv99dm8Af
	 YpJcPU68lNkyt9dqmwhYSP9MVZkz+E5QrbLC0NK6AEftuFamYhZlydWTUyKxCbQdNb
	 V87xroUjne0dg==
Date: Fri, 30 May 2025 09:50:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/3] pwm: sophgo: add driver for SG2044
Message-ID: <azf5lzfkegr6wt3mratxra2mlfah45dc3comtkjbrbdzf4x5xc@tlzxp7oqtcfl>
References: <20250528101139.28702-1-looong.bin@gmail.com>
 <20250528101139.28702-4-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ekb2tmeniacut2mz"
Content-Disposition: inline
In-Reply-To: <20250528101139.28702-4-looong.bin@gmail.com>


--ekb2tmeniacut2mz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/3] pwm: sophgo: add driver for SG2044
MIME-Version: 1.0

Hello,

On Wed, May 28, 2025 at 06:11:38PM +0800, Longbin Li wrote:
> Add PWM controller for SG2044 on base of SG2042.
>=20
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> Tested-by: Chen Wang <unicorn_wang@outlook.com>

Nitpick: Make your S-o-b line the last line. This way you document that
it was you who added the tags for Chen Wang.

> [...]
> +static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +
> +	pwm_sg2044_set_polarity(ddata, pwm, state);
> +
> +	pwm_sg2042_set_dutycycle(chip, pwm, state);
> +
> +	/*
> +	 * re-enable PWMSTART to refresh the register period
> +	 */
> +	 pwm_sg2044_set_outputen(ddata, pwm, false);

I'm astonished that checkpatch doesn't spot the wrong indention here.

> +
> +	if (!state->enabled)
> +		return 0;
> +
> +	pwm_sg2044_set_outputdir(ddata, pwm, true);
> +	pwm_sg2044_set_outputen(ddata, pwm, true);
> +
> +	return 0;
> +}
> +
>  static const struct sg2042_chip_data sg2042_chip_data =3D {
>  	.ops =3D {
>  		.apply =3D pwm_sg2042_apply,
> @@ -142,11 +215,22 @@ static const struct sg2042_chip_data sg2042_chip_da=
ta =3D {
>  	}
>  };
>=20
> +static const struct sg2042_chip_data sg2044_chip_data =3D {
> +	.ops =3D {
> +		.apply =3D pwm_sg2044_apply,
> +		.get_state =3D pwm_sg2042_get_state,
> +	}

Missing , after }.

If you're ok, I'll pick up this version and fixup the two code changes
and the order of the tags in the commit log.

Best regards
Uwe

--ekb2tmeniacut2mz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg5Yz4ACgkQj4D7WH0S
/k6d8gf9EA6hIB2KVuUHwQKu4wMvhPhW35TEI1CVTR9L04YSgFP6CudQ407fy/Aa
IYUnsov4TI+hKOpz0/Tb05+czeAgWU6wBoi2OSBEAB3nszVZ2xQq1PcYd2l/xtHg
ifvgWm9LWghQRH4lwb9VvHyxowfKejMZpVTeysRB6B4mcTKOUt4VFLX6mktCdHFc
pUedFaagWDocC+OuToPxA1f9havIw9hu56PBVJUFmq3RZ9m02QBjRs2PkOTVcMJQ
ydtu4p+MtY+s7qYAsxBqEZlrM/CCrrRFeoBmRF22OhWOOzzNOIqcJZ19BC1uowum
YglxYBkxgm8pY8XGGJkIkAVa3rktDw==
=oO4S
-----END PGP SIGNATURE-----

--ekb2tmeniacut2mz--

