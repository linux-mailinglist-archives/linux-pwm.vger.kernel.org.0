Return-Path: <linux-pwm+bounces-441-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F918094D4
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 22:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400B3B20A3C
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F7840C3;
	Thu,  7 Dec 2023 21:42:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EFD199B
	for <linux-pwm@vger.kernel.org>; Thu,  7 Dec 2023 13:42:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBM8A-00016p-9Y; Thu, 07 Dec 2023 22:42:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBM87-00EHBk-UV; Thu, 07 Dec 2023 22:41:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBM87-00GEFH-Kz; Thu, 07 Dec 2023 22:41:59 +0100
Date: Thu, 7 Dec 2023 22:41:59 +0100
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
Message-ID: <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ekhwc4sfyeifnj5w"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ekhwc4sfyeifnj5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Wednesday, December 6, 2023 6:38 PM
> > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > On Mon, Nov 20, 2023 at 11:33:06AM +0000, Biju Das wrote:
> > > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
> > > +u32 val, u8 prescale) {
> > > +	u64 retval;
> > > +	u64 tmp;
> > > +
> > > +	tmp =3D NSEC_PER_SEC * (u64)val;
> > > +	/*
> > > +	 * To avoid losing precision for smaller period/duty cycle values
> > > +	 * ((2^32 * 10^9 << 2) < 2^64), do not process the rounded values.
> > > +	 */
> > > +	if (prescale < 2)
> > > +		retval =3D DIV64_U64_ROUND_UP(tmp << (2 * prescale), rzg2l_gpt-
> > >rate);
> > > +	else
> > > +		retval =3D DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate) << (2 *
> > > +prescale);
> >=20
> > Maybe introduce a mul_u64_u64_div64_roundup (similar to
> > mul_u64_u64_div64) to also be exact for prescale >=3D 2?
>=20
> mul_u64_u64_div_u64()has a bug already and we are losing precision with v=
ery high values.
> See the output with CONFIG_PWM_DEBUG enabled[1]. So we cannot reuse mul_u=
64_u64_div64()
> for roundup operation.
>=20
> Maybe we need to come with 128bit operations for mul_u64_u64_div64_roundu=
p().
> Do you have any specific algorithm in mind for doing mul_u64_u64_div64_ro=
undup()?
>=20
> Fabrizio already developed an algorithm for 128 bit operation, I could re=
use once it
> hits the mainline.
>=20
> [1]
> ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent=
 (ena=3D1 pol=3D0 5500000000000/43980352512000) -> (ena=3D1 pol=3D0 5500000=
000000/43980239923200)
> 	 High setting##
> 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent (ena=
=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=3D0 23980465100=
800/43980239923200)

Have you tried to understand that? What is the clk rate when this
happens? You're not suggesting that mul_u64_u64_div_u64 is wrong, are
you?

> > With prescale <=3D 5 and rzg2l_gpt->rate >=3D 1024 this shouldn't work =
just
> > fine.

I meant here "this should work just fine", I guess you understood that
right.

> Practically this is not possible. Yes, from theoretical point, rate=3D1kH=
z=20
> compared to the practical case, 100MHz won't work.
>=20
> For the practical case, the current logic is fine. If we need to achieve
> theoretical example like you mentioned then we need to have=20
> mul_u64_u64_div64_roundup().

That shouldn't be so hard to implement.

> > > +	rzg2l_gpt->max_val =3D mul_u64_u64_div_u64(U32_MAX, NSEC_PER_SEC,
> > > +						 rzg2l_gpt->rate) * RZG2L_MAX_SCALE_FACTOR;
> >=20
> > Is it clear that this won't overflow?

U32_MAX * NSEC_PER_SEC doesn't even overflow an u64, so using a plain
u64 division would be more efficient.

You'd get a smaller rounding error with:

	rzg2l_gpt->max_val =3D mul_u64_u64_div_u64((u64)U32_MAX * NSEC_PER_SEC, RZ=
G2L_MAX_SCALE_FACTOR, rzg2l_gpt->rate);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ekhwc4sfyeifnj5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVyPCYACgkQj4D7WH0S
/k5SEAf9FJQJGPRf6pVXHNRm7nyoiMjxWH7+X8Of6LjANoPBeK20X/3ttyA31dUI
Q6OsRib0QxS9zH2khyPy1Fxigxc1QOmSBbUfXzlqdcIl2LkgntOkTKK3TIHBc1zd
WfWwx+tv0h9XJ/m7DS1Puv9ihmUOSchAy6/lpM/JgM2ga4GSTQT4UDVWvC/tg3GY
OQIDdF2C6/CPHHdzqHCLyjpPZoRr93SKBA9JjI7SO9foYk+rnryj7x5Ewh4DqVDC
ftXVeKm63LpkxdcnbDstFgP0wa+rrw7vpdf6rYzSzoqXAl2JiPf3DT0XKRJTxp6j
Fcw1bYcxs+iqDBQqf/Nuf0XimMMCxw==
=sEx9
-----END PGP SIGNATURE-----

--ekhwc4sfyeifnj5w--

