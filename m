Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E77390A24
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhEYUAj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhEYUAj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 16:00:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248DC061574
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 12:59:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lldCl-0000uy-9E; Tue, 25 May 2021 21:59:07 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lldCk-0008GM-4n; Tue, 25 May 2021 21:59:06 +0200
Date:   Tue, 25 May 2021 21:59:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] pwm: imx27: Don't check the return code of
 pwmchip_remove()
Message-ID: <20210525195905.abybdmfu5zjl7sc3@pengutronix.de>
References: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
 <20210324152058.69022-3-u.kleine-koenig@pengutronix.de>
 <YHBB1HrlQ/DMiey7@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ujfyxtsagvq6kud"
Content-Disposition: inline
In-Reply-To: <YHBB1HrlQ/DMiey7@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2ujfyxtsagvq6kud
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Apr 09, 2021 at 02:00:20PM +0200, Thierry Reding wrote:
> On Wed, Mar 24, 2021 at 04:20:58PM +0100, Uwe Kleine-K=F6nig wrote:
> > pwmchip_remove() always returns 0. Don't use the value to make it
> > possible to eventually change the function to return void. This is a
> > good thing as pwmchip_remove() is usually called from a remove function
> > (mostly for platform devices) and their return value is ignored by the
> > device core anyhow.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-imx27.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> It's true that there's not much we can do upon failure, so failing
> doesn't make much sense and therefore returning an error doesn't make
> sense. So how about we WARN on the -EBUSY case instead of returning an
> error? That should have an even higher impact than an error that's being
> silently ignored.

After patch 1 in this series (or the reworked version from
https://lore.kernel.org/r/20210423165902.2439564-1-u.kleine-koenig@pengutro=
nix.de)
pwmchip_remove() really always returns 0, so adding a WARN in the imx27
(or any other) driver doesn't make much sense.

It might make sense to add such a WARN in pwmchip_remove(), is it that
what you intended to suggest?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2ujfyxtsagvq6kud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCtVwUACgkQwfwUeK3K
7AkdOQf/ZWoL18Wri6HeDXXE8pvjN6nOoYIrhbn3TQpepoG0flFuI27a4y/UqE05
pkWy6PW72/F07BZfnb2yIPN4sZjHh6nMNXIzUB4K0qog8SUvtqtFYfNw4lLmqqn4
aNS1IAluu9fEfyLUb9CZtIIdkZw9KMuhD3FL4t2H9n48zwfR+R39jZJmmbh92JfK
XCDC5rJyDSmQvvxWM1L3wBiYK7e44F2jJ9A7wy+R1CvPgG4gURFrS1zR++nQUIt8
wro+PLFcCT/VX7mDDLz/QZClWd9Ks2auh5yQnQiMPnKYtv4dHYEq1aDBJYU1ZRjG
0Jdkol4CEL4RJ3/xx4RO9bPS8TCC0A==
=E2KI
-----END PGP SIGNATURE-----

--2ujfyxtsagvq6kud--
