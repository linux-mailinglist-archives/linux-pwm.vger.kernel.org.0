Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2648340AED4
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Sep 2021 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhINNYc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Sep 2021 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhINNYc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Sep 2021 09:24:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A54C061574
        for <linux-pwm@vger.kernel.org>; Tue, 14 Sep 2021 06:23:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ8Or-0007cz-Dv; Tue, 14 Sep 2021 15:23:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ8Oo-0006RL-Ia; Tue, 14 Sep 2021 15:22:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ8Oo-00077e-GZ; Tue, 14 Sep 2021 15:22:58 +0200
Date:   Tue, 14 Sep 2021 15:22:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     alexandre.belloni@bootlin.com,
        Michael Turquette <mturquette@baylibre.com>,
        Ludovic.Desroches@microchip.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, o.rempel@pengutronix.de,
        andy.shevchenko@gmail.com, aardelean@deviqon.com,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        broonie@kernel.org, Jonathan.Cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        wsa@kernel.org, thierry.reding@gmail.com, kernel@pengutronix.de,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        Claudiu.Beznea@microchip.com
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
Message-ID: <20210914132256.5ucytcfmk3sjn2vi@pengutronix.de>
References: <20210728202547.7uvfwflpruku7yps@pengutronix.de>
 <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
 <20210731120004.i3affxw7upl5y4c5@pengutronix.de>
 <20210802094810.GJ22278@shell.armlinux.org.uk>
 <20210802152755.ibisunvibmwhiyry@pengutronix.de>
 <20210802163824.GK22278@shell.armlinux.org.uk>
 <162797831443.714452.3551045763456936564@swboyd.mtv.corp.google.com>
 <20210803104012.wf2buscbukxufesl@pengutronix.de>
 <162820957661.19113.17221558053361108175@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mggb23vxwlpcjl6t"
Content-Disposition: inline
In-Reply-To: <162820957661.19113.17221558053361108175@swboyd.mtv.corp.google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mggb23vxwlpcjl6t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 05, 2021 at 05:26:16PM -0700, Stephen Boyd wrote:
> Quoting Uwe Kleine-K=F6nig (2021-08-03 03:40:12)
> > On Tue, Aug 03, 2021 at 01:11:54AM -0700, Stephen Boyd wrote:
> > >=20
> > > Maybe this series would be more compelling if those various drivers t=
hat
> > > are hand rolling the devm action were converted to the consolidated
> > > official devm function. The truth is it's already happening in various
> > > subsystems so consolidating that logic into one place would be a win
> > > code size wise and very hard to ignore.
> > >=20
> > > Doing
> > >=20
> > >  $ git grep devm_add_action | grep clk
> > >=20
> > > seems to catch quite a few of them.

Will do.
=20
> > Another upside is that grepping for these drivers with a potential for
> > further improvement become easier to grep for as
> > devm_clk_get_{prepared,enabled} is a much better hint :-)
>=20
> Sorry, but that's a pretty weak argument. I'd think grepping for the
> absence of pm_ops in drivers would be the same hint.

To be honest: Yes, it's a weak argument, but grepping for drivers
without pm_ops is a tad more complicated and yields a different set of
drivers. For example take the i2c-imx driver
(drivers/i2c/busses/i2c-imx.c) which has a pm_ops but still can make use
of devm_clk_get_enabled.

> > The changes to these drivers probably won't go through a clk tree, so
> > adding these patches before adding devm_clk_get_enabled() would only
> > help for the warm and cozy feeling that it is right to do so, correct?
>=20
> It isn't to feel warm and cozy. It's to demonstrate the need for
> consolidating code. Converting the i2c and spi drivers to use this is
> actively damaging the cause though. Those driver frameworks are more
> likely to encourage proper power management around bus transfers, so
> converting them to use the devm API moves them away from power
> management, not closer to it.

Well I think one could disagree here. Today these drivers are not power
efficient as they just enable the clock in their probe routine and keep
it on even though it might not be needed.

My patch still is beneficial as it simplifies the drivers without making
them worse. Agreed, this isn't the best optimisation to the drivers
(assuming it is possible to disable the clocks while the device isn't in
use).

> This proves why this topic is always contentious. It's too easy to
> blindly convert drivers to get the clk and leave it enabled forever and
> then they never use power management. The janitors win and nobody else.

If the janitors win and nobody else looses anything, this is fine for
me. And if in the future someone turns up who cares enough to improve
the converted drivers to a more efficient clock usage, they will
probably not stop their efforts just because then the driver uses
devm_clk_get_enabled.

> Is there some way to avoid that trap? Maybe through some combination of
> a device PM function that indicates the driver has no runtime PM
> callbacks (pm_runtime_no_callbacks() perhaps?) and
> devm_clk_get_enabled() checking for that and returning the clk only when
> that call has been made (i.e. pm_runtime_has_no_callbacks())? This
> approach would fail to catch the case where system wide suspend/resume
> could turn the clk off but the driver doesn't do it. I'm not sure how
> much we care about that case though.
>=20
> > As my focus is limited to (mostly) drivers/pwm and I already have quite
> > some other patch quests on my list:
>=20
> Don't we all? :)

Might be. The patches in your queue are however not a reason to drop my
efforts to make my queue shorter :-P

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mggb23vxwlpcjl6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFAoiwACgkQwfwUeK3K
7An7Fgf+Ia8CaycjOR7ZZLxYVuGNx+XLrBQeXwl1H3567k8tcNg55hObDzgVPo1w
cB9RPS5f36SEEa4ixbzMsRINVfkngTTL2zyTKgniKoy4eD0Nb0qYNKuAxRmb87yt
bURm19Q+4J/gdUkTzEVqYIYcXPQJlWzEPKaGHBNlZ55stXnT1IUf5FmoPWK7FWxM
1FTzxg3khSQXc/UosMbVBY9slM4JAskBAfXk7oRasoVbuaEJldG+Gr4jDn78Cras
mJHAT/hsDtRmum9dl8U2NdLXtHoEy3xg6MARQO/K50Kqixg8dIdOpajV8ynvsJFj
3RYCJRrVGp7yeeS9SRw1w6IdNbkBHg==
=z44f
-----END PGP SIGNATURE-----

--mggb23vxwlpcjl6t--
