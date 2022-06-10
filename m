Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E26545F35
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jun 2022 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbiFJIdM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Jun 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348034AbiFJIcq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2022 04:32:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C03DA4B
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jun 2022 01:30:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nza24-0006fB-Mj; Fri, 10 Jun 2022 10:30:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nza23-007Xjo-Q6; Fri, 10 Jun 2022 10:30:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nza21-00FMVM-E4; Fri, 10 Jun 2022 10:30:13 +0200
Date:   Fri, 10 Jun 2022 10:30:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220610083013.7asxcv4b554ln7pu@pengutronix.de>
References: <20220606160509.250962-1-biju.das.jz@bp.renesas.com>
 <20220606160509.250962-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lxji2wcfbab36k5"
Content-Disposition: inline
In-Reply-To: <20220606160509.250962-3-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7lxji2wcfbab36k5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 06, 2022 at 05:05:09PM +0100, Biju Das wrote:
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits =D7 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM waveforms.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>=20
> This patch adds basic pwm support for RZ/G2L GPT driver by creating
> separate logical channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested driver with PWM_DEBUG enabled
> RFC->V1:
>  * Updated macros
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read()
> ---
>  drivers/pwm/Kconfig         |  11 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 351 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 904de8d61828..a6cf24cb31e0 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -471,6 +471,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_RZG2L_GPT
> +	tristate "Renesas RZ/G2L General PWM Timer support"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the General PWM Timer controller found in Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rzg2l-gpt.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5c08bdb817b4..12bc2a005e24 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-=
poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644
> index 000000000000..f83ba2d5c219
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,351 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Limitations:
> + * - Mode and Prescalar must be set, while the GTCNT is stopped.
> + * - Configured for Output low on GTIOCx pin when counting stops.

The last item means the PWM emits the inactive level when disabled,
right? Then I suggest to write that as:

 * - When PWM is disabled, the output is driven to inactive.

to simplify understanding that. Also add:

 * - While the hardware supports both polarities, the driver (for now)
 *   only handles normal polarity.

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +
> +#define GPT_IO_PER_CHANNEL	2
> +
> +#define GTPR_MAX_VALUE	0xFFFFFFFF
> +#define GTCR		0x2c
> +#define GTUDDTYC	0x30
> +#define GTIOR		0x34
> +#define GTBER		0x40
> +#define GTCNT		0x48
> +#define GTCCRA		0x4c
> +#define GTCCRB		0x50
> +#define GTPR		0x64
> +
> +#define GTCR_CST	BIT(0)
> +#define GTCR_MD		GENMASK(18, 16)
> +#define GTCR_TPCS	GENMASK(26, 24)
> +
> +#define GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(GTCR_MD, 0)
> +
> +#define GTUDDTYC_UP	BIT(0)
> +#define GTUDDTYC_UDF	BIT(1)
> +#define UP_COUNTING	(GTUDDTYC_UP | GTUDDTYC_UDF)
> +
> +#define GTIOR_GTIOA	GENMASK(4, 0)
> +#define GTIOR_GTIOB	GENMASK(20, 16)
> +#define GTIOR_OAE	BIT(8)
> +#define GTIOR_OBE	BIT(24)
> +
> +#define INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> +#define INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +
> +#define GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH	(INIT_OUT_HI_OUT_HI_END_=
TOGGLE | GTIOR_OAE)
> +#define GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH	(INIT_OUT_LO_OUT_LO_END_=
TOGGLE | GTIOR_OAE)
> +#define GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH	((INIT_OUT_HI_OUT_HI_END=
_TOGGLE << 16) | GTIOR_OBE)
> +#define GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH	((INIT_OUT_LO_OUT_LO_END=
_TOGGLE << 16) | GTIOR_OBE)

the LHS of the last define can be better written as:

	FIELD_PREP(GTIOR_GTIOB, INIT_OUT_LO_OUT_LO_END_TOGGLE) | GTIOR_OBE

It's a bit longer, but doesn't duplicate the 16. Similar for the other
defines.

Can you please prefix all these defines all by RZG2L_?

> +
> +struct phase {
> +	u32 value;
> +	u32 mask;
> +	u32 duty_reg_offset;
> +};
> +
> +static const struct phase phase_params[] =3D {
> +	/* Setting for phase A */
> +	{
> +		.value =3D GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> +		.mask =3D GTIOR_GTIOA | GTIOR_OAE,
> +		.duty_reg_offset =3D GTCCRA,
> +	},
> +	/* Setting for phase B */
> +	{
> +		.value =3D GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
> +		.mask =3D GTIOR_GTIOB | GTIOR_OBE,
> +		.duty_reg_offset =3D GTCCRB,
> +	},
> +};
> +
> +struct gpt_pwm_device {
> +	const struct phase *ph;
> +};
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct gpt_pwm_device gpt[2];
> +};
> +
> +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
> +{
> +	return container_of(chip, struct rzg2l_gpt_chip, chip);
> +}
> +
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *pc, u32 reg, u32 data)
> +{
> +	iowrite32(data, pc->mmio + reg);
> +}
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *pc, u32 reg)
> +{
> +	return ioread32(pc->mmio + reg);
> +}
> +
> +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *pc, u32 reg, u32 clr=
, u32 set)
> +{
> +	rzg2l_gpt_write(pc, reg, (rzg2l_gpt_read(pc, reg) & ~clr) | set);
> +}
> +
> +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, u64 period=
_cycles)
> +{
> +	u16 i, prod;
> +	u8 prescale;
> +
> +	prescale =3D 5;
> +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> +	for (i =3D 0; i < 6; i++) {
> +		prod =3D 1 << (2 * i);
> +		if ((period_cycles / (1ULL * GTPR_MAX_VALUE * prod)) =3D=3D 0) {
> +			prescale =3D i;
> +			break;
> +		}
> +	}
> +
> +	return prescale;

You must not do 64 bit divisions using /.
Also you can shorten the calculation using something like:

	prescaled_period_cycles =3D period_cycles;
	do_div(prescaled_period_cycles, GTPR_MAX_VALUE);

	prescale =3D fls((prescaled_period_cycles + 1) >> 1);
	return min(prescale, 5);

(Please double check, I didn't)

> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	struct gpt_pwm_device *gpt;
> +
> +	if (pwm->hwpwm >=3D GPT_IO_PER_CHANNEL)
> +		return -EINVAL;
> +
> +	gpt =3D &pc->gpt[pwm->hwpwm];
> +	gpt->ph =3D &phase_params[pwm->hwpwm];
> +	pwm_set_chip_data(pwm, gpt);

What is the advantage to do that here instead of at the place where gpt
and gpt->ph is used?

> +	pm_runtime_get_sync(chip->dev);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	pm_runtime_put(chip->dev);
> +}
> +
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *pc)
> +{
> +	/* Start count */
> +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, GTCR_CST);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc)
> +{
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, 0);
> +}
> +
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    u64 duty_ns, u64 period_ns)
> +{
> +	struct gpt_pwm_device *gpt =3D pwm_get_chip_data(pwm);
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	unsigned long rate, pv, dc;
> +	u64 period_cycles;
> +	u8 prescale;
> +
> +	rate =3D clk_get_rate(pc->clk);
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> +	 * calculation.
> +	 */
> +	if (rate > NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	period_cycles =3D mul_u64_u64_div_u64(rate, period_ns, NSEC_PER_SEC);
> +	prescale =3D rzg2l_calculate_prescale(pc, period_cycles);
> +
> +	pv =3D round_down(period_cycles >> (2 * prescale), 1 >> (2 * prescale));
> +	period_cycles =3D mul_u64_u64_div_u64(rate, duty_ns, NSEC_PER_SEC);
> +	dc =3D round_down(period_cycles >> (2 * prescale), 1 >> (2 * prescale));
> +
> +	/* Mode and Prescalar must be set, while the GTCNT is stopped. */

	/* GTCNT must be stopped before modifying Mode and Prescaler */

is more accurate. Would it make sense to check if mode and prescaler
have to be modified before stopping the hardware?

> +	if (rzg2l_gpt_read(pc, GTCR) & GTCR_CST)
> +		rzg2l_gpt_disable(pc);
> +
> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(pc, GTCR, GTCR_MD, GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(pc, GTUDDTYC, UP_COUNTING);
> +
> +	/* Select count clock */
> +	rzg2l_gpt_modify(pc, GTCR, GTCR_TPCS, FIELD_PREP(GTCR_TPCS, prescale & =
0x3));

prescale is <=3D 5, so there is no need for & 0x3.

> +	/* Set cycle */
> +	rzg2l_gpt_write(pc, GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(pc, gpt->ph->duty_reg_offset, dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(pc, GTCNT, 0);
> +
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(pc, GTBER, 0);
> +
> +	/* Enable pin output */
> +	rzg2l_gpt_modify(pc, GTIOR, gpt->ph->mask, gpt->ph->value);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	struct gpt_pwm_device *gpt =3D pwm_get_chip_data(pwm);
> +	unsigned long rate;
> +	u8 prescale;
> +	u32 val;
> +
> +	val =3D rzg2l_gpt_read(pc, GTCR);
> +	state->enabled =3D val & GTCR_CST;
> +	if (state->enabled) {
> +		rate =3D clk_get_rate(pc->clk);
> +		prescale =3D FIELD_GET(GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(pc, GTPR);
> +		state->period =3D div_u64(val, rate) << (2 * prescale);

Didn't PWM_DEBUG report a problem here? What is rate typically? Which
ranges did you test with PWM_DEBUG enabled? This doesn't look to match
=2Eapply(). I suspect .apply is wrong here, if I had to guess the division
by 0xffffffff is bogus.

Also you're loosing precision here. div_u64(val << (2 * prescale), rate)
would return a more accurate value. (However you had to make sure that
the shift doesn't overflow.)

> +		val =3D rzg2l_gpt_read(pc, gpt->ph->duty_reg_offset);
> +		state->duty_cycle =3D div_u64(val, rate) << (2 * prescale);
> +	} else {
> +		state->period =3D GTPR_MAX_VALUE;
> +		state->duty_cycle =3D 0;

You can drop this else branch.

> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	int ret =3D 0;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled)
> +		goto err;

I wouldn't call this "err", a request to disable the PWM isn't an error.

> +	ret =3D rzg2l_gpt_config(chip, pwm, state->duty_cycle, state->period);
> +	if (ret)
> +		goto err;

No need to disable the PWM in this case, just return ret here.

> +	return rzg2l_gpt_enable(pc);
> +err:
> +	rzg2l_gpt_disable(pc);
> +	return ret;
> +}
> +
> +static const struct pwm_ops rzg2l_gpt_ops =3D {
> +	.request =3D rzg2l_gpt_request,
> +	.free =3D rzg2l_gpt_free,
> +	.get_state =3D rzg2l_gpt_get_state,
> +	.apply =3D rzg2l_gpt_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-gpt", },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static void rzg2l_gpt_reset_assert_pm_disable(void *data)
> +{
> +	struct rzg2l_gpt_chip *pc =3D data;
> +
> +	pm_runtime_disable(pc->chip.dev);
> +	reset_control_assert(pc->rstc);
> +}
> +
> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	int ret;
> +
> +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
> +	if (!rzg2l_gpt)
> +		return -ENOMEM;
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	rzg2l_gpt->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	platform_set_drvdata(pdev, rzg2l_gpt);
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_gpt_reset_assert_pm_disable,
> +				       rzg2l_gpt);
> +	if (ret < 0)
> +		return ret;
> +
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D GPT_IO_PER_CHANNEL;
> +
> +	return devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);

If the PWM is already running during probe (e.g. because the bootloader
enabled the LCD backlight and showed a splash screen), you should make
sure to keep the PWM in that state. In this case you are required to
enable the clk.

> +}
> +
> +static struct platform_driver rzg2l_gpt_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzg2l-gpt",
> +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> +	},
> +	.probe =3D rzg2l_gpt_probe,
> +};
> +module_platform_driver(rzg2l_gpt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:pwm-rzg2l-gpt");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7lxji2wcfbab36k5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKjARIACgkQwfwUeK3K
7Al1Dwf/UZFXoSJfBb012gz4QT12sGpjXm33RlBrIhBS1rGXWuRvnkC0Kx7isgsi
E4w5oo3zZJjMoMYfahtwt02Y593KlG78EK3G+KUFhYOakE5AL6pVEc0MnuZkrHpw
UDCAddqU8FTAZGU6U7JSnpnK4J/DwE58UuTwGdYo4BOI6D7cDJBKr+vVtygHYu2X
RNhpcpXs5Z96xhUXVv5IQGp7YoMdI5zeYa19V5AXtwEX0yovfI1BoD3+lheR4Njl
FATWFVyzaqFhri85rJbZtOYD+X5mgNiD9KnRtwRhc/2QyD+EujGKZjDfYbS847K7
vTFPoJ3us1XwE32N/XeX/MUCyoOy3w==
=2Lqh
-----END PGP SIGNATURE-----

--7lxji2wcfbab36k5--
