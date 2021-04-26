Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C901436BAD2
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Apr 2021 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhDZUov (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Apr 2021 16:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhDZUov (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Apr 2021 16:44:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68720C061574
        for <linux-pwm@vger.kernel.org>; Mon, 26 Apr 2021 13:44:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb84z-0000N2-QD; Mon, 26 Apr 2021 22:43:41 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb84s-0003qI-3d; Mon, 26 Apr 2021 22:43:34 +0200
Date:   Mon, 26 Apr 2021 22:43:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        kernel@pengutronix.de
Subject: Re: [v2 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210426204333.gzqke6td33dtugnh@pengutronix.de>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
 <20210414104939.1093-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nzgryyh3rrrmgih2"
Content-Disposition: inline
In-Reply-To: <20210414104939.1093-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nzgryyh3rrrmgih2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2021 at 06:49:39PM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-funciton device "pwm-tach controller".

s/funciton/function/

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig         |   7 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-aspeed-g6.c | 324 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 332 insertions(+)
>  create mode 100644 drivers/pwm/pwm-aspeed-g6.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 9a4f66ae8070..d6c1e25717d7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -42,6 +42,13 @@ config PWM_DEBUG
>  	  It is expected to introduce some runtime overhead and diagnostic
>  	  output to the kernel log, so only enable while working on a driver.
> =20
> +config PWM_ASPEED_G6
> +	tristate "ASPEEDG6 PWM support"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	help
> +	  This driver provides support for ASPEED G6 PWM controllers.
> +
> +

A single empty line is enough. Please keep the list sorted.

>  config PWM_AB8500
>  	tristate "AB8500 PWM support"
>  	depends on AB8500_CORE && ARCH_U8500
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 6374d3b1d6f3..2d9b4590662e 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
> +obj-$(CONFIG_PWM_ASPEED_G6)	+=3D pwm-aspeed-g6.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o

Ditto, this should be sorted alphabetically.

>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
> diff --git a/drivers/pwm/pwm-aspeed-g6.c b/drivers/pwm/pwm-aspeed-g6.c
> new file mode 100644
> index 000000000000..b537a5d7015a
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-g6.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 ASPEED Technology Inc.
> + *
> + * PWM controller driver for Aspeed ast26xx SoCs.
> + * This drivers doesn't rollback to previous version of aspeed SoCs.
> + *
> + * Hardware Features:

Please call this "Limitations" for easier grepping.

> + * 1. Support up to 16 channels
> + * 2. Support PWM frequency range from 24Hz to 780KHz
> + * 3. Duty cycle from 0 to 100% with 1/256 resolution incremental
> + * 4. Support wdt reset tolerance (Driver not ready)

The interesting facts to mention here are: Does the hardware complete a
period on configuration changes? Does the hardware complete a period on
disable? Does the hardware switch configuration atomically, that is if
it is currently running with

	.duty_cycle =3D A + .period =3D B

and is then asked to run at

	.duty_cycle =3D C + .period =3D D

can it happen, that we see a period with .duty_cycle =3D A and period
length D, or similar? If this is configurable, please program the
hardware that is completes a currently running period and then
atomically switches to the new setting.

> + *
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

empty line here

> +/* The channel number of Aspeed pwm controller */
> +#define PWM_ASPEED_NR_PWMS 16
> +
> +/* PWM Control Register */
> +#define PWM_ASPEED_CTRL_CH(ch) (((ch * 0x10) + 0x00))
> +#define PWM_LOAD_SEL_RISING_AS_WDT BIT(19)
> +#define PWM_DUTY_LOAD_AS_WDT_ENABLE BIT(18)
> +#define PWM_DUTY_SYNC_DISABLE BIT(17)
> +#define PWM_CLK_ENABLE BIT(16)
> +#define PWM_LEVEL_OUTPUT BIT(15)
> +#define PWM_INVERSE BIT(14)
> +#define PWM_OPEN_DRAIN_ENABLE BIT(13)
> +#define PWM_PIN_ENABLE BIT(12)
> +#define PWM_CLK_DIV_H GENMASK(11, 8)
> +#define PWM_CLK_DIV_L GENMASK(7, 0)
> +
> +/* PWM Duty Cycle Register */
> +#define PWM_ASPEED_DUTY_CYCLE_CH(ch) (((ch * 0x10) + 0x04))
> +#define PWM_PERIOD GENMASK(31, 24)
> +#define PWM_POINT_AS_WDT GENMASK(23, 16)
> +#define PWM_FALLING_POINT GENMASK(15, 8)
> +#define PWM_RISING_POINT GENMASK(7, 0)

Please use a common prefix for register defines. Also ch must be used in
parenthesis, Something like:

	#define PWM_ASPEED_CTRL(ch)			(0x00 + (ch) * 0x10)
	#define PWM_ASPEED_CTRL_LOAD_SEL_RISING_AS_WDT		BIT(19)
	...

	#define ASPEED_PWM_DUTY_CYCLE(ch)		(0x04 + (ch) * 0x10)
	#define ASPEED_PWM_DUTY_CYCLE_PERIOD			GENMASK(31, 24)
	#define ASPEED_PWM_DUTY_CYCLE_POINT_AS_WDT		GENMASK(23, 16)
	...

(I already asked that in reply to your v1.)

> +/* PWM fixed value */
> +#define PWM_FIXED_PERIOD 0xff
> +
> +struct aspeed_pwm_data {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	struct reset_control *reset;
> +};
> +
> +static void aspeed_set_pwm_channel_enable(struct regmap *regmap, u8 pwm_=
channel,
> +					  bool enable)
> +{
> +	regmap_update_bits(regmap, PWM_ASPEED_CTRL_CH(pwm_channel),
> +			   (PWM_CLK_ENABLE | PWM_PIN_ENABLE),
> +			   enable ? (PWM_CLK_ENABLE | PWM_PIN_ENABLE) : 0);

What is the semantic difference between CLK_ENABLE and PIN_ENABLE? Does
the pin stay at it's inactive level if PIN_ENABLE is unset? Does the
output just freeze at it's current level if CLK_ENABLE is unset?

> +}
> +/*
> + * The PWM frequency =3D HCLK(200Mhz) / (clock division L bit *
> + * clock division H bit * (period bit + 1))
> + */
> +static void aspeed_set_pwm_freq(struct aspeed_pwm_data *priv,
> +				struct pwm_device *pwm, u32 freq)
> +{
> +	u32 target_div, freq_a_fix_div, out_freq;
> +	u32 tmp_div_h, tmp_div_l, diff, min_diff =3D INT_MAX;
> +	u32 div_h =3D BIT(5) - 1, div_l =3D BIT(8) - 1;
> +	u8 div_found;
> +	u32 index =3D pwm->hwpwm;
> +	/* Frequency after fixed divide */
> +	freq_a_fix_div =3D clk_get_rate(priv->clk) / (PWM_FIXED_PERIOD + 1);
> +	/*
> +	 * Use round up to avoid 0 case.
> +	 * After that the only scenario which can't find divide pair is too slow
> +	 */
> +	target_div =3D DIV_ROUND_UP(freq_a_fix_div, freq);

You're losing precision here, as freq is already the result of a division.

> +	div_found =3D 0;
> +	/* calculate for target frequency */
> +	for (tmp_div_h =3D 0; tmp_div_h < 0x10; tmp_div_h++) {
> +		tmp_div_l =3D target_div / BIT(tmp_div_h) - 1;
> +
> +		if (tmp_div_l < 0 || tmp_div_l > 255)
> +			continue;
> +
> +		diff =3D freq - ((freq_a_fix_div >> tmp_div_h) / (tmp_div_l + 1));
> +		if (abs(diff) < abs(min_diff)) {
> +			min_diff =3D diff;
> +			div_l =3D tmp_div_l;
> +			div_h =3D tmp_div_h;
> +			div_found =3D 1;
> +			if (diff =3D=3D 0)
> +				break;
> +		}
> +	}
> +	if (div_found =3D=3D 0) {
> +		pr_debug("target freq: %d too slow set minimal frequency\n",
> +			 freq);
> +	}
> +	out_freq =3D freq_a_fix_div / (BIT(div_h) * (div_l + 1));

This is overly complicated. Just pick the smallest value for div_h that
allows to approximate the period. Using a bigger div_h doesn't have any
advantage as it just results in using a smaller div_l which makes the
resolution more coarse. So something like:

	rate =3D clk_get_rate(...);

	/* this might need some reordering to prevent an integer overflow */
	div_h =3D round_up(state->period * rate / (256 * NSEC_PER_SEC * (PWM_PERIO=
D + 1)));
	div_h =3D order_base_2(div_h);
	if (div_h > 0xf)
		div_h =3D 0xf

	div_l =3D round_up((state->period * rate) >> div_h / (NSEC_PER_SEC * (PWM_=
PERIOD + 1)));
	if (div_l =3D=3D 0)
		/* period too small, cannot implement it */
		return -ERANGE;

	div_l -=3D 1;

	if (div_l > 255)
		div_l =3D 255;


The intended goal is to provide the biggest possible period not bigger
than the requested value.

> +	pr_debug("div h %x, l : %x\n", div_h, div_l);
> +	pr_debug("hclk %ld, target pwm freq %d, real pwm freq %d\n",
> +		 clk_get_rate(priv->clk), freq, out_freq);
> +
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +			   (PWM_CLK_DIV_H | PWM_CLK_DIV_L),
> +			   FIELD_PREP(PWM_CLK_DIV_H, div_h) |
> +				   FIELD_PREP(PWM_CLK_DIV_L, div_l));
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
> +				   PWM_ASPEED_DUTY_CYCLE_CH(index),
> +				   PWM_FALLING_POINT,
> +				   FIELD_PREP(PWM_FALLING_POINT, duty_pt));
> +		aspeed_set_pwm_channel_enable(priv->regmap, index, true);
> +	}
> +}
> +
> +static void aspeed_set_pwm_polarity(struct aspeed_pwm_data *priv,
> +				    struct pwm_device *pwm, u8 polarity)

polarity is an enum, not an u8.

> +{
> +	u32 index =3D pwm->hwpwm;
> +
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index), PWM_INVERSE,
> +			   (polarity) ? PWM_INVERSE : 0);

You can drop the parenthesis around polarity.

> +}
> +
> +static int aspeed_pwm_request(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D dev_get_drvdata(dev);
> +	struct pwm_state *channel;
> +	u32 index =3D pwm->hwpwm;
> +	/*
> +	 * Fixed the period to the max value and rising point to 0
> +	 * for high resolution and =08simplified frequency calculation.

Stray character before "simplified".

> +	 */
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
> +			   PWM_PERIOD,
> +			   FIELD_PREP(PWM_PERIOD, PWM_FIXED_PERIOD));
> +
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
> +			   PWM_RISING_POINT, 0);

=2Erequest() is not supposed to touch the hardware configuration. Only
=2Eapply() is allowed to modify the output. Also initialisation isn't
supposed to happen in case the bootloader setup the hardware for some
purpose.

> +	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
> +	if (!channel)
> +		return -ENOMEM;
> +
> +	return pwm_set_chip_data(pwm, channel);
> +}
> +
> +static void aspeed_pwm_free(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +{
> +	struct pwm_state *channel =3D pwm_get_chip_data(pwm);
> +
> +	kfree(channel);
> +}
> +
> +static inline struct aspeed_pwm_data *
> +aspeed_pwm_chip_to_data(struct pwm_chip *c)
> +{
> +	return container_of(c, struct aspeed_pwm_data, chip);
> +}
> +
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	struct pwm_state *channel =3D pwm_get_chip_data(pwm);
> +	/* compute the ns to Hz */
> +	u32 freq =3D DIV_ROUND_UP_ULL(1000000000, state->period);

Please use NSEC_PER_SEC here.

> +	u32 duty_pt =3D DIV_ROUND_UP_ULL(
> +		state->duty_cycle * (PWM_FIXED_PERIOD + 1), state->period);

In the v1 thread you said you have to set PWM_FALLING_POINT to
PWM_RISING_POINT to implement a 100% relative duty cycle. It seems this
only works by chance here (because duty_pt will be 256 in this case. The
value & 255 is written to the PWM_FALLING_POINT bit field). Assuming
this is what you intended, this needs some comment to be understandable.

Also please round down in the division to never provide a duty_cycle
bigger than the requested vaule. Also you have to use the actually used
period as divider, not state->period.

> +	dev_dbg(dev, "freq: %d, duty_pt: %d", freq, duty_pt);
> +	if (state->enabled) {
> +		aspeed_set_pwm_freq(priv, pwm, freq);
> +		aspeed_set_pwm_duty(priv, pwm, duty_pt);
> +		aspeed_set_pwm_polarity(priv, pwm, state->polarity);

How does the hardware behave in between these calls? If for example the
polarity is changed, does this affect the output immediately? Does this
start a new period?

> +	} else {
> +		aspeed_set_pwm_duty(priv, pwm, 0);
> +	}
> +	channel->period =3D state->period;
> +	channel->duty_cycle =3D state->duty_cycle;
> +	channel->polarity =3D state->polarity;
> +	channel->enabled =3D state->enabled;
> +
> +	return 0;
> +}
> +
> +static void aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct pwm_state *channel =3D pwm_get_chip_data(pwm);
> +
> +	state->period =3D channel->period;
> +	state->duty_cycle =3D channel->duty_cycle;
> +	state->polarity =3D channel->polarity;
> +	state->enabled =3D channel->enabled;

This is not what .get_state() is supposed to do. You should read the
hardware registers and then fill state with the description of the
actually emitted wave form.

> +}
> +
> +static const struct pwm_ops aspeed_pwm_ops =3D {
> +	.request =3D aspeed_pwm_request,
> +	.free =3D aspeed_pwm_free,
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
> +
> +	priv->regmap =3D syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(dev, "Couldn't get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return -ENODEV;

Please consider using dev_err_probe to emit an error message here. Also
for the other error paths for consistency.

> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "couldn't enable clock\n");
> +		return ret;
> +	}
> +
> +	priv->reset =3D reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(priv->reset)) {
> +		dev_err(dev, "can't get aspeed_pwm_tacho reset: %pe\n",
> +			ERR_PTR((long)priv->reset));

This cast can (and should) be dropped.

> +		return PTR_ERR(priv->reset);
> +	}
> +
> +	ret =3D reset_control_deassert(priv->reset);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
> +			ERR_PTR(ret));

You have to undo clk_prepare_enable() here.

> +		return ret;
> +	}
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &aspeed_pwm_ops;
> +	priv->chip.npwm =3D PWM_ASPEED_NR_PWMS;
> +	priv->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	priv->chip.of_pwm_n_cells =3D 3;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to add PWM chip: %pe\n", ERR_PTR(ret));

Again missing clk_disable_unprepare.

> +		return ret;
> +	}
> +	dev_set_drvdata(dev, priv);
> +	return ret;
> +}
> +
> +static int aspeed_pwm_remove(struct platform_device *dev)
> +{
> +	struct aspeed_pwm_data *priv =3D platform_get_drvdata(dev);
> +
> +	reset_control_assert(priv->reset);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return pwmchip_remove(&priv->chip);

Please clean up in reverse order compared to probe. Also there is no
need to check the return value of pwmchip_remove, so this should be:

	pwmchip_remove(&priv->chip);
	reset_control_assert(priv->reset);
	clk_disable_unprepare(priv->clk);

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
> +	.remove		=3D aspeed_pwm_remove,
> +	.driver		=3D {
> +		.name	=3D "aspeed_pwm",
> +		.of_match_table =3D of_pwm_match_table,
> +	},
> +};
> +
> +module_platform_driver(aspeed_pwm_driver);
> +
> +MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
> +MODULE_DESCRIPTION("ASPEED PWM device driver");
> +MODULE_LICENSE("GPL v2");

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nzgryyh3rrrmgih2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCHJfIACgkQwfwUeK3K
7Anqdgf9EAuaHuNa/4VjCD51dXUWinyiTa6BhgV9o7pnl1nzG5ROmw8/9EzpVnTp
uf7uduHWVbgxJecWw31iPNsB2A1Z+X75ud65+3Mb2LambxnfmTy2ns/TxTR1+LzK
vTwEC7tWHV8tmMt3Epdab8NrE93Bso9+HbQHeqPaqON5h3JiZq3b3Y2tniCoopYF
9lYLb14fR/JlksMXDcPge0cCV4Z9rfV/l/i8TIDy2Ksblgq9omSzqHq7lqee6qYZ
63l4MKdZCrRrjV7leSKIPEGVOc1chjWVASb5B4VZXj+Dv9AyKqUw/FP/qUBVO0oX
3gmXHVnYBHyvjSI24aDobzJq2D1HFA==
=hltX
-----END PGP SIGNATURE-----

--nzgryyh3rrrmgih2--
