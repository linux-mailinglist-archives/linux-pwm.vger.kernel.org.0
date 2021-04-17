Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626236321D
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhDQT7R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 15:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhDQT7Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 15:59:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03858C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 12:58:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXr5c-0007OM-5F; Sat, 17 Apr 2021 21:58:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXr5b-0003Wv-Rt; Sat, 17 Apr 2021 21:58:47 +0200
Date:   Sat, 17 Apr 2021 21:58:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/8] pwm: pca9685: Restrict period change for enabled
 PWMs
Message-ID: <20210417195847.ejhzoh34dqtroq2p@pengutronix.de>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
 <20210415121455.39536-7-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zslt6uzl2w3dgpsx"
Content-Disposition: inline
In-Reply-To: <20210415121455.39536-7-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zslt6uzl2w3dgpsx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 02:14:54PM +0200, Clemens Gruber wrote:
> Previously, the last used PWM channel could change the global prescale
> setting, even if other channels are already in use.
>=20
> Fix it by only allowing the first enabled PWM to change the global
> chip-wide prescale setting. If there is more than one channel in use,
> the prescale settings resulting from the chosen periods must match.
>=20
> GPIOs do not count as enabled PWMs as they are not using the prescaler
> and can't change it.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zslt6uzl2w3dgpsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7PfQACgkQwfwUeK3K
7AnbWgf+Kn7ggz++9uixZgHv9L5JqCQ9rKu3vVNBo+MgemkQv2Crr50rOG2p1t+e
2tMxIbOysuIQbWzHugTr+FDoXKu0O2UAgti5HDaWHxdUKaPScespf6Rw+cElPUAh
kX6Oss/MOwEBtp3JiW7s0LMcpuC+S+xisJBD8iJVmliJH8U773pERvjRwkGe/zVx
uqWllDFYLEH4bKNK6WHlE7uuxp2+L/WziGy6gYlNGaSQkPgT2aPRlXf5dgTzg+Mc
UusGEFXNlat/SViLZ++Gm56W6Vi03GX9oSJLANYiZ3QhATxbGRh0iDDZshdBg0vN
VM+9xVXRW8/0q+AhZx+WVigtXHV0SQ==
=quLN
-----END PGP SIGNATURE-----

--zslt6uzl2w3dgpsx--
