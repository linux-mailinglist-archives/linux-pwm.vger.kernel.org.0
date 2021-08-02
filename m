Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA43DDC6F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Aug 2021 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhHBP23 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Aug 2021 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbhHBP2Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Aug 2021 11:28:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00689C06175F
        for <linux-pwm@vger.kernel.org>; Mon,  2 Aug 2021 08:28:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mAZrC-00076g-Hh; Mon, 02 Aug 2021 17:27:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mAZrA-0004Qi-3t; Mon, 02 Aug 2021 17:27:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mAZrA-0008Ni-1g; Mon, 02 Aug 2021 17:27:56 +0200
Date:   Mon, 2 Aug 2021 17:27:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     alexandre.belloni@bootlin.com,
        Michael Turquette <mturquette@baylibre.com>,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        Ludovic.Desroches@microchip.com, o.rempel@pengutronix.de,
        andy.shevchenko@gmail.com, aardelean@deviqon.com,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        broonie@kernel.org, Jonathan.Cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, wsa@kernel.org, kernel@pengutronix.de,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        Claudiu.Beznea@microchip.com
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210802152755.ibisunvibmwhiyry@pengutronix.de>
References: <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de>
 <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
 <20210802094810.GJ22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4yhd4k7pc6ksrfur"
Content-Disposition: inline
In-Reply-To: <20210802094810.GJ22278@shell.armlinux.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4yhd4k7pc6ksrfur
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Russell,

On Mon, Aug 02, 2021 at 10:48:10AM +0100, Russell King (Oracle) wrote:
> On Sat, Jul 31, 2021 at 02:00:04PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hi Russell, hi Stephen,
> >=20
> > On Sat, Jul 31, 2021 at 12:41:19AM -0700, Stephen Boyd wrote:
> > > +1 This patch doesn't fall under CCF maintainer.
> >=20
> > Given that CCF is the only implementer of devm_clk_get at least an Ack
> > from your side would still be good I guess?
>=20
> I think devm_clk_get() should not be part of CCF but should be
> part of the interface level - it's silly to have devm_clk_get()
> being CCF but not clk_get(). The same should go for the other
> devm wrappers around the plain clk_* interfaces.

What is the practical difference between "Function X is part of CCF" and
"Function X is part of the clk interface and there is only CCF who
implements it"?

> > I found a patch set adding devm variants of clk_enable (e.g.
> > https://lore.kernel.org/patchwork/patch/755667/) but this approach is
> > different as it also contains clk_get which IMHO makes more sense=20
> > The discussion considered wrapping get+enable at one point, but I didn't
> > find a followup.
>=20
> There have been several different approaches to wrapping things up,
> but here's a question: should we make it easier to do the lazy thing
> (get+enable) or should we make it easier to be power efficient?
> Shouldn't we be encouraging people to write power efficient drivers?

Yeah, sounds compelling, but I wonder if that's of practical importance.
How many driver authors do you expect to lure into making a better
driver just because devm_clk_get_prepared() doesn't exist? In contrast:
How many drivers become simpler with devm_clk_get_prepared() and so
it becomes easier to maintain them and easier to spot bugs?
In the absence of devm_clk_get_prepared(), is it better that several
frameworks (or drivers) open code it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4yhd4k7pc6ksrfur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEIDvMACgkQwfwUeK3K
7Alp/gf/YuHVn2QCiQY9Ln+XZfkad7QXQJYE0+fG2AJ7dxEy13P7sSRuADCYTAGu
sE2xOSevHd7QQeJjY2UcjHahHyGJwJXMBKLouDyrPEhocQpBd3mp9ewBe1BL/jRH
4Euz/1SRM2NSfTc9lw7QzxHD6tGOY6Lo6Qj34pE7gKel4UX9FrYOqCoq2YbViMoX
nVueeVsmqp5pt+mB4tfNDWOA+H7dkH+LoGc0yggaVQW/K+rZqdr/qBYsFq7k4Zjv
Csk4EcDMhWkDlTekyjRutr3F6uGoCFWvuu52IQqxkVfRVy35Zx0tBpzGtILDTVRB
Ww69Vm7tkWdIyLcrczBXbDvc7FMunQ==
=PmG8
-----END PGP SIGNATURE-----

--4yhd4k7pc6ksrfur--
