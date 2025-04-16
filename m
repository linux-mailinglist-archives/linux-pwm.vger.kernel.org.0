Return-Path: <linux-pwm+bounces-5512-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C36A8AFA5
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 07:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEE63BB1E5
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 05:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA2229B36;
	Wed, 16 Apr 2025 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Aih0xs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E6E571;
	Wed, 16 Apr 2025 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781062; cv=none; b=FC+2FT9zAI8Wo+makn7rGgQ8UAI0/yAHfL3C230l0uaSGJ4E28139fwfgFkARURAghJcbBmo3mVoZEvrjPacKhrhpRNULAZXjlIEtkCZo0ZOZB2+6KX9hdZXTWfur4uYvD82xoeJFrFJHOet0a8WczOD3+bgDB3xPhOzYjn+b/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781062; c=relaxed/simple;
	bh=cKllk8vD4eaxEJ2Tc4nn29nj7GJhMYpArHkxkZWFHqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQh22BMUeOZlTy6BQ7xe1e4/wtXfZ7519tpPuRpPrXUNmSNWymAiyuBXEpBBXH3I0B6RjHLH3SP85iTy2mEjDX5IqNkGzT+W8OMUdClkyNlV7R27aR3Okg0FWpIajCQhi6lQlhxk3PV3dwxKmSUvIS2Rljwp0Qu1J6B7U3siUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Aih0xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F7BC4CEE2;
	Wed, 16 Apr 2025 05:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744781062;
	bh=cKllk8vD4eaxEJ2Tc4nn29nj7GJhMYpArHkxkZWFHqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/Aih0xsdUZ4w+dvVu9dR2anmJdnujUqE99aZDXHW6BnTkzeTq9+FvKzD5j0+lR0C
	 HrXlYpyi+3sySf+rmNZ2igqpL+lDyGH4W34iq7OgUFzw0cDOn19V8zr+dp3YN4sJDT
	 GmOvftUtjP+rk3qTHexjHMqLzR6gdeSLtzcBWysiFDBbZ5k/Kfrh8Ocu4Yhvjh4mWT
	 DS1/Zkjn79eGrcq6cCTO/xLi2V8TW/aiSxdySu9QfxFD8g1znpLhUgOzyLL5PcUydm
	 kqLjAmQdVxhftdj8KGmsxwxIxh42cpHBXMQtYYhf5McBqLEdtY2pEp76VWRplBJXzs
	 YoO3IHD6kcLBQ==
Date: Wed, 16 Apr 2025 07:24:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Juxin Gao <gaojuxin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] pwm: loongson: Fix an error code in probe()
Message-ID: <7apoevpcxrsi7u345otb6cna3k3khhiwlmoitgilu6f3bv6mtb@jdvlox57u3cu>
References: <6965a480-745c-426f-b17b-e96af532578f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqula3fkor7hottj"
Content-Disposition: inline
In-Reply-To: <6965a480-745c-426f-b17b-e96af532578f@stanley.mountain>


--mqula3fkor7hottj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH next] pwm: loongson: Fix an error code in probe()
MIME-Version: 1.0

Hello Dan,

On Wed, Apr 09, 2025 at 02:00:20PM +0300, Dan Carpenter wrote:
> There is a copy and paste bug so we accidentally returned
> PTR_ERR(ddata->clk) instead of "ret".
>=20
> Fixes: 322fc380cea1 ("pwm: Add Loongson PWM controller support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/pwm/pwm-loongson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> index 412c67739ef9..e31afb11ddd7 100644
> --- a/drivers/pwm/pwm-loongson.c
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -211,7 +211,7 @@ static int pwm_loongson_probe(struct platform_device =
*pdev)
>  	if (ddata->clk) {
>  		ret =3D devm_clk_rate_exclusive_get(dev, ddata->clk);
>  		if (ret)
> -			return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +			return dev_err_probe(dev, ret,
>  					     "Failed to get exclusive rate\n");
> =20
>  		ddata->clk_rate =3D clk_get_rate(ddata->clk);

How embarrassing that I didn't spot that during review. Thanks for the
fix!

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with Binbin's Reviewed-by tag.

Best regards
Uwe

--mqula3fkor7hottj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf/Pv8ACgkQj4D7WH0S
/k4RNQf8Cc3mcurLaW/Yv9UGm/iXtfVECvExlonj8/rQA0LyWM4zuns7YsA0olfZ
uJhCsED71FCS6yfbh2lplRjK8Znh241XQg/A5WoUW4/KIV7iUX4DlU+bkLofYvE4
A0xtgtId1t6q/C5xuiweOBJjIT+kzn6fJpiKlQ6O2cZTSnPO7hi8NK1dPi2Z4DLb
AIN6gIrq0/uhGJd6SST2m8/9+6YJ8tKSXSH+/XUuDjloHoE11d8C+d5xOE4b3mTM
9va96XUQAP6ky3XtExiHadlosqpnYxZ7iOWZrARYmAkHLBREpwjmnKWQ1cb5OatY
VLE9FsdIE31LqaxRjknt9lZOQjBnJw==
=aE/z
-----END PGP SIGNATURE-----

--mqula3fkor7hottj--

