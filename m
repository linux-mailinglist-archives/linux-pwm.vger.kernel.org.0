Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296E52FA3FD
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Jan 2021 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405254AbhARPCt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 10:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393222AbhARPBD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jan 2021 10:01:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0A2C061575
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jan 2021 07:00:23 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1W0l-0003JB-LH; Mon, 18 Jan 2021 16:00:07 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1W0V-0007WT-3p; Mon, 18 Jan 2021 15:59:51 +0100
Date:   Mon, 18 Jan 2021 15:59:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/5] gpio: mvebu: pwm fixes and improvements
Message-ID: <20210118145950.57oojkpe2b6zjmsf@pengutronix.de>
References: <cover.1610529002.git.baruch@tkos.co.il>
 <CACRpkdZvECD74V2+84+TJOW8cx-OUH-nHOouTxgNGSxkqPzsjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4tyzmw24tono5g4i"
Content-Disposition: inline
In-Reply-To: <CACRpkdZvECD74V2+84+TJOW8cx-OUH-nHOouTxgNGSxkqPzsjw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4tyzmw24tono5g4i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

On Mon, Jan 18, 2021 at 02:45:14PM +0100, Linus Walleij wrote:
> On Wed, Jan 13, 2021 at 10:23 AM Baruch Siach <baruch@tkos.co.il> wrote:
>=20
> > This series adds a few related fixes to the pwm .apply and .get_state
> > callbacks.
> >
> > The first patch was originally part of the series adding Armada 8K/7K p=
wm
> > support. I split it out to a separate series following review comments =
=66rom
> > Uwe Kleine-K=F6nig who spotted a few more issues. There is no dependenc=
y between
> > this and the Armada 8K/7K series.
>=20
> This version looks really good and +/- minor tweaks as indicated by
> Uwe:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

The most recent version of this series is v4.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4tyzmw24tono5g4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAFomQACgkQwfwUeK3K
7Aka3Af7Bt/IECK5Ip0iUiop1hHEluezWkLhf/SuXttl/HIkCPoB6m9amFHI68tl
06Zn/DrJULPj2iVUAtt2x9zSb+cExW+FZDhrol3/Sotuu1ozr7AH4JH7tZIIK9E8
Q0OL6b4vj6UT+i8rILONZ3tdpBMDNpf+hpucnVEpZIP2WaBlNcqQM3cUBtk+FcdU
0zNeBiZtYL1O5TEjGyA4h2W/HjP22aKZH/kPJMDT7LS+Bh3w5GWEd5aH8SuRgGaQ
GBbN0lm7BYNYaHRRaS9KmBe6Pec1UxcP4m1qDJZKCxJwaywlaLI7trEONb6hl27G
Ask+CpBXZaC+zkYR+kCVp4NoTr6Ebw==
=yrA0
-----END PGP SIGNATURE-----

--4tyzmw24tono5g4i--
