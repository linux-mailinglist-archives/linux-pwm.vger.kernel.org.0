Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3E2F4796
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 10:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAMJ2j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 04:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbhAMJ2j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 04:28:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9D1C061786
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jan 2021 01:27:58 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcRV-0004qK-HO; Wed, 13 Jan 2021 10:27:53 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcRD-0001vm-1j; Wed, 13 Jan 2021 10:27:35 +0100
Date:   Wed, 13 Jan 2021 10:27:34 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] gpio: mvebu: fix pwm .get_state period calculation
Message-ID: <20210113092734.he6dnfpqzxanlo2a@pengutronix.de>
References: <cover.1610529002.git.baruch@tkos.co.il>
 <57860e4929a9d20d73f5e003a148b86a9f82310e.1610529002.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aux4rrwjwnfotsod"
Content-Disposition: inline
In-Reply-To: <57860e4929a9d20d73f5e003a148b86a9f82310e.1610529002.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aux4rrwjwnfotsod
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 11:22:41AM +0200, Baruch Siach wrote:
> The period is the sum of on and off values. That is, calculate period as
>=20
>   ($on + $off) / clkrate
>=20
> instead of
>=20
>   $off / clkrate - $on / clkrate
>=20
> that makes no sense.
>=20
> Reported-by: Russell King <linux@armlinux.org.uk>
> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aux4rrwjwnfotsod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+vQMACgkQwfwUeK3K
7AkF2QgAhVqlTWE9mawJcyYxBGbmVC+NDSoQgHkgbxE3fG3zGU7gpcaWwcyYp5nd
JHV3K0m8zMVqihhlscOMG+zpwILYutl1lkXGN5z5tsxyX07ZFvH+FT6Uw06/UG8k
TwQdpz07v4X/TX8FzrKpXovsVpUnTfLTyVebIt0FcizpW1nnWBTYY+DpZRsHnBNr
n+2J6IzqfOANIc4KU3BOJrMlKU33ydfAo+RQJq9KfjcQxx6jt6iVEdXaq9s7pvbB
BOrJdoSpfd/DHZ99UmNvQ4Ws7qoHr/F6yPZ5TRpDn07dkSx/oSV70VEgZEfFf55A
YJ8x6TEKx2Vexr7yz/QVAw/4c/HlZg==
=P+Qu
-----END PGP SIGNATURE-----

--aux4rrwjwnfotsod--
