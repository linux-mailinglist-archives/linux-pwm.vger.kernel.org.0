Return-Path: <linux-pwm+bounces-5059-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFCA4D3CF
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 07:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A4718849DD
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 06:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52D1F4CA2;
	Tue,  4 Mar 2025 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoBWsxyS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B61F0E44;
	Tue,  4 Mar 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069476; cv=none; b=R0PkY2TmUO2fq5jq5OYrafr063fyMTiHRIIHMnXmiq9Qc4IILWOj4KH5/Z+otsUxUO27F06ODyc7agp3Emkc4Pbwd6zqs5s/xT8FgCS4dAZkNT2RBD1CDYskEDLpXC1iRIInvRpvv35yumS1lzfNG2S4SShFkFAFedlxT9eDO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069476; c=relaxed/simple;
	bh=Cw2QMKf7IVdFrql9kCVeyibfjjY320rrDvX0qGCRrOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAXEHcfMhZE6yStzKaAx512BJQrrT+0w+e5UoZlrhnIOnZ1T9w819hIjb0tSgjfU9qu3W6Mxn0xXRfdYgRBvtvFcM0fJ+WEwIWZ6NxeGnFwbXVwsCaSPBfjyy/LSLO+tr01SblcLZp6attMeqDH0byR54l6rN3CIw8A+U7/2moU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoBWsxyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB80C4CEE5;
	Tue,  4 Mar 2025 06:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741069475;
	bh=Cw2QMKf7IVdFrql9kCVeyibfjjY320rrDvX0qGCRrOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VoBWsxyS69IbVZjPON2snq5rAqVG5F02DqwMi5jtruO627eyqhQ8oswEoxraNywI5
	 uE4GtFcQUktKV9nPU26LsbtHLRhzBoKEN0WnPh+Ru+rqIbU/BTVm9+dTXyCh+BZVHT
	 Te7xzawilBlQGijRI7YasMQTM38x/8Ev6oS7NL/0ysfkXcbYTq3OPrb/L+jl3+HaLt
	 p1iUEnGI6IomoeDFFupHeHqwjIkp3xITDtvE8RZsB+0qr2CfjepxvQVg287ZJ519nc
	 1TYNRpz4Ri6Asx/AHDBj2Zao4AZMxrfafZFF1TOScfG7/jzTqxeuoVZRpR26z2ICpN
	 aEg2nRwragKIg==
Date: Tue, 4 Mar 2025 07:24:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Kamal Wadhwa <quic_kamalw@quicinc.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Message-ID: <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbhjmniybhvgywki"
Content-Disposition: inline
In-Reply-To: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>


--bbhjmniybhvgywki
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
MIME-Version: 1.0

Hello Abel,

On Mon, Mar 03, 2025 at 06:14:36PM +0200, Abel Vesa wrote:
> Currently, the implementation computes the best matched period based
> on the requested one, by looping through all possible register
> configurations. The best matched period is below the requested period.

The best matched period *isn't above* the requested one. An exact match
is fine.

> This means the PWM consumer could request duty cycle values between
> the best matched period and the requested period, which with the current
> implementation for computing the PWM value, it will result in values out
> of range with respect to the selected resolution.

I still don't understand what you mean with resolution here.

I guess you spend some time understanding the workings of the driver and
you also have an example request that results in a hardware
configuration you don't like. Please share the latter to a) support your
case and b) make it easier for your reviewers to judge if your change is
indeed an improvement.

> So change the way the PWM value is determined as a ratio between the
> requested period and duty cycle, mapped on the resolution interval.

Is the intention here that (for the picked period) a duty_cycle is
selected that approximates the requested relative duty_cycle (i.e.
=2Eduty_cycle / .period)?

If it's that: Nack. This might be the right thing for your use case, but
it's wrong for others, it complicates the driver because you have spend
more effort in the calculation and (from my POV even worse) the driver's
behaviour deviates from the usual one for pwm drivers. I admit there are
some other lowlevel pwm drivers that are not aligned to the procedure I
described that should be used to determine the register settings for a
given request. But I target a common behaviour of all pwm drivers
because that is the only way the pwm API functions can make a promise to
its consumers about the resulting behaviour. Reaching this is difficult,
because some consumers might depend on the "broken" behaviour of a given
lowlevel driver (and also because analysing a driver to check and fix
its behaviour is an effort). But "fixing" a driver to deviate from the
declared right behaviour is wrong and includes all downsides that make
me hesitate to align the old drivers to the common policy.

The policy to pick a hardware setting is a compromise between consumer
needs and what is straight forward to implement for (most) hardware
drivers. Please stick to that. If you want more flexibility and
precision in your consumer, please consider converting the pwm driver to
the waveform API.

> [...]
> @@ -532,13 +534,15 @@ static void lpg_calc_duty(struct lpg_channel *chan,=
 uint64_t duty)
>  	if (chan->subtype =3D=3D LPG_SUBTYPE_HI_RES_PWM) {
>  		max =3D BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
>  		clk_rate =3D lpg_clk_rates_hi_res[chan->clk_sel];
> +		pwm_resolution_arr =3D lpg_pwm_resolution_hi_res;
>  	} else {
>  		max =3D BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;
>  		clk_rate =3D lpg_clk_rates[chan->clk_sel];
> +		pwm_resolution_arr =3D lpg_pwm_resolution;
>  	}
> =20
> -	val =3D div64_u64(duty * clk_rate,
> -			(u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div_sel] * (1 << chan->pre=
_div_exp));
> +	step =3D div64_u64(period, max);
> +	val =3D div64_u64(duty, step);

Such a pair of divisions is bound to loose precision. I didn't try to
determine values that can happen in practise here, but consider:

	period =3D  999996
	max =3D     500000
	duty =3D    499998

The exact value for val is 250000. However with integer division you
get 499998. What you can do about that is calculating

	val =3D duty * max / period

instead which gives you a more exact result. The challenge here however
is that the multiplication might overflow. If you know that the result
fits into a u64, mul_u64_u64_div_u64() is the function that gets this
right for you.

>  	chan->pwm_value =3D min(val, max);
>  }
> [...]
> ---
> base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3

My git repo doesn't know that commit. Given that you said your patch
bases on that other series, this isn't surprising. Please use a publicly
available commit as base parameter, otherwise you (and I) don't benefit
=66rom the armada of build bots because they just silently fail to test in
this case.

Best regards
Uwe

--bbhjmniybhvgywki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfGnJ0ACgkQj4D7WH0S
/k5KZAf+IDkU8qVALy67hx3Bo7niiC7euPqxcaUR1ldvxfDzaz6Hzrs7M2nQZDJR
fbSgqJZmAZipYMQ5hCh60TfNYzCC8TyDRuuyoyg1voI9IjPvP4LGua+j9UzybNfV
qzBLgsDnH6h0H5TytGpo7nlS763cx4Z2BFZjZ/tWFnGFLZHs6dNycGU0nVke/KMZ
czytn2zdyxSrdFbmjJWhHFVc7YVTyZWEXcs/LPrKgg2lwZSFtchmqPwI9cq9q5jC
VbfrmOdW9fFtOADyLQw3t27IvwA/FCB3bbx6yWIEHcalnGZvxyhuk7WZtbsq6isT
l2Qh4EzEq1jVCkLJb6sx7bM0sdBvwQ==
=kD8J
-----END PGP SIGNATURE-----

--bbhjmniybhvgywki--

