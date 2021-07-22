Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDEC3D2314
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 14:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhGVL0s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 07:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhGVL0m (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Jul 2021 07:26:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A82961351;
        Thu, 22 Jul 2021 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626955637;
        bh=gbtgRtJwBuii+M7tkqsl84TqgCIZq8mhcmte2Lzn+MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ddt3vm77y1mLIvPkDSMVMzHyNoET2snL4RU4Xto4FuWRjolDWsCffbkdPaix+t87x
         VrBh0KcRxla7FaXm83dqk7zUmfbENHuAlalGxA4vy9G9YDNwFOJCRK8DZ3l8lh2nZM
         EBSbiHSvZ9qVwsegoGfKYFxtJvOrILOfdvMkUvlLQB1Y+vYP+Zqa4A+6w9dtYMT9TJ
         Xt10Af4cb7dIQGTNzpEAEG1RfrgdueAJGQ2BzsLqn5/EfSzGUwjGKY5Ezi6pswSHbj
         8uKg4F0zihD6S+NknM29cXmlN53cVl2Vm+QDSB4jsDuRQCwhKeiswcmqIFNywTqKCm
         h3Uo0EbuQfJ5w==
Date:   Thu, 22 Jul 2021 14:07:13 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-pwm@vger.kernel.org,
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
Message-ID: <YPlfcbkxiBmB+vw1@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HJmKiO7YWMeyy5Jn"
Content-Disposition: inline
In-Reply-To: <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--HJmKiO7YWMeyy5Jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What about adding gkh to the list explaining the situation to him?
>=20
> Greg doesn't like devm_ stuff.
>=20
> I already asked Arnd who doesn't want to interfere and akpm who didn't
> react either up to now.

Wow, okay, that is frustrating.


--HJmKiO7YWMeyy5Jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmD5X20ACgkQFA3kzBSg
KbZ9fg/+IRGhv497cb9AjUOAaqwkvEXqBc1EjRWR9pNzZOWyt7pj/mR/lEHb0xW7
EVNmU6w1ZFv4l3zRKsIYlEXggrIk/vuFsMvYpARpFRFY8v7tU4pwCBDjTFe4aSTH
lTWbeySPepEbAFfkX0V05vlCFyl/5yXMoP5y5qmuQrRrsJ9Usu6wr00YtcA0ImSh
lkqxiOudsmiEF8l3UbxyX10o6CYYGZnKpuADEl9SMj9dRF7GHicNHKsW9jQklRig
b9cjnZJH2SNzM6wzP2IK2OplmLoP7KFCPbkfPfC6jvCDVZ97/9FMu78y4IN2B1bx
mWXSY6VWPNmV3yl7Xl1SwbyL7StWZleneeQcsQkX9V80g3b//eqkqDziz/Db8MPf
hIqkvbj5OAX9jWb8DQBNTE12bvHKXiq5L377FdD4WPgt2xj8zDHwBM7t9HQyIUUZ
jzDgNDGRye3H+FGr4rfmjUU4y5U+pN3f0hgWshTc6Hk4pmf7fGek03/W/bSlo3e2
c4VcVDDs90DZN6guC6fZKWoPSl1AMTTsRavsU3V2IxykCUFSPJzfxlJZ3xOkjPhX
ajN8x4uy3fZj8EsITgszI08QhCavDH4XHvouiBhQKzHmT4iDsQRgeGuHaVRyzCr/
DOf97Ewe7ukTIHFB7uRSaPua/Y0nPXpeNyqWeR/cJZA4PmFDUaY=
=qGuf
-----END PGP SIGNATURE-----

--HJmKiO7YWMeyy5Jn--
