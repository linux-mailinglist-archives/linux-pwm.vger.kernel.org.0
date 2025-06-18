Return-Path: <linux-pwm+bounces-6435-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF621ADF53B
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396AF401C36
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A82F94B4;
	Wed, 18 Jun 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9SDhn13"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFE2F5469;
	Wed, 18 Jun 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269316; cv=none; b=new4lKTfSzol/cGUGB7fzxm1lK9nRIplXd//RBoR2y7I41uECNWvQhMfmjDYDjcs2w2oFj2EfDckxTzSMs6mmO7ajxhsRRRHBpfH2yPJk9bfklwBXsUHk3nzes1qMhZcfpopw8lgo2PubkGkmqvjPwGKMshUhUMlMtUcAbAqzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269316; c=relaxed/simple;
	bh=5wT0aIrsAha0PXMViQ6wIobYxSVAr6a7EIn8WbcB6Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t65YbicfJxsmS2al+B+j2+rRIMqHne2N+K72vuBHDjWPIocDhDhaVuG0dZd7d7VpDEu85QqFS1px0b1d6YblbdhHVkXA+1yradD3a8rVo0dLplp0NRb6BBxiAmB7skGTY2bhakw/KQqhXHQH26PLzQfxTRkisg1anqfcH+7SeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9SDhn13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41642C4CEE7;
	Wed, 18 Jun 2025 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750269314;
	bh=5wT0aIrsAha0PXMViQ6wIobYxSVAr6a7EIn8WbcB6Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9SDhn13c0JD2tjlibEUADU/2YTadF28roMpREO+NiAgnQ9xC2FmjSnyGkCpIkQxI
	 aj4ltT+dQVGJhd/slgNsY4huMq/s9VuWI0iCVJkjQaIVhmA43ZlQCdI36eY9jZbxU8
	 S5sB5uipNgGj1dkuWSg4+WmAYz1tyS3SG/0it1nGZH/5ftfmneJKpl1lsL62Bb1zOE
	 gNKYcOZ2R3Z8mF4IUUc7M5aD2cWvO0/XKLyBNtRLkn6NP1Mz8WF5eSnnnhr5KDfYHs
	 Gy4lSXenkcd4etvjBxXJFBz4i16317pfiN0GkhY1/+tumtO9rgewoi9KYYNMVPxAuD
	 f6rREnUPhqvvA==
Date: Wed, 18 Jun 2025 19:55:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iio: adc: Add support for ad4052
Message-ID: <ie44wrnocvisv2ilgds76owbk4u423rr2htpsc5pobykj37zeg@ga5y25gcdjv3>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
 <yw3n2csu4x4mfed33dtvl75zc5scgkjvkzruqilpw64n7esmdn@3fj77ufzm3c2>
 <oqibdd7spdxvlimrwcabqo2xryfplk4q6lnwav5grtl5juud5x@vqfego523x7a>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6n56agevkbvsdqk4"
Content-Disposition: inline
In-Reply-To: <oqibdd7spdxvlimrwcabqo2xryfplk4q6lnwav5grtl5juud5x@vqfego523x7a>


--6n56agevkbvsdqk4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/8] iio: adc: Add support for ad4052
MIME-Version: 1.0

Hello,

On Tue, Jun 17, 2025 at 05:34:56PM +0200, Jorge Marques wrote:
> On Tue, Jun 17, 2025 at 04:59:48PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jun 10, 2025 at 09:34:37AM +0200, Jorge Marques wrote:
> > > +static int ad4052_get_samp_freq(struct iio_dev *indio_dev,
> > > +				struct iio_chan_spec const *chan,
> > > +				int *val,
> > > +				int *val2)
> > > +{
> > > +	struct ad4052_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	*val =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, st->pwm_st.period);
> > > +	return IIO_VAL_INT;
> >=20
> > st->pwm_st.period is the period that was requested before. If you want
> > the real period that is currently emitted, check pwm_get_state_hw().
>=20
> I believe only ad4695.c uses this method and the reason for that is if
> the pwm is disabled we still want to obtain the requested value.
>=20
> Reverting slightly to v2, the semantic to allow fetching from hw when
> enabled, and using the managed state when disabled, would be:
>=20
> 	struct pwm_state pwm_st;
> 	int ret
>=20
> 	ret =3D pwm_get_state_hw(st->cnv_pwm, &pwm_st);
> 	if (ret)
> 		goto out_release;
>=20
> 	if (!pwm_st.enabled)
> 		pwm_st =3D st->pwm_st;
>=20
> 	*val =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, pwm_st.period);
>=20
> Is this ok?

Looks fine to me. I didn't object the original suggested code, just
wanted to highlight the semantics.

I would expect that the compiler optimizes out the unnecessary
assignments done in pwm_st =3D st->pwm_st, as only pwm_st.period is used
later on.

Best regards
Uwe

--6n56agevkbvsdqk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhS/X0ACgkQj4D7WH0S
/k6uOggAutqfRasKnyDG4NPZagUBSr3nqLLjatsZLuA3uLLglPffPSkWn906uKQL
s+GFWFqirMgxqPyT6wi37NJL5Sv0nYvqgN02HBa8uDnSOip3wVtD14B+FI1wC2+A
puYwXaPwG/0eSZOi+XmtqO5M3bwgsnVb3ev8oH1dF1bkJKaDFnh8b73o2mqPZ2cn
hSkHzrRTW0tWN6x9T+wUH2CfnTsgGZe/M5twgwYoLUbbPmmvca0lpOS5bxAbKjo+
735f9Yg65sp7HDsCR8JgVjE/Yr+5No2TkWpIx8JpAMdsbq8lZKEugWPHHs16tu+8
PWQ+2XLnIVDnEBYpBRenpgEMHFZ2+w==
=oKT8
-----END PGP SIGNATURE-----

--6n56agevkbvsdqk4--

