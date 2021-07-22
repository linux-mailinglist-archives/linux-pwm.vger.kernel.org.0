Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7A3D1FC4
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGVHiA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 03:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHh7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Jul 2021 03:37:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD7C061575
        for <linux-pwm@vger.kernel.org>; Thu, 22 Jul 2021 01:18:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6TuN-0002SO-F3; Thu, 22 Jul 2021 10:18:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6TuL-0001kn-O6; Thu, 22 Jul 2021 10:18:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m6TuL-00036S-MN; Thu, 22 Jul 2021 10:18:17 +0200
Date:   Thu, 22 Jul 2021 10:18:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Message-ID: <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dcz6k6v3zmej7fpb"
Content-Disposition: inline
In-Reply-To: <YPkg0wtYIoHKpTUW@kunai>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dcz6k6v3zmej7fpb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Wolfram,

On Thu, Jul 22, 2021 at 09:40:03AM +0200, Wolfram Sang wrote:
>=20
> > The next merge window is over now. The pull request still merges fine
> > into v5.14-rc2. I'm still convinced it adds some benefit and I want to
> > use it to simplify a bunch of drivers. But I cannot without this being
> > merged.
> >=20
> > Do I have to consider creating these functions in the pwm namespace to
> > continue here? This cannot be the right thing to do?!
>=20
> What about adding gkh to the list explaining the situation to him?

Greg doesn't like devm_ stuff.

I already asked Arnd who doesn't want to interfere and akpm who didn't
react either up to now.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dcz6k6v3zmej7fpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD5KcYACgkQwfwUeK3K
7An5gwf/afFsO3XhKXHxb1kAtRxC3wVwPMVXvOt3lTAT8Xj2zGPXDM/j3uOEod7w
bt+MoV2KpvrIBXqQC1H/xuG6UOGI7TXHsMtCButRTQDlr9GQvQnpd/u1S4Kp6Bue
yRV0YigoJLCba3100r7Ibs30oDluD1zEzGbCdaiuqEHDIAqezH2fCEAzGJreg6eb
MvMJ6dOKSqIe3rOPvM9DiTUy+Zluco6y9Pw3ZM3oMRQTTvQnsrGbXnlGrcelkD4A
siFcCUhI4hF8BxGCiYArEX2R1hNFiDWCeTXeSHB8pIE3hYqzya98X+Z9GeSKcc5e
LCKoXqOqcE9oB0xyvs/bvBYWjJv/mg==
=3nTq
-----END PGP SIGNATURE-----

--dcz6k6v3zmej7fpb--
