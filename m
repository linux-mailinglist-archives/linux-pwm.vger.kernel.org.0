Return-Path: <linux-pwm+bounces-1744-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F9878F08
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Mar 2024 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC281C20893
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Mar 2024 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3618832C84;
	Tue, 12 Mar 2024 07:20:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54D3236
	for <linux-pwm@vger.kernel.org>; Tue, 12 Mar 2024 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228028; cv=none; b=srYQP7KYUXEEze8bwb+oe0nXC+sONnfu/Vqu/biox3JHKLuClI9/cbkHokrTyW+rZoo7np3YRUqr/7xhcZkVl5DccofZ4GN+PzzlBCbNpI9plpDXqUF3cn7Z0IYKWL9180KTVnL3BcSpI7H/QDrk/efO3C7S0rY5D/h5MGdVV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228028; c=relaxed/simple;
	bh=F0jEjqpTXPGLQ/+3U4yCTnbbpr2IY6zKMlEGqPLX20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gje0CIl4PwTfhBALrTaojMQRTWnu1ZNkCZ49n3TeGcfTRhcLUQzzkFgskSI978//L/SZep4ZL1tW/suDgmNj0aj3qbrrtfPzqG/xMCFkqYUKiuBFcaxL4QwHyjE14wL4kbf3ubyMaihZv/uB42kDaoNop6BGPpqCzJm6T2RmmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjwQt-0003pA-Dd; Tue, 12 Mar 2024 08:20:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjwQr-005s2a-Nt; Tue, 12 Mar 2024 08:20:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjwQr-004cDN-26;
	Tue, 12 Mar 2024 08:20:17 +0100
Date: Tue, 12 Mar 2024 08:20:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Biju Das <biju.das.au@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
References: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
 <20240220194318.672443-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fr2a5dqbtbpp5rtz"
Content-Disposition: inline
In-Reply-To: <20240220194318.672443-4-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--fr2a5dqbtbpp5rtz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 20, 2024 at 07:43:17PM +0000, Biju Das wrote:
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644
> index 000000000000..0dc8163ee92b
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,559 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2024 Renesas Electronics Corporation
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

Do I understand right that the driver doesn't disable one channel if the
other is running?

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
> +#include <linux/units.h>
> +
> +#define RZG2L_GTCR		0x2c
> +#define RZG2L_GTUDDTYC		0x30
> +#define RZG2L_GTIOR		0x34
> +#define RZG2L_GTBER		0x40
> +#define RZG2L_GTCNT		0x48
> +#define RZG2L_GTCCR(i)		(0x4c + 4 * (i))
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

Would it make sense to have GTUDDTYC in the last define's name?

> +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_GTIOx(a)	((a) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIO=
A)
> +#define RZG2L_GTIOR_OAE		BIT(8)
> +#define RZG2L_GTIOR_OBE		BIT(24)
> +#define RZG2L_GTIOR_OxE(a)	((a) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
> +
> +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
> +#define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) | R=
ZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(a) \
> +	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
> +	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
> +
> +#define RZG2L_MAX_HW_CHANNELS	8
> +#define RZG2L_CHANNELS_PER_IO	2
> +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_P=
ER_IO)
> +#define RZG2L_MAX_SCALE_FACTOR	1024
> +
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
> +	u32 period_cycles[RZG2L_MAX_HW_CHANNELS];
> +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> +	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
> +};
> +
> +static inline unsigned int rzg2l_gpt_subchannel(unsigned int hwpwm)
> +{
> +	return hwpwm & 0x1;
> +}
> +
> +static inline u64 rzg2l_gpt_mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> +{
> +	u64 retval;
> +
> +	if (a > b)
> +		retval =3D mul_u64_u64_div_u64(b, a, c);
> +	else
> +		retval =3D mul_u64_u64_div_u64(a, b, c);

With
https://lore.kernel.org/lkml/20240303092408.662449-2-u.kleine-koenig@pengut=
ronix.de
this function can be replaced by a direct call to mul_u64_u64_div_u64().
I expect this patch to go into v6.9-rc1 as akpm picked it up before the
merge window opened.

> +	return retval;
> +}
> [...]
> +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt, u3=
2 val, u8 prescale)
> +{
> +	u64 tmp, d;
> +
> +	/*
> +	 * Rate is in MHz and is always integer for peripheral clk
> +	 * 2^32 * 2^10 (prescalar) * 10^9 > 2^64
> +	 * 2^32 * 2^10 (prescalar) * 10^6 < 2^64
> +	 * Multiply val with prescalar first, if the result is less than
> +	 * 2^34, then multiply by 10^9. Otherwise divide nr and dr by 10^3
> +	 * so that it will never overflow.
> +	 */
> +
> +	tmp =3D (u64)val << (2 * prescale);
> +	if (tmp <=3D (1ULL << 34)) {

I would have written that as:

	if (tmp >> 34 =3D=3D 0)

(which implements tmp < (1ULL << 34), which doesn't matter much).

> +		tmp *=3D NSEC_PER_SEC;
> +		d =3D rzg2l_gpt->rate;
> +	} else {
> +		tmp *=3D div64_u64(NSEC_PER_SEC, KILO);

I don't know if the compiler is clever enough to not calculate that
every time? Also using div64_u64 is too heavy given that both values fit
into an u32.

> +		d =3D div64_u64(rzg2l_gpt->rate, KILO);

At first I thought you could better use 1024 as the common divisor here
as it could be implemented using a shift operation. But I understood
with the comment above that we're not losing precision here as both
NSEC_PER_SEC and rate are a multiple of 1000.

Maybe s/Rate is in MHz and is always integer for peripheral clk/Rate is
a multiple of 1000000, and so dividing by 1000 is an exact operation./ ?


> +	}
> +
> +	return DIV64_U64_ROUND_UP(tmp, d);
> +}
> +
> +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(chip->dev);
> +	if (rc)
> +		return rc;
> +
> +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> +	if (state->enabled) {
> +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +		u8 prescale;
> +		u32 val;
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> +		state->period =3D calculate_period_or_duty(rzg2l_gpt, val, prescale);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> +				     offs + RZG2L_GTCCR(rzg2l_gpt_subchannel(pwm->hwpwm)));
> +		state->duty_cycle =3D calculate_period_or_duty(rzg2l_gpt, val, prescal=
e);
> +		if (state->duty_cycle > state->period)
> +			state->duty_cycle =3D state->period;
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)
> +{
> +	return min_t(u64, (period_or_duty_cycle + (1 << (2 * prescale)) - 1) >>=
 (2 * prescale),
> +		     U32_MAX);

Can the addition overflow? Is the addition even right? This function is
used in .apply() where it's usually right to round down.

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
> +	/* Limit period/duty cycle to max value supported by the HW */
> +	if (state->period > rzg2l_gpt->max_val)
> +		period_cycles =3D rzg2l_gpt->max_val;
> +	else
> +		period_cycles =3D state->period;

this is equivalent to

	period_cycles =3D min(state->period, rzg2l_gpt->max_val);

Is this less readable to justify keeping the if?

> +	period_cycles =3D rzg2l_gpt_mul_u64_u64_div_u64(period_cycles, rzg2l_gp=
t->rate, NSEC_PER_SEC);

After this operation period_cycles's unit is really hardware cycles.
Before it isn't. I suggest to introduce another variable "period" for
the value above. So make this read:

	period =3D min(state->period, rzg2l_gpt->max_val);
	period_cycles =3D mul_u64_u64_div_u64(period, rzg2l_gpt->rate, NSEC_PER_SE=
C);

=2E This shouldn't be harder for the compiler but easier for the human
reader.

> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (period_cycles < rzg2l_gpt->period_cycles[ch] && rzg2l_gpt->user_cou=
nt[ch] > 1)

Would it make sense to swap the checks? Technically it doesn't make a
difference, but if rzg2l_gpt->user_count[ch] =3D=3D 0
rzg2l_gpt->period_cycles[ch] might be an invalid value?

> +		return -EBUSY;
> +
> +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	if (state->duty_cycle > rzg2l_gpt->max_val)
> +		duty_cycles =3D rzg2l_gpt->max_val;
> +	else
> +		duty_cycles =3D state->duty_cycle;
> +
> +	duty_cycles =3D rzg2l_gpt_mul_u64_u64_div_u64(duty_cycles, rzg2l_gpt->r=
ate, NSEC_PER_SEC);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period cycl=
es
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->period_cycles[ch] =3D period_cycles;
> +
> +	/*
> +	 * Counter must be stopped before modifying mode, prescaler, timer
> +	 * counter and buffer enable registers. These registers are shared
> +	 * between both channels. So allow updating these registers only for the
> +	 * first enabled channel.
> +	 */
> +	if (rzg2l_gpt->enable_count[ch] <=3D 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);

What happens for the second running channel here? You're still writing
to the relevant registers, just without stopping the hardware. Sounds
strange.

> +
> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
> +			 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> [...]
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled) {
> +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> +			pm_runtime_put_sync(rzg2l_gpt->chip.dev);
> +		}
> +
> +		return 0;
> +	}
> +
> +	if (!enabled) {
> +		ret =3D pm_runtime_resume_and_get(rzg2l_gpt->chip.dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +	if (ret)

Is here a conditional pm_runtime_put_sync() missing?

> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);

and here?

> +	return ret;
> +}
> +
> [...]
> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	int ret;
> +	u32 i;
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
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		goto err_reset;
> +
> +	ret =3D clk_rate_exclusive_get(rzg2l_gpt->clk);

There is a devm variant of this function in the mean time.

> +	if (ret)
> +		goto err_pm_put;
> +
> +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> +	if (!rzg2l_gpt->rate) {
> +		ret =3D dev_err_probe(&pdev->dev, -EINVAL, "gpt clk rate is 0");
> +		goto err_clk_rate_put;
> +	}
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rzg2l_gpt->rate > NSEC_PER_SEC) {
> +		ret =3D -EINVAL;

Error message please.

> +		goto err_clk_rate_put;
> +	}
> +
> +	rzg2l_gpt->max_val =3D div64_u64((u64)U32_MAX * NSEC_PER_SEC,
> +				       rzg2l_gpt->rate) * RZG2L_MAX_SCALE_FACTOR;
> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe().
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> +			set_bit(i, rzg2l_gpt->ch_en_bits);
> +			pm_runtime_get_sync(&pdev->dev);
> +		}
> +	}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fr2a5dqbtbpp5rtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXwAjAACgkQj4D7WH0S
/k64XQgApHn08QMyTOD5Lvei9cC/O6rwRf1PJgE3k23a+NlV51p53Qa40k6K2W7i
1bGXfSUqgOFaMnjNShs3ZHUQ+CZuoxOiwP7U7nNaxpOZ2NqbQdUuQLx7HToaMwhR
uPjLLbYU3WfU4kVnRhQX2P68Qh6yw84yRaknbvgTQbJ7IPdQv733d5h7c+B5CFDT
n5ff93Mdrtv45VKmt627dcuchO8D2tqfGLvOShtnVfLyntfBTelMM7jH31VoPJOu
UU5QS2THrZYOiwY8xGks3FHomJqel1XvrimCBhFBfICY7LGgP2ccD4f+59IpsUMa
H5HW3sxxQ2RAqt1jmI/7kX/Q80nAPw==
=46xh
-----END PGP SIGNATURE-----

--fr2a5dqbtbpp5rtz--

