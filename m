Return-Path: <linux-pwm+bounces-667-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DAF8247F4
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jan 2024 19:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537D11F22A50
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jan 2024 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7428DB0;
	Thu,  4 Jan 2024 18:06:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4928DB9
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jan 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLS6w-0004Pv-Dj; Thu, 04 Jan 2024 19:06:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLS6v-000PoX-Js; Thu, 04 Jan 2024 19:06:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLS6v-003bpf-1d;
	Thu, 04 Jan 2024 19:06:29 +0100
Date: Thu, 4 Jan 2024 19:06:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-pwm@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>, 
	Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, 
	Maxime Ripard <mripard@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, 
	Michal Simek <michal.simek@amd.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] clk: Add a devm variant of clk_rate_exclusive_get()
Message-ID: <g5ahts576gcub7iwn3xsaky3yu7cqdh3szu67ovixmrrci7zq6@t5fjhj6as5vk>
References: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
 <744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de>
 <5391068cdc86b6117920d31a524d934b.sboyd@kernel.org>
 <3fhgutm42b6sy6gdydcvflnsjuc2ozjetjbeyoxjvnl2t5q7za@4og2x6gqz5y2>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oumpew54f3a4zrvd"
Content-Disposition: inline
In-Reply-To: <3fhgutm42b6sy6gdydcvflnsjuc2ozjetjbeyoxjvnl2t5q7za@4og2x6gqz5y2>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--oumpew54f3a4zrvd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Mon, Dec 18, 2023 at 02:01:41PM +0100, Uwe Kleine-K=F6nig wrote:
> [Cc +=3D Maxime]
>=20
> Hello Stephen,
>=20
> On Sun, Dec 17, 2023 at 04:17:41PM -0800, Stephen Boyd wrote:
> > Quoting Uwe Kleine-K=F6nig (2023-12-12 10:09:42)
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index af2011c2a93b..78249ca2341c 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -937,6 +937,21 @@ void clk_rate_exclusive_get(struct clk *clk)
> > >  }
> > >  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> > > =20
> > > +static void devm_clk_rate_exclusive_put(void *data)
> > > +{
> > > +       struct clk *clk =3D data;
> > > +
> > > +       clk_rate_exclusive_put(clk);
> > > +}
> > > +
> > > +int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk)
> > > +{
> > > +       clk_rate_exclusive_get(clk);
> >=20
> > It seems the other thread wants this to return an error value.
>=20
> The status quo is that clk_rate_exclusive_get() always returns zero.
> Some users do error handling (which is dead code until Maxime reworks
> the call that it might return something non-zero), others just call it
> without checking.
>=20
> If you don't require to add something like:
>=20
> 	ret =3D clk_rate_exclusive_get(clk);
> 	if (ret)
> 		return ret;
>=20
> where we currently have just
>=20
> 	clk_rate_exclusive_get(clk);
>=20
> the patch can just be applied (using git am -3) not even hitting a merge
> conflict without that other series.

I wonder what you think about this. This devm_clk_rate_exclusive_get()
would be very useful and simplify a few more drivers.

Do you intend to take the patch as is, or should I rework it to check
for the zero it returns?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oumpew54f3a4zrvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWW86QACgkQj4D7WH0S
/k4ciAf/eOK87ES4U6MU0G9Rspb+tGWwA3KlgYQlJg9evBvn0dH+yq2O9XwW2bRi
6/ZWoD6G7r1IGrjyE9TX6YBAfDd1YL7HdFa1eHjlFrPfAuze5/rEI9oqp8qhbtWz
Z9TiGfzQf5qVWMadUbIc7tu+99rTaewA7o2hve7M9zERCrcL+Gd+nIVg/RN4BcuH
4PcdqiZaNRTeWz+qQ2XnCTZ0y+5IpUurhXmVKX4dMWYx+XSQrzD8vFpdXzTvLvKR
bnN/CxSP5KpUv/1n4AstYQaSAVz+P+e2H6NjcqhGD4XKToMZnF38kGdzeEGYcLeQ
dvsHcn9hzLDG75UvgEdizik+g4zDZQ==
=IrAZ
-----END PGP SIGNATURE-----

--oumpew54f3a4zrvd--

