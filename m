Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A653D1DFC
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhGVF0l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 01:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhGVF0k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Jul 2021 01:26:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69A2C061757
        for <linux-pwm@vger.kernel.org>; Wed, 21 Jul 2021 23:07:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6RrI-0002e6-Hf; Thu, 22 Jul 2021 08:07:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6RrF-0001Zj-AS; Thu, 22 Jul 2021 08:06:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6RrF-0002kg-8x; Thu, 22 Jul 2021 08:06:57 +0200
Date:   Thu, 22 Jul 2021 08:06:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
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
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <20210722060654.nudpdtemosi64nlb@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2k53gnwa3ltya4v"
Content-Disposition: inline
In-Reply-To: <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--r2k53gnwa3ltya4v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Mon, Jul 05, 2021 at 10:01:44AM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Jun 25, 2021 at 07:14:34PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jun 09, 2021 at 10:21:23PM +0200, Uwe Kleine-K=F6nig wrote:
> > > given that I don't succeed in getting any feedback for my patch set, =
I'm
> > > trying with a pull request today. It would be really great if this pu=
ll
> > > request made it finally in for the next merge window.
> >=20
> > It seems sending a pull request didn't help either :-\
> >=20
> > I'm waiting since October for feedback, several people expressed to like
> > this series and I want to make use of it to simplify a few drivers. I'm
> > quite annoyed that your missing feedback blocks me from further
> > improving stuff.
>=20
> There is still no feedback, not even something like: "I saw your
> nagging, sorry. I'm drown in other missions, please have some more
> patience."
>=20
> I assume it's not to much to expect at least such a reply after more
> than 8 months?

The next merge window is over now. The pull request still merges fine
into v5.14-rc2. I'm still convinced it adds some benefit and I want to
use it to simplify a bunch of drivers. But I cannot without this being
merged.

Do I have to consider creating these functions in the pwm namespace to
continue here? This cannot be the right thing to do?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r2k53gnwa3ltya4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD5CvsACgkQwfwUeK3K
7AmOhAf+KEi6OI5+iu0T3ce0P5fYpVgvH17BQ2OQgNAk+G/pekmQPaYq3wekL2lt
3tSmhkWJ+jaLx3CFlFx5h8eXQXo3Kln2w7UXpi+2RbkLx6tNWrLzlFn1pImvkJZx
smHBjVsy91SbUbyfxsShxn1/p2VRyd/zpnuCw8X0igvBl7k621aAKBhSwB7SgowB
a0vzrD3Rj1NL5/nly7UQyWHbGZ3zXqSjkfbWLiR74Yu0UpiU0XdM3SWMsCPW7Bc2
QGRQyEw2izrhp+YKuqba9EyfHTNjMyd8yRS+6wCKa3ch1VO40uUujegbb9vIez8k
/uxpB1ndq3h7j+TfBHIHLLSe0L1Uvw==
=OlkQ
-----END PGP SIGNATURE-----

--r2k53gnwa3ltya4v--
