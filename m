Return-Path: <linux-pwm+bounces-4257-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BAD9E5B5F
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EB5285708
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFD121D5B7;
	Thu,  5 Dec 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuWKYlcJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CEF1401C;
	Thu,  5 Dec 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416011; cv=none; b=k+zYn69NmNp3wXgyW1BqP0D3KWfKyztwy3JT3psgzNwKGMv0ed2NYNHAAxOhP90iPwErSnXCtIzOF/rpTQyS/bksudL7Oj7sSWK8p8bz0CcdJLLOI41lVA8XpkMTP65n/6YM3UI/KnC0bk8yuTSxAxrbQKn5E4iBGr6iCzgadbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416011; c=relaxed/simple;
	bh=2vcNbTelv2caXpZPt58RGIY6oH56uuKfqLkKaHp1kWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up7e26XJLohTYSJbvKxo176WjgyWPGZUo2r2myBogpwYStwl6Hd8XhC8u6u5rBoQpicwey1ux72KGpn4xdYiD2XYtKGdgCDNfQP4O+JUFjAPHPru0O+v+m2PtxAggUjbZ3gkbbjsG4wePQC9yplm9fXeIClZI32lZ3REil2YtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuWKYlcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F0EC4CED1;
	Thu,  5 Dec 2024 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733416011;
	bh=2vcNbTelv2caXpZPt58RGIY6oH56uuKfqLkKaHp1kWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuWKYlcJltFPDCLmuxub0UTVL/Z2t+0fj4hsRYwfPm8jhD/MF+tvhQ7XZVzD6mI9A
	 oYwcYRMgif/Cxiq0/EUOhlTpbj0TVaeVsEFUxBZRHrW/sgGbC+gmWX6arRoeBp7Vjc
	 iGP7zNA4vTxu7TrI9+uK56daTx4RM8gdiVrMq5fEbK97NYW80KhEhDjVZVb/eeNVvl
	 0KBkDSuAn8JRogU4guAgB7wmT95rVq0FCCEoF2/7qzFkvcCMWSUYQI5bUySZsnPLjJ
	 XUCIDy151XtokEnezrCDXeOxMnZ9gvmYAjLkDv6GfkzouD2ahfm0i3O9vxqL4ZTucU
	 hfmJtnR6BLMtg==
Date: Thu, 5 Dec 2024 17:26:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <mgc7ioulqxj6ht5rajpehblpattrojby4e3ashqvhxcrn5fszh@7steb6p27xtc>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com>
 <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
 <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
 <TY3PR01MB11346E660F70645F04F67F67686302@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r3fk7lwkp45kigza"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346E660F70645F04F67F67686302@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--r3fk7lwkp45kigza
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
MIME-Version: 1.0

Hello,

On Thu, Dec 05, 2024 at 09:29:35AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: 05 December 2024 08:28
> > Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
> >=20
> > Hello Biju,
> >=20
> > > According to me, we should not allow updating periods for second enab=
led channel.
> >=20
> > Not entirely sure you mean the right thing here. If IO A operates at 5n=
s and IO B is requested to
> > set .period =3D 5 ms, every operation that also changes A is out-of-bou=
nds. So your options are only:
> > Use the 5ns, or return an error. The latter is hard for consumers becau=
se it's unclear what to do
> > then.
>=20
>=20
> I guess, these 2 IO's mostly used in switching circuits. So, can't we ret=
urn error, if period of IO_A !=3D IO_B?
> Then the user know the mistake and he will configure with proper values??

You can do that. However in general the user (or consumer driver) of IO
A won't know about the connection between the two PWMs and so they only
see their request failing.

> Here IO_B has faster switching(MHz) compared to IO_A (kHZ),
> So, by allowing IO_A to operate at IO_B frequency, we are doing
> Some incorrect operation for IO_A.

"incorrect" is very subjective and depends on the use case. Many drivers
only care about the relative duty cycle. So if they initially want

	.duty_cycle =3D 1ms
	.period =3D 5ms

and then learn that only period =3D 5ns is possible, they are also happy
with

	.duty_cycle =3D 1ns
	.period =3D 5ns

Some other drivers are happy with a given duty cycle and hardly care
about the period, so they only care that .duty_cycle is 3ns and both
=2Eperiod =3D 5ms and .period =3D 5ns is ok.

Or a driver that requests

	.duty_cycle =3D 0ms
	.period =3D 5ms

doesn't care about the period at all if only .duty_cycle is zero.

So the only way to make everybody happy, is to be able to query the
hardware possibilities.

Best regards
Uwe

--r3fk7lwkp45kigza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdR1EYACgkQj4D7WH0S
/k4xLAf+JjyeId/DVenyhNEwBwmuyv3VxLYHXhc213/FIHfN2tikr7d9zHn2pyXt
upj1Z0Tt0NZ56qbUPsAfcldg91N+fMv84ZA97l80I76G5Bq5Z2SSeIlbSzycsp5Z
/WBb0QIfSieZ0aRmdN4ilL/mT8ZC8Y4hGMZxnpxPlZlKdvivBVZh87KIAtATuQMr
LdqZElwHUss3b/o7TLv1VaJU0yG30H6D2N8uxe45szq9JIzMXg5xNessrRYyLPf6
FwA36/kYKCF3S1m1rDMzkh3NDlUmgIwnjir76aPEOdc7Jr2SAvYsiL9XD/4fh9p3
Z2eVPfkOIr8G+HsH03r6rMXsnwtTjg==
=Aja3
-----END PGP SIGNATURE-----

--r3fk7lwkp45kigza--

