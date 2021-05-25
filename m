Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43B39082E
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhEYR65 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhEYR65 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 13:58:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB07C061574
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 10:57:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llbIx-0003mR-Pg; Tue, 25 May 2021 19:57:23 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llbIt-0001Ua-L6; Tue, 25 May 2021 19:57:19 +0200
Date:   Tue, 25 May 2021 19:57:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: visconti: Fix and simplify period calculation
Message-ID: <20210525175719.jc2txl4afaquiwu7@pengutronix.de>
References: <20210426150350.2829255-1-u.kleine-koenig@pengutronix.de>
 <YK0mBTy1dC6mi0PG@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36523o3k2baphu4u"
Content-Disposition: inline
In-Reply-To: <YK0mBTy1dC6mi0PG@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--36523o3k2baphu4u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 06:29:57PM +0200, Thierry Reding wrote:
> On Mon, Apr 26, 2021 at 05:03:50PM +0200, Uwe Kleine-K=F6nig wrote:
> > With the original code a request for period =3D 65536000 ns and period =
=3D
> > 32768000 ns yields the same register settings (which results in 32768000
> > ns) because the value for pwmc0 was miscalculated.
> >=20
> > Also simplify using that fls(0) is 0.
> >=20
> > Fixes: 721b595744f1 ("pwm: visconti: Add Toshiba Visconti SoC PWM suppo=
rt")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-visconti.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> Applied, thanks.

I see you applied to your for-next branch. I would have considered to
get this patch in before v5.13 given that the driver was introduced for
5.13-rc1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--36523o3k2baphu4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCtOnwACgkQwfwUeK3K
7Ak8PQf+IuxL4mbI1/KSZe8fAhZtJrzZ4MW4gmf8qrrzSPIQrRAYPh4IWXsBkFMt
2D3lOiBV9xug/yLeqqhgLe5/xe5uOzU88Rcf/v6C54Dg2o8agiGmZCEwxZcNyg/n
0jG2tFOZKLs6W5HJ4qHR9Mt1yAlTqx7lYjV93JkvBA4AFGj3UXjWz28yEbUDhDjD
M06I0lIdoinIUCGWp3VNmCiN9FLdFceLY6yBJsDIoei74I+UzEoq9IZ1GtbAbW6C
RAoi49e5a2HNSWXhZADTPfsHqe8hL3+2wztOoZU/U6FUCd5i1RjYECtX/WrH6mJ8
l2XwzFHnrZqvBRKLqFD7ftGzMg2zMQ==
=1Ooh
-----END PGP SIGNATURE-----

--36523o3k2baphu4u--
