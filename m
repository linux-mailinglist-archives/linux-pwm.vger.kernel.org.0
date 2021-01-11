Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C02F209D
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 21:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbhAKUVu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390827AbhAKUVt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 15:21:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA1C061795
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 12:21:09 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3gV-0007GN-An; Mon, 11 Jan 2021 21:21:03 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3gU-0001xU-VG; Mon, 11 Jan 2021 21:21:02 +0100
Date:   Mon, 11 Jan 2021 21:21:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] gpio: mvebu: don't limit pwm period/duty_cycle to
 UINT_MAX
Message-ID: <20210111202102.zwyjkvxxylylviqq@pengutronix.de>
References: <cover.1610362661.git.baruch@tkos.co.il>
 <97e5ed4dfc4385a99c585f7980210f9dd7c6ee3d.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfoxppzywe25jvjp"
Content-Disposition: inline
In-Reply-To: <97e5ed4dfc4385a99c585f7980210f9dd7c6ee3d.1610362661.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hfoxppzywe25jvjp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 01:17:05PM +0200, Baruch Siach wrote:
> PWM on/off registers are limited to UINT_MAX. However the state period
> and duty_cycle fields are ns values of type u64. There is no reason to
> limit them to UINT_MAX.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hfoxppzywe25jvjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8sywACgkQwfwUeK3K
7Ak2SQf/bI8GlMvs3REI9S0cAHESvMUYgAQzfkeO8S2SU99KU1V2hY11KToF73Hz
stiocqQBz/wKTSO/ZUFzCLiAqq6cNoU2I+Z3d6KJ7NFX0d1KjcbKM20d5PIKmdeb
piOaLGzW5Vezijj/fofa3RinaMCT50Y9D1N92VzCKkUL3b95SqNhRA7EVgig2YrG
EBxBwj8Gz7hqFC2zCAVcjLtQEYGe3ZKdvrfCCYiBLi5KeowsCR557TFsgThsFGGM
LRdZdzjCvXbHUoQaLInYckZwSKzBnGzucXuJblVB0yZiTeEOJecD5yX6JZZRQVp3
0HxO4rFCnGwnCcxVrbVfsgFNirT82w==
=ZdbW
-----END PGP SIGNATURE-----

--hfoxppzywe25jvjp--
