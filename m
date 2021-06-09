Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1271F3A1E0D
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jun 2021 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhFIUXj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Jun 2021 16:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhFIUXi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jun 2021 16:23:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEF7C06175F
        for <linux-pwm@vger.kernel.org>; Wed,  9 Jun 2021 13:21:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lr4hc-0002WB-Au; Wed, 09 Jun 2021 22:21:28 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lr4hX-0003g3-WB; Wed, 09 Jun 2021 22:21:24 +0200
Date:   Wed, 9 Jun 2021 22:21:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-clk@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PULL] Add variants of devm_clk_get for prepared and enabled clocks
 enabled clocks
Message-ID: <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlb5tlnr3m7frksr"
Content-Disposition: inline
In-Reply-To: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jlb5tlnr3m7frksr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

given that I don't succeed in getting any feedback for my patch set, I'm
trying with a pull request today. It would be really great if this pull
request made it finally in for the next merge window.

The changes are not as bad or complex as the diffstat suggests. The
first patch contains all the complexity and only has
 1 file changed, 50 insertions(+), 17 deletions(-)
=2E The second patch makes use of this and just adds kernel-doc, four
functions that are one-line wrappers around the newly introduced
__devm_clk_get() function in the first patch and dummy implementations
for the !CONFIG_HAVE_CLK case.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/devm-clk-get-enabled

for you to fetch changes up to fec74d434d6f6016b6b2d5ab13aa28a0c657f5fb:

  clk: Provide new devm_clk_helpers for prepared and enabled clocks (2021-0=
5-11 14:20:13 +0200)

----------------------------------------------------------------
New variants of devm_clk_get() for prepared and enabled clocks

These two patches create a set of new devm helpers that return clocks
already prepared or prepared-and-enabled. The automatic cleanup cares
for unpreparing and disabling+unpreparing respectively.

This allows to simplify various drivers as was demonstrated with
additional patches sent with the various revisions of this patch set.
See
https://lore.kernel.org/r/20210510174142.986250-1-u.kleine-koenig@pengutron=
ix.de
for the last submission round. This pull request doesn't contain these
patches though.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (2):
      clk: generalize devm_clk_get() a bit
      clk: Provide new devm_clk_helpers for prepared and enabled clocks

 drivers/clk/clk-devres.c | 96 ++++++++++++++++++++++++++++++++++++++++----=
----
 include/linux/clk.h      | 90 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 17 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jlb5tlnr3m7frksr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDBIsAACgkQwfwUeK3K
7Alkugf/WZeWnWAV4qBqO+Z6x4ARRoga+Gjpg6BwHHpK+Kk9UNydeZtR0UeaVDZp
hK/705S/EeZplYpkKxrxtsVV4EK2fqagBccxfYDtbcbjQsWEOZzqBAxtw+xoUPB0
FXwwQcD6RIMMnMsILzsr43KX4gOmDp6rUSAGsQj9ctOJtGd0qp8Y0g2FxcUkXRYK
tmLuixTBnOegyNmzK99qGA7bPNABkbt4wfnqPDrn30txhGV7ZOjeCm5FOApsgt2E
BYIl6DTFCKRvE1EDQMFV1FHI8eX2ygJ/KjrDOm+OWkO4bEJfZxrS0I48gm3GFkbG
l4kofwamfBagjIlMv2toKyH0CpDyEw==
=OVXu
-----END PGP SIGNATURE-----

--jlb5tlnr3m7frksr--
