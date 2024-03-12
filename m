Return-Path: <linux-pwm+bounces-1747-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4858790F0
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Mar 2024 10:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810CA281C3F
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Mar 2024 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62C77F1F;
	Tue, 12 Mar 2024 09:28:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FC8464
	for <linux-pwm@vger.kernel.org>; Tue, 12 Mar 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235684; cv=none; b=uBaa+89WWKAEMrKojM6VqzI38SDZkJyTtxjxg71YPMb1vf00kh8wCjjWry8I0vtEWRqMyxZ+H35LHyiG6tnqdwBhJGlTApD4BjyS8rQRiU4GjiPzKznhGchZT3K7TW9dzCASgHmNidG2pjwzUVvfGiyeBLdilh8tlW3T++zF2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235684; c=relaxed/simple;
	bh=n3I7Mx/WBXJLEO8LJk9M2tK6z+0w6vWOXn0tBA3uaTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmja4BkqHSpJZ0Ub2Mex2d1DQuZXJN4lg1IUYNqKXj/iEB0Ug7q01J2T6A9brhG8d7sQ5rprasglwgMu4gpcLT46GdPK6l5U6fzoxoDObiB+VGAavToizwjw6tqRYPqdf6xOK4x9ecqa1TZQxCRuTjNrls6gCtaRjsSbQj2MTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjyQK-0002bH-US; Tue, 12 Mar 2024 10:27:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjyQJ-005t5W-Fd; Tue, 12 Mar 2024 10:27:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjyQJ-004fZT-1C;
	Tue, 12 Mar 2024 10:27:51 +0100
Date: Tue, 12 Mar 2024 10:27:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.au@gmail.com>, linux-pwm@vger.kernel.org, 
	kernel@pengutronix.de, Magnus Damm <magnus.damm@gmail.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-renesas-soc@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <fdbdfaaczwiqweoa6lot7rycjnhc3fsvsluwx3c5mwc6ic2dsv@m6foz6somnuz>
References: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
 <20240220194318.672443-4-biju.das.jz@bp.renesas.com>
 <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
 <CAMuHMdV8SnMgawrMspemJNfsAHW-wSboXeEOgZ6F37QqrmiLSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pa5nwvyx2ef2tnjt"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV8SnMgawrMspemJNfsAHW-wSboXeEOgZ6F37QqrmiLSA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--pa5nwvyx2ef2tnjt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Geert,

On Tue, Mar 12, 2024 at 09:11:42AM +0100, Geert Uytterhoeven wrote:
> On Tue, Mar 12, 2024 at 8:20=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Feb 20, 2024 at 07:43:17PM +0000, Biju Das wrote:
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt=
, u32 val, u8 prescale)
> > > +{
> > > +     u64 tmp, d;
> > > +
> > > +     /*
> > > +      * Rate is in MHz and is always integer for peripheral clk
> > > +      * 2^32 * 2^10 (prescalar) * 10^9 > 2^64
> > > +      * 2^32 * 2^10 (prescalar) * 10^6 < 2^64
> > > +      * Multiply val with prescalar first, if the result is less than
> > > +      * 2^34, then multiply by 10^9. Otherwise divide nr and dr by 1=
0^3
> > > +      * so that it will never overflow.
> > > +      */
> > > +
> > > +     tmp =3D (u64)val << (2 * prescale);
> > > +     if (tmp <=3D (1ULL << 34)) {
> >
> > I would have written that as:
> >
> >         if (tmp >> 34 =3D=3D 0)
> >
> > (which implements tmp < (1ULL << 34), which doesn't matter much).
> >
> > > +             tmp *=3D NSEC_PER_SEC;
> > > +             d =3D rzg2l_gpt->rate;
> > > +     } else {
> > > +             tmp *=3D div64_u64(NSEC_PER_SEC, KILO);
> >
> > I don't know if the compiler is clever enough to not calculate that
> > every time?
>=20
> Not on 32-bit when written that way.
>=20
> > Also using div64_u64 is too heavy given that both values fit
> > into an u32.
>=20
> Indeed, so "NSEC_PER_SEC / KILO" should be fine.

ack.

> I guess NSEC_PER_MSEC would be too obfuscating?

or USEC_PER_SEC? Not sure. Also I'm unsure if using KILO instead of 1000
is really an improvement.

If you know that the clkrate is a multiple of 1000 there is no reason to
not use clkrate / 1000 unconditionally. So maybe use
rzg2l_gpt->rate_kHz (and error out in .probe if the rate isn't a
multiple of 1000?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pa5nwvyx2ef2tnjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXwIBYACgkQj4D7WH0S
/k7n/Qf+O2eff5Vj93FymELQFjYTNZWQQqMsgwC+kOgLpklXf2jgmqJze00bKhaJ
6oMBExaPokeiJqwAn5vrUetYAEped3bh2oO+fIlSdvn315/hy6xI0vByoST+kpzB
Hjn2YmC6pOx8Cy6cZ1i5BZGvY+vNw9PLPSmRLIyQbwdUlUciWZRx6OkM1vSrFtW5
+Q3mmBqfvPINfFnU9crdP/lIBMBYUlEjx4UOsq1zZdDwVHBCE1+cnrURDm9Yq62F
xhNw0QnJkUEPeklKoaU/YlB2/UBoG7RCD6/T6Z8j5zZbe6ifpDMhqd8xu/+PhQfY
vJ2JkwSiTjUwW5bRpM69hvtVUNeEWw==
=Cty7
-----END PGP SIGNATURE-----

--pa5nwvyx2ef2tnjt--

