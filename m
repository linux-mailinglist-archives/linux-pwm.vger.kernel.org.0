Return-Path: <linux-pwm+bounces-458-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A380A521
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 15:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990561C208F1
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8121DDCE;
	Fri,  8 Dec 2023 14:07:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A1A9
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 06:07:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBbVi-000175-M3; Fri, 08 Dec 2023 15:07:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBbVh-00ERFa-8B; Fri, 08 Dec 2023 15:07:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBbVg-00GRjV-V5; Fri, 08 Dec 2023 15:07:20 +0100
Date: Fri, 8 Dec 2023 15:07:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <20231208140718.laekt3jlsmwvzc7x@pengutronix.de>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
 <TYCPR01MB11269C233892B6E3002622C3B868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhsyx3inpf2mpw5i"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11269C233892B6E3002622C3B868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--jhsyx3inpf2mpw5i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Fri, Dec 08, 2023 at 10:34:55AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Thursday, December 7, 2023 9:42 PM
> > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> >=20
> > Hello Biju,
> >=20
> > On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > > ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > idempotent (ena=3D1 pol=3D0 5500000000000/43980352512000) -> (ena=3D1=
 pol=3D0
> > > 5500000000000/43980239923200)
> > > 	 High setting##
> > > 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent
> > > (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=3D0
> > > 23980465100800/43980239923200)
> >=20
> > Have you tried to understand that? What is the clk rate when this happe=
ns?
> > You're not suggesting that mul_u64_u64_div_u64 is wrong, are you?
>=20
> mul_u64_u64_div_u64() works for certain values. But for very high
> values we are losing precision and is giving unexpected values.

Can you reduce the problem to a bogus result of mul_u64_u64_div_u64()?
I'd be very surprised if the problem was mul_u64_u64_div_u64() and not
how it's used in your pwm driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jhsyx3inpf2mpw5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVzIxUACgkQj4D7WH0S
/k6LOAgAkA1YylIJiSk1W36fsxyVnqPGFhkGKlsr5YBi8otsbLLjE6xD8j1inFHY
YmwrYUODZE/+qT2pom9EP4nE8ttlCrd8Rc0JMazp33i8gDLb9puR/vb+EZ65TdiK
1FMjvodKdYzvifv8Hp2wTm3J/IaxOJAF9xOlQ0oF8RTlMzJj2btffhK9zwLE7+Mq
/fVpp6XK1Lchb6uEIt9KW01BHaNRl44sjiWtsQdK60FpoqW6LDr4z/k4jQINQ0jd
Z/KDu8YuXqRoreV33bUsAauQCdjr9Ju7Lp3O7MYYtXIKr4X+MSeCGNctYMtIUco8
Nb5WdhtBVlsaDQoyNJCcJRg8Ob+FJA==
=HkLo
-----END PGP SIGNATURE-----

--jhsyx3inpf2mpw5i--

