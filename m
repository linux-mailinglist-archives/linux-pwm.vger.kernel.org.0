Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2308521E080
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2020 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGMTLG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jul 2020 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTLG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 15:11:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD7AC061755
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jul 2020 12:11:05 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jv3qv-00075n-Il; Mon, 13 Jul 2020 21:11:01 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jv3qt-0002oJ-PY; Mon, 13 Jul 2020 21:10:59 +0200
Date:   Mon, 13 Jul 2020 21:10:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v4 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <a74b18b68f26bf902c30a017050cc4ea070da887.1593503228.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="csyip5vgfnxw7tta"
Content-Disposition: inline
In-Reply-To: <a74b18b68f26bf902c30a017050cc4ea070da887.1593503228.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--csyip5vgfnxw7tta
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 30, 2020 at 03:55:32PM +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/pwm/Kconfig         |  11 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-intel-lgm.c | 266 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 278 insertions(+)
>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cb8d739067d2..3486edab09c4 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -232,6 +232,17 @@ config PWM_IMX_TPM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx-tpm.
> =20
> +config PWM_INTEL_LGM
> +	tristate "Intel LGM PWM support"
> +	depends on OF && HAS_IOMEM
> +	depends on X86 || COMPILE_TEST
> +	select REGMAP_MMIO
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
> index 000000000000..fddfedd56fc3
> --- /dev/null
> +++ b/drivers/pwm/pwm-intel-lgm.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Intel Corporation.
> + *
> + * Notes & Limitations:

I'd like to have this "Limitations:" only to make it easily greppable.

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
> +#define LGM_PWM_FAN_CON0		0x0
> +#define LGM_PWM_FAN_EN_EN		BIT(0)
> +#define LGM_PWM_FAN_EN_DIS		0x0
> +#define LGM_PWM_FAN_EN_MSK		BIT(0)
> +#define LGM_PWM_FAN_MODE_2WIRE		0x0
> +#define LGM_PWM_FAN_MODE_4WIRE		0x1
> +#define LGM_PWM_FAN_MODE_MSK		BIT(1)
> +#define LGM_PWM_FAN_DC_MSK		GENMASK(23, 16)
> +
> +#define LGM_PWM_FAN_CON1		0x4
> +#define LGM_PWM_FAN_MAX_RPM_MSK		GENMASK(15, 0)
> +
> +#define LGM_PWM_MAX_RPM			(BIT(16) - 1)
> +#define LGM_PWM_DEFAULT_RPM		4000
> +#define LGM_PWM_MAX_DUTY_CYCLE		(BIT(8) - 1)
> +
> +#define LGM_PWM_DC_BITS			8
> +
> +#define LGM_PWM_PERIOD_2WIRE_NSECS	40000000
> +#define LGM_PWM_PERIOD_4WIRE_NSECS	40000
> +
> +struct lgm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	u32 period;
> +};
> +
> +static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct lgm_pwm_chip, chip);
> +}
> +
> +static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	struct regmap *regmap =3D pc->regmap;
> +
> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_EN_MSK,
> +			   enable ? LGM_PWM_FAN_EN_EN : LGM_PWM_FAN_EN_DIS);

regmap_update_bits has a return value. I think it is supposed to be
checked.

> +
> +	return 0;
> +}
> +
> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	u32 duty_cycle, val;
> +	unsigned int period;
> +
> +	if (!state->enabled) {
> +		lgm_pwm_enable(chip, 0);
> +		return 0;
> +	}
> +
> +	period =3D min_t(u64, state->period, pc->period);
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> +	    period < pc->period)
> +		return -EINVAL;

This check looks wrong. If you refuse period < pc->period there isn't
much configuration possible.

> +	duty_cycle =3D min_t(u32, state->duty_cycle, period);

This is wrong. Consider state->duty_cycle =3D 0x100000001 (once it is an
u64).

> +	/* reg_value =3D duty_ns * LGM_PWM_MAX_DUTY_CYCLE(0xff) / period_ns */
> +	val =3D duty_cycle * LGM_PWM_MAX_DUTY_CYCLE / period;

The comment is little helpful.

> +	regmap_update_bits(pc->regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_DC_MSK,
> +			   FIELD_PREP(LGM_PWM_FAN_DC_MSK, val));
> +
> +	if (state->enabled)
> +		lgm_pwm_enable(chip, 1);
> +
> +	return 0;
> +}
> +
> +static void lgm_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      struct pwm_state *state)
> +{
> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> +	u32 duty, val;
> +
> +	state->enabled =3D regmap_test_bits(pc->regmap, LGM_PWM_FAN_CON0,
> +					  LGM_PWM_FAN_EN_EN);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->period =3D pc->period; /* fixed period */
> +
> +	regmap_read(pc->regmap, LGM_PWM_FAN_CON0, &val);
> +	duty =3D FIELD_GET(LGM_PWM_FAN_DC_MSK, val);
> +	state->duty_cycle =3D DIV_ROUND_UP(duty * pc->period,
> +					 LGM_PWM_MAX_DUTY_CYCLE);
> +}
> +
> +static const struct pwm_ops lgm_pwm_ops =3D {
> +	.get_state =3D lgm_pwm_get_state,
> +	.apply =3D lgm_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static void lgm_pwm_init(struct lgm_pwm_chip *pc)
> +{
> +	struct device *dev =3D pc->chip.dev;
> +	struct regmap *regmap =3D pc->regmap;
> +	u32 max_rpm, fan_wire, con0_val, con0_mask;
> +
> +	if (device_property_read_u32(dev, "intel,fan-wire", &fan_wire))
> +		fan_wire =3D 2; /* default is 2 wire mode */
> +
> +	con0_mask =3D LGM_PWM_FAN_MODE_MSK;
> +
> +	switch (fan_wire) {
> +	case 4:
> +		con0_val =3D FIELD_PREP(LGM_PWM_FAN_MODE_MSK, LGM_PWM_FAN_MODE_4WIRE);
> +		pc->period =3D LGM_PWM_PERIOD_4WIRE_NSECS;
> +		break;
> +	default:
> +		/* default is 2wire mode */
> +		con0_val =3D FIELD_PREP(LGM_PWM_FAN_MODE_MSK, LGM_PWM_FAN_MODE_2WIRE);
> +		pc->period =3D LGM_PWM_PERIOD_2WIRE_NSECS;
> +		break;
> +	}
> +
> +	if (device_property_read_u32(dev, "intel,max-rpm", &max_rpm))
> +		max_rpm =3D LGM_PWM_DEFAULT_RPM;
> +
> +	max_rpm =3D min_t(u32, max_rpm, LGM_PWM_MAX_RPM);
> +	if (max_rpm =3D=3D 0)
> +		max_rpm =3D LGM_PWM_DEFAULT_RPM;
> +
> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON1, LGM_PWM_FAN_MAX_RPM_MSK, m=
ax_rpm);
> +	regmap_update_bits(regmap, LGM_PWM_FAN_CON0, con0_mask, con0_val);
> +}
> +
> +static const struct regmap_config lgm_pwm_regmap_config =3D {
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
> +	pc->regmap =3D devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_conf=
ig);
> +	if (IS_ERR(pc->regmap)) {
> +		ret =3D PTR_ERR(pc->regmap);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to init register map: %pe\n",
> +				pc->regmap);
> +		return ret;
> +	}
> +
> +	pc->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pc->clk)) {
> +		ret =3D PTR_ERR(pc->clk);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to get clock: %pe\n", pc->clk);
> +		return ret;
> +	}
> +
> +	pc->rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pc->rst)) {
> +		ret =3D PTR_ERR(pc->rst);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to get reset control: %pe\n",
> +				pc->rst);
> +		return ret;
> +	}
> +
> +	ret =3D reset_control_deassert(pc->rst);
> +	if (ret) {
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "cannot deassert reset control: %pe\n",
> +				ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(pc->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");

reset_control_assert missing here.

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
> +		dev_err(dev, "failed to add PWM chip: %pe\n", ERR_PTR(ret));
> +		clk_disable_unprepare(pc->clk);
> +		reset_control_assert(pc->rst);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pc);
> +	return 0;
> +}
> +
> +static int lgm_pwm_remove(struct platform_device *pdev)
> +{
> +	struct lgm_pwm_chip *pc =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&pc->chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	clk_disable_unprepare(pc->clk);
> +	reset_control_assert(pc->rst);

Please swap the two previous lines to match the error patch of .probe.

> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--csyip5vgfnxw7tta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8MscAACgkQwfwUeK3K
7AmOSQf9Gc0ghAccaxb0AqSC6aiVgdG/v5bKo/kpS+sTvXH/ZAZITpIgIoP5PFk/
ogFgBJJ6cVRYEwtNJC/fBOc7oj89Jvr9Ra6vigPn0z2si5l59tNF2M1XlrMSBYl3
AiLYq/PgJRdNnutULF/rxSd8NbXBKnr9OhxZOR/jWpSaU2Ufo3yXZXaPbBxQygHS
Ub/S460N1MwT2Vus6dhSbum23oP6IRvP2m5cESwHEWrG0PjocxWN3KsS6rqh9Oa2
RSYlT4S2/SnovH9nHULzzQCZFrwNZDqO0jsjBwDxngt2TJc0Bl0oDE39lEU7cYx7
wrqx59LugzhTolmPxQ4d9XCykvfOHQ==
=wcBm
-----END PGP SIGNATURE-----

--csyip5vgfnxw7tta--
