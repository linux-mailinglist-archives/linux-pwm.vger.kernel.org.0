Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD823045E
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgG1HoE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgG1HoA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 03:44:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B918C061794
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 00:44:00 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0KHD-0007eB-9w; Tue, 28 Jul 2020 09:43:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0KHA-0005TR-HV; Tue, 28 Jul 2020 09:43:52 +0200
Date:   Tue, 28 Jul 2020 09:43:52 +0200
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200728074352.ckyfso5zwsfgupjx@pengutronix.de>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-7-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ieqxdi6df6wn4p4j"
Content-Disposition: inline
In-Reply-To: <20200725231834.25642-7-michael@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ieqxdi6df6wn4p4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a few minor issues left:

On Sun, Jul 26, 2020 at 01:18:27AM +0200, Michael Walle wrote:
> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> new file mode 100644
> index 000000000000..956fa09f3aba
> --- /dev/null
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld PWM driver
> + *
> + * Copyright (c) 2020 Michael Walle <michael@walle.cc>
> + *
> + * There is no public datasheet available for this PWM core. But it is e=
asy
> + * enough to be briefly explained. It consists of one 8-bit counter. The=
 PWM
> + * supports four distinct frequencies by selecting when to reset the cou=
nter.
> + * With the prescaler setting you can select which bit of the counter is=
 used
> + * to reset it. This implies that the higher the frequency the less rema=
ining
> + * bits are available for the actual counter.
> + *
> + * Let cnt[7:0] be the counter, clocked at 32kHz:
> + * +-----------+--------+--------------+-----------+
> + * | prescaler |  reset | counter bits | frequency |
> + * +-----------+--------+--------------+-----------+
> + * |         0 | cnt[7] |     cnt[6:0] |     250Hz |
> + * |         1 | cnt[6] |     cnt[5:0] |     500Hz |
> + * |         2 | cnt[5] |     cnt[4:0] |      1kHz |
> + * |         3 | cnt[4] |     cnt[3:0] |      2kHz |
> + * +-----------+--------+--------------+-----------+

Very nice. I'd add a "period length" column, as this is what the PWM
core uses.

For your convenience (and as I created that table anyhow for further
checking of the formulas below):

 * +-----------+--------+--------------+-----------+--------+
 * | prescaler |  reset | counter bits | frequency | period |
 * |           |        |              |           | length |
 * +-----------+--------+--------------+-----------+--------+
 * |         0 | cnt[7] |     cnt[6:0] |     250Hz | 4000ns |
 * |         1 | cnt[6] |     cnt[5:0] |     500Hz | 2000ns |
 * |         2 | cnt[5] |     cnt[4:0] |      1kHz | 1000ns |
 * |         3 | cnt[4] |     cnt[3:0] |      2kHz |  500ns |
 * +-----------+--------+--------------+-----------+--------+

> + *
> + * Limitations:
> + * - The hardware cannot generate a 100% duty cycle if the prescaler is =
0.
> + * - The hardware cannot atomically set the prescaler and the counter va=
lue,
> + *   which might lead to glitches and inconsistent states if a write fai=
ls.
> + * - The counter is not reset if you switch the prescaler which leads
> + *   to glitches, too.
> + * - The duty cycle will switch immediately and not after a complete cyc=
le.
> + * - Depending on the actual implementation, disabling the PWM might have
> + *   side effects. For example, if the output pin is shared with a GPIO =
pin
> + *   it will automatically switch back to GPIO mode.
> + */
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
> +#define SL28CPLD_PWM_CTRL			0x00
> +#define   SL28CPLD_PWM_CTRL_ENABLE		BIT(7)
> +#define   SL28CPLD_PWM_CTRL_PRESCALER_MASK	GENMASK(1, 0)
> +#define SL28CPLD_PWM_CYCLE			0x01
> +#define   SL28CPLD_PWM_CYCLE_MAX		GENMASK(6, 0)
> +
> +#define SL28CPLD_PWM_CLK			32000 /* 32 kHz */
> +#define SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler)	(1 << (7 - (prescaler)))
> +#define SL28CPLD_PWM_PERIOD(prescaler) \
> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * SL28CPLD_PWM_MAX_DUTY_CYCLE(prescale=
r))
> +
> +/*
> + * We calculate the duty cycle like this:
> + *   duty_cycle_ns =3D pwm_cycle_reg * max_period_ns / max_duty_cycle
> + *
> + * With
> + *   max_period_ns =3D (1 << 7 - prescaler) / pwm_clk * NSEC_PER_SEC
> + *   max_duty_cycle =3D 1 << (7 - prescaler)

If you don't need parenthesis in the max_period_ns around 7 - prescaler,
you don't need them either in the max_duty_cycle line.

> + * this then simplifies to:
> + *   duty_cycle_ns =3D pwm_cycle_reg / pwm_clk * NSEC_PER_SEC
> + */
> +#define SL28CPLD_PWM_TO_DUTY_CYCLE(reg) \
> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg))

For those who copy from your driver maybe add a comment like:

 * NSEC_PER_SEC / SL28CPLD_PWM_CLK is integer here, so we're not loosing
 * precision by doing the division first.

> +#define SL28CPLD_PWM_FROM_DUTY_CYCLE(duty_cycle) \
> +	(DIV_ROUND_DOWN_ULL((duty_cycle), NSEC_PER_SEC / SL28CPLD_PWM_CLK))
> +
> +struct sl28cpld_pwm {
> +	struct pwm_chip pwm_chip;
> +	struct regmap *regmap;
> +	u32 offset;
> +};
> +
> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> +	unsigned int reg;
> +	int prescaler;
> +
> +	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, &reg);

Would it make sense to hide this using e.g.:

	#define sl28cpkd_pwm_read(priv, reg, val)	regmap_read((priv)->regmap, (pri=
v)->offset + (reg), val)

The line would then become:

	sl28cpkd_pwm_read(priv, SL28CPLD_PWM_CTRL, &reg);

which is a bit prettier. Up to you to decide. If you do it, please do
the same for write=20

> +	state->enabled =3D reg & SL28CPLD_PWM_CTRL_ENABLE;
> +
> +	prescaler =3D FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
> +	state->period =3D SL28CPLD_PWM_PERIOD(prescaler);
> +
> +	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, &reg);
> +	state->duty_cycle =3D SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> +	unsigned int cycle, prescaler;
> +	int ret;
> +	u8 ctrl;
> +
> +	/* Polarity inversion is not supported */
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/*
> +	 * Calculate the prescaler. Pick the the biggest period that isn't
> +	 * bigger than the requested period.
> +	 */
> +	prescaler =3D DIV_ROUND_UP_ULL(SL28CPLD_PWM_PERIOD(0), state->period);
> +	prescaler =3D order_base_2(prescaler);
> +
> +	if (prescaler > field_max(SL28CPLD_PWM_CTRL_PRESCALER_MASK))
> +		return -ERANGE;

The calculation looks right.
Did you check the generated code? Maybe using an if or switch here is
more effective? (optional task for bonus points :-)

> +	ctrl =3D FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, prescaler);
> +	if (state->enabled)
> +		ctrl |=3D SL28CPLD_PWM_CTRL_ENABLE;
> +
> +	cycle =3D SL28CPLD_PWM_FROM_DUTY_CYCLE(state->duty_cycle);
> +	cycle =3D min_t(unsigned int, cycle, SL28CPLD_PWM_MAX_DUTY_CYCLE(presca=
ler));
> +
> +	/*
> +	 * Work around the hardware limitation. See also above. Trap 100% duty
> +	 * cycle if the prescaler is 0. Set prescaler to 1 instead. We don't
> +	 * care about the frequency because its "all-one" in either case.
> +	 *
> +	 * We don't need to check the actual prescaler setting, because only
> +	 * if the prescaler is 0 we can have this particular value.
> +	 */
> +	if (cycle =3D=3D SL28CPLD_PWM_MAX_DUTY_CYCLE(0)) {
> +		ctrl &=3D ~SL28CPLD_PWM_CTRL_PRESCALER_MASK;
> +		ctrl |=3D FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, 1);
> +		cycle =3D SL28CPLD_PWM_MAX_DUTY_CYCLE(1);
> +	}
> +
> +	ret =3D regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, ct=
rl);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, (u=
8)cycle);

This cast isn't needed, is it?

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

Error message here?

> +		return -ENODEV;
> +
> +	ret =3D device_property_read_u32(&pdev->dev, "reg", &priv->offset);
> +	if (ret) {
> +		dev_err(&pdev->dev, "no 'reg' property found (%pe)\n",
> +			ERR_PTR(ret));
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize the pwm_chip structure */
> +	chip =3D &priv->pwm_chip;
> +	chip->dev =3D &pdev->dev;
> +	chip->ops =3D &sl28cpld_pwm_ops;
> +	chip->base =3D -1;
> +	chip->npwm =3D 1;
> +
> +	ret =3D pwmchip_add(&priv->pwm_chip);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add PWM chip (%pe)",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
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

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ieqxdi6df6wn4p4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8f1zUACgkQwfwUeK3K
7AldKgf+LJO55bS0rWoi7kWDwlvUdb79pxs1XfYkg0B40xmCUURauCWGMK2o7HsJ
N91DQobr7hd/umspwTgQ6+iDh2KTigrk1D0OAgg/sXxvd4CAX0CiqFF4vmYMTLjQ
bADecGbQxFXk74EXytpNRR6zum43PgwiCYvfVgbGhRZP/mZrNER10+PZctHZBr9h
99xLEOgd6tW3QjkoQWbuM3AzYaiPSjjPl4eKlK1ylRco+MDiaDlTrkflpBSzAMX6
ew9AhP/YJW/A6F2027xn5v49w5X6Kw0iOHItzcP9ULw3FSRxfEp+Gf2eZwozA/bd
AVBzzi4LuULQZuyQu4Fl08pmdkTIog==
=xkzL
-----END PGP SIGNATURE-----

--ieqxdi6df6wn4p4j--
