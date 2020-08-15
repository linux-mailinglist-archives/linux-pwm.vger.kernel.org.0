Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2395245362
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Aug 2020 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgHOWA6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Aug 2020 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgHOVvd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Aug 2020 17:51:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9326C03B3C7
        for <linux-pwm@vger.kernel.org>; Sat, 15 Aug 2020 00:50:49 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k6qxZ-0008Au-Ql; Sat, 15 Aug 2020 09:50:37 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k6qxW-0005H6-Cf; Sat, 15 Aug 2020 09:50:34 +0200
Date:   Sat, 15 Aug 2020 09:50:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, kernel@axis.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, oliver@schinagl.nl
Subject: Re: [PATCH 2/2] pwm: Add GPIO PWM driver
Message-ID: <20200815075032.k2xyw75l56sbl7nx@pengutronix.de>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200814155513.31936-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rf5behupqocofi63"
Content-Disposition: inline
In-Reply-To: <20200814155513.31936-2-vincent.whitchurch@axis.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rf5behupqocofi63
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 14, 2020 at 05:55:13PM +0200, Vincent Whitchurch wrote:
> Add a software PWM which toggles a GPIO from a high-resolution timer.
>=20
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
>=20
> Since high-resolution timers are used, sleeping gpio chips are not
> supported and are rejected in the probe function.
>=20
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Nice idea. IMHO this can serve as example about what we expect from pwm
drivers. There is some improvement necessary however to reach that
state.

> ---
> While preparing this driver for posting, I found a pwm-gpio driver posted=
 to
> the lists way back in 2015 by Olliver Schinagl:
>=20
>  https://lore.kernel.org/linux-pwm/1445895161-2317-8-git-send-email-o.sch=
inagl@ultimaker.com/
>=20
> This driver was developed independently, but since both drivers are trivi=
al
> they are quite similar.  The main difference I see (apart from the usage =
of
> newer APIs and DT schemas) is that this driver only supports one PWM per
> instance, which makes for simpler code.  I also reject sleeping GPIO chips
> explicitly while that driver uses gpio_set_value_cansleep() from a hrtime=
r,
> which is a no-no.
>=20
>  drivers/pwm/Kconfig    |  10 ++++
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-gpio.c | 123 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 drivers/pwm/pwm-gpio.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf6973d33..20e4fda82e61 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -181,6 +181,16 @@ config PWM_FSL_FTM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-fsl-ftm.
> =20
> +config PWM_GPIO
> +	tristate "GPIO PWM support"
> +	depends on OF && GPIOLIB
> +	help
> +	  Generic PWM framework driver for a software PWM toggling a GPIO pin
> +	  from kernel high-resolution timers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-gpio.
> +
>  config PWM_HIBVT
>  	tristate "HiSilicon BVT PWM support"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a03557..2e045f063cd1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
> +obj-$(CONFIG_PWM_GPIO)		+=3D pwm-gpio.o
>  obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
>  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
> new file mode 100644
> index 000000000000..e579aca0f937
> --- /dev/null
> +++ b/drivers/pwm/pwm-gpio.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2020 Axis Communications AB */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/hrtimer.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/pwm.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +
> +struct pwm_gpio {
> +	struct pwm_chip chip;
> +	struct hrtimer hrtimer;
> +	struct gpio_desc *gpio;
> +	ktime_t on_interval;
> +	ktime_t off_interval;
> +	bool invert;
> +	bool on;
> +};
> +
> +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *hrtimer)
> +{
> +	struct pwm_gpio *gpwm =3D container_of(hrtimer, struct pwm_gpio, hrtime=
r);
> +	bool newon =3D !gpwm->on;
> +
> +	gpwm->on =3D newon;
> +	gpiod_set_value(gpwm->gpio, newon ^ gpwm->invert);
> +
> +	hrtimer_forward_now(hrtimer, newon ? gpwm->on_interval : gpwm->off_inte=
rval);

If I understand correct this adds the new interval on top of "now" and
not on top of the previous timestamp where an edge was expected. Would
it make sense to change that?

> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
> +
> +	hrtimer_cancel(&gpwm->hrtimer);
> +
> +	if (!state->enabled) {
> +		gpiod_set_value(gpwm->gpio, 0);
> +		return 0;
> +	}
> +
> +	gpwm->on_interval =3D ns_to_ktime(state->duty_cycle);
> +	gpwm->off_interval =3D ns_to_ktime(state->period - state->duty_cycle);
> +	gpwm->invert =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
> +
> +	gpwm->on =3D !!gpwm->on_interval;
> +	gpiod_set_value(gpwm->gpio, gpwm->on ^ gpwm->invert);
> +
> +	if (gpwm->on_interval && gpwm->off_interval)
> +		hrtimer_start(&gpwm->hrtimer, gpwm->on_interval, HRTIMER_MODE_REL);

Ideally the currently running period is completed before a period with
the new configuration starts. Would be nice switch only on the next
period end if the current configuration is enabled.

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_gpio_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.apply =3D pwm_gpio_apply,

Usually a .get_state callback is nice. Does it make sense to do
something like:

	if (driver is up)
		report current setting
	else
		val =3D gpio_get_value()
		report(period=3D1, duty_cycle=3Dval, enabled=3Dval, polarity=3DNORMAL)

?

> +};
> +
> +static int pwm_gpio_probe(struct platform_device *pdev)
> +{
> +	struct pwm_gpio *gpwm;
> +	int ret;
> +
> +	gpwm =3D devm_kzalloc(&pdev->dev, sizeof(*gpwm), GFP_KERNEL);
> +	if (!gpwm)
> +		return -ENOMEM;
> +
> +	gpwm->gpio =3D devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
> +	if (IS_ERR(gpwm->gpio))
> +		return PTR_ERR(gpwm->gpio);
> +
> +	if (gpiod_cansleep(gpwm->gpio))
> +		return -EINVAL;
> +
> +	gpwm->chip.dev =3D &pdev->dev;
> +	gpwm->chip.ops =3D &pwm_gpio_ops;
> +	gpwm->chip.base =3D pdev->id;
> +	gpwm->chip.npwm =3D 1;
> +
> +	hrtimer_init(&gpwm->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	gpwm->hrtimer.function =3D pwm_gpio_timer;
> +
> +	ret =3D pwmchip_add(&gpwm->chip);
> +	if (ret < 0)
> +		return ret;

Error messages in the error paths please (preferably using
dev_err_probe).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rf5behupqocofi63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl83k8UACgkQwfwUeK3K
7AmO4ggAlGQT0fMUFlmyKSdE6QjeZrDtyDSIyjZWS+PoicZ3xRQvF6X/Dvg4+QIL
Q9+oSCx0gZqFUvqId/giJYlzbb+LtGkGbdrTJFHs0Fhd6HaUHO1JHqjlqGH2zuEx
ZmvlkCPzr/b+HBK2uNz8PT/mk5RzOb31aQAjREgUXxRCNa2jaw1ec7KKso/uoez8
w03RzCO4MEhLBBmBkhcWhVGNMaZ/5VosDaEJCpsPfuft8JI808Ek6hMQE0JIXn16
AMqITGVdyZYloabrMy+8KkcJHSEDDN/WOqR0Kqq2IbLgBKngMBwyQ0dcGrV1jTuF
wfbek89lLGGgn5gHuXOoVLkYVQuGNQ==
=xFtm
-----END PGP SIGNATURE-----

--rf5behupqocofi63--
