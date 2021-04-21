Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2378E366999
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Apr 2021 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhDULEP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Apr 2021 07:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbhDULEN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Apr 2021 07:04:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8002FC06174A
        for <linux-pwm@vger.kernel.org>; Wed, 21 Apr 2021 04:03:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZAdu-000286-CJ; Wed, 21 Apr 2021 13:03:38 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZAds-0008SJ-SF; Wed, 21 Apr 2021 13:03:36 +0200
Date:   Wed, 21 Apr 2021 13:03:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: overflow and wrong timeout errors in pwm-atmel
Message-ID: <20210421110336.bd5s6e2kjxqilddi@pengutronix.de>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
 <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdqkwrongijobl6a"
Content-Disposition: inline
In-Reply-To: <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sdqkwrongijobl6a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 21, 2021 at 11:26:08AM +0200, Uwe Kleine-K=F6nig wrote:
> With these three patches PWM_DEBUG is now happy. (At least I couldn't
> trigger a warning any more. I think there are still a few problems with
> integer overflows.)

BTW, setting the period to 138350580899 (with a clock rate of 133333333
Hz) results in setting period=3D0 because

	state->period * clkrate =3D
	138350580899 * 133333333 =3D
	40254751 (discarded from 18446744073749806367).

Another problem I just noticed is: The driver configures a period of 4s
just fine (i.e. without an overflow). But waiting for a new period to
start (e.g. in atmel_pwm_disable()) aborts after 2s.

So in the area of big period states there are still a few things to
improve.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sdqkwrongijobl6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCABoUACgkQwfwUeK3K
7Ak+SwgAlNeBTFbkl5mSv+YT5agUvdFjMogvlXHJV+ESXSzLN/U+2lp4d4NbCjHt
VFB5WgIBRXQZkitXRiW9msnU2oWqvvSuHKryyv91IpzlKQocbkcMoldc8NpR51Dw
4yFwzfUr7vMVPLUCiYc1U6A7J5Okddf9QfJorJXbGApXR3LEHF0q3BhjMI/DT/k2
i+92tewxHUIF4FS4ITUnTfsapL7xTvyFZovzj9pnKX/7JynA7AOjw+MWoEF3RifQ
4+kdQqrpHL2lqP2ZIeCIgLdhF3Vc7WqGDYlGYj3l9IW3lbPrWdSZWnEl6r+/SLK+
Rxtc8FHDZf/b9+K29Ii02aD3KYwPSA==
=EJ/x
-----END PGP SIGNATURE-----

--sdqkwrongijobl6a--
