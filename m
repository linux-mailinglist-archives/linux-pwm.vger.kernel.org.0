Return-Path: <linux-pwm+bounces-428-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C28077AD
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 19:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56FC282138
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3B41868;
	Wed,  6 Dec 2023 18:38:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700BA139
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 10:38:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAwmw-0003nR-9X; Wed, 06 Dec 2023 19:38:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAwmu-00E1KG-PN; Wed, 06 Dec 2023 19:38:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAwmu-00Ff7p-Eg; Wed, 06 Dec 2023 19:38:24 +0100
Date: Wed, 6 Dec 2023 19:38:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbbrl6lrzovx3fyc"
Content-Disposition: inline
In-Reply-To: <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--nbbrl6lrzovx3fyc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Mon, Nov 20, 2023 at 11:33:06AM +0000, Biju Das wrote:
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644
> index 000000000000..428e6e577db6
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,572 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2023 Renesas Electronics Corporation
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
> + * - When both channels are used, disabling the channel on one stops the
> + *   other.

Just for my understanding: The combination of the first and the last
item means you cannot update Moed and Prescaler for one channel without
affecting the other one, right?

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
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

These are not all used. Is it sensible to still keep them?

> +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))

For i =3D 0 this is RZG2L_GTCCRA, for i =3D 1 it's RZG2L_GTCCRB. Als
RZG2L_GTCCRA and RZG2L_GTCCRB are unused. Maybe move the definition of
RZG2L_GTCCR to the list of registers above?

> +#define RZG2L_MAX_HW_CHANNELS	8
> +#define RZG2L_CHANNELS_PER_IO	2
> +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_P=
ER_IO)
> +#define RZG2L_MAX_SCALE_FACTOR	1024
> +
> +#define RZG2L_IS_IOB(a)	((a) & 0x1)
> +#define RZG2L_GET_CH(a)	((a) / 2)
> +
> +#define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct mutex lock; /* lock to protect shared channel resources */
> +	unsigned long rate;
> +	u64 max_val;
> +	u32 state_period[RZG2L_MAX_HW_CHANNELS];
> +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> +	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
> +};
> +
> [...]
> +
> +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8=
 hwpwm)
> +{
> +	u8 ch =3D RZG2L_GET_CH(hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	bool is_counter_running, is_output_en;
> +	u32 val;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +	is_counter_running =3D val & RZG2L_GTCR_CST;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTIOR);
> +	if (RZG2L_IS_IOB(hwpwm))
> +		is_output_en =3D val & RZG2L_GTIOR_OBE;
> +	else
> +		is_output_en =3D val & RZG2L_GTIOR_OAE;

IIUC the i in RZG2L_GTCCR(i) stands for either A (0) or B (1), right?
Maybe define RZG2L_GTIOR_OxE(i) assuming this is about the same A and B
here? Then this could be simplified to:

	is_output_en =3D val & RZG2L_GTIOR_OxE(rzg2l_gpt_subchannel(hwpwm));

(maybe modulo better names).

> +	return (is_counter_running && is_output_en);

You could return early after knowing that is_counter_running is false
without determining is_output_en.

> +}
> +
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			    struct pwm_device *pwm)
> +{
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Enable pin output */
> +	if (RZG2L_IS_IOB(pwm->hwpwm))
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> +				 RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> +				 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);

Similar suggestion as above for A and B?!

> +	mutex_lock(&rzg2l_gpt->lock);
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0, RZG2L_GTCR_CST);
> +
> +	rzg2l_gpt->enable_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> [...]
> +
> +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt, u3=
2 val, u8 prescale)
> +{
> +	u64 retval;
> +	u64 tmp;
> +
> +	tmp =3D NSEC_PER_SEC * (u64)val;
> +	/*
> +	 * To avoid losing precision for smaller period/duty cycle values
> +	 * ((2^32 * 10^9 << 2) < 2^64), do not process the rounded values.
> +	 */
> +	if (prescale < 2)
> +		retval =3D DIV64_U64_ROUND_UP(tmp << (2 * prescale), rzg2l_gpt->rate);
> +	else
> +		retval =3D DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate) << (2 * prescale);

Maybe introduce a mul_u64_u64_div64_roundup (similar to
mul_u64_u64_div64) to also be exact for prescale >=3D 2?

With prescale <=3D 5 and rzg2l_gpt->rate >=3D 1024 this shouldn't work just
fine.

> +	return retval;
> +}
> +
> [...]
> +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)
> +{
> +	return min_t(u64, DIV64_U64_ROUND_UP(period_or_duty_cycle, 1 << (2 * pr=
escale)),
> +		     (u64)U32_MAX);

DIV64_U64_ROUND_UP(period_or_duty_cycle, 1 << (2 * prescale)) can be
calculated a bit cheaper by using:

	(period_or_duty_cycle + 1 << (2 * prescale) - 1) >> (2 * prescale)

assuming the LHS doesn't overflow.

When using min_t, you can drop the cast for U32_MAX.

> +}
> +
> +/* Caller holds the lock while calling rzg2l_gpt_config() */
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (state->period !=3D rzg2l_gpt->state_period[ch] && rzg2l_gpt->user_c=
ount[ch] > 1)
> +		return -EBUSY;

if (state->period < rzg2l_gpt->state_period[ch] && rzg2l_gpt->user_count[ch=
] > 1)

would be more forgiving and still correct.

> +	/* Limit period/duty cycle to max value supported by the HW */
> +	if (state->period > rzg2l_gpt->max_val)
> +		period_cycles =3D rzg2l_gpt->max_val;
> +	else
> +		period_cycles =3D state->period;
> +
> +	period_cycles =3D mul_u64_u32_div(period_cycles, rzg2l_gpt->rate, NSEC_=
PER_SEC);
> +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> +
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	if (state->duty_cycle > rzg2l_gpt->max_val)
> +		duty_cycles =3D rzg2l_gpt->max_val;
> +	else
> +		duty_cycles =3D state->duty_cycle;
> +
> +	duty_cycles =3D mul_u64_u32_div(duty_cycles, rzg2l_gpt->rate, NSEC_PER_=
SEC);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period value
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->state_period[ch] =3D state->period;

With the rounding that happens above, I think it would be more
approriate to track period_cycles here instead of period.

> [...]
> +	rzg2l_gpt->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> +	if (ret)
> +		goto err_reset;

devm_clk_get_enabled()?

> [...]
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rzg2l_gpt->rate > NSEC_PER_SEC) {
> +		ret =3D -EINVAL;
> +		goto err_clk_rate_put;
> +	}
> +
> +	rzg2l_gpt->max_val =3D mul_u64_u64_div_u64(U32_MAX, NSEC_PER_SEC,
> +						 rzg2l_gpt->rate) * RZG2L_MAX_SCALE_FACTOR;

Is it clear that this won't overflow?

> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe().
> +	 */

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nbbrl6lrzovx3fyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVwv58ACgkQj4D7WH0S
/k489gf/Si/pInTnpkfaQ3cGFW8hcNMpfx2/Iy6LBxXUFf+m5yf6nhWmO9FDHbMT
3C0ZTdHOz9gIWKj3NA85leHly5AXrN4bdaXXvWmSnQX30JBbjcDcTKFZcsMIVUsT
OaMSognmCDzo5hVPpuCORIIDs8zRbv8/iMcF21/Wgrdq9IbykOYRUvB2tc6YL+eC
h2W9EoJrnjSH7G8ZIgJV5SYBGNxzMoXyVr+KonSpiwNuApYQd65inrJ3ymWqoJFh
cQ1NdGIrWChdGheN+CzHNB8G1OuSPJBbqjBonAJLZl9vEfWDzf1iv4SL/X6iDpa8
P6QqwO+2ruH24FBjIvomlFKAGfoq2A==
=5ib9
-----END PGP SIGNATURE-----

--nbbrl6lrzovx3fyc--

