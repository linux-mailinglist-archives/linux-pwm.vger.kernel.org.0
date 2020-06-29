Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAD20D8F2
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 22:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgF2Tm5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbgF2Tmo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:42:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97AAC02A576
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 06:43:51 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpu4a-0007OW-GO; Mon, 29 Jun 2020 15:43:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpu4Y-0000bN-D0; Mon, 29 Jun 2020 15:43:46 +0200
Date:   Mon, 29 Jun 2020 15:43:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v3 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200629134346.yjol6xk2iafs2mgj@pengutronix.de>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
 <df22a642083474e71f9f8274c033a6ef9757af5f.1593420979.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n26qah5gp5lkcukr"
Content-Disposition: inline
In-Reply-To: <df22a642083474e71f9f8274c033a6ef9757af5f.1593420979.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n26qah5gp5lkcukr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rahul,

On Mon, Jun 29, 2020 at 05:03:47PM +0800, Rahul Tanwar wrote:
> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
> new file mode 100644
> index 000000000000..661fa7d9145d
> --- /dev/null
> +++ b/drivers/pwm/pwm-intel-lgm.c
> @@ -0,0 +1,265 @@
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

This would be worth mentioning if it didn't support that. IMHO you can
drop this one.

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
> +#define PWM_FAN_DC_MSK		GENMASK(23, 16)
> +
> +#define PWM_FAN_CON1		0x4
> +#define PWM_FAN_MAX_RPM_MSK	GENMASK(15, 0)
> +
> +#define MAX_RPM			(BIT(16) - 1)
> +#define DFAULT_RPM		4000

DEFAULT_RPM?
> +#define MAX_DUTY_CYCLE		(BIT(8) - 1)
> +
> +#define DC_BITS			8
> +
> +#define PERIOD_2WIRE_NSECS	40000000
> +#define PERIOD_4WIRE_NSECS	40000

Please add a common prefix to these definitions.

> +#define LGM_PWM_DIV_ROUND_DOWN(n, d) (((n) + ((d) / 2) - 1) / (d))
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
> +	if (enable)
> +		regmap_update_bits(regmap, PWM_FAN_CON0,
> +				   PWM_FAN_EN_MSK, PWM_FAN_EN_EN);
> +	else
> +		regmap_update_bits(regmap, PWM_FAN_CON0,
> +			   	   PWM_FAN_EN_MSK, PWM_FAN_EN_DIS);

Is it easier to understand what happens here if you write this as:

+	regmap_update_bits(regmap, PWM_FAN_CON0, PWM_FAN_EN_MSK,
+			   enable ? PWM_FAN_EN_EN : PWM_FAN_EN_DIS);

? (This is what I'd prefer, but maybe this is subjective?)

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
> +	period =3D min_t(unsigned int, state->period, pc->period);

Given that state->period will most probably change type (from unsigned
int to u64) soon, it would be nice to use this already here.

> +	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> +	    period < pc->period)
> +		return -EINVAL;
> +
> +	duty_cycle =3D min_t(u32, state->duty_cycle, period);
> +
> +	/* reg_value =3D duty_ns * MAX_REG_VAL(0xff) / period_ns */

s/MAX_REG_VAL/MAX_DUTY_CYCLE/

> +	val =3D LGM_PWM_DIV_ROUND_DOWN(duty_cycle << DC_BITS, period);

The rounding is wrong here, you have to round down. I think you need to
do:

	val =3D duty_cycle * MAX_DUTY_CYCLE / period;

> +	val =3D min_t(u32, val, MAX_DUTY_CYCLE);

Then as duty_cycle <=3D period this is a noop and can be dropped.

> +	regmap_update_bits(pc->regmap, PWM_FAN_CON0, PWM_FAN_DC_MSK,
> +			   FIELD_PREP(PWM_FAN_DC_MSK, val));
> +
> +	if (state->enabled !=3D regmap_test_bits(pc->regmap, PWM_FAN_CON0,
> +					       PWM_FAN_EN_EN))
> +		lgm_pwm_enable(chip, state->enabled);

Here a spike can happen that you can prevent:

	pwm_apply_state(pwm, { .enabled =3D 1, .duty_cycle =3D 0ms, .period =3D 40=
ms })
	pwm_apply_state(pwm, { .enabled =3D 0, .duty_cycle =3D 40ms, .period =3D 4=
0ms })

As apply first configures the duty_cycle, the output goes high before
disabling. So better do something like:

	if (!state->enabled) {
		lgm_pwm_enable(chip, 0);
		return;
	}

	configure_duty_cycle();

	if ( state->enabled)
		lgm_pwm_enable(chip, 1);

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
> +	state->enabled =3D regmap_test_bits(pc->regmap, PWM_FAN_CON0,
> +					  PWM_FAN_EN_EN);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->period =3D pc->period; /* fixed period */
> +
> +	regmap_read(pc->regmap, PWM_FAN_CON0, &val);
> +	duty =3D FIELD_GET(PWM_FAN_DC_MSK, val);
> +	state->duty_cycle =3D duty * pc->period >> DC_BITS;

If PWM_FAN_DC =3D 255 means 100% the calculation is wrong. You said in the
v2 thread: 0 =3D disabled (0%) and 255 =3D 100%, so we need here:

	state->duty_cycle =3D DIV_ROUND_UP(duty * pc->period, 255);

=2E

> +	state->duty_cycle =3D roundup_pow_of_two(state->duty_cycle);
> +}
> +[..]
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
> +	pc->rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pc->rst)) {
> +		ret =3D PTR_ERR(pc->rst);
> +		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);

Please skip the error messages if ret =3D -EPROBE_DEFER.

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

		reset_control_assert(pc->rst);

> +		return ret;
> +	}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n26qah5gp5lkcukr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl758A8ACgkQwfwUeK3K
7AnqEggAjJLu0WEx9cLQA/AAXoCU/NXSqQp4/cTxoMFIItSMaEuOy1xv1x08l3wn
2ymeLd67E/eMTSjSJ8/mLyX0nqD9OmPstj0Wu4xV2qPPuAb2dqPajIgCDD7vWVZe
Qt6nERM2fh16NOiDm3W/EzWR9UcvXvQUu9Vsz2EPT1iZ3UmTyJgzDQJJcMZ1FreV
Q/4d3Iag8X7/mKL6Z2ncGT968f2K/2Fq7s2vegRy1fT5UlHxzMqq5rGNSaG5gmdH
+8B8NB3/J4v36iJTXIWs8n9w+hy/p5zEzQdZnwBecevklcyeDZVQawABPJRbZ0s2
4Lya5lOXtsQSWMuR4nJly7sopgrvFA==
=NBCi
-----END PGP SIGNATURE-----

--n26qah5gp5lkcukr--
