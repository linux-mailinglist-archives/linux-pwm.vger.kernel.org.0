Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E126AF1A
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Sep 2020 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgIOVEG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Sep 2020 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgIOVDy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Sep 2020 17:03:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C9C06178C
        for <linux-pwm@vger.kernel.org>; Tue, 15 Sep 2020 14:03:54 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kII79-00006G-Jl; Tue, 15 Sep 2020 23:03:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kII73-00019G-6I; Tue, 15 Sep 2020 23:03:41 +0200
Date:   Tue, 15 Sep 2020 23:03:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v10 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200915210340.xg5xwmajufedyltr@pengutronix.de>
References: <20200914214341.14268-1-michael@walle.cc>
 <20200914214341.14268-7-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyiwyjcsxpn452wt"
Content-Disposition: inline
In-Reply-To: <20200914214341.14268-7-michael@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cyiwyjcsxpn452wt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 11:43:34PM +0200, Michael Walle wrote:
> Add support for the PWM controller of the sl28cpld board management
> controller. This is part of a multi-function device driver.
>=20
> The controller has one PWM channel and can just generate four distinct
> frequencies.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

@Lee: From my side taking the patch via your mfd tree is fine.

Thanks for your effort to align your patch to my reviews
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cyiwyjcsxpn452wt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9hLCkACgkQwfwUeK3K
7AmJogf/X2AMslmJpJk0/t52+83yxuLmP8HEPZ/fZLyaE9/xTy0N/O2LeLsp13pK
Jy7h+pQXkSORq2B/y38E5O+HAYSHquEkhnJKCG6sQk6gFxBH4F4eU14Y3LB7etqM
8mNonE4LjJoNew2Mv2hBdO+9fTMum16bEe7rcQwBY3B6BYFkmad7ZK9XoDYm4cfB
V5aLHywUaFB9/CZ2fqXDvtN/47Rf+ejnkrijTYwwu+BGf8i6bxIOUzSTHrrm5KnF
fZ+GAFFikBriPAKpJvrVA0w3/tOhHpaOhNu405ghN4+aNwieSq0f6OZVP8IgJP3T
c/G/lstWFGVi0MbWlbzQfVxcrCnBpg==
=I40k
-----END PGP SIGNATURE-----

--cyiwyjcsxpn452wt--
