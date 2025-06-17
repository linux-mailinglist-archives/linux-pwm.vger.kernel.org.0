Return-Path: <linux-pwm+bounces-6419-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B293ADD0C1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 16:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC7F167CE2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470C2DE208;
	Tue, 17 Jun 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMLPMk2d"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2872BF014;
	Tue, 17 Jun 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172391; cv=none; b=g15yuTlCQRUVdeDyfQ2fPV+bYPnzL3RDyV2Of0B7uCzfKsB0NAycgXdt0Q+1/skGpyXJha3HJs0S6eFNMQfDAS6FRN73eummaxk2ih1gEH2hYcE95Q+4ex9V0b2U2ln97UwWDCSF+9gnyTMWMF9NR2Gh2EFP1KRMpqNadKSfmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172391; c=relaxed/simple;
	bh=Lp/eB4U1Un6QvP4XOvYyZTYQsbExFyzr5cs6+/LV4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyGQv87nlqsJj2w7pzx8mhYg3HY/Nk0VJG6dBSqtXldSL2S4S6kFRp2sdOO+0idLu79m7pzdy3TXeVXUdjqhs5FAXEa8bJia16LHFKuMrp+fv5JwW67ZCTLY8DJXQK1ctEJ08KCThptNNglFbLKFES2O4UvGvc1gSNxy3+ix5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMLPMk2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C841DC4CEE3;
	Tue, 17 Jun 2025 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750172391;
	bh=Lp/eB4U1Un6QvP4XOvYyZTYQsbExFyzr5cs6+/LV4mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMLPMk2dAOVz7xSLGDg7idYdBgEd7wg426LO52ywB+o8KkiEPfQ/GccDgDPQrOAsG
	 THMr361pcJmPeA3rLLaf0drTP5HTCNxL7u5PPKonuUMhdeLI5Lj4ruLMCtfMjN1LQR
	 tuA+J9L3SMYQFn7/8/tL7IjidlZw4ZpU2pSoI2eS6wK+a3CmWgGeouGrN8LdEYlSiw
	 33vwb3NL1a+niHyr5oN4pNaKbGG+11DUqzSOiZ79netUyWu4uiwrSauevBHjRfUZYz
	 Wv1SO6+jpd2P6Y5+t0voeACGn2v1c1uJ1fybYCelJe5wBWDV/EZdO8BRHWw30wpnwb
	 mN2F9kszPGjtA==
Date: Tue, 17 Jun 2025 16:59:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iio: adc: Add support for ad4052
Message-ID: <yw3n2csu4x4mfed33dtvl75zc5scgkjvkzruqilpw64n7esmdn@3fj77ufzm3c2>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ccnztqp4ebdwmdoc"
Content-Disposition: inline
In-Reply-To: <20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>


--ccnztqp4ebdwmdoc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 4/8] iio: adc: Add support for ad4052
MIME-Version: 1.0

On Tue, Jun 10, 2025 at 09:34:37AM +0200, Jorge Marques wrote:
> +static int ad4052_get_samp_freq(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val,
> +				int *val2)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +
> +	*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, st->pwm_st.period);
> +	return IIO_VAL_INT;

st->pwm_st.period is the period that was requested before. If you want
the real period that is currently emitted, check pwm_get_state_hw().

> +}

Best regards
Uwe

--ccnztqp4ebdwmdoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhRguEACgkQj4D7WH0S
/k5A4wgAlbFUMHh3LtHIRWgkjM61wKadhfZQVlIKuHoXFDWz983UWxN2bZgss2Zd
xMEhoqvneHvAtH7E5MwOFh9/+WMbpfn6Bu4BRTZXUO0dhpS740XkoFb2B3NxX+0K
k5PlODZZffbXuH5v90+7weBrFNuoAuYlLDbQ4SglYkg0NPKaTUroVXxHGF+XnH0l
bvupgHfI2iFM+72ujtJD1Z0mRVn9iT6ZD7XkvXpd8Mddr7Oq2Pm8G80bvRvv1mb9
c/7o5bk6fmhsuXnpZ3SVWfXyrhQpB697/iJyywbdJJnacpu2LB+VKiaSD7WRsWKz
XwdqeSN+ok5I+DT7QANfZPeXZXqANg==
=33LJ
-----END PGP SIGNATURE-----

--ccnztqp4ebdwmdoc--

