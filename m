Return-Path: <linux-pwm+bounces-5057-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC81A4CEB6
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 23:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3395D18909C3
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DE91F03D4;
	Mon,  3 Mar 2025 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCPbq3TF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F01EEA2A;
	Mon,  3 Mar 2025 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042053; cv=none; b=kyqWHJEtAq3PJWqKNxjBijjNEYzYVnBbOab3tqfdQiYuE5+El8rkKKC5fcVXca+F5Vo/QXz6dRgQAOglf1Y802JElPmx6PX1szNmtqZepjWkFWrumBur+wiBPn8BAxHr5YavjhmnpB62J3KP9gdryuyvPpyZ4OfCPVPESHaj0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042053; c=relaxed/simple;
	bh=wKdg7KORP/wHWURGAJFZ2Y8n8FL65o9Ik3M+IG4bka4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLj4Md46vgvPBGk7VSDOHbRXQxwxrem0nlvyeg6Ca7/B6YGu7+eNidEtI1brw2mcPgzZ8B0oG1mLuB8Qo096F3xnbcQyQp7DzPHlc2MiHIuHq+SmgiI2URNTrH5hshuE/yHr7aNtWx2ZDH38i0+qDMeDPfis9O3WGtBXczkeotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCPbq3TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26810C4CED6;
	Mon,  3 Mar 2025 22:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042053;
	bh=wKdg7KORP/wHWURGAJFZ2Y8n8FL65o9Ik3M+IG4bka4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCPbq3TFGrB0DCgSPIq9EzJ7cA2PwqDTKlAD34aJSfhLncJf5pS3w5EGa2bDxzPKq
	 2qZdfU0WuwAMiKS864cuMmFwzEPdAMhPQ94F/H8dETNbBU7yPGOlIlFA7ikd14SS4E
	 5VHM1GN5X1zWc7tOG8dO6bpLk1Nzl5/GTA+fUbpPqY+khU7IoxGltbxeiyRWUDMApD
	 LB6z7AJKs8DM9aM1GmcIJv6SKh4sJ0Je9ww/y1MEZDhvm2htVIZbYaDt7gMCTSoYTE
	 gfoO4f9EW2Qn1II3T34SD/NwuqAirE1gMH/GVx48gfsXkcHGaBf1kAFHJn2bs1PZca
	 f1JOR8Y08W1NQ==
Received: by venus (Postfix, from userid 1000)
	id 3952A1806F5; Mon, 03 Mar 2025 23:47:31 +0100 (CET)
Date: Mon, 3 Mar 2025 23:47:31 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] leds: rgb: leds-qcom-lpg: Fix calculation of best
 period Hi-Res PWMs
Message-ID: <7cm7ccorawh3nzjhnqaohzoaggxjdne7fdhr6uniljq7ly7vri@fkkgiu3quqwz>
References: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
 <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-3-62703c0ab76a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqdunyfqhcqswvjm"
Content-Disposition: inline
In-Reply-To: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-3-62703c0ab76a@linaro.org>


--mqdunyfqhcqswvjm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] leds: rgb: leds-qcom-lpg: Fix calculation of best
 period Hi-Res PWMs
MIME-Version: 1.0

Hi,

On Mon, Mar 03, 2025 at 01:52:52PM +0200, Abel Vesa wrote:
> When determining the actual best period by looping through all
> possible PWM configs, the resolution currently used is based on
> bit shift value which is off-by-one above the possible maximum
> PWM value allowed.
>=20
> So subtract one from the resolution before determining the best
> period so that the maximum duty cycle requested by the PWM user
> won't result in a value above the maximum allowed.
>=20
> Cc: stable@vger.kernel.org    # 6.4
> Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high reso=
lution PWM")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

Greetings,

-- Sebastian

>  drivers/leds/rgb/leds-qcom-lpg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index 0b6310184988c299d82ee7181982c03d306407a4..4f2a178e3d265a2cc88e651d3=
e2ca6ae3dfac2e2 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -462,7 +462,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, ui=
nt64_t period)
>  		max_res =3D LPG_RESOLUTION_9BIT;
>  	}
> =20
> -	min_period =3D div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0=
]),
> +	min_period =3D div64_u64((u64)NSEC_PER_SEC * ((1 << pwm_resolution_arr[=
0]) - 1),
>  			       clk_rate_arr[clk_len - 1]);
>  	if (period <=3D min_period)
>  		return -EINVAL;
> @@ -483,7 +483,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, ui=
nt64_t period)
>  	 */
> =20
>  	for (i =3D 0; i < pwm_resolution_count; i++) {
> -		resolution =3D 1 << pwm_resolution_arr[i];
> +		resolution =3D (1 << pwm_resolution_arr[i]) - 1;
>  		for (clk_sel =3D 1; clk_sel < clk_len; clk_sel++) {
>  			u64 numerator =3D period * clk_rate_arr[clk_sel];
> =20
> @@ -1292,7 +1292,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  		if (ret)
>  			return ret;
> =20
> -		state->period =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (1 << resolutio=
n) *
> +		state->period =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * ((1 << resoluti=
on) - 1) *
>  						 pre_div * (1 << m), refclk);
>  		state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value *=
 pre_div * (1 << m), refclk);
>  	} else {
>=20
> --=20
> 2.34.1
>=20

--mqdunyfqhcqswvjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfGMYIACgkQ2O7X88g7
+prDYQ//UUIJKGGJcyRkqdJOJy9kE4w3t0E7ZywEWGqYO0m6ErRDcfs8MSCSwj+9
+YQA9WXS/HZs24lo66MTIDAiB8xSiQBxH6fdTG+cFmooW5rKqt8Xmo8GDdgSiv26
MobNhvf28N5DbRJQz6C+KsVwiBBLjW67m/ZoFMHO4L0sRg8jpbeEqKseHWGCrrcW
wCM5cQIq+IZuksQKzvzHM66oqcgvO802TcbZYN95/PXdZRHXhays/G90uCHCzU6l
Xl4FK1n2xrBzz99ZchFkeVu/G2Gja4Cth077tjSPmUTBzqvkK5X0o7RJfHOw0b14
4qS0kR/vnjvkySuwdLgZ59Oa9efirknz18mvO7mzy/wAjHaTOj5aCeyIzZ4NGFFr
VlXnrlQz1W4P6+hGf38X3V/Kd7rKTFC+Stx+wcFvkRmPjHSdeqqEdQEhsPjopJwm
Vub2aA45WPKItetuYwYdDgAVp2tWIUNIl5SKFx3Iw0FzR6osOlEu96sYEJIEtIX8
ZIB4zZPhkyokZTWkSAd09uFzRpbaLAQZyCBMc4NA4C0wKQXhhfvCO7TYWHMs8ZMt
7Uam/avcRQLSAGOtWIpYAL7WySWOIrFBe8NO9QRbMcZ/1LfVfsgxmR6ekeTdAUWJ
Em9R0ADPU/eeNkBxf7rxpRj8BHSFIXr4WezakGvrxjDn3nFXamc=
=lnHF
-----END PGP SIGNATURE-----

--mqdunyfqhcqswvjm--

