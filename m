Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359992D3BF1
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Dec 2020 08:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgLIHGI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Dec 2020 02:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgLIHGI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Dec 2020 02:06:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8687DC0613CF
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 23:05:27 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmtXK-0007ZR-4Q; Wed, 09 Dec 2020 08:05:18 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmtXI-0005LE-Iu; Wed, 09 Dec 2020 08:05:16 +0100
Date:   Wed, 9 Dec 2020 08:05:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sean@mess.org, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201209070516.yw5bpsh474k7mnfx@pengutronix.de>
References: <1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2dgo6pzrzz5yxyxt"
Content-Disposition: inline
In-Reply-To: <1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2dgo6pzrzz5yxyxt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lino,

On Tue, Dec 08, 2020 at 11:01:45PM +0100, Lino Sanfilippo wrote:
> Use the newer .apply function of pwm_ops instead of .config, .enable,
> .disable and .set_polarity. This guarantees atomic changes of the pwm
> controller configuration. It also reduces the size of the driver.
>=20
> Since now period is a 64 bit value, add an extra check to reject periods
> that exceed the possible max value for the 32 bit register.
>=20
> This has been tested on a Raspberry PI 4.

This looks right, just two small nitpicks below.

> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>=20
> v3: Check against period truncation (based on a review by Uwe Kleine-K=F6=
nig)
> v2: Fix compiler error for 64 bit builds
>=20
>  drivers/pwm/pwm-bcm2835.c | 72 +++++++++++++++++------------------------=
------
>  1 file changed, 26 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 6841dcf..d339898 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -58,13 +58,15 @@ static void bcm2835_pwm_free(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	writel(value, pc->base + PWM_CONTROL);
>  }
> =20
> -static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> -			      int duty_ns, int period_ns)
> +static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
>  {
> +
>  	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
>  	unsigned long rate =3D clk_get_rate(pc->clk);
> +	unsigned long long period;
>  	unsigned long scaler;
> -	u32 period;
> +	u32 val;
> =20
>  	if (!rate) {
>  		dev_err(pc->dev, "failed to get clock rate\n");
> @@ -72,65 +74,43 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	}
> =20
>  	scaler =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
> -	period =3D DIV_ROUND_CLOSEST(period_ns, scaler);
> +	/* set period */
> +	period =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> =20
> -	if (period < PERIOD_MIN)
> +	/* dont accept a period that is too small or has been truncated */
> +	if ((period < PERIOD_MIN) || (period > U32_MAX))
>  		return -EINVAL;
> =20
> -	writel(DIV_ROUND_CLOSEST(duty_ns, scaler),
> -	       pc->base + DUTY(pwm->hwpwm));
> -	writel(period, pc->base + PERIOD(pwm->hwpwm));
> -
> -	return 0;
> -}
> -
> -static int bcm2835_pwm_enable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> -{
> -	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
> -	u32 value;
> -
> -	value =3D readl(pc->base + PWM_CONTROL);
> -	value |=3D PWM_ENABLE << PWM_CONTROL_SHIFT(pwm->hwpwm);
> -	writel(value, pc->base + PWM_CONTROL);
> -
> -	return 0;
> -}
> -
> -static void bcm2835_pwm_disable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> -{
> -	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
> -	u32 value;
> +	writel((u32) period, pc->base + PERIOD(pwm->hwpwm));

This cast isn't necessary. (And if it was, I *think* the space between
"(u32)" and "period" is wrong. But my expectation that checkpatch warns
about this is wrong, so take this with a grain of salt.)

> -	value =3D readl(pc->base + PWM_CONTROL);
> -	value &=3D ~(PWM_ENABLE << PWM_CONTROL_SHIFT(pwm->hwpwm));
> -	writel(value, pc->base + PWM_CONTROL);
> -}
> +	/* set duty cycle */
> +	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, scaler);
> +	writel(val, pc->base + DUTY(pwm->hwpwm));
> =20
> -static int bcm2835_set_polarity(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> -				enum pwm_polarity polarity)
> -{
> -	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
> -	u32 value;
> +	/* set polarity */
> +	val =3D readl(pc->base + PWM_CONTROL);
> =20
> -	value =3D readl(pc->base + PWM_CONTROL);
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		val &=3D ~(PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm));
> +	else
> +		val |=3D PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm);
> =20
> -	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> -		value &=3D ~(PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm));
> +	/* enable/disable */
> +	if (state->enabled)
> +		val |=3D PWM_ENABLE << PWM_CONTROL_SHIFT(pwm->hwpwm);
>  	else
> -		value |=3D PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm);
> +		val &=3D ~(PWM_ENABLE << PWM_CONTROL_SHIFT(pwm->hwpwm));
> =20
> -	writel(value, pc->base + PWM_CONTROL);
> +	writel(val, pc->base + PWM_CONTROL);
> =20
>  	return 0;
>  }
> =20
> +

I wouldn't have added this empty line. But I guess that's subjective. Or
did you add this by mistake?

>  static const struct pwm_ops bcm2835_pwm_ops =3D {
>  	.request =3D bcm2835_pwm_request,
>  	.free =3D bcm2835_pwm_free,
> -	.config =3D bcm2835_pwm_config,
> -	.enable =3D bcm2835_pwm_enable,
> -	.disable =3D bcm2835_pwm_disable,
> -	.set_polarity =3D bcm2835_set_polarity,
> +	.apply =3D bcm2835_pwm_apply,
>  	.owner =3D THIS_MODULE,
>  };

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2dgo6pzrzz5yxyxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/QdykACgkQwfwUeK3K
7AkPywf8Dzj3PZCI1FXSSWq7XojtMiHYjfwbB9wbON6qdC6v66hq0X5HMJyZj5qZ
uxtVSIA5Q5v5x6OFWVlezzeMapIux09Qyit5m53C67orAVXoW7vgi41n5An158oj
/KixR6hhj7SOn0YCYP/PFON4ve15vdlspDLFPhP2vcfnaxdjqLGO3zctlsEreZSQ
cBDDop3dSZvwxHCssqFD9JwHNka2z3Gko3bJRrGBTGNkNGioZGfn43/igU1u/YPY
UM1xMQWF3hjIvmtWjUQ9UrX4aolVM7LVN3ecrui+Ag0JdxvlNOKvPw2h/q7Uc04A
77Rmu+XD8LH4xs1yMppmSDNP16QxLA==
=wwYJ
-----END PGP SIGNATURE-----

--2dgo6pzrzz5yxyxt--
