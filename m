Return-Path: <linux-pwm+bounces-5021-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B600EA49D33
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 16:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890837AA7E2
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33B26FA7D;
	Fri, 28 Feb 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVcCufY4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06ED26BDA4;
	Fri, 28 Feb 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755891; cv=none; b=pAZKxGdtIf184O2ACE2DVDPGEF5XGjs1bUcssIVejnouYkiP9+vkDTgRluS0RFvlhiXPA778amKdmj+JggbPJb7MzADpEQF+7zx2s2uLf9Zkb30SUa3LdLYAr8uP3W6lgXTWojnPDYoIqY1yVa72a6gbkN0glNZ6xcibCs1eHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755891; c=relaxed/simple;
	bh=jkPRvgo3NpRaDEp4k1hzJV3HaS+fwgbJw+P6jRyMFGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujsnWj2SCT0uOCnjMNDPVDISut5hYjrD3IYITpyiRttm8BFzOF3HZDw4vfsV8FLzi+MmgrWtqN/i7cK+sq3m4HuyPr5OPAiVZus8J/1SAFRVQMulxrcabtZ+ihnspjukjXCsAOGCNOyEP81voPeNOgzECiclbFcM2kT4zR6G7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVcCufY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB84C4CED6;
	Fri, 28 Feb 2025 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755889;
	bh=jkPRvgo3NpRaDEp4k1hzJV3HaS+fwgbJw+P6jRyMFGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVcCufY4G1TsQxgU92YFTwrHcLywjpyb41J0DfYNxaBJvrYArIte5gY7HV6saTZ8r
	 xHXPcmui7GLTuGkjmyxX6xAf/4pBTVbk4Uk7cLC/NBZYXho1I5tlYJmBVATfDGSwT4
	 pEp1GrtGxb/KhnT6XcsQirXIBsrLDlMU+vztD7x5L5/0EZfuye5yBpmUUq+AxWIl6X
	 H95hdzTfzsvnWd6yYFXRV9z+HADw8FuUES9TjCeBz/YptSgodpY4g+g3JEU2CcF6dZ
	 NqA+yJL0n9Z+aeBFZW4Uxhd6l78d7TEFJmlBx1V5LI75eLay/f+J2EdoAGrnHIUKeT
	 tVsdxI8QExtew==
Date: Fri, 28 Feb 2025 16:18:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: David Jander <david@protonic.nl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-pwm@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
Message-ID: <tm57fsmijq4t4y4dpmtss63ekzpm5oefir5tz4aioxq5dx4or6@lgoqjpxc3axh>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-8-david@protonic.nl>
 <20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
 <20250228102201.590b4be6@erd003.prtnl>
 <9a1d75a2-66c0-46b6-91a1-4922b892dfb1@kernel.org>
 <20250228110931.7bdae7fd@erd003.prtnl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rfp3v5bmp743c3to"
Content-Disposition: inline
In-Reply-To: <20250228110931.7bdae7fd@erd003.prtnl>


--rfp3v5bmp743c3to
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
MIME-Version: 1.0

Hey David,

On Fri, Feb 28, 2025 at 11:09:31AM +0100, David Jander wrote:
> On Fri, 28 Feb 2025 10:37:48 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On 28/02/2025 10:22, David Jander wrote:
> > >  =20
> > >>> +
> > >>> +  motion,pwm-inverted:
> > >>> +    $ref: /schemas/types.yaml#/definitions/flag   =20
> > >>
> > >> And PWM flag does not work? =20
> > >=20
> > > I have seen PWM controllers that don't seem to support the
> > > PWM_POLARITY_INVERTED flag and those where it just doesn't work. Shou=
ld all =20
> >=20
> >=20
> > Shouldn't the controllers be fixed? Or let's rephrase the question: why
> > only this PWM consumer needs this property and none of others need it?
>=20
> CCing Uwe Kleine-Koenig and linux-pwm mailing list.
>=20
> I know that at least in kernel 6.11 the pwm-stm32.c PWM driver doesn't
> properly invert the PWM signal when specifying PWM_POLARITY_INVERTED. I a=
gree
> this is a probably bug that needs fixing if still present in 6.14-rc. Bes=
ides
> that, if linux-pwm agrees that every single PWM driver _must_ properly su=
pport
> this flag, I will drop this consumer flag an start fixing broken PWM driv=
ers
> that I encounter. I agree that it makes more sense this way, but I wanted=
 to
> be sure.

Some hardwares cannot support PWM_POLARITY_INVERTED. Affected drivers
include:

	pwm-adp5585
	pwm-ntxec
	pwm-raspberrypi-poe
	pwm-rz-mtu3 (software limitation only)
	pwm-sunplus
	pwm-twl-led (not completely sure, that one is strange)

=2E ISTR that there is a driver that does only support inverted polarity,
but I don't find it. For an overview I recommend reading through the
output of:

	for f in drivers/pwm/pwm-*; do
		echo $f;
		sed -rn '/Limitations:/,/\*\/?$/p' $f;
		echo;
	done | less

=2E (Note not all drivers have commentary in the right format to unveil
their limitations.)

For most use-cases you can just do

	.duty_cycle =3D .period - .duty_cycle

instead of inverting polarity, but there is no abstraction in the PWM
bindings for that and also no helpers in the PWM framework. The problem
is more or less ignored, so if you have a device with

	pwms =3D <&pwm0 0 PWM_POLARITY_INVERTED>;

and the PWM chip in question doesn't support that, the pwm API functions
will fail. So the system designer better makes sure that the PWM
hardware can cope with the needed polarity.

Best regards
Uwe

--rfp3v5bmp743c3to
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfB06AACgkQj4D7WH0S
/k4NKQgAgDC2JJ02fk1A7PHXuaUhWRukm6F8XGZLDrQDFRYtxz8yV4pdryg+dQ/+
4eexB6lXvkYCA7d2N13Ij/iRe6ou5gf6lXWC0Pf7sCkrcPTZgNOy3DGCaubOrkT6
c+/cCzVSrr3xhp1dDEC4sO20USUbjCurHkuhwVO6eUuDKc6rpm43GTs8lWiAbBPh
2MiCcOP3FyEotRl6mvegvaeKuj4qzjAZkpk+aNBU6sxfuCbkHbO50GXqUQIR/LSS
GPs3+oAGm30doTOYJJKXlotrv9Dg3nDIqcXugpiEDlPPOHR2l2URUQ6zQFAi6FIY
AFNoAAbpnoQQV2PW3ew4qf8UIZRXVg==
=ELQV
-----END PGP SIGNATURE-----

--rfp3v5bmp743c3to--

