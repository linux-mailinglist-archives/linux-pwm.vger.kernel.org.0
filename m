Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF73DC5CF
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Jul 2021 14:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhGaMAw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 31 Jul 2021 08:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhGaMAw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 31 Jul 2021 08:00:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568DEC06175F
        for <linux-pwm@vger.kernel.org>; Sat, 31 Jul 2021 05:00:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9nf1-0006Si-LC; Sat, 31 Jul 2021 14:00:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9nex-0007cy-2W; Sat, 31 Jul 2021 14:00:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9nex-0001JF-0C; Sat, 31 Jul 2021 14:00:07 +0200
Date:   Sat, 31 Jul 2021 14:00:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     alexandre.belloni@bootlin.com,
        Michael Turquette <mturquette@baylibre.com>,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        Ludovic.Desroches@microchip.com, o.rempel@pengutronix.de,
        andy.shevchenko@gmail.com, aardelean@deviqon.com,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        broonie@kernel.org, Jonathan.Cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        wsa@kernel.org, kernel@pengutronix.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, Claudiu.Beznea@microchip.com
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
References: <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de>
 <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6yytbqtmtyzj4jc"
Content-Disposition: inline
In-Reply-To: <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--i6yytbqtmtyzj4jc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell, hi Stephen,

On Sat, Jul 31, 2021 at 12:41:19AM -0700, Stephen Boyd wrote:
> Quoting Russell King (Oracle) (2021-07-28 13:40:34)
> > > I adapted the Subject in the hope to catch Stephen's and Michael's
> > > attention. My impression is that this thread isn't on their radar yet,
> > > but the topic here seems important enough to get a matching Subject.
>=20
> The thread is on my radar but...
>=20
> >=20
> > Have you thought about sending your pull request to the clk API
> > maintainer (iow, me) ?

I wasn't really aware that Russell has the clk API hat (or that this
separate hat actually exists and this isn't purely a CCF topic). I
assume I only did

	$ scripts/get_maintainer.pl -f drivers/clk/clk-devres.c

which is where the current and new code implementing devm_clk_get et al
lives.

@Russell: What is your position here, do you like the approach of
devm_clk_get_enabled? I can send a new pull request in your direction if
you like it and are willing to take it.

> +1 This patch doesn't fall under CCF maintainer.

Given that CCF is the only implementer of devm_clk_get at least an Ack
=66rom your side would still be good I guess?

> Finally, this sort of patch has been discussed for years and I didn't
> see any mention of those previous attempts in the patch series. Has
> something changed since that time? I think we've got a bunch of hand
> rolled devm things in the meantime but not much else.=20

I found a patch set adding devm variants of clk_enable (e.g.
https://lore.kernel.org/patchwork/patch/755667/) but this approach is
different as it also contains clk_get which IMHO makes more sense=20
The discussion considered wrapping get+enable at one point, but I didn't
find a followup.

> I still wonder if it would be better if we had some sort of DT binding
> that said "turn this clk on when the driver probes this device and keep
> it on until the driver is unbound".

This doesn't sound like a hardware property and so I don't think this
belongs into DT and I would be surprised if the dt maintainers would be
willing to accept an idea with this semantic.

> That would probably work well for quite a few drivers that don't want
> to ever call clk_get() or clk_prepare_enable() and could tie into the
> assigned-clock-rates property in a way that let us keep the platform
> details out of the drivers. We could also go one step further and make
> a clk pm domain when this new property is present and then have the
> clk be enabled based on runtime PM of the device (and if runtime PM is
> disabled then just enable it at driver probe time).

clk pm domain sounds good, but introducing devm_clk_get_enabled() is
much easier and converting to it can be done without dt changes and more
or less mechanically. So I consider the cost-usage-value of
devm_clk_get_enabled() much better.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i6yytbqtmtyzj4jc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEFO0EACgkQwfwUeK3K
7AlP7gf+Mh0OqHPD6Rdp5r9B+Fxlngh7uhJxy6hGORWCzdtQGYt1lJo7givJt/jp
h8/E8f7WHUoDRQ1UWeFfpRDlDFxIvLWqw0xCq+V7pSqTzuynRPg8mVGxFvuni+g3
79HyLA6VnVI9rvaSb1NMcWTLwF8FYISAp3WnrpBQnH1VM1Oi/DDGCA+wHGC3XkWI
sTqJrqewjSGyanX7ijHA/lGUoC+ibLwy1ilQpRJ99GKfqDvSomtSupY/DocH4euY
7VKDTLKTilOB5f0tFlzYplIjbaphveTAD3Qow91V6ycitCOMqQhu1z3y8cDIQ+x2
iBa83Y+F+FSTBv0yzh0od7me8xfcDA==
=D5zi
-----END PGP SIGNATURE-----

--i6yytbqtmtyzj4jc--
