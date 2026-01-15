Return-Path: <linux-pwm+bounces-7907-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7206D23BD7
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 10:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F59302EF4C
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6F35F8AF;
	Thu, 15 Jan 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv0/ls4Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5A2DA77F;
	Thu, 15 Jan 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470760; cv=none; b=blpjZZNAWj8VMmbrEoFTyvJUrhSuo27rYfaMnj4cfgtt4yN/CVnfJ4efSQIgOl0IeE4NoNIMRQuX7dQBSYIs1nuNcv9G5zqLs1o3W69pceFTZeCm42AX0rBVcnAZ4xPs91GalvifyhabpyQrAAt95QsoLeQ58trBJiDgwcyuy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470760; c=relaxed/simple;
	bh=ie3TmYI5cr3rUG7dAH0RXadAUzvgEe3WDQN3llnpLt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4BJkwa/lJEvVw936VqKeuL3KiN8ZYdFfMTYbLyKc4UZv7+0Uti8aaZp5rZm5bf+H6D3UqionIg46859uZe71dIObu8kzSfxYBgqVG//8TW+1mbrOZwY3AIqnthpUrGn/GV2Bvpe9eoWEWJSXGrsOXD+W9fwqBZCwpqStJ3IoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv0/ls4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21F5C116D0;
	Thu, 15 Jan 2026 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470760;
	bh=ie3TmYI5cr3rUG7dAH0RXadAUzvgEe3WDQN3llnpLt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wv0/ls4QVoGKTVjl9268gU38Fsq3tsRrW5GWkUjGCnYiQEA6OOSlCDnor4N/1VZEn
	 TOVOvR2UEvVOVTMfIkJr5P7gnDHwIRlyMupn+fwLDzB84tt9UHqvHnkV3rw/3dmSwD
	 g+XSboVVh3kQdvS3fpkH++ASC7+f00PZZ7rXkrAQgt2ubr4Fsep1nDGhiz8YVkgp/o
	 7ke7bJu+9IIPRBfauFviJDV0QZ3nHX84SAUtb145+/zizpJh5OFylc176G/LveiZqA
	 bj/WsD57BqxTCGX76yNkW/cJnScyv28Q75bwZ6A5SGe6JbRQO1skknqev2S46mkPjA
	 gydloRM32hoiQ==
Date: Thu, 15 Jan 2026 10:52:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Message-ID: <elf2i3oefpflkcxup3howpikgwko6uvm5rkimqwyzhq35nwowk@vtdbe6ad4rkw>
References: <20251128103431.161591-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="limlu64r62pyvpna"
Content-Disposition: inline
In-Reply-To: <20251128103431.161591-1-biju.das.jz@bp.renesas.com>


--limlu64r62pyvpna
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
MIME-Version: 1.0

Hello Biju,

On Fri, Nov 28, 2025 at 10:34:29AM +0000, Biju wrote:
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
> +	bool is_small_second_period =3D false;
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
> @@ -278,21 +273,25 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
>  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> =20
> -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
>  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> -				return -EBUSY;
> +				is_small_second_period =3D true;
> =20
>  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
>  		}
>  	}
> =20
> -	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks=
);
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> +	wfhw->gtpr =3D pv;
> +	if (is_small_second_period)
> +		return 1;

Why don't you need to set .gtccr in this case? I think it's wrong, but
even if 0 is ok, please initialize the value explicitly.

> -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_=
khz, USEC_PER_SEC);
>  	if (duty_ticks > period_ticks)
>  		duty_ticks =3D period_ticks;

Orthogonal to this patch: The if condition can only become true if

	if (period_ticks > RZG2L_MAX_TICKS)
		period_ticks =3D RZG2L_MAX_TICKS;

triggered above, right? So maybe it's more natural to do

	if (duty_ticks > RZG2L_MAX_TICKS)
		duty_ticks =3D RZG2L_MAX_TICKS;

here, too?

> -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
> +	wfhw->gtccr =3D dc;
> =20
>  	/*
>  	 * GPT counter is shared by multiple channels, we cache the period ticks

Best regards
Uwe

--limlu64r62pyvpna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlouOMACgkQj4D7WH0S
/k6WJggArcDzWQgtRNk1bcgE5jTydUMbFwfJL+pJQpP23c5j5AV1LBE51i50ZWG1
e88gTlaBUf/KxpKbskpwtuJfmQ5IIxPLLQFLoekVEanWGK4mCv5LnZM40ZWHwbYC
x7giKZkMqDsfEzz2wGQyI6hWCyXvDAWbLyXXP3rLZgqsODCsOMk7f0nnspPNbRfT
VxBY9dOgNV4c6tGN0yAu7KEaVmfMk/gMAcwaB3YqPgqhOu45Ros7oBslKF2Mulia
d/yHyqLaqPm8pU5AmvIKJDawBiQoKoLI+UHaEuE4aKa0cCTmPPEDTAjBLWg3HFJL
OoovaotpQqJr8sUoSUpy8hrV8oO5Dg==
=6r58
-----END PGP SIGNATURE-----

--limlu64r62pyvpna--

