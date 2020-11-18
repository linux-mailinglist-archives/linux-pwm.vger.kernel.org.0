Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0636E2B7AC1
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 10:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKRJyD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 04:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgKRJyD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:54:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237EAC0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 01:54:03 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK9t-0003br-T9; Wed, 18 Nov 2020 10:53:49 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK9p-00087c-1n; Wed, 18 Nov 2020 10:53:45 +0100
Date:   Wed, 18 Nov 2020 10:53:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>, zhang.lyra@gmail.com,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>, orsonzhai@gmail.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-pwm@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Scott Branden <sbranden@broadcom.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>, baolin.wang7@gmail.com,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
Message-ID: <20201118095342.sviuxvfsbmmn22mo@pengutronix.de>
References: <20201117154340.18216-1-info@metux.net>
 <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrmdeyhh5m52oxeb"
Content-Disposition: inline
In-Reply-To: <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jrmdeyhh5m52oxeb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 06:45:37PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 17, 2020 at 5:45 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
> >
> > The of_match_ptr(foo) macro evaluates to foo, only if
> > CONFIG_OF is set, otherwise to NULL. Same does ACPI_PTR with
> > CONFIG_ACPI. That's very helpful for drivers that can be used
> > with or without oftree / acpi.
> >
> > Even though most of the drivers touched here probably don't
> > actually need that, it's also nice for consistency to make it
> > the de-facto standard and change all drivers to use the
> > of_match_ptr() and ACPI_PTR() macros.
> >
> > A nice side effect: in some situations, when compiled w/o
> > CONFIG_OF/CONFIG_ACPI, the corresponding match tables could
> > automatically become unreferenced and optimized-away by the
> > compiler, w/o explicitly cluttering the code w/ ifdef's.
>=20
> NAK.
>=20
> It prevents using DT-enabled drivers on ACPI based platforms.

So a system without CONFIG_OF might still make use of .of_match_table?

If so: TIL ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jrmdeyhh5m52oxeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+07yIACgkQwfwUeK3K
7Ak+4Af/S4LACdOy4WkgBIlg0vOjRAgAtSXuRqE7DZpYrEDA16Jf1/hvxQgwZgoQ
2gZ2CszqBXhxH94X4GFtm7veiGfXquPsf0qlQ31Ou2yDIIv0+oXBBrSi78lwesD1
1s6fYmYnp+Oijt1tRIg+euHAWOyIIyavCIBFkoFVIOvlux7JMc7pQZrdTGuiHJP1
6c6F0G+G2nlLQtmwsR4Jm2vERKNDy3X87PdQANsH4ipSsIFyxTH/5Mgx4kLRZ/sg
prSguvAIqgH+3KyVK9w454gWpqQJrGiCa7CEybzjNjAnjCAoxnnJ8SQ1/Ys27Y5L
O0PgX1tM/ulriSZe+T5UUlYqGZyBAw==
=A5vw
-----END PGP SIGNATURE-----

--jrmdeyhh5m52oxeb--
