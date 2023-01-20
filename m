Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75E675142
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jan 2023 10:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjATJfH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Jan 2023 04:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjATJfH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2023 04:35:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B608C928
        for <linux-pwm@vger.kernel.org>; Fri, 20 Jan 2023 01:34:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pInn6-0005f8-Lb; Fri, 20 Jan 2023 10:34:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pInn5-007LDA-44; Fri, 20 Jan 2023 10:34:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pInn4-00EMHp-I4; Fri, 20 Jan 2023 10:34:30 +0100
Date:   Fri, 20 Jan 2023 10:34:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <20230120093430.qddre6bxojlcrtkz@pengutronix.de>
References: <20221213185827.2012004-1-biju.das.jz@bp.renesas.com>
 <20221213185827.2012004-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5fyloi27vy2r7rlp"
Content-Disposition: inline
In-Reply-To: <20221213185827.2012004-3-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5fyloi27vy2r7rlp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

now I come around to review your driver. Sorry that it took so long, I
was busy with other stuff.

On Tue, Dec 13, 2022 at 06:58:25PM +0000, Biju Das wrote:
> The RZ/V2{M, MA} PWM Timer supports the following functions:
>=20
>  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
>  * The frequency division ratio for internal counter operation is
>    selectable as PWM_CLK divided by 1, 16, 256, or 2048.
>  * The period as well as the duty cycle is adjustable.
>  * The low-level and high-level order of the PWM signals can be
>    inverted.
>  * The duty cycle of the PWM signal is selectable in the range from
>    0 to 100%.
>  * The minimum resolution is 20.83 ns.
>  * Three interrupt sources: Rising and falling edges of the PWM signal
>    and clearing of the counter
>  * Counter operation and the bus interface are asynchronous and both
>    can operate independently of the magnitude relationship of the
>    respective clock periods.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Added return code for rzv2m_pwm_get_state()
>  * Added comment in rzv2m_pwm_reset_assert_pm_disable()
> v1->v2:
>  * Replaced devm_reset_control_get_optional_shared->devm_reset_control_ge=
t_shared
> ---
>  drivers/pwm/Kconfig     |  11 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-rzv2m.c | 398 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 410 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzv2m.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a2..31cdc9dae3c5 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -473,6 +473,17 @@ config PWM_RENESAS_TPU
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-renesas-tpu.
> =20
> +config PWM_RZV2M
> +       tristate "Renesas RZ/V2M PWM support"
> +       depends on ARCH_R9A09G011 || COMPILE_TEST
> +       depends on HAS_IOMEM
> +       help
> +         This driver exposes the PWM controller found in Renesas
> +         RZ/V2M like chips through the PWM API.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-rzv2m.
> +
>  config PWM_ROCKCHIP
>  	tristate "Rockchip PWM support"
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..a95aabae9115 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
>  obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> +obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> diff --git a/drivers/pwm/pwm-rzv2m.c b/drivers/pwm/pwm-rzv2m.c
> new file mode 100644
> index 000000000000..80fb3523026d
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzv2m.c
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/V2M PWM Timer (PWM) driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + * https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardwar=
e?language=3Den
> + *
Please document the hardware properties here in a "Limitations"
paragraph similar to e.g. pwm-sl28cpld.c. The idea is to get the
information about how the hardware behaves on .apply (are there
glitches? Can a mixed period happen that has the previous period but the
new duty_cycle? Or maybe duty_cycle and period are shadowed until the
currently running period ends, but polarity takes effect immediately?
etc. pp) when doing

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/pwm-rzv2m.c

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +
> +#define U24_MASK	GENMASK(23, 0)
> +#define U24_MAX		(U24_MASK)
> +
> +#define RZV2M_PWMCTR	0x0
> +#define RZV2M_PWMCYC	0x4
> +#define RZV2M_PWMLOW	0x8
> +#define RZV2M_PWMCNT	0xc
> +
> +#define RZV2M_PWMCTR_PWMPS	GENMASK(17, 16)
> +#define RZV2M_PWMCTR_PWMHL	BIT(3)
> +#define RZV2M_PWMCTR_PWMTM	BIT(2)
> +#define RZV2M_PWMCTR_PWME	BIT(1)
> +
> +#define F2CYCLE_NSEC(f)		(1000000000 / (f))

Driver prefix please.

> +
> +struct rzv2m_pwm_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *apb_clk;
> +	struct clk *pwm_clk;
> +	unsigned long rate;
> +	unsigned long delay;
> +};
> +
> +static const int rzv2m_pwm_freq_div[] =3D { 1, 16, 256, 2048 };

These are powers of 16, so you can use

	1 << (4 * i)

instead of rzv2m_pwm_freq_div[i]. This might make it easier for the
compiler to optimize.

> [...]
> +static int rzv2m_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	unsigned long pwm_cyc, pwm_low;
> +	u8 prescale;
> +	u64 pc, dc;
> +	int err;
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> +	 * calculation.
> +	 */
> +	if (rzv2m_pwm->rate > NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	/*
> +	 * Formula for calculating PWM Cycle Setting Register
> +	 * PWM cycle =3D (PWM period(ns) / (PWM_CLK period(ns) =C3=97 Div ratio=
)) - 1
> +	 */
> +
> +	pc =3D mul_u64_u32_div(state->period, rzv2m_pwm->rate, NSEC_PER_SEC);
> +	dc =3D mul_u64_u32_div(state->duty_cycle, rzv2m_pwm->rate, NSEC_PER_SEC=
);
> +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pc);
> +
> +	pwm_cyc =3D pc / rzv2m_pwm_freq_div[prescale];

That's a 64 bit division, that's not allowed. (I guess the compiler
optimizes that, otherwise I would have expected a build bot to point out
that problem.)

> +	if (pc / rzv2m_pwm_freq_div[prescale] <=3D U24_MAX)
> +		pwm_cyc =3D pwm_cyc ? (pwm_cyc - 1) : 0;
> +	else
> +		pwm_cyc =3D U24_MAX;

I'd do that part as follows:

#define RZV2M_PWMCYC_PERIOD GENMASK(23, 0)

pwm_cyc =3D pc >> (4 * prescale);
if (pwm_cyc)
	pwm_cyc -=3D 1;

if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc))
	pwm_cyc =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);

(Ideally the hardware manual specifies a name for the bitfield. Then of
course pick that one instead of PERIOD.)

> +	pwm_low =3D dc / rzv2m_pwm_freq_div[prescale];
> +	if (pwm_low <=3D U24_MAX)
> +		pwm_low =3D pwm_low ? (pwm_low - 1) : 0;
> +	else
> +		pwm_low =3D U24_MAX;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm_is_enabled(pwm)) {
> +		err =3D pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM, 0);
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMPS,
> +			 FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale));

Is there a need to do this in two register writes? If yes, please add
this information in a comment, if not, please do it in one access.

> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMHL, 0);
> +	else
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMHL,
> +				 RZV2M_PWMCTR_PWMHL);

This can be merged into the above write to RZV2M_PWMCTR, too?!

> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +
> +	/*
> +	 * If the PWM is not enabled, turn the clock off again to save power.
> +	 */
> +	if (!pwm_is_enabled(pwm))
> +		pm_runtime_put(rzv2m_pwm->chip.dev);

This is wrong for two reasons: First, you should not use pwm consumer
functions in a low level driver and second, this gives information about
the old state, I think you want:

	if (!state->enabled)
		pm_runtime_put(rzv2m_pwm->chip.dev);

Thinking again: rzv2m_pwm_config() is only ever called when
state->enabled is true, to this can be further simplified.

(And for the check above you want:

	if (!pwm->state.enabled) {
		err =3D pm_runtime_resume_and_get(...)
		...
	}
)

> +	return 0;
> +}
> +
> +static int rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	u8 prescale;
> +	u64 tmp;
> +	u32 val;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
> +	state->enabled =3D FIELD_GET(RZV2M_PWMCTR_PWME, val);
> +	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, val);

Please don't use a bit value as enum pwm_polarity.

Something like

	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, val) ?  PWM_POLARITY_INV=
ERSED : PWM_POLARITY_NORMAL;

should be identical for the compiler, but doesn't implicitly hardcode
the value of the PWM_POLARITY_* constants.

> +	prescale =3D FIELD_GET(RZV2M_PWMCTR_PWMPS, val);
> +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> +	val =3D val ? val + 1 : 0;

oh, how unusual. Are you sure here?

> +	tmp =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val, rzv2m_pwm->rate);
> +	state->period =3D tmp * rzv2m_pwm_freq_div[prescale];

rate is usually 48 MHz, right? Assuming val =3D 1 and prescale =3D 3 the
actual period value is

	1000000000 * 1 * 2048 / (48 MHz) =E2=89=85 42666.6667

however your calculation yields 43008 in that case. Can you please try
to make this 42667 instead? The needed calculation is:

	divroundup(NSEC_PER_SEC * (u64)val * rzv2m_pwm_freq_div[prescale], rzv2m_p=
wm->rate);

To prevent an overflow, we might need an uprounding variant of mul_u64_u64_=
div_u64().

(Mental note for myself: Update PWM_DEBUG to catch that problem.)

> +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> +	val =3D val ? val + 1 : 0;
> +	tmp =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val, rzv2m_pwm->rate);
> +	state->duty_cycle =3D tmp * rzv2m_pwm_freq_div[prescale];
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}

I'd reorder the functions to have rzv2m_pwm_config() directly before
rzv2m_pwm_apply().

> +static int rzv2m_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> [...]
> +static int rzv2m_pwm_probe(struct platform_device *pdev)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm;
> +	unsigned long apb_clk_rate;
> +	int ret;
> +
> +	rzv2m_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2m_pwm), GFP_KERNEL);
> +	if (!rzv2m_pwm)
> +		return -ENOMEM;
> +
> +	rzv2m_pwm->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzv2m_pwm->mmio))
> +		return PTR_ERR(rzv2m_pwm->mmio);
> +
> +	rzv2m_pwm->apb_clk =3D devm_clk_get(&pdev->dev, "apb");
> +	if (IS_ERR(rzv2m_pwm->apb_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->apb_clk),
> +				     "cannot get apb clock\n");
> +
> +	apb_clk_rate =3D clk_get_rate(rzv2m_pwm->apb_clk);
> +	if (!apb_clk_rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "apb clk rate is 0");
> +
> +	rzv2m_pwm->pwm_clk =3D devm_clk_get(&pdev->dev, "pwm");
> +	if (IS_ERR(rzv2m_pwm->pwm_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->pwm_clk),
> +				     "cannot get pwm clock\n");
> +
> +	rzv2m_pwm->rate =3D clk_get_rate(rzv2m_pwm->pwm_clk);
> +	if (!rzv2m_pwm->rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clk rate is 0");
> +
> +	/* delay =3D 6 * PCLK + 9 * PWM_CLK */
> +	rzv2m_pwm->delay =3D F2CYCLE_NSEC(apb_clk_rate) * 6 +
> +		F2CYCLE_NSEC(rzv2m_pwm->rate) * 9;

F2CYCLE_NSEC contains a division, so you're loosing precision here. Also
as this is a minimal delay, you might want to use up-rounding division.

> +	rzv2m_pwm->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(rzv2m_pwm->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->rstc),
> +				     "get reset failed\n");
> +
> +	platform_set_drvdata(pdev, rzv2m_pwm);
> +	clk_prepare_enable(rzv2m_pwm->apb_clk);
> +	clk_prepare_enable(rzv2m_pwm->pwm_clk);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D reset_control_deassert(rzv2m_pwm->rstc);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "cannot deassert reset control\n");
> +		goto clk_disable;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzv2m_pwm_reset_assert_pm_disable,
> +				       rzv2m_pwm);
> +	if (ret < 0)
> +		goto clk_disable;
> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe().
> +	 */
> +	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
> +		pm_runtime_get_sync(&pdev->dev);
> +
> +	rzv2m_pwm->chip.dev =3D &pdev->dev;
> +	rzv2m_pwm->chip.ops =3D &rzv2m_pwm_ops;
> +	rzv2m_pwm->chip.npwm =3D 1;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rzv2m_pwm->chip);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +		goto clk_disable;

If you fail here, rzv2m_pwm_reset_assert_pm_disable is called which
calls pm_runtime_set_suspended(). I assume that results in
rzv2m_pwm_pm_runtime_suspend() being called and to the clks are already
disabled?

> +	}
> +
> +	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
> +	clk_disable_unprepare(rzv2m_pwm->apb_clk);
> +	return ret;
> +}
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5fyloi27vy2r7rlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPKYB8ACgkQwfwUeK3K
7AkXFQf+IcXjPzFI4W2qYfLoUjOgRpOOlYN4l+fC943Sj5/3NPIBZCZpBjhsuK1P
M4SFVpp5YrLWXO2GuKpbGo4f8CJ8Op6R2d2pQKsSBZgDeYceifNhLfflP2VMsuLZ
i0jhiz0wKfyW4W4+GkyDscoooLnLzMNNQykag1NUAz5Ri2BEuBZeA7+b++GZL8Lu
aRKRNaCJfhCb49tP4bt3Pb8r25m1YMPLk1J+iN98HS1ldhDI9fr7XQpYbB3zZgMu
mrsR4yxCj/BMIC2YyqoC7qSK5F9aGX0qUy496MfO7sv0XEURf/C5neTns+z1qz7H
UJZqRrN/w5w8ZtnTHdM0BqvoNV0FJQ==
=MUn0
-----END PGP SIGNATURE-----

--5fyloi27vy2r7rlp--
