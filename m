Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6127BB619
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjJFLOz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjJFLOy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:14:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2FBCA
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:14:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoinB-00082o-AI; Fri, 06 Oct 2023 13:14:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoinA-00BV9n-Mu; Fri, 06 Oct 2023 13:14:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoinA-00AAjx-DT; Fri, 06 Oct 2023 13:14:48 +0200
Date:   Fri, 6 Oct 2023 13:14:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 101/101] pwm: Add more locking
Message-ID: <20231006111448.7c22kvupxfjmy2qc@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-102-u.kleine-koenig@pengutronix.de>
 <ZR_c99evPTimrQY9@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vrwh76u3ctmdmklz"
Content-Disposition: inline
In-Reply-To: <ZR_c99evPTimrQY9@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vrwh76u3ctmdmklz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 12:09:59PM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 07:19:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > This ensures that a pwm_chip that has no corresponding driver isn't used
> > and that a driver doesn't go away while a callback is still running.
> >=20
> > As with the previous commit this was not expected to be a problem in the
> > presence of device links, but still it can happen with the command
> > sequence mentioned in the previous commit. Even if this should turn out
> > to be a problem that could be fixed by improving device links, this is a
> > necessary preparation to create race-free pwmchip character devices.
> >=20
> > A not so nice side effect is that all calls to the PWM API are
> > serialized now. If this turns out to be problematic this can be replaced
> > by per-pwm_chip locking later. As long as this bottleneck isn't known to
> > be a problem in practise, the simpler approach of a single lock is used
> > here.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c  | 50 ++++++++++++++++++++++++++++++++++++---------
> >  include/linux/pwm.h |  2 ++
> >  2 files changed, 42 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index fcf30f77da34..66743ded66f6 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -230,6 +230,7 @@ static struct pwm_chip *pwmchip_alloc(struct device=
 *parent, unsigned int npwm,
> >  	dev->release =3D pwmchip_release;
> > =20
> >  	chip->npwm =3D npwm;
> > +	chip->ready =3D false;
> > =20
> >  	for (i =3D 0; i < chip->npwm; i++) {
> >  		struct pwm_device *pwm =3D &chip->pwms[i];
> > @@ -309,6 +310,8 @@ int __pwmchip_add(struct pwm_chip *chip, struct mod=
ule *owner)
> >  		module_put(owner);
> >  	}
> > =20
> > +	chip->ready =3D true;
> > +
> >  	mutex_unlock(&pwm_lock);
> > =20
> >  	return ret;
> > @@ -324,12 +327,25 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
> >  void pwmchip_remove(struct pwm_chip *chip)
> >  {
> >  	pwmchip_sysfs_unexport(chip);
> > +	unsigned int i;
>=20
> This looks weird, mixing declarations and code.
>=20
> > =20
> >  	if (IS_ENABLED(CONFIG_OF))
> >  		of_pwmchip_remove(chip);
> > =20
> >  	mutex_lock(&pwm_lock);
> > =20
> > +	for (i =3D 0; i < chip->npwm; ++i) {
> > +		struct pwm_device *pwm =3D &chip->pwms[i];
> > +
> > +		if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> > +			dev_alert(&chip->dev, "Freeing requested pwm #%u\n", i);
>=20
> s/pwm #%u/PWM #%u/
>=20
> > +			if (pwm->chip->ops->free)
> > +				pwm->chip->ops->free(pwm->chip, pwm);
> > +		}
> > +	}
> > +
> > +	chip->ready =3D false;
> > +
> >  	idr_remove(&pwmchip_idr, chip->id);
> > =20
> >  	mutex_unlock(&pwm_lock);
> > @@ -505,7 +521,7 @@ static void pwm_apply_state_debug(struct pwm_device=
 *pwm,
> >  int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *st=
ate)
> >  {
> >  	struct pwm_chip *chip;
> > -	int err;
> > +	int err =3D 0;
> > =20
> >  	/*
> >  	 * Some lowlevel driver's implementations of .apply() make use of
> > @@ -522,17 +538,24 @@ int pwm_apply_state(struct pwm_device *pwm, const=
 struct pwm_state *state)
> > =20
> >  	chip =3D pwm->chip;
> > =20
> > +	mutex_lock(&pwm_lock);
> > +
> > +	if (!chip->ready) {
> > +		err =3D -ENXIO;
> > +		goto out_unlock;
> > +	}
> > +
> >  	if (state->period =3D=3D pwm->state.period &&
> >  	    state->duty_cycle =3D=3D pwm->state.duty_cycle &&
> >  	    state->polarity =3D=3D pwm->state.polarity &&
> >  	    state->enabled =3D=3D pwm->state.enabled &&
> >  	    state->usage_power =3D=3D pwm->state.usage_power)
> > -		return 0;
> > +		goto out_unlock;
> > =20
> >  	err =3D chip->ops->apply(chip, pwm, state);
> >  	trace_pwm_apply(pwm, state, err);
> >  	if (err)
> > -		return err;
> > +		goto out_unlock;
> > =20
> >  	pwm->state =3D *state;
> > =20
> > @@ -542,7 +565,10 @@ int pwm_apply_state(struct pwm_device *pwm, const =
struct pwm_state *state)
> >  	 */
> >  	pwm_apply_state_debug(pwm, state);
> > =20
> > -	return 0;
> > +out_unlock:
> > +	mutex_unlock(&pwm_lock);
> > +
> > +	return err;
> >  }
> >  EXPORT_SYMBOL_GPL(pwm_apply_state);
> > =20
> > @@ -566,7 +592,12 @@ int pwm_capture(struct pwm_device *pwm, struct pwm=
_capture *result,
> >  		return -ENOSYS;
> > =20
> >  	mutex_lock(&pwm_lock);
> > -	err =3D pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
> > +
> > +	if (pwm->chip->ready)
> > +		err =3D pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
> > +	else
> > +		err =3D -ENXIO;
> > +
> >  	mutex_unlock(&pwm_lock);
> > =20
> >  	return err;
> > @@ -978,18 +1009,17 @@ void pwm_put(struct pwm_device *pwm)
> > =20
> >  	mutex_lock(&pwm_lock);
> > =20
> > -	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> > -		pr_warn("PWM device already freed\n");
>=20
> Don't we want to keep this message? We do want to make sure that we're
> always calling things in the right order and this might help catch
> errors.

No, if this triggers we already got

	dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);

in pwmchip_remove() before.

>=20
> > +	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags))
> >  		goto out;
> > -	}
> > =20
> > -	if (pwm->chip->ops->free)
> > +	if (pwm->chip->ready && pwm->chip->ops->free)
> >  		pwm->chip->ops->free(pwm->chip, pwm);
>=20
> These callbacks may do things like decrease internal reference counts or
> free memory, etc. Don't we want to run those even if the PWM chip isn't
> operational anymore? Wouldn't we otherwise risk leaking memory and/or
> other resources?

It is run, in pwmchip_remove().

> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 3dd46b89ab8b..f5b65994a30e 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -289,6 +289,7 @@ struct pwm_ops {
> >   * @of_pwm_n_cells: number of cells expected in the device tree PWM sp=
ecifier
> >   * @list: list node for internal use
> >   * @pwms: array of PWM devices allocated by the framework
> > + * @ready: tracks if the chip is operational
> >   */
> >  struct pwm_chip {
> >  	struct device dev;
> > @@ -302,6 +303,7 @@ struct pwm_chip {
> >  	unsigned int of_pwm_n_cells;
> > =20
> >  	/* only used internally by the PWM framework */
> > +	bool ready;
>=20
> Can we find a better name for this? Maybe something like "available" or
> "operational"? Those are a bit longer, but I feel like they convey more
> accurately what's going on. In other words, "ready" is very vague.

I don't think that "available" or "operational" is relevant better than
"ready", but I don't care much. I'd pick "operational" over "available".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vrwh76u3ctmdmklz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUf7CcACgkQj4D7WH0S
/k6f7ggAqFS+T2v6YDT4yLcxjfiEIePi25pAF7h+KIrnMBo156KxlIrlvtpQcANk
KWWvEKSxhXkSyvMVoBtEs1CGR/MUC8IBVR7Bcp5KiZEQyEFrX3vhGGI5k9z7CxoJ
RucqP2bl/PSRw52Q4nv7SQiBu6Em3Zzq7A3ltnm4YDmh5Zy0QZD2b//hAa3BuiDk
aTHUB/pmU3XxEhlwOyXh+bx99CpO40Yjnrpv+bQB3qIgP1aZ2MtokvPZeUr2b+m1
+OwmW2mvJOd/vzNAqSW48p/wwoACEx9/8kE+92WcvG44XfVcxqHG+Gm7P/aimFjd
mcyZUwCA3mMwC3wsYYuAl1C9KMlZ4g==
=jT0X
-----END PGP SIGNATURE-----

--vrwh76u3ctmdmklz--
