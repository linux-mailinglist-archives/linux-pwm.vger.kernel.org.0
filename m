Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9E8338EC9
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 14:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCLN3D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 08:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCLN2n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 08:28:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18766C061574
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 05:28:43 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKhqL-0000MR-KN; Fri, 12 Mar 2021 14:28:41 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKhqL-0007sw-46; Fri, 12 Mar 2021 14:28:41 +0100
Date:   Fri, 12 Mar 2021 14:28:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: sprd: Refuse requests with unsupported polarity
Message-ID: <20210312132840.ffusege6uat4jpat@pengutronix.de>
References: <20210312085916.386422-1-u.kleine-koenig@pengutronix.de>
 <CAAfSe-uN-U8OqPErRUWmt8CUHGW+8PVZTZN1UACynozzWFA9Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rks4gtm5dw5n4sr4"
Content-Disposition: inline
In-Reply-To: <CAAfSe-uN-U8OqPErRUWmt8CUHGW+8PVZTZN1UACynozzWFA9Rw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rks4gtm5dw5n4sr4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 06:40:52PM +0800, Chunyan Zhang wrote:
> On Fri, 12 Mar 2021 at 16:59, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The driver only supports normal polarity and so should refuse requests
> > for inversed polarity.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-sprd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > index 5123d948efd6..bd6087cfb0b2 100644
> > --- a/drivers/pwm/pwm-sprd.c
> > +++ b/drivers/pwm/pwm-sprd.c
> > @@ -164,6 +164,9 @@ static int sprd_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >         struct pwm_state *cstate =3D &pwm->state;
> >         int ret;
> >
> > +       if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +               return -EINVAL;
>=20
> Should we use EOPNOTSUPP instead?

No, see 2b1c1a5d5148 ("pwm: Use -EINVAL for unsupported polarity").

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rks4gtm5dw5n4sr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBLbIYACgkQwfwUeK3K
7AkL1gf8Dj1VkwaOJhrp4IG5hMbgQ6dHqg/L0G19xp6+nliADHToeJBtadmnMTl+
qUQjfHBP6oCeDHLfyxBAWV1YN3FpH+g6kndbD+KurGCoCMOT6D+vlmOAYIo4Y9HJ
hSV7QopNjvpb7ji/ya7h54DaVaCJKakhd8WmwYlT9o8owLGFp/HVBmoIZJMdhEDo
v7VZMw4KDw7d87X4H6kHi9zlyNmQbzxm31Lg6rpu2PVIpEVu7BzykikEVOFqmK22
/SW9onr3s7YEJYJa6GkV7Z3n6rAwZCPIuhiuMssJ1wHwGdZije2vX8nXf4xSOCgo
C3hjvSC4SnxS8Iq3KWOXfXNDkqeTZA==
=A/bd
-----END PGP SIGNATURE-----

--rks4gtm5dw5n4sr4--
