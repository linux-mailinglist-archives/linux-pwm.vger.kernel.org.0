Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9452DD060
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 12:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgLQLcG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Dec 2020 06:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQLcF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Dec 2020 06:32:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9490EC061794
        for <linux-pwm@vger.kernel.org>; Thu, 17 Dec 2020 03:31:25 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kprVE-0008D1-71; Thu, 17 Dec 2020 12:31:24 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kprVD-0005gJ-5q; Thu, 17 Dec 2020 12:31:23 +0100
Date:   Thu, 17 Dec 2020 12:31:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Taras Galchenko <tpgalchenko@gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Remove erroneous else branch
Message-ID: <20201217113123.v3jialznqipzerne@pengutronix.de>
References: <20201216174309.1604658-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="npdnodtypsgqri4v"
Content-Disposition: inline
In-Reply-To: <20201216174309.1604658-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--npdnodtypsgqri4v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2020 at 06:43:09PM +0100, Thierry Reding wrote:
> Commit d3817a647059 ("pwm: sun4i: Remove redundant needs_delay") changed
> the logic of an else branch so that the PWM_EN and PWM_CLK_GATING bits
> are now cleared if the PWM is to be disabled, whereas previously the
> condition was always false, and hence the branch never got executed.
>=20
> This code is reported causing backlight issues on boards based on the
> Allwinner A20 SoC. Fix this by removing the else branch, which restores
> the behaviour prior to the offending commit.
>=20
> Note that the PWM_EN and PWM_CLK_GATING bits still get cleared later in
> sun4i_pwm_apply() if the PWM is to be disabled.
>=20
> Fixes: d3817a647059 ("pwm: sun4i: Remove redundant needs_delay")
> Reported-by: Taras Galchenko <tpgalchenko@gmail.com>

This report didn't happen on the linux-pwm list, or did I miss it?

What is the reported problem? I would expect a short time where the
backlight goes off completely (or on depending on polarity?) when only a
small continuous change is expected.

> Suggested-by: Taras Galchenko <tpgalchenko@gmail.com>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--npdnodtypsgqri4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/bQYcACgkQwfwUeK3K
7Ak2aQf9HK46ebYfhKBYjQ/2avufYy/sYB8fXyzidHIFvGk+DjpXnLQuCpjUa6QG
wUjbI6rNp8Pg+Tl3oWwQvEZVXvxaH2LcWd/p7wW87z2ibQpqiDQaac6xkgOrscBC
CfYcfqCnnQN0m7hUFYjotBV+TkToi/JT7xjNRV7PuLL4FgaGJyB69dzNvJ3F4z6j
nZgbLFbycENyw064bOZ8S2HaclDWdJluJ91Xi4FCvThvNnoDyztc+vjBi+oIASos
wnhTWzFKWnBIzAoVZ10odPhBbgKMisrmgMCEDfhJgdgh5fl+P930X2Ae6K5ZjPOJ
MgjLFEllUPPiA1UV1UvCI4DWaTqkAw==
=lv9D
-----END PGP SIGNATURE-----

--npdnodtypsgqri4v--
