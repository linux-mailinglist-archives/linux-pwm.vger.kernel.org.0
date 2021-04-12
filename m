Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225C435C660
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhDLMfk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241101AbhDLMfk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 08:35:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB2CC061574
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 05:35:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVvmX-0005ls-5G; Mon, 12 Apr 2021 14:35:09 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVvmR-0001gy-0w; Mon, 12 Apr 2021 14:35:03 +0200
Date:   Mon, 12 Apr 2021 14:35:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        billy_tasi@aspeedtech.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 3/4] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210412123502.v77fvmi3awvbmduu@pengutronix.de>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-4-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzhggbiygyuccl5t"
Content-Disposition: inline
In-Reply-To: <20210412095457.15095-4-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jzhggbiygyuccl5t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

On Mon, Apr 12, 2021 at 05:54:56PM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can find at aspeed
> ast2600 soc chip. This controller supoorts up to 16 channels.
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/pwm-aspeed-g6.c | 291 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 291 insertions(+)
>  create mode 100644 drivers/pwm/pwm-aspeed-g6.c
>=20
> diff --git a/drivers/pwm/pwm-aspeed-g6.c b/drivers/pwm/pwm-aspeed-g6.c
> new file mode 100644
> index 000000000000..4bb4f97453c6
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-g6.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) ASPEED Technology Inc.

Don't you need to add a year here?

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 or lat=
er as
> + * published by the Free Software Foundation.

Hmm, the comment and the SPDX-License-Identifier contradict each other.
The idea of the latter is that the former isn't needed.

> + */

Is there documentation available in the internet for this hardware? If
yes, please mention a link here.

Also describe the hardware here similar to how e.g.
drivers/pwm/pwm-sifive.c does it. Please stick to the same format for
easy grepping.

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
> +#include <linux/pwm.h>
> +/* The channel number of Aspeed pwm controller */
> +#define ASPEED_NR_PWMS 16
> +/* PWM Control Register */
> +#define ASPEED_PWM_CTRL_CH(ch) ((ch * 0x10) + 0x00)

#define ASPEED_PWM_CTRL_CH(ch) (((ch) * 0x10) + 0x00)

> +#define PWM_LOAD_SEL_AS_WDT BIT(19)
> +#define LOAD_SEL_FALLING 0
> +#define LOAD_SEL_RIGING 1
> +#define PWM_DUTY_LOAD_AS_WDT_EN BIT(18)
> +#define PWM_DUTY_SYNC_DIS BIT(17)
> +#define PWM_CLK_ENABLE BIT(16)
> +#define PWM_LEVEL_OUTPUT BIT(15)
> +#define PWM_INVERSE BIT(14)
> +#define PWM_OPEN_DRAIN_EN BIT(13)
> +#define PWM_PIN_EN BIT(12)
> +#define PWM_CLK_DIV_H_SHIFT 8
> +#define PWM_CLK_DIV_H_MASK (0xf << PWM_CLK_DIV_H_SHIFT)
> +#define PWM_CLK_DIV_L_SHIFT 0
> +#define PWM_CLK_DIV_L_MASK (0xff << PWM_CLK_DIV_L_SHIFT)
> +/* PWM Duty Cycle Register */
> +#define ASPEED_PWM_DUTY_CYCLE_CH(ch) ((ch * 0x10) + 0x04)
> +#define PWM_PERIOD_SHIFT (24)
> +#define PWM_PERIOD_MASK (0xff << PWM_PERIOD_SHIFT)
> +#define PWM_POINT_AS_WDT_SHIFT (16)
> +#define PWM_POINT_AS_WDT_MASK (0xff << PWM_POINT_AS_WDT_SHIFT)
> +#define PWM_FALLING_POINT_SHIFT (8)
> +#define PWM_FALLING_POINT_MASK (0xffff << PWM_FALLING_POINT_SHIFT)
> +#define PWM_RISING_POINT_SHIFT (0)
> +#define PWM_RISING_POINT_MASK (0xffff << PWM_RISING_POINT_SHIFT)
> +/* PWM default value */
> +#define DEFAULT_PWM_PERIOD 0xff
> +#define DEFAULT_TARGET_PWM_FREQ 25000
> +#define DEFAULT_DUTY_PT 10
> +#define DEFAULT_WDT_RELOAD_DUTY_PT 16

You could spend a few empty lines to make this better readable. Also
please use a consistent driver-specific prefix for your defines and
consider using the macros from <linux/bitfield.h>. Also defines
for bitfields should contain the register name.

> +struct aspeed_pwm_data {
> +	struct pwm_chip chip;
> +	struct regmap *regmap;
> +	unsigned long clk_freq;
> +	struct reset_control *reset;
> +};
> +/**
> + * struct aspeed_pwm - per-PWM driver data
> + * @freq: cached pwm freq
> + */
> +struct aspeed_pwm {
> +	u32 freq;
> +};

This is actually unused, please drop it. (You save a value in it, but
make never use of it.)

> +static void aspeed_set_pwm_channel_enable(struct regmap *regmap, u8 pwm_=
channel,
> +					  bool enable)
> +{
> +	regmap_update_bits(regmap, ASPEED_PWM_CTRL_CH(pwm_channel),
> +			   (PWM_CLK_ENABLE | PWM_PIN_EN),
> +			   enable ? (PWM_CLK_ENABLE | PWM_PIN_EN) : 0);

What is the semantic of PIN_EN?

> +}
> +/*
> + * The PWM frequency =3D HCLK(200Mhz) / (clock division L bit *
> + * clock division H bit * (period bit + 1))
> + */
> +static void aspeed_set_pwm_freq(struct aspeed_pwm_data *priv,
> +				struct pwm_device *pwm, u32 freq)
> +{
> +	u32 target_div, cal_freq;
> +	u32 tmp_div_h, tmp_div_l, diff, min_diff =3D INT_MAX;
> +	u32 div_h =3D BIT(5) - 1, div_l =3D BIT(8) - 1;
> +	u8 div_found;
> +	u32 index =3D pwm->hwpwm;
> +	struct aspeed_pwm *channel =3D pwm_get_chip_data(pwm);
> +
> +	cal_freq =3D priv->clk_freq / (DEFAULT_PWM_PERIOD + 1);
> +	target_div =3D DIV_ROUND_UP(cal_freq, freq);
> +	div_found =3D 0;
> +	/* calculate for target frequence */

s/frequence/frequency/

> +	for (tmp_div_h =3D 0; tmp_div_h < 0x10; tmp_div_h++) {
> +		tmp_div_l =3D target_div / BIT(tmp_div_h) - 1;
> +
> +		if (tmp_div_l < 0 || tmp_div_l > 255)
> +			continue;
> +
> +		diff =3D freq - cal_freq / (BIT(tmp_div_h) * (tmp_div_l + 1));
> +		if (abs(diff) < abs(min_diff)) {
> +			min_diff =3D diff;
> +			div_l =3D tmp_div_l;
> +			div_h =3D tmp_div_h;
> +			div_found =3D 1;
> +			if (diff =3D=3D 0)
> +				break;
> +		}
> +	}

If my understanding is right (i.e. H divides by a power of two and L by
an integer) this can be simplified.

> +	if (div_found =3D=3D 0) {
> +		pr_debug("target freq: %d too slow set minimal frequency\n",
> +			 freq);
> +	}
> +	channel->freq =3D cal_freq / (BIT(div_h) * (div_l + 1));
> +	pr_debug("div h %x, l : %x pwm out clk %d\n", div_h, div_l,
> +		 channel->freq);
> +	pr_debug("hclk %ld, target pwm freq %d, real pwm freq %d\n",
> +		 priv->clk_freq, freq, channel->freq);
> +
> +	regmap_update_bits(priv->regmap, ASPEED_PWM_CTRL_CH(index),
> +			   (PWM_CLK_DIV_H_MASK | PWM_CLK_DIV_L_MASK),
> +			   (div_h << PWM_CLK_DIV_H_SHIFT) |
> +				   (div_l << PWM_CLK_DIV_L_SHIFT));
> +}
> +
> +static void aspeed_set_pwm_duty(struct aspeed_pwm_data *priv,
> +				struct pwm_device *pwm, u32 duty_pt)
> +{
> +	u32 index =3D pwm->hwpwm;
> +
> +	if (duty_pt =3D=3D 0) {
> +		aspeed_set_pwm_channel_enable(priv->regmap, index, false);
> +	} else {
> +		regmap_update_bits(priv->regmap,
> +				   ASPEED_PWM_DUTY_CYCLE_CH(index),
> +				   PWM_FALLING_POINT_MASK,
> +				   duty_pt << PWM_FALLING_POINT_SHIFT);
> +		aspeed_set_pwm_channel_enable(priv->regmap, index, true);
> +	}
> +}
> +
> +static void aspeed_set_pwm_polarity(struct aspeed_pwm_data *priv,
> +				    struct pwm_device *pwm, u8 polarity)
> +{
> +	u32 index =3D pwm->hwpwm;
> +
> +	regmap_update_bits(priv->regmap, ASPEED_PWM_CTRL_CH(index), PWM_INVERSE,
> +			   (polarity) ? PWM_INVERSE : 0);
> +}
> +
> +static int aspeed_pwm_request(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D dev_get_drvdata(dev);
> +	struct aspeed_pwm *channel;
> +	u32 index =3D pwm->hwpwm;
> +	/*
> +	 * Fixed the period to the max value and rising point to 0
> +	 * for high resolution and =08simplified frequency calculation.

s/^H//

> +	 */
> +	regmap_update_bits(priv->regmap, ASPEED_PWM_DUTY_CYCLE_CH(index),
> +			   PWM_PERIOD_MASK,
> +			   DEFAULT_PWM_PERIOD << PWM_PERIOD_SHIFT);
> +
> +	regmap_update_bits(priv->regmap, ASPEED_PWM_DUTY_CYCLE_CH(index),
> +			   PWM_RISING_POINT_MASK, 0);

Only .apply is supposed to modify the PWM's configuration.

> +	channel =3D devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
> +	if (!channel)
> +		return -ENOMEM;

Don't use devm_kzalloc if freeing isn't done at device cleanup time.

> +	pwm_set_chip_data(pwm, channel);
> +
> +	return 0;

> +}
> +
> +static void aspeed_pwm_free(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm *channel =3D pwm_get_chip_data(pwm);
> +
> +	devm_kfree(dev, channel);
> +}
> +
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D dev_get_drvdata(dev);

Please consider using

	priv =3D container_of(chip, struct aspeed_pwm_data, chip);

(preferably wrapped in a macro) which is more type safe and more
effective to calculate.

> +	struct pwm_state *cur_state =3D &pwm->state;
> +	u32 freq =3D DIV_ROUND_UP_ULL(1000000000, state->period);
> +	u32 duty_pt =3D DIV_ROUND_UP_ULL(
> +		state->duty_cycle * (DEFAULT_PWM_PERIOD + 1), state->period);

You're loosing precision here.

> +	dev_dbg(dev, "freq: %d, duty_pt: %d", freq, duty_pt);
> +	if (state->enabled) {
> +		aspeed_set_pwm_freq(priv, pwm, freq);
> +		aspeed_set_pwm_duty(priv, pwm, duty_pt);
> +		aspeed_set_pwm_polarity(priv, pwm, state->polarity);

How does the hardware behave between these calls? E.g. can it happen
that it already emits a normal period when inversed polarity is
requested just before aspeed_set_pwm_polarity is called? Or there is a
period with the previous duty cycle and the new period?

> +	} else {
> +		aspeed_set_pwm_duty(priv, pwm, 0);
> +	}
> +	cur_state->period =3D state->period;
> +	cur_state->duty_cycle =3D state->duty_cycle;
> +	cur_state->polarity =3D state->polarity;
> +	cur_state->enabled =3D state->enabled;

The driver is not supposed to modify pwm->state.

> +	return 0;
> +}

=46rom your code I understood: The period of the signal is

	(PWM_PERIOD + 1) * (2 ** DIV_H) * (DIV_L + 1) / 200 MHz

=2E The duty cycle is

	PWM_FALLING_POINT * (2 ** DIV_H) * (DIV_L + 1) / 200 MHz

=2E So the PWM cannot provide a 100% relative duty cycle.

Is this right?

> +static const struct pwm_ops aspeed_pwm_ops =3D {
> +	.request =3D aspeed_pwm_request,
> +	.free =3D aspeed_pwm_free,
> +	.apply =3D aspeed_pwm_apply,

Please test your driver with PWM_DEBUG enabled.

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct clk *clk;
> +	int ret;
> +	struct aspeed_pwm_data *priv;
> +	struct device_node *np;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np =3D pdev->dev.parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach")) {
> +		dev_err(dev, "unsupported pwm device binding\n");
> +		return -ENODEV;
> +	}

Is this pwm-tach an mfd?

> +	priv->regmap =3D syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(dev, "Couldn't get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		return -ENODEV;
> +	priv->clk_freq =3D clk_get_rate(clk);

If you intend to use this clock, you have to enable it.

> +	priv->reset =3D reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(priv->reset)) {
> +		dev_err(&pdev->dev, "can't get aspeed_pwm_tacho reset\n");
> +		return PTR_ERR(priv->reset);
> +	}
> +	reset_control_deassert(priv->reset);

missing error checking

> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &aspeed_pwm_ops;
> +	priv->chip.base =3D -1;

This isn't necessary since f9a8ee8c8bcd118e800d88772c6457381db45224,
please drop the assignment to base.

> +	priv->chip.npwm =3D ASPEED_NR_PWMS;
> +	priv->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	priv->chip.of_pwm_n_cells =3D 3;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);

Please use %pe to make the error messages better readable.

> +		return ret;
> +	}
> +	dev_set_drvdata(dev, priv);
> +	return ret;
> +}
> +
> +static const struct of_device_id of_pwm_match_table[] =3D {
> +	{
> +		.compatible =3D "aspeed,ast2600-pwm",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_pwm_match_table);
> +
> +static struct platform_driver aspeed_pwm_driver =3D {
> +	.probe		=3D aspeed_pwm_probe,

Please implement a .remove callback.

> +	.driver		=3D {
> +		.name	=3D "aspeed_pwm",
> +		.of_match_table =3D of_pwm_match_table,
> +	},
> +};

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jzhggbiygyuccl5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB0PnMACgkQwfwUeK3K
7Alzegf/YT3V2IatEJsB6eLsxeZ/4oXm+pIdj5tejNTKZUP6q+qlaLpGwDNK4d1q
cuGKGXwzDN8p8d6ivM51QdDah3dT/bsdxHsllnnm+qHnJnz3frAcdRnHwncgOZGf
6d+Djdt6ZOTTrVAg5/rIS3kUZX5UcdIN6+DYlDJ5QSs+JIoja36IkJoudDGxcrCT
sBB+nbI2k0dZTmL8b+flKdUE+VB0TxxdH4hwiapews6WtSbQgK9gdO2QJh5ecsfD
woPOSnludKA/PNu+Ymbg1yjMyLCrqWew9xbem1xVx4fOA0zP9SXuK4r3ke8lfLjr
LtkO4iBnZI7twKE7ZA7lPYhqXtEb1A==
=Xoxt
-----END PGP SIGNATURE-----

--jzhggbiygyuccl5t--
