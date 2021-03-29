Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35D34D592
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 18:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC2Qy7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhC2Qyd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 12:54:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C7BC061574
        for <linux-pwm@vger.kernel.org>; Mon, 29 Mar 2021 09:54:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQv9q-0004zl-2r; Mon, 29 Mar 2021 18:54:30 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQv9p-0005CS-Mf; Mon, 29 Mar 2021 18:54:29 +0200
Date:   Mon, 29 Mar 2021 18:54:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210329165429.ookfliw4eq6zz2sg@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-2-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jj5t55ipcok53hai"
Content-Disposition: inline
In-Reply-To: <20210329125707.182732-2-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jj5t55ipcok53hai
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 02:57:02PM +0200, Clemens Gruber wrote:
> Implements .get_state to read-out the current hardware state.
>=20
> The hardware readout may return slightly different values than those
> that were set in apply due to the limited range of possible prescale and
> counter register values.
>=20
> Also note that although the datasheet mentions 200 Hz as default
> frequency when using the internal 25 MHz oscillator, the calculated
> period from the default prescaler register setting of 30 is 5079040ns.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 41 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 0ed1013737e3..fb026a25fb61 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -333,6 +333,46 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	return 0;
>  }
> =20
> +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct pca9685 *pca =3D to_pca(chip);
> +	unsigned long long duty;
> +	unsigned int val =3D 0;
> +
> +	/* Calculate (chip-wide) period from prescale value */
> +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> +	state->period =3D (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ=
) *
> +			(val + 1);

As we have PCA9685_OSC_CLOCK_MHZ =3D 25 this is an integer calculation
without loss of precision. It might be worth to point that out in a
comment. (Otherwise doing the division at the end might be more
sensible.)

> +	/* The (per-channel) polarity is fixed */
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	if (pwm->hwpwm >=3D PCA9685_MAXCHAN) {
> +		/*
> +		 * The "all LEDs" channel does not support HW readout
> +		 * Return 0 and disabled for backwards compatibility
> +		 */
> +		state->duty_cycle =3D 0;
> +		state->enabled =3D false;
> +		return;
> +	}
> +
> +	duty =3D pca9685_pwm_get_duty(pca, pwm->hwpwm);
> +
> +	state->enabled =3D !!duty;
> +	if (!state->enabled) {
> +		state->duty_cycle =3D 0;
> +		return;
> +	} else if (duty =3D=3D PCA9685_COUNTER_RANGE) {
> +		state->duty_cycle =3D state->period;
> +		return;
> +	}
> +
> +	duty *=3D state->period;
> +	state->duty_cycle =3D duty / PCA9685_COUNTER_RANGE;

=2Eapply uses ROUND_CLOSEST to calculate duty from state->duty_cycle,
still using / here (instead of ROUND_CLOSEST), but again as
PCA9685_OSC_CLOCK_MHZ is 25 this calculation doesn't suffer from
rounding errors. So if you feed the state returned here into .apply
again, there is (as I want it) no change.

The only annoyance is that if PCA9685_PRESCALE holds a value smaller
than 3, .apply() will fail. Not sure there is any saner way to handle
this.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jj5t55ipcok53hai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBiBkIACgkQwfwUeK3K
7AkXKAf9Edxq8VdhqE0oDz96RLGkPW0PEAiL6u8vB1+9uTC2lxfe6gMj6tqPZamt
H/Jk4XXwbitFnMLIfgZMtfA+/CMwymtjYvd6FjY5+yt1MfFkGLyZNX5G3IccWPgE
d4MUwF9bG0BGgTJHEnWqJLiJ8mkDpOX6FMYSDvRtKw9rlODXnq6wlxRws/tjtjXm
SkSivomIoImBw6ZE6EHiImGjX+BzSBHeyztU5PwuxDGry05ZEaR4CX9p3sZE4GOU
U7U87QEUnHLdK1+vZ/1RJAsV1RTOh4v2fZtDw3WCsW8GDjyN59B9Q8X2nMQH5Z3B
K+ac83vQ/Hlzgdaa5rIliDTJ1Y3b6Q==
=j+4H
-----END PGP SIGNATURE-----

--jj5t55ipcok53hai--
