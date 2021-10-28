Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FAB43DB76
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1Grz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Oct 2021 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhJ1Gry (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Oct 2021 02:47:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B386C061570
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 23:45:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mfzA4-0008LQ-77; Thu, 28 Oct 2021 08:45:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mfzA2-0001rL-1N; Thu, 28 Oct 2021 08:45:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mfzA2-000369-04; Thu, 28 Oct 2021 08:45:14 +0200
Date:   Thu, 28 Oct 2021 08:45:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     sean@mess.org, lkp@intel.com, mchehab@kernel.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
References: <YXlxhpZWf2mxJaMi@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mf4wlywlnibmr5pv"
Content-Disposition: inline
In-Reply-To: <YXlxhpZWf2mxJaMi@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mf4wlywlnibmr5pv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 12:34:30PM -0300, Ma=EDra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
> Reported-by: kernel test robot <lkp@intel.com>

While it's true that he kernel robot told you about a problem in an
earlier revision, adding the tag here is misleading, because in the end
you only see the tag in the commit history, and there is suggests that
the commit fixes something that was reported in the kernel tree before.

For this reason I usually only add a thanks after the tripple dash.

Also note this nitpick: Your S-o-b should always be the last thing.

> ---
> V1 -> V2: Assign variables directly and simplify conditional statement
> V2 -> V3: Fix declaration of undeclared variables
> V3 -> V4: Fix DIV_ROUND_CLOSEST error with u64 variables
> ---
>  drivers/media/rc/pwm-ir-tx.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index 4bc28d2c9cc9..105a9c24f1e3 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -53,22 +53,21 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int=
 *txbuf,
>  {
>  	struct pwm_ir *pwm_ir =3D dev->priv;
>  	struct pwm_device *pwm =3D pwm_ir->pwm;
> -	int i, duty, period;
> +	struct pwm_state state;
> +	int i;
>  	ktime_t edge;
>  	long delta;
> =20
> -	period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> -	duty =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
> +	pwm_init_state(pwm, &state);
> =20
> -	pwm_config(pwm, duty, period);
> +	state.period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> +	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> =20
>  	edge =3D ktime_get();
> =20
>  	for (i =3D 0; i < count; i++) {
> -		if (i % 2) // space
> -			pwm_disable(pwm);
> -		else
> -			pwm_enable(pwm);
> +		state.enabled =3D !(i % 2);
> +		pwm_apply_state(pwm, &state);
> =20
>  		edge =3D ktime_add_us(edge, txbuf[i]);
>  		delta =3D ktime_us_delta(edge, ktime_get());
> @@ -76,7 +75,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *=
txbuf,
>  			usleep_range(delta, delta + 10);
>  	}
> =20
> -	pwm_disable(pwm);
> +	state.enabled =3D false;
> +	pwm_apply_state(pwm, &state);
> =20
>  	return count;
>  }

The conversion is right (I think), note this could be optimized a bit
further: state.period only depends on carrier which rarely changes, so
the calculation could be done in pwm_ir_set_carrier(). Ditto for duty
which only depends on state.period and pwm_ir->duty_cycle. (This is for
a separate commit though.)

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mf4wlywlnibmr5pv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF6RvUACgkQwfwUeK3K
7Anl9Af8CgvGM/ZHx9tafHzheQcFRngBZ+7mNWcXYkutj+S3XAQ/G/W9V+nS9RWc
j5M9Q/st772Y1X0h7dT0YpUcYiLa2IYlAQlWijolrdFKzuXW7lDiAGDexmI3TAVO
C/LaJQ4oHUgfr4wULkvQey3FgwXpE6asDxTk+eiIG1zLoADJ5ur38zpqpq1nrQNv
jl4S3iBgO3BftndvCk0qPN3Ff16XgzjLFvzoXr81nxOJIHfUAmzjaZ8ctJbckN8f
Qo3dY2KhxgCVJt7DuRytUIS6kYY5or4lh1udF+y0UiS0TiavLk0pvuwegYxJ6Ovq
mOIZhjNjBObw03KqCaBga9+pU74N7A==
=V5HL
-----END PGP SIGNATURE-----

--mf4wlywlnibmr5pv--
