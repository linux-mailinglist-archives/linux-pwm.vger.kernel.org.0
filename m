Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0544468D0
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Nov 2021 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhKETVw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Nov 2021 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhKETVw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Nov 2021 15:21:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F466C061714
        for <linux-pwm@vger.kernel.org>; Fri,  5 Nov 2021 12:19:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mj4k1-0005ZY-7K; Fri, 05 Nov 2021 20:19:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mj4k0-0007jL-AI; Fri, 05 Nov 2021 20:19:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mj4k0-0004oa-9N; Fri, 05 Nov 2021 20:19:08 +0100
Date:   Fri, 5 Nov 2021 20:19:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/3] pwm: Some improvements for legacy drivers
Message-ID: <20211105191905.i2ixhea2tmr5u7tg@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6rt6v444hs4xihyp"
Content-Disposition: inline
In-Reply-To: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6rt6v444hs4xihyp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Jul 01, 2021 at 09:29:24AM +0200, Uwe Kleine-K=F6nig wrote:
> this is the successor of my earlier patch "pwm: Ensure for legacy
> drivers that pwm->state stays consistent" that was applied shortly to
> next until Geert found a problem with it.
>=20
> I split the patch in three parts now: First the legacy handling is just
> moved to a separate function without any semantic change. Then a glitch
> is fixed, but without the regression I introduced initially. In the
> third and last patch the longstanding FIXME about breaking pwm->state if
> a callback fails is addressed.

I noticed you collected patches for the current merge window, but among
others skipped this series.

You mentioned two doubts, but never reacted on my replies that (IMHO)
should remove your doubts.

Can you please voice your concerns?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6rt6v444hs4xihyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGFg6YACgkQwfwUeK3K
7AknDQf/Y1Gm75Z3T35YqecWPHCsq3qphXutrBvCr4kdxCTbYp63EfPNAbnuuQiW
NMj9aj8jnvTeON0vR/I4pZy6PIbbpgtco0Uc7cCgoyIlo1PXdtPyE1Q9bD1pNmUv
ipzHqw9oq4fdmtcx5ThRxpvQxzhHSq89/Qs7R4gqX/b+921Cn8NAmwPk2srZxILr
Ep/XDW7dpWAXYJTuObP4kDu58rDoBwoZ5aht3Qw/Pk4LBlTzmKXz1MK/gnb0u0MA
hZMex5dmqFGvdlXUUQkwNkFAtdYO5p5LkI5siqwtJJ+bhsR9tPq/xsYT7f3Y7Msj
StImWd031XaHRXsXLfIVOav/EL4Gsg==
=Ej4w
-----END PGP SIGNATURE-----

--6rt6v444hs4xihyp--
