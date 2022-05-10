Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6941A522158
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347474AbiEJQiW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347475AbiEJQiU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 12:38:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DEF2A471A
        for <linux-pwm@vger.kernel.org>; Tue, 10 May 2022 09:34:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1noSoM-0001fw-Td; Tue, 10 May 2022 18:34:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noSoM-001WbM-QO; Tue, 10 May 2022 18:34:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noSoK-008qaM-N7; Tue, 10 May 2022 18:34:08 +0200
Date:   Tue, 10 May 2022 18:34:05 +0200
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
Subject: Re: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220510163405.pts6mm7zdoxxpmqt@pengutronix.de>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gjknl2mbhq5ay7vx"
Content-Disposition: inline
In-Reply-To: <20220510144259.9908-3-biju.das.jz@bp.renesas.com>
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


--gjknl2mbhq5ay7vx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 10, 2022 at 03:42:59PM +0100, Biju Das wrote:
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
> RFC->V1:
>  * Updated macros
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read()
> ---
>  drivers/pwm/Kconfig         |  11 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 355 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 367 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..d93b510f9ca8 100644
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
> index 708840b7fba8..bd213ae64074 100644
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
> index 000000000000..d5d22b1ff792
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/units.h>
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
> +#define GTCR_CST			BIT(0)
> +#define GTCR_MD_MASK			GENMASK(18, 16)
> +#define GTCR_TPCS_MASK			GENMASK(26, 24)
> +#define GTCR_MD_SAW_WAVE_PWM_MODE	(0 << 16)

I assume this should better be FIELD_PREF(GTCR_MD_MASK, 0).

Also I suggest to drop "_MASK" from the define names.

> +#define GTUDDTYC_UP	BIT(0)
> +#define GTUDDTYC_UDF	BIT(1)
> +#define UP_COUNTING	(GTUDDTYC_UP | GTUDDTYC_UDF)
> +
> +#define GTIOR_GTIOA_MASK			GENMASK(4, 0)
> +#define GTIOR_GTIOB_MASK			GENMASK(20, 16)
> +#define GTIOR_OAE				BIT(8)
> +#define GTIOR_OBE				BIT(24)
> +
> +#define INIT_OUT_LO_OUT_LO_END_TOGGLE		(0x07)
> +#define INIT_OUT_HI_OUT_HI_END_TOGGLE		(0x1B)
> +#define GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH	(INIT_OUT_HI_OUT_HI_END_=
TOGGLE | GTIOR_OAE)
> +#define GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH	(INIT_OUT_LO_OUT_LO_END_=
TOGGLE | GTIOR_OAE)
> +#define GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH	((INIT_OUT_HI_OUT_HI_END=
_TOGGLE << 16) | GTIOR_OBE)
> +#define GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH	((INIT_OUT_LO_OUT_LO_END=
_TOGGLE << 16) | GTIOR_OBE)
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
> +		GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> +		GTIOR_GTIOA_MASK | GTIOR_OAE,
> +		GTCCRA,

Please use named initializer (i.e.

	.value =3D GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
	.mask =3D GTIOR_GTIOA_MASK | GTIOR_OAE,
	.duty_reg_offset =3D GTCCRA,

)

> +	},
> +
> +	/* Setting for phase B */
> +	{
> +		GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
> +		GTIOR_GTIOB_MASK | GTIOR_OBE,
> +		GTCCRB,
> +	},
> +};
> +
> +struct rzg2l_gpt_chip;
> +
> +struct gpt_pwm_device {
> +	struct rzg2l_gpt_chip *pc;
> +	const struct phase *ph;
> +	unsigned int channel;	/* IO channel number in the GPT */
> +
> +	enum pwm_polarity polarity;
> +};
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +};

I suggest to not allocate memory in .request, instead put the two struct
gpt_pwm_device into a flexible array member in rzg2l_gpt_chip.
I also suspect that most of struct gpt_pwm_device isn't worth being
tracked. E.g. polarity is a write only variable.

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
> +static int rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, int perio=
d_ns)
> +{
> +	unsigned long long c, clk_rate;
> +	unsigned long period_cycles;
> +	int prescale;
> +	int i, prod;
> +
> +	clk_rate =3D clk_get_rate(pc->clk);
> +	c =3D clk_rate * period_ns;

This might overflow (once you keep period_ns as u64).

> +	period_cycles =3D div_u64(c, NANO);

Please use NSEC_PER_SEC here.

> +
> +	if (period_cycles < 1)
> +		period_cycles =3D 1;
> +
> +	prescale =3D -1;
> +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> +	for (i =3D 0, prod =3D 1; i < 6; i++) {
> +		if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0) {
> +			prescale =3D i;
> +			break;
> +		}
> +
> +		prod *=3D 4;
> +	}

This would be better understandable if you used:

	for (i =3D 0; i < 6; i++) {
		prod =3D 1 << (2 * i);
		...

	}

Have you tested this? The division by GTPR_MAX_VALUE (=3D 0xFFFFFFFF)
looks suspicious. Unless I'm missing something

	if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0)

is equivalent to:

	if (period_cycles < GTPR_MAX_VALUE)

=2E Is this really what you want here?

> +
> +	return prescale;
> +}
> +
> +static unsigned long
> +rzg2l_time_to_tick_number(struct rzg2l_gpt_chip *pc, int time_ns,
> +			  unsigned long prescale)
> +{
> +	unsigned long long c, clk_rate;
> +	unsigned long period_cycles;
> +	int i, prod;
> +
> +	clk_rate =3D clk_get_rate(pc->clk);
> +	c =3D clk_rate * time_ns;
> +	period_cycles =3D div_u64(c, NANO);
> +
> +	if (period_cycles < 1)
> +		period_cycles =3D 1;
> +
> +	/* Divide by 1, 4, 16, 64, 256 and 1024 */
> +	for (i =3D 0, prod =3D 1; i < prescale; i++)
> +		prod *=3D 4;

	prod =3D 1 << (2 * prescale);

> +
> +	return period_cycles / prod;

	return period_cycles >> (2 * prescale);

> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *_=
pwm)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	struct gpt_pwm_device *pwm;
> +
> +	if (_pwm->hwpwm >=3D GPT_IO_PER_CHANNEL)
> +		return -EINVAL;
> +
> +	pwm =3D kzalloc(sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->pc =3D pc;
> +	pwm->channel =3D _pwm->hwpwm;
> +	pwm->polarity =3D PWM_POLARITY_NORMAL;
> +	pwm->ph =3D &phase_params[pwm->channel & 0x1];
> +	pwm_set_chip_data(_pwm, pwm);
> +
> +	pm_runtime_get_sync(chip->dev);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *_pw=
m)
> +{
> +	struct gpt_pwm_device *pwm =3D pwm_get_chip_data(_pwm);
> +
> +	pm_runtime_put(chip->dev);
> +	kfree(pwm);
> +}
> +
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *_p=
wm,
> +			    int duty_ns, int period_ns)
> +{
> +	struct gpt_pwm_device *pwm =3D pwm_get_chip_data(_pwm);

Please use the variable name pwm only for pointers to struct pwm_device.

> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	unsigned long pv, dc;
> +	int prescale;
> +
> +	if (duty_ns < 0 || period_ns < 0) {
> +		dev_err(chip->dev, "ch=3D%d Set time negative\n", pwm->channel);
> +		return -EINVAL;
> +	}
> +
> +	prescale =3D rzg2l_calculate_prescale(pc, period_ns);
> +	if (prescale < 0) {
> +		dev_err(chip->dev, "ch=3D%d wrong prescale val\n", pwm->channel);
> +		return -EINVAL;
> +	}
> +
> +	pv =3D rzg2l_time_to_tick_number(pc, period_ns, prescale);
> +	dc =3D rzg2l_time_to_tick_number(pc, duty_ns, prescale);

I think the algorithm could be implemented in a much more understandable
way.

> +	if (duty_ns =3D=3D period_ns)
> +		dc =3D pv;

Isn't that already the case? If not, why? If yes, why do you calculate
dc using rzg2l_time_to_tick_number at all?

> +	/* GPT setting saw-wave up-counting */
> +	rzg2l_gpt_modify(pc, GTCR, GTCR_MD_MASK, GTCR_MD_SAW_WAVE_PWM_MODE);
> +	rzg2l_gpt_modify(pc, GTCR, GTCR_TPCS_MASK, prescale << 24);

You're doing 2 reads and 2 writes here. Wouldn't a single write be
better?

Also please use FIELD_PREP(GTCR_TPCS_MASK, prescale) instead of the abov
expression.

> +	/* Set counting mode */
> +	rzg2l_gpt_write(pc, GTUDDTYC, UP_COUNTING);
> +	/* Set period */
> +	rzg2l_gpt_write(pc, GTPR, pv);
> +
> +	/* Enable pin output */
> +	rzg2l_gpt_modify(pc, GTIOR, pwm->ph->mask, pwm->ph->value);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(pc, pwm->ph->duty_reg_offset, dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(pc, GTCNT, 0);
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(pc, GTBER, 0);

How does the output behave on reprogramming? Does it complete the
currently programmed period? Please document this behaviour as e.g.
drivers/pwm/pwm-sl28cpld.c does.

> +	return 0;
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
> +	/* Stop count */
> +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, 0);

Same question here: How does the hardware behave? Does it complete the
currently running period? How does the output behave? (Typical
candidates are: freeze at the level where it is currently, constant 0,
high-z.)

> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> +	int ret;

As you don't support different polarities, there is the following
missing:

	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -EINVAL;

> +
> +	if (!state->enabled) {
> +		rzg2l_gpt_disable(pc);
> +		return 0;
> +	}
> +
> +	ret =3D rzg2l_gpt_config(chip, pwm, state->duty_cycle, state->period);

Note that state->duty_cycle is an u64, but the 3rd parameter to
rzg2l_gpt_config is an int. So you're loosing bits here. (Yes, that is a
problem that the core has, too, but you should still do better here.)

> +	if (!ret)
> +		ret =3D rzg2l_gpt_enable(pc);
> +
> +	return ret;

It would make sense to unroll the function calls here.

> +}
> +
> +static const struct pwm_ops rzg2l_gpt_ops =3D {
> +	.request =3D rzg2l_gpt_request,
> +	.free =3D rzg2l_gpt_free,
> +	.apply =3D rzg2l_gpt_apply,

Please implement .get_state()

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-gpt", },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
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
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D GPT_IO_PER_CHANNEL;
> +
> +	ret =3D pwmchip_add(&rzg2l_gpt->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register GPT chip: %d\n", ret);

Please use dev_err_probe.

> +		pm_runtime_disable(&pdev->dev);
> +		reset_control_assert(rzg2l_gpt->rstc);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_remove(struct platform_device *pdev)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&rzg2l_gpt->chip);
> +	pm_runtime_disable(&pdev->dev);
> +	reset_control_assert(rzg2l_gpt->rstc);

All these have devm variants that can be used to simplify the error
paths in .probe and then you don't need a .remove function at all.

> +	return 0;
> +}
> +
> +static struct platform_driver rzg2l_gpt_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzg2l-gpt",
> +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> +	},
> +	.probe =3D rzg2l_gpt_probe,
> +	.remove =3D rzg2l_gpt_remove,
> +};
> +module_platform_driver(rzg2l_gpt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:pwm-rzg2l-gpt");

Please test your driver with PWM_DEBUG enabled.

Assuming you test using sysfs, a good test is:

	echo 0 > duty_cycle

	for i in $(seq 10000 -1 1); do
		echo $i > period
	done

	for i in $(seq 1 10000); do
		echo $i > period
	done

	for i in $(seq 10000 -1 1); do
		echo $i > duty_cycle
	done

	for i in $(seq 1 10000); do
		echo $i > duty_cycle
	done

=09

(Maybe pick more sensible bounds than 1 and 10000.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gjknl2mbhq5ay7vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ6k/oACgkQwfwUeK3K
7Anocwf/SMTz3oTQOlGaQe/gHUcXd6Jdx79PpLP5o1mePwTUYa0fBTjQtODeAOJi
bTI1BjtfkgQ+JCfgmWtGzLrL+4B5Sps9hfCfLh3TmM2kO3xxzUgpmdIdMhSa5PHT
GK54d+ah6j6D4q463cZoPPoFMPsjZxKG+67IOGg9aQB3aMNO3rrVisdY8wvbsGBF
nMVbiyWbUXzA+pB7DxDr/4CewstjoGCbQ+Eh5x71/QzI78jaMg0f6iuAzT5Ksm1O
n1hRQTJruJaeOoF5Gq/tbKj1AA6aOU/EdbsJ7lpuVhWmTsjzQ6Ho89dTGghd4pSQ
6BLxuM6QFqaNqlZNLuDeMfUEDPFoXA==
=ffiN
-----END PGP SIGNATURE-----

--gjknl2mbhq5ay7vx--
