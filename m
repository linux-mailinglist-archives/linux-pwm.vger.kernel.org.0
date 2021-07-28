Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA23D96B0
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jul 2021 22:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhG1U0P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Jul 2021 16:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhG1U0P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Jul 2021 16:26:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8DC061757
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jul 2021 13:26:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8q7j-0001DY-CD; Wed, 28 Jul 2021 22:25:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8q7f-00016c-Jz; Wed, 28 Jul 2021 22:25:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8q7f-00018J-IS; Wed, 28 Jul 2021 22:25:47 +0200
Date:   Wed, 28 Jul 2021 22:25:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Claudiu.Beznea@microchip.com
Cc:     Arnd Bergmann <arnd@arndb.de>, andy.shevchenko@gmail.com,
        alexandre.belloni@bootlin.com, Nicolas.Ferre@microchip.com,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        o.rempel@pengutronix.de, Ludovic.Desroches@microchip.com,
        aardelean@deviqon.com, linux-pwm@vger.kernel.org,
        broonie@kernel.org, Jonathan.Cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        wsa@kernel.org, kernel@pengutronix.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210728202547.7uvfwflpruku7yps@pengutronix.de>
References: <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qq7fthau66l5qry"
Content-Disposition: inline
In-Reply-To: <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6qq7fthau66l5qry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I adapted the Subject in the hope to catch Stephen's and Michael's
attention. My impression is that this thread isn't on their radar yet,
but the topic here seems important enough to get a matching Subject.

On Mon, Jul 26, 2021 at 09:18:16AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> > On Fri, Jul 23, 2021 at 11:26:58AM +0300, Andy Shevchenko wrote:
> >> On Thursday, July 22, 2021, Wolfram Sang <wsa@kernel.org> wrote:
> >>>>>> [ some frustration for not getting feedback for clk patches ]
> >>>>> What about adding gkh to the list explaining the situation to him?
> >>>> Greg doesn't like devm_ stuff.
> >>>>
> >>>> I already asked Arnd who doesn't want to interfere and akpm who didn=
't
> >>>> react either up to now.
> >>> Wow, okay, that is frustrating.
> >> The situation simply shows the process gap and One Maintainer nowadays=
 is
> >> far from enough to satisfy demands.
> >=20
> > Technically there are two maintainers for drivers/clk, Michael Turquette
> > and Stephen Boyd. It seems Michael is MIA and Stephen doesn't have the
> > capacity to address all requests.
> >=20
> >> What I think about is that we need to escalate this to Linus and
> >> others and elaborate the mechanisms how to squeeze a new (additional)
> >> maintainer when the original one is not responsive. Let=E2=80=99s say =
some
> >> procedural steps. Otherwise we doomed because of human factor.
> >=20
> > Assuming there was some process for this, is there someone who is
> > willing to take responsibility here?
>=20
> In the last year I worked on AT91 clock drivers and I would be available
> for taking responsibility beyond AT91 clocks (if everyone's OK with this),
> in whatever form the current maintainers and people in the audience would
> agree, if any (co-maintainer or other forms that could be useful). The id=
ea
> is to help things progress as I also have patches waiting for feedback on
> clock mailing list for almost 6 months.
>=20
> Let me know if I can be helpful.

Wondering about how we can progress here I think it's crucial that
Stephen and/or Michael share their thoughts about how they intend to
care for drivers/clk in the future.

Do you want to keep the maintainer post long-term? Or only for a
transitional period until someone else can take care? Is your
non-presence only temporal and is it foreseeable that you will increase
your efforts in the next weeks/months again? Do you welcome a
co-maintainer? What kind of involvement would you consider helpful?

Thanks to Claudiu for offering to support here, at least from my side
this is very appreciated.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6qq7fthau66l5qry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEBvToACgkQwfwUeK3K
7Aksbwf/YlXrflASuxAw9ZMxMY43DC3nIKdf2RTKOgtNNEFOXGHJAhFzxIb9D6Iu
yUJ9O3vjSnS2L56hUNq4WzAFg/QFj29vCHYwMlI3S0rKJAbPik+NbdakEvgjgGSH
G5jhi2RKJDosXRHy2djyjqINHgjPViVka7qVoa2+hJnOLrfGmUjSzWTbWBE69Zs+
Zm0HSIg9VXbOpxcqxy55PNTkn5hzQ03rvHR6VeqnB15Pab9AHSKDta5yfReZPWoP
/WHoVwCGU6JmlKbTAqCePaDG0Y0HfUQjhg6aQj1Z823tT9LcNP8khCE2tbhM0ii7
5y0J8EYhxmhak5kFGiuNPYvYGgfTsw==
=SgSy
-----END PGP SIGNATURE-----

--6qq7fthau66l5qry--
