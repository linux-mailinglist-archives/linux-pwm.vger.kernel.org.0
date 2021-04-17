Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D70E363221
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 21:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbhDQT7r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 15:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbhDQT7r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 15:59:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E0C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 12:59:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXr66-0007P9-O0; Sat, 17 Apr 2021 21:59:18 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXr66-0003XK-CT; Sat, 17 Apr 2021 21:59:18 +0200
Date:   Sat, 17 Apr 2021 21:59:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 8/8] pwm: pca9685: Add error messages for failed
 regmap calls
Message-ID: <20210417195918.i4ugym3busamymtl@pengutronix.de>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
 <20210415121455.39536-8-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vpfteztswegvpk7m"
Content-Disposition: inline
In-Reply-To: <20210415121455.39536-8-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vpfteztswegvpk7m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 02:14:55PM +0200, Clemens Gruber wrote:
> Regmap operations can fail if the underlying subsystem is not working
> properly (e.g. hogged I2C bus, etc.)
> As this is useful information for the user, print an error message if it
> happens.
> Let probe fail if the first regmap_read or the first regmap_write fails.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vpfteztswegvpk7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7PhIACgkQwfwUeK3K
7Amz8wf9H+ets8pXp0ZaXVDhobF/LbaLnPgzRIIN5R6LKyP0dZZ8ZHo/XjoPzB73
bsyxK0fhwbakNoMxrw86mcS/+vOV0R93BLb4p4qIVo9myEM2xQwWFfvcKvqyyED5
AI6nLpDYk6knguJZbIpMUEQeE48DXAra6BENdD4idTcMgF5hSb1oCW3SddZsAV3m
78M8YPgPbfazURIQ3Hvt9H6rCYpp+HrPsDXAWVrX2AI9fUSW0TaAEYZcrbaKK0KF
7ju801s60JgND0+3fFCjVIHBAH2P6jozUI70aAn4FpbEgGinYhnvRT6tUFyig9Vz
d4yIKAdWn3iec+HjtHG90IiMDzInrQ==
=w+wf
-----END PGP SIGNATURE-----

--vpfteztswegvpk7m--
