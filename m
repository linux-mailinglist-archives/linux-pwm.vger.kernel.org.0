Return-Path: <linux-pwm+bounces-3984-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBFF9B8265
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2024 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D46F1C20EE0
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2024 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B11C8FC0;
	Thu, 31 Oct 2024 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoWxXegU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07B1BD501;
	Thu, 31 Oct 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398576; cv=none; b=QLxR3YE2C+DVV/YRps68yWcpRsP4Uh/TZsAjWgrn0jjFgnQr3/60bUiaoyR64Wwjq4bWJZnjsfsRuZ0EIoluYQTO56NGmel3TWY4EUKVcUqwBXfgq9XDRJ6Gb5ds7d75FPaXDh0OnAZUKDFkyav4i4FQsD4I6Z2cpZqbYtVtcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398576; c=relaxed/simple;
	bh=a0XxDbtJwqAkMvK39cpkd2F8PdsdCUxiE0cP0WUw1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufXx/FycyUDnMDBy2du0iptFGm6bRAtPQmIYUugAwZ62Zlt9iykk/cqjQGc3VQOLGDlKATL0f7XG2QW0rvsu3rbICfU039rOnWarVsv7hGeu3SrunmWIUHChBKqfg+uqQCDN0GqqSLooz+hsqCKLDMtrmzqU50yCTqhqLLudJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoWxXegU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DC0C4CEC3;
	Thu, 31 Oct 2024 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730398575;
	bh=a0XxDbtJwqAkMvK39cpkd2F8PdsdCUxiE0cP0WUw1vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoWxXegU1p/t/x19dGfnMq/kDCEoZeI9+y0FMrYykBQOyJIc9q/ohxuRbJYxhkylK
	 YagvMlX50thLX3ltS0k6ualhU7oWE50jZ4G/ea/tlT/xyzW8Loxa47A0rRz7OTMwEd
	 a9sFbDnTTU4FpQitrOsQQ6hr1Zka3loLzTLacGmKY3/J65vw/fG0prF4zxEOMxTiAM
	 G0kSLdi1EiD/b/TN1+4znIJwOEYm1De2UOIRTyhk+6SbAS+8hti0pXrftJFF6XwOgc
	 LW3Q8iZzCgJtbW/JxTrgr+weCC6b43XZwjG15xrN/Sx576n0cAmcZTNlz71DvVJqFx
	 20cxF+emjs4fA==
Date: Thu, 31 Oct 2024 18:16:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH RFC v4 05/15] spi: dt-bindings: add PWM SPI offload
 trigger
Message-ID: <20241031-croon-boss-3b30ff9e9333@spud>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-5-f8125b99f5a1@baylibre.com>
 <20241026161837.30a56ae1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uFDjMC94MKRrYJ2w"
Content-Disposition: inline
In-Reply-To: <20241026161837.30a56ae1@jic23-huawei>


--uFDjMC94MKRrYJ2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 04:18:37PM +0100, Jonathan Cameron wrote:
> On Wed, 23 Oct 2024 15:59:12 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > Add a new binding for using a PWM signal as a trigger for SPI offloads.
>=20
> I don't have a better suggestion for this, but it does smell rather like
> other bridge binding (iio-hwmon for example) where we have had push back =
on
> representing something that doesn't really exist but is just a way to
> tie two bits of hardware together. Those kind of exist because we snuck
> them in a long time back when no one was paying attention.

I dunno. iio-hwmon to me is a particularly strange one, because it is
the exact same device being used in different subsystems. Like that
voltage monitoring device with 10000 compatibles that I CCed you and
Peter on the other day feels like it should really in your subsytem. A
"hwmon" isn't a class of device at all.

This however, I think is more like pwm-clock (or clk-pwm, they both
exist and are opposites) where the node is used to change the type of
device rather than the subsystem using it.

> So this one may need more explanation and justification and I'd definitely
> like some DT maintainer review on this at a fairly early stage!

Ye, /shrug. Maybe the others have dissenting opinions. I'd like to hear
=66rom them, but I don't personally have a problem with this.

--uFDjMC94MKRrYJ2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyPJagAKCRB4tDGHoIJi
0typAQCEmnsI5mzHHvq89+khhenHZThZa1J9UsxH41LEsVWFPAD/WefyfVnQD3JS
OyCiDnA+Y6CorQ7SLLilyBtOMN4XGgc=
=UiW6
-----END PGP SIGNATURE-----

--uFDjMC94MKRrYJ2w--

