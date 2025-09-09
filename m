Return-Path: <linux-pwm+bounces-7279-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6CB500DF
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B4C4E234D
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A435085E;
	Tue,  9 Sep 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYh071Xa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81581341655;
	Tue,  9 Sep 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431165; cv=none; b=Qov9PplB0ya+50v/kadQw3mrWfuFq9SeXswRypBS2BWAYqY5ZXmIY7lq72p4RBcWtMBJGTn9U238ekDkVxpa4TdyocuBJecaN7OI9f/98+adk58ooQ+8gw+WGTYI9iplf0GDNUYTvgDWZxHSOwKq183YBZAVQfvYK30fK0CjRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431165; c=relaxed/simple;
	bh=7SRUwPA2a90ovbfGHKX8RU7Qb1UX5kf40ZeIxMT+cuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3keSjMhkXpxXCmaJ1Pg9a9HKX0Z1AiXLYGKQd+cZdUAe8eXt1cvg1rN8OflLrLls2FLzjU0JnJ7USTerUqMX2Zo+Sg2nLh3m3N9Ug55u0ozbGvfsCA86w3ou5KZER0kJS5/JKuuFV/3bivy6pE7BLZKaff2BNrtsqdyVJqJm2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYh071Xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB453C4CEF4;
	Tue,  9 Sep 2025 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757431165;
	bh=7SRUwPA2a90ovbfGHKX8RU7Qb1UX5kf40ZeIxMT+cuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYh071XaOmMZ0ZGhV+q1ZgRPB+JPzOGVc1kWEN9UY1RehmbgS0FExbtgwyeNkGAMr
	 YQHuYNyt12T9Jn3rXZjKYzH7AHBTPra4s/s+cDmquGPg71YdVv/2ku1CEeLRuOW5ry
	 hI6KV+3eP9Uz9kqCVWEkPCmSwXAS8LNetbBHNy6nQC4XuKDxWrWVfK8O9Z8z+KiBm7
	 OJ3HIkEw41bA7lMZ3Sk2QqRGD7DCv9Tti2QBDMvCdpzlDrlhSdTcp+1yyJjeiPFmBQ
	 15dsQyOK24y55zaN9mv9BFwcQiHRo/wyVZwgAywIro7l8NW3TBvd5b67QTQJRsZBhm
	 swMePAuoEGdlw==
Date: Tue, 9 Sep 2025 17:19:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Message-ID: <jb6vcdv3553kbvuzuxdmx7tyxcpmnkaqszks3n4apmt43an6d2@mr4lyezd5a7s>
References: <20250814115022.73732-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gccpacaxlk4o3gd3"
Content-Disposition: inline
In-Reply-To: <20250814115022.73732-1-biju.das.jz@bp.renesas.com>


--gccpacaxlk4o3gd3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
MIME-Version: 1.0

Hello Biju,

On Thu, Aug 14, 2025 at 12:50:20PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Convert the rzg2l-gpt driver to use the new callbacks for hardware
> programming.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped modifing hardware from .round_waveform_tohw() callback.
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 175 +++++++++++++++++++++---------------
>  1 file changed, 102 insertions(+), 73 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 360c8bf3b190..f0a8531457ca 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -86,6 +86,13 @@ struct rzg2l_gpt_chip {
>  	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
>  };
> =20
> +/* This represents a hardware configuration for one channel */
> +struct rzg2l_gpt_waveform {
> +	u32 gtpr;
> +	u32 gtccr;
> +	u8 prescale;
> +};
> +
>  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
>  {
>  	return pwmchip_get_drvdata(chip);
> @@ -190,8 +197,10 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip =
*rzg2l_gpt,
>  	/* Stop count, Output low on GTIOCx pin when counting stops */
>  	rzg2l_gpt->channel_enable_count[ch]--;
> =20
> -	if (!rzg2l_gpt->channel_enable_count[ch])
> +	if (!rzg2l_gpt->channel_enable_count[ch]) {
>  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> +		rzg2l_gpt->period_ticks[ch] =3D 0;
> +	}

I wonder if this is a fix that is orthogonal to the waveform conversion.
Shouldn't that be a separate commit?

>  	/* Disable pin output */
>  	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0=
);
> @@ -215,54 +224,37 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struc=
t rzg2l_gpt_chip *rzg2l_gpt,
>  	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
>  }
> =20
> -static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> -			       struct pwm_state *state)
> -{
> -	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -
> -	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> -	if (state->enabled) {
> -		u32 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> -		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> -		u8 prescale;
> -		u32 val;
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
> -		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> -		state->period =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val, p=
rescale);
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
> -		state->duty_cycle =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, va=
l, prescale);
> -		if (state->duty_cycle > state->period)
> -			state->duty_cycle =3D state->period;
> -	}
> -
> -	state->polarity =3D PWM_POLARITY_NORMAL;
> -
> -	return 0;
> -}
> -
>  static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)
>  {
>  	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * pr=
escale)),
>  		     U32_MAX);
>  }
> =20
> -/* Caller holds the lock while calling rzg2l_gpt_config() */
> -static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> -			    const struct pwm_state *state)
> +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
>  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
>  	u64 period_ticks, duty_ticks;
>  	unsigned long pv, dc;
> -	u8 prescale;
> +
> +	guard(mutex)(&rzg2l_gpt->lock);
> +	if (wf->period_length_ns =3D=3D 0) {
> +		*wfhw =3D (struct rzg2l_gpt_waveform){
> +			.gtpr =3D 0,
> +			.gtccr =3D 0,
> +			.prescale =3D 0,
> +		};
> +
> +		return 0;
> +	}
> =20
>  	/* Limit period/duty cycle to max value supported by the HW */
> -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz=
, USEC_PER_SEC);
> +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns, rzg2l_gpt->r=
ate_khz, USEC_PER_SEC);
>  	if (period_ticks > RZG2L_MAX_TICKS)
>  		period_ticks =3D RZG2L_MAX_TICKS;
>  	/*

The code that follows here needs adaption. Other than .apply(),
=2Eround_waveform_tohw() is supposed to not fail if the requested period
is too small but use the smallest possible value then (and return 1).

> @@ -277,13 +269,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
>  	}
> =20
> -	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> -
> -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks=
);
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> +	wfhw->gtpr =3D pv;
> +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_=
khz, USEC_PER_SEC);
>  	if (duty_ticks > period_ticks)
>  		duty_ticks =3D period_ticks;
> -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
> +	wfhw->gtccr =3D dc;
> =20
>  	/*
>  	 * GPT counter is shared by multiple channels, we cache the period ticks
> @@ -292,6 +285,58 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	 */
>  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
> =20
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_round_waveform_fromhw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const void *_wfhw,
> +					   struct pwm_waveform *wf)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	const struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +
> +	wf->period_length_ns =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, =
wfhw->gtpr,
> +								  wfhw->prescale);
> +	wf->duty_length_ns =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, wf=
hw->gtccr,
> +								wfhw->prescale);
> +	wf->duty_offset_ns =3D 0;
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   void *_wfhw)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +	u32 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 gtcr;
> +

Why does rzg2l_gpt_write_waveform() grab the lock but
rzg2l_gpt_read_waveform() doesn't?

> +	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm)) {
> +		gtcr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
> +		wfhw->prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
> +		wfhw->gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> +		wfhw->gtccr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
> +		if (wfhw->gtccr > wfhw->gtpr)
> +			wfhw->gtccr =3D wfhw->gtpr;
> +	}

If rzg2l_gpt_is_ch_enabled() returns false wfhw must still be
initialized, I guess using:

	*wfhw =3D (struct rzg2l_gpt_waveform) { };

Minor optimization: rzg2l_gpt_is_ch_enabled() reads RZG2L_GTCR(ch)
already, would be nice to only do it once.

> +	return 0;
> +}
> +
> +static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    const void *_wfhw)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	const struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +
> +	guard(mutex)(&rzg2l_gpt->lock);
>  	/*
>  	 * Counter must be stopped before modifying mode, prescaler, timer
>  	 * counter and buffer enable registers. These registers are shared
> @@ -310,14 +355,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> =20
>  		/* Select count clock */
>  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
> -				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
> =20
>  		/* Set period */
> -		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
>  	}
> =20
>  	/* Set duty cycle */
> -	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), wfhw->gtccr);
> =20
>  	if (rzg2l_gpt->channel_enable_count[ch] <=3D 1) {
>  		/* Set initial value for counter */
> @@ -326,44 +371,28 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		/* Set no buffer operation */
>  		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
> =20
> -		/* Restart the counter after updating the registers */
> -		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
> -				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> -	}
> -
> -	return 0;
> -}

=2Ewrite_waveform() must make sure to not disturb the other channel. So
this is the place where you need to check if the other channel relies on
the current value of global period (and fail with an error if yes and
the period value to write is different).

> -
> -static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> -			   const struct pwm_state *state)
> -{
> -	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -	bool enabled =3D pwm->state.enabled;
> -	int ret;
> -
> -	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> -		return -EINVAL;
> -
> -	guard(mutex)(&rzg2l_gpt->lock);
> -	if (!state->enabled) {
> -		if (enabled)
> -			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> -
> -		return 0;
> +		if (wfhw->gtpr)
> +			/* Restart the counter after updating the registers */
> +			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
> +					 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
>  	}
> =20
> -	ret =3D rzg2l_gpt_config(chip, pwm, state);
> -	if (!ret && !enabled)
> +	if (wfhw->gtpr && !rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm))
>  		rzg2l_gpt_enable(rzg2l_gpt, pwm);
> +	else if (!wfhw->gtpr && rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm))
> +		rzg2l_gpt_disable(rzg2l_gpt, pwm);
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static const struct pwm_ops rzg2l_gpt_ops =3D {
>  	.request =3D rzg2l_gpt_request,
>  	.free =3D rzg2l_gpt_free,
> -	.get_state =3D rzg2l_gpt_get_state,
> -	.apply =3D rzg2l_gpt_apply,
> +	.sizeof_wfhw =3D sizeof(struct rzg2l_gpt_waveform),
> +	.round_waveform_tohw =3D rzg2l_gpt_round_waveform_tohw,
> +	.round_waveform_fromhw =3D rzg2l_gpt_round_waveform_fromhw,
> +	.read_waveform =3D rzg2l_gpt_read_waveform,
> +	.write_waveform =3D rzg2l_gpt_write_waveform,
>  };
> =20
>  static int rzg2l_gpt_probe(struct platform_device *pdev)

Best regards
Uwe

--gccpacaxlk4o3gd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjARXcACgkQj4D7WH0S
/k5fywgAuLuZ6g035Sg2GPEF2mNJ63c14vvS+N+/5Zq7vq67wsoUvxQzm7lvGsHX
5Di09pkHcW3gQ2V4Hde12F/hW8Zd1K4stHJjDeL6rRtmHTdkzBb5JJe70Trw3ag4
glbBmlCji2V1HP4hTYGj2xz8lpJ4cTjc3pAK/pISDqBXOrH2W6QuH0JJ7lCpIeoT
VH03uTbRMOJ2kQHKP0AJTPUcc1lHyVCIxkfwvdmZPHUoMRk9mNVaOqbs3i02YLtx
yGoqCAR/PHBEUrpRIOJO29UNhUZr9NcslWr02xUDazk/x6TtHpFFgPGJz7wAvuq6
nwG9umfURLW8ivmkaziZ5uWsZuUcOQ==
=Z8q4
-----END PGP SIGNATURE-----

--gccpacaxlk4o3gd3--

