Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2B35B0A3
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDJV4Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 17:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhDJV4Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 17:56:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7735EC06138A
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 14:56:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVLaK-0006iG-R0; Sat, 10 Apr 2021 23:56:08 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVLaJ-0000aJ-3o; Sat, 10 Apr 2021 23:56:07 +0200
Date:   Sat, 10 Apr 2021 23:56:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/2] pwm: Drop unused error path from pwmchip_remove()
Message-ID: <20210410215606.hrdfjqygeoexhzbt@pengutronix.de>
References: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
 <20210324152058.69022-2-u.kleine-koenig@pengutronix.de>
 <YHBBOrhHqFdN2QxV@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j66dtzl53sm4ft4z"
Content-Disposition: inline
In-Reply-To: <YHBBOrhHqFdN2QxV@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--j66dtzl53sm4ft4z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 01:57:46PM +0200, Thierry Reding wrote:
> On Wed, Mar 24, 2021 at 04:20:57PM +0100, Uwe Kleine-K=F6nig wrote:
> > Since the pwm core uses device links (commit b2c200e3f2fd ("pwm: Add
> > consumer device link")) it cannot happen any more that there is still a
> > consumer when a pwmchip goes away. So drop this check.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 16 ++--------------
> >  1 file changed, 2 insertions(+), 14 deletions(-)
>=20
> Can't this still happen when a consumer forgets to pwm_put() the PWM?

The change is still good, and a more correct change log would be:

	Since the pwm core uses device links (commit b2c200e3f2fd ("pwm: Add
	consumer device link")) each consumer driver that requested the PWMs is
	already gone. If they called pwm_put() (as they should) the
	PWMF_REQUESTED bit is not set. If they failed (which is a bug) the
	PWMF_REQUESTED bit is still set, but the driver that cared is still
	gone, so nothing bad happens if the pwmchip goes away anyhow.

	So the check can be dropped.

Does this sound better?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j66dtzl53sm4ft4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmByHvMACgkQwfwUeK3K
7AnaOgf7BDzewUqOPVDy2/uTbRW16l+Stg93lFhAgggtK7qWyhnqPeUBGxMtwJfM
CWzNXSxyKRpScYkLjnL/f5jKFadBavO7j1JPJoz9OvCdq1bKpJdXJafsJVNIaHFq
Hb9bmh/w0ZzPKp7h51V8a+R7hKBApWU19vcsun+KcYmH+6rFC5XGkHBddX3BJP+9
mnd8vn8wYfEqoq8gFg5dCk4PaYtwmv50RdLqJeNxQ2zftZt0JYBNejNAP6nkqccn
ue+8DBJys6di0Ea1hverye/xiL0+g8dqD17BeqRniTE5kUZfhug07Nky9HsFgJu/
F2vVS33j2IkKnrbsXhZsHOCUGT6N8g==
=PsYk
-----END PGP SIGNATURE-----

--j66dtzl53sm4ft4z--
