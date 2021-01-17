Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24242F9266
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 14:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbhAQNFW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 08:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbhAQNFU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Jan 2021 08:05:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B08C061573
        for <linux-pwm@vger.kernel.org>; Sun, 17 Jan 2021 05:04:39 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l17jQ-0000Ic-65; Sun, 17 Jan 2021 14:04:36 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l17jO-0005ho-Ub; Sun, 17 Jan 2021 14:04:34 +0100
Date:   Sun, 17 Jan 2021 14:04:34 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Message-ID: <20210117130434.663qpp6noujptdyt@pengutronix.de>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-2-nicola.dilieto@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fbpyp2dgzua7xjjj"
Content-Disposition: inline
In-Reply-To: <20201211170432.6113-2-nicola.dilieto@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fbpyp2dgzua7xjjj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[added the gpio people to Cc:]

On Fri, Dec 11, 2020 at 06:04:31PM +0100, Nicola Di Lieto wrote:
> This new driver allows pulse width modulating any GPIOs using
> a high resolution timer. It is fully generic and can be useful
> in a variety of situations. As an example I used it to provide
> a pwm to the pwm-beeper driver so that my embedded system can
> produce tones through a piezo buzzer connected to a GPIO which
> unfortunately is not hardware PWM capable.
>=20
> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> ---
>  MAINTAINERS            |   7 ++
>  drivers/pwm/Kconfig    |  10 +++
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-gpio.c | 188 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 drivers/pwm/pwm-gpio.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52086876ce40..486a8857b47b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14222,6 +14222,13 @@ F:	Documentation/devicetree/bindings/hwmon/pwm-f=
an.txt
>  F:	Documentation/hwmon/pwm-fan.rst
>  F:	drivers/hwmon/pwm-fan.c
> =20
> +PWM GPIO DRIVER
> +M:	Nicola Di Lieto <nicola.dilieto@gmail.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> +F:	drivers/pwm/pwm-gpio.c

Maybe only add the line for the binding doc in the second patch?

> +
>  PWM IR Transmitter
>  M:	Sean Young <sean@mess.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..5432084c6276 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -181,6 +181,16 @@ config PWM_FSL_FTM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-fsl-ftm.
> =20
> +config PWM_GPIO
> +	tristate "PWM GPIO support"
> +	depends on GPIOLIB
> +	depends on HIGH_RES_TIMERS
> +	help
> +	  Generic PWM for software modulation of GPIOs
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-gpio.
> +
>  config PWM_HIBVT
>  	tristate "HiSilicon BVT PWM support"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index cbdcd55d69ee..eea0216215a7 100644
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
> index 000000000000..06b4ddee389d
> --- /dev/null
> +++ b/drivers/pwm/pwm-gpio.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic software PWM for modulating GPIOs
> + *
> + * Copyright 2020 Nicola Di Lieto
> + *
> + * Author: Nicola Di Lieto <nicola.dilieto@gmail.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/hrtimer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +struct pwm_gpio {
> +	struct pwm_chip chip;
> +	struct gpio_desc *desc;
> +	struct work_struct work;
> +	struct hrtimer timer;
> +	atomic_t enabled;
> +	spinlock_t lock;
> +	struct {
> +		u64 ton_ns;
> +		u64 toff_ns;
> +		bool invert;
> +	} cur, new;
> +	bool state;
> +	bool output;
> +};

I would have called this struct pwm_gpio_ddata. Given that pwm_gpio is
the common prefix of all variables and functions in this driver,
pwm_gpio alone is a bit short.

> +static void pwm_gpio_work(struct work_struct *work)
> +{
> +	struct pwm_gpio *pwm_gpio =3D container_of(work, struct pwm_gpio, work);
> +
> +	gpiod_set_value_cansleep(pwm_gpio->desc, pwm_gpio->output);

Usually you want to check the return value of gpiod_set_value. @Linus +
Bartosz: What do you think, does it need checking for an error here?

> +}
> +
> +enum hrtimer_restart pwm_gpio_do_timer(struct hrtimer *handle)
> +{
> +	struct pwm_gpio *pwm_gpio =3D container_of(handle, struct pwm_gpio, tim=
er);
> +	u64 ns;
> +
> +	if (!atomic_read(&pwm_gpio->enabled))
> +		return HRTIMER_NORESTART;
> +
> +	if (pwm_gpio->state) {
> +		ns =3D pwm_gpio->cur.toff_ns;
> +		pwm_gpio->state =3D false;
> +	} else {
> +		if (spin_trylock(&pwm_gpio->lock)) {
> +			pwm_gpio->cur =3D pwm_gpio->new;
> +			spin_unlock(&pwm_gpio->lock);
> +		}
> +		ns =3D pwm_gpio->cur.ton_ns;
> +		pwm_gpio->state =3D true;
> +	}
> +	pwm_gpio->output =3D pwm_gpio->state ^ pwm_gpio->cur.invert;
> +
> +	schedule_work(&pwm_gpio->work);
> +	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns));

This is hard to understand. I think we need more comments explaining
(e.g.) the semantic of the members of struct pwm_gpio.

Does it make sense to use the workqueue only if the GPIO is a sleeping
one and for fast GPIOs call gpiod_set_value directly?

> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static inline struct pwm_gpio *pwm_gpio_from_chip(struct pwm_chip *_chip)
> +{
> +	return container_of(_chip, struct pwm_gpio, chip);
> +}
> +
> +static void pwm_gpio_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct pwm_gpio *pwm_gpio =3D pwm_gpio_from_chip(chip);
> +
> +	cancel_work_sync(&pwm_gpio->work);
> +	gpiod_set_value_cansleep(pwm_gpio->desc, pwm_gpio->cur.invert);
> +}
> +
> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct pwm_gpio *pwm_gpio =3D pwm_gpio_from_chip(chip);
> +
> +	spin_lock(&pwm_gpio->lock);
> +	pwm_gpio->new.ton_ns =3D state->duty_cycle;
> +	pwm_gpio->new.toff_ns =3D state->period - state->duty_cycle;
> +	pwm_gpio->new.invert =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED);
> +	spin_unlock(&pwm_gpio->lock);
> +
> +	if (state->enabled && !atomic_cmpxchg(&pwm_gpio->enabled, 0, 1)) {
> +		hrtimer_start(&pwm_gpio->timer, 0, HRTIMER_MODE_REL);
> +	} else if (!state->enabled && atomic_cmpxchg(&pwm_gpio->enabled, 1, 0))=
 {
> +		pwm_gpio->state =3D false;
> +		pwm_gpio->output =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED);
> +		schedule_work(&pwm_gpio->work);
> +	}
> +	return 0;
> +}
> +
> +static void pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct pwm_gpio *pwm_gpio =3D pwm_gpio_from_chip(chip);
> +
> +	state->duty_cycle =3D pwm_gpio->new.ton_ns;
> +	state->period =3D pwm_gpio->new.ton_ns + pwm_gpio->new.toff_ns;
> +	state->polarity =3D pwm_gpio->new.invert ? PWM_POLARITY_INVERSED
> +					       : PWM_POLARITY_NORMAL;
> +	state->enabled =3D atomic_read(&pwm_gpio->enabled);
> +}
> +
> +static const struct pwm_ops pwm_gpio_ops =3D {
> +	.free =3D pwm_gpio_free,

A free without request seems wrong. The callback stops the PWM, this is
wrong, the PWM should continue to toggle.

> +	.apply =3D pwm_gpio_apply,
> +	.get_state =3D pwm_gpio_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int pwm_gpio_probe(struct platform_device *pdev)
> +{
> +	struct pwm_gpio *pwm_gpio;
> +
> +	pwm_gpio =3D devm_kzalloc(&pdev->dev, sizeof(*pwm_gpio), GFP_KERNEL);
> +	if (!pwm_gpio)
> +		return -ENOMEM;
> +
> +	pwm_gpio->desc =3D devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
> +	if (IS_ERR(pwm_gpio->desc))
> +		return PTR_ERR(pwm_gpio->desc);
> +
> +	INIT_WORK(&pwm_gpio->work, pwm_gpio_work);
> +
> +	hrtimer_init(&pwm_gpio->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	pwm_gpio->timer.function =3D pwm_gpio_do_timer;
> +	pwm_gpio->chip.dev =3D &pdev->dev;
> +	pwm_gpio->chip.ops =3D &pwm_gpio_ops;
> +	pwm_gpio->chip.npwm =3D 1;
> +	pwm_gpio->chip.base =3D -1;
> +
> +	platform_set_drvdata(pdev, pwm_gpio);
> +
> +	spin_lock_init(&pwm_gpio->lock);
> +
> +	return pwmchip_add(&pwm_gpio->chip);

Error message please if pwmchip_add fails

> +}
> +
> +static int pwm_gpio_remove(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct pwm_gpio *pwm_gpio =3D platform_get_drvdata(pdev);
> +
> +	ret =3D pwmchip_remove(&pwm_gpio->chip);
> +	if (ret)
> +		return ret;

This exit path is bad. The return value of the remove callback is
ignored and after pwm_gpio_remove() returns the gpio and *pwm_gpio are
freed.

> +
> +	hrtimer_cancel(&pwm_gpio->timer);
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fbpyp2dgzua7xjjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAENeAACgkQwfwUeK3K
7AkN5Af+JrlCF0WV4QAKajELdSQXNClJEciMbCWfk4QjaJRl/caZ07tAEoXTIgpu
pquAPUuca1FP0EkB/KaDhHX/uEj5YKy6rjpeszWrg6MC6ATFU7li4QyQs4A/OPoW
bf+xCjP3ZJL8Ts6Qykk/oF9OqF/mB7CBugNKB7rLjlb1nFJE+Txd8Ui93eL4Zgb/
V8c6OW+I+sJn4qSZ16x/HpC39m4MnD+ekojblx7NwEiSNwVzHir9et+iDmUZkOAV
cqwx9P2ml8QxopTMTtJPnkAJ2yaYj0G+WsrxrqocUva1IkyxztMOl2ckf5ELtWz7
HJ6HLQ45TMT8CNc+ZWy0wJplO6Ef6g==
=oTwn
-----END PGP SIGNATURE-----

--fbpyp2dgzua7xjjj--
