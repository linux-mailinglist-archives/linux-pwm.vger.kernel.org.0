Return-Path: <linux-pwm+bounces-4358-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57E9F2BAF
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2024 09:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D49A188511F
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97211FF61C;
	Mon, 16 Dec 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e12vIT85"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD491CEAC3;
	Mon, 16 Dec 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337387; cv=none; b=qGLrICWiWpBkXf+qkuiIjrTx5f4z3E8WQ+/7lDk26f+BEV1ZPYzu09/jG9wX1oVdaSduDLivydUytKTI2Lf2vttPxjPqnJiMnKb/cU0a7Z4MTp90yP8Ke4RaknVvSAU0Tm7cRgUmokqX2E909ar8ugJyTg2pi47nndaJOuZgW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337387; c=relaxed/simple;
	bh=vOCQPuexICPOQSuilzYyp/1Ex7qhBODA8YKKaZigSgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3hvVDKUYlB1pYNP8AHzdIgwbgCb71HshApRyt4qzFkwdwFoYHyRe851nGjYexATirg4iPrSmsadkbm5CN2U4fEKd684cjEcKKkrY7HXA4Tzx3XWxwfIQEp+S5s1KazroguBVEuXhnr3/Q9eLz9yc6/BaO8lr5OOsRjgJRrqxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e12vIT85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885F9C4CED0;
	Mon, 16 Dec 2024 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734337385;
	bh=vOCQPuexICPOQSuilzYyp/1Ex7qhBODA8YKKaZigSgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e12vIT85AtBLi/+MH997JfBhodHyWT+2POvUj+hV7NhjX5rp47oVnm+TTojt52OxH
	 pDLesVc/gN+RyMtGqQmSryHKsT6vSlC0qsLoSPp6aUVLc3w6OBU5EhYPfdMqlalrU6
	 /Kf49hNAhfDrI74hj4VeYQzJjnbLHJXBrdTKHoOWVZzEECYbFbjimcvnoaKzqUDrMZ
	 YAi00a/CZzkrCyFSNXSTkjZP5LFloECGG+ZpeyHDAQnKqmGlAeGDdvN27/AVpcpjPL
	 39ExDgxY8OYlfVrDW+9tW6rzAHKXi1WyyIwPQ6mIPJ5b78nZNiBrDcZMFlopJF/s74
	 sYZTnhiVbrsXw==
Date: Mon, 16 Dec 2024 09:23:03 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com, p.zabel@pengutronix.de, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] pwm: stm32: Add check for clk_enable()
Message-ID: <24zcihiin4lkfhahxmn4nx4t7v5hlvxhlcjzeyrz2kizcqkaop@b5yq44j4vozj>
References: <20241215224752.220318-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nx6agqcxa3ihyuxg"
Content-Disposition: inline
In-Reply-To: <20241215224752.220318-1-zmw12306@gmail.com>


--nx6agqcxa3ihyuxg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: stm32: Add check for clk_enable()
MIME-Version: 1.0

Hello,

On Sun, Dec 15, 2024 at 05:47:52PM -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.
>=20
> Fixes: 19f1016ea960 ("pwm: stm32: Fix enable count for clk in .probe()")
> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index b889e64522c3..b94d186e3c0c 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -858,8 +858,11 @@ static int stm32_pwm_probe(struct platform_device *p=
dev)
>  	chip->ops =3D &stm32pwm_ops;
> =20
>  	/* Initialize clock refcount to number of enabled PWM channels. */
> -	for (i =3D 0; i < num_enabled; i++)
> -		clk_enable(priv->clk);
> +	for (i =3D 0; i < num_enabled; i++) {
> +		ret =3D clk_enable(priv->clk);
> +		if (ret)
> +			return ret;
> +	}

I wondered for some time if we could still improve more here. If the
(say) second clk_enable() or devm_pwmchip_add() fails, the clk_enable()
calls are leaked. However disabling the clk also might have downsides
(as it might stop a running PWM). OTOH the only expected failure point
is the first clk_enable() as the following are just software operations
and devm_pwmchip_add() only fails on memory pressure. So proper cleanup
doesn't really matter.

So I think the patch is fine as is and I will apply it.

Best regards
Uwe

--nx6agqcxa3ihyuxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdf41wACgkQj4D7WH0S
/k7llwf/UiLvKJ4m+BX9uZ9YkHIcbQ5Y9akNESa58tdAXToIePTuElL94I9wcLtr
jyU3+IZmgT0FaQ6kfIlkt87oM/owomEUiXSmE9KCZdoNJVb8cx1rPHGocbE3xB6d
2YSpQyi1yoybKbSl/32eFuKREaZC1K2kd0PA1lu7S4rpMhfUVBF5fa1z+gfV9XYQ
0l8KoryMUslshBYLYK4Jt8fcWm62JTCC9kHmpmAhUQOYHP7kRu2HTwyBtLwqIL+1
rGTpleh6Y1MNAeWx9oCFhaL5Cb+T1JFJWbaQpX+hFaIGghLacIh41JhCzDwPiqjs
Sc298uJWaEPzq1vJv/Oo7qr94cDNZA==
=NnDg
-----END PGP SIGNATURE-----

--nx6agqcxa3ihyuxg--

