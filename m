Return-Path: <linux-pwm+bounces-5056-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F57A4CEB1
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 23:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF3618921A0
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF9236A8E;
	Mon,  3 Mar 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKkabPod"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB51F152E;
	Mon,  3 Mar 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042020; cv=none; b=diKcj5WMFlmeMpLgdg4L6d5qx6RmmcSI7nj4oBx7dkJdNVjaBOL7w5uZfqUIzTc5G1qUaupsMFcySXaa4mcFjyHmIJaoMhjWBxOnplhHHwAFgi19HC1hFiPKBw4kaZTHo0swzo9tw4kxMNBGBqnxSayKcD4n3WLwRTWeUZEskpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042020; c=relaxed/simple;
	bh=XrgMmmLBSJBNDJB74r0tYuLE+5OLBOGXNzybRIycscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESrXxECd6QNhr1GCYm3m+KgaxK11McFRIfONNnRbmELSHYJgpROiz2QjumbY0GlY5cnNBqwKmv+hNTPTIYB5Sf8EYybELzmCxvUguat8G2LvFUXo8wr6TNmAwK4cDmclPSHVld7cLBSHAP9stQTt6TM3Y87pjWxs6Pa++9+HYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKkabPod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9362C4CED6;
	Mon,  3 Mar 2025 22:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042020;
	bh=XrgMmmLBSJBNDJB74r0tYuLE+5OLBOGXNzybRIycscU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKkabPodNNtbwweUV4eR9u+XXVLYlVG/qW9ZHV/FLyi+0sIWn8owdkD9lUP5N+pqb
	 ZZsVs+jetRu5z4yY57lFydNFC4WaMg+4q42I3c0QoqdaOtUCqYvcwxPeFYepxQlnn5
	 mjH4h17XAYRhEi7Mf13yUOJBT9spuVNOhP9wfTkzmHts/MGGyRtBU/4BQOKnGF7mZm
	 mfCeXvEGM3+fFiSZwQEo63uUQVIQLG8UvSYquXgKPmuKa+s2m8z3Imc/9zyqzYs3kM
	 xAb/DFqWKX9Tn+LzBZ8s6a5jatfISsgaP6ghazxuDH6j87aXoxv3to9okrg/MiKk1D
	 DbrL0Z7NQhtLA==
Received: by venus (Postfix, from userid 1000)
	id D8FA61806F5; Mon, 03 Mar 2025 23:46:57 +0100 (CET)
Date: Mon, 3 Mar 2025 23:46:57 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for Hi-Res PWMs
Message-ID: <oqaw3v4dvht56ukirszu6g7shnltoep2r5wjdcvrmiax3qwqtc@y3bcaxkcwvic>
References: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
 <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-2-62703c0ab76a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2s3ziy7qtd6awmj"
Content-Disposition: inline
In-Reply-To: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-2-62703c0ab76a@linaro.org>


--f2s3ziy7qtd6awmj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for Hi-Res PWMs
MIME-Version: 1.0

Hi,

On Mon, Mar 03, 2025 at 01:52:51PM +0200, Abel Vesa wrote:
> Ideally, the requested duty cycle should never translate to a PWM
> value higher than the selected resolution (PWM size), but currently the
> best matched period is never reported back to the PWM consumer, so the
> consumer will still be using the requested period which is higher than
> the best matched one. This will result in PWM consumer requesting
> duty cycle values higher than the allowed PWM value.
>=20
> In case of Hi-Res PWMs, the current implementation is capping the PWM
> value at a 15-bit resolution, even when the lower resolutions are
> selected.
>=20
> Fix the issue by capping the PWM value to the maximum value allowed by
> the selected resolution.
>=20
> Cc: stable@vger.kernel.org    # 6.4
> Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high reso=
lution PWM")
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

Greetings,

-- Sebastian

>  drivers/leds/rgb/leds-qcom-lpg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index 4454fc6a38480b61916318dd170f3eddc32976d6..0b6310184988c299d82ee7181=
982c03d306407a4 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -530,7 +530,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, u=
int64_t duty)
>  	unsigned int clk_rate;
> =20
>  	if (chan->subtype =3D=3D LPG_SUBTYPE_HI_RES_PWM) {
> -		max =3D LPG_RESOLUTION_15BIT - 1;
> +		max =3D BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
>  		clk_rate =3D lpg_clk_rates_hi_res[chan->clk_sel];
>  	} else {
>  		max =3D BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;
>=20
> --=20
> 2.34.1
>=20

--f2s3ziy7qtd6awmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfGMWEACgkQ2O7X88g7
+poS4Q//XCnMIwfQbRG5zVWAD6v/GZ5zdz4B5CqpkKuR9b++G9ySjLhjZvRWmWYu
vAxtIJj0P1RR2SiBm7EkYolQ2Sn4V/FXIoG9t4cIAOxl9l5Qmz0wGBzifKao5GST
8Mlws/NDBZZPxbgCEj8B4pMzMWB7qDabf29/77r5ht6q9JLDLzocZYeNREtAlPyn
HygqsjBO5SA4qOU0Cx57Z2WvnX9kM1o2h012xI9I6UMgP3+z4BZU35GpfT60JNSB
jrxmGqkBrR5GEYiMiV6ADQ+WUNrJ3CF+DLO8EQpv3F3QWvznWlhdwaO1JMciBeUN
NWzwXXjtshkW6lzrZCgkht6lWDfCEP0klvVKHVUkMu19Ut+4WgfyX4TQU7d5Illb
pW7z0xOwc5rccn6qIV5xe7gQ5Y6Pah8EEuh+7gviPkITOhrnBI+WgXL6XgmUXjY5
MzrfQsPHNXnzs+hOvKEsKUxW0w0gfCvLUQVA2GO1oXFMYZ/CbQwFcf77U+VtfdHU
I127qP3CKOtnpcomtwm3lG/IPVrDsF546RT/xjl1lRjlVslZOCZwBnyUsZPDiT9j
QYcqNXn06A3wyPqWGGDsQ6Sfm/HGmh+Z17Mv+k2mZfNCdzAlmMV+EavbT6qVfpj1
vMwggUmXNz4U7n77CKFjF5rkCJra1ngjjpUg/9VBjPGOAralybg=
=c+B5
-----END PGP SIGNATURE-----

--f2s3ziy7qtd6awmj--

