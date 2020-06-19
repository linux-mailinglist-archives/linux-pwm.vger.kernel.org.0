Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15D72001D3
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2020 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgFSGCX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Jun 2020 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgFSGCX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Jun 2020 02:02:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE32C06174E
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2020 23:02:22 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jmA6R-0000Bj-C4; Fri, 19 Jun 2020 08:02:15 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jmA6P-0003Sq-S7; Fri, 19 Jun 2020 08:02:13 +0200
Date:   Fri, 19 Jun 2020 08:02:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200619060213.ldvun5y4tgnz55hh@taurus.defre.kleine-koenig.org>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
 <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s4q67lgek7jj2cgj"
Content-Disposition: inline
In-Reply-To: <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s4q67lgek7jj2cgj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rahul,

On Thu, Jun 18, 2020 at 08:05:13PM +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/pwm/Kconfig         |   9 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-intel-lgm.c | 400 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 410 insertions(+)
>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cb8d739067d2..a3303e22d5fa 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -232,6 +232,15 @@ config PWM_IMX_TPM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx-tpm.
> =20
> +config PWM_INTEL_LGM
> +	tristate "Intel LGM PWM support"
> +	depends on X86 || COMPILE_TEST
> +	help
> +	  Generic PWM fan controller driver for LGM SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-intel-lgm.
> +
>  config PWM_IQS620A
>  	tristate "Azoteq IQS620A PWM support"
>  	depends on MFD_IQS62X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a59c710e98c7..db154a6b4f51 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
>  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> +obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
> new file mode 100644
> index 000000000000..3c7077acb161
> --- /dev/null
> +++ b/drivers/pwm/pwm-intel-lgm.c
> @@ -0,0 +1,400 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Intel Corporation.
> + *
> + * Notes & Limitations:
> + * - The hardware supports fixed period which is dependent on 2/3 or 4
> + *   wire fan mode.
> + * - Supports normal polarity. Does not support changing polarity.
> + * - When PWM is disabled, output of PWM will become 0(inactive). It doe=
sn't
> + *   keep track of running period.
> + * - When duty cycle is changed, PWM output may be a mix of previous set=
ting
> + *   and new setting for the first period. From second period, the outpu=
t is
> + *   based on new setting.
> + * - Supports 100% duty cycle.
> + * - It is a dedicated PWM fan controller. There are no other consumers =
for
> + *   this PWM controller.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#define PWM_FAN_CON0		0x0
> +#define PWM_FAN_EN_EN		BIT(0)
> +#define PWM_FAN_EN_DIS		0x0
> +#define PWM_FAN_EN_MSK		BIT(0)
> +#define PWM_FAN_MODE_2WIRE	0x0
> +#define PWM_FAN_MODE_4WIRE	0x1
> +#define PWM_FAN_MODE_MSK	BIT(1)
> +#define PWM_FAN_PWM_DIS_DIS	0x0
> +#define PWM_FAN_PWM_DIS_MSK	BIT(2)
> +#define PWM_TACH_EN_EN		0x1
> +#define PWM_TACH_EN_MSK		BIT(4)
> +#define PWM_TACH_PLUS_2		0x0
> +#define PWM_TACH_PLUS_4		0x1
> +#define PWM_TACH_PLUS_MSK	BIT(5)
> +#define PWM_FAN_DC_MSK		GENMASK(23, 16)
> +
> +#define PWM_FAN_CON1		0x4
> +#define PWM_FAN_MAX_RPM_MSK	GENMASK(15, 0)
> +
> +#define PWM_FAN_STAT		0x10
> +#define PWM_FAN_TACH_MASK	GENMASK(15, 0)
> +
> +#define MAX_RPM			(BIT(16) - 1)
> +#define DFAULT_RPM		4000
> +#define MAX_DUTY_CYCLE		(BIT(8) - 1)
> +
> +#define FRAC_BITS		10
> +#define DC_BITS			8
> +#define TWO_TENTH		204
> +
> +#define PERIOD_2WIRE_NSECS	40000000
> +#define PERIOD_4WIRE_NSECS	40000
> +
> +#define TWO_SECONDS		2000
> +#define IGNORE_FIRST_ERR	1
> +#define THIRTY_SECS_WINDOW	15
> +#define ERR_CNT_THRESHOLD	6
> +
> +struct lgm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	u32 tach_en;
> +	u32 max_rpm;
> +	u32 set_rpm;
> +	u32 set_dc;
> +	u32 period;
> +	struct delayed_work work;
> +};
> +
> +static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct lgm_pwm_chip, chip);
> +}
> +
> +static int lgm_pwm_update_dc(struct lgm_pwm_chip *pc, u32 val)
> +{
> +	return regmap_update_bits(pc->regmap, PWM_FAN_CON0, PWM_FAN_DC_MSK,
> +				  FIELD_PREP(PWM_FAN_DC_MSK, val));
> +}
> +
> +static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	struct regmap *regmap =3D pc->regmap;
> +
> +	if (enable) {
> +		regmap_update_bits(regmap, PWM_FAN_CON0,
> +				   PWM_FAN_EN_MSK, PWM_FAN_EN_EN);
> +		if (pc->tach_en)
> +			schedule_delayed_work(&pc->work, msecs_to_jiffies(10000));
> +	} else {
> +		if (pc->tach_en)
> +			cancel_delayed_work_sync(&pc->work);
> +		regmap_update_bits(regmap, PWM_FAN_CON0,
> +			   	   PWM_FAN_EN_MSK, PWM_FAN_EN_DIS);
> +	}
> +
> +	return 0;
> +}
> +
> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	struct pwm_state cur_state;
> +	u32 duty_cycle, duty, val;
> +	int ret =3D 0;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> +	    state->period !=3D pc->period)

The period-check is too strict, please accept periods bigger than the
resulting value. This case however isn't handled correctly yet in the
following code and needs:

	period =3D min(state->period, pc->period);

	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
	    period < pc->period)
	    	return -EINVAL;

(and then use period instead of state->period in the following)

> +		return -EINVAL;
> +
> +	cur_state =3D pwm->state;
> +	duty_cycle =3D state->duty_cycle;

This would then be:

	duty_cycle =3D min(state->duty_cycle, period);

> +	if (!state->enabled)
> +		duty_cycle =3D 0;

What happens if you don't set duty_cycle to 0? Is it just to prevent a
spike in lgm_pwm_update_dc before calling lgm_pwm_enable(.., false)? If
so, what about skipping writing (and calculating) the duty register
value at all?

> +	duty =3D duty_cycle * (1U << DC_BITS);
> +	val =3D DIV_ROUND_CLOSEST(duty, state->period);

This is equivalent to:

	val =3D DIV_ROUND_CLOSEST(duty_cycle << DC_BITS, state->period);

which doesn't need two variables with similar name but different
scaling. Having said that using closest rounding is wrong here, please
round down.

> +	val =3D min_t(u32, val, MAX_DUTY_CYCLE);

Hmm, this looks suspicious. Does the hardware really produce 100% when
val =3D MAX_DUTY_CYCLE? Either it doesn't or there is a rounding error in
your algorithm. Does the PWM support 0%? It would help to mention the
formula from the reference manual to verify and understand your
algorithm. Please add a comment for that.

> +	if (pc->tach_en) {
> +		pc->set_dc =3D val;
> +		pc->set_rpm =3D val * pc->max_rpm / MAX_DUTY_CYCLE;
> +	}
> +
> +	ret =3D lgm_pwm_update_dc(pc, val);
> +
> +	if (state->enabled !=3D cur_state.enabled)
> +		lgm_pwm_enable(chip, state->enabled);

I would prefer if you would make this call conditional on the (cached)
state of the PWM_FAN_EN_MSK bit instead of pwm->state. This way the
driver is more independent from pwm API internals.

> +	return ret;
> +}
> +
> +static void lgm_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      struct pwm_state *state)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	u32 duty, val;
> +
> +	state->enabled =3D regmap_test_bits(pc->regmap, PWM_FAN_CON0,
> +					  PWM_FAN_EN_EN);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->period =3D pc->period; /* fixed period */
> +
> +	regmap_read(pc->regmap, PWM_FAN_CON0, &val);
> +	duty =3D FIELD_GET(PWM_FAN_DC_MSK, val);
> +	state->duty_cycle =3D duty * pc->period >> DC_BITS;

The rounding here must use the inverse rounding of .apply(). So please
round up here.

> +}
> +
> +static const struct pwm_ops lgm_pwm_ops =3D {
> +	.get_state =3D lgm_pwm_get_state,
> +	.apply =3D lgm_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static void lgm_pwm_tach_work(struct work_struct *work)
> +{
> +	struct lgm_pwm_chip *pc =3D container_of(work, struct lgm_pwm_chip,
> +						 work.work);
> +	struct regmap *regmap =3D pc->regmap;
> +	u32 fan_tach, fan_dc, val;
> +	s32 diff;
> +	static u32 fanspeed_err_cnt, time_window, delta_dc;
> +
> +	/*
> +	 * Fan speed is tracked by reading the active duty cycle of PWM output
> +	 * from the active duty cycle register. Some variance in the duty cycle
> +	 * register value is expected. So we set a time window of 30 seconds and
> +	 * if we detect inaccurate fan speed 6 times within 30 seconds then we
> +	 * mark it as fan speed problem and fix it by readjusting the duty cycl=
e.
> +	 */
> +
> +	if (fanspeed_err_cnt > IGNORE_FIRST_ERR)
> +		/*
> +		 * Ignore first time we detect inaccurate fan speed
> +		 * because it is expected during bootup.
> +		 */
> +		time_window++;
> +
> +	if (time_window =3D=3D THIRTY_SECS_WINDOW) {
> +		/*
> +		 * This work is scheduled every 2 seconds i.e. each time_window
> +		 * counter step roughly mean 2 seconds. When the time window
> +		 * reaches 30 seconds, reset all the counters/logic.
> +		 */
> +		fanspeed_err_cnt =3D 0;
> +		delta_dc =3D 0;
> +		time_window =3D 0;
> +	}
> +
> +	regmap_read(regmap, PWM_FAN_STAT, &fan_tach);
> +	fan_tach &=3D PWM_FAN_TACH_MASK;
> +	if (!fan_tach)
> +		goto restart_work;
> +
> +	val =3D DIV_ROUND_CLOSEST(pc->set_rpm << FRAC_BITS, fan_tach);
> +	diff =3D val - BIT(FRAC_BITS);
> +
> +	if (abs(diff) > TWO_TENTH) {
> +		/* if duty cycle diff is more than two tenth, detect it as error */
> +		if (fanspeed_err_cnt > IGNORE_FIRST_ERR)
> +			delta_dc +=3D val;
> +		fanspeed_err_cnt++;
> +	}
> +
> +	if (fanspeed_err_cnt =3D=3D ERR_CNT_THRESHOLD) {
> +		/*
> +		 * We detected fan speed errors 6 times with 30 seconds.
> +		 * Fix the error by readjusting duty cycle and reset
> +		 * our counters/logic.
> +		 */
> +		fan_dc =3D pc->set_dc * delta_dc >> (FRAC_BITS + 2);
> +		fan_dc =3D min_t(u32, fan_dc, MAX_DUTY_CYCLE);
> +		lgm_pwm_update_dc(pc, fan_dc);
> +		fanspeed_err_cnt =3D 0;
> +		delta_dc =3D 0;
> +		time_window =3D 0;
> +	}
> +
> +restart_work:
> +	/*
> +	 * Fan speed doesn't need continous tracking. Schedule this work
> +	 * every two seconds so it doesn't steal too much cpu cycles.
> +	 */
> +	schedule_delayed_work(&pc->work, msecs_to_jiffies(TWO_SECONDS));

You had concerns about my review feedback that I don't like the fan
stuff in the PWM driver. I still think that the fan part doesn't belong
here.

> +}
> +
> +static void lgm_pwm_init(struct lgm_pwm_chip *pc)
> +{
> +	struct device *dev =3D pc->chip.dev;
> +	struct regmap *regmap =3D pc->regmap;
> +	u32 max_rpm, fan_wire, tach_plus, con0_val, con0_mask;
> +
> +	if (device_property_read_u32(dev, "intel,fan-wire", &fan_wire))
> +		fan_wire =3D 2; /* default is 2 wire mode */
> +
> +	con0_val =3D FIELD_PREP(PWM_FAN_PWM_DIS_MSK, PWM_FAN_PWM_DIS_DIS);
> +	con0_mask =3D PWM_FAN_PWM_DIS_MSK | PWM_FAN_MODE_MSK;

Please don't disable the PWM in .probe()

> +
> +	switch (fan_wire) {
> +	case 4:
> +		con0_val |=3D FIELD_PREP(PWM_FAN_MODE_MSK, PWM_FAN_MODE_4WIRE) |
> +			    FIELD_PREP(PWM_TACH_EN_MSK, PWM_TACH_EN_EN);
> +		con0_mask |=3D PWM_TACH_EN_MSK | PWM_TACH_PLUS_MSK;
> +		pc->tach_en =3D 1;
> +		pc->period =3D PERIOD_4WIRE_NSECS;
> +		break;
> +	default:
> +		/* default is 2wire mode */
> +		con0_val |=3D FIELD_PREP(PWM_FAN_MODE_MSK, PWM_FAN_MODE_2WIRE);
> +		pc->period =3D PERIOD_2WIRE_NSECS;
> +		break;
> +	}
> +
> +	if (pc->tach_en) {
> +		if (device_property_read_u32(dev, "intel,tach-plus",
> +					     &tach_plus))
> +			tach_plus =3D 2;
> +
> +		switch (tach_plus) {
> +		case 4:
> +			con0_val |=3D FIELD_PREP(PWM_TACH_PLUS_MSK,
> +					       PWM_TACH_PLUS_4);
> +			break;
> +		default:
> +			con0_val |=3D FIELD_PREP(PWM_TACH_PLUS_MSK,
> +					       PWM_TACH_PLUS_2);
> +			break;
> +		}
> +
> +		if (device_property_read_u32(dev, "intel,max-rpm", &max_rpm))
> +			max_rpm =3D DFAULT_RPM;
> +
> +		max_rpm =3D min_t(u32, max_rpm, MAX_RPM);
> +		if (max_rpm =3D=3D 0)
> +			max_rpm =3D DFAULT_RPM;
> +
> +		pc->max_rpm =3D max_rpm;
> +		INIT_DEFERRABLE_WORK(&pc->work, lgm_pwm_tach_work);
> +		regmap_update_bits(regmap, PWM_FAN_CON1,
> +				   PWM_FAN_MAX_RPM_MSK, max_rpm);
> +	}
> +
> +	regmap_update_bits(regmap, PWM_FAN_CON0, con0_mask, con0_val);
> +}
> +
> +static const struct regmap_config pwm_regmap_config =3D {

Here you missed to add the lgm_ prefix.

> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +};
> +
> +static int lgm_pwm_probe(struct platform_device *pdev)
> +{
> +	struct lgm_pwm_chip *pc;
> +	struct device *dev =3D &pdev->dev;
> +	void __iomem *io_base;
> +	int ret;
> +
> +	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	io_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	pc->regmap =3D devm_regmap_init_mmio(dev, io_base, &pwm_regmap_config);
> +	if (IS_ERR(pc->regmap)) {
> +		ret =3D PTR_ERR(pc->regmap);
> +		dev_err(dev, "failed to init register map: %pe\n", pc->regmap);
> +		return ret;
> +	}
> +
> +	pc->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pc->clk)) {
> +		ret =3D PTR_ERR(pc->clk);
> +		dev_err(dev, "failed to get clock: %pe\n", pc->clk);
> +		return ret;
> +	}
> +
> +	pc->rst =3D devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(pc->rst)) {
> +		ret =3D PTR_ERR(pc->rst);
> +		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);
> +		return ret;
> +	}
> +
> +	ret =3D reset_control_deassert(pc->rst);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert reset control: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(pc->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	pc->chip.dev =3D dev;
> +	pc->chip.ops =3D &lgm_pwm_ops;
> +	pc->chip.npwm =3D 1;
> +
> +	lgm_pwm_init(pc);
> +
> +	ret =3D pwmchip_add(&pc->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to add PWM chip: %d\n", ret);

%pe please.

> +		clk_disable_unprepare(pc->clk);
> +		reset_control_assert(pc->rst);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pc);
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s4q67lgek7jj2cgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7sVOIACgkQwfwUeK3K
7AnLbQf9E9/hFQg2xtnaMPMkPFQIgjq3vs8CnQd6qCqz/MgRjuPMqarqd4jty/gL
F/+VdviP+GgaBcRKVaHO6xC/jZpySZLS1y3tl2QsraGQVZ+lpYh3ES637XIcCbjQ
HH+BLGDV1TQ7zA5XnZE14pfKx7tzfMeX+1C8Bn8lHHwWGz/S6522/cdOZJ1WYjwh
hbi1RLBTXGjYIkdeWyQeWeMgvWnN2gN9uLcp05ZI4YCyLo6WxSfF4SZga6kIEapc
XNp/+eZLRqqUdzciALZcsdPOtkE/t3SqUpPxAEIPWQpKtBQYCIhYslJ6TXEG/Stl
nD0Tw5xIt4v7nImULwuPLlEVg/aoug==
=90Xl
-----END PGP SIGNATURE-----

--s4q67lgek7jj2cgj--
