Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694535CDF7
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbhDLQlH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244370AbhDLQgn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 12:36:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1CC061373
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 09:30:48 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVzSY-0003BG-2s; Mon, 12 Apr 2021 18:30:46 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVzSX-0001id-PR; Mon, 12 Apr 2021 18:30:45 +0200
Date:   Mon, 12 Apr 2021 18:30:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/8] pwm: pca9685: Support new PWM_USAGE_POWER flag
Message-ID: <20210412163045.apgnac7atgpboths@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-6-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhmrx7lbecqocasu"
Content-Disposition: inline
In-Reply-To: <20210412132745.76609-6-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jhmrx7lbecqocasu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 03:27:43PM +0200, Clemens Gruber wrote:
> If PWM_USAGE_POWER is set on a PWM, the pca9685 driver will phase shift
> the individual channels relative to their channel number. This improves
> EMI because the enabled channels no longer turn on at the same time,
> while still maintaining the configured duty cycle / power output.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 63 ++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 7f97965033e7..410b93b115dc 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -93,46 +93,76 @@ static inline struct pca9685 *to_pca(struct pwm_chip =
*chip)
>  /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=
=3D2048 -> 50%) */
>  static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsig=
ned int duty)
>  {
> +	struct pwm_device *pwm =3D &pca->chip.pwms[channel];
> +	unsigned int on, off;
> +
>  	if (duty =3D=3D 0) {
>  		/* Set the full OFF bit, which has the highest precedence */
>  		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> +		return;
>  	} else if (duty >=3D PCA9685_COUNTER_RANGE) {
>  		/* Set the full ON bit and clear the full OFF bit */
>  		regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
>  		regmap_write(pca->regmap, REG_OFF_H(channel), 0);
> -	} else {
> -		/* Set OFF time (clears the full OFF bit) */
> -		regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> -		regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> -		/* Clear the full ON bit */
> -		regmap_write(pca->regmap, REG_ON_H(channel), 0);
> +		return;
>  	}
> +
> +
> +	if (pwm->args.usage_power && channel < PCA9685_MAXCHAN) {
> +		/*
> +		 * If PWM_USAGE_POWER is set on a PWM, the pca9685
> +		 * driver will phase shift the individual channels
> +		 * relative to their channel number.
> +		 * This improves EMI because the enabled channels no
> +		 * longer turn on at the same time, while still
> +		 * maintaining the configured duty cycle / power output.
> +		 */
> +		on =3D channel * PCA9685_COUNTER_RANGE / PCA9685_MAXCHAN;
> +	} else
> +		on =3D 0;
> +
> +	off =3D (on + duty) % PCA9685_COUNTER_RANGE;
> +
> +	/* Set ON time (clears full ON bit) */
> +	regmap_write(pca->regmap, REG_ON_L(channel), on & 0xff);
> +	regmap_write(pca->regmap, REG_ON_H(channel), (on >> 8) & 0xf);
> +	/* Set OFF time (clears full OFF bit) */
> +	regmap_write(pca->regmap, REG_OFF_L(channel), off & 0xff);
> +	regmap_write(pca->regmap, REG_OFF_H(channel), (off >> 8) & 0xf);
>  }
> =20
>  static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channe=
l)
>  {
> -	unsigned int off_h =3D 0, val =3D 0;
> +	struct pwm_device *pwm =3D &pca->chip.pwms[channel];
> +	unsigned int off =3D 0, on =3D 0, val =3D 0;
> =20
>  	if (WARN_ON(channel >=3D PCA9685_MAXCHAN)) {
>  		/* HW does not support reading state of "all LEDs" channel */
>  		return 0;
>  	}
> =20
> -	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> -	if (off_h & LED_FULL) {
> +	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off);
> +	if (off & LED_FULL) {
>  		/* Full OFF bit is set */
>  		return 0;
>  	}
> =20
> -	regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> -	if (val & LED_FULL) {
> +	regmap_read(pca->regmap, LED_N_ON_H(channel), &on);
> +	if (on & LED_FULL) {
>  		/* Full ON bit is set */
>  		return PCA9685_COUNTER_RANGE;
>  	}
> =20
> -	val =3D 0;
>  	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> -	return ((off_h & 0xf) << 8) | (val & 0xff);
> +	off =3D ((off & 0xf) << 8) | (val & 0xff);
> +	if (!pwm->args.usage_power)
> +		return off;
> +
> +	/* Read ON register to calculate duty cycle of staggered output */
> +	val =3D 0;
> +	regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
> +	on =3D ((on & 0xf) << 8) | (val & 0xff);
> +	return (off - on) & (PCA9685_COUNTER_RANGE - 1);

If LED_N_ON is !=3D 0 but usage_power is false, the returned state is
bogus.

>  }
> =20
>  #if IS_ENABLED(CONFIG_GPIOLIB)
> @@ -439,9 +469,11 @@ static int pca9685_pwm_probe(struct i2c_client *clie=
nt,
>  	reg &=3D ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
>  	regmap_write(pca->regmap, PCA9685_MODE1, reg);
> =20
> -	/* Reset OFF registers to POR default */
> +	/* Reset OFF/ON registers to POR default */
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, LED_FULL);
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> =20
>  	pca->chip.ops =3D &pca9685_pwm_ops;
>  	/* Add an extra channel for ALL_LED */
> @@ -450,6 +482,9 @@ static int pca9685_pwm_probe(struct i2c_client *clien=
t,
>  	pca->chip.dev =3D &client->dev;
>  	pca->chip.base =3D -1;
> =20
> +	pca->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	pca->chip.of_pwm_n_cells =3D 3;
> +

Huh, you're incompatibly changing the device tree binding here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jhmrx7lbecqocasu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB0dbIACgkQwfwUeK3K
7Am0xwf/RepmiWGQfaTPVhxluBb43rSyURqoSGZOLqdFh/VCADNOQPnFkoZBCurf
LgQPla6JL7BWoTLRl+FDjNEe38xLjN12pjq+eLBkimyAT5WKxSJtnujo0GRpR3Lb
+Dmum3JnOvgYpWyafbgXTZ0vvb2eaKE1r5i3v2gWVFkLTw0WnE2Pha/yiDkDuLqh
Mwi+9HHrzQ28JxzpL24KUwrUqf76x3YwqCzaHgWrqZzw0EZKKFBxDLPaRGVhE/GO
Www5klGeoWHFraZh1bUcR3BnX0MEHryzNdyoKzloUwY7lZX8opCcCtU4LzJ0Je7R
eSrsbpzW1ZNFngz0kHGWxBecZBH5Ew==
=lvJz
-----END PGP SIGNATURE-----

--jhmrx7lbecqocasu--
