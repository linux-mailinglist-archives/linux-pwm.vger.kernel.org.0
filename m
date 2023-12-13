Return-Path: <linux-pwm+bounces-553-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C4811055
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 12:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69BB1B20F43
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F864249F0;
	Wed, 13 Dec 2023 11:40:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3EFB0
	for <linux-pwm@vger.kernel.org>; Wed, 13 Dec 2023 03:40:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDNav-0007rJ-Ru; Wed, 13 Dec 2023 12:40:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDNau-00FYhS-MM; Wed, 13 Dec 2023 12:40:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDNau-002GH7-Cq; Wed, 13 Dec 2023 12:40:04 +0100
Date: Wed, 13 Dec 2023 12:40:04 +0100
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
Message-ID: <20231213114004.cuei66hi3jmcpocj@pengutronix.de>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
 <TYCPR01MB11269C233892B6E3002622C3B868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231208140718.laekt3jlsmwvzc7x@pengutronix.de>
 <TYCPR01MB11269900EF62D8CA3E906DBAC868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB1126992DD51F714AEDADF0A4F868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5uzhohpjibqigktr"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1126992DD51F714AEDADF0A4F868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--5uzhohpjibqigktr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 09:06:56AM +0000, Biju Das wrote:
> Hi Uwe,
>=20
> > -----Original Message-----
> > From: Biju Das
> > Sent: Friday, December 8, 2023 2:12 PM
> > Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> >=20
> > Hi Uwe Kleine-K=F6nig,
> >=20
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Sent: Friday, December 8, 2023 2:07 PM
> > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > >
> > > Hello Biju,
> > >
> > > On Fri, Dec 08, 2023 at 10:34:55AM +0000, Biju Das wrote:
> > > > > -----Original Message-----
> > > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > Sent: Thursday, December 7, 2023 9:42 PM
> > > > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > > > >
> > > > > Hello Biju,
> > > > >
> > > > > On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > > > > > ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > > > idempotent (ena=3D1 pol=3D0 5500000000000/43980352512000) -> (e=
na=3D1
> > > > > > pol=3D0
> > > > > > 5500000000000/43980239923200)
> > > > > > 	 High setting##
> > > > > > 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > > > idempotent
> > > > > > (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=
=3D0
> > > > > > 23980465100800/43980239923200)
> > > > >
> > > > > Have you tried to understand that? What is the clk rate when this
> > > happens?
> > > > > You're not suggesting that mul_u64_u64_div_u64 is wrong, are you?
> > > >
> > > > mul_u64_u64_div_u64() works for certain values. But for very high
> > > > values we are losing precision and is giving unexpected values.
> > >
> > > Can you reduce the problem to a bogus result of mul_u64_u64_div_u64()?
> > > I'd be very surprised if the problem was mul_u64_u64_div_u64() and not
> > > how it's used in your pwm driver.
> >=20
> > When I looked last time, it drops precision here[1]. I will recheck aga=
in.
> > On RZ/G2L family devices, the PWM rate is 100MHz.
> >=20
>  [1]
> https://elixir.bootlin.com/linux/v6.7-rc4/source/lib/math/div64.c#L214
>=20
>=20
> Please find the bug details in mul_u64_u64_div_u64() compared to mul_u64_=
u32_div()
>=20
> Theoretical calculation:
>=20
> Period =3D 43980465100800 nsec
> Duty_cycle =3D 23980465100800 nsec
> PWM rate =3D 100MHz
>=20
> period_cycles(tmp) =3D 43980465100800 * (100 * 10 ^ 6) / (10 ^ 9) =3D 439=
8046510080
> prescale =3D ((43980465100800 >> 32) >=3D 256) =3D 5
> period_cycles =3D min (round_up(4398046510080,( 1 << (2 * 5 )), U32_MAX) =
=3D min (4295162607, U32_MAX) =3D U32_MAX =3D 0xFFFFFFFF
> duty_cycles =3D min (2398046510080, ,( 1 << (2 * 5 )), U32_MAX) =3D  min =
(2341842295, U32_MAX) =3D 0x8B95AD77
>=20
>=20
> with mul_u64_u64_div_u64 (ARM64):
> [   54.551612] ##### period_cycles_norm=3D43980465100800
> [   54.305923] ##### period_cycles_tmp=3D4398035251080 ---> This is the b=
ug.

It took me a while to read from your mail that=20

	mul_u64_u64_div_u64(43980465100800, 100000000, 1000000000)

yields 4398035251080 on your machine (which isn't the exact result).

I came to the same conclusion, damn, I thought mul_u64_u64_div_u64() was
exact. I wonder if it's worth to improve that. One fun fact is that
while mul_u64_u64_div_u64(43980465100800, 100000000, 1000000000) yields
4398035251080 (which is off by 11259000), swapping the parameters (and
thus using mul_u64_u64_div_u64(100000000, 43980465100800, 1000000000))
yields 4398046510080 which is the exact result.

So this exact issue can be improved by:

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 55a81782e271..9523c3cd37f7 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -188,6 +188,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 	u64 res =3D 0, div, rem;
 	int shift;
=20
+	if (a > b)
+		return mul_u64_u64_div_u64(b, a, c);
+
 	/* can a * b overflow ? */
 	if (ilog2(a) + ilog2(b) > 62) {
 		/*

but the issue stays in principle. I'll think about that for a while.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5uzhohpjibqigktr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV5mBMACgkQj4D7WH0S
/k5SWwgAlNpH9hagxJJx+RW1bu0KU4KuHqUxRZpodeQVjF1LAmNKjzMPALMdgZOu
CPirhdW2pgCywK0q3ReytWUwRuIn7sKGNDn9YepobkINE72k8gPzdLivqzjuDNzj
591baq3WFWzTVRbYqlEqb6Xuo2TbNZ4Qhv7SysrtMAxDJvkJyqAFg2QBKsVSrx/+
rSlpGERDN9BFfi808BzZ30hmaYqZgCIAX86krQVO/SZjgp6md2fKLmZvJnXmoHCb
KCwNjBbr63c5InRN5egQfBag3LO3PQUMpD+/bcpzGLBK/UJtaRQA4drG9AnViJoN
2jS/mluc8YI+d2/l1e+nRPuH1aBTHQ==
=vF5I
-----END PGP SIGNATURE-----

--5uzhohpjibqigktr--

