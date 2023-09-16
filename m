Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603C47A311F
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Sep 2023 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbjIPPdI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Sep 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjIPPdC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 16 Sep 2023 11:33:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9CCE7
        for <linux-pwm@vger.kernel.org>; Sat, 16 Sep 2023 08:32:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhXHu-0006Gw-VF; Sat, 16 Sep 2023 17:32:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhXHs-006n9L-Oa; Sat, 16 Sep 2023 17:32:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhXHs-0027SJ-F1; Sat, 16 Sep 2023 17:32:48 +0200
Date:   Sat, 16 Sep 2023 17:32:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
 <20230630114003.320641-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="atv4v5raas3cs2c3"
Content-Disposition: inline
In-Reply-To: <20230630114003.320641-3-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--atv4v5raas3cs2c3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

sorry this took so long.

On Fri, Jun 30, 2023 at 12:40:01PM +0100, Biju Das wrote:
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
> v4->v5:
>  * Sorted KConfig file
>  * Sorted Make file
>  * Updated copyright header 2022->2023.
>  * Updated limitation section.
>  * Replaced the variable chip->rzv2m_pwm in rzv2m_pwm_wait_delay()
>  * Replaced polarity logic as per HW manual dutycycle =3D Ton/Ton+Toff, so
>    eventhough native polarity is inverted from period point of view it is
>    correct.
>  * Added logic for supporting 0% , 100% and remaining duty cycle.
>  * On config() replaced pm_runtime_resume_and_get()->pm_runtime_get_sync()
>  * Counter is stopped while updating period/polarity to avoid glitches.
>  * Added error check for clk_prepare_enable()
>  * Introduced is_ch_enabled variable to cache channel enable status.
>  * clk_get_rate is called after enabling the clock and clk_rate_exclusive=
_get()
>  * Added comment for delay
>  * Replaced 1000000000UL->NSEC_PER_SEC.
>  * Improved error handling in probe().
> v3->v4:
>  * Documented the hardware properties in "Limitations" section
>  * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
>  * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
>  * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i) for
>    calculating divider as it is power of 16.
>  * Reordered the functions to have rzv2m_pwm_config() directly before
>    rzv2m_pwm_apply().
>  * Improved the logic for calculating period and duty cycle in config()
>  * Merged multiple RZV2M_PWMCTR register writes to a single write in conf=
ig()
>  * replaced pwm_is_enabled()->pwm->state.enabled
>  * Avoided assigning bit value as enum pwm_polarity instead used enum con=
stant.
>  * Fixed various issues in probe error path.
>  * Updated the logic for PWM cycle setting register
>  * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So restricting
>    PWMCYC values < 0xffffff =20
>  * The native polarity of the hardware is inverted (i.e. it starts with t=
he
>  * low part). So switched the inversion bit handling.
> v2->v3:
>  * Added return code for rzv2m_pwm_get_state()
>  * Added comment in rzv2m_pwm_reset_assert_pm_disable()
> v1->v2:
>  * Replaced devm_reset_control_get_optional_shared->devm_reset_control_ge=
t_shared
> ---
>  drivers/pwm/Kconfig     |  11 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-rzv2m.c | 451 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 463 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzv2m.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6210babb0741..1c8dbb064ee5 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -514,6 +514,17 @@ config PWM_RZ_MTU3
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rz-mtu3.
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
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c822389c2a24..ee190df16279 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> +obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rzv2m.c b/drivers/pwm/pwm-rzv2m.c
> new file mode 100644
> index 000000000000..0c5c0b9f0e70
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzv2m.c
> @@ -0,0 +1,451 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/V2M PWM Timer (PWM) driver
> + *
> + * Copyright (C) 2023 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + * https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardwar=
e?language=3Den
> + *
> + * Limitations:
> + * - Changes to the duty cycle configuration get effective only after th=
e next
> + *   period end.
> +=A0* - The duty cycle can be changed only by modifying the PWMLOW regist=
er
> +=A0* =A0 value and changing the pulse width at low level. The duty cycle=
 becomes
> +=A0* =A0 0% for the low width when the value of the PWMLOW register is 0=
x0h
> +=A0* =A0 and 100% for the low width when the value of the PWMLOW > PWMCY=
C.
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
> +#define RZV2M_PWMCYC_PERIOD	GENMASK(23, 0)
> +
> +struct rzv2m_pwm_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *apb_clk;
> +	struct clk *pwm_clk;
> +	unsigned long rate;
> +	unsigned long delay;
> +	unsigned long pwm_cyc;
> +	enum pwm_polarity polarity;
> +	bool is_ch_enabled;
> +};
> +
> +static inline struct rzv2m_pwm_chip *to_rzv2m_pwm_chip(struct pwm_chip *=
chip)
> +{
> +	return container_of(chip, struct rzv2m_pwm_chip, chip);
> +}
> +
> +static void rzv2m_pwm_wait_delay(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	/* delay timer when change the setting register */
> +	ndelay(rzv2m_pwm->delay);
> +}
> +
> +static void rzv2m_pwm_write(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg, u=
32 data)
> +{
> +	writel(data, rzv2m_pwm->mmio + reg);
> +}
> +
> +static u32 rzv2m_pwm_read(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg)
> +{
> +	return readl(rzv2m_pwm->mmio + reg);
> +}
> +
> +static void rzv2m_pwm_modify(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg, =
u32 clr,
> +			     u32 set)
> +{
> +	rzv2m_pwm_write(rzv2m_pwm, reg,
> +			(rzv2m_pwm_read(rzv2m_pwm, reg) & ~clr) | set);
> +}
> +
> +static u8 rzv2m_pwm_calculate_prescale(struct rzv2m_pwm_chip *rzv2m_pwm,
> +				       u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 24;
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 3;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 3) / 4;
> +
> +	return prescale;
> +}
> +
> +static int rzv2m_pwm_enable(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> +			 RZV2M_PWMCTR_PWME);
> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +	rzv2m_pwm->is_ch_enabled =3D true;
> +
> +	return 0;
> +}
> +
> +static void rzv2m_pwm_disable(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +	pm_runtime_put_sync(rzv2m_pwm->chip.dev);
> +	rzv2m_pwm->is_ch_enabled =3D false;
> +}
> +
> +static int rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	u32 period, low, val;
> +	u8 prescale;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
> +	state->enabled =3D FIELD_GET(RZV2M_PWMCTR_PWME, val);
> +	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, val) ?
> +		PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	prescale =3D FIELD_GET(RZV2M_PWMCTR_PWMPS, val);
> +	period =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> +	low =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> +	if (low > period) /* 0% duty cycle */
> +		val =3D 0;
> +	else if (!low) /* 100% duty cycle */
> +		val =3D period;
> +	else
> +		val =3D period - low;

This could be simplified to:

	if (low > period) /* 0% duty cycle */
		val =3D 0;
	else
		val =3D period - low;

Maybe it makes sense add another variable "duty_cycle" here and use that
for improved clarity? And then maybe rename "val" to "ctr"?

> +	if (period)
> +		period +=3D 1;

This looks bogus, why don't you add 1 if RZV2M_PWMCYC is 0?

Also it suggests that the hardware cannot do a 100% relative duty cycle?
If I didn't miss anything here, please add that to the list of
Limitations above.

> +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)period << (4 * p=
rescale),
> +					 rzv2m_pwm->rate);

The multiplication can overflow. I see no easy way to prevent this
without introducing a mul_u64_u64_div_roundup helper. Maybe I miss
something?

> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val << (4 * =
prescale),
> +					     rzv2m_pwm->rate);
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rzv2m_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	unsigned long pwm_cyc, pwm_low;
> +	u8 prescale;
> +	u32 pwm_ctr;
> +	u64 pc, dc;
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
> +	 * PWM cycle =3D (PWM period(ns) / (PWM_CLK period(ns) =D7 Div ratio)) =
- 1
> +	 */
> +	pc =3D mul_u64_u32_div(state->period, rzv2m_pwm->rate, NSEC_PER_SEC);

rzv2m_pwm->rate is an unsigned long. So mul_u64_u32_div is the wrong
function (at least on archs where sizeof(long) > 4).

> +	dc =3D mul_u64_u32_div(state->duty_cycle, rzv2m_pwm->rate, NSEC_PER_SEC=
);
> +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pc);
> +
> +	pwm_cyc =3D pc >> (4 * prescale);

The division above might have round down the result, so you're losing
precision here?

> +	if (pwm_cyc)
> +		pwm_cyc -=3D 1;

If the requested period is too small, please refuse the request.
PWM_DEBUG should catch that and emit a warning.

> +	if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc))
> +		pwm_cyc =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);
> +
> +	/*
> +	 * Formula for calculating PWMLOW register
> +	 * PWMLOW register =3D PWM cycle * Low pulse width ratio (%)
> +	 */
> +	pwm_low =3D dc >> (4 * prescale);
> +	if (!dc) /* 0% duty cycle */
> +		pwm_low =3D pwm_cyc + 1;

if pwm_cyc =3D=3D FIELD_MAX(RZV2M_PWMCYC_PERIOD) that + 1 isn't a good idea,
is it?

> +	else if (pc =3D=3D dc) /* 100% duty cycle */
> +		pwm_low =3D 0;
> +	else
> +		pwm_low =3D pwm_cyc - pwm_low;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(rzv2m_pwm->chip.dev);

Can it happen that this already makes the hardware emit a (probably
wrong) signal?

> +	/*
> +	 * To change the setting value of the PWM cycle setting register
> +	 * (PWMm_PWMCYC) or polarity, set the PWME bit of the PWM control
> +	 * register (PWMm_PWMCTR) to 0b and stop the counter operation.
> +	 */
> +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=3D=
 pwm_cyc) {
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> +		rzv2m_pwm_wait_delay(rzv2m_pwm);
> +	}
> +
> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
> +
> +	pwm_ctr =3D FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale);
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pwm_ctr |=3D RZV2M_PWMCTR_PWMHL;
> +
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM |
> +			 RZV2M_PWMCTR_PWMPS | RZV2M_PWMCTR_PWMHL, pwm_ctr);
> +
> +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=3D=
 pwm_cyc) {
> +		rzv2m_pwm->polarity =3D state->polarity;
> +		rzv2m_pwm->pwm_cyc =3D pwm_cyc;
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> +				 RZV2M_PWMCTR_PWME);
> +	}
> +
> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(rzv2m_pwm->chip.dev);
> +
> +	return 0;
> +}
> +
> +static int rzv2m_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			rzv2m_pwm_disable(rzv2m_pwm);
> +
> +		return 0;
> +	}
> +
> +	ret =3D rzv2m_pwm_config(chip, pwm, state);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rzv2m_pwm_enable(rzv2m_pwm);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rzv2m_pwm_ops =3D {
> +	.get_state =3D rzv2m_pwm_get_state,
> +	.apply =3D rzv2m_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int rzv2m_pwm_pm_runtime_suspend(struct device *dev)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
> +	clk_disable_unprepare(rzv2m_pwm->apb_clk);
> +
> +	return 0;
> +}
> +
> +static int rzv2m_pwm_pm_runtime_resume(struct device *dev)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	err =3D clk_prepare_enable(rzv2m_pwm->apb_clk);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_prepare_enable(rzv2m_pwm->pwm_clk);
> +	if (err)
> +		return err;

It would be consequent here to disable apb_clk in the error case to
prevent a clk enable imbalance.

> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--atv4v5raas3cs2c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUFyp8ACgkQj4D7WH0S
/k5l/Qf7BDkHonnmONhn6c2WijpGM/8Aqjg4w6gv3t0/dIgj/7bncWAQJdkHSZBA
6zVbC7aU7Shy+ZkGZMh66DIiUaCsV/WYqZ8dt9VxedD+ube0UgO2iT8UlV+14dIE
KGHpSpkkinJouKgZv2/vSdFy+iixUoaspH6dMPmSQYAwpuOiMyj1JIxtfZroJLVH
vdnsA11TQ+YQ81JKsRg4Bi22xujrZdnpz59gJVAxlCQ6Y9N9gZI3Mw0b2EQVw9oc
T8KKboZ6yyQLrV/154pyhQ9NLwJ+M+sVe8dYmQh+sNrJn+M1Lb1iQMMZuwcvJg0z
aYdNz0QwXue3V5vtx9id2JjBpga43w==
=usS9
-----END PGP SIGNATURE-----

--atv4v5raas3cs2c3--
