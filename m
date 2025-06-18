Return-Path: <linux-pwm+bounces-6433-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D3ADF4A0
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 19:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB141BC178C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2330205F;
	Wed, 18 Jun 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ1c3u9d"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667D30205B;
	Wed, 18 Jun 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268473; cv=none; b=AG3fkGPjloX2Gg7d1bUwBnyfIyDLhUFguDJKo2QWs/sndQYVc4DEqUj9cWoOQDymbob/r19t92ES3frcY1w6waQ7/qvqXzSB1VW/fhnBfQKlBRdkph1iUQRZ46Csvb9boXMTjSQupSxnqkR4bKgxSIUufhHM4qW/vze6P/QBHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268473; c=relaxed/simple;
	bh=/TiGTBzimC2/z0V6LUdAOK0yy2IS3BJGEJvAFc88JY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdJmpwLcjpT0EZzpmXaVA/OcJLhmwNzF4c6v6oZKbF+aMIfyVPSrHquT4DF6ub3y/WTUsGSbGM+sv6ZI9Q/qUUgTANT0qCYmzaGQbyVuh3Bf7fyLnnFaStOldJRf3MQrhfLSzbK/yn45IYnzvARk5tAr/qLVDMsP5xkOyMV/m8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ1c3u9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C5C4CEF0;
	Wed, 18 Jun 2025 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750268472;
	bh=/TiGTBzimC2/z0V6LUdAOK0yy2IS3BJGEJvAFc88JY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJ1c3u9dQOXpVJq+NPH9vhuId06/6seAUmxRse4KgZ36ISAQBIAyPDgqqEfamaiZf
	 3xLmc++OtQxPyFP17NKZa/1kje8hZWqAvhWHCaqcI2keRpo9a8qwBTvrpLdmxx/2PL
	 FitOhfxx+avNrkSWlfN1cdasl2rwSbk50iHHL1/DyPEZxE1rhXvtn3vZ9YnVjn+USp
	 1I5hInkQbAgpggIiJ3EaBFWgu1xCYNUJEx0hKnWkHo1IfUNu6Lq1RwqJDf7yrM+dXA
	 Z2RKmxXflnZQyd58iUmweF7ctsIeD5w6CvhEwv2VX12C0UtHi6nmAZN4yk+sI/9OWj
	 6O8hGMWYKqkEw==
Date: Wed, 18 Jun 2025 19:41:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v5 03/20] mfd: adp5585: enable oscilator during probe
Message-ID: <juxdbsujseggwelvo4lpcnxbeigmykmzcbibvtnsubdyomjqta@nsttvpbpqvio>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250614-dev-adp5589-fw-v5-3-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="da53m2ldsbxqwerk"
Content-Disposition: inline
In-Reply-To: <20250614-dev-adp5589-fw-v5-3-7e9d84906268@analog.com>


--da53m2ldsbxqwerk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 03/20] mfd: adp5585: enable oscilator during probe
MIME-Version: 1.0

On Sat, Jun 14, 2025 at 03:35:54PM +0100, Nuno S=E1 via B4 Relay wrote:
> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> Make sure to enable the oscillator in the top device. This will allow to
> not control this in the child PWM device as that would not work with
> future support for keyboard matrix where the oscillator needs to be
> always enabled (and so cannot be disabled by disabling PWM).
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>

I assume the idea is to merge the whole series via Lee? If so:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--da53m2ldsbxqwerk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhS+jMACgkQj4D7WH0S
/k6UPwf8Ci9+opGLDMFjlZfll+Gs2QPJYg/HNx9q6katBxSzTJ+QpQeOqgdXTLrd
E43JT+SDSWw3vaiT52vcn416pC6rXHfFRr6yozyIqwwwfkmzZnkC5OLIoGW58Xei
oc1Na++0VYYOhiSTSMKRZRANHPY0ieF0RXpuVv+612gb5LJVBkrNt5rT+dRWIK1y
62/kOlxoTthLKAH/MdI09Nb5LwNFKQB7RO61Bf47E6n8nA8jqqAK5Tt7xPNHxN81
Ao7B945aJ0f4BpJuL7OTE/njnux3DdBawuh2zvb7FwMaSPmHvdTmJh92mpmkgCci
MuuBEOYjc+SQ4SJAYsSfCbhT5qS5lA==
=UIdk
-----END PGP SIGNATURE-----

--da53m2ldsbxqwerk--

