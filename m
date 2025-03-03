Return-Path: <linux-pwm+bounces-5058-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5984A4CEBF
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 23:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F356916A9C7
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 22:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E023A58E;
	Mon,  3 Mar 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ/rfuXD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D701EEA2A;
	Mon,  3 Mar 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042132; cv=none; b=LTe90wFjMBrttFPvyHKmxiUTael4jxqno2b2mYJs1W8ZjsQOrXhLiHEbJrAuwt0PhHRmZSK4cJQmA1XWhnin+K0vunECQPPbdugC51hl9FEmClNhFUJCcSLGoQO6qfcPWtZqVQodMJL0ppwQoywSuxeNR7giNO5KkPNAxMniiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042132; c=relaxed/simple;
	bh=GnbaYekVw85/VbcANlfgwrZzx2IeqHp4aJLvmUvw2xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6b3rqiM+rDQcAFsw2NB5hZwwBzUK0YN8xIw6ZTSC4Wl3ZKqpjHIN/oLAvl3XyO1c8tnCSA0VYtiRV1sQ7Y5jkSBE1AOC4/UgL8y54kpR/rGqyprcpBk63ySOBP4XpduHAKHSG3qO7yKGGI0ND+hrMWH+P6hf67UzrjwfFV5R5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ/rfuXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59117C4CED6;
	Mon,  3 Mar 2025 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042132;
	bh=GnbaYekVw85/VbcANlfgwrZzx2IeqHp4aJLvmUvw2xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZ/rfuXD/mBuSA4qcQc7ihXo2Lgu8KVIunW4ROx+hjX3+MOSZuDQS2GfRPxyG/8pK
	 BK3arwj/JqVmeReRAtpkU7SujfM5aclRzPTrcs9BWH9wxmZQFLZAkSE6UBMWM5ky7G
	 NLD9wEN7h75a5iamcHckW54dt1CA2bcygnJRWHxQvpMR3YWPd2FpV8Y0/LF6Gs9oqD
	 FAS+2nN9yK051Zawt3eJS3fy8c7IpRs5ZuPvuSnE82/b2yfo1mT4hY0gOUQx2RnL4H
	 eBztQlWHdH/W3lpv+Sl/olOHOF8ZRbcwQt2i2gf/x9umGENzPHiQMki0b4JiXnsURd
	 gVOSYAIQ+UQRA==
Received: by venus (Postfix, from userid 1000)
	id 62D3A1806F5; Mon, 03 Mar 2025 23:48:50 +0100 (CET)
Date: Mon, 3 Mar 2025 23:48:50 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Message-ID: <kucfjwsrj5gxfhqle7d4h5kzzaxhepx4fmlh2z63vrxquke7kb@dfuobfamrcp2>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="olgaxtlp6pq7hjzm"
Content-Disposition: inline
In-Reply-To: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>


--olgaxtlp6pq7hjzm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
MIME-Version: 1.0

Hi,

On Mon, Mar 03, 2025 at 06:14:36PM +0200, Abel Vesa wrote:
> Currently, the implementation computes the best matched period based
> on the requested one, by looping through all possible register
> configurations. The best matched period is below the requested period.
> This means the PWM consumer could request duty cycle values between
> the best matched period and the requested period, which with the current
> implementation for computing the PWM value, it will result in values out
> of range with respect to the selected resolution.
>=20
> So change the way the PWM value is determined as a ratio between the
> requested period and duty cycle, mapped on the resolution interval.
> Do this in contrast to using the register configuration selected when
> the best matching period was determined.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> This patch is based on the following patchset:
> https://lore.kernel.org/all/20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-=
v3-0-62703c0ab76a@linaro.org/
> ---

Tested-by: Sebastian Reichel <sre@kernel.org>

Greetings,

-- Sebastian

>  drivers/leds/rgb/leds-qcom-lpg.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index 4f2a178e3d265a2cc88e651d3e2ca6ae3dfac2e2..80130c205dce7c6ae1c356b7a=
7c5f6460a2b0bb0 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -523,8 +523,10 @@ static int lpg_calc_freq(struct lpg_channel *chan, u=
int64_t period)
>  	return 0;
>  }
> =20
> -static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
> +static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty, uint6=
4_t period)
>  {
> +	const unsigned int *pwm_resolution_arr;
> +	unsigned int step;
>  	unsigned int max;
>  	unsigned int val;
>  	unsigned int clk_rate;
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
> =20
>  	chan->pwm_value =3D min(val, max);
>  }
> @@ -829,7 +833,7 @@ static void lpg_brightness_set(struct lpg_led *led, s=
truct led_classdev *cdev,
>  			lpg_calc_freq(chan, NSEC_PER_MSEC);
> =20
>  			duty =3D div_u64(brightness * chan->period, cdev->max_brightness);
> -			lpg_calc_duty(chan, duty);
> +			lpg_calc_duty(chan, duty, NSEC_PER_MSEC);
>  			chan->enabled =3D true;
>  			chan->ramp_enabled =3D false;
> =20
> @@ -906,7 +910,7 @@ static int lpg_blink_set(struct lpg_led *led,
>  		chan =3D led->channels[i];
> =20
>  		lpg_calc_freq(chan, period);
> -		lpg_calc_duty(chan, duty);
> +		lpg_calc_duty(chan, duty, period);
> =20
>  		chan->enabled =3D true;
>  		chan->ramp_enabled =3D false;
> @@ -1241,7 +1245,7 @@ static int lpg_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  		if (ret < 0)
>  			goto out_unlock;
> =20
> -		lpg_calc_duty(chan, state->duty_cycle);
> +		lpg_calc_duty(chan, state->duty_cycle, state->period);
>  	}
>  	chan->enabled =3D state->enabled;
> =20
>=20
> ---
> base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
> change-id: 20250303-leds-qcom-lpg-compute-pwm-value-using-period-0823ceb7=
542a
>=20
> Best regards,
> --=20
> Abel Vesa <abel.vesa@linaro.org>
>=20

--olgaxtlp6pq7hjzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfGMdEACgkQ2O7X88g7
+pqzkQ/9GUNGTPSFiWQGET1AZGNzBn6xUZp1b4qtnWvv7VasoPqLxTJnIT3yS9yD
dgP8/tmkFASk/ffO3UKQY1KSvlKljJ2j02fjibHlICgTbM7MYgC8sS4wt7+BAAAR
xXSgJs06Wfnk6pPYC0YwD/R9XE2EuieCiWGyhAmhfC0eThqu6zF59FZPdGU/PyaG
B2siUoWR0Z4oT7oPRDRdo0J/zpKr/5raLSqgGqStNc+Yy0DnWsK8nXjTMjBcFGLL
TQibyrP/8/ADa85aEqN/ucRAWgO9NVtX6H0JaDdKstJzw/AEspmjIPtKl6S8k1Ob
324hA5sd7PW9W6a22udEBdb4WoX3uSWKfZAyACblLI1DtyAWjnI07XikBHbGoNFR
V5jE84ZwvkCmby1XQxVX/XJPloAdWPgrtkL+cDP+oBBiJwlG4LDY34aRo89jAxOf
vv6vQCwXhRDMBndjXtw/MIDjLq4yfoO296WSeuh5dSOibHwSEsx6SOBeIkAQOGbk
4jukxnb0d8XqzolRzB1szFitYfWC2yi4uLd6tvC02uuKtNUgpWEsG9JPoYP757NM
qE+nVpYoV51vvsy6+IBs0ErnDcc6VIR/ie2M2X7D3Dl+fZQ2JModE56HiBHBWtLt
W2d1yw8r42z/uzPBRL8aQUfsEXf5oH7bgRwDfChc0+EaYwUaR4w=
=PQY7
-----END PGP SIGNATURE-----

--olgaxtlp6pq7hjzm--

