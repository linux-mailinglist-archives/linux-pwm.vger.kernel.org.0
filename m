Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE96F440FD2
	for <lists+linux-pwm@lfdr.de>; Sun, 31 Oct 2021 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJaRnq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 31 Oct 2021 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhJaRnn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 31 Oct 2021 13:43:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A31EC061746
        for <linux-pwm@vger.kernel.org>; Sun, 31 Oct 2021 10:41:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhEpK-0007sQ-7P; Sun, 31 Oct 2021 18:41:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhEpI-0003Yq-4G; Sun, 31 Oct 2021 18:41:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhEpI-0005Po-2b; Sun, 31 Oct 2021 18:41:00 +0100
Date:   Sun, 31 Oct 2021 18:40:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211031174057.rizqg6rw47devq5o@pengutronix.de>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
 <20211031103933.GA28316@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dz53yxaxk2uaah4j"
Content-Disposition: inline
In-Reply-To: <20211031103933.GA28316@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dz53yxaxk2uaah4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 31, 2021 at 10:39:34AM +0000, Sean Young wrote:
> Hi Uwe,
>=20
> On Thu, Oct 28, 2021 at 01:15:35PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 28, 2021 at 10:14:42AM +0100, Sean Young wrote:
> > > We still have the problem that the pwm drivers calculate the period
> > > incorrectly by rounding down (except pwm-bcm2835). So the period is n=
ot
> > > as good as it could be in most cases, but this driver can't do anythi=
ng
> > > about that.
> >=20
> > Yeah, some time ago I started coding a round_state function
> > (wip at
> > https://git.pengutronix.de/cgit/ukl/linux/commit/?h=3Dpwm-wip&id=3Dae34=
8eb6a55d6526f30ef4a49819197d9616391e)
> > but this was pushed down on my todo-list by more important stuff.
> >=20
> > If you want to experiment with that ...
>=20
> I was thinking about this problem this morning.=20
>=20
> - The pwm-ir-tx driver gets a carrier set in Hz, which it has to convert =
to
>   a period (1e9 / carrier). There is loss of accuracy there.

Ack, and the loss is known.

> - When it gets to the pwm driver, the period is converted into the format
>   the pwm hardware expects. For example the pwm-bcm2835 driver converts
>   it into clock cycles (1e9 / 8e8).
>=20
> Both calculations involve loss of accuracy because of integer representat=
ion.
>=20
> Would it make more sense for the pwm interface to use numer/denom rational
> numbers?

This is quite a complication because then all lowlevel driver needs to
do fractal math. I don't want to open that can of worms.

> struct rational {
> 	u64 numer;
> 	u64 denom;
> };
>=20
> If pwm-ir-tx would like to set the carrier, it could it like so:
>=20
> 	struct rational period =3D {
> 		.numer =3D NUSEC_PER_SEC,
> 		.denom =3D carrier,
> 	};
>=20
> 	pwm_set_period(&period);
>=20
> Now pwm-bcm2835 could do it like so:
>=20
> 	int bcm2835_set_period(struct rational *period)
> 	{
> 		struct rational rate =3D {
> 			.numer =3D NUSEC_PER_SEC,
> 			.denum =3D clk_get_rate(clk),
> 		};
>=20
> 		rational_div(&rate, period);
>=20
> 		int step =3D rational_to_u64(&rate);
> 	}
>=20
> Alternatively, since most of the pwm hardware is doing scaling based on t=
he
> clock (I think), would not make more sense for the pwm driver interface to
> take a frequency rather than a period? Then the integer calculations can =
be
> simpler: just divide the clock rate by the required frequency and you have
> the period.

I think the rounding approach is easier and gives you the optimal
setting, too. With a carrier of say 455 KHz you want a period of
1e9 / (455 kHz) =3D 2197.802197802198 ns. Now assuming a pwm clk of 10 MHz
the pwm-bcm2835 driver can offer you 2100 ns and 2200 ns and the
pwm-ir-tx driver can pick the one it prefers. (OK, this works so nicely
because the pwm-bcm2835 driver has a nice clk rate, but also if it were
say 66666000 Hz, it would offer you 2191 ns and 2206 ns and you could
pick your favourite. (In this case there is a rounding error because the
actual periods are 2190.021900219002 ns and 2205.022050220502 ns, but I
would expect that this doesn't influence the choice and to improve here
we probably would have to change the unit of clk_get_rate, too.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dz53yxaxk2uaah4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF+1SYACgkQwfwUeK3K
7AkS4ggAgTu6+YUzCPjg9cyzjbo1cS6UhhdPI7CxPJg6zl6JsQ4rIwzdmO2tEAO7
S+K+LKzZYTChxSrPgPstRCvJPkzHFt9fvmRb5lfZzuigzzx54saIJeETdPJdTmuX
nZWQpLMJF0qBh0UTy2KgVyIlQXWUmyUaiKC/qjiwxbU+UAvLpy7jqHG1vYvtfaOr
jE9qhNUnY3LMjKN9aczA4yoSIelg/xC6jaW/gqfN53ECq81nq5uKOcTJAPz9R3nt
UF2q/G+YMq4iZQ25Ns+Gu2rwfqvLmE8bVvzqCKXxQOF3784KyW6FlCWNbrDRkNG1
pEjfo3j9G6IVRKNAtCnO2WzCtysjmg==
=QDfF
-----END PGP SIGNATURE-----

--dz53yxaxk2uaah4j--
