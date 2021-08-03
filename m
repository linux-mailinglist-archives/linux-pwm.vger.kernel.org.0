Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BD3DEB19
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Aug 2021 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhHCKko (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Aug 2021 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhHCKkl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Aug 2021 06:40:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5CC06179B
        for <linux-pwm@vger.kernel.org>; Tue,  3 Aug 2021 03:40:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mArqL-0000Z2-TR; Tue, 03 Aug 2021 12:40:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mArqG-0006N5-So; Tue, 03 Aug 2021 12:40:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mArqG-0002vP-Qh; Tue, 03 Aug 2021 12:40:12 +0200
Date:   Tue, 3 Aug 2021 12:40:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        alexandre.belloni@bootlin.com,
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
Message-ID: <20210803104012.wf2buscbukxufesl@pengutronix.de>
References: <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
 <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de>
 <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
 <20210802094810.GJ22278@shell.armlinux.org.uk>
 <20210802152755.ibisunvibmwhiyry@pengutronix.de>
 <20210802163824.GK22278@shell.armlinux.org.uk>
 <162797831443.714452.3551045763456936564@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jsnx7dwxusk2t7bj"
Content-Disposition: inline
In-Reply-To: <162797831443.714452.3551045763456936564@swboyd.mtv.corp.google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jsnx7dwxusk2t7bj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2021 at 01:11:54AM -0700, Stephen Boyd wrote:
> Quoting Russell King (Oracle) (2021-08-02 09:38:24)
> > On Mon, Aug 02, 2021 at 05:27:55PM +0200, Uwe Kleine-Konig wrote:
> > > Hello Russell,
> > >=20
> > > On Mon, Aug 02, 2021 at 10:48:10AM +0100, Russell King (Oracle) wrote:
> >=20
> > > > There have been several different approaches to wrapping things up,
> > > > but here's a question: should we make it easier to do the lazy thing
> > > > (get+enable) or should we make it easier to be power efficient?
> > > > Shouldn't we be encouraging people to write power efficient drivers?
> > >=20
> > > Yeah, sounds compelling, but I wonder if that's of practical importan=
ce.
> > > How many driver authors do you expect to lure into making a better
> > > driver just because devm_clk_get_prepared() doesn't exist? In contras=
t:
> > > How many drivers become simpler with devm_clk_get_prepared() and so
> > > it becomes easier to maintain them and easier to spot bugs?
> > > In the absence of devm_clk_get_prepared(), is it better that several
> > > frameworks (or drivers) open code it?
> >=20
> > It probably depends on where you stand on power management and power
> > efficiency issues. Personally, I would like to see more effort put
> > into drivers to make them more power efficient, and I believe in the
> > coming years, power efficiency is going to become a big issue.
> >=20
>=20
> I agree we should put more effort into power efficiency in the kernel.
> I've occasionally heard from driver writers that they never will turn
> the clk off even in low power modes though. They feel like it's a
> nuisance to have to do anything with the clk framework in their driver.
> When I say "why not use runtime PM?" I get told that they're not turning
> the clk off because it needs to be on all the time, so using runtime PM
> makes the driver more complicated, not less, and adds no value. I think
> some touchscreens are this way, and watchdogs too. Looking at the
> drivers being converted in this series I suspect RTC is one of those
> sorts of devices as well. But SPI and I2C most likely could benefit from
> using runtime PM and so those ones don't feel appropriate to convert.
>=20
> Maybe this series would be more compelling if those various drivers that
> are hand rolling the devm action were converted to the consolidated
> official devm function. The truth is it's already happening in various
> subsystems so consolidating that logic into one place would be a win
> code size wise and very hard to ignore.
>=20
> Doing
>=20
>  $ git grep devm_add_action | grep clk
>=20
> seems to catch quite a few of them.

Another upside is that grepping for these drivers with a potential for
further improvement become easier to grep for as
devm_clk_get_{prepared,enabled} is a much better hint :-)

The changes to these drivers probably won't go through a clk tree, so
adding these patches before adding devm_clk_get_enabled() would only
help for the warm and cozy feeling that it is right to do so, correct?

As my focus is limited to (mostly) drivers/pwm and I already have quite
some other patch quests on my list:

So can I lure you in merging the new functions and I will create a
kernel janitor task to convert more existing drivers?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jsnx7dwxusk2t7bj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEJHQkACgkQwfwUeK3K
7Al74wgAkhpu5oiH9zXF7yver2FOhm5lA/whLWxAmSyiMUqAURgga0ZHZaA5jSfS
V47S5aYg2PHTPQjHsE9vffbXZ1NfmE4t+XsY/9hn1EaGA3yrwCfxF5oFeTqZnP+D
AJxuot538b05HhV1MY2TDE/MYs7XKlKzT/BzfI14JPKIAzdFpTu33/XNNocLBs3M
FK3NlL7d2p7tynJYDE7WCTsBH8r+k9QJmwSVl1GB8xTk7WOwEcPysg4Ts3aO5csk
02QFW6StrFEYfMKMEPm6uf5PX0Y4G4es8MbCpy+3pU1UXGojQcRvp4ocPiszpYFt
mqFFq7f3cn4PK8GIh5GncnlWzh7DeQ==
=THuX
-----END PGP SIGNATURE-----

--jsnx7dwxusk2t7bj--
