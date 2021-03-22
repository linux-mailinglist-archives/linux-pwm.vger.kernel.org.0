Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72E343F50
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCVLMK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhCVLLe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:11:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE3C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:11:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIT5-000475-Uw; Mon, 22 Mar 2021 12:11:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIT5-0008C4-6Y; Mon, 22 Mar 2021 12:11:31 +0100
Date:   Mon, 22 Mar 2021 12:11:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Prevent a glitch in compat code
Message-ID: <20210322111131.w2c6lj6m2vw7socw@pengutronix.de>
References: <20210308093600.25455-1-u.kleine-koenig@pengutronix.de>
 <YFh47dFLmWqZHvz7@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g6sjvpyd6exp2eje"
Content-Disposition: inline
In-Reply-To: <YFh47dFLmWqZHvz7@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g6sjvpyd6exp2eje
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 12:01:01PM +0100, Thierry Reding wrote:
> On Mon, Mar 08, 2021 at 10:36:00AM +0100, Uwe Kleine-K=F6nig wrote:
> > When a PWM is to be disabled, configuring the duty cycle and
> > period before actually disabling the hardware might result in either a
> > glitch or a delay. So check for disabling first and return early in this
> > case.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 4058d3c86a45..4604ca3e0e62 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -597,6 +597,12 @@ int pwm_apply_state(struct pwm_device *pwm, const =
struct pwm_state *state)
> >  			pwm->state.polarity =3D state->polarity;
> >  		}
> > =20
> > +		if (!state->enabled && pwm->state.enabled) {
> > +			chip->ops->disable(chip, pwm);
> > +			pwm->state.enabled =3D false;
> > +			return 0;
>=20
> I don't think we can return early here because otherwise if consumers
> happen to modify the period along with the enabled state, the changes
> to the period will get lost.

This however doesn't matter, because the output of a disabled PWM only
depends on polarity. (And polarity is already cared for.)

And if a driver calls pwm_enable() afterwards (or the equivalent in
terms of pwm_apply_state) the period and duty_cycle will be picked up
correctly.

> Can we just omit the "return 0;" here?

>=20
> > +		}
> > +
> >  		if (state->period !=3D pwm->state.period ||
> >  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> >  			int duty_cycle, period;
> > @@ -620,16 +626,12 @@ int pwm_apply_state(struct pwm_device *pwm, const=
 struct pwm_state *state)
> >  			pwm->state.period =3D state->period;
> >  		}
> > =20
> > -		if (state->enabled !=3D pwm->state.enabled) {
> > -			if (state->enabled) {
> > -				err =3D chip->ops->enable(chip, pwm);
> > -				if (err)
> > -					return err;
> > -			} else {
> > -				chip->ops->disable(chip, pwm);
> > -			}
> > +		if (!pwm->state.enabled) {
>=20
> If we don't return early above, we'll have to change this here as well
> to ensure we don't gratuituously enable the PWM. Instead this would
> basically become the inverse of what we do for disable above, which is
> also nicely symmetrical (i.e. disable, then change period/duty to avoid
> a glitch and change period/duty then enable to avoid the glitch).

Either I don't understand you, or we're already there.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g6sjvpyd6exp2eje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYe2AACgkQwfwUeK3K
7AmzFwgAlcqR+Y16Tw6JXbR6XD6sp8T6wJ7KJwvtV6gjLsH9LWAI9AMry7WTb4Oc
dmW4Rmb5Iv5JEjCbxbpZ8fXwcSwHo2UNBuljtFQUm8R5peCoqRtDz0WPI/athCtB
TOYwEXw/jylK01sRl6d3Pudd0o9e8KAmdN2paF+Qv9O+Bmslx9B/+7yJHva64jvj
chFOEWTNVG5ZfyGu/CJTRktDiVje7KXoOs/QYvnvV4bpBhaPsm5XrsUbg6RAcoDE
QaS+UOyuz0jTk+r+8U2zSjUmxSguUGZMovJBv2KX8NuA8SmjAspxqGybH/HHT1ug
mQghc5RrLP1OB1bGu5uNnyI5TbSVaw==
=Ca9V
-----END PGP SIGNATURE-----

--g6sjvpyd6exp2eje--
