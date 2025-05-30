Return-Path: <linux-pwm+bounces-6180-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6565AC8B41
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 11:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC8A4E5AF5
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC263220F4B;
	Fri, 30 May 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inxk4Yp8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27021D5BE;
	Fri, 30 May 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597912; cv=none; b=tVWu17GHlKlmpDj7En4aEekW76bYWAN6pooFhDE2ZvDoil94KSsUYPhw+e1KQ9wM9NACHylMJ82eFctnz4gX7AVecSeVvgY8mAe22mCGnKrUS2kcfwyNOuwOe2qPBXnRRKSrAkiUBV+AQ1MVaUpYLGXtQ8ukwLM/kBbEOpQFejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597912; c=relaxed/simple;
	bh=ICSGQ0Zax6RfiU1eNFI15hxlnpkjaqK5BGkuN+umx5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRsH+xDKixXLZ0tlL7p36OM/vsDJUfB7StBh36e/qOgamJPeYOeFFT7JFOm9GeS/XuHOWOQZhmjaIihaeVSlo+HVpv9DsgkCl4Uowzw1BAoB8ngbItmQjE4hKwmG2zzRrl++KyEWFbWYEXZj7zo/sZhfWsldz1LUklwSBxOiNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inxk4Yp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C537CC4CEE9;
	Fri, 30 May 2025 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748597912;
	bh=ICSGQ0Zax6RfiU1eNFI15hxlnpkjaqK5BGkuN+umx5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inxk4Yp8xtNFcmPalhY09ck1qo1uYRCOcIWDRzIjZrLR7sPqhhXwCHPFDqMHLJd9g
	 sHZFVXK6FD1UizbfB6DLmzqePp11GrU+bAvzTM2yyDUq4QFT+Mmn1w1ZCzuMd3Z++r
	 2rfN38whXYJrJfbDDPu65/kN4bHjMqPADKnsMQtO+wyQwtLzyKI5dwaU3yVgl+CY6c
	 mwSjpaGlZA383yCa/07eaFq5rD2szRfYhwQl84F4vK2iGD8hYyW2MfktL8fRWru7Gh
	 0Cd2BNMrPJjHKZ+QZivVRi85ri4A4dqVmlF2ll/8UBkqvHhrhjueT0WLFbZE49Ec2S
	 It9sSic/aD+Tg==
Date: Fri, 30 May 2025 11:38:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, 
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <dirkbdd5oeofjhy5pk6jiaixbuhmuq7axewhrd7bdghc3dp5x6@ok2uhywwz5ls>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
 <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
 <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>
 <jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl>
 <4858ce06-2081-4335-af09-f118872317ea@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iwycug4hm3mtqr5n"
Content-Disposition: inline
In-Reply-To: <4858ce06-2081-4335-af09-f118872317ea@alliedtelesis.co.nz>


--iwycug4hm3mtqr5n
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
MIME-Version: 1.0

Hello Chris,

On Wed, May 28, 2025 at 09:18:37PM +0000, Chris Packham wrote:
> On 28/05/2025 18:10, Uwe Kleine-K=F6nig wrote:
> > If I understand correctly you need the default value for duty to
> > statically setup (or only initialize?) a fan, right?
>=20
> Correct.
>=20
> > I'm not sure I like
> > extending #pwm-cells for a default duty value. Thinking about that a
> > while I'd prefer a binding that looks more like the clock configuration
> > stuff because actually having the period and flags as part of the
> > reference to the PWM to be used is also a bit strange. So I imagine
> > something like:
> >
> > 	mypwm: pwm {
> > 		compatible =3D "...."
> > 		#pwm-cells =3D <1>;
> > 	};
> >
> > 	fan {
> > 		compatible =3D "pwm-fan";
> > 		pwms =3D <&mypwm 1>;
> > 		assigned-pwms =3D <&mypwm>;
> > 		assigned-pwm-default-period-lengths-ns =3D <40000>;
> > 		assigned-pwm-default-flags =3D <PWM_POLARITY_INVERTED>;
> > 	};
> >
> > Then specifying a period (or later a duty cycle length) would be
> > optional and could be provided iff the device needs that for operation.
>=20
> The frequency and flags were already part of the standard #pwm-cells=20
> which I think is why I was encouraged to use them.

Yeah, that part is fine. This might not be the long-term future, but
today that's the norm.

> I was also trying to get something that would work as an ACPI overlay
> which turned out to be really hard.

I don't know enough about ACPI to be helpful with this quest.

> > My mail was just me being frustrated about another special case that I'd
> > have to handle if I go into that direction. I should have been more
> > attentive to that development before it entered the mainline.
>=20
> I'd be happy to deprecate the 4 cell thing and replace it with 3 cell +=
=20
> vendor property for the default period if that helps.

I wonder how other similar devices determine the default duty cycle.
Isn't the norm to make the fan rotate at max speed and then when
userspace takes over it's speeded down?

Best regards
Uwe

--iwycug4hm3mtqr5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg5fJIACgkQj4D7WH0S
/k7Q/QgAhpRbbtxTmdd1TU+JKciJM1ubiQ6suwb+RqEXC/4zfLvLc7QwkWAm16v3
MMCqJxvwSwXVWPxPoaaFEU9k4S9YHi5ggLfT4/1Bde79ynsdCFHbL6zfaH3Fq3gH
m15Q2/Z9yPQ2z3tWe0b2PskubMtRGXpzWsEk3M2SwTb09J421hWW8qFxV//OqMf+
PM8qkChq3fe9ZZgkHzNepPYfmJEl6uhs1mEN7FinZi6ZHqxRSF2L92celgIcmYWK
6VqNq8381esfPA9OeA2oLFEuz2sQv5DtDE2PVsSea8iGggRFrYbGMC/oYTBLwjBp
1WTJLq7hrYJSTtyNu1HKGvIDfj+Gew==
=y7cT
-----END PGP SIGNATURE-----

--iwycug4hm3mtqr5n--

