Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF42D3C2D
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Dec 2020 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgLIH3Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Dec 2020 02:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLIH3Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Dec 2020 02:29:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761DC0613CF
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 23:28:44 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmtty-0001P7-S1; Wed, 09 Dec 2020 08:28:42 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmtty-0006jw-8d; Wed, 09 Dec 2020 08:28:42 +0100
Date:   Wed, 9 Dec 2020 08:28:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] pwm: pwm-gpio: New driver
Message-ID: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
References: <20201205214353.xapax46tt5snzd2v@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ytnl22zzmog3och"
Content-Disposition: inline
In-Reply-To: <20201205214353.xapax46tt5snzd2v@einstein.dilieto.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3ytnl22zzmog3och
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicola,

On Sat, Dec 05, 2020 at 10:43:53PM +0100, Nicola Di Lieto wrote:
> This new driver allows pulse width modulating any GPIOs using
> a high resolution timer. It is fully generic and can be useful
> in a variety of situations. As an example I used it to provide
> a pwm to the pwm-beeper driver so that my embedded system can
> produce tones through a piezo buzzer connected to a GPIO which
> unfortunately is not hardware PWM capable.
>=20
> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> ---
> MAINTAINERS            |   7 ++
> drivers/pwm/Kconfig    |  10 +++
> drivers/pwm/Makefile   |   1 +
> drivers/pwm/pwm-gpio.c | 172 ++++++++++++++++++++++++++++++++++++++++++++=
+++++
> 4 files changed, 190 insertions(+)
> create mode 100644 drivers/pwm/pwm-gpio.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebe4829cdd4d..fe9b5b00ba94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14215,6 +14215,13 @@ F:	Documentation/devicetree/bindings/hwmon/pwm-f=
an.txt
> F:	Documentation/hwmon/pwm-fan.rst
> F:	drivers/hwmon/pwm-fan.c
>=20

The patch is whitespace damaged. Also it would be good if the patch set
was sent in a single mail thread. I suggest you look into git-send-email
for the next round.

> +PWM GPIO DRIVER
> +M:	Nicola Di Lieto <nicola.dilieto@gmail.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> +F:	drivers/pwm/pwm-gpio.c
> +
> PWM IR Transmitter
> M:	Sean Young <sean@mess.org>
> L:	linux-media@vger.kernel.org
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..5432084c6276 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -181,6 +181,16 @@ config PWM_FSL_FTM
> 	  To compile this driver as a module, choose M here: the module
> 	  will be called pwm-fsl-ftm.
>=20
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
> config PWM_HIBVT
> 	tristate "HiSilicon BVT PWM support"
> 	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index cbdcd55d69ee..eea0216215a7 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
> obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
> obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
> +obj-$(CONFIG_PWM_GPIO)		+=3D pwm-gpio.o
> obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
> obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
> new file mode 100644
> index 000000000000..6f425f2d02fe
> --- /dev/null
> +++ b/drivers/pwm/pwm-gpio.c
> @@ -0,0 +1,172 @@
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
> +#include <linux/workqueue.h>
> +
> +struct pwm_gpio {
> +	struct pwm_chip chip;
> +	struct gpio_desc *desc;
> +	struct work_struct work;
> +	struct hrtimer timer;
> +	atomic_t enabled;
> +	u64 ton_ns;
> +	u64 toff_ns;
> +	enum pwm_polarity polarity;
> +	bool output;
> +};
> +
> +static void pwm_gpio_work(struct work_struct *work)
> +{
> +	struct pwm_gpio *pwm_gpio =3D container_of(work, struct pwm_gpio, work);
> +
> +	gpiod_set_value_cansleep(pwm_gpio->desc,
> +		(pwm_gpio->polarity =3D=3D PWM_POLARITY_INVERSED) ^ pwm_gpio->output);
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
> +	if (pwm_gpio->output) {
> +		ns =3D pwm_gpio->toff_ns;
> +		pwm_gpio->output =3D false;
> +	} else {
> +		ns =3D pwm_gpio->ton_ns;
> +		pwm_gpio->output =3D true;
> +	}
> +
> +	schedule_work(&pwm_gpio->work);
> +	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns));
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static inline struct pwm_gpio *to_pwm_gpio(struct pwm_chip *_chip)

If you rename this to "pwm_gpio_from_chip" it shares the prefix that all
other functions and global variables in your driver use.

> +{
> +	return container_of(_chip, struct pwm_gpio, chip);
> +}
> +
> +static void pwm_gpio_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct pwm_gpio *pwm_gpio =3D to_pwm_gpio(chip);
> +
> +	cancel_work_sync(&pwm_gpio->work);
> +	gpiod_set_value_cansleep(pwm_gpio->desc,
> +		pwm_gpio->polarity =3D=3D PWM_POLARITY_INVERSED);
> +}
> +
> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct pwm_gpio *pwm_gpio =3D to_pwm_gpio(chip);
> +	u64 period =3D clamp(state->period, U64_C(50000), U64_C(1000000000));

=2Eapply is expected to implement the biggest period that is not bigger
than the requested period. So clamping to a value > 50000 is wrong.

Also the (arbitrary?) choice to not implement periods < 50 =B5s needs a
comment. (I assume it is something like: the pwm-gpio driver suffers
=66rom latency in the timer and gpio frameworks, smaller periods are
expected to be impossible to be implemented.)

> +	u64 duty_cycle =3D clamp(state->duty_cycle, U64_C(0), period);

If you consider that a period < 50 =B5s is problematic, I wonder if you
have similar concerns for a duty_cycle of 25 =B5s.

> +	pwm_gpio->ton_ns =3D duty_cycle;
> +	pwm_gpio->toff_ns =3D period - duty_cycle;

If the timer triggers here it has an inconsistent view because ton and
toff are already updated, but polarity isn't.

> +	pwm_gpio->polarity =3D state->polarity;
> +
> +	if (state->enabled && !atomic_read(&pwm_gpio->enabled)) {
> +		atomic_set(&pwm_gpio->enabled, 1);
> +		hrtimer_start(&pwm_gpio->timer, 0, HRTIMER_MODE_REL);
> +	} else if (!state->enabled && atomic_read(&pwm_gpio->enabled)) {
> +		atomic_set(&pwm_gpio->enabled, 0);
> +		pwm_gpio->output =3D false;
> +		schedule_work(&pwm_gpio->work);
> +	}

It's not obvious to me that this driver completes the currently running
period before the new setting takes effect. If you think it is, please
make the mechanism more obvious in a comment, if it isn't, please fix.

> +	return 0;
> +}
> +
> +static void pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct pwm_gpio *pwm_gpio =3D to_pwm_gpio(chip);
> +
> +	state->duty_cycle =3D pwm_gpio->ton_ns;
> +	state->period =3D pwm_gpio->ton_ns + pwm_gpio->toff_ns;
> +	state->polarity =3D pwm_gpio->polarity;
> +	state->enabled =3D atomic_read(&pwm_gpio->enabled);
> +}
> +
> +static const struct pwm_ops pwm_gpio_ops =3D {
> +	.free =3D pwm_gpio_free,
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

	pwm_gpio->base =3D -1;

> +	platform_set_drvdata(pdev, pwm_gpio);
> +
> +	return pwmchip_add(&pwm_gpio->chip);
> +}
> +
> +static int pwm_gpio_remove(struct platform_device *pdev)
> +{
> +	struct pwm_gpio *pwm_gpio =3D platform_get_drvdata(pdev);
> +
> +	hrtimer_cancel(&pwm_gpio->timer);
> +
> +	return pwmchip_remove(&pwm_gpio->chip);

Please swap the order of hrtimer_cancel and pwmchip_remove to have it in
reverse order to the allocation in .probe and to make the PWM
unfunctional only after the pwmchip is unregistered.

> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id pwm_gpio_of_match[] =3D {
> +	{ .compatible =3D "pwm-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_gpio_of_match);
> +#endif
> +
> +static struct platform_driver pwm_gpio_driver =3D {
> +	.probe =3D pwm_gpio_probe,
> +	.remove =3D pwm_gpio_remove,
> +	.driver =3D {
> +		.name =3D "pwm-gpio",
> +		.of_match_table =3D of_match_ptr(pwm_gpio_of_match),
> +	},
> +};
> +module_platform_driver(pwm_gpio_driver);
> +
> +MODULE_DESCRIPTION("PWM GPIO driver");
> +MODULE_ALIAS("platform:pwm-gpio");
> +MODULE_AUTHOR("Nicola Di Lieto");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3ytnl22zzmog3och
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/QfKcACgkQwfwUeK3K
7AmFqAgAiJEsMQwfNFNfkGjj3V89hEyg/GUqbWGUhoapw9+pyPiA8E2mggEdVsTk
GNf9yjBPknFiym175CXZn/ikik1hGBTE5BROuBuhHB6e9Os6cWNB3xaKP9Ic0i9Z
PvrkkXT8i7IdGwmxKMjCE3GoU+lorTV9EFHB2J6vojd/vvwTbkodcZDF7rFoTwTn
UBFCgRdmL7Df5RKAp/r1dvztO7OhDJoF10gn85g61mbUyAylCRosE/zXhqbbQ6E4
NBwuv0L/8wgPyD2z9hfjD2L4I7LJDAz4XiMO+ue3sVIXh0BnOCA0NxzB+KPN1End
RrPSc0heC9gtU3z5CRDWs1OidX/0Zw==
=L3mc
-----END PGP SIGNATURE-----

--3ytnl22zzmog3och--
