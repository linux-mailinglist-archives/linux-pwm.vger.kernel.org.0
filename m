Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3727D366D22
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Apr 2021 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhDUNtH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Apr 2021 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDUNtD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Apr 2021 09:49:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6EC06174A
        for <linux-pwm@vger.kernel.org>; Wed, 21 Apr 2021 06:48:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZDDP-0002bJ-SZ; Wed, 21 Apr 2021 15:48:27 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZDDO-00018U-EK; Wed, 21 Apr 2021 15:48:26 +0200
Date:   Wed, 21 Apr 2021 15:48:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: overflow and wrong timeout errors in pwm-atmel
Message-ID: <20210421134825.powx5tvqvce32fho@pengutronix.de>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
 <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
 <20210421110336.bd5s6e2kjxqilddi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hunmctkm5vrpq4ne"
Content-Disposition: inline
In-Reply-To: <20210421110336.bd5s6e2kjxqilddi@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hunmctkm5vrpq4ne
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 21, 2021 at 01:03:36PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Apr 21, 2021 at 11:26:08AM +0200, Uwe Kleine-K=F6nig wrote:
> > With these three patches PWM_DEBUG is now happy. (At least I couldn't
> > trigger a warning any more. I think there are still a few problems with
> > integer overflows.)
>=20
> BTW, setting the period to 138350580899 (with a clock rate of 133333333
> Hz) results in setting period=3D0 because
>=20
> 	state->period * clkrate =3D
> 	138350580899 * 133333333 =3D
> 	40254751 (discarded from 18446744073749806367).

As a first remedy the following could be done:

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 38d86340201c..02d69fa5f7d2 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -199,6 +199,11 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pw=
m_chip *chip,
 	unsigned long long cycles =3D state->period;
 	int shift;
=20
+	if (fls(cycles) + fls(clkrate) > 64) {
+		dev_err(chip->dev, "period to big to calculate HW parameters\n");
+		return -EINVAL;
+	}
+
 	/* Calculate the period cycles and prescale value */
 	cycles *=3D clkrate;
 	do_div(cycles, NSEC_PER_SEC);

Is this sensible? (Actually I'd prefer to just continue with

	period =3D (ULL(1) << (64 - fls(clkrate))) - 1

according to the motto to yield the highest possible period, but this
function has another error path that returns -EINVAL so this would be
inconsistent.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hunmctkm5vrpq4ne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCALSYACgkQwfwUeK3K
7Almrwf/c+tV70NNg925X+gBlg69oaELR8U7TwSV0FF2Pfxk2qyPGcDnxRFBiBrH
WDmcQ/mfk/qO7Jn2Y7Jmf1S4ZMX80ELFfHLEP1nMYk2jIB/77lmBWkAlNvSnc5Ak
+NoINHyO735sVHaHQlEBUBDeWdElsmzDD/dxJTbGpDNWQnQb+xzR5yAYsieLC1o9
JjyQ/Y9NM7471W54jzF3xHwo9tSMIUaPhm2aM66XDsQCGzgzn+h/Ss4LV1lTAPqg
gMU907QtjzkL5/fRBqud80wmVOvkXs++x7GgDX5QCR5qRo1sI0IyXJvUU+AemRBa
fjRg0uBCeu1g7CJOrT8RtMRf9GGvxQ==
=45Q3
-----END PGP SIGNATURE-----

--hunmctkm5vrpq4ne--
