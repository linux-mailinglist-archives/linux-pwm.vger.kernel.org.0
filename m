Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1D3B7D52
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhF3GVC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 02:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhF3GVB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 02:21:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D0C061766
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jun 2021 23:18:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyTYL-0008Mr-Uu; Wed, 30 Jun 2021 08:18:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyTYK-0004dv-4G; Wed, 30 Jun 2021 08:18:28 +0200
Date:   Wed, 30 Jun 2021 08:18:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jisheng Zhang <jszhang@marvell.com>, linux-pwm@vger.kernel.org,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: berlin: Put channel config into driver data
Message-ID: <20210630061804.2qrsqbd4xl7wtunh@pengutronix.de>
References: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
 <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxdlk4pqb5e5zd37"
Content-Disposition: inline
In-Reply-To: <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sxdlk4pqb5e5zd37
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, May 04, 2021 at 03:25:35PM +0200, Uwe Kleine-K=F6nig wrote:
> Instead of allocating extra data in .request() provide the needed memory
> in struct berlin_pwm_chip. This reduces the number of allocations. A side
> effect is that on suspend and resume the state for all four channels is
> always saved and restored. This is easier (and probably quicker) than
> looking up the matching pwm_device and checking its PWMF_REQUESTED bit.

I noticed you applied the other three patches in this series, but
skipped this one and marked it as rejected.

Please point out what you don't like about this patch instead of just
dropping it without comment.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sxdlk4pqb5e5zd37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDcDJUACgkQwfwUeK3K
7AkNqgf+LyHbca3L4VFOMk3dZ9Xvz3k0WXVWGoV4e6vCBQp/MCVG4DWwInWw31m+
/nz/+L9VTsQkTIyWn9hPaLBBh/cYJ1yhrw6wrTqkz4/cvZjkkzWacJX+1j4RYqqu
V8qIdn5i1zyKYtYQNZvkrh/QzPSWNify+U7QHTDOaximBkKyJcvtuvHjHqn+x3/W
GPIp9TbXKcuWInD9dam9s3JzxlFGrA9rTb9mGP/4sXC7lt9FR84hvVdqCpoHDq5O
pkS6QOyPXRLlPMsu/RGMEzps4mNPwZDkferRuIQMA3fbv7HAaoAZ/kB2qCgJJcnw
+BYBvtOckGYY+jofJxRdm26voSji7Q==
=Nkej
-----END PGP SIGNATURE-----

--sxdlk4pqb5e5zd37--
