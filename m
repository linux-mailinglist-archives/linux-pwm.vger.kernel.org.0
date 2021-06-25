Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3713B4810
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFYRRQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYRRQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 13:17:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4C2C061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 10:14:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwpPZ-0002EO-Ed; Fri, 25 Jun 2021 19:14:37 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwpPW-0005JJ-9a; Fri, 25 Jun 2021 19:14:34 +0200
Date:   Fri, 25 Jun 2021 19:14:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yt4c5ea6o5vvs7cu"
Content-Disposition: inline
In-Reply-To: <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yt4c5ea6o5vvs7cu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Wed, Jun 09, 2021 at 10:21:23PM +0200, Uwe Kleine-K=F6nig wrote:
> given that I don't succeed in getting any feedback for my patch set, I'm
> trying with a pull request today. It would be really great if this pull
> request made it finally in for the next merge window.

It seems sending a pull request didn't help either :-\

I'm waiting since October for feedback, several people expressed to like
this series and I want to make use of it to simplify a few drivers. I'm
quite annoyed that your missing feedback blocks me from further
improving stuff.

> The changes are not as bad or complex as the diffstat suggests. The
> first patch contains all the complexity and only has
>  1 file changed, 50 insertions(+), 17 deletions(-)
> . The second patch makes use of this and just adds kernel-doc, four
> functions that are one-line wrappers around the newly introduced
> __devm_clk_get() function in the first patch and dummy implementations
> for the !CONFIG_HAVE_CLK case.
>=20
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627=
b5:
>=20
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.pengutronix.de/git/ukl/linux tags/devm-clk-get-enabled
>=20
> for you to fetch changes up to fec74d434d6f6016b6b2d5ab13aa28a0c657f5fb:
>=20
>   clk: Provide new devm_clk_helpers for prepared and enabled clocks (2021=
-05-11 14:20:13 +0200)
>=20
> ----------------------------------------------------------------
> New variants of devm_clk_get() for prepared and enabled clocks
>=20
> These two patches create a set of new devm helpers that return clocks
> already prepared or prepared-and-enabled. The automatic cleanup cares
> for unpreparing and disabling+unpreparing respectively.
>=20
> This allows to simplify various drivers as was demonstrated with
> additional patches sent with the various revisions of this patch set.
> See
> https://lore.kernel.org/r/20210510174142.986250-1-u.kleine-koenig@pengutr=
onix.de
> for the last submission round. This pull request doesn't contain these
> patches though.
>=20
> ----------------------------------------------------------------
> Uwe Kleine-K=F6nig (2):
>       clk: generalize devm_clk_get() a bit
>       clk: Provide new devm_clk_helpers for prepared and enabled clocks
>=20
>  drivers/clk/clk-devres.c | 96 ++++++++++++++++++++++++++++++++++++++++--=
------
>  include/linux/clk.h      | 90 ++++++++++++++++++++++++++++++++++++++++++=
++-
>  2 files changed, 169 insertions(+), 17 deletions(-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yt4c5ea6o5vvs7cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDWDvYACgkQwfwUeK3K
7AlVZgf+IaVy0jXvnrb1R7iOX2vSxmgWoXuGFE87xgMQhGK4KsqAx+hbgk8lGxx9
RgQSXmBFj6mxdQVbzCIRiYtN73AeUixQvZwc3pIPMRfYFDrrx+N5XvUkTWyvp3kj
PKTkVEeVYXFZi48twlb9N/wqs8DIdDGNSR1Me1w6FIcASw2c9NfzF9+XJ/Eosi8F
hDqlDlbcyXThL2rAvmckHnSKjY+8VUDGgPrQwipWqjM5GJeD0SH/zW5Dv42pUsop
lduvdTFCazmNoDIuSwf/bHJs+RcWsVpHUMgghIAY2xCYvxf9Livj22/iHBdR80Zl
O9XSiJAcEiz5iXzqI8k/9/JzM1CEXw==
=UnMp
-----END PGP SIGNATURE-----

--yt4c5ea6o5vvs7cu--
