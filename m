Return-Path: <linux-pwm+bounces-4157-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB69DC1A7
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A0D161C5E
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91577156C72;
	Fri, 29 Nov 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxbMOPdy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662891547D5;
	Fri, 29 Nov 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873813; cv=none; b=OhOAfkaRhpXFXr4SUM4xjnrolDtBNzvOc0OzAYMyH+swkWPKoG6H9YvjfEtKUdxBGdzRuxARQwNB7pdBNleijFKnh5zwjbCkWQ7Cz4IRLwWdR2ZpxVkznUShoK56AnblAz556/EWzhzKeA6udrjVz7Ub12nyKkQ0276qYors9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873813; c=relaxed/simple;
	bh=omHCaGD6Hu7iGJTI/ixjXVxkc/J+q6Nt9F2eRXmVQvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsmUzkpd3ZSsYIlibjThd35sybWzjK5MN6dLIB+Bh6gMLwd37IsPWliP5lDEUUK7Xsd0AtzBI8y/n/wIY8pQAfmJ04dbNUHZORN7mxGW+vpzRi6QuH3xacw/x++4ZAtMdSuJBoPY9rZgqRywDfEFSD5kyf/A+puyvAwZe/OECQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxbMOPdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C432C4CECF;
	Fri, 29 Nov 2024 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732873812;
	bh=omHCaGD6Hu7iGJTI/ixjXVxkc/J+q6Nt9F2eRXmVQvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxbMOPdynzB/ydG3jEu7rTNPDgBV7DhdEJ/Qt63RmoWnOzExZ3xgEB7i/ajqLBOyJ
	 sYnkog+WZF1noVpj5d9h3QT2y5czHf8OYvgzzgQZYJ7ui1ucDzSnIJKKPvzQ5CThnM
	 QU1VhjDdSdx0kiOWlPC8G/OchU1bqSc54nrLS2Wva/PCaoLl+5MG4y+x33lEJVBVeN
	 f7Rsi/Ih43+BGpsg6B4I+wBIZK6ZUnxxh/zLCd5GbtmwY2vU7wzWuP/4GlyqyfxAqX
	 6g11afAVVaX9yf/qLaQ5C3xAlLXoS9WoPbJVe/U3gxFmqPILE0QN/Q8X0Zg9pA9v+w
	 r6Jfa1YdGQXqw==
Date: Fri, 29 Nov 2024 10:50:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q7d7t5p3kze5urnx"
Content-Disposition: inline
In-Reply-To: <20241018130049.138775-4-biju.das.jz@bp.renesas.com>


--q7d7t5p3kze5urnx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
MIME-Version: 1.0

Hello,

as I already wrote in earlier revisions I find this driver complicated
and wonder if this is because the hardware is complicated or because the
driver adds unneeded complexity. So here come a few suggestions that
might seem to be trivial but IMHO simplify understanding the driver.

On Fri, Oct 18, 2024 at 02:00:44PM +0100, Biju Das wrote:
> [...]
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644
> index 000000000000..28ed39eecb93
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,473 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2024 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
> + *
> + * Limitations:
> + * - Counter must be stopped before modifying Mode and Prescaler.
> + * - When PWM is disabled, the output is driven to inactive.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
> + *   each HW channel have 2 IOs.
> + * - Each IO is modelled as an independent PWM channel.
> + * - When both channels are used, disabling the channel on one stops the
> + *   other.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +#include <linux/units.h>
> +
> +#define RZG2L_GET_CH(a)		((a) / 2)

The parameter is a hwpwm value. If you use "hwpwm" instead of "a" this
is directly obvious.

> +#define RZG2L_GET_CH_OFFS(i)	(0x100 * (i))

The parameter is a channel number, rename it to ch.

> +#define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
> +#define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
> +#define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
> +#define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
> +#define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
> +#define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (sub_ch))
> +#define RZG2L_GTPR(ch)		(0x64 + RZG2L_GET_CH_OFFS(ch))
> +
> +#define RZG2L_GTCR_CST		BIT(0)
> +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> +
> +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> +
> +#define RZG2L_GTUDDTYC_UP	BIT(0)
> +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> +#define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> +
> +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_GTIOx(a)	((a) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIOA)

sub_ch instead of a.

> +#define RZG2L_GTIOR_OAE		BIT(8)
> +#define RZG2L_GTIOR_OBE		BIT(24)
> +#define RZG2L_GTIOR_OxE(a)	((a) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
> +
> +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
> +#define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) | RZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(a) \
> +	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
> +	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
> +
> +#define RZG2L_MAX_HW_CHANNELS	8
> +#define RZG2L_CHANNELS_PER_IO	2
> +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
> +#define RZG2L_MAX_SCALE_FACTOR	1024
> +#define RZG2L_MAX_TICKS ((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
> +
> +struct rzg2l_gpt_chip {
> +	void __iomem *mmio;
> +	struct mutex lock; /* lock to protect shared channel resources */

Hmm, I nearly claimed you'd not need that lock since 1cc2e1faafb3 ("pwm:
Add more locking") but that doesn't cover ->request(). Probably that
should change. (i.e. no action item for you.)

> +	unsigned long rate_khz;
> +	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
> +	u32 user_count[RZG2L_MAX_HW_CHANNELS];

This tracks the count of requests per channel. So maybe call it
channel_request_count?

> +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];

channel_enable_count?

> +};
> [...]
> +/* Caller holds the lock while calling rzg2l_gpt_disable() */
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			      struct pwm_device *pwm)
> +{
> +	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
> +
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	rzg2l_gpt->enable_count[ch]--;
> +
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> +
> +	/* Disable pin output */
> +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0);
> +}
> +
> +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt, u32 val, u8 prescale)

Missing name prefix

> +{
> [...]
> +/* Caller holds the lock while calling rzg2l_gpt_config() */
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
> +	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
> +	u64 period_ticks, duty_ticks;
> +	unsigned long pv, dc;
> +	u8 prescale;
> +
> +	/* Limit period/duty cycle to max value supported by the HW */
> +	period_ticks = mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz, USEC_PER_SEC);
> +	if (period_ticks > RZG2L_MAX_TICKS)
> +		period_ticks = RZG2L_MAX_TICKS;
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and period

shared by the two IOs of a single channel?

> +	 * can NOT be modified when there are multiple channels in use with

multiple IOs?

> +	 * different settings.
> +	 */
> +	if (rzg2l_gpt->user_count[ch] > 1 && period_ticks < rzg2l_gpt->period_ticks[ch])
> +		return -EBUSY;
> +
> +	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> +	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> +
> +	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, USEC_PER_SEC);
> +	if (duty_ticks > RZG2L_MAX_TICKS)
> +		duty_ticks = RZG2L_MAX_TICKS;
> +	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period ticks
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->period_ticks[ch] = period_ticks;

Unless I'm missing something you might overwrite the value of the other
IO in the same channel here.

> +	/*
> +	 * Counter must be stopped before modifying mode, prescaler, timer
> +	 * counter and buffer enable registers. These registers are shared
> +	 * between both channels. So allow updating these registers only for the

both IOs?

> +	 * first enabled channel.
> +	 */
> +	if (rzg2l_gpt->enable_count[ch] <= 1) {
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> +
> +		/* GPT set operating mode (saw-wave up-counting) */
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_MD,
> +				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +		/* Set count direction */
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
> +
> +		/* Select count clock */
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
> +				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +
> +		/* Set period */
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
> +	}
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
> +
> +	if (rzg2l_gpt->enable_count[ch] <= 1) {
> +		/* Set initial value for counter */
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT(ch), 0);
> +
> +		/* Set no buffer operation */
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
> +
> +		/* Restart the counter after updating the registers */
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
> +				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> +	}

So you're not writing duty_cycle to hardware. Then you should check that
the actual value in use is <= the intended value as you did above with
period.

> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> [...]
> +	rstc = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc), "get reset failed\n");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "cannot get clock\n");
> +
> +	ret = devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return ret;
> +
> +	rate = clk_get_rate(clk);
> +	if (!rate)
> +		return dev_err_probe(dev, -EINVAL, "gpt clk rate is 0");
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rate > NSEC_PER_SEC)
> +		return dev_err_probe(dev, -EINVAL, "gpt clk rate is > 1GHz");
> +
> +	/*
> +	 * Rate is in MHz and is always integer for peripheral clk
> +	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
> +	 * So make sure rate is multiple of 1000.
> +	 */
> +	rzg2l_gpt->rate_khz = rate / KILO;
> +	if (rzg2l_gpt->rate_khz * KILO != rate)
> +		return dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000");
> +
> +	ret = reset_control_deassert(rstc);

Please move reset deassertion directly after
devm_reset_control_get_exclusive() that it can later be trivially
converted to devm_reset_control_get_exclusive_deasserted().
If you base the next revision on top of v6.13-rc1 you can also make use
of it already.

> +	chip->ops = &rzg2l_gpt_ops;
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");

nitpick: Can you make the error messages all start with a capital letter
please?

Best regards
Uwe


--q7d7t5p3kze5urnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdJjk8ACgkQj4D7WH0S
/k6oJQf+IiYwnvuuw1Zv8Er+qECgczQPVmCTaL+dGZTTJjN6irCVyZ/fDw1rrO3o
attpTBGUgYkcES0vy+mLb3gr9i72vK8a5ffiHvS0AKs9XC4wXRoa5MLstaLGkmwf
OvdCs3yugYDg45IywDwJnGbCAJba9uGEPqus4loRllFmbwvTxirrRWNvCGq8B4bA
uRepL9tQbz9G3pC9aqYfTicYW9oFBKPzkjIgbuJFIEZMvjnkDe/A9NHbjub9T1cb
h+dnx61gsWxP/DTmLTcLce/rxIn4H/cNMjJYDm6ESC4/UjpH5lRO9mAufORas7hc
0dgiQTNZsKpohwIrbnj8exO5giZqVg==
=0M3X
-----END PGP SIGNATURE-----

--q7d7t5p3kze5urnx--

