Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2248030DE00
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Feb 2021 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhBCPWt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Feb 2021 10:22:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhBCPO7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Feb 2021 10:14:59 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7Jp3-0002k9-GM; Wed, 03 Feb 2021 16:12:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7Jp2-0007eB-IG; Wed, 03 Feb 2021 16:12:00 +0100
Date:   Wed, 3 Feb 2021 16:12:00 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <20210203151200.fdzzq23teoypbxad@pengutronix.de>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xc7r6qniku525sjf"
Content-Disposition: inline
In-Reply-To: <20210203125317.1975-1-fengzheng923@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xc7r6qniku525sjf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ban,

On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> v1->v2:

FTR: v1 wasn't sent to any list, so don't try to find it in some
archive.

> diff --git a/drivers/pwm/pwm-sun50i.c b/drivers/pwm/pwm-sun50i.c
> new file mode 100644
> index 000000000000..37285d771924
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Allwinner sun50i Pulse Width Modulation Controller
> + *
> + * Copyright (C) 2020 Ban Tao <fengzheng923@gmail.com>
> + */

Please add a section here about how this PWM behaves. Things to cover:

 - Mention if the hardware cannot do 0% or 100%
 - Describe if changing the settings is racy, e.g. if it can happen when
   switching from duty_cycle=3D100 + period=3D1000 to duty_cycle=3D200 +
   period=3D2000 that we see a period with duty_cycle=3D100 and period=3D20=
00
   or similar
 - Tell if on a reconfiguration the currently running period is
   completed.

Please stick to the format used in other drivers to simplify grepping,
see the Limitations section in drivers/pwm/pwm-sl28cpld.c for an
example.

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
> +#define PWM_CLK_APB_SCR			BIT(7)
> +#define PWM_DIV_M			0
> +#define PWM_DIV_M_WIDTH			0x4
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
> +#define PWM_PRESCAL_K_WIDTH		0x8
> +
> +#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
> +#define PWM_ENTIRE_CYCLE		16
> +#define PWM_ENTIRE_CYCLE_WIDTH		0x10
> +#define PWM_ACT_CYCLE			0
> +#define PWM_ACT_CYCLE_WIDTH		0x10

Please use a driver specific prefix for these defines.

> +
> +#define BIT_CH(bit, chan)		((bit) << (chan))
> +
> +#define SETMASK(width, shift)		((width?((-1U) >> (32-width)):0)  << (shi=
ft))
> +#define CLRMASK(width, shift)		(~(SETMASK(width, shift)))
> +#define GET_BITS(shift, width, reg)     \
> +	    (((reg) & SETMASK(width, shift)) >> (shift))
> +#define SET_BITS(shift, width, reg, val) \
> +	    (((reg) & CLRMASK(width, shift)) | (val << (shift)))

You're reinventing the stuff from <linux/bitfield.h> here. Please don't.

> +
> +#define PWM_OSC_CLK			24000000
> +#define PWM_PRESCALER_MAX		256
> +#define PWM_CLK_DIV_M__MAX		9
> +#define PWM_ENTIRE_CYCLE_MAX		65536
> +
> +struct sun50i_pwm_data {
> +	unsigned int npwm;
> +};
> +
> +struct sun50i_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst_clk;
> +	void __iomem *base;
> +	const struct sun50i_pwm_data *data;
> +};
> +
> +static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct pwm_ch=
ip *chip)
> +{
> +	return container_of(chip, struct sun50i_pwm_chip, chip);
> +}
> +
> +static inline u32 sun50i_pwm_readl(struct sun50i_pwm_chip *chip,
> +				  unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun50i_pwm_writel(struct sun50i_pwm_chip *chip,
> +				    u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun50i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	u32 temp;
> +
> +	temp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
> +
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		temp |=3D PWM_ACT_STA;
> +	else
> +		temp &=3D ~PWM_ACT_STA;
> +
> +	sun50i_pwm_writel(sun50i_pwm, temp, PWM_CTL_REG(pwm->hwpwm));
> +
> +	return 0;
> +}

For v1 I asked to test this driver with PWM_DEBUG enabled and to fix all
emitted warnings. This didn't happen :-\

> +static int sun50i_pwm_config(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +		int duty_ns, int period_ns)

Please align to the opening brace in the line above.

> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	unsigned long long c;
> +	unsigned long entire_cycles, active_cycles;
> +	unsigned int div_m, prescaler;
> +	u32 tmp;
> +
> +	if (period_ns > 334) {
> +		/* if freq < 3M, then select 24M clock */
> +		c =3D PWM_OSC_CLK;
> +		tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +		tmp &=3D ~PWM_CLK_APB_SCR;
> +		sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	} else {
> +		/* if freq > 3M, then select APB as clock */
> +		c =3D clk_get_rate(sun50i_pwm->clk);
> +		tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +		tmp |=3D PWM_CLK_APB_SCR;
> +		sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	}
> +
> +	dev_dbg(chip->dev, "duty_ns=3D%d period_ns=3D%d c =3D%llu.\n",
> +			duty_ns, period_ns, c);

Inconsistent spacing in the message.

> +
> +	/*
> +	 * (clk / div_m / prescaler) / entire_cycles =3D NSEC_PER_SEC / period_=
ns.
> +	 * So, entire_cycles =3D clk * period_ns / NSEC_PER_SEC / div_m / presc=
aler.
> +	 */
> +	c =3D c * period_ns;
> +	do_div(c, NSEC_PER_SEC);
> +	for (div_m =3D 0; div_m < PWM_CLK_DIV_M__MAX; div_m++) {
> +		for (prescaler =3D 0; prescaler < PWM_PRESCALER_MAX; prescaler++) {

The calculation could be done without this double-for loop. Something
like:

	div_m =3D order_base_2(PWM_ENTIRE_CYCLE_MAX * PWM_PRESCALER_MAX / c);
	if (div_m >=3D PWM_CLK_DIV_M__MAX)
		bail out;

	prescaler =3D DIV_ROUND_UP(c << div_m, PWM_ENTIRE_CYCLE_MAX) - 1;

(but please double check, I didn't.) Also note that this doesn't yield
the best approximation for period in general. (But that's ok for now,
maybe just mention it in a comment.)

> +			/*
> +			 * actual prescaler =3D prescaler + 1.
> +			 * actual div_m =3D 0x1 << div_m.
> +			*/
> +			entire_cycles =3D ((unsigned long)c/(0x1 << div_m))/(prescaler + 1);

c / (1 << div_m) can be written as c >> div_m which reads better and
might result in better code.

> +			if (entire_cycles <=3D PWM_ENTIRE_CYCLE_MAX) {
> +				goto calc_end;
> +			}

No { } for one line bodys please.

> +		}
> +	}

Missing error handling for the case that

	c >> (PWM_CLK_DIV_M__MAX - 1) / PWM_PRESCALER_MAX > PWM_ENTIRE_CYCLE_MAX

> +
> +calc_end:
> +	/*
> +	 * duty_ns / period_ns =3D active_cycles / entire_cycles.
> +	 * So, active_cycles =3D entire_cycles * duty_ns / period_ns.

active_cyles is the number of clock steps for duty_cycle, right?

> +	 */
> +	c =3D (unsigned long long)entire_cycles * duty_ns;
> +	do_div(c, period_ns);
> +	active_cycles =3D c;
> +	if (entire_cycles =3D=3D 0)
> +		entire_cycles++;
> +
> +	/* enable clk gating */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> +	tmp |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> +
> +	/* config  clk div_m*/
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	tmp =3D SET_BITS(PWM_DIV_M, PWM_DIV_M_WIDTH, tmp, div_m);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +
> +	/* config prescal */

prescale

> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
> +	tmp =3D SET_BITS(PWM_PRESCAL_K, PWM_PRESCAL_K_WIDTH, tmp, prescaler);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CTL_REG(pwm->hwpwm));
> +
> +	/* config active and period cycles */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_PERIOD_REG(pwm->hwpwm));
> +	tmp =3D SET_BITS(PWM_ACT_CYCLE, PWM_ACT_CYCLE_WIDTH, tmp, active_cycles=
);
> +	tmp =3D SET_BITS(PWM_ENTIRE_CYCLE, PWM_ENTIRE_CYCLE_WIDTH, tmp, (entire=
_cycles - 1));
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_PERIOD_REG(pwm->hwpwm));
> +
> +	dev_dbg(chip->dev, "active_cycles=3D%lu entire_cycles=3D%lu prescaler=
=3D%u div_m=3D%u\n",
> +			active_cycles, entire_cycles, prescaler, div_m);

align to opening brace.

> +
> +	return 0;
> +}
> +
> +static int sun50i_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	u32 tmp;
> +
> +	/* enable pwm controller */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
> +	tmp |=3D BIT_CH(PWM_EN, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
> +
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> +	tmp |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> +
> +	return 0;
> +}
> +
> +static void sun50i_pwm_disable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	u32 tmp;
> +
> +	/* disable pwm controller */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
> +	tmp &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
> +
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> +	tmp &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> +}
> +
> +static const struct pwm_ops sun50i_pwm_ops =3D {
> +	.config =3D sun50i_pwm_config,
> +	.enable =3D sun50i_pwm_enable,
> +	.disable =3D sun50i_pwm_disable,
> +	.set_polarity =3D sun50i_pwm_set_polarity,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {
> +	.npwm =3D 9,
> +};
> +
> +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D {
> +	.npwm =3D 16,
> +};
> +
> +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
> +	{
> +		.compatible =3D "allwinner,sun8i-v833-pwm",
> +		.data =3D &sun8i_pwm_data_c9,
> +	}, {
> +		.compatible =3D "allwinner,sun8i-v536-pwm",
> +		.data =3D &sun8i_pwm_data_c9,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-r818-pwm",
> +		.data =3D &sun50i_pwm_data_c16,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-a133-pwm",
> +		.data =3D &sun50i_pwm_data_c16,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-r329-pwm",
> +		.data =3D &sun8i_pwm_data_c9,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);
> +
> +static int sun50i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sun50i_pwm_chip *pwm;

"pwm" isn't a good name, in PWM code this name is usually used for
struct pwm_device pointers (and sometimes the global pwm id). I usually
use "ddata" for driver data (and would have called "sun50i_pwm_chip"
"sun50i_pwm_ddata" instead). Another common name is "priv".

> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->data =3D of_device_get_match_data(&pdev->dev);
> +	if (!pwm->data)

Error message here

> +		return -ENODEV;
> +
> +	pwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->base),
> +				     "can't remap pwm resource\n");
> +
> +	pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk),
> +				     "get unnamed clock failed\n");

s/unnamed/PWM/ ?

> +
> +	pwm->rst_clk =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->rst_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->rst_clk),
> +				     "get reset failed\n");
> +
> +	/* Deassert reset */
> +	ret =3D reset_control_deassert(pwm->rst_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;

Even though reset_control_deassert probably will never return
-EPROBE_DEFER, you should use dev_err_probe here to for consistency.

> +	}
> +
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot prepare and enable clk %pe\n",
> +			ERR_PTR(ret));
> +		goto err_clk;
> +	}
> +
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.ops =3D &sun50i_pwm_ops;
> +	pwm->chip.npwm =3D pwm->data->npwm;
> +	pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	pwm->chip.base =3D -1;
> +	pwm->chip.of_pwm_n_cells =3D 3;
> +
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xc7r6qniku525sjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAavTwACgkQwfwUeK3K
7AnEXAf8C5s1LEz9zY50LpmcldnQFDt79E/nxex4Tf/QWrvYSqXmFyv/OhI6NLSB
Rx8xRknBdjsslmiXEwuUsDwL/cfqcSNqn0jvhdXlRZyiZIJCNOdZvtxTPFoBejcl
32uINxIVUC6RZXO3tWgBg7OH3k420aBOTGXlqnIiQqirDCizcoBE6u6oDiGFbD03
vCJpoXgvG9BZ3Zb0EwoQjj0EJHOmAaq9Tiukyj05yFTPSr0SIA94VPChrQhcUyRe
GXqGaoI8x0l29ICfQrafLT5P4H9bVoMzaNesVbD4V5o94krDD15GWSjNTrbKUtLj
iyC6j1zuG2LaQnTzdXMi7ccLbUsrJw==
=ODJI
-----END PGP SIGNATURE-----

--xc7r6qniku525sjf--
