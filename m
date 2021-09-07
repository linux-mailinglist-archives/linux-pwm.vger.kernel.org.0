Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EBD402748
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Sep 2021 12:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhIGKht (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Sep 2021 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343582AbhIGKhs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Sep 2021 06:37:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BBC061575
        for <linux-pwm@vger.kernel.org>; Tue,  7 Sep 2021 03:36:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNYT2-0000mM-Cu; Tue, 07 Sep 2021 12:36:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNYT1-00019N-FE; Tue, 07 Sep 2021 12:36:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNYT1-0007Z7-Du; Tue, 07 Sep 2021 12:36:39 +0200
Date:   Tue, 7 Sep 2021 12:36:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] pwm: Prevent a glitch for legacy drivers
Message-ID: <20210907103639.lfxjk3tzoygnv4yj@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <20210701072927.328254-3-u.kleine-koenig@pengutronix.de>
 <YR5eWvpEaLxgdWxD@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2cumbucfz3tea2mz"
Content-Disposition: inline
In-Reply-To: <YR5eWvpEaLxgdWxD@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2cumbucfz3tea2mz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Aug 19, 2021 at 03:36:26PM +0200, Thierry Reding wrote:
> On Thu, Jul 01, 2021 at 09:29:26AM +0200, Uwe Kleine-K=F6nig wrote:
> > If a running PWM is reconfigured to disabled calling the ->config()
> > callback before disabling the hardware might result in a glitch where
> > the (maybe) new period and duty_cycle are visible on the output before
> > disabling the hardware.
> >=20
> > So handle disabling before calling ->config(). Also exit early in this =
case
> > which is possible because period and duty_cycle don't matter for disabl=
ed PWMs.
> > In return however ->config has to be called even if state->period =3D=3D
> > pwm->state.period && state->duty_cycle !=3D pwm->state.duty_cycle becau=
se setting
> > these might have been skipped in the previous call.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 41 ++++++++++++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 3c72f8963073..20afe6d0bc5e 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -568,26 +568,33 @@ static int pwm_apply_legacy(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  		pwm->state.polarity =3D state->polarity;
> >  	}
> > =20
> > -	if (state->period !=3D pwm->state.period ||
> > -	    state->duty_cycle !=3D pwm->state.duty_cycle) {
> > -		err =3D chip->ops->config(pwm->chip, pwm,
> > -					state->duty_cycle,
> > -					state->period);
> > -		if (err)
> > -			return err;
> > +	if (!state->enabled) {
> > +		if (pwm->state.enabled)
> > +			chip->ops->disable(chip, pwm);
> > =20
> > -		pwm->state.period =3D state->period;
> > -		pwm->state.duty_cycle =3D state->duty_cycle;
> > +		return 0;
> >  	}
> > =20
> > -	if (state->enabled !=3D pwm->state.enabled) {
> > -		if (!pwm->state.enabled) {
> > -			err =3D chip->ops->enable(chip, pwm);
> > -			if (err)
> > -				return err;
> > -		} else {
> > -			chip->ops->disable(chip, pwm);
> > -		}
> > +	/*
> > +	 * We cannot skip calling ->config even if state->period =3D=3D
> > +	 * pwm->state.period && state->duty_cycle =3D=3D pwm->state.duty_cycle
> > +	 * because we might have exited early in the last call to
> > +	 * pwm_apply_state because of !state->enabled and so the two values in
> > +	 * pwm->state might not be configured in hardware.
> > +	 */
> > +	err =3D chip->ops->config(pwm->chip, pwm,
> > +				state->duty_cycle,
> > +				state->period);
> > +	if (err)
> > +		return err;
> > +
> > +	pwm->state.period =3D state->period;
> > +	pwm->state.duty_cycle =3D state->duty_cycle;
> > +
> > +	if (!pwm->state.enabled) {
> > +		err =3D chip->ops->enable(chip, pwm);
> > +		if (err)
> > +			return err;
> >  	}
>=20
> I thought we might have discussed this, but I can't find any record of
> it. How is this better than always configuring, whether the PWM is
> disabled or not?

The question is: Should we call .config() if state->enabled is false,
right?

> From an atomic point of view, the hardware state is expected to match
> the PWM state that was passed to ->apply() after it returns. That means
> that calling ->get_state() after ->apply() should return the same state
> that was passed to ->apply(). With the above that's no longer true. It
> doesn't actually matter, because legacy drivers don't support
> ->get_state(), but conceptually it's not mimicking the atomic API as
> well as it could.

In my book the value of .period and .duty_cycle is irrelevant when
state->enabled is false as it has no effect on the actual behaviour of
the hardware. And then calling .config() with all the calculations that
are done there just to have the values stored in hardware doesn't make
much sense for me. Still more because this isn't possible for all
hardwares as not all support the concept of "disabled" and have to
simulate it using .duty_cycle =3D 0.

For me it is ok to deviate here, callers of .get_state() have to be
aware of other hardware induced deviations anyhow. If having a match
here is really wanted, then I suggest to fixup in the framework instead
of adapting all drivers (if and when we will have a consumer reachable
function that makes use of .get_state()). So for example do something
like:

	ret =3D chip->ops->get_state(..., &state);
	if (ret)
		return ret;

	/* Normalize */
	if (!state->enabled) {
		state->period =3D pwm->state->period;
		state->duty_cycle =3D pwm->state->duty_cycle;
	}

but also assigning 0 instead of pwm->state->{period,duty_cycle} would
work for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2cumbucfz3tea2mz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE3QLMACgkQwfwUeK3K
7AnMIQf+IObw5bdflzxbrI5q7dUQ+4rFSNjIf5XrWDatmpWCC7XLIxCC4r2I3zSs
7ED9vhaZKkH0BGfmBop0fFz5odBdbIR+wUbdN+nj9ibEBGxrM7xeDqktqZ3Vu+ki
7IKa8fRbonM9yWfbdDo9P4TRKCCTmF7aTUiKkJfBA2dbskuvFrSXbv6hGZcjUqMV
f+EfuKVzSb98wOlaqCDUDS3ATHYa9iL2M7XSjzGU/DadIx8igAJHM6OstJbKf83U
2Zj2MJ2FpebcE9bJh13ZTYi3N3/HPZJCEtgxPMOgYNZD6VLo3RQUhvMcsb6MHGMI
/rRKUBGOCFG/LSwHk+g1zEDX71Bc/g==
=/mnD
-----END PGP SIGNATURE-----

--2cumbucfz3tea2mz--
