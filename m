Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2E381988
	for <lists+linux-pwm@lfdr.de>; Sat, 15 May 2021 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhEOPUZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 May 2021 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhEOPUX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 May 2021 11:20:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916ECC06174A
        for <linux-pwm@vger.kernel.org>; Sat, 15 May 2021 08:19:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lhw3x-0007mt-Hz; Sat, 15 May 2021 17:18:45 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lhw3i-0005Ts-Iu; Sat, 15 May 2021 17:18:30 +0200
Date:   Sat, 15 May 2021 17:18:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        kernel@pengutronix.de
Subject: Re: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210515151827.amiqh6j6brv44jif@pengutronix.de>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xttmurqnkmfrurv7"
Content-Disposition: inline
In-Reply-To: <20210514024845.10531-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xttmurqnkmfrurv7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, May 14, 2021 at 10:48:45AM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig         |   8 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-aspeed-g6.c | 355 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 364 insertions(+)
>  create mode 100644 drivers/pwm/pwm-aspeed-g6.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..b0964b9a3273 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,14 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
> =20
> +config PWM_ASPEED_G6
> +	tristate "ASPEEDG6 PWM support"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for ASPEED G6 SoC.
> +
> +	  This driver provides support for ASPEED G6 PWM controllers.

The first sentence has little information, just the second is good
enough, maybe mention the module name as the other driver items do.

> +
>  config PWM_ATMEL
>  	tristate "Atmel PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index cbdcd55d69ee..29d22d806e68 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
> +obj-$(CONFIG_PWM_ASPEED_G6)	+=3D pwm-aspeed-g6.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> diff --git a/drivers/pwm/pwm-aspeed-g6.c b/drivers/pwm/pwm-aspeed-g6.c
> new file mode 100644
> index 000000000000..a3d0ad324a13
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-g6.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 ASPEED Technology Inc.
> + *
> + * PWM controller driver for Aspeed ast26xx SoCs.
> + * This drivers doesn't support earlier version of the IP.
> + *
> + * The formula of pwm frequency:
> + * PWM frequency =3D CLK Source / ((DIV_L + 1) * BIT(DIV_H) * (PERIOD + =
1))
> + *
> + * The software driver fixes the period to 255, which causes the high-fr=
equency
> + * precision of the PWM to be coarse, in exchange for the fineness of th=
e duty cycle.
> + *
> + * Register usage:
> + * PIN_ENABLE: When it is unset the pwm controller will always output lo=
w to the extern.
> + * Use to determine whether the PWM channel is enabled or disabled
> + * CLK_ENABLE: When it is unset the pwm controller will reset the duty c=
ounter to 0 and
> + * output low to the PIN_ENABLE mux after that the driver can still chan=
ge the pwm period
> + * and duty and the value will apply when CLK_ENABLE be set again.
> + * Use to determin whether duty_cycle bigger than 0.
> + * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will inv=
erse immediately.
> + * PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POIN=
T: When these two
> + * values are equal it means the duty cycle =3D 100%.
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we cannot prevent in
> + *   software that the output might produce a period with mixed
> + *   settings.
> + *
> + * Improvements:
> + * - When changing the duty cycle or period, our pwm controller will not
> + *   generate the glitch, the configure will change at next cycle of pwm.
> + *   This improvement can disable/enable through PWM_ASPEED_CTRL_DUTY_SY=
NC_DISABLE.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
> +#include <linux/reset.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
> +#include <linux/slab.h>
> +#include <linux/pwm.h>
> +
> +/* The channel number of Aspeed pwm controller */
> +#define PWM_ASPEED_NR_PWMS 16
> +
> +/* PWM Control Register */
> +#define PWM_ASPEED_CTRL_CH(ch) ((((ch)*0x10) + 0x00))

The outer parenthesis pair can be dropped.

> +#define PWM_ASPEED_CTRL_LOAD_SEL_RISING_AS_WDT BIT(19)
> +#define PWM_ASPEED_CTRL_DUTY_LOAD_AS_WDT_ENABLE BIT(18)
> +#define PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE BIT(17)
> +#define PWM_ASPEED_CTRL_CLK_ENABLE BIT(16)
> +#define PWM_ASPEED_CTRL_LEVEL_OUTPUT BIT(15)
> +#define PWM_ASPEED_CTRL_INVERSE BIT(14)
> +#define PWM_ASPEED_CTRL_OPEN_DRAIN_ENABLE BIT(13)
> +#define PWM_ASPEED_CTRL_PIN_ENABLE BIT(12)
> +#define PWM_ASPEED_CTRL_CLK_DIV_H GENMASK(11, 8)
> +#define PWM_ASPEED_CTRL_CLK_DIV_L GENMASK(7, 0)
> +
> +/* PWM Duty Cycle Register */
> +#define PWM_ASPEED_DUTY_CYCLE_CH(ch) ((((ch)*0x10) + 0x04))
> +#define PWM_ASPEED_DUTY_CYCLE_PERIOD GENMASK(31, 24)
> +#define PWM_ASPEED_DUTY_CYCLE_POINT_AS_WDT GENMASK(23, 16)
> +#define PWM_ASPEED_DUTY_CYCLE_FALLING_POINT GENMASK(15, 8)
> +#define PWM_ASPEED_DUTY_CYCLE_RISING_POINT GENMASK(7, 0)
> +
> +/* PWM fixed value */
> +#define PWM_ASPEED_FIXED_PERIOD 0xff
> +
> +struct aspeed_pwm_data {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	struct reset_control *reset;
> +};
> +
> +static inline struct aspeed_pwm_data *
> +aspeed_pwm_chip_to_data(struct pwm_chip *c)
> +{
> +	return container_of(c, struct aspeed_pwm_data, chip);
> +}
> +
> +static u64 aspeed_pwm_get_period(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> +{
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	unsigned long rate;
> +	u32 index =3D pwm->hwpwm;
> +	u32 div_h, div_l, val;
> +	u64 period;
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
> +	div_h =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
> +	div_l =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
> +	period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, rate);
> +	period *=3D (BIT(div_h) * (div_l + 1) * (PWM_ASPEED_FIXED_PERIOD + 1));

As this function is used in .get_state it makes sense to use the
PWM_ASPEED_DUTY_CYCLE_PERIOD register value instead of
PWM_ASPEED_FIXED_PERIOD in case the bootloader programmed doesn't
implement the "always use 255" strategy.

DIV_ROUND_UP_ULL doens't give any advantage here over plain DIV_ROUND_UP
because both parameters fit into a plain unsigned long. However first
doing the multiplication and only then the division increases precision.
(Consider rate =3D 199000000, div_h =3D 2, div_l =3D 130 and
PWM_ASPEED_DUTY_CYCLE_PERIOD =3D 255: The exact period is
674090.4522613066 ns. With your ordering you calculate 804864.0 ns,
while when dividing at the end you get 674091.)

> +
> +	return period;
> +}
> +
> +static int aspeed_pwm_set_freq(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *state)

It's a bit irritating that this is called ..._set_freq but it is about
the period. Maybe better call it ..._set_period?

> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	unsigned long rate;
> +	u64 div_h, div_l;
> +	u32 index =3D pwm->hwpwm;
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	rate =3D DIV_ROUND_UP_ULL(rate, (PWM_ASPEED_FIXED_PERIOD + 1));

You don't need parenthesis around the parameters of DIV_ROUND_UP_ULL. As
you round up here, you don't necessarily calculate the smallest value
for div_h, do you?

> +	/* Get the smallest value for div_h  */
> +	div_h =3D rate * state->period;

Same issue as above, if you divide at the end of the calculation the
precision is better.

> +	div_h =3D DIV_ROUND_DOWN_ULL(div_h,
> +				   (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
> +	div_h =3D DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);

As a division is an expensive operation you can better first multiply
NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 and divide by
the result.

> +
> +	div_h =3D order_base_2(div_h);
> +	if (div_h > 0xf)
> +		div_h =3D 0xf;
> +
> +	div_l =3D rate * state->period;
> +	div_l >>=3D div_h;
> +	div_l =3D DIV_ROUND_DOWN_ULL(div_l, NSEC_PER_SEC);
> +	if (div_l =3D=3D 0) {
> +		dev_err(dev, "Period too small, cannot implement it");

No error message please.

> +		return -ERANGE;
> +	}
> +
> +	div_l -=3D 1;
> +
> +	if (div_l > 255)
> +		div_l =3D 255;
> +
> +	dev_dbg(dev, "clk source: %ld div_h %lld, div_l : %lld\n", rate, div_h,
> +		div_l);
> +
> +	regmap_update_bits(
> +		priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +		(PWM_ASPEED_CTRL_CLK_DIV_H | PWM_ASPEED_CTRL_CLK_DIV_L),
> +		FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_H, div_h) |
> +			FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_L, div_l));
> +	return 0;
> +}
> +
> +static void aspeed_set_pwm_duty(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				const struct pwm_state *state)

aspeed_pwm_set_duty please

> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 duty_pt;
> +	u32 index =3D pwm->hwpwm;
> +	u64 cur_period;
> +
> +	cur_period =3D aspeed_pwm_get_period(chip, pwm);
> +	duty_pt =3D DIV_ROUND_DOWN_ULL(
> +		state->duty_cycle * (PWM_ASPEED_FIXED_PERIOD + 1), cur_period);
> +	dev_dbg(dev, "cur_period =3D %lld, duty_cycle =3D %lld, duty_pt =3D %d\=
n",
> +		cur_period, state->duty_cycle, duty_pt);
> +	if (duty_pt =3D=3D 0) {
> +		regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +				   PWM_ASPEED_CTRL_CLK_ENABLE, 0);
> +	} else {
> +		if (duty_pt >=3D (PWM_ASPEED_FIXED_PERIOD + 1))
> +			duty_pt =3D 0;
> +		regmap_update_bits(
> +			priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
> +			PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
> +			FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
> +				   duty_pt));
> +		regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +				   PWM_ASPEED_CTRL_CLK_ENABLE,
> +				   PWM_ASPEED_CTRL_CLK_ENABLE);
> +	}
> +}
> +
> +static void aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 index =3D pwm->hwpwm;
> +	bool polarity, ch_en, clk_en;
> +	u32 duty_pt, val;
> +
> +	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
> +	polarity =3D FIELD_GET(PWM_ASPEED_CTRL_INVERSE, val);
> +	ch_en =3D FIELD_GET(PWM_ASPEED_CTRL_PIN_ENABLE, val);
> +	clk_en =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_ENABLE, val);
> +	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index), &val);
> +	duty_pt =3D FIELD_GET(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, val);
> +
> +	state->period =3D aspeed_pwm_get_period(chip, pwm);
> +	if (clk_en && duty_pt)
> +		state->duty_cycle =3D DIV_ROUND_DOWN_ULL(
> +			state->period * duty_pt, PWM_ASPEED_FIXED_PERIOD + 1);

Round up please.

> +	else
> +		state->duty_cycle =3D clk_en ? state->period : 0;
> +	state->polarity =3D polarity;
> +	state->enabled =3D ch_en;
> +	dev_dbg(dev, "get period: %lldns, duty_cycle: %lldns", state->period,
> +		state->duty_cycle);
> +}
> +
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 index =3D pwm->hwpwm;
> +	int ret;
> +
> +	dev_dbg(dev, "apply period: %lldns, duty_cycle: %lldns", state->period,
> +		state->duty_cycle);
> +
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +			   PWM_ASPEED_CTRL_PIN_ENABLE,
> +			   state->enabled ? PWM_ASPEED_CTRL_PIN_ENABLE : 0);
> +	/*
> +	 * Fixed the period to the max value and rising point to 0
> +	 * for high resolution and simplify frequency calculation.
> +	 */
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
> +			   (PWM_ASPEED_DUTY_CYCLE_PERIOD |
> +			    PWM_ASPEED_DUTY_CYCLE_RISING_POINT),
> +			   FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
> +				      PWM_ASPEED_FIXED_PERIOD));
> +
> +	ret =3D aspeed_pwm_set_freq(chip, pwm, state);
> +	if (ret)
> +		return ret;
> +	aspeed_set_pwm_duty(chip, pwm, state);
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +			   PWM_ASPEED_CTRL_INVERSE,
> +			   FIELD_PREP(PWM_ASPEED_CTRL_INVERSE,
> +				      state->polarity));
> +	return 0;
> +}
> +
> +static const struct pwm_ops aspeed_pwm_ops =3D {
> +	.apply =3D aspeed_pwm_apply,
> +	.get_state =3D aspeed_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +	struct aspeed_pwm_data *priv;
> +	struct device_node *np;
> +	struct platform_device *parent_dev;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np =3D pdev->dev.parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach")) {
> +		dev_err(dev, "unsupported pwm device binding\n");
> +		return -ENODEV;

You can simplify this to

	return dev_err_probe(dev, -ENODEV, "uns...");

> +	}
> +
> +	priv->regmap =3D syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +	}

No { } please

> +
> +	parent_dev =3D of_find_device_by_node(np);
> +	priv->clk =3D devm_clk_get(&parent_dev->dev, 0);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "get clock failed\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "couldn't enable clock\n");
> +		return ret;

If you use dev_err_probe here this is more compact and the error message
contains the error code.

> +	}
> +
> +	priv->reset =3D of_reset_control_get_shared(np, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "get reset failed\n");
> +
> +	ret =3D reset_control_deassert(priv->reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert reset control: %pe\n",
> +			ERR_PTR(ret));

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xttmurqnkmfrurv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCf5kAACgkQwfwUeK3K
7AlNDwf/YiCimYu6s5wc2+7fLSwe4CUo5nXLSap0z8oyjqanAFTk/5UT2eNoh6C4
wUqaesjxq/MYS+RDyEskI2J/e6wzYjEwMD0V0z1OIca2gJM2GWMlrtFdB9o+YPHP
xE7Ove1nD20qXtbFdQ5oF6hJ4u3B/G8sShvQOWBqy7pzQWps9RaSsoEt6FI2kEyE
QEy8K3pMKnPgiUqk6ta1jObRp2EL/ddf56ES/qUwtN5RLm7qshsI2ndTcfsrgs+b
tpamdBFEuku+RTCeMBGln3NawNJr9qemGLx8RkEZ2YZlSXo5q1fySeMDNZsZyRjI
NZs/XJtYR6rtrxJItYfbu2kUlaITZg==
=K4Mw
-----END PGP SIGNATURE-----

--xttmurqnkmfrurv7--
