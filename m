Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AACE40274D
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Sep 2021 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbhIGKml (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Sep 2021 06:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhIGKmk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Sep 2021 06:42:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA3C061575
        for <linux-pwm@vger.kernel.org>; Tue,  7 Sep 2021 03:41:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNYXk-0001HO-PG; Tue, 07 Sep 2021 12:41:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNYXj-0001A1-UA; Tue, 07 Sep 2021 12:41:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNYXj-0007a2-TE; Tue, 07 Sep 2021 12:41:31 +0200
Date:   Tue, 7 Sep 2021 12:41:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] pwm: Restore initial state if a legacy callback fails
Message-ID: <20210907104131.5ngowf3lmbehy4ni@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <20210701072927.328254-4-u.kleine-koenig@pengutronix.de>
 <YR5cf+UIpc3lLotK@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wuurxkktiq23hfbz"
Content-Disposition: inline
In-Reply-To: <YR5cf+UIpc3lLotK@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wuurxkktiq23hfbz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 03:28:31PM +0200, Thierry Reding wrote:
> On Thu, Jul 01, 2021 at 09:29:27AM +0200, Uwe Kleine-K=F6nig wrote:
> > It is not entirely accurate to go back to the initial state after e.g.
> > .enable() failed, as .config() still modified the hardware, but this sa=
me
> > inconsistency exists for drivers that implement .apply().
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 20afe6d0bc5e..6e30ef9b9b79 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -539,10 +539,8 @@ static int pwm_apply_legacy(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >  			    const struct pwm_state *state)
> >  {
> >  	int err;
> > +	struct pwm_state initial_state =3D pwm->state;
> > =20
> > -	/*
> > -	 * FIXME: restore the initial state in case of error.
> > -	 */
> >  	if (state->polarity !=3D pwm->state.polarity) {
> >  		if (!chip->ops->set_polarity)
> >  			return -EINVAL;
> > @@ -563,7 +561,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, =
struct pwm_device *pwm,
> > =20
> >  		err =3D chip->ops->set_polarity(chip, pwm, state->polarity);
> >  		if (err)
> > -			return err;
> > +			goto rollback;
> > =20
> >  		pwm->state.polarity =3D state->polarity;
> >  	}
> > @@ -586,7 +584,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  				state->duty_cycle,
> >  				state->period);
> >  	if (err)
> > -		return err;
> > +		goto rollback;
> > =20
> >  	pwm->state.period =3D state->period;
> >  	pwm->state.duty_cycle =3D state->duty_cycle;
> > @@ -594,10 +592,14 @@ static int pwm_apply_legacy(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  	if (!pwm->state.enabled) {
> >  		err =3D chip->ops->enable(chip, pwm);
> >  		if (err)
> > -			return err;
> > +			goto rollback;
> >  	}
> > =20
> >  	return 0;
> > +
> > +rollback:
> > +	pwm->state =3D initial_state;
> > +	return err;
> >  }
>=20
> Can't we achieve the same thing by just removing all the updates to
> pwm->state in pwm_apply_legacy()? Patch 1 in the series now does
> pwm->state =3D *state for both the atomic and the legacy cases, so if
> we don't update pwm->state explicitly in pwm_apply_legacy(), then
> there should be no need to rollback, right?

No, this doesn't work because the implemention of the callbacks might
rely on ->state holding the result from a previous callback.
See for example drivers/pwm/pwm-lpc18xx-sct.c where .enable() calls
pwm_get_polarity().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wuurxkktiq23hfbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE3QdgACgkQwfwUeK3K
7Al7sgf/YtLY7u5K8GazUxKmvZQnQn7u6Sc4FQy0FaYFJNFfe8JYa23A32nnDA/2
uEZt1BEPBskdKlZUBKYvdFK2N5D74v9iKWgeAgf+P6IPtk1L3xT1nuFVVMow01bp
ZNNx0Yqml66BdnVL99Zb8YcfiyZZHLBx9Ua+z/QRz7AK4UWJqcHFD8GSXHJlGlT5
6zpNEF5yBqrNHkvSOgU5fP+swncbn/SCy4B6izftwDeTg4hkg3EcuwegFba+YbHT
I8Kg7IE4IfFrEzrFRItEsWXphpAWz97E/YVjFrPAdCSPtvAj0IHwQ3/7CJhofiNz
Th4XzQfjpu0AlCJN3FSZhFjA4zCVdg==
=frs3
-----END PGP SIGNATURE-----

--wuurxkktiq23hfbz--
