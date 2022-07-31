Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4666B585F52
	for <lists+linux-pwm@lfdr.de>; Sun, 31 Jul 2022 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiGaOva (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 31 Jul 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGaOv3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 31 Jul 2022 10:51:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E4B87C
        for <linux-pwm@vger.kernel.org>; Sun, 31 Jul 2022 07:51:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oIAHj-000665-0a; Sun, 31 Jul 2022 16:51:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oIAHe-000vgK-Tl; Sun, 31 Jul 2022 16:51:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oIAHe-008iOb-4T; Sun, 31 Jul 2022 16:51:10 +0200
Date:   Sun, 31 Jul 2022 16:51:07 +0200
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
Subject: Re: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220731145107.iepktigt4g63ranr@pengutronix.de>
References: <20220728162526.330542-1-biju.das.jz@bp.renesas.com>
 <20220728162526.330542-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbu2wrayngvkwjhm"
Content-Disposition: inline
In-Reply-To: <20220728162526.330542-3-biju.das.jz@bp.renesas.com>
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


--vbu2wrayngvkwjhm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2022 at 05:25:26PM +0100, Biju Das wrote:
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
> v3->v4:
>  * Changed the local variable type i from u16->u8 and prescaled_period_
>    cycles from u64->u32 in calculate_prescale().
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
>  * Dropped the comma after the sentinel.
>  * Add a variable to track pwm enabled by bootloader and added comments
>    in probe().
>  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
>  * Replaced devm_clk_get()->devm_clk_get_prepared()
>  * Removed devm_clk_get_optional_enabled()
> v2->v3:
>  * Updated limitation section
>  * Added prefix "RZG2L_" for all macros
>  * Modified prescale calculation
>  * Removed pwm_set_chip_data
>  * Updated comment related to modifying Mode and Prescaler
>  * Updated setting of prescale value in rzg2l_gpt_config()
>  * Removed else branch from rzg2l_gpt_get_state()
>  * removed the err label from rzg2l_gpt_apply()
>  * Added devm_clk_get_optional_enabled() to retain clk on status,
>    in case bootloader turns on the clk of pwm.
>  * Replaced devm_reset_control_get_exclusive->devm_reset_control_get_shar=
ed
>    as single reset shared between 8 channels.
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
>  drivers/pwm/pwm-rzg2l-gpt.c | 371 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 383 insertions(+)
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
> index 000000000000..8d25428bed69
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation

If there is a publicly available manual, adding a link here would be
great.

> + * Limitations:
> + * - GTCNT must be stopped before modifying Mode and Prescaler.

GTCNT is the counter of the hardware unit, right? So I suggest
s/GTCNT/counter/ for better general understandability.

> + * - When PWM is disabled, the output is driven to inactive.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
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
> +#define RZG2L_GPT_IO_PER_CHANNEL	2

I would not introduce a define for that number, trust the PWM framework
to not pass a hwpwm >=3D 2 in .request and just use a plain

	rzg2l_gpt->chip.npwm =3D 2;

in .probe.

> +
> +#define RZG2L_GTPR_MAX_VALUE	0xFFFFFFFF

This is unused.

> +#define RZG2L_GTCR		0x2c
> +#define RZG2L_GTUDDTYC		0x30
> +#define RZG2L_GTIOR		0x34
> +#define RZG2L_GTBER		0x40
> +#define RZG2L_GTCNT		0x48
> +#define RZG2L_GTCCRA		0x4c
> +#define RZG2L_GTCCRB		0x50
> +#define RZG2L_GTPR		0x64
> +
> +#define RZG2L_GTCR_CST		BIT(0)
> +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> +
> +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> +
> +#define RZG2L_GTUDDTYC_UP	BIT(0)
> +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> +#define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> +
> +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_OAE		BIT(8)
> +#define RZG2L_GTIOR_OBE		BIT(24)
> +
> +#define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
> +#define RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE)
> +#define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	((RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> +#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	((RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> +
> +struct phase {
> +	u32 value;
> +	u32 mask;
> +	u32 duty_reg_offset;
> +};
> +
> +static const struct phase phase_params[] =3D {

driver prefix for the type name and the variable please.

> +	/* Setting for phase A */
> +	{
> +		.value =3D RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> +		.mask =3D RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> +		.duty_reg_offset =3D RZG2L_GTCCRA,
> +	},
> +	/* Setting for phase B */
> +	{
> +		.value =3D RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
> +		.mask =3D RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> +		.duty_reg_offset =3D RZG2L_GTCCRB,
> +	},
> +};
> +
> +struct gpt_pwm_device {
> +	const struct phase *ph;
> +};

ditto

> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct gpt_pwm_device gpt[2];
> +	bool pwm_enabled_by_bootloader;
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
> +	u32 prescaled_period_cycles;
> +	u8 prescale, i;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +	prescale =3D 5;
> +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> +	for (i =3D 0; i < 6; i++) {
> +		if ((1 << (2 * i)) > prescaled_period_cycles) {
> +			prescale =3D i;
> +			break;
> +		}
> +	}

The following should be equivalent and (I guess) more effective to
calculate as:

	prescaled_period_cycles =3D period_cycles >> 32;
	if (prescaled_period_cycles >=3D 256)
		prescale =3D 5;
	else
		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1) + 1) / 2

(Should prescaled_period_cycles =3D 256 really yield prescale =3D 5?)

> +
> +	return prescale;
> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	struct gpt_pwm_device *gpt;
> +
> +	if (pwm->hwpwm >=3D RZG2L_GPT_IO_PER_CHANNEL)
> +		return -EINVAL;
> +
> +	gpt =3D &pc->gpt[pwm->hwpwm];
> +	gpt->ph =3D &phase_params[pwm->hwpwm];

This can already be done in .probe, doesn't it?

> +	pm_runtime_get_sync(chip->dev);

runtime PM is one of my bigger unknown spots, so my question might be
missleading here: Doesn't that only have an effect if there is a suspend
and resume callback for the device?
Also I would expect these calls to be more sensible on enable + disable
instead of request + free.

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
> +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_CST, RZG2L_GTCR_CST);

Given the parameters to rzg2l_gpt_modify are called clr ("clear") and
set, it's unintuitive what should happen if you pass the same bits to
both parameters. I suggest to either rename the parameters to mask and
set (and adapt the implementation accordingly) or to pass clr=3D0 here.

> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc)
> +{
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_CST, 0);
> +}
> +
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    u64 duty_ns, u64 period_ns)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	struct gpt_pwm_device *gpt =3D &pc->gpt[pwm->hwpwm];
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
> +	period_cycles =3D mul_u64_u32_div(period_ns, rate, NSEC_PER_SEC);
> +	prescale =3D rzg2l_calculate_prescale(pc, period_cycles);
> +
> +	pv =3D round_down(period_cycles >> (2 * prescale), 1 << (2 * prescale));
> +	period_cycles =3D mul_u64_u32_div(duty_ns, rate, NSEC_PER_SEC);
> +	dc =3D round_down(period_cycles >> (2 * prescale), 1 << (2 * prescale));

It would be a bit less irritating to not reuse period_cycles for the
duty cycle calculation. Either rename to cycles so it's not specific to
the period length, or introduce a separate variable for the duty stuff.

Is it really true, that prescale influences both parameters of
round_down as programmed here? I didn't thought deeply about that, but
it feels strange.

> +	/* GTCNT must be stopped before modifying Mode and Prescaler */
> +	if (rzg2l_gpt_read(pc, RZG2L_GTCR) & RZG2L_GTCR_CST)
> +		rzg2l_gpt_disable(pc);

Your chip provides two PWMs. Do the two outputs share a single prescaler
and period? In that case you need to make sure that modifying one of
them doesn't change the other one. In case of conflict refuse the
request. There are examples for that, see e.g.
drivers/pwm/pwm-imx-tpm.c.

> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_MD, RZG2L_GTCR_MD_SAW_WAVE_=
PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(pc, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> +
> +	/* Select count clock */
> +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_TPCS, FIELD_PREP(RZG2L_GTCR=
_TPCS, prescale));
> +
> +	/* Set cycle */

s/cycle/period/

> +	rzg2l_gpt_write(pc, RZG2L_GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(pc, gpt->ph->duty_reg_offset, dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(pc, RZG2L_GTCNT, 0);
> +
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(pc, RZG2L_GTBER, 0);
> +
> +	/* Enable pin output */
> +	rzg2l_gpt_modify(pc, RZG2L_GTIOR, gpt->ph->mask, gpt->ph->value);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	struct gpt_pwm_device *gpt =3D &pc->gpt[pwm->hwpwm];
> +	unsigned long rate;
> +	u8 prescale;
> +	u64 tmp;
> +	u32 val;
> +
> +	val =3D rzg2l_gpt_read(pc, RZG2L_GTCR);
> +	state->enabled =3D val & RZG2L_GTCR_CST;
> +	if (state->enabled) {
> +		rate =3D clk_get_rate(pc->clk);
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(pc, RZG2L_GTPR);
> +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rate);
> +
> +		val =3D rzg2l_gpt_read(pc, gpt->ph->duty_reg_offset);
> +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rate);
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		rzg2l_gpt_disable(pc);
> +		return 0;
> +	}
> +
> +	ret =3D rzg2l_gpt_config(chip, pwm, state->duty_cycle, state->period);
> +	if (ret)
> +		return ret;
> +
> +	return rzg2l_gpt_enable(pc);
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
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static void rzg2l_gpt_reset_assert_pm_disable(void *data)
> +{
> +	struct rzg2l_gpt_chip *pc =3D data;

In the probe function the parameter is called rzg2l_gpt. Would be great
to have always the same name for the same thing.

> +
> +	if (pc->pwm_enabled_by_bootloader)
> +		clk_disable(pc->clk);

When this function is called as part of remove, not disabling the clk is
wrong, isn't it?

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
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	rzg2l_gpt->clk =3D devm_clk_get_prepared(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	platform_set_drvdata(pdev, rzg2l_gpt);

This is unused.

> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
> +			ERR_PTR(ret));

dev_err_probe for consistency

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
> +	ret =3D clk_enable(rzg2l_gpt->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "clk enable failed\n");
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader enabled PWM and
> +	 *  is running during probe().
> +	 */
> +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> +		rzg2l_gpt->pwm_enabled_by_bootloader =3D true;
> +	else
> +		clk_disable(rzg2l_gpt->clk);
> +
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D RZG2L_GPT_IO_PER_CHANNEL;
> +
> +	return devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);

Please add an error message here if devm_pwmchip_add fails.

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

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vbu2wrayngvkwjhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLmltcACgkQwfwUeK3K
7AnISAf/ReTIGg0qt6X/EQoxEaGNoJ2C2WiMutTyLpaObn34rCs2R2o/s4oyKXry
bx09W5hA6F5EDFhqwhcA8ZOngeqtg1Afn6CXox09eSQHc2opLKKcodri57GEePQa
f+MN0D+WbkimpXkoB9aGpLtCL+5K8mVL9apoPJHeVOLeX6yFEscoG1zxpWwGdNOf
t0Zo8STzPJ6cPJu+q6ab7AkrSCf1Gumarpo/7zkR5aEybmFy2MEbC/kYMJp5IPdT
itOBdZOUN6iqIrQDOUTHIKub/kBvym7Ms5nL2GMftcVbcxfq5KHHGXWtSNhfPsGD
rtz8iDCaGVYffdzQdQqIJvkCc4aEsg==
=Ytcl
-----END PGP SIGNATURE-----

--vbu2wrayngvkwjhm--
