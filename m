Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA34338D671
	for <lists+linux-pwm@lfdr.de>; Sat, 22 May 2021 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhEVQJB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 May 2021 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhEVQI7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 May 2021 12:08:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2892C061574
        for <linux-pwm@vger.kernel.org>; Sat, 22 May 2021 09:07:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lkU9k-0004rd-F7; Sat, 22 May 2021 18:07:16 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lkU9f-00026L-8u; Sat, 22 May 2021 18:07:11 +0200
Date:   Sat, 22 May 2021 18:07:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v6 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210522160708.ryr7n7klapszu2da@pengutronix.de>
References: <20210518005517.9036-1-billy_tsai@aspeedtech.com>
 <20210518005517.9036-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k34lll7347jlokxj"
Content-Disposition: inline
In-Reply-To: <20210518005517.9036-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--k34lll7347jlokxj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 18, 2021 at 08:55:17AM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig         |   9 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-aspeed-g6.c | 351 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 361 insertions(+)
>  create mode 100644 drivers/pwm/pwm-aspeed-g6.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..3b2d4cf024a6 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,15 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
> =20
> +config PWM_ASPEED_G6
> +	tristate "ASPEEDG6 PWM support"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for ASPEED G6 SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-aspeed-g6.
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
> index 000000000000..a80211eb4877
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-g6.c
> @@ -0,0 +1,351 @@
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
> +#include <linux/math64.h>
> +
> +/* The channel number of Aspeed pwm controller */
> +#define PWM_ASPEED_NR_PWMS 16
> +
> +/* PWM Control Register */
> +#define PWM_ASPEED_CTRL_CH(ch) (((ch)*0x10) + 0x00)
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
> +#define PWM_ASPEED_DUTY_CYCLE_CH(ch) (((ch)*0x10) + 0x04)
> +#define PWM_ASPEED_DUTY_CYCLE_PERIOD GENMASK(31, 24)
> +#define PWM_ASPEED_DUTY_CYCLE_POINT_AS_WDT GENMASK(23, 16)
> +#define PWM_ASPEED_DUTY_CYCLE_FALLING_POINT GENMASK(15, 8)
> +#define PWM_ASPEED_DUTY_CYCLE_RISING_POINT GENMASK(7, 0)
> +
> +/* PWM fixed value */
> +#define PWM_ASPEED_FIXED_PERIOD FIELD_MAX(PWM_ASPEED_DUTY_CYCLE_PERIOD)
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
> +	u32 val;
> +	u64 period, div_h, div_l, clk_period;
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
> +	div_h =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
> +	div_l =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
> +	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index), &val);
> +	clk_period =3D FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
> +	period =3D (NSEC_PER_SEC * BIT(div_h) * (div_l + 1) * (clk_period + 1));

The outer pair of parenthesis on the RHS isn't necessary. The maximal
value that period can have here is:

	1000000000 * 2**15 * 256 * 256

This fits into an u64, but as all but the last factor are 32 bit values
you might get an overflow here.

> +	period =3D DIV_ROUND_UP_ULL(period, rate);
> +
> +	return period;
> +}
> +
> +static int aspeed_pwm_set_period(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	unsigned long rate;
> +	u64 div_h, div_l, divisor;
> +	u32 index =3D pwm->hwpwm;
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	/*
> +	 * Pick the smallest value for div_h so that div_l can be the biggest
> +	 * which results in a finer resolution near the target period value.
> +	 */
> +	divisor =3D (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
> +		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
> +	div_h =3D order_base_2(div64_u64(rate * state->period, divisor));
> +	if (div_h > 0xf)
> +		div_h =3D 0xf;
> +
> +	divisor =3D ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_=
h;
> +	div_l =3D div64_u64(rate * state->period, divisor);
> +
> +	if (div_l =3D=3D 0)
> +		return -ERANGE;
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
> +static void aspeed_pwm_set_duty(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				const struct pwm_state *state)
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
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(
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
> +	ret =3D aspeed_pwm_set_period(chip, pwm, state);
> +	if (ret)
> +		return ret;
> +	aspeed_pwm_set_duty(chip, pwm, state);

aspeed_pwm_set_duty calls aspeed_pwm_get_period() which is a bit
ineffective after just having set the period.

> +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
> +			   PWM_ASPEED_CTRL_INVERSE,
> +			   FIELD_PREP(PWM_ASPEED_CTRL_INVERSE,
> +				      state->polarity));
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k34lll7347jlokxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCpLCgACgkQwfwUeK3K
7AmCSAf/b10m3pzrgftS+pOerE/lMcWweypHlCGoxuBo/WPy3uk708NgCQ+u0110
fpsX1ItRoBjZwyINMcTywGm43ZxXsmUx1LTF1I5/0ag7Cjgqz7fVOR4Km71At9DV
DBhgHDJzvLkrnDajE6UfjAulqU5jgMkcEmyyxIeoLkGNUKmLM2azIga3Cr529EDX
AF5ssSO1lF/U774ynJtneG68MvX0aGhWsKFDgQLP9q87Di5Y2uDFHqS0DB/9JqH2
d6PyqthvRLydMSCqcfk/zy+izNUo+s9j5ZUwUxj8pdnfEaZ+FohaYgXuOg8CLaTb
xfUIR2iYm0iiKIM6e6fteqh21QCKqQ==
=H9ku
-----END PGP SIGNATURE-----

--k34lll7347jlokxj--
