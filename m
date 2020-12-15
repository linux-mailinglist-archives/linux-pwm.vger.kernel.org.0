Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96DD2DAD92
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgLOM4y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 07:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgLOM4s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Dec 2020 07:56:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A978C0617A6
        for <linux-pwm@vger.kernel.org>; Tue, 15 Dec 2020 04:56:08 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kp9s6-0004pL-Dx; Tue, 15 Dec 2020 13:56:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kp9s4-0005e9-6b; Tue, 15 Dec 2020 13:56:04 +0100
Date:   Tue, 15 Dec 2020 13:56:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Barker <pbarker@konsulko.com>
Cc:     linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Ensure that calculation doesn't
 discard big period values
Message-ID: <20201215125604.iygkycrlxmkq5kzx@pengutronix.de>
References: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
 <CAM9ZRVt1wRUuGSniDvS2PME=O-Y3YtVHgTh27qn5Dkj_kUc3AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2uwuptwb7ryc6kmr"
Content-Disposition: inline
In-Reply-To: <CAM9ZRVt1wRUuGSniDvS2PME=O-Y3YtVHgTh27qn5Dkj_kUc3AQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2uwuptwb7ryc6kmr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2020 at 11:29:39AM +0000, Paul Barker wrote:
> On Tue, 15 Dec 2020 at 09:23, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > With MAX_PWM being defined to 255 the code
> >
> >         unsigned long period;
> >         ...
> >         period =3D ctx->pwm->args.period;
> >         state.duty_cycle =3D DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
>=20
> Reviewing this I noticed that in pwm_fan_resume() we use
> DIV_ROUND_UP_ULL for what looks like essentially the same calculation.

After my second patch this isn't true any more. With it applied
__set_pwm is the only place in the driver that calculates this stuff.

> Could we just switch this line to DIV_ROUND_UP_ULL instead?

Yes that would work, but actually I don't expect someone specifiying a
period big enough to justify the additional overhead of a 64 bit
division.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2uwuptwb7ryc6kmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/YsmAACgkQwfwUeK3K
7AkhvAgAmAAHDLedS50W9mpbLyngbPASUmJQkUSIaCIPnUSDs6G/Xa3Whk9whCYu
+xwNNbK2EVCSXPKX8Ds1unhan58sq5hc3q4l4Aof5V9qEgKJLTOlkws+I+xWEBBU
yPHROHc5dVU5PvuG0cxGetLpSnD3iC38X3Lb9nAsYAZ29tjSaOEDO6VFMxj3w3AH
I/BqDHP0PJP0wpmSKg12CRyyzG4A7H3exHJjQ4pUfsnQQ5kQJ6M/nVQoTC89xJG+
2M5zybQ6P5PSCLDroqYWD+sdO5f8/7XRXjrSmO8/AfdLtTGBRYHb4bYpYMSsP154
6cH2E/UdJSfrLgWqC6Y+zsOU8SM/FA==
=vkFM
-----END PGP SIGNATURE-----

--2uwuptwb7ryc6kmr--
