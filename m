Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615AC23E07B
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 20:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHFSex (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHFSe2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 14:34:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF0C06138E
        for <linux-pwm@vger.kernel.org>; Thu,  6 Aug 2020 11:34:18 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3kiN-00043O-ME; Thu, 06 Aug 2020 20:34:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3kiM-0007Yl-En; Thu, 06 Aug 2020 20:34:06 +0200
Date:   Thu, 6 Aug 2020 20:34:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] pwm: cros-ec: Simplify EC error handling
Message-ID: <20200806183406.avejgcuxaolea2pz@pengutronix.de>
References: <20200806153308.204605-1-linux@roeck-us.net>
 <20200806153308.204605-8-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yaf2rliyowjjwr36"
Content-Disposition: inline
In-Reply-To: <20200806153308.204605-8-linux@roeck-us.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yaf2rliyowjjwr36
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 08:33:08AM -0700, Guenter Roeck wrote:
> With enhanced error reporting from cros_ec_cmd_xfer_status() in place,
> we can fully use it and no longer rely on EC error codes.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yaf2rliyowjjwr36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8sTRsACgkQwfwUeK3K
7AljKgf+NqWAUswdLzLgjqhYVOCid4+Uol5gqvLd1PWPzFcBLjYn4qhp9zCcu9IJ
AzY555m9cXLChHqkEScDlUleoaOE0SjOlW4eabwKO3BakLm5S+xaiu1ak7RcxW8O
Bz9qlW1S+9lAm+fG5jxdHnJkk9RJ5isJQl7s0XdzDYvACgGjh5oLHnm5pjbwH+Gk
u8tFgy0xLsm6MdURY7gEaIveEUiD4Pcn+Kh13Z3RArmF5hJqoRFi0qxxszaQyZF4
p2FozkPNOBxKOVr1hKtXQqU/q0yrFWh4Wlokh+POqnNiS5U9uO1+i/r563VbKJyZ
5PtUqpdOjmjZR0c+LuqFEHYBaDr8vg==
=AiFP
-----END PGP SIGNATURE-----

--yaf2rliyowjjwr36--
