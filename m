Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580BE2B98F0
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 18:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKSRIT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 12:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgKSRIT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Nov 2020 12:08:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFAC0613CF
        for <linux-pwm@vger.kernel.org>; Thu, 19 Nov 2020 09:08:19 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfnPk-0003Hr-8W; Thu, 19 Nov 2020 18:08:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfnPg-0005S4-75; Thu, 19 Nov 2020 18:08:04 +0100
Date:   Thu, 19 Nov 2020 18:08:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     alexandre.belloni@bootlin.com, heiko@sntech.de,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-riscv@lists.infradead.org, festevam@gmail.com,
        f.fainelli@gmail.com, shc_work@mail.ru,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        khilman@baylibre.com, wens@csie.org, jonathanh@nvidia.com,
        linux-rockchip@lists.infradead.org,
        ludovic.desroches@microchip.com,
        bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
        slemieux.tyco@gmail.com, linux-pwm@vger.kernel.org,
        rjui@broadcom.com, s.hauer@pengutronix.de, mripard@kernel.org,
        vz@mleia.com, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, paul.walmsley@sifive.com,
        matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, palmer@dabbelt.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        claudiu.beznea@microchip.com, nsaenzjulienne@suse.de
Subject: Re: About devm_platform_ioremap_resource [Was: Re: [PATCH 01/32]
 pwm: sun4i: convert to devm_platform_ioremap_resource]
Message-ID: <20201119170802.bup5foltlhrg5576@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
 <20201112190649.GA908613@ulmo>
 <20201112211429.kfyqzkmmchjo6pll@pengutronix.de>
 <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
 <20201113161153.GB1408970@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mpmylxzqzkfzclys"
Content-Disposition: inline
In-Reply-To: <20201113161153.GB1408970@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mpmylxzqzkfzclys
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 13, 2020 at 05:11:53PM +0100, Thierry Reding wrote:
> I think function names are always a compromise between giving you the
> gist of what the implementation does and being short enough so it
> doesn't become difficult to read or use.

Right. In my eyes if you have=20

 - devm_platform_ioremap_resource
 - devm_platform_get_and_ioremap_resource
 - devm_ioremap_resource
 - devm_ioremap

(to list just a few) with the current semantics, the compromise is badly
shifted into the "short name" direction however; and that was the
motivation for this patch set. In my eyes it must be more obvious which
of these functions include devm_request_mem_region() and which don't.

And note, my patch series doesn't introduce new helpers, just renames
them to have a better name (and adds compat glue for the old names).

> One of the reasons why I dislike the addition of helpers for every
> common special case (like devm_platform_ioremap_resource()) is because
> it doesn't (always) actually make things easier for developers and/or
> maintainers. Replacing three lines of code with one is a minor
> improvement, even though there may be many callsites and therefore in
> the sum this being a fairly sizeable reduction. The flip side is that
> now we've got an extra symbol with an unwieldy name that people need
> to become familiar with, and then, like the link above shows, it doesn't
> work in all cases, so you either need to fall back to the open-coded
> version or you keep adding helpers until you've covered all cases. And
> then we end up with a bunch of helpers that you actually have to go and
> read the documentation for in order to find out which one exactly fits
> your use-case.

This is indeed a relevant point. An alternative is to make the helper
more flexible. This complicates the API, too, however, so this isn't
always gold, either.
=20
> Without the helpers it's pretty simple to write, even if a little
> repetitive:
>=20
>   1) get the resource you want to map
>   2) request the resource
>   3) map the resource
>=20
> 2) & 3) are very commonly done together, so it makes sense to have a
> generic helper for them. If you look at the implementation, the
> devm_ioremap_request() implementation does quite a bit of things in
> addition to just requesting and remapping, and that's the reason why
> that helper makes sense.
>=20
> For me personally, devm_platform_ioremap_resource() is just not adding
> enough value to justify its existence. And then we get all these other
> variants that operate on the resource name (_byname) and those which
> remap write-combined (_wc). But don't we also need a _byname_wc()
> variant for the combination? Where does it stop?

I'm on your side for the _wc stuff, looking at next-20201119:

 - devm_ioremap_resource_wc has a single user:
   devm_platform_ioremap_resource_wc
 - devm_platform_ioremap_resource_wc has a single user:
   drivers/misc/sram.c

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mpmylxzqzkfzclys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+2pm8ACgkQwfwUeK3K
7Anx6gf/afcuCS6ctL6YtwVi/Z9EkHHcNA1X6g1BHEYgptvB5jElIwju5FwCP1Mr
dFL0pNAhpH9f0DppbH2oLUVOCNyD1ZfgQGWqGvcrFY+T/cx7wNOTgF7Meq/DMeH4
Btkjn4WlVzI342o84E+DOy1HLsqFio7btNOVl/UtRWOJXeiebIbTd8ees4f4Y89q
W9/WHyX7vHoJ3Xr+o2U+sdGrP8yZv+rZ+5LqrHCFhbPQIRXcdf37e2BINTBY5R/d
ceVKdUCv+pHJAc096R4R4t2vc42sG7OfOJzSDndG4B/duKHoL+v79d8ocfUpaO58
3CubdcFfVk/uoUX+9qYPjwKoWefCBw==
=OAoV
-----END PGP SIGNATURE-----

--mpmylxzqzkfzclys--
