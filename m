Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3F213C20
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGCOxS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgGCOxR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 10:53:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848AC08C5C1
        for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2020 07:53:17 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jrN3y-0002on-6T; Fri, 03 Jul 2020 16:53:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jrN3x-0000mO-Fp; Fri, 03 Jul 2020 16:53:13 +0200
Date:   Fri, 3 Jul 2020 16:53:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qpoybkluvtfa4wj6"
Content-Disposition: inline
In-Reply-To: <20200503105453.23658-1-miquel.raynal@bootlin.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qpoybkluvtfa4wj6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Miquel,

On Sun, May 03, 2020 at 12:54:53PM +0200, Miquel Raynal wrote:
> +static u8 max7313_pwm_get_intensity(struct pca953x_chip *pca_chip,
> +				    unsigned int idx)
> +{
> +	struct device *dev =3D &pca_chip->client->dev;
> +	unsigned int reg, shift, val, output;
> +	u8 intensity;
> +	bool phase;
> +	int ret;
> +
> +	/* Retrieve the intensity */
> +	reg =3D MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift =3D (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;

I would find

	shift =3D (idx % PWM_PER_REG) * PWM_BITS_PER_REG

more natural here as your formula only works for PWM_PER_REG =3D 2.

> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_read(pca_chip->regmap, reg, &val);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot retrieve PWM intensity (%d)\n", ret);

Please use %pe for error codes.

> +		return 0;
> +	}
> +
> +	val >>=3D shift;
> +	val &=3D PWM_INTENSITY_MASK;
> +
> +	/* Retrieve the phase */
> +	reg =3D pca953x_recalc_addr(pca_chip, pca_chip->regs->output, idx, 0, 0=
);
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_read(pca_chip->regmap, reg, &output);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot retrieve PWM phase (%d)\n", ret);
> +		return 0;
> +	}
> +
> +	phase =3D output & BIT(idx % BANK_SZ);

Would it make sense to cache the phase value to reduce register access
and locking here?

> [...]
> +static int max7313_pwm_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct max7313_pwm *max_pwm =3D to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip =3D to_pca953x(max_pwm);
> +	unsigned int intensity, active;
> +	int ret =3D 0;
> +
> +	if (!state->enabled ||
> +	    state->period < PWM_PERIOD_NS ||
> +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;

You could simulate state->enabled =3D false using duty_cycle =3D 0.

> +	/* Convert the duty-cycle to be in the [0;16] range */
> +	intensity =3D max7313_pwm_duty_to_intensity(state->duty_cycle);

This might return a value > 16 if state->duty_cycle > PWM_PERIOD_NS.
I suggest to do

	duty_cycle =3D min(state->duty_cycle, PWM_PERIOD_NS);

and use that value instead of state->duty_cycle.

> +	/*
> +	 * The hardware is supposedly glitch-free when changing the intensity,
> +	 * unless we need to flip the blink phase to reach an extremity or the
> +	 * other of the spectrum (0/16 from phase 1, 16/16 from phase 0).

s/other of/other end of/. I don't understand the difference between
extremity and "other end of the spectrum".

> +	 */
> +	return max7313_pwm_set_state(pca_chip, pwm, intensity);
> +}
> +
> +static void max7313_pwm_get_state(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct max7313_pwm *max_pwm =3D to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip =3D to_pca953x(max_pwm);
> +	u8 intensity;
> +
> +	state->enabled =3D true;
> +	state->period =3D PWM_PERIOD_NS;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	intensity =3D max7313_pwm_get_intensity(pca_chip, pwm->hwpwm);
> +	state->duty_cycle =3D max7313_pwm_intensity_to_duty(intensity);

Please round up the division in max7313_pwm_intensity_to_duty().

(The reasoning is: with rounding down the following can happen:

	/* this configures for 15/16 */
	pwm_apply_state(pwm, { .duty_cycle =3D 31249, .period =3D 31250 });

	/* assume this called your .get_state callback */
	pwm_get_state(pwm, &state);

	/*
	 * we now have
	 *	state.duty_cycle =3D 29296;
	 *	state.period =3D 31250;
	 * right?
	 */
=09
	/* this configures for 14/16 because 29296 * 16 / 31250 < 15 */
	pwm_apply_state(pwm, &state);

But I want this to be idempotent, i.e. pwm_get_state has to round up and
then return .duty_cycle =3D 29297 in the above example which is enough to
let .apply_state() configure 15/16 again. Enabling PWM_DEBUG should
catch this.)

> +};

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qpoybkluvtfa4wj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7/RlUACgkQwfwUeK3K
7AnMFgf/ZWd0QN8FR23Bf9LgdIj/yRJX1ZfTwH8YSVGQYd0Y6uB5u9gaTVlE3zEU
CwnSstJbOPSu9/roLxUFiGSi1O04tx7FjASPhtr4P31F8kLe7HhQfftgPw1TMzl/
r3RT+8k4x+qUcP/wUrdM0wPUctD9Bk7y/Qk3OQ9YB8sHLOKVKAz0oGGjPsN2gf5i
vCEH0nxTHjE16hLViVIpJh9Be9iG+03ajvI+1zkI0gXy02zoPg3v7v4lwnmhpLUH
pdCgFxWrOgU5ZQKwWX6DvyUPq5TcOTVspRo252mIjiH3guOP/N8W9h6wslOoYiql
NpN1gu54TLt5bRLvSFlosx7mMbGz5g==
=e8Kb
-----END PGP SIGNATURE-----

--qpoybkluvtfa4wj6--
