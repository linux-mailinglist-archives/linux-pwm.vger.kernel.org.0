Return-Path: <linux-pwm+bounces-4929-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3759AA37C81
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 08:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E23A8A74
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9523192D80;
	Mon, 17 Feb 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz/n9El0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842E1922F3;
	Mon, 17 Feb 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778579; cv=none; b=rDUtLoVY0Z7J78KmRSsq3eEkZRXFqBoGAYYyGUNJV1u2NIyhYIKV9veyL/5QrTTbYITyQJnsxv+YDnXOpJ0gpSKo6eUix1BjtdOe9REPmiOZpwBtTxTST0BdDKXfR0fEmo78iFAL0DMsVsBq8z14wri8OK8rjz+EQw6b9I8ee0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778579; c=relaxed/simple;
	bh=16vj36Lgwd2wcpLYZYILJJ2i3EUzlfBHM+5zf2X9BEo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=jyudvH9eqeoxY2sYQAdIDSDzbpPcQbVUrT11t1r19wOPZxCeCu8YkdPYqhSY6XUBVEneJqvvFAYOdCtrx5/ccvv7nz8sWbUjDKSkedS+HPAOu8OckYPDJzT5ZHqI16Tcr1L9wjMezEMErSGpNlhNBcUpfhNogZdurb/uGmmSa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz/n9El0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F094FC4CED1;
	Mon, 17 Feb 2025 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739778579;
	bh=16vj36Lgwd2wcpLYZYILJJ2i3EUzlfBHM+5zf2X9BEo=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=gz/n9El09XA1b66t36s/zgS4N3j5iSykcC18LX4iLY54hWCM/LI0ofNFS8rJwYxJ2
	 NL+oKt0phr9uxNYaxSORuvfoDtARxHSjuqQvAhy5wICxwpdjjE0srVeWm/du+c2FzU
	 wuSKpGWDGyp004aTWxZxKlfteJoRTUyQU1K26tmPsL4/heVXoZQSIODE+TpfL0Zrdt
	 wcSRX5qZpnRa8/pylC/EtlQkeRVt4j/rfOvHshuSLIRVFM3jVlE35JVr1LlusCYb+C
	 HJf/bPO6g8a0y5XXZUwjOO6QrxYn8mpwndOhcY8ywNDu0RRi49XOLp9aTx5SnVW1+r
	 AivTKhGGJtyaA==
Content-Type: multipart/signed;
 boundary=d86e9473d3daa6c97c74ffc63e11b90ba2941869ba77179fbdee0053404e;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 17 Feb 2025 08:49:35 +0100
Message-Id: <D7UK17VYQYF1.1MBG6HEHPVXN3@kernel.org>
Subject: Re: [PATCH 06/14] gpio: regmap: use value returning setters
Cc: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, "Bartosz Golaszewski"
 <bartosz.golaszewski@linaro.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Bamvor Jian Zhang" <bamv2005@gmail.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Keerthy"
 <j-keerthy@ti.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
 <20250211-gpio-set-retval-v1-6-52d3d613d7d3@linaro.org>
In-Reply-To: <20250211-gpio-set-retval-v1-6-52d3d613d7d3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

--d86e9473d3daa6c97c74ffc63e11b90ba2941869ba77179fbdee0053404e
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Feb 11, 2025 at 1:09 PM CET, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has additional variants of the set(_multiple)
> driver callbacks that return an integer to indicate success or failure.
> Convert the driver to using them.

Great!

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-regmap.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 05f8781b5204..e3b4e392549b 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -81,22 +81,25 @@ static int gpio_regmap_get(struct gpio_chip *chip, un=
signed int offset)
>  	return !!(val & mask);
>  }
> =20
> -static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
> -			    int val)
> +static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
> +			   int val)
>  {
>  	struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
>  	unsigned int base =3D gpio_regmap_addr(gpio->reg_set_base);
>  	unsigned int reg, mask;
> +	int ret;
> =20
>  	gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);

reg_mask_xlate() might fail. Please also check the return code.

>  	if (val)
> -		regmap_update_bits(gpio->regmap, reg, mask, mask);
> +		ret =3D regmap_update_bits(gpio->regmap, reg, mask, mask);
>  	else
> -		regmap_update_bits(gpio->regmap, reg, mask, 0);
> +		ret =3D regmap_update_bits(gpio->regmap, reg, mask, 0);
> +
> +	return ret;
>  }
> =20
> -static void gpio_regmap_set_with_clear(struct gpio_chip *chip,
> -				       unsigned int offset, int val)
> +static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
> +				      unsigned int offset, int val)
>  {
>  	struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
>  	unsigned int base, reg, mask;
> @@ -107,7 +110,7 @@ static void gpio_regmap_set_with_clear(struct gpio_ch=
ip *chip,
>  		base =3D gpio_regmap_addr(gpio->reg_clr_base);
> =20
>  	gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);

same same :)

-michael

> -	regmap_write(gpio->regmap, reg, mask);
> +	return regmap_write(gpio->regmap, reg, mask);
>  }
> =20
>  static int gpio_regmap_get_direction(struct gpio_chip *chip,
> @@ -266,9 +269,9 @@ struct gpio_regmap *gpio_regmap_register(const struct=
 gpio_regmap_config *config
>  	chip->free =3D gpiochip_generic_free;
>  	chip->get =3D gpio_regmap_get;
>  	if (gpio->reg_set_base && gpio->reg_clr_base)
> -		chip->set =3D gpio_regmap_set_with_clear;
> +		chip->set_rv =3D gpio_regmap_set_with_clear;
>  	else if (gpio->reg_set_base)
> -		chip->set =3D gpio_regmap_set;
> +		chip->set_rv =3D gpio_regmap_set;
> =20
>  	chip->get_direction =3D gpio_regmap_get_direction;
>  	if (gpio->reg_dir_in_base || gpio->reg_dir_out_base) {


--d86e9473d3daa6c97c74ffc63e11b90ba2941869ba77179fbdee0053404e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ7LqDxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j86QGAwDBn6Kej4A5j4gOWk1KOBtlcmqgeC1Gl
Vtt0s14ztQFI5UPjGylsHI36EVvshxiqAX44PdCssuN28N44thtgDtPBt5w+J2wp
OKFwk+m+4zjM94X+cYtJxwNt9NL6aoQB8To=
=WujZ
-----END PGP SIGNATURE-----

--d86e9473d3daa6c97c74ffc63e11b90ba2941869ba77179fbdee0053404e--

