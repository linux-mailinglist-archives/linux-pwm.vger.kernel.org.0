Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6CB378ED2
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhEJNcD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343758AbhEJMOU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 08:14:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC84C0612A3
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 05:09:18 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg4ic-0002wS-OZ; Mon, 10 May 2021 14:09:02 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg4iY-0002JM-7R; Mon, 10 May 2021 14:08:58 +0200
Date:   Mon, 10 May 2021 14:08:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v4 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210510120857.fu573osgwj6oyqx3@pengutronix.de>
References: <20210510073511.7291-1-billy_tsai@aspeedtech.com>
 <20210510073511.7291-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64cuejwgbbnmbxi4"
Content-Disposition: inline
In-Reply-To: <20210510073511.7291-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--64cuejwgbbnmbxi4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 10, 2021 at 03:35:11PM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig         |   8 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-aspeed-g6.c | 368 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 377 insertions(+)
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
> index 000000000000..f5bb982c21e6
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-g6.c
> @@ -0,0 +1,368 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 ASPEED Technology Inc.
> + *
> + * PWM controller driver for Aspeed ast26xx SoCs.
> + * This drivers doesn't rollback to previous version of aspeed SoCs.

Does that mean it doesn't support earlier versions of the IP?

> + *
> + * The formula of pwm frequency:
> + * PWM frequency =3D CLK Source / ((DIV_L + 1) * BIT(DIV_H) * (PERIOD + =
1))
> + *
> + * The software driver fixes the period to 256, which causes the high-fr=
equency
> + * precision of the PWM to be coarse, in exchange for the fineness of th=
e duty cycle.
> + *
> + * Register usage:
> + * PIN_ENABLE: When it is unset the pwm controller will always output lo=
w to the extern.
> + * Use to determin PWM channel enable/disable.

s/determin PWM channel enable.disable/determine if the PWM channel is enabl=
ed or disabled/

> + * CLK_ENABLE: When it is unset the pwm controller will reset the duty c=
ounter to 0 and
> + * output low to the PIN_ENABLE mux after that the driver can still chan=
ge the pwm period
> + * and duty and the value will apply when CLK_ENABLE be set again.
> + * Use to determin whether duty_cycle bigger than 0.
> + * PWM_ASPEED_INVERSE: When it is toggled the output value will inverse =
immediately.
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we cannot prevent in
> + *   software that the output might produce a period with mixed
> + *   settings.
> + *
> + * Improvements:
> + * - When changing the duty cycle or period, our pwm controller will not
> + *   generate the glitch, the configure will change at next cycle of pwm.
> + *   This improvement can disable/enable through PWM_ASPEED_DUTY_SYNC_DI=
SABLE.
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
> +#define PWM_ASPEED_CTRL_CH(ch) (((ch * 0x10) + 0x00))

Please put ch in parenthesis.

> +#define PWM_ASPEED_LOAD_SEL_RISING_AS_WDT BIT(19)
> +#define PWM_ASPEED_DUTY_LOAD_AS_WDT_ENABLE BIT(18)
> +#define PWM_ASPEED_DUTY_SYNC_DISABLE BIT(17)
> +#define PWM_ASPEED_CLK_ENABLE BIT(16)
> +#define PWM_ASPEED_LEVEL_OUTPUT BIT(15)
> +#define PWM_ASPEED_INVERSE BIT(14)
> +#define PWM_ASPEED_OPEN_DRAIN_ENABLE BIT(13)
> +#define PWM_ASPEED_PIN_ENABLE BIT(12)
> +#define PWM_ASPEED_CLK_DIV_H GENMASK(11, 8)
> +#define PWM_ASPEED_CLK_DIV_L GENMASK(7, 0)

It would be great if the bit definitions contained the name of the
register. This simplifies verifying that we're using a define for the
expected register.

> +/* PWM Duty Cycle Register */
> +#define PWM_ASPEED_DUTY_CYCLE_CH(ch) (((ch * 0x10) + 0x04))
> +#define PWM_ASPEED_PERIOD GENMASK(31, 24)
> +#define PWM_ASPEED_POINT_AS_WDT GENMASK(23, 16)
> +#define PWM_ASPEED_FALLING_POINT GENMASK(15, 8)
> +#define PWM_ASPEED_RISING_POINT GENMASK(7, 0)
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
> +static void aspeed_set_pwm_clk_enable(struct regmap *regmap, u8 pwm_chan=
nel,
> +					  bool enable)

I'd call this function aspeed_pwm_set_clk_enable to use "aspeed_pwm_" as
the common prefix for all functions. Similarly for the other functions.
> +{
> +	regmap_update_bits(regmap, PWM_ASPEED_CTRL_CH(pwm_channel),
> +			   PWM_ASPEED_CLK_ENABLE,
> +			   enable ? PWM_ASPEED_CLK_ENABLE : 0);

There is only a single caller for this function, I'd recommend to fold
it into this caller.

> +}
> +
> +static u32 apseed_get_pwm_freq(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	unsigned long rate;
> +	u32 index =3D pwm->hwpwm;
> +	u32 div_h, div_l, cur_freq, val;
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
> +	div_h =3D FIELD_GET(PWM_ASPEED_CLK_DIV_H, val);
> +	div_l =3D FIELD_GET(PWM_ASPEED_CLK_DIV_L, val);
> +
> +	cur_freq =3D DIV_ROUND_DOWN_ULL(rate, (BIT(div_h) * (div_l + 1) *
> +					     (PWM_ASPEED_FIXED_PERIOD + 1)));
> +	return cur_freq;
> +}
> +
> +static int aspeed_set_pwm_freq(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	unsigned long rate;
> +	u32 div_h, div_l, freq;
> +	u32 index =3D pwm->hwpwm;
> +	/* Get the smallest value for div_h  */
> +	freq =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, state->period);
> +	rate =3D clk_get_rate(priv->clk);
> +	div_h =3D DIV_ROUND_DOWN_ULL(rate,
> +				   ((FIELD_MAX(PWM_ASPEED_CLK_DIV_L) + 1) *
> +				    freq * (PWM_ASPEED_FIXED_PERIOD + 1)));

Please don't divide by the result of a division.

> +	div_h =3D order_base_2(div_h);
> +	if (div_h > 0xf)
> +		div_h =3D 0xf;
> +
> +	div_l =3D DIV_ROUND_DOWN_ULL(rate >> div_h,
> +				   (freq * (PWM_ASPEED_FIXED_PERIOD + 1)));
> +	if (div_l =3D=3D 0) {
> +		dev_err(dev, "Period too small, cannot implement it");
> +		return -ERANGE;
> +	}
> +
> +	div_l -=3D 1;
> +
> +	if (div_l > 255)
> +		div_l =3D 255;
> +
> +	dev_dbg(dev, "clk source: %ld div h %x, l : %x\n", rate, div_h, div_l);
> +
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +			   (PWM_ASPEED_CLK_DIV_H | PWM_ASPEED_CLK_DIV_L),
> +			   FIELD_PREP(PWM_ASPEED_CLK_DIV_H, div_h) |
> +				   FIELD_PREP(PWM_ASPEED_CLK_DIV_L, div_l));
> +	return 0;
> +}
> +
> +static void aspeed_set_pwm_duty(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				const struct pwm_state *state)
> +{
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 duty_pt;
> +	u32 index =3D pwm->hwpwm;
> +	u32 cur_freq;
> +	u64 cur_period;
> +
> +	cur_freq =3D apseed_get_pwm_freq(chip, pwm);

s/apseed/aspeed/

cur_freq is the result of a division ...

> +	cur_period =3D DIV_ROUND_DOWN_ULL(NSEC_PER_SEC, cur_freq);

=2E.. dividing through such a number loses precision.


> +	duty_pt =3D DIV_ROUND_DOWN_ULL(
> +		state->duty_cycle * (PWM_ASPEED_FIXED_PERIOD + 1), cur_period);
> +	if (duty_pt =3D=3D 0) {
> +		aspeed_set_pwm_clk_enable(priv->regmap, index, false);
> +	} else {
> +		if (duty_pt >=3D (PWM_ASPEED_FIXED_PERIOD + 1))
> +			duty_pt =3D 0;
> +		/* When duty_pt =3D 0 it mean our duty cycle =3D 100% */

Please put this comment above the code that it explains.

> +		regmap_update_bits(
> +			priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
> +			PWM_ASPEED_FALLING_POINT,
> +			FIELD_PREP(PWM_ASPEED_FALLING_POINT, duty_pt));
> +		aspeed_set_pwm_clk_enable(priv->regmap, index, true);
> +	}
> +}
> +
> +static void aspeed_set_pwm_polarity(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    const struct pwm_state *state)
> +{
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 index =3D pwm->hwpwm;
> +
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +			   PWM_ASPEED_INVERSE,
> +			   FIELD_PREP(PWM_ASPEED_INVERSE, state->polarity));
> +}

This function also only has a single caller and can better be folded
into it.

> +static void aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 index =3D pwm->hwpwm;
> +	bool polarity, ch_en, clk_en;
> +	u32 duty_pt, val;
> +	u32 cur_freq;
> +
> +	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
> +	polarity =3D FIELD_GET(PWM_ASPEED_INVERSE, val);
> +	ch_en =3D FIELD_GET(PWM_ASPEED_PIN_ENABLE, val);
> +	clk_en =3D FIELD_GET(PWM_ASPEED_CLK_ENABLE, val);
> +	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index), &val);
> +	duty_pt =3D FIELD_GET(PWM_ASPEED_FALLING_POINT, val);
> +
> +	cur_freq =3D apseed_get_pwm_freq(chip, pwm);
> +
> +	state->period =3D DIV_ROUND_DOWN_ULL(NSEC_PER_SEC, cur_freq);

Please round up in .get_state().

> +	if (clk_en && duty_pt)
> +		state->duty_cycle =3D DIV_ROUND_DOWN_ULL(
> +			state->period * duty_pt, PWM_ASPEED_FIXED_PERIOD + 1);
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
> +	struct pwm_state cur_state;
> +	int ret;
> +
> +	aspeed_pwm_get_state(chip, pwm, &cur_state);
> +	dev_dbg(dev, "cur period: %lldns, cur duty_cycle: %lldns",
> +		cur_state.period, cur_state.duty_cycle);
> +	dev_dbg(dev, "apply period: %lldns, duty_cycle: %lldns", state->period,
> +		state->duty_cycle);
> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +			   PWM_ASPEED_PIN_ENABLE,
> +			   state->enabled ? PWM_ASPEED_PIN_ENABLE : 0);
> +	if (cur_state.period !=3D state->period) {
> +		ret =3D aspeed_set_pwm_freq(chip, pwm, state);
> +		if (ret)
> +			return ret;
> +		aspeed_set_pwm_duty(chip, pwm, state);
> +	} else if (cur_state.duty_cycle !=3D state->duty_cycle)
> +		aspeed_set_pwm_duty(chip, pwm, state);

In aspeed_set_pwm_duty() you call apseed_get_pwm_freq(), in one of the two
cases above you already know the freq. If you ask me, just drop the
cur_state.period !=3D state->period check and calculate all the required
settings unconditionally. Then you also don't need to call
aspeed_pwm_get_state(). (Apart from that apseed_get_pwm_freq implements
the wrong rounding for .apply().)

> +	aspeed_set_pwm_polarity(chip, pwm, state);
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
> +	int ret, index;
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

Please return PTR_ERR(priv->regmap) here and use dev_err_probe for
consistency.

> +	}
> +
> +	priv->clk =3D of_clk_get(np, 0);

Maybe use devm_clk_get() instead? (Otherwise you have to put the clock
in the error paths.)

> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "get clock failed\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "couldn't enable clock\n");
> +		return ret;
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
> +		clk_disable_unprepare(priv->clk);

Consider using goto for error handling. Then you don't have to repeat
the same thing over and over again.

> +		return ret;
> +	}
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &aspeed_pwm_ops;
> +	priv->chip.npwm =3D PWM_ASPEED_NR_PWMS;
> +	priv->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	priv->chip.of_pwm_n_cells =3D 3;
> +
> +	/*
> +	 * Fixed the period to the max value and rising point to 0
> +	 * for high resolution and =08simplified frequency calculation.

There is a stray non-printable char before "simplified".

> +	 */
> +	for (index =3D 0; index < PWM_ASPEED_NR_PWMS; index++) {
> +		regmap_update_bits(
> +			priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
> +			PWM_ASPEED_PERIOD,
> +			FIELD_PREP(PWM_ASPEED_PERIOD, PWM_ASPEED_FIXED_PERIOD));
> +		regmap_update_bits(priv->regmap,
> +				   PWM_ASPEED_DUTY_CYCLE_CH(index),
> +				   PWM_ASPEED_RISING_POINT, 0);
> +	}

Please don't modify the output in .probe. .apply is the only function
that is supposed to do that.

> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to add PWM chip: %pe\n", ERR_PTR(ret));
> +		reset_control_assert(priv->reset);
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +	dev_set_drvdata(dev, priv);
> +	return ret;

s/ret/0/

> +}
> +
> +static int aspeed_pwm_remove(struct platform_device *dev)
> +{
> +	struct aspeed_pwm_data *priv =3D platform_get_drvdata(dev);
> +
> +	pwmchip_remove(&priv->chip);
> +	reset_control_assert(priv->reset);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
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

Please use alignment of =3D consistently. Either don't do it at all (my
favourite) or do it for all structs in the same way.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--64cuejwgbbnmbxi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCZIlYACgkQwfwUeK3K
7Alt7Af9GlsEuZjP7tY5Ta/hxgo67Mp8j4NN2LpWquEl7DsY0DJJNaut/QfoCWD4
BeSuTm/DAGBvjY2a+KKEu3r7eyyx53BY910Pu5ginaVu1zTbGhmHtOPQsYssGrQV
AuRn7nk132j8pAq1O/7uGxb+Dzg5Eeg/7k7s5xfhNEKEtRKRnf9GEWKQqS93+7dS
L4SPZfxDmfluYjeCE1CzgdcJTKla0cakrW8HjApo6feSO43pFJGd5zo5uz4UmZvj
MAHj5eAwKDC0dorqhcjtVcV2zi/Sff3+OM5Ad4Ck44tPYgFM5QjzIJwEtC9QmS36
x+HmmeRs0OA0YXYAlt3/RHcGS5DDYw==
=A/2A
-----END PGP SIGNATURE-----

--64cuejwgbbnmbxi4--
