Return-Path: <linux-pwm+bounces-113-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E707F3073
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58C3B21201
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990F54F82;
	Tue, 21 Nov 2023 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="YO373uGf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4201F10CB;
	Tue, 21 Nov 2023 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1700576044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QBM7Xf6lZJfKnQQGMsbzOKEQni0yAfnHUbfp1xPNIjE=;
	b=YO373uGfr6wdoinqJdzuuY+wVRpwd01cx5BbFL0irDyfnIOoAj20toWoTLBTsuPccTgipq
	SVcC+6OVluvd9JhPQoe732D2RNTEIOAiVblGApK5QKqe0h3POIs2lEveB28FuRZ/MVfDj5
	tLFpunBaaII6SaSkqzCgegaZlvV1g+U=
Message-ID: <ba21c20b20364a39d5ffff81dac8bd300a746dbb.camel@crapouillou.net>
Subject: Re: [PATCH v3 014/108] pwm: jz4740: Make use of pwmchip_parent()
 macro
From: Paul Cercueil <paul@crapouillou.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, 
	kernel@pengutronix.de
Date: Tue, 21 Nov 2023 15:13:58 +0100
In-Reply-To: <20231121134901.208535-15-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
	 <20231121134901.208535-15-u.kleine-koenig@pengutronix.de>
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

Le mardi 21 novembre 2023 =C3=A0 14:49 +0100, Uwe Kleine-K=C3=B6nig a =C3=
=A9crit=C2=A0:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the macro
> provided for exactly this purpose.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> =C2=A0drivers/pwm/pwm-jz4740.c | 17 ++++++++---------
> =C2=A01 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index e9375de60ad6..555c2db3968d 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -35,13 +35,12 @@ static inline struct jz4740_pwm_chip
> *to_jz4740(struct pwm_chip *chip)
> =C2=A0	return container_of(chip, struct jz4740_pwm_chip, chip);
> =C2=A0}
> =C2=A0
> -static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
> -				=C2=A0=C2=A0 unsigned int channel)
> +static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned
> int channel)
> =C2=A0{
> =C2=A0	/* Enable all TCU channels for PWM use by default except
> channels 0/1 */
> -	u32 pwm_channels_mask =3D GENMASK(jz->chip.npwm - 1, 2);
> +	u32 pwm_channels_mask =3D GENMASK(chip->npwm - 1, 2);
> =C2=A0
> -	device_property_read_u32(jz->chip.dev->parent,
> +	device_property_read_u32(pwmchip_parent(chip)->parent,
> =C2=A0				 "ingenic,pwm-channels-mask",
> =C2=A0				 &pwm_channels_mask);

You could have used pwmchip_parent(&jz->chip) and not change the
prototype.

But the patch is tiny enough that I don't really care, so:

Acked-by: Paul Cercueil <paul@crapouillou.net>

> =C2=A0
> @@ -55,14 +54,14 @@ static int jz4740_pwm_request(struct pwm_chip
> *chip, struct pwm_device *pwm)
> =C2=A0	char name[16];
> =C2=A0	int err;
> =C2=A0
> -	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
> +	if (!jz4740_pwm_can_use_chn(chip, pwm->hwpwm))
> =C2=A0		return -EBUSY;
> =C2=A0
> =C2=A0	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
> =C2=A0
> -	clk =3D clk_get(chip->dev, name);
> +	clk =3D clk_get(pwmchip_parent(chip), name);
> =C2=A0	if (IS_ERR(clk))
> -		return dev_err_probe(chip->dev, PTR_ERR(clk),
> +		return dev_err_probe(pwmchip_parent(chip),
> PTR_ERR(clk),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get clock\n");
> =C2=A0
> =C2=A0	err =3D clk_prepare_enable(clk);
> @@ -149,7 +148,7 @@ static int jz4740_pwm_apply(struct pwm_chip
> *chip, struct pwm_device *pwm,
> =C2=A0	 */
> =C2=A0	rate =3D clk_round_rate(clk, tmp);
> =C2=A0	if (rate < 0) {
> -		dev_err(chip->dev, "Unable to round rate: %ld",
> rate);
> +		dev_err(pwmchip_parent(chip), "Unable to round rate:
> %ld", rate);

While you're at it - and if you need a v4 - maybe sneak in a \n there?

> =C2=A0		return rate;
> =C2=A0	}
> =C2=A0
> @@ -170,7 +169,7 @@ static int jz4740_pwm_apply(struct pwm_chip
> *chip, struct pwm_device *pwm,
> =C2=A0
> =C2=A0	err =3D clk_set_rate(clk, rate);
> =C2=A0	if (err) {
> -		dev_err(chip->dev, "Unable to set rate: %d", err);
> +		dev_err(pwmchip_parent(chip), "Unable to set rate:
> %d", err);

And there.

> =C2=A0		return err;
> =C2=A0	}
> =C2=A0

Cheers,
-Paul

