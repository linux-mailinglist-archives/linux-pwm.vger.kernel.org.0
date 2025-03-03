Return-Path: <linux-pwm+bounces-5055-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE00A4CEAD
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 23:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC73169D01
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F601F12EE;
	Mon,  3 Mar 2025 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj80RDLK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6CEC4;
	Mon,  3 Mar 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042004; cv=none; b=Y6sf7TABLyH8DR8FX6v5xPfRIW+SUOr2Q+aWaORfah+t/8EUW3FXXPxJc0RKTIHHVl6j+/xJGVpNjxmcBx/hgExxpEQ2Kn1AGPVN17lDQNjgMZnSczp/D0XnMEhm08BVwcUOpuBE+WSdkfQ7Mkj2BMN2IYuvv5JYAgVNmYwZqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042004; c=relaxed/simple;
	bh=OW5D+p+/vduzBlWS3j6sL24B87Evh3Ge81TPLw8Nuls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC8is+Nvj0ilYcwLcez69wzx4SC61mdo3e7NIRSFsxaBXCg/w/iCjA8S8zpLHCVfIulZ1T6Bz2qVaXEQRfGRlF/zmPhh2bp+jgnp308CvmIQayTaBlxgC+Hou534FsLhwqlCsUr9Kwae+50ZKuumN6bAzi4B/EdVDetC725o/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj80RDLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A159C4CED6;
	Mon,  3 Mar 2025 22:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042003;
	bh=OW5D+p+/vduzBlWS3j6sL24B87Evh3Ge81TPLw8Nuls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yj80RDLKKAlItSxFxz/tavuWKeTcL4wFMO3pcUjc1eJkryWusxiwJbiCU8DR4JY/c
	 AbSKlq1+rDe3faQnVCPpVqJ5vtGZtSIPNW0fBb9ox8oyObdR2yiK0OGj3AgRHFK5T3
	 E9Vl3YXSFcwI2rW9UGncLRB1j4UcfKCYAqX98b4kVo3JFWJLS4ZOHg8wusCXTQ94mX
	 GP3ovEiwZVGHToZMsqdGwQaVXsq4FRQe1DUyqhDx8m4A3gePVRkfawpb3fA8GN1u8g
	 qs2gTchu9Jhu5g1STeTpsCUcljIA6zk6Q67dihWXBB3dOLJvrh1pvTNItIhkpHwDCA
	 1RZR5SBjHTTkA==
Received: by venus (Postfix, from userid 1000)
	id 19FCF1806F5; Mon, 03 Mar 2025 23:46:41 +0100 (CET)
Date: Mon, 3 Mar 2025 23:46:40 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for normal PWMs
Message-ID: <h2ipg2qfr7sjpasxxxhmular6fileku3lhrzamvuk6ltzr4fvp@4na3kpmhcmsp>
References: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
 <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-1-62703c0ab76a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqwo236sf227nizw"
Content-Disposition: inline
In-Reply-To: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-1-62703c0ab76a@linaro.org>


--xqwo236sf227nizw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for normal PWMs
MIME-Version: 1.0

Hi,

On Mon, Mar 03, 2025 at 01:52:50PM +0200, Abel Vesa wrote:
> Ideally, the requested duty cycle should never translate to a PWM
> value higher than the selected resolution (PWM size), but currently the
> best matched period is never reported back to the PWM consumer, so the
> consumer will still be using the requested period which is higher than
> the best matched one. This will result in PWM consumer requesting
> duty cycle values higher than the allowed PWM value.
>=20
> In case of normal PWMs (non Hi-Res), the current implementation is
> capping the PWM value at a 9-bit resolution, even when the 6-bit
> resolution is selected.
>=20
> Fix the issue by capping the PWM value to the maximum value allowed by
> the selected resolution.
>=20
> Fixes: 7a3350495d9a ("leds: rgb: leds-qcom-lpg: Add support for 6-bit PWM=
 resolution")
> Suggested-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
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
> index 4e5c56ded1f0412c9913670699e912b24f3408bd..4454fc6a38480b61916318dd1=
70f3eddc32976d6 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -533,7 +533,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, u=
int64_t duty)
>  		max =3D LPG_RESOLUTION_15BIT - 1;
>  		clk_rate =3D lpg_clk_rates_hi_res[chan->clk_sel];
>  	} else {
> -		max =3D LPG_RESOLUTION_9BIT - 1;
> +		max =3D BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;
>  		clk_rate =3D lpg_clk_rates[chan->clk_sel];
>  	}
> =20
>=20
> --=20
> 2.34.1
>=20

--xqwo236sf227nizw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfGMUkACgkQ2O7X88g7
+ppe6A//bmFPDK8S9OKGe9vWPeq76fum0q/zWVog39gSifCJV0gdgXmMnv3nqnW7
70TDNOaHiZHGLdH04txxuSfivSpM0/q8U8a/Ils3JldLs7JXzDPKAfXCqIbQhiik
JsCMf9CcdezSj5jcRxBIEz9IXfJx3uy4KKJK2Iyz8AJWnyG2TKLTgYBIwxCExowN
jmRmJES9R4qK3k8HFCMU1rU5zizb6vcOIYjhuzWI88xhD5Z2QCdGuoPGd8AmZFbT
CAx08AY7yzC1OJUd4dJSwQxFMaHXgc5UyMzYJ+uLMKvwqAEfAMGYhVHBTb0XxCji
P81sl6MRyHBApZlhtw48Wz1RwG2JnEfqQXGQydCLx1+i/Bkp9Bn5ofNwvi/wC87n
qKJSdnDKClEVMEEz6+tk5NlhIoLnQyWelhLzYozw0vEAf639t7+pjf2kGypv0lWY
HweBk5WyuEwydLuc/Jf0i1NBCLWMpHt84QgorYr+vai87gaovcRGsLHvhujQLnjw
kG2+VM8M3xk67lb74ggKJhYEFr2iPHW5we3kyN6eiiz5SznSodhXK3iSinlNJz3+
QQfnrucH86osNA/o/SJBDd/okQsaYJOzA6nuu3q1kJlSqYCd53US4j/Fe9lVrwDj
tj4/hW94osfUfepUPa9jwL2Rl7gRV0Fln99sVZqXdGw3gS1haPw=
=UN9N
-----END PGP SIGNATURE-----

--xqwo236sf227nizw--

