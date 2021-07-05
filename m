Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC73BB885
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jul 2021 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhGEIEb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhGEIEa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 04:04:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B4DC061574
        for <linux-pwm@vger.kernel.org>; Mon,  5 Jul 2021 01:01:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0JY4-0000hQ-TF; Mon, 05 Jul 2021 10:01:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0JY1-0000t7-0J; Mon, 05 Jul 2021 10:01:45 +0200
Date:   Mon, 5 Jul 2021 10:01:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zkue7xi2s6vksapu"
Content-Disposition: inline
In-Reply-To: <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zkue7xi2s6vksapu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Fri, Jun 25, 2021 at 07:14:34PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Jun 09, 2021 at 10:21:23PM +0200, Uwe Kleine-K=F6nig wrote:
> > given that I don't succeed in getting any feedback for my patch set, I'm
> > trying with a pull request today. It would be really great if this pull
> > request made it finally in for the next merge window.
>=20
> It seems sending a pull request didn't help either :-\
>=20
> I'm waiting since October for feedback, several people expressed to like
> this series and I want to make use of it to simplify a few drivers. I'm
> quite annoyed that your missing feedback blocks me from further
> improving stuff.

There is still no feedback, not even something like: "I saw your
nagging, sorry. I'm drown in other missions, please have some more
patience."

I assume it's not to much to expect at least such a reply after more
than 8 months?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zkue7xi2s6vksapu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDivGUACgkQwfwUeK3K
7AkjnAf/a6JWigt/E4r2Q+YarOahwo6FeKczLbaLzTCJNlhBmRV/Meyb3zKO0C/f
tejQizaLLLrHlhP/iSjItUpzMJ0PxECM/xWhaAuAq5Bir9J5EjBj1ryFdYB/Styv
Bv4gAmoEbjPAaoOimPt0eZaoe1vXJ+KhtGyYV89a77GZLPOjZvAugKbdxU5TU46i
oLbAQEjgroBM93AMRc/BiakWh6OAnLb1lu69Z3Vc7GbZPeSDoEkZBjqFi3Q+EAA8
UbvamISvheZ8ZHvjuxRxCGv7IQv4ZmBrRiLJePrboNTKGhUMktt4Zc7Ye0rMoNTc
6iDHWYLtjng09CMf01KEsc39jpmN5g==
=A+R2
-----END PGP SIGNATURE-----

--zkue7xi2s6vksapu--
