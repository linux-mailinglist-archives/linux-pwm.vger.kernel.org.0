Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE235B09F
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 23:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDJVrA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 17:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhDJVrA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 17:47:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B9C06138A
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 14:46:44 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVLRD-00064G-8r; Sat, 10 Apr 2021 23:46:43 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVLRC-0000IV-Dd; Sat, 10 Apr 2021 23:46:42 +0200
Date:   Sat, 10 Apr 2021 23:46:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Prevent a glitch in compat code
Message-ID: <20210410214642.nh2c4jhxbcqd7jxt@pengutronix.de>
References: <20210308093600.25455-1-u.kleine-koenig@pengutronix.de>
 <YFh47dFLmWqZHvz7@orome.fritz.box>
 <20210322111131.w2c6lj6m2vw7socw@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zlhjpga6sdwk2jge"
Content-Disposition: inline
In-Reply-To: <20210322111131.w2c6lj6m2vw7socw@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zlhjpga6sdwk2jge
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 12:11:31PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Mar 22, 2021 at 12:01:01PM +0100, Thierry Reding wrote:
> > On Mon, Mar 08, 2021 at 10:36:00AM +0100, Uwe Kleine-K=F6nig wrote:
> > > When a PWM is to be disabled, configuring the duty cycle and
> > > period before actually disabling the hardware might result in either a
> > > glitch or a delay. So check for disabling first and return early in t=
his
> > > case.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/core.c | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 4058d3c86a45..4604ca3e0e62 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -597,6 +597,12 @@ int pwm_apply_state(struct pwm_device *pwm, cons=
t struct pwm_state *state)
> > >  			pwm->state.polarity =3D state->polarity;
> > >  		}
> > > =20
> > > +		if (!state->enabled && pwm->state.enabled) {
> > > +			chip->ops->disable(chip, pwm);
> > > +			pwm->state.enabled =3D false;
> > > +			return 0;
> >=20
> > I don't think we can return early here because otherwise if consumers
> > happen to modify the period along with the enabled state, the changes
> > to the period will get lost.
>=20
> This however doesn't matter, because the output of a disabled PWM only
> depends on polarity. (And polarity is already cared for.)
>=20
> And if a driver calls pwm_enable() afterwards (or the equivalent in
> terms of pwm_apply_state) the period and duty_cycle will be picked up
> correctly.

I see you marked my patch as "changes requested" in patchwork. However
I'm convinced your feedback is wrong and so I still think the patch
is safe to be applied unmodified.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zlhjpga6sdwk2jge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmByHL8ACgkQwfwUeK3K
7Al4kAf9GiVTeJgyIIkwvtP8/pzYA+4qR0dX90JpJ3rcxLjakQSBVb6CbH0329/H
i0j4JkUMAGUl2/TI1RNBjJBdt30MyD0xn1D8/JgbKpyFyezeLUHTPXJYMZfSTjPI
lZJm0oqi1JwOnanrOlZEWl0Y7casv5z+3lx1MnXkArJ+uFwRgH9OHsPHh32CLWfy
PFVLkOBa00tgVEwxT1zpqaqeG2jo6gGJXhLe23lsqYeWJUaAc1eQ20GSskYlRxaI
aDCHBHovJUDSO2DMrv18q7irfuyVRVs3KlijXfuZ6ju+OiOaq8eL3PKHXFFPiO9f
iU0tmRxm5DkW7iFti77fXIC5YaPd1Q==
=3996
-----END PGP SIGNATURE-----

--zlhjpga6sdwk2jge--
