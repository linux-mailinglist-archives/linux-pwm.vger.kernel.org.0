Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92426219B75
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgGIIuW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIIuS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 04:50:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D5C061A0B
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2020 01:50:18 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtSFw-0008EV-8U; Thu, 09 Jul 2020 10:50:12 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtSFq-0005Cr-D3; Thu, 09 Jul 2020 10:50:06 +0200
Date:   Thu, 9 Jul 2020 10:50:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 07/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200709085006.b54ype3p4yu64upl@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zo5wkjqhpntpevbs"
Content-Disposition: inline
In-Reply-To: <20200706175353.16404-8-michael@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zo5wkjqhpntpevbs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Mon, Jul 06, 2020 at 07:53:47PM +0200, Michael Walle wrote:
> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> new file mode 100644
> index 000000000000..8ee286b605bf
> --- /dev/null
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld PWM driver
> + *
> + * Copyright 2020 Kontron Europe GmbH
> + */

Is there publically available documenation available? If so please add a
link here.

> +
> +#include <linux/bitfield.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * PWM timer block registers.
> + */
> +#define PWM_CTRL		0x00
> +#define   PWM_ENABLE		BIT(7)
> +#define   PWM_MODE_250HZ	0
> +#define   PWM_MODE_500HZ	1
> +#define   PWM_MODE_1KHZ		2
> +#define   PWM_MODE_2KHZ		3
> +#define   PWM_MODE_MASK		GENMASK(1, 0)
> +#define PWM_CYCLE		0x01
> +#define   PWM_CYCLE_MAX		0x7f

Please use a less generic prefix for your defines. Also I like having
the defines for field names include register name. Something like:

	#define PWM_SL28CPLD_CTRL		0x00
	#define PWM_SL28CPLD_CTRL_ENABLE		BIT(7)
	#define PWM_SL28CPLD_CTRL_MODE_MASK		GENMASK(1, 0)
	#define PWM_SL28CPLD_CTRL_MODE_250HZ		FIELD_PREP(PWM_SL28CPLD_CTRL_MODE_MA=
SK, 0)

> +struct sl28cpld_pwm {
> +	struct pwm_chip pwm_chip;
> +	struct regmap *regmap;
> +	u32 offset;
> +};
> +
> +struct sl28cpld_pwm_periods {
> +	u8 ctrl;
> +	unsigned long duty_cycle;
> +};
> +
> +struct sl28cpld_pwm_config {
> +	unsigned long period_ns;
> +	u8 max_duty_cycle;
> +};
> +
> +static struct sl28cpld_pwm_config sl28cpld_pwm_config[] =3D {

const ? (Or drop as the values can be easily computed, see below.)

> +	[PWM_MODE_250HZ] =3D { .period_ns =3D 4000000, .max_duty_cycle =3D 0x80=
 },
> +	[PWM_MODE_500HZ] =3D { .period_ns =3D 2000000, .max_duty_cycle =3D 0x40=
 },
> +	[PWM_MODE_1KHZ]  =3D { .period_ns =3D 1000000, .max_duty_cycle =3D 0x20=
 },
> +	[PWM_MODE_2KHZ]  =3D { .period_ns =3D  500000, .max_duty_cycle =3D 0x10=
 },
> +};
> +
> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> +	static struct sl28cpld_pwm_config *config;
> +	unsigned int reg;
> +	unsigned int mode;
> +
> +	regmap_read(priv->regmap, priv->offset + PWM_CTRL, &reg);
> +
> +	state->enabled =3D reg & PWM_ENABLE;

Would it be more consisted to use FIELD_GET here, too?

> +
> +	mode =3D FIELD_GET(PWM_MODE_MASK, reg);
> +	config =3D &sl28cpld_pwm_config[mode];
> +	state->period =3D config->period_ns;

I wonder if this could be done more effectively without the above table.
Something like:

	state->period =3D 4000000 >> mode.
=09
(with a #define for 4000000 of course).

> +	regmap_read(priv->regmap, priv->offset + PWM_CYCLE, &reg);
> +	pwm_set_relative_duty_cycle(state, reg, config->max_duty_cycle);

Oh, what a creative idea to use pwm_set_relative_duty_cycle here.
Unfortunately it's using the wrong rounding strategy. Please enable
PWM_DEBUG which should diagnose these problems (given enough testing).

(Hmm, on second thought I'm not sure that rounding is relevant with the
numbers of this hardware. Still it's wrong in general and I don't want
to have others copy this.)

> +}
> +
> +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> +	struct sl28cpld_pwm_config *config;
> +	unsigned int cycle;
> +	int ret;
> +	int mode;
> +	u8 ctrl;
> +
> +	/* Get the configuration by comparing the period */
> +	for (mode =3D 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
> +		config =3D &sl28cpld_pwm_config[mode];
> +		if (state->period =3D=3D config->period_ns)
> +			break;
> +	}
> +
> +	if (mode =3D=3D ARRAY_SIZE(sl28cpld_pwm_config))
> +		return -EINVAL;

You're supposed to pick the biggest period that isn't bigger than the
requested period. So something like:

	switch(period) {
	case 4000000 ... UINT_MAX:
		mode =3D 0;
		break;
	case 2000000 ... 3999999:
		mode =3D 1;
		break;
	...
	}

(or:

	if period >=3D 4000000:
		mode =3D 0
	else:
		// I think ... please double-check
		mode =3D ilog2(4000000 / (period + 1)) + 1

	if mode > 3:
		return -ERANGE;
)

	real_period =3D 4000000 >> mode;

> +	ctrl =3D FIELD_PREP(PWM_MODE_MASK, mode);
> +	if (state->enabled)
> +		ctrl |=3D PWM_ENABLE;
> +
> +	cycle =3D pwm_get_relative_duty_cycle(state, config->max_duty_cycle);

Again the rounding is wrong. You need need to round down the requested
duty_cycle to the next possible value. So something like:

	duty_cycle =3D min(real_period, state->duty_cycle);

	cycle =3D duty_cycle * (0x80 >> mode) / (4000000 >> mode);

which can be further simplified to

	cycle =3D duty_cycle / 31250

=2E

> +	/*
> +	 * The hardware doesn't allow to set max_duty_cycle if the
> +	 * 250Hz mode is enabled, thus we have to trap that here.
> +	 * But because a 100% duty cycle is equal on all modes, i.e.

It depends on how picky you are if you can agree here. Please document
this in a Limitations paragraph at the top of the driver similar to
drivers/pwm/pwm-rcar.c and others.

> +	 * it is just a "all-high" output, we trap any case with a
> +	 * 100% duty cycle and use the 500Hz mode.

Please only trap on 250Hz mode. (Can be done using: if (cycle =3D=3D 0x80) I
think)

> +	 */
> +	if (cycle =3D=3D config->max_duty_cycle) {
> +		ctrl &=3D ~PWM_MODE_MASK;
> +		ctrl |=3D FIELD_PREP(PWM_MODE_MASK, PWM_MODE_500HZ);
> +		cycle =3D PWM_CYCLE_MAX;
=09
I would have expected 0x40 here instead of 0x7f?

> +	}
> +
> +	ret =3D regmap_write(priv->regmap, priv->offset + PWM_CTRL, ctrl);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(priv->regmap, priv->offset + PWM_CYCLE, (u8)cycle);

I assume this can result in broken output? Consider the hardware runs
with mode =3D 1 & cycle =3D 0x23 and you want to go to mode =3D 0 & cycle =
=3D
0x42: Can this result in a period that has mode =3D 0 & cycle =3D 0x23?

If this cannot be avoided, please document this in the Limitations
paragraph.

> +}
> +
> +static const struct pwm_ops sl28cpld_pwm_ops =3D {
> +	.apply =3D sl28cpld_pwm_apply,
> +	.get_state =3D sl28cpld_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int sl28cpld_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_pwm *priv;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!priv->regmap)
> +		return -ENODEV;
> +
> +	ret =3D device_property_read_u32(&pdev->dev, "reg", &priv->offset);
> +	if (ret)
> +		return -EINVAL;
> +
> +	/* Initialize the pwm_chip structure */
> +	chip =3D &priv->pwm_chip;
> +	chip->dev =3D &pdev->dev;
> +	chip->ops =3D &sl28cpld_pwm_ops;
> +	chip->base =3D -1;
> +	chip->npwm =3D 1;
> +
> +	ret =3D pwmchip_add(&priv->pwm_chip);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}

Please add error messages with some details for the error paths
(preferable using %pe to indicate the error code).

> +static int sl28cpld_pwm_remove(struct platform_device *pdev)
> +{
> +	struct sl28cpld_pwm *priv =3D platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&priv->pwm_chip);
> +}
> +
> +static const struct of_device_id sl28cpld_pwm_of_match[] =3D {
> +	{ .compatible =3D "kontron,sl28cpld-pwm" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
> +
> +static struct platform_driver sl28cpld_pwm_driver =3D {
> +	.probe =3D sl28cpld_pwm_probe,
> +	.remove	=3D sl28cpld_pwm_remove,
> +	.driver =3D {
> +		.name =3D "sl28cpld-pwm",
> +		.of_match_table =3D sl28cpld_pwm_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_pwm_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld PWM Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zo5wkjqhpntpevbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8G2joACgkQwfwUeK3K
7AmJGgf/WBxR5LIpn0VH8Eu7pe5XA6Ic/I7iL7pbWV+u7KttKvKeJSKDQP+Rj7w/
oTgVpPOzquY7nsgi8Xc+X980NILKIg3h/GOOWCie31utloJHocy4Xva3W4AtfJFi
vtu5Aeunx9zaStCDvwrA/5QKsxYuMSAKWoTqzRW8gdGyyUFKG5rnS4Sz5A1Zk7Tj
kv2pVpbVAU4JsnS8FUGQnXG32UhrZddYZKb6h6NoOIP13OybadiQ11dcsfrjguPg
0NgNL+VHwM1nFEOOTza5u3WfaEXSFIInFev55g3TYnjOIk1mY980eNLc682VqhZX
djlTan09K0g6k9nD5qjkmhAT8tntQw==
=pWwP
-----END PGP SIGNATURE-----

--zo5wkjqhpntpevbs--
