Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B265E6D92B2
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Apr 2023 11:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjDFJa3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Apr 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjDFJa2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2023 05:30:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68081726
        for <linux-pwm@vger.kernel.org>; Thu,  6 Apr 2023 02:30:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkLwi-0007bY-5p; Thu, 06 Apr 2023 11:30:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkLwg-009Lih-GU; Thu, 06 Apr 2023 11:30:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkLwf-00B0E1-H8; Thu, 06 Apr 2023 11:30:17 +0200
Date:   Thu, 6 Apr 2023 11:30:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <20230406093017.dsciryvdbavitien@pengutronix.de>
References: <20230209125656.191905-1-biju.das.jz@bp.renesas.com>
 <20230209125656.191905-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jiz5f6k4g464zos"
Content-Disposition: inline
In-Reply-To: <20230209125656.191905-3-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7jiz5f6k4g464zos
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I finally come around to spend some time on your patch. Sorry it took so
long.

On Thu, Feb 09, 2023 at 12:56:54PM +0000, Biju Das wrote:
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
>  drivers/pwm/pwm-rzv2m.c | 436 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 448 insertions(+)
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

The driver uses readl and writel to access its registers. If that
justifies a dependency on HAS_IOMEM there are quite some drivers (in
drivers/pwm and elsewhere) that are missing this dependency.

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
> index 000000000000..516e875d6285
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzv2m.c
> @@ -0,0 +1,436 @@
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
> + * Limitations:
> + * - If the PWMLOW value is changed during PWM operation, the changed
> +=A0* =A0 value is reflected in the next PWM cycle.

Ideally this section is understandable without knowing the hardware. I
think what you want to say here is that changes to the duty cycle
configuration get effective only after the next period end?!

> +=A0* - The duty cycle can be changed only by modifying the PWMLOW regist=
er
> +=A0* =A0 value and changing the pulse width at low level. The duty cycle=
 becomes
> +=A0* =A0 0% for the low width when the value of the PWMLOW register is 0=
x0h
> +=A0* =A0 and 100% for the low width when the value of the PWMLOW > PWMCY=
C.

pulse width =3D period length?

> +=A0* - To change the setting value of the PWM cycle setting register
> +=A0* =A0 (PWMm_PWMCYC), set the PWME bit of the PWM control register (PW=
Mm_PWMCTR)
> +=A0* =A0 to 0b and stop the counter operation. If it is changed during c=
ounter
> +=A0* =A0 operation, PWM output may not be performed correctly.

This is an implementation detail that isn't important for the general
overview of the driver. The typical question that should be answered in
the Limitations paragraph is: "Is this driver suitable for my use case?"

> +=A0* - The registers other than the PWM interrupt register (PWMINT) are =
always
> +=A0* =A0 synchronized with PWM_CLK at regular intervals. It takes some t=
ime
> +=A0* =A0 (Min: 2 =D7 PCLK + 4 =D7 PWM_CLK to Max: 6 =D7 PCLK + 9 =D7 PWM=
_CLK) for the
> +=A0* =A0 value set in the register to be reflected in the PWM circuit be=
cause
> +=A0* =A0 there is a synchronizer between the register and the PWM circui=
t.

This is a nice information, keep it, but move it out of the Limitations
paragraph.

> + * - The native polarity of the hardware is inverted (i.e. it starts wit=
h the
> + *   low part).

Another implementation detail. The driver supports both, so which is the
native one is of little interest.

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
> +};
> +
> +static inline struct rzv2m_pwm_chip *to_rzv2m_pwm_chip(struct pwm_chip *=
chip)
> +{
> +	return container_of(chip, struct rzv2m_pwm_chip, chip);
> +}
> +
> +static void rzv2m_pwm_wait_delay(struct rzv2m_pwm_chip *chip)

Please pick a different variable name. "chip" is usually used for
variables of type struct pwm_chip. rzv2m_pwm is what you use in other
functions.

> +{
> +	/* delay timer when change the setting register */
> +	ndelay(chip->delay);
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
> +static bool rzv2m_pwm_is_ch_enabled(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	return !!(rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR) & RZV2M_PWMCTR_PWME);
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
> +
> +	return 0;
> +}
> +
> +static void rzv2m_pwm_disable(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +
> +	pm_runtime_put_sync(rzv2m_pwm->chip.dev);
> +}
> +
> +static int rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	u8 prescale;
> +	u32 val;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
> +	state->enabled =3D FIELD_GET(RZV2M_PWMCTR_PWME, val);
> +	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, val) ?
> +		PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> +	prescale =3D FIELD_GET(RZV2M_PWMCTR_PWMPS, val);
> +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> +	if (val)
> +		val +=3D 1;
> +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val << (4 * pres=
cale),
> +					 rzv2m_pwm->rate);
> +
> +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> +	if (val)
> +		val +=3D 1;
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
> +	 * PWM cycle =3D (PWM period(ns) / (PWM_CLK period(ns) =D7 Div ratio)) =
- 1
> +	 */
> +
> +	pc =3D mul_u64_u32_div(state->period, rzv2m_pwm->rate, NSEC_PER_SEC);
> +	dc =3D mul_u64_u32_div(state->duty_cycle, rzv2m_pwm->rate, NSEC_PER_SEC=
);
> +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pc);
> +
> +	pwm_cyc =3D pc >> (4 * prescale);
> +	if (pwm_cyc)
> +		pwm_cyc -=3D 1;
> +
> +	if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc))
> +		pwm_cyc =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);
> +
> +	pwm_low =3D dc >> (4 * prescale);
> +	if (pwm_low)
> +		pwm_low -=3D 1;
> +
> +	if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_low))
> +		pwm_low =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);
> +
> +	/*
> +	 * A 100% duty cycle is only possible with PWMLOW > PWMCYC. if PWMCYC is
> +	 * 0xffffff a 100% duty cycle is not possible.
> +	 */
> +	if (pwm_cyc =3D=3D pwm_low && pwm_cyc =3D=3D FIELD_MAX(RZV2M_PWMCYC_PER=
IOD))
> +		pwm_cyc -=3D 1;

This is a common limitation. The meson driver doesn't use the max value
for the cycle counter for this reason at all. This is more consistent
with the usual expectations of a consumer.

> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled) {
> +		err =3D pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
> +		if (err)
> +			return err;

You can do pm_runtime_resume_and_get unconditionally. I think this would
simplify the code flow a bit.

> +	} else {
> +		/*
> +		 * To change the setting value of the PWM cycle setting register
> +		 * (PWMm_PWMCYC), set the PWME bit of the PWM control register
> +		 * (PWMm_PWMCTR) to 0b and stop the counter operation.
> +		 */
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> +		rzv2m_pwm_wait_delay(rzv2m_pwm);

Would it make sense to only stop the hardware if PWMCYC (or polarity?)
is about to change? This way you wouldn't introduce glitches for the
usual request to only change the duty cycle.

> +	}
> +
> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
> +
> +	pwm_ctr =3D FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale);
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		pwm_ctr |=3D RZV2M_PWMCTR_PWMHL;
> +
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM |
> +			 RZV2M_PWMCTR_PWMPS | RZV2M_PWMCTR_PWMHL, pwm_ctr);
> +
> +	if (pwm->state.enabled)
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> +				 RZV2M_PWMCTR_PWME);

If pwm->state.enabled, RZV2M_PWMCTR_PWME should already be set?

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

How does a disabled PWM behave?

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
> +
> +	clk_prepare_enable(rzv2m_pwm->apb_clk);
> +	clk_prepare_enable(rzv2m_pwm->pwm_clk);

Missing error checking.

> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rzv2m_pwm_pm_ops,
> +				 rzv2m_pwm_pm_runtime_suspend,
> +				 rzv2m_pwm_pm_runtime_resume, NULL);
> +
> +static void rzv2m_pwm_reset_assert_pm_disable(void *data)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D data;
> +
> +	/*
> +	 * The below check is for making balanced PM usage count in probe/remove
> +	 * eg: boot loader is turning on PWM and probe increments the PM usage
> +	 * count. Before apply, if there is unbind/remove callback we need to
> +	 * decrement the PM usage count.
> +	 */
> +	clk_prepare_enable(rzv2m_pwm->apb_clk);
> +	clk_prepare_enable(rzv2m_pwm->pwm_clk);

What happens if enabling fails here? Maybe it would be easier and safer
to cache the info if a channel is enabled in driver data? Then you don't
need to enable the clks just to call rzv2m_pwm_is_ch_enabled().

> +	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
> +		pm_runtime_put(rzv2m_pwm->chip.dev);
> +
> +	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
> +	clk_disable_unprepare(rzv2m_pwm->apb_clk);
> +
> +	pm_runtime_disable(rzv2m_pwm->chip.dev);
> +	pm_runtime_set_suspended(rzv2m_pwm->chip.dev);
> +	reset_control_assert(rzv2m_pwm->rstc);
> +}
> +
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

The value returned by clk_get_rate() isn't reliable for a clk that
wasn't enabled. (See also
https://lore.kernel.org/linux-clk/20230201082309.233348-1-u.kleine-koenig@p=
engutronix.de
=2E)

> +	if (!rzv2m_pwm->rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clk rate is 0");
> +
> +	/* delay =3D 6 * PCLK + 9 * PWM_CLK */

Here would be a nice place for the comment about synchronisation of the
two clks.

> +	rzv2m_pwm->delay =3D DIV_ROUND_UP(6 * 1000000000UL, apb_clk_rate) +
> +		DIV_ROUND_UP(9 * 1000000000UL, rzv2m_pwm->rate);

s/1000000000UL/NSEC_PER_SEC/

On 32 bit archs, 6 * 1000000000 > MAX_ULONG resulting in a too small
delay.

> +	rzv2m_pwm->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(rzv2m_pwm->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->rstc),
> +				     "get reset failed\n");
> +
> +	platform_set_drvdata(pdev, rzv2m_pwm);
> +	clk_prepare_enable(rzv2m_pwm->apb_clk);
> +	clk_prepare_enable(rzv2m_pwm->pwm_clk);

error checking missing.

> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D reset_control_deassert(rzv2m_pwm->rstc);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "cannot deassert reset control\n");
> +		goto pm_clk_disable;
> +	}
> +
> +	rzv2m_pwm->chip.dev =3D &pdev->dev;
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe().
> +	 */
> +	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
> +		pm_runtime_get_sync(&pdev->dev);
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzv2m_pwm_reset_assert_pm_disable,
> +				       rzv2m_pwm);
> +	if (ret < 0)
> +		goto channel_disable;
> +
> +	rzv2m_pwm->chip.ops =3D &rzv2m_pwm_ops;
> +	rzv2m_pwm->chip.npwm =3D 1;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rzv2m_pwm->chip);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +		goto channel_disable;
> +	}
> +
> +	return 0;
> +
> +pm_clk_disable:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +channel_disable:
> +	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> +
> +	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
> +	clk_disable_unprepare(rzv2m_pwm->apb_clk);
> +	return ret;
> +}
> +
> +static const struct of_device_id rzv2m_pwm_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzv2m-pwm", },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzv2m_pwm_of_table);
> +
> +static struct platform_driver rzv2m_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzv2m",
> +		.pm =3D pm_ptr(&rzv2m_pwm_pm_ops),
> +		.of_match_table =3D of_match_ptr(rzv2m_pwm_of_table),
> +	},
> +	.probe =3D rzv2m_pwm_probe,
> +};
> +module_platform_driver(rzv2m_pwm_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/V2M PWM Timer Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:pwm-rzv2m");
> --=20
> 2.25.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7jiz5f6k4g464zos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQukSgACgkQj4D7WH0S
/k7bngf6Ali+KPjgjzWc8Pu5fqxiA711OT2HmYNS5rviM1HINwd/gWplmdpXl5F2
sVC7XwdAgO7Buh6SqKbaeNqELzR3NgDAOsc8opeQendYCulb9juMeSxYn09kjFPU
WXYUccagWdX4sqHGgD5gBFAbs3k165mR2u7L0NR97SFKQN9e/Hbq7Gll/FUPamql
PF8gkJzqjwGbVPFy1jXOaQLHf9nqdedgmYd58J+gXiOFe4wBW2FrE5NttU6JnO59
rqmtFjEvJq4IzxuuKB6WoDcx2pEF6llpBseqHE/3vnGyraW/x7Q/Gis1OUQflA6s
4pn2nrkJtusAErMyq9W0eMXwhGpWFA==
=fBxN
-----END PGP SIGNATURE-----

--7jiz5f6k4g464zos--
