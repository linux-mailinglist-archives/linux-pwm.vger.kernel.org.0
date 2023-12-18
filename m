Return-Path: <linux-pwm+bounces-570-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E4816FE9
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Dec 2023 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167BB281B5A
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Dec 2023 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B29740BD;
	Mon, 18 Dec 2023 13:01:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2D74E21
	for <linux-pwm@vger.kernel.org>; Mon, 18 Dec 2023 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFDFe-0000yN-MX; Mon, 18 Dec 2023 14:01:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFDFd-00Ghrj-UA; Mon, 18 Dec 2023 14:01:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFDFd-005IgU-Kh; Mon, 18 Dec 2023 14:01:41 +0100
Date: Mon, 18 Dec 2023 14:01:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, 
	Sean Anderson <sean.anderson@seco.com>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, 
	Michal Simek <michal.simek@amd.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 1/2] clk: Add a devm variant of clk_rate_exclusive_get()
Message-ID: <3fhgutm42b6sy6gdydcvflnsjuc2ozjetjbeyoxjvnl2t5q7za@4og2x6gqz5y2>
References: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
 <744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de>
 <5391068cdc86b6117920d31a524d934b.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rnggtg3wisreb74"
Content-Disposition: inline
In-Reply-To: <5391068cdc86b6117920d31a524d934b.sboyd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--3rnggtg3wisreb74
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc +=3D Maxime]

Hello Stephen,

On Sun, Dec 17, 2023 at 04:17:41PM -0800, Stephen Boyd wrote:
> Quoting Uwe Kleine-K=F6nig (2023-12-12 10:09:42)
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index af2011c2a93b..78249ca2341c 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -937,6 +937,21 @@ void clk_rate_exclusive_get(struct clk *clk)
> >  }
> >  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> > =20
> > +static void devm_clk_rate_exclusive_put(void *data)
> > +{
> > +       struct clk *clk =3D data;
> > +
> > +       clk_rate_exclusive_put(clk);
> > +}
> > +
> > +int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk)
> > +{
> > +       clk_rate_exclusive_get(clk);
>=20
> It seems the other thread wants this to return an error value.

The status quo is that clk_rate_exclusive_get() always returns zero.
Some users do error handling (which is dead code until Maxime reworks
the call that it might return something non-zero), others just call it
without checking.

If you don't require to add something like:

	ret =3D clk_rate_exclusive_get(clk);
	if (ret)
		return ret;

where we currently have just

	clk_rate_exclusive_get(clk);

the patch can just be applied (using git am -3) not even hitting a merge
conflict without that other series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3rnggtg3wisreb74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWAQrQACgkQj4D7WH0S
/k4ciQf/bx+ktF4gQ2yImbs9v+bJkuvbEpmBeKUZ6D0MDv8PrBwZFFKeRrzktdYQ
5eCujDLMVI1s1GQTAnLTNL/049NAdj/XEU0t4tCzEK92guttASVgW1virlGbLq2G
yn44JbmPpmwCZgBfp8IvrqE3OLtflatbuwqpfzr9PNkvz+eXBQ4+FYmzGE3jJXYm
8wT6NM6RyT9f64+bNMZ8+DNX+X0GPa0MRXPa2CpGs4rajnMISvxpTr26MFJ/LEl/
SgLJkEtebx5VUDUP+PijfJZ8rCA5R/OzjqlpDsgJdu6kx+MOSsccqWBAd+o/YhN5
lKhdcO48PpW0eKqlyUAd1uSrZNxE+A==
=A0ib
-----END PGP SIGNATURE-----

--3rnggtg3wisreb74--

