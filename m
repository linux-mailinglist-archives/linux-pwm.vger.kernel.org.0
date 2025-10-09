Return-Path: <linux-pwm+bounces-7427-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E1BCA40F
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 18:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9FE4E5AEE
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF90226CF9;
	Thu,  9 Oct 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evtRoave"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755102253B0;
	Thu,  9 Oct 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028824; cv=none; b=lKB3nSlT5CrGWkw+uwSnuw2joyffjIioj2xSdc5op3BAWbWg0mJ7yF9V2U+wt16dC+geCaDYLf+q42ZcMsvJZqIa0B2SOMt6g2FqmHo6X+HJ/dXH5f4IB2COJPkR4KCF9ab7oQRESI1tAIGsnyEtmUeX1b/dTOpD8z4oG90KzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028824; c=relaxed/simple;
	bh=epjvvnuppmyRenwVzfDD+OEyJF5NAOaMIRlvp0bTwIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABuNU9JJmC+UiQ6Z1hCRC0SpzLunfYnCZoM9O00ZMsEb/eJcrXn3AaGglJsG7ZrsbGarLb0kIVzdmRrwVSFyGTEUTmKzEO4qjPTkR0GGNdYukGhIqaVz+EiIfyZ60N2qJQEjqNs9/dzZXCVzCyDp3ytDyfQ8TDaUzcrE9cFZOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evtRoave; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EED2C4CEE7;
	Thu,  9 Oct 2025 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760028824;
	bh=epjvvnuppmyRenwVzfDD+OEyJF5NAOaMIRlvp0bTwIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evtRoaveR542GD74OlaK0XZHSdKVsx9HnKDhcLetjfRAs2zCLjEuAd9BMCh2wLdYr
	 I+4ufzeyF1KZnjq8O0lpiK+elr5CE1yiK1bojaQSLDI9sC50BJGSzeK6OMXXnxtW/6
	 kFvfbB+pFi5ILdbxPdufT9IGTV2AxzeOc+bcIr/Cn1FOW7yFuBc6j8WuY0snJWU6+2
	 sCT1Ne6sk/0aN+hHFSn5H5CQiBqSRN41+X38iHfPHzVxmX7QRorN/FOD1dMHVeYf+T
	 pAXuXNSQMEPQK4cj2RSHUgx7CMG/a567qNrVSBbJ6yoN6dAKgu/AO6QwTIUBRiNqy9
	 pILdlKH6J9JoQ==
Date: Thu, 9 Oct 2025 18:53:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, marcelo.schmitt1@gmail.com, kernel test robot <lkp@intel.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
Message-ID: <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
References: <1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtpjpznqgwf67kka"
Content-Disposition: inline
In-Reply-To: <1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>


--gtpjpznqgwf67kka
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
MIME-Version: 1.0

Hello Marcelo,

On Tue, Oct 07, 2025 at 07:19:38PM -0300, Marcelo Schmitt wrote:
> Previously, the PWM waveform consumer API would not be declared if
> CONFIG_PWM was not reachable. That caused kernel builds to fail if a
> consumer driver was enabled but PWM disabled. Add stubs for PWM waveform
> functions so client drivers that use, but don't depend on PWM, can build =
if
> PWM is disabled.
>=20
> Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for wavefor=
ms")

At the time 6c5126c6406d was applied, there was no user of the API that
doesn't depend on CONFIG_PWM, so I object adding this Fixes line.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lkp@i=
ntel.com/
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Cc: Jonathan Cameron <jic23@kernel.org>
> Hi Uwe,
>=20
> This is a fix based on a report from 0-day bot [1].
> We need this for a sophisticated IIO device that makes direct use of a PWM
> waveform (in addition to indirect use of PWM through SPI_OFFLOAD_TRIGGER_=
PWM).=20

Does the driver work in some configuration with the pwm stubs? If not,
the right thing to do is to let it depend on PWM. (Note the inverse
isn't necessarily a good idea.)

And I wonder how you could even compile your driver without PWM support
given that it selects SPI_OFFLOAD_TRIGGER_PWM which depends on PWM.

=2E.. some time later ...

OK, I tried to reproduce the problem that the kernel build bot run into.
There is a warning:

	WARNING: unmet direct dependencies detected for SPI_OFFLOAD_TRIGGER_PWM
	  Depends on [n]: SPI [=3Dy] && SPI_OFFLOAD [=3Dy] && PWM [=3Dn]
	  Selected by [y]:
	  - AD4030 [=3Dy] && IIO [=3Dy] && SPI [=3Dy] && GPIOLIB [=3Dy]

This is the thing that needs fixing, i.e. don't select a symbol with
dependencies that the selecting symbol doesn't assert to be fulfilled.

Best regards
Uwe

--gtpjpznqgwf67kka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjn6JMACgkQj4D7WH0S
/k4UwAf/Xi58Gz3voetCP7AG978T24RE1BOCkdT8fyDxUQmlCkdCaw9awK0nQaqY
nnvr28hOA03CwH7JsxTBj5GrJ7HLofBmE1/FQHIT25qg68x8M3nIm0rlFkocw0na
XmApu0OfRURM8Nmlg4LZLelrYzAAHuXWkZ8+3IiubpZ0siMP2FGG5eOZWTE+qf1E
wIMc2OcYAhW3GLyB9wicKcyg6aVWs8A5mktw5TRJJ6he1HTxC35oZwRHILnpy/Qn
Q7DR/BCPJE8EkFjglVszUg6arresnHvlujg8p5U9O7Ogm7Gr8OFY229ghW3p8pF4
nH8HzqJv4vXa3AGqJTU8Mcj87zVM0g==
=33nq
-----END PGP SIGNATURE-----

--gtpjpznqgwf67kka--

