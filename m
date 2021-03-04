Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F432D84C
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhCDRF4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 12:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbhCDRF3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Mar 2021 12:05:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE678C061756
        for <linux-pwm@vger.kernel.org>; Thu,  4 Mar 2021 09:04:48 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lHrP0-000670-Iz; Thu, 04 Mar 2021 18:04:42 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lHrOy-0004ws-P7; Thu, 04 Mar 2021 18:04:40 +0100
Date:   Thu, 4 Mar 2021 18:04:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, mripard@kernel.org,
        wens@csie.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] pwm: sunxi: Add Allwinner SoC PWM controller
 driver
Message-ID: <20210304170440.b45rvam37xir5zp2@pengutronix.de>
References: <20210302123737.1867-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s47yztabt4tfgidm"
Content-Disposition: inline
In-Reply-To: <20210302123737.1867-1-fengzheng923@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s47yztabt4tfgidm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

the Subject should mention sun8i-v536.

On Tue, Mar 02, 2021 at 08:37:37PM +0800, Ban Tao wrote:
> The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
> IP compared to the older Allwinner SoCs.
>=20
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
>=20
> ---
> v1->v2:
> 1.delete unnecessary code.
> 2.using a named define for some constants.
> 3.Add comment in sun50i_pwm_config function.
> 4.using dev_err_probe() for error handling.
> 5.disable the clock after pwmchip_remove().
> ---
> v2->v3:
> 1.fix all emitted warnings when PWM_DEBUG enabled.
> 2.modify the name of file pwm-sun50i to pwm-sun8i-v536.
> 3.fix "sun50i_pwm_from_chip" -> "to_sun8i_pwm_chip".
> 4.delete some unnecessary "compatible".
> ---
>  MAINTAINERS                  |   6 +
>  drivers/pwm/Kconfig          |  11 +
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-sun8i-v536.c | 401 +++++++++++++++++++++++++++++++++++
>  4 files changed, 419 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun8i-v536.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..387e187c635c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -737,6 +737,12 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/staging/media/sunxi/cedrus/
> =20
> +ALLWINNER PWM DRIVER
> +M:	Ban Tao <fengzheng923@gmail.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pwm/pwm-sun8i-v536.c
> +
>  ALPHA PORT
>  M:	Richard Henderson <rth@twiddle.net>
>  M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 9a4f66ae8070..3418b5b898a9 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -552,6 +552,17 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN8I_V536
> +	tristate "Allwinner SUN8I_V536 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Enhanced PWM framework driver for Allwinner R818, A133, R329,
> +	  V536 and V833 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun8i-v536.
> +
>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 6374d3b1d6f3..380d6b107308 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN8I_V536)	+=3D pwm-sun8i-v536.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sun8i-v536.c b/drivers/pwm/pwm-sun8i-v536.c
> new file mode 100644
> index 000000000000..52101df6bd41
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i-v536.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Allwinner sun8i-v536 Pulse Width Modulation Controller
> + *
> + * Copyright (C) 2021 Ban Tao <fengzheng923@gmail.com>
> + *
> + *
> + * Limitations:
> + * - When PWM is disabled, the output is driven to inactive.
> + * - If the register is reconfigured while PWM is running,
> + *   it does not complete the currently running period.
> + * - If the user input duty is beyond acceptible limits,
> + *   -EINVAL is returned.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +
> +#define PWM_GET_CLK_OFFSET(chan)	(0x20 + ((chan >> 1) * 0x4))

Please add parenthesis around variable uses, i.e.

+#define PWM_GET_CLK_OFFSET(chan)	(0x20 + (((chan) >> 1) * 0x4))

> +#define PWM_CLK_APB_SCR			BIT(7)
> +#define PWM_DIV_M			0
> +#define PWM_DIV_M_MASK			GENMASK(3, PWM_DIV_M)
> +
> +#define PWM_CLK_REG			0x40
> +#define PWM_CLK_GATING			BIT(0)
> +
> +#define PWM_ENABLE_REG			0x80
> +#define PWM_EN				BIT(0)
> +
> +#define PWM_CTL_REG(chan)		(0x100 + 0x20 * chan)
> +#define PWM_ACT_STA			BIT(8)
> +#define PWM_PRESCAL_K			0
> +#define PWM_PRESCAL_K_MASK		GENMASK(7, PWM_PRESCAL_K)
> +
> +#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
> +#define PWM_ENTIRE_CYCLE			16
> +#define PWM_ENTIRE_CYCLE_MASK		GENMASK(31, PWM_ENTIRE_CYCLE)
> +#define PWM_ACT_CYCLE			0
> +#define PWM_ACT_CYCLE_MASK		GENMASK(15, PWM_ACT_CYCLE)
> +
> +#define BIT_CH(bit, chan)		((bit) << (chan))
> +#define SET_BITS(shift, mask, reg, val) \
> +	    (((reg) & ~mask) | (val << (shift)))

As already pointed out in v2: You're reinventing the stuff from
<linux/bitfield.h> here. Please don't.

> +#define PWM_OSC_CLK			24000000
> +#define PWM_PRESCALER_MAX		256
> +#define PWM_CLK_DIV_M__MAX		9

So you cannot put something bigger than 9 into the 4bit bitfield
defining M?

> +#define PWM_ENTIRE_CYCLE_MAX		65536

Knowing that Thierry doesn't consider it important: I would still prefer
seeing a driver specific prefix for these constants. It's also nice to
make it obvious for bit fields to which register they belong. So I'd
use:

	#define PWMSUN8IV536_REG_ENABLE		0x80
	#define PWMSUN8IV536_REG_ENABLE_EN		BIT(0)



> +struct sun8i_pwm_data {

Given that the driver is called pwm_sun8i_v536 the prefix isn't optimal.
(Though I admit that the whole name is a bit long. hmmmm.)

> +	unsigned int npwm;
> +};
> +
> +struct sun8i_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst_clk;
> +	void __iomem *base;
> +	const struct sun8i_pwm_data *data;
> +};
> +
> +static inline struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *=
chip)
> +{
> +	return container_of(chip, struct sun8i_pwm_chip, chip);
> +}
> +
> +static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *chip,
> +				   unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *chip,
> +				     u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static void sun8i_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct sun8i_pwm_chip *pc =3D to_sun8i_pwm_chip(chip);
> +	u64 clk_rate;
> +	u32 tmp, entire_cycles, active_cycles;
> +	unsigned int prescaler, div_m;
> +
> +	tmp =3D sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	if (tmp & PWM_CLK_APB_SCR)
> +		clk_rate =3D clk_get_rate(pc->clk);
> +	else
> +		clk_rate =3D PWM_OSC_CLK;
> +
> +	tmp =3D sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	div_m =3D 0x1 << (tmp & PWM_DIV_M_MASK);
> +
> +	tmp =3D sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
> +	prescaler =3D (tmp & PWM_PRESCAL_K_MASK) + 1;
> +
> +	tmp =3D sun8i_pwm_readl(pc, PWM_PERIOD_REG(pwm->hwpwm));
> +	entire_cycles =3D (tmp >> PWM_ENTIRE_CYCLE) + 1;

entire_cycles =3D FIELD_GET(PWM_ENTIRE_CYCLE_MASK, tmp) + 1;

When you use this consistently, you don't need the define for
PWM_ENTIRE_CYCLE (holding the shift value) and can use its name to hold
the bitmask.

Also I'd spend a variable per register, then when also following my
advice to have matching names for registers and their bitfields one can
see at a glace that you don't use the bitfield of register A to get a
value from register B.

> +	active_cycles =3D (tmp & PWM_ACT_CYCLE_MASK);
> +
> +	/* (clk / div_m / prescaler) / entire_cycles =3D NSEC_PER_SEC / period_=
ns. */

I'd write:

	The hardware's input clock is divided by div_m and prescaler to
	define the PWM clock. div_m is a power of two in the range [1, 512],
	prescaler is an integer in the range [1, 256].
	Then the period length has a length of $entire_cycles PWM clock
	ticks.

> +	state->period =3D DIV_ROUND_CLOSEST_ULL(entire_cycles * NSEC_PER_SEC,
> +					      clk_rate) * div_m * prescaler;

Please round up the division result. Also if you use

	tmp =3D sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
	m =3D FIELD_GET(PWM_DIV_M_MASK, tmp);

above this can be calculated (maybe) a tad faster using:

	state->period =3D DIV_ROUND_UP_ULL(entire_cycles * NSEC_PER_SEC, clk_rate)=
 * prescaler << m;

The result's precision can be further improved by using

	state->period =3D DIV_ROUND_UP_ULL((u64)entire_cycles * prescaler * NSEC_P=
ER_SEC << m, clk_rate);

=2E This then needs a comment with the reasoning that it cannot overflow.
(That's because entire_cycles < (1 << 16), prescaler <=3D 256 and m <=3D 9,=
 so
entire_cycles * prescaler * NSEC_PER_SEC << 9 is less than
8589934592000000000 which fits into a u64. You'd have to verify however
that m is indeed <=3D 9 then (which you should do anyhow IMHO).

> +	/* duty_ns / period_ns =3D active_cycles / entire_cycles. */
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(active_cycles * state->peri=
od,
> +						  entire_cycles);

Here you're losing precision, please use

	state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)active_cycles * prescaler * NS=
EC_PER_SEC << m, clk_rate);

> +	/* parsing polarity */
> +	tmp =3D sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
> +	if (tmp & PWM_ACT_STA)
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +	else
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +
> +	/* parsing enabled */
> +	tmp =3D sun8i_pwm_readl(pc, PWM_ENABLE_REG);
> +	if (tmp & BIT_CH(PWM_EN, pwm->hwpwm))
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	dev_dbg(chip->dev, "duty_ns=3D%lld period_ns=3D%lld polarity=3D%s enabl=
ed=3D%s.\n",
> +				state->duty_cycle, state->period,
> +				state->polarity ? "inversed":"normal",
> +				state->enabled ? "true":"false");
> +}
> +
> +static void sun8i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				    enum pwm_polarity polarity)
> +{
> +	struct sun8i_pwm_chip *pc =3D to_sun8i_pwm_chip(chip);
> +	u32 temp;
> +
> +	temp =3D sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
> +
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		temp |=3D PWM_ACT_STA;
> +	else
> +		temp &=3D ~PWM_ACT_STA;
> +
> +	sun8i_pwm_writel(pc, temp, PWM_CTL_REG(pwm->hwpwm));
> +}
> +
> +static int sun8i_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			      const struct pwm_state *state)
> +{
> +	struct sun8i_pwm_chip *pc =3D to_sun8i_pwm_chip(chip);
> +	unsigned long long c;
> +	unsigned long entire_cycles, active_cycles;
> +	unsigned int div_m, prescaler;
> +	u64 duty_ns =3D state->duty_cycle, period_ns =3D state->period;
> +	u32 config;
> +	int ret =3D 0;
> +
> +	if (period_ns > 334) {

For this decision you seem to anticipate a value for the APB clock
speed. Please describe the weighing in a comment.

> +		/* if freq < 3M, then select 24M clock */
> +		c =3D PWM_OSC_CLK;
> +		config =3D sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +		config &=3D ~PWM_CLK_APB_SCR;
> +		sun8i_pwm_writel(pc, config, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	} else {
> +		/* if freq > 3M, then select APB as clock */
> +		c =3D clk_get_rate(pc->clk);
> +		config =3D sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +		config |=3D PWM_CLK_APB_SCR;
> +		sun8i_pwm_writel(pc, config, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	}
> +
> +	dev_dbg(chip->dev, "duty_ns=3D%lld period_ns=3D%lld c =3D%llu.\n",
> +			duty_ns, period_ns, c);
> +
> +	/*
> +	 * (clk / div_m / prescaler) / entire_cycles =3D NSEC_PER_SEC / period_=
ns.
> +	 * So, entire_cycles =3D clk * period_ns / NSEC_PER_SEC / div_m / presc=
aler.
> +	 */
> +	c =3D c * period_ns;
> +	c =3D DIV_ROUND_CLOSEST_ULL(c, NSEC_PER_SEC);

Please round down. Given the right test case PWM_DEBUG should criticise
this.

> +	for (div_m =3D 0; div_m < PWM_CLK_DIV_M__MAX; div_m++) {
> +		for (prescaler =3D 0; prescaler < PWM_PRESCALER_MAX; prescaler++) {
> +			/*
> +			 * actual prescaler =3D prescaler(reg value) + 1.
> +			 * actual div_m =3D 0x1 << div_m(reg value).
> +			 */
> +			entire_cycles =3D ((unsigned long)c >> div_m)/(prescaler + 1);
> +			if (entire_cycles <=3D PWM_ENTIRE_CYCLE_MAX)
> +				goto calc_end;
> +		}
> +	}

In my reply to your v2 I already pointed out a better way to calculate M
and prescaler, please either use it or reason that my suggestion was
bad.

> +	ret =3D -EINVAL;
> +	goto exit;

Given that jumping to exit only returns ret, I'd claim that using return
-EINVAL is better readable than this.

> +calc_end:
> +	/*
> +	 * duty_ns / period_ns =3D active_cycles / entire_cycles.
> +	 * So, active_cycles =3D entire_cycles * duty_ns / period_ns.
> +	 */
> +	c =3D (unsigned long long)entire_cycles * duty_ns;
> +	c =3D DIV_ROUND_CLOSEST_ULL(c, period_ns);
> +	active_cycles =3D c;
> +	if (entire_cycles =3D=3D 0)
> +		entire_cycles++;
> +
> +	/* config  clk div_m*/
> +	config =3D sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	config =3D SET_BITS(PWM_DIV_M, PWM_DIV_M_MASK, config, div_m);
> +	sun8i_pwm_writel(pc, config, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +
> +	/* config prescaler */
> +	config =3D sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
> +	config =3D SET_BITS(PWM_PRESCAL_K, PWM_PRESCAL_K_MASK, config, prescale=
r);
> +	sun8i_pwm_writel(pc, config, PWM_CTL_REG(pwm->hwpwm));
> +
> +	/* config active and period cycles */
> +	config =3D sun8i_pwm_readl(pc, PWM_PERIOD_REG(pwm->hwpwm));
> +	config =3D SET_BITS(PWM_ACT_CYCLE, PWM_ACT_CYCLE_MASK, config, active_c=
ycles);
> +	config =3D SET_BITS(PWM_ENTIRE_CYCLE, PWM_ENTIRE_CYCLE_MASK,
> +			config, (entire_cycles - 1));
> +	sun8i_pwm_writel(pc, config, PWM_PERIOD_REG(pwm->hwpwm));
> +
> +	dev_dbg(chip->dev, "active_cycles=3D%lu entire_cycles=3D%lu prescaler=
=3D%u div_m=3D%u\n",
> +			   active_cycles, entire_cycles, prescaler, div_m);

I assume the output wave form starts to change as soon as you do the
first register write, so there might happen some glitches that need
mentioning in the Limitations section above.

> +
> +exit:
> +	return ret;
> +}
> +
> +static void sun8i_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     bool enable)
> +{
> +	struct sun8i_pwm_chip *pc =3D to_sun8i_pwm_chip(chip);
> +	u32 clk, pwm_en;
> +
> +	clk =3D sun8i_pwm_readl(pc, PWM_CLK_REG);
> +	pwm_en =3D sun8i_pwm_readl(pc, PWM_ENABLE_REG);
> +
> +	if (enable) {
> +		clk |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +		sun8i_pwm_writel(pc, clk, PWM_CLK_REG);
> +
> +		pwm_en |=3D BIT_CH(PWM_EN, pwm->hwpwm);
> +		sun8i_pwm_writel(pc, pwm_en, PWM_ENABLE_REG);
> +	} else {
> +		pwm_en &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> +		sun8i_pwm_writel(pc, pwm_en, PWM_ENABLE_REG);
> +
> +		clk &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +		sun8i_pwm_writel(pc, clk, PWM_CLK_REG);
> +	}
> +}
> +
> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct pwm_state curstate;
> +	int ret;
> +
> +	pwm_get_state(pwm, &curstate);

Please don't use pwm_get_state. There is a problem in the PWM framework
that might require that we add locking to these functions. Using
consumer functions in a lowlevel driver would probably deadlock then.

> +	ret =3D sun8i_pwm_config(chip, pwm, state);
> +
> +	if (state->polarity !=3D curstate.polarity)
> +		sun8i_pwm_set_polarity(chip, pwm, state->polarity);
> +
> +	if (state->enabled !=3D curstate.enabled)
> +		sun8i_pwm_enable(chip, pwm, state->enabled);

If your PWM is enabled and the consumer calls:

	pwm_apply_state(mypwm, { .enabled =3D false, .period =3D someperiod, .duty=
_cycle =3D someduty});

the hardware might emit someperiod,someduty for a moment, right? Please
ensure that in this case you disable first.

> +	return ret;
> +}
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s47yztabt4tfgidm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBBEyQACgkQwfwUeK3K
7Al5UQgAkgxpmrJSpQHIHngC5I+6MQ5uRcJSXpmE+TtJjwpv6rA2YhcZjHcM3Dei
iii2Mpdkbuqj9LFT0F0TSbg/wODT7bJjvKUh03gr8WIUsVcAHImp5MzkSMJ6mLhk
6nNhtmoctO9V252fbaU5dONUVFC+zFXH36Ahe01UA9d5DAWL3s6Q6NslM8xWsfzu
iR0Izd3E2aWA1NXGx0iiHWRwtlTGscutjbSHivYBDTpQfnXWxhv87np84tMt/rqP
IMhqMagl739tR0j8or+7wwnVFStA4B8BlAbdvKrmlp6wBw10XBn27QaMQhUaDuAU
rV49r+ue4U4uaPQ6TZb3qaa2dSsSWg==
=r5tr
-----END PGP SIGNATURE-----

--s47yztabt4tfgidm--
