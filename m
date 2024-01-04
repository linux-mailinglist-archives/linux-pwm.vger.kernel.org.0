Return-Path: <linux-pwm+bounces-673-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FE824B99
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jan 2024 00:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5026283CD8
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jan 2024 23:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7132D035;
	Thu,  4 Jan 2024 23:01:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC22CCBC
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jan 2024 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWiF-0006xK-G9; Fri, 05 Jan 2024 00:01:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWiE-000SZB-BW; Fri, 05 Jan 2024 00:01:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLWiE-003elX-0o;
	Fri, 05 Jan 2024 00:01:18 +0100
Date: Fri, 5 Jan 2024 00:01:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-pwm@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>, 
	Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, 
	Maxime Ripard <mripard@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, 
	Michal Simek <michal.simek@amd.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] clk: Add a devm variant of clk_rate_exclusive_get()
Message-ID: <5l6flihq3uqt26f3ewnfu73nmochf6333xlmjrcaah5bihwiv7@742tycpiszno>
References: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
 <744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de>
 <5391068cdc86b6117920d31a524d934b.sboyd@kernel.org>
 <3fhgutm42b6sy6gdydcvflnsjuc2ozjetjbeyoxjvnl2t5q7za@4og2x6gqz5y2>
 <g5ahts576gcub7iwn3xsaky3yu7cqdh3szu67ovixmrrci7zq6@t5fjhj6as5vk>
 <c1effbda6f323aa58935e1990ba3aed8.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ww4jhyvonlgndukx"
Content-Disposition: inline
In-Reply-To: <c1effbda6f323aa58935e1990ba3aed8.sboyd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ww4jhyvonlgndukx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Thu, Jan 04, 2024 at 01:38:27PM -0800, Stephen Boyd wrote:
> Quoting Uwe Kleine-K=C3=B6nig (2024-01-04 10:06:29)
> > On Mon, Dec 18, 2023 at 02:01:41PM +0100, Uwe Kleine-K=EF=BF=BDnig wrot=
e:
> > > If you don't require to add something like:
> > >=20
> > >       ret =3D clk_rate_exclusive_get(clk);
> > >       if (ret)
> > >               return ret;
> > >=20
> > > where we currently have just
> > >=20
> > >       clk_rate_exclusive_get(clk);
> > >=20
> > > the patch can just be applied (using git am -3) not even hitting a me=
rge
> > > conflict without that other series.
> >=20
> > I wonder what you think about this. This devm_clk_rate_exclusive_get()
> > would be very useful and simplify a few more drivers.
> >=20
> > Do you intend to take the patch as is, or should I rework it to check
> > for the zero it returns?
>=20
> Please check the return value even if it is always zero. The discussion
> about handling the return value can continue in parallel.

The discussion in the other thread died, but maybe that's because of the
holidays. Anyhow, I sent a v2 that checks the return value and intend to
rebase and resend my series making clk_rate_exclusive_get() return void
if there is no further contribution by Maxime in a few months.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ww4jhyvonlgndukx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWXOL0ACgkQj4D7WH0S
/k6ppAgAgqY5MVpjJG8UWx2qsWtypJ2JKkiPaY3aSfN8mvFVxX0pOkQP3FKMZFzQ
sDtzkCVoubkRtIOy3AqJh5xOK9sTRvq3SutC4HEpJyRFXfKKKLq9L4+MaUfA1bza
Ozw+EqxMGyQDB93r5jqU1scO0WeWMCBFCXmaG7MCtqrq1Uwq3rvC93EAYB+83KSw
dSP5gpzjjPHom66FuxYJHK16zGPEZKQ0Zi7+I2ZMQj4towGedWOtb+cOD42MWsIJ
7RwZ8HkOWuGNcM6ywLOjHcNY+pkKCPaIyyFHUW++kQ2/ulhO10qcYbLizr6NR23+
WLf5tG2EYPofs3gm2TsGt/yc6JaS/A==
=5oGM
-----END PGP SIGNATURE-----

--ww4jhyvonlgndukx--

