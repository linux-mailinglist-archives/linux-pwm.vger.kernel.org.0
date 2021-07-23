Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103063D376E
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jul 2021 11:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGWIdc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jul 2021 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhGWIdb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jul 2021 04:33:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B78CC061575
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jul 2021 02:14:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6rFP-0006Ca-H4; Fri, 23 Jul 2021 11:13:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6rFL-00042o-FB; Fri, 23 Jul 2021 11:13:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6rFL-0007WN-DB; Fri, 23 Jul 2021 11:13:31 +0200
Date:   Fri, 23 Jul 2021 11:13:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7dh7scaylhwikjek"
Content-Disposition: inline
In-Reply-To: <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7dh7scaylhwikjek
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[adding Linus and lkml to Cc: and adding some more context]=20

On Wed, Jun 09, 2021 at 10:21:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> given that I don't succeed in getting any feedback for my patch set, I'm
> trying with a pull request today.

This is for a series that is currently in v7 and didn't get any feedback
at all yet. The history is:

v1: 2020-10-13, https://lore.kernel.org/linux-clk/20201013082132.661993-1-u=
=2Ekleine-koenig@pengutronix.de
    no feedback at all

v2: 2021-03-01, https://lore.kernel.org/linux-clk/20210301110821.1445756-1-=
uwe@kleine-koenig.org
    kernel test robot identified some issues

v3: 2021-03-01, https://lore.kernel.org/linux-clk/20210301135053.1462168-1-=
u.kleine-koenig@pengutronix.de
    I added a few driver patches to show the benefit. (However in a way
    that the autobuilders don't understand, so there were some false
    positive build failure reports.)

v4: 2021-03-30, https://lore.kernel.org/linux-clk/20210330181755.204339-1-u=
=2Ekleine-koenig@pengutronix.de
    Got some feedback for the converted drivers by the respective
    maintainers. Some were indifferent, some found it good

v5: 2021-04-22, https://lore.kernel.org/linux-clk/20210422065726.1646742-1-=
u.kleine-koenig@pengutronix.de
    Fixed a problem in one of the driver changes (i2c-imx), no feedback
    apart from pointing out a few typos, silence from the clk
    maintainers

v6: 2021-04-26, https://lore.kernel.org/linux-clk/20210426141730.2826832-1-=
u.kleine-koenig@pengutronix.de
    Just the typos fixed, no feedback

v6 resend: 2021-05-10, https://lore.kernel.org/linux-clk/20210510061724.940=
447-1-u.kleine-koenig@pengutronix.de
    no changes in code. Got some feedback from Jonathan Cameron

v7: 2021-05-10, https://lore.kernel.org/linux-clk/20210510174142.986250-1-u=
=2Ekleine-koenig@pengutronix.de
    Adress Jonathan's feedback, recieved some more acks from non-clk
    people

pull request: 2021-07-09, https://lore.kernel.org/linux-clk/20210609202123.=
u5rmw7al4x3rrvun@pengutronix.de

On Fri, Jul 23, 2021 at 11:26:58AM +0300, Andy Shevchenko wrote:
> On Thursday, July 22, 2021, Wolfram Sang <wsa@kernel.org> wrote:
>=20
> >
> > > > What about adding gkh to the list explaining the situation to him?
> > >
> > > Greg doesn't like devm_ stuff.
> > >
> > > I already asked Arnd who doesn't want to interfere and akpm who didn't
> > > react either up to now.
> >
> > Wow, okay, that is frustrating.
>=20
> The situation simply shows the process gap and One Maintainer nowadays is
> far from enough to satisfy demands.

Technically there are two maintainers for drivers/clk, Michael Turquette
and Stephen Boyd. It seems Michael is MIA and Stephen doesn't have the
capacity to address all requests.

> What I think about is that we need to escalate this to Linus and
> others and elaborate the mechanisms how to squeeze a new (additional)
> maintainer when the original one is not responsive. Let=E2=80=99s say some
> procedural steps. Otherwise we doomed because of human factor.

Assuming there was some process for this, is there someone who is
willing to take responsibility here?

Best regards
Uwe
=20
--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7dh7scaylhwikjek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD6iDgACgkQwfwUeK3K
7Alfmwf/d10tYw/BrbClW56C9FCNGAhT1ACcLUxq9mF9kPuafNk9VXbSFdYwtm6M
mwp9Er33t3/rfzxt3LYfRReNt/K1cB8CfLxdkCjFiVe9w5IjxEbYTKx13R/v56M4
C5v8DkL1Y5Af/e8GLsLP4W4gE4D6ZrXG35UXW07hMtuHd8gcXIUAtiODlE/3Mlx6
HVF+6ytkRCXONa4CpNdJWR84cfqka9IhYYv/k0ttG5nt/Xj7yrcEEwjR9jzQk8sD
H38mmqZsdAD5eQHDgi0ZkCiGoI5sJ7uV5ERoEyH6BsCtKRKu945CM+f8h6IeNPmi
z349jO7W2FxoVJTSLPEsw5/o1dSb/A==
=mQTO
-----END PGP SIGNATURE-----

--7dh7scaylhwikjek--
