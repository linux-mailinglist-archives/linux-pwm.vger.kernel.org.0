Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EADE3562FF
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 07:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbhDGFZU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 01:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhDGFZT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 01:25:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49DC06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 22:24:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU0g1-0000We-G0; Wed, 07 Apr 2021 07:24:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU0g0-00016A-Nk; Wed, 07 Apr 2021 07:24:28 +0200
Date:   Wed, 7 Apr 2021 07:24:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <20210407052428.4hkzzqtitpq7zzc5@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ko6fq56lz6hystfz"
Content-Disposition: inline
In-Reply-To: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ko6fq56lz6hystfz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 06, 2021 at 06:41:33PM +0200, Clemens Gruber wrote:
> The switch to the atomic API goes hand in hand with a few fixes to
> previously experienced issues:
> - The duty cycle is no longer lost after disable/enable (previously the
>   OFF registers were cleared in disable and the user was required to
>   call config to restore the duty cycle settings)
> - If one sets a period resulting in the same prescale register value,
>   the sleep and write to the register is now skipped
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
> Changes since v6:
> - Order of a comparison switched for improved readability
>=20
> Changes since v5:
> - Function documentation for set_duty
> - Variable initializations
> - Print warning if all LEDs channel
> - Changed EOPNOTSUPP to EINVAL
> - Improved error messages
> - Register reset corrections moved to this patch
>=20
> Changes since v4:
> - Patches split up
> - Use a single set_duty function
> - Improve readability / new macros
> - Added a patch to restrict prescale changes to the first user
>=20
> Changes since v3:
> - Refactoring: Extracted common functions
> - Read prescale register value instead of caching it
> - Return all zeros and disabled for "all LEDs" channel state
> - Improved duty calculation / mapping to 0..4096
>=20
> Changes since v2:
> - Always set default prescale value in probe
> - Simplified probe code
> - Inlined functions with one callsite
>=20
> Changes since v1:
> - Fixed a logic error
> - Impoved PM runtime handling and fixed !CONFIG_PM
> - Write default prescale reg value if invalid in probe
> - Reuse full_off/_on functions throughout driver
> - Use cached prescale value whenever possible
>=20
>  drivers/pwm/pwm-pca9685.c | 261 ++++++++++++++------------------------
>  1 file changed, 92 insertions(+), 169 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 4a55dc18656c..5a2ce97e71fd 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -51,7 +51,6 @@
>  #define PCA9685_PRESCALE_MAX	0xFF	/* =3D> min. frequency of 24 Hz */
> =20
>  #define PCA9685_COUNTER_RANGE	4096
> -#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns =3D 1/200 Hz=
 */
>  #define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 MHz */
> =20
>  #define PCA9685_NUMREGS		0xFF
> @@ -71,10 +70,14 @@
>  #define LED_N_OFF_H(N)	(PCA9685_LEDX_OFF_H + (4 * (N)))
>  #define LED_N_OFF_L(N)	(PCA9685_LEDX_OFF_L + (4 * (N)))
> =20
> +#define REG_ON_H(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_H : L=
ED_N_ON_H((C)))
> +#define REG_ON_L(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_L : L=
ED_N_ON_L((C)))
> +#define REG_OFF_H(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H :=
 LED_N_OFF_H((C)))
> +#define REG_OFF_L(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L :=
 LED_N_OFF_L((C)))
> +
>  struct pca9685 {
>  	struct pwm_chip chip;
>  	struct regmap *regmap;
> -	int period_ns;
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>  	struct mutex lock;
>  	struct gpio_chip gpio;
> @@ -87,6 +90,51 @@ static inline struct pca9685 *to_pca(struct pwm_chip *=
chip)
>  	return container_of(chip, struct pca9685, chip);
>  }
> =20
> +/* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=
=3D2048 -> 50%) */
> +static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsig=
ned int duty)
> +{
> +	if (duty =3D=3D 0) {
> +		/* Set the full OFF bit, which has the highest precedence */
> +		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> +	} else if (duty >=3D PCA9685_COUNTER_RANGE) {
> +		/* Set the full ON bit and clear the full OFF bit */
> +		regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
> +		regmap_write(pca->regmap, REG_OFF_H(channel), 0);
> +	} else {
> +		/* Set OFF time (clears the full OFF bit) */
> +		regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> +		regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> +		/* Clear the full ON bit */
> +		regmap_write(pca->regmap, REG_ON_H(channel), 0);
> +	}
> +}
> +
> +static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channe=
l)
> +{
> +	unsigned int off_h =3D 0, val =3D 0;
> +
> +	if (WARN_ON(channel >=3D PCA9685_MAXCHAN)) {
> +		/* HW does not support reading state of "all LEDs" channel */
> +		return 0;
> +	}
> +
> +	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> +	if (off_h & LED_FULL) {
> +		/* Full OFF bit is set */
> +		return 0;
> +	}
> +
> +	regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> +	if (val & LED_FULL) {
> +		/* Full ON bit is set */
> +		return PCA9685_COUNTER_RANGE;
> +	}
> +
> +	val =3D 0;

Why do you set val to 0 first? Do you get a compiler warning otherwise?

> +	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> +	return ((off_h & 0xf) << 8) | (val & 0xff);
> +}
> +
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>  static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_=
idx)
>  {
> @@ -138,34 +186,23 @@ static int pca9685_pwm_gpio_request(struct gpio_chi=
p *gpio, unsigned int offset)
>  static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int off=
set)
>  {
>  	struct pca9685 *pca =3D gpiochip_get_data(gpio);
> -	struct pwm_device *pwm =3D &pca->chip.pwms[offset];
> -	unsigned int value;
> =20
> -	regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
> -
> -	return value & LED_FULL;
> +	return pca9685_pwm_get_duty(pca, offset) !=3D 0;

Is this a relevant bug fix? If both OFF_H.FULL and ON_H.FULL are set,
the output is low and this was diagnosed before as high.

>  }
> =20
>  static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int of=
fset,
>  				 int value)
>  {
>  	struct pca9685 *pca =3D gpiochip_get_data(gpio);
> -	struct pwm_device *pwm =3D &pca->chip.pwms[offset];
> -	unsigned int on =3D value ? LED_FULL : 0;
> -
> -	/* Clear both OFF registers */
> -	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0);
> -	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0);
> =20
> -	/* Set the full ON bit */
> -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
> +	pca9685_pwm_set_duty(pca, offset, value ? PCA9685_COUNTER_RANGE : 0);
>  }
> =20
>  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int o=
ffset)
>  {
>  	struct pca9685 *pca =3D gpiochip_get_data(gpio);
> =20
> -	pca9685_pwm_gpio_set(gpio, offset, 0);
> +	pca9685_pwm_set_duty(pca, offset, 0);

Orthogonal to your patch:
I don't know the customs of GPIO drivers enough, but I wonder that
=2Efree() results in setting the value of the GPIO?!

>  	pm_runtime_put(pca->chip.dev);
>  	pca9685_pwm_clear_inuse(pca, offset);
>  }
> @@ -246,167 +283,56 @@ static void pca9685_set_sleep_mode(struct pca9685 =
*pca, bool enable)
>  	}
>  }
> =20
> -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> -			      int duty_ns, int period_ns)
> +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
>  {
>  	struct pca9685 *pca =3D to_pca(chip);
> -	unsigned long long duty;
> -	unsigned int reg;
> -	int prescale;
> -
> -	if (period_ns !=3D pca->period_ns) {
> -		prescale =3D DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
> -					     PCA9685_COUNTER_RANGE * 1000) - 1;
> -
> -		if (prescale >=3D PCA9685_PRESCALE_MIN &&
> -			prescale <=3D PCA9685_PRESCALE_MAX) {
> -			/*
> -			 * Putting the chip briefly into SLEEP mode
> -			 * at this point won't interfere with the
> -			 * pm_runtime framework, because the pm_runtime
> -			 * state is guaranteed active here.
> -			 */
> -			/* Put chip into sleep mode */
> -			pca9685_set_sleep_mode(pca, true);
> -
> -			/* Change the chip-wide output frequency */
> -			regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> -
> -			/* Wake the chip up */
> -			pca9685_set_sleep_mode(pca, false);
> -
> -			pca->period_ns =3D period_ns;
> -		} else {
> -			dev_err(chip->dev,
> -				"prescaler not set: period out of bounds!\n");
> -			return -EINVAL;
> -		}
> -	}
> +	unsigned long long duty, prescale;
> +	unsigned int val =3D 0;
> =20
> -	if (duty_ns < 1) {
> -		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -			reg =3D PCA9685_ALL_LED_OFF_H;
> -		else
> -			reg =3D LED_N_OFF_H(pwm->hwpwm);
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> =20
> -		regmap_write(pca->regmap, reg, LED_FULL);
> -
> -		return 0;
> +	prescale =3D DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->perio=
d,
> +					 PCA9685_COUNTER_RANGE * 1000) - 1;

Here the multiplication might overflow.  Also if period is small the
result of the division might be 0 and prescale might end up being -1ULL.
(But that's a problem that we had already before, so not a stopper for
this patch.)

> +	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX)=
 {
> +		dev_err(chip->dev, "pwm not changed: period out of bounds!\n");
> +		return -EINVAL;
>  	}
> =20
> -	if (duty_ns =3D=3D period_ns) {
> -		/* Clear both OFF registers */
> -		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -			reg =3D PCA9685_ALL_LED_OFF_L;
> -		else
> -			reg =3D LED_N_OFF_L(pwm->hwpwm);
> -
> -		regmap_write(pca->regmap, reg, 0x0);
> -
> -		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -			reg =3D PCA9685_ALL_LED_OFF_H;
> -		else
> -			reg =3D LED_N_OFF_H(pwm->hwpwm);
> -
> -		regmap_write(pca->regmap, reg, 0x0);
> -
> -		/* Set the full ON bit */
> -		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -			reg =3D PCA9685_ALL_LED_ON_H;
> -		else
> -			reg =3D LED_N_ON_H(pwm->hwpwm);
> -
> -		regmap_write(pca->regmap, reg, LED_FULL);
> +	duty =3D PCA9685_COUNTER_RANGE * state->duty_cycle;
> +	duty =3D DIV_ROUND_CLOSEST_ULL(duty, state->period);

Here we're losing precision. In general calculating the duty should be
done using time, not period counter values. (Again, that's an old
problem.)

> =20
> +	if (duty < 1 || !state->enabled) {
> +		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> +		return 0;
> +	} else if (duty =3D=3D PCA9685_COUNTER_RANGE) {
> +		pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
>  		return 0;
>  	}
> =20
> -	duty =3D PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> -	duty =3D DIV_ROUND_UP_ULL(duty, period_ns);

Oh, the new implementation uses DIV_ROUND_CLOSEST. IMHO either keep the
calculations as is, or use the preferred round-down.

> -
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_OFF_L;
> -	else
> -		reg =3D LED_N_OFF_L(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, (int)duty & 0xff);
> -
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_OFF_H;
> -	else
> -		reg =3D LED_N_OFF_H(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
> -
> -	/* Clear the full ON bit, otherwise the set OFF time has no effect */
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_ON_H;
> -	else
> -		reg =3D LED_N_ON_H(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0);
> -
> -	return 0;
> -}
> -
> -static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> -{
> -	struct pca9685 *pca =3D to_pca(chip);
> -	unsigned int reg;
> -
> -	/*
> -	 * The PWM subsystem does not support a pre-delay.
> -	 * So, set the ON-timeout to 0
> -	 */
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_ON_L;
> -	else
> -		reg =3D LED_N_ON_L(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0);
> -
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_ON_H;
> -	else
> -		reg =3D LED_N_ON_H(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0);
> +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> +	if (prescale !=3D val) {
> +		/*
> +		 * Putting the chip briefly into SLEEP mode
> +		 * at this point won't interfere with the
> +		 * pm_runtime framework, because the pm_runtime
> +		 * state is guaranteed active here.
> +		 */
> +		/* Put chip into sleep mode */
> +		pca9685_set_sleep_mode(pca, true);

I assume it's a requirement to stop the oscillator when changing the
prescaler?

> =20
> -	/*
> -	 * Clear the full-off bit.
> -	 * It has precedence over the others and must be off.
> -	 */
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_OFF_H;
> -	else
> -		reg =3D LED_N_OFF_H(pwm->hwpwm);
> +		/* Change the chip-wide output frequency */
> +		regmap_write(pca->regmap, PCA9685_PRESCALE, (int)prescale);

The cast isn't necessary, is it?

> -	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> +		/* Wake the chip up */
> +		pca9685_set_sleep_mode(pca, false);
> +	}
> =20
> +	pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
>  	return 0;
>  }
> =20
> -static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> -{
> -	struct pca9685 *pca =3D to_pca(chip);
> -	unsigned int reg;
> -
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_OFF_H;
> -	else
> -		reg =3D LED_N_OFF_H(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, LED_FULL);
> -
> -	/* Clear the LED_OFF counter. */
> -	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> -		reg =3D PCA9685_ALL_LED_OFF_L;
> -	else
> -		reg =3D LED_N_OFF_L(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0x0);
> -}
> -
>  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
>  {
>  	struct pca9685 *pca =3D to_pca(chip);
> @@ -422,15 +348,13 @@ static void pca9685_pwm_free(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  {
>  	struct pca9685 *pca =3D to_pca(chip);
> =20
> -	pca9685_pwm_disable(chip, pwm);
> +	pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
>  	pm_runtime_put(chip->dev);
>  	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
>  }
> =20
>  static const struct pwm_ops pca9685_pwm_ops =3D {
> -	.enable =3D pca9685_pwm_enable,
> -	.disable =3D pca9685_pwm_disable,
> -	.config =3D pca9685_pwm_config,
> +	.apply =3D pca9685_pwm_apply,
>  	.request =3D pca9685_pwm_request,
>  	.free =3D pca9685_pwm_free,
>  	.owner =3D THIS_MODULE,
> @@ -461,7 +385,6 @@ static int pca9685_pwm_probe(struct i2c_client *clien=
t,
>  			ret);
>  		return ret;
>  	}
> -	pca->period_ns =3D PCA9685_DEFAULT_PERIOD;
> =20
>  	i2c_set_clientdata(client, pca);
> =20
> @@ -484,9 +407,9 @@ static int pca9685_pwm_probe(struct i2c_client *clien=
t,
>  	reg &=3D ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
>  	regmap_write(pca->regmap, PCA9685_MODE1, reg);
> =20
> -	/* Clear all "full off" bits */
> -	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> -	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> +	/* Reset OFF registers to POR default */
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, LED_FULL);
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);

Is this hunk unrelated to the patch description?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ko6fq56lz6hystfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBtQgkACgkQwfwUeK3K
7Alc9Af+KFmFCdwMyHJdIroSiuyBN2VpcxAfS1bnzcMMUugiaPGExw0B+Y6gZAc+
bKY4y4Xk936pvGiROcDjdHPF0n5vcL67a0D542nUqlc8THSF9Y9lpAkWyO3z+xCw
bhdBZYv3NKK18VVY1UueQP79FRtFo+HKZZmDMi+0deo08DFC2oLUXvoYHJkGj1fF
VckVtE7KN3YhYRSkyv0Yd5hh61yYzdN8bIkTh0fZMxzLeei98wizSUwXL4Y6EEyh
2ETgsvbNtRab3d/9W1Wjr/wto1L/cv3E/xXf/L63iBcAkUvxQ/xP1MJcvsIhaaqu
8HFNjDaH5EQoLFgUSAUvITgT3MoE5A==
=duGG
-----END PGP SIGNATURE-----

--ko6fq56lz6hystfz--
