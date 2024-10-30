Return-Path: <linux-pwm+bounces-3980-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19E29B6884
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95DB1C21AFD
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E22141B9;
	Wed, 30 Oct 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II0PQP69"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842502141B5;
	Wed, 30 Oct 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303730; cv=none; b=QRMEUOS+A9MdoeKLfbG9E0TV/Us4eCzQUTJPz/9iYEy+wkADMqB2aItynUALOOAPAJMwvBmSlfz9XyCAXfczyq1JrxlUZVMUgeQdVCNZsOJVyKqZeGPY5WrDBlyQjyyhHcwujTsLczEegytmMuVbI6zXqWMQYlpghIf4Tc/8e9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303730; c=relaxed/simple;
	bh=3yyLl30TQjYKD071Dpap+W12aDnptjFmDQr9KsgJj4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAYXw3vMHugbSbXEJk300/OkuDToPYQv/eQGwvPTKIeyuVRVQVFOAZpu824VAxRi5MXhA2yAqX9LXksqX1BkVMggT2YkpHL+N03nXERqWKPL4RNL8FqF/6K3t9diiaW6gj/rgKT7au+8wocsIfyOgL21kqXf5VqxlWYRw+kczxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II0PQP69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BDEC4CECE;
	Wed, 30 Oct 2024 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730303730;
	bh=3yyLl30TQjYKD071Dpap+W12aDnptjFmDQr9KsgJj4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=II0PQP69uWeP8lH2TXSIqUAQTe8WyNMJpjFfn+2Ctqok/d+umG4MHgWALYdMPIzVY
	 mCKwu5o+4F+M0RaJEHnflVbiau/dHaakOVDDWkC2gejogLJ3G3UFyb65te+GHzG8LP
	 09bMmB/73rZFHV7tiJS9uTCZh7nqqsam6un7bSc2ygu25rAoUPD785aZHTMA/tSYYa
	 FZbCf6ZRYSopkB5ThsQNKWjF+5kmXV1j/+cWRSX3yxE3zU03j/r8TC1+9bdLCBFmsZ
	 zHJWnFjAUtwG+smzYdbgEPbqgk+ujO4X5KRB8q9jZjBSWYo9oEeqdaaLo3J+MhKlJj
	 /9Dh9N2CvzTEQ==
Date: Wed, 30 Oct 2024 15:55:24 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
Message-ID: <e1b4f91a-ac94-4939-90eb-fc10e9a72ee9@sirena.org.uk>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wIB7CppBQdb9BVMQ"
Content-Disposition: inline
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
X-Cookie: I feel partially hydrogenated!


--wIB7CppBQdb9BVMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2024 at 03:59:09PM -0500, David Lechner wrote:

> +struct spi_offload *devm_spi_offload_alloc(struct device *dev,
> +					   size_t num_offloads,
> +					   size_t priv_size)

> +	privs = (void *)(offloads + num_offloads);

Casting to or from void * is generally suspicious.

> +		void *priv = privs + i * priv_size;

Can we have some brackets here for clarity please?

--wIB7CppBQdb9BVMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmciVusACgkQJNaLcl1U
h9Chqgf8DW8de4pnIgIUw/jsiKAtu3L5MxZFUkpBXjxY07ECczmWImt2iWoseFYJ
rILRHF01ca8kZn1PRVsO9CFoP89a+jkwZgvXjYT7A+9jy3yBgGSddeOkrrvgOUBD
1R5JngdpYU4IesCQWUopjqKJw61zFZvwmKboQR38z3Yxnfb88Ea1+XkwE/sCofPp
KB7Z918mA4iyn5L9p8nrA1t8ivRc/KC0zBzH3smen+WzAqsLz5HfIJke5UzbTN6I
zsYQP0gBHr0SDkivg9dKJ3oCcTwGpQ8iZySndgpLOHbBVEUxMTTmKetyOGldmpKF
1MR7dfo/8rpKErN0COB/DbEgmN2RBQ==
=NEXq
-----END PGP SIGNATURE-----

--wIB7CppBQdb9BVMQ--

