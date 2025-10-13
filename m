Return-Path: <linux-pwm+bounces-7447-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E4BD2372
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 11:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5298B3BC94A
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6D1BDCF;
	Mon, 13 Oct 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fenw9g9w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A482FC01D;
	Mon, 13 Oct 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346738; cv=none; b=fVatV1mZgv6nwSMOZOHYLK2hOgQd4peK9vekaGdtYjDN9pP2CXDd/kyLm2xsU7z2prgoEN7CvkQy4cSqAeqXyFbcGeTKuD4g/8UNXoNutv6qivjNL4mFiIZP0QzdjWn3UVT3xcF8YIR7HvbBhsBSatE6FLz/qIf0HkHbny41MeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346738; c=relaxed/simple;
	bh=Q15JViqHlxPqcwsd5S0ctvupoWQgiXstESpn/mDX0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPFVCL12fhV+SM+jRqHL8ErM7FbyWjoUhkKBZh07BMLToeHYSz0ikPmbzcZ2Os/AzBaR5cuBC1BXAefiRs+e7Z27JyhZ36c0McrPkftBG+647DhhqOCxVWXylD0x0BLtUW4oGsK/uOHlwm/sBiqnt8R+U8LBCfKA1L11A3VTfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fenw9g9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C39FC4CEFE;
	Mon, 13 Oct 2025 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760346738;
	bh=Q15JViqHlxPqcwsd5S0ctvupoWQgiXstESpn/mDX0wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fenw9g9wq/XSVfSzIfcrdq1gzp8s6y/sEVH9JygZhabBtzNEgEP/BXAT0XPQmiJcZ
	 636m3bsXBpBQGryP4LRxBWY/gmN6OGy5+lSRE1+6NuJvxTiXVRj9eoBaQGzeBOEiQh
	 g7yjqECEn6p+IFi0Lv6x+gFRPKZIYgiaBSUgX2gMHW8TfmwpgzOHwtS258Qn4QzAKy
	 AmNLwDXAVpANtb5RdlZtJBO59wa+YiYsPfYVJspXpAJNgDcvq8UQtPHa5qgreLdIdC
	 yFfhj/YPZKC0fdqzh+3lL+OwH4ELF5BVPGObunyG2gu3Z08qUl/gPVWW1zoq7aV4WO
	 BRQkJGQudHhVg==
Date: Mon, 13 Oct 2025 11:12:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, kernel test robot <lkp@intel.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
Message-ID: <zmag5qgkvk2mnkiiyxzdeft6edttolvlmulmtajw4q46setaie@4febizheayqz>
References: <1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
 <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
 <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>
 <aOlYDyLzVGbCh5mE@debian-BULLSEYE-live-builder-AMD64>
 <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qwl2wh5536khtwdf"
Content-Disposition: inline
In-Reply-To: <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>


--qwl2wh5536khtwdf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
MIME-Version: 1.0

On Fri, Oct 10, 2025 at 07:51:09PM +0100, Nuno S=E1 wrote:
> On Fri, 2025-10-10 at 16:01 -0300, Marcelo Schmitt wrote:
> > On 10/10, Nuno S=E1 wrote:
> > > On Thu, 2025-10-09 at 18:53 +0200, Uwe Kleine-K=F6nig wrote:
> > ...
> > > > >=20
> > > > > Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for
> > > > > waveforms")
> > > >=20
> > > > At the time 6c5126c6406d was applied, there was no user of the API =
that
> > > > doesn't depend on CONFIG_PWM, so I object adding this Fixes line.
> >=20
> > Fair. Looks like the stubs are not the preferred solution so probably g=
oing to
> > drop this patch.=20
> >=20
> > > >=20
> > ...
> > > >=20
> > > > 	WARNING: unmet direct dependencies detected for
> > > > SPI_OFFLOAD_TRIGGER_PWM
> > > > 	=A0 Depends on [n]: SPI [=3Dy] && SPI_OFFLOAD [=3Dy] && PWM [=3Dn]
> > > > 	=A0 Selected by [y]:
> > > > 	=A0 - AD4030 [=3Dy] && IIO [=3Dy] && SPI [=3Dy] && GPIOLIB [=3Dy]
> > > >=20
> > > > This is the thing that needs fixing, i.e. don't select a symbol with
> > > > dependencies that the selecting symbol doesn't assert to be fulfill=
ed.
> > > >=20
> > >=20
> > > Agreed. Seems to be one of those cases where we select a symbol that =
depends on
> > > something.
> > >=20
> > > However, this driver can indeed work without spi offload and hence PW=
M and
> > > SPI_OFFLOAD (AFAIR) are optional so I wonder what's the right approac=
h. Looking
> > > at the new series I already see:
> > >=20
> > > select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> > >=20
> > > Which makes more sense but I guess we still need the stubs with the a=
bove. But=20
> > > I would also expect stubs to be needed for spi/offload/consumer.h. Ma=
ybe I'm
> > > missing something though...
> >=20
> > I have successfully tested it with imply SPI_OFFLOAD_TRIGGER_PWM in Kco=
nfig and
> > MODULE_IMPORT_NS("SPI_OFFLOAD") in the ADC driver.
> > Both the PWM offload trigger and ADC driver were built as modules.
> > I'm not sure the import ns is needed, but ended up breaking the remote =
test
> > setup so will only be able to tell it next week.
> >=20
> > >=20
> > > I did not tested but I also wonder if 'imply SPI_OFFLOAD_TRIGGER_PWM'=
 is not
> > > similar to the above.
> >=20
> > It works, and I'll update the IIO patch to have
> > 	select SPI_OFFLOAD
> > 	imply PWM
> > 	imply SPI_OFFLOAD_TRIGGER_PWM
> > in Kconfig. The PWM imply is because I think SPI offload support meets =
the=20
> > "highly desirable feature" criterion mentioned by kbuild doc [1].
>=20
> With imply we then need to take care either using stubs (which seems not =
to be an
> option) or with preprocessor conditions in your driver. As discussed in t=
he other

Note that if there is a better reason than broken dependencies, I'm not
a fan of those stubs, but would accept them.

What I don't like about the similar discussion to make GPIOs optional
is: If a hardware might or might not have a reset line connected to a
GPIO, the driver typically does:

	gpiod =3D gpiod_get_optional(...);
	if (IS_ERR(gpiod))
		return PTR_ERR(gpiod);

=2E With gpiod_get_optional() being a stub without GPIO support enabled,
you get a working driver if the hardware doesn't have a GPIO. If however
the hardware has a GPIO, IMHO the driver should fail to bind. But
instead it continues to operate and probably fails at some point down
the road, in the worst case with a floating reset pin only working on
Tuesdays or when the fridge door is closed.

So the misconception is: gpiod_get_optional() means: "Give me a GPIO if
the hardware has one *and* GPIO support is enabled". However most driver
authors expect the semantic to be "Give me a GPIO if the hardware has
one." I want to prevent that for PWM.

Best regards
Uwe

--qwl2wh5536khtwdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjswmwACgkQj4D7WH0S
/k5Y+wgAr64aAtqkO05P9RvkOS2ZEP5xK50WYptiBjwW6FSHJq9spzwbKxGSwwKv
jm3vOz3JaF9vrsvI4NOBVsuWdMZ5QssB2n2uSuFCupu8LnfhHmsP33/M8vrTQXXW
lHQ3wuCQRe9zVTSsua2D4uusIqu9MQAfmgvvKksy2QyItNu2+W7u6Sq9NKRvSAcH
N9yue+1mf6WeZ+MnhORze/NpOzv1bthmJvsiWjEzDeYMtRuiTZYBC2Sf9EnE9iwu
RFwFtsQPTndIL7AsRkXJ1NX3YpBYn6+2w2s7JZxprvNk6nOJ+xAC+x6tyG563rN2
NnR51+Ei8FS5Uou5Yl2Qzp6S1knQqA==
=5mZe
-----END PGP SIGNATURE-----

--qwl2wh5536khtwdf--

