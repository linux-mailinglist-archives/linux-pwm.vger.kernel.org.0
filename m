Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3C3BA23C
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jul 2021 16:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhGBOel (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Jul 2021 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhGBOek (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Jul 2021 10:34:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF9C061762
        for <linux-pwm@vger.kernel.org>; Fri,  2 Jul 2021 07:32:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lzKCs-00087Y-Hl; Fri, 02 Jul 2021 16:31:50 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lzKCp-0006q4-Lv; Fri, 02 Jul 2021 16:31:47 +0200
Date:   Fri, 2 Jul 2021 16:31:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v8 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210702143147.6a7psfup4tlidq2x@pengutronix.de>
References: <20210608064658.14262-1-billy_tsai@aspeedtech.com>
 <20210608064658.14262-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bvtsoikuummpf4jw"
Content-Disposition: inline
In-Reply-To: <20210608064658.14262-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bvtsoikuummpf4jw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

On Tue, Jun 08, 2021 at 02:46:58PM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig              |   9 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-aspeed-ast2600.c | 311 +++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
>  create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..a5aac3ca4ac7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,15 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
> =20
> +config PWM_ASPEED_AST2600
> +	tristate "Aspeed ast2600 PWM support"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	help
> +	  This driver provides support for Aspeed ast2600 PWM controllers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-aspeed-ast2600.
> +
>  config PWM_ATMEL
>  	tristate "Atmel PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index cbdcd55d69ee..ada454f9129a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
> +obj-$(CONFIG_PWM_ASPEED_AST2600)	+=3D pwm-aspeed-ast2600.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-as=
t2600.c
> new file mode 100644
> index 000000000000..6ea0f7eb311f
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-ast2600.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 Aspeed Technology Inc.
> + *
> + * PWM controller driver for Aspeed ast2600 SoCs.
> + * This drivers doesn't support earlier version of the IP.
> + *
> + * The formula of pwm period duration:
> + * period duration =3D ((DIV_L + 1) * BIT(DIV_H) * (PERIOD + 1)) / input=
-clk
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
> + * Use to determine whether duty_cycle bigger than 0.
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
> + * - Disabling the PWM doesn't complete the current period.
> + *
> + * Improvements:
> + * - When only changing one of duty cycle or period, our pwm controller =
will not
> + *   generate the glitch, the configure will change at next cycle of pwm.
> + *   This improvement can disable/enable through PWM_ASPEED_CTRL_DUTY_SY=
NC_DISABLE.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/errno.h>
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
> +#define PWM_ASPEED_CTRL(ch) ((ch) * 0x10 + 0x00)
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
> +#define PWM_ASPEED_DUTY_CYCLE(ch) ((ch) * 0x10 + 0x04)
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
> +aspeed_pwm_chip_to_data(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct aspeed_pwm_data, chip);
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
> +	unsigned long rate;
> +	u64 div_h, div_l, clk_period;
> +
> +	regmap_read(priv->regmap, PWM_ASPEED_CTRL(index), &val);
> +	polarity =3D FIELD_GET(PWM_ASPEED_CTRL_INVERSE, val);
> +	ch_en =3D FIELD_GET(PWM_ASPEED_CTRL_PIN_ENABLE, val);
> +	clk_en =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_ENABLE, val);
> +	div_h =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
> +	div_l =3D FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
> +	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE(index), &val);
> +	duty_pt =3D FIELD_GET(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, val);
> +	clk_period =3D FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	state->period =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * _BITULL(div_h) *
> +						 (div_l + 1) * (clk_period + 1),
> +					 rate);

Instead of _BITULL(div_h) you can just do << div_h, which reads a bit
easier.

The multiplication can be up to:

	100000000 * (1 << 31) * (31 + 1) * (255 + 1)

right? This needs 71 bits and so might overflow a u64.

I guess to prevent that you have to do something like SH_DIV does for a
u32 division:

	u64 rem;

	/*
	 * To calculate
	 *
	 *   roundup(NSEC_PER_SEC * (div_l + 1) * (clk_period + 1) << div_h / rate)
	 *
	 * we have to jump through some hoops because the numerator
	 * might not fit into a u64. So calculate:
	 *
	 *   roundup(NSEC_PER_SEC * (div_l + 1) * (clk_period + 1) / rate) << div_h
	 *
	 * and fixup for the imprecision.
	 */
	nom =3D (u64)NSEC_PER_SEC * (div_l + 1) * (clk_period + 1) + (rate - 1);
	rem =3D do_div(nom, rate);
	state->period =3D nom << div_h + DIV_ROUND_DOWN_ULL(rem << div_h + (rate >=
> 1), rate);

You might want to double check my math here, I didn't invest the time to
verify myself that this is sensible but just quickly combined SH_DIV and
DIV_ROUND_UP_ULL.

> +	if (clk_en && duty_pt)
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(
> +			state->period * duty_pt, clk_period + 1);

You're loosing precision here. You have to repeat the hoop jumping from
above to fix.

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
> +	u32 index =3D pwm->hwpwm, duty_pt;
> +	unsigned long rate;
> +	u64 div_h, div_l, divisor;
> +	bool clk_en;
> +
> +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", state->period,
> +		state->duty_cycle);
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	/*
> +	 * Pick the smallest value for div_h so that div_l can be the biggest
> +	 * which results in a finer resolution near the target period value.
> +	 */
> +	divisor =3D (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
> +		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
> +	div_h =3D order_base_2(DIV64_U64_ROUND_UP(rate * state->period, divisor=
));
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

I already checked that in the previous round, I assume that's fine now.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bvtsoikuummpf4jw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDfI0UACgkQwfwUeK3K
7AkxzQf/aRvsyQ+PYgKY6u78z8gwkDP0Vd4TckmUEh/wF8b//PdWA1dEMh8d7iuB
QvpKzfPJ9wvRt4MfGxR8FTSE4TLkK1hlKZIYdyTlPGNyNWIyUu0i6TzYVnw/SzFJ
7rb4lAvfr8bW6AwTBwwhPp8C8K6NFXoEZ1E6+GrfDTBBTmDu/yuCHk76CQqIHqqM
M7lJebtreYDrpkvFoQV1yLBGlvEkCAGgxdoIlvKyBQR3KH+oVjEHkqXyDAs0q6dx
7KhKkM2FIR9B43ClRQNJ9IK+brjDpCi42+tFqpF+bhLZLie53H/vPGJPKEs4ookm
mFhh1X/hWr/Ip8UThnNgQdLdZ6C8GA==
=DoBB
-----END PGP SIGNATURE-----

--bvtsoikuummpf4jw--
