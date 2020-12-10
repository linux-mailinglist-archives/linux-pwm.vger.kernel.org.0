Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF72D5B12
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 14:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgLJM7A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 07:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732630AbgLJM6u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 07:58:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC05C0613CF
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 04:58:09 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knLWE-00063I-Pt; Thu, 10 Dec 2020 13:58:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knLWD-0004ic-4E; Thu, 10 Dec 2020 13:58:01 +0100
Date:   Thu, 10 Dec 2020 13:58:00 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sean@mess.org, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201210125800.gj4f4rioq7df4hbl@pengutronix.de>
References: <1607546905-20549-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6tvo3blcdefqpmbe"
Content-Disposition: inline
In-Reply-To: <1607546905-20549-1-git-send-email-LinoSanfilippo@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6tvo3blcdefqpmbe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 09:48:25PM +0100, Lino Sanfilippo wrote:
> Use the newer .apply function of pwm_ops instead of .config, .enable,
> .disable and .set_polarity. This guarantees atomic changes of the pwm
> controller configuration. It also reduces the size of the driver.
>=20
> Since now period is a 64 bit value, add an extra check to reject periods
> that exceed the possible max value for the 32 bit register.
>=20
> This has been tested on a Raspberry PI 4.
>=20
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

I replied to v3 earlier, this was supposed to go to this v4 of course.
Still had v3 open for comparing the two. So to ensure it is picked up:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6tvo3blcdefqpmbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/SG1UACgkQwfwUeK3K
7AlHQQf/Vw6TeRvt4v1Bz3mRlclNw2+/Tcu0VHY8orK2+FYUzUZ4c1ywNmdycxsQ
9FSssC5fW3kLq1rTZnXe0m2dcvj1whY6PIprRo+BSrS5gmF7uc5py5NjstFxA0Z6
aSgMu/L6irP/g8dQUFvzMzSMEhCmqSVqOKGwFGKsMxGbzbp5J6peztQJp0/CxtQo
1G2GGbVKtSnGQsAgO3x3ePXrUj11J9UHtTOSJFDIwIp/DWjm1zatDK4yEsjI2NU1
tdpv2fFpUe/CUfpNqLW31ZJrez8QkJic1LGQ4b/FVbD3LOUQEw7zjDFpGr7XQ5un
xnlbU/YWSJmZ7I77pfLgiZzu2w2iOg==
=DB1h
-----END PGP SIGNATURE-----

--6tvo3blcdefqpmbe--
