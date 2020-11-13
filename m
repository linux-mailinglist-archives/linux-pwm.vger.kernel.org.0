Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A42B162B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 08:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKMHES (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 02:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKMHES (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Nov 2020 02:04:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5FEC0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 23:04:16 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdT7e-0002r8-3x; Fri, 13 Nov 2020 08:03:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdT7Z-0004f0-FQ; Fri, 13 Nov 2020 08:03:45 +0100
Date:   Fri, 13 Nov 2020 08:03:43 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     alexandre.belloni@bootlin.com, heiko@sntech.de,
        Yangtao Li <tiny.windzz@gmail.com>,
        nicolas.ferre@microchip.com, matthias.bgg@gmail.com,
        linux-riscv@lists.infradead.org, festevam@gmail.com,
        f.fainelli@gmail.com, shc_work@mail.ru, khilman@baylibre.com,
        ludovic.desroches@microchip.com, jonathanh@nvidia.com,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
        slemieux.tyco@gmail.com, linux-pwm@vger.kernel.org,
        rjui@broadcom.com, s.hauer@pengutronix.de, mripard@kernel.org,
        vz@mleia.com, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, paul.walmsley@sifive.com,
        linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        claudiu.beznea@microchip.com, nsaenzjulienne@suse.de,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: About devm_platform_ioremap_resource [Was: Re: [PATCH 01/32] pwm:
 sun4i: convert to devm_platform_ioremap_resource]
Message-ID: <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
 <20201112190649.GA908613@ulmo>
 <20201112211429.kfyqzkmmchjo6pll@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bfm7upvbg2x7q3rm"
Content-Disposition: inline
In-Reply-To: <20201112211429.kfyqzkmmchjo6pll@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bfm7upvbg2x7q3rm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Added lkml and the people involved in commit 7945f929f1a7
("drivers: provide devm_platform_ioremap_resource()") to Cc:. For the
new readers: This is about patches making use of
devm_platform_ioremap_resource() instead of open coding it. Full context
at https://lore.kernel.org/r/20201112190649.GA908613@ulmo]

On Thu, Nov 12, 2020 at 10:14:29PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 12, 2020 at 08:06:49PM +0100, Thierry Reding wrote:
> > I also think that it's overly narrow is scope, so you can't actually
> > "blindly" use this helper and I've seen quite a few cases where this was
> > unknowingly used for cases where it shouldn't have been used and then
> > broke things (because some drivers must not do the request_mem_region()
> > for example).
>=20
> You have a link to such an accident?

I got a hint in private here: https://lore.kernel.org/r/1555670144-24220-1-=
git-send-email-aisheng.dong@nxp.com

devm_platform_ioremap_resource() is platform_get_resource() +
devm_ioremap_resource() and here it was used to replace
platform_get_resource() + devm_ioremap().

IMHO the unlucky thing in this situation is that devm_ioremap_resource()
and devm_ioremap() are different by more than just how they get the area
to remap. (i.e. devm_ioremap_resource() also does
devm_request_mem_region().)

So the problem is not the added wrapper, but unclear semantics in the
functions it uses. In my eyes devm_ioremap() and
devm_platform_ioremap_resource() should better be named
devm_request_ioremap() and devm_platform_request_ioremap_resource()
respectively. Is it worth to rename these for clearity?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bfm7upvbg2x7q3rm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+uL8wACgkQwfwUeK3K
7AmhFQf/UMY3Z/O4ajFXsCh5aeqAW1EKy0wv+YtVLmLASYlkvBQ5OpoaFH6U7oZY
a1BVjZ2I3q3pi1zMs+2dPAkylNi0VEIERvwncqHOfYN4FjdNsI85rKbxu4DNsWHJ
wlaQxLwmUmDXDESpJ4RN8JqF/V/nPZfj/4V52ANK31PZ+i4fYnIlW6TU0cJwoJ9s
aGSM2QwTb27uaRg5hqZqfOyIkt3wwkDJIF65H/vi64r0Gtm3c+0iKbEmlXr2XZCh
APhFgQQDGFOMXdSBZeFxTtuLCzuG/RA3Fxb+7okleZUL6GrSwq7xWHJGorO136kq
mo88jw2ceYf/qJA9E4atasOfbQUtlg==
=gJ1m
-----END PGP SIGNATURE-----

--bfm7upvbg2x7q3rm--
