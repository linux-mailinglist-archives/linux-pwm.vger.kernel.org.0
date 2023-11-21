Return-Path: <linux-pwm+bounces-114-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7F7F307B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3281C2159A
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1C854F8A;
	Tue, 21 Nov 2023 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WBLejFVG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4710E3;
	Tue, 21 Nov 2023 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1700576165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y2eCk+RDK6SxObHRv6P0nLQfbjaMAqY+HZL8M9E6T8w=;
	b=WBLejFVGoktRatbwuEXx0uYPGTmqGhm/Z2GEwJzSv7VNtnBZ/U4YpgVE9VPmD9rorjWv0M
	RjebljtH3buCX1NRHqmi0/59QxxtIF2m6mnoxWXOFGPwKmcfqT795Fo6o1qZXCcSgtfuPv
	7z4BJhbz4nQLEGcy/sJXxv6jxABAoww=
Message-ID: <57204b6f7b771b10691a18ca9f82e274bb3511d1.camel@crapouillou.net>
Subject: Re: [PATCH v3 062/108] pwm: jz4740: Make use of
 devm_pwmchip_alloc() function
From: Paul Cercueil <paul@crapouillou.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, 
	kernel@pengutronix.de
Date: Tue, 21 Nov 2023 15:16:03 +0100
In-Reply-To: <20231121134901.208535-63-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
	 <20231121134901.208535-63-u.kleine-koenig@pengutronix.de>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Uwe,

Le mardi 21 novembre 2023 =C3=A0 14:50 +0100, Uwe Kleine-K=C3=B6nig a =C3=
=A9crit=C2=A0:
> This prepares the pwm-jz4740 driver to further changes of the pwm
> core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> =C2=A0drivers/pwm/pwm-jz4740.c | 18 ++++++++----------
> =C2=A01 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 555c2db3968d..84ad5c3eb599 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -25,14 +25,13 @@ struct soc_info {
> =C2=A0};
> =C2=A0
> =C2=A0struct jz4740_pwm_chip {
> -	struct pwm_chip chip;

Ah, nevermind my previous comment on patch [014/108] then.

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> =C2=A0	struct regmap *map;
> =C2=A0	struct clk *clk[];
> =C2=A0};
> =C2=A0
> =C2=A0static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip
> *chip)
> =C2=A0{
> -	return container_of(chip, struct jz4740_pwm_chip, chip);
> +	return pwmchip_priv(chip);
> =C2=A0}
> =C2=A0
> =C2=A0static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned
> int channel)
> @@ -222,6 +221,7 @@ static const struct pwm_ops jz4740_pwm_ops =3D {
> =C2=A0static int jz4740_pwm_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> =C2=A0	struct jz4740_pwm_chip *jz;
> =C2=A0	const struct soc_info *info;
> =C2=A0
> @@ -229,10 +229,10 @@ static int jz4740_pwm_probe(struct
> platform_device *pdev)
> =C2=A0	if (!info)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	jz =3D devm_kzalloc(dev, struct_size(jz, clk, info->num_pwms),
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> -	if (!jz)
> -		return -ENOMEM;
> +	chip =3D devm_pwmchip_alloc(dev, info->num_pwms,
> struct_size(jz, clk, info->num_pwms));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	jz =3D to_jz4740(chip);
> =C2=A0
> =C2=A0	jz->map =3D device_node_to_regmap(dev->parent->of_node);
> =C2=A0	if (IS_ERR(jz->map)) {
> @@ -240,11 +240,9 @@ static int jz4740_pwm_probe(struct
> platform_device *pdev)
> =C2=A0		return PTR_ERR(jz->map);
> =C2=A0	}
> =C2=A0
> -	jz->chip.dev =3D dev;
> -	jz->chip.ops =3D &jz4740_pwm_ops;
> -	jz->chip.npwm =3D info->num_pwms;
> +	chip->ops =3D &jz4740_pwm_ops;
> =C2=A0
> -	return devm_pwmchip_add(dev, &jz->chip);
> +	return devm_pwmchip_add(dev, chip);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct soc_info jz4740_soc_info =3D {


