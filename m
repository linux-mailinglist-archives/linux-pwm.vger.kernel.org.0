Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B05BC3C7
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Sep 2022 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiISH5o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Sep 2022 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiISH5n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Sep 2022 03:57:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9391EED8
        for <linux-pwm@vger.kernel.org>; Mon, 19 Sep 2022 00:57:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaBel-0007bS-Lg; Mon, 19 Sep 2022 09:57:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaBek-001cW1-3z; Mon, 19 Sep 2022 09:57:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaBeh-001tX9-Ig; Mon, 19 Sep 2022 09:57:27 +0200
Date:   Mon, 19 Sep 2022 09:57:27 +0200
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
Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkyiwg2iyebec3ec"
Content-Disposition: inline
In-Reply-To: <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
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


--vkyiwg2iyebec3ec
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 05, 2022 at 06:13:28PM +0100, Biju Das wrote:
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
> v5->v6:
>  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
>    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
>    involving FIELD_PREP macro.
>  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
>    for duty_offset.
>  * replaced misnomer real_period->state_period.
>  * Added handling for values >=3D (1024 << 32) for both period
>    and duty cycle.
>  * Added comments for pwm {en,dis}abled by bootloader during probe.
> v4->v5:
>  * Added Hardware manual details
>  * Replaced the comment GTCNT->Counter
>  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
>    used in probe.
>  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
>  * Added driver prefix for the type name and the variable.
>  * Initialization of per_channel data moved from request->probe.
>  * Updated clr parameter for rzg2l_gpt_modify for Start count.
>  * Started using mutex and usage_count for handling shared
>    period and prescalar for the 2 channels.
>  * Updated the comment cycle->period.
>  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
>  * Replaced pc->rzg2l_gpt.
>  * Updated prescale calculation.
>  * Moved pm_runtime_{get_sync,put} from {request,free}->{enable,disable}
>  * Removed platform_set_drvdata as it is unused
>  * Removed the variable pwm_enabled_by_bootloader=20
>  * Added dev_err_probe in various error paths in probe.
>  * Added an error message, if devm_pwmchip_add() fails.
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
>  drivers/pwm/Kconfig         |  11 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 409 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 421 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..2723a3e9ff65 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
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
> index 7bf1a29f02b8..cac39b18d1ee 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-=
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
> index 000000000000..9913dd995891
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-u=
sers-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - Counter must be stopped before modifying Mode and Prescaler.
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
> +#include <linux/limits.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +
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
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) | R=
ZG2L_GTIOR_OBE)
> +#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) | R=
ZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct mutex lock;
> +	u32 user_count;
> +	u32 state_period;
> +	unsigned long rate;
> +	bool pwm_enabled_by_bootloader;
> +};
> +
> +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
> +{
> +	return container_of(chip, struct rzg2l_gpt_chip, chip);
> +}
> +
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u=
32 data)
> +{
> +	iowrite32(data, rzg2l_gpt->mmio + reg);
> +}
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg)
> +{
> +	return ioread32(rzg2l_gpt->mmio + reg);
> +}
> +
> +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, =
u32 clr,
> +			     u32 set)
> +{
> +	rzg2l_gpt_write(rzg2l_gpt, reg,
> +			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
> +}
> +
> +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> +				   u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 5;
> +	else
> +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count--;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +}
> +
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt)
> +{
> +	/* Start count */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, 0, RZG2L_GTCR_CST);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt)
> +{
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_CST, 0);
> +}
> +
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> +	 * calculation.
> +	 */
> +	if (rzg2l_gpt->rate > NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (state->period !=3D rzg2l_gpt->state_period && rzg2l_gpt->user_count=
 > 1)
> +		return -EBUSY;

I had feedback to that one in v5. Please at least state the potential to
improve in a comment.

> +
> +	rzg2l_gpt->state_period =3D state->period;
> +
> +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate, NSEC_=
PER_SEC);
> +	prescale =3D rzg2l_calculate_prescale(rzg2l_gpt, period_cycles);
> +
> +	if (period_cycles >=3D (1024ULL << 32))
> +		pv =3D U32_MAX;
> +	else
> +		pv =3D period_cycles >> (2 * prescale);

You're assuming that pv <=3D U32_MAX after this block, right? Then maybe

	if (period_cycles >> (2 * prescale) <=3D U32_MAX)

is the more intuitive check?

> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate, NSE=
C_PER_SEC);
> +
> +	if (duty_cycles >=3D (1024ULL << 32))
> +		dc =3D U32_MAX;
> +	else
> +		dc =3D duty_cycles >> (2 * prescale);
> +
> +	/* Counter must be stopped before modifying Mode and Prescaler */
> +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> +		rzg2l_gpt_disable(rzg2l_gpt);

For v5 I asked if this affects other channels, you said yes and in the
follow up I failed to reply how to improve this.

I wonder how this affects other channels. Does it restart a period
afterwards, or is the effect only that the currently running period is a
bit stretched? At least point that this stops the global counter and so
affects the other PWMs provided by this chip.

> +
> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR,
> +			 RZG2L_GTCR_MD, RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> +
> +	/* Select count clock */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +
> +	/* Set period */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm), dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
> +
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> +
> +	/* Enable pin output */
> +	if (pwm->hwpwm)
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> +				 RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> +				 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u8 prescale;
> +	u64 tmp;
> +	u32 val;
> +
> +	/* get period */
> +	state->period =3D rzg2l_gpt->state_period;

This is useless. For one thing .state_period is only set by .apply()
which might not have been called and in the interesting cases (i.e. with
=2Eenabled =3D true) the value is overwritten anyhow. I'd just drop this
line.

> +	pm_runtime_get_sync(chip->dev);
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> +	state->enabled =3D val & RZG2L_GTCR_CST;
> +	if (state->enabled) {
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);

This can overflow.

> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm));
> +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);

ditto.

> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> +		/*
> +		 * Ordering is important, when we set a period for the second
> +		 * channel, as pwm_request_from_chip() calling get_state() will
> +		 * have an invalid duty cycle value as the register is not
> +		 * initialized yet. So set duty_cycle to zero.
> +		 */
> +		if (state->duty_cycle > state->period &&
> +		    rzg2l_gpt->user_count > 1)
> +			state->duty_cycle =3D 0;

I would expect

		if (state->duty_cycle > state->period)
			state->duty_cycle =3D state->period;

here?

> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	if (!state->enabled) {
> +		if (rzg2l_gpt->pwm_enabled_by_bootloader) {
> +			/*
> +			 * For PWM enabled by bootloader case, Release the clk
> +			 * framework resources and set the pwm_enabled_by_bootloader
> +			 * variable to false. After this clock is managed by PM.
> +			 */
> +			rzg2l_gpt->pwm_enabled_by_bootloader =3D false;
> +			devm_clk_put(chip->dev, rzg2l_gpt->clk);
> +		}
> +
> +		rzg2l_gpt_disable(rzg2l_gpt);
> +		ret =3D 0;
> +		goto done;
> +	}
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +	if (ret)
> +		goto done;
> +
> +	return rzg2l_gpt_enable(rzg2l_gpt);
> +
> +done:
> +	pm_runtime_put(chip->dev);
> +
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
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static void rzg2l_gpt_reset_assert_pm_disable(void *data)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> +
> +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> +	reset_control_assert(rzg2l_gpt->rstc);
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
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_gpt_reset_assert_pm_disable,
> +				       rzg2l_gpt);
> +	if (ret < 0)
> +		return ret;
> +
> +	rzg2l_gpt->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe(). A variable pwm_enabled_by_
> +	 *  bootloader is set to true in that case and during first
> +	 *  pwm_disable(), it is set to false and release the clock resource.
> +	 *
> +	 *  In case the pwm is not enabled by the bootloader, devm_clk_put
> +	 *  disables the clk and holding a reference on the clk isn't needed
> +	 *  because runtime-pm handles the needed enabling.
> +	 */
> +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> +		rzg2l_gpt->pwm_enabled_by_bootloader =3D true;
> +	else
> +		devm_clk_put(&pdev->dev, rzg2l_gpt->clk);

While it works I don't particularly like this construct. But maybe
that's only me and I don't have a nice alternative to offer.

> +
> +	mutex_init(&rzg2l_gpt->lock);
> +
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D 2;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> +	if (ret)
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	return ret;
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
> --=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vkyiwg2iyebec3ec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMoIOQACgkQwfwUeK3K
7AmzsAf+PZQoDC3LeRbhNTe2OkyFVVwYkGTDS6nZ8SPr0DFk43U9dggiGNJoMaha
Qt8GAxdXSt39qBdNbFS2XloLpXebiRTobcvXzd4A8KQIA4k+tz/hQFOv67XB6Go2
M7F5PcojLlivq3Ru8E/ys/9Y0FwcVifsMO/ZyuMznUbFzRnRDzjj9KCM3fr9GHtL
jTuuuf0kzIu6eN91G/RJIV0GflRZm9eNQbUX2o4UU9iyB+i0pLdNdAEjkrloJxT0
egDnPACkjU1/G9qCTD6a/+gFQw4j7TIL4fTX8tmIhX8UF53sLYmApFSZ3lu3IZDg
8S4mbC+m2tom7VxDQRbeQ4pDkztMIg==
=CHAH
-----END PGP SIGNATURE-----

--vkyiwg2iyebec3ec--
