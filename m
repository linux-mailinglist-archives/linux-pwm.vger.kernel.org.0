Return-Path: <linux-pwm+bounces-2380-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19865900A35
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAA51F23428
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E819A29F;
	Fri,  7 Jun 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="u4LKJjnM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFF1991C6;
	Fri,  7 Jun 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777299; cv=none; b=FM8B6mcCwO03Zq1yeadapu+HeO91qni/BzZMrAxRqSk6mkqtpiIp/toT8koO9AINbHNCxJYn4E0kkT8jiUCkfXIw1WR80YsD1VKFMIopg9Wv3rYyH9LlcVbehk4JxVS8BOORGuJBxLTqZaZg1aurgths7qmx9fuJxC6hgO6FgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777299; c=relaxed/simple;
	bh=aQXTonn+rCEvnOa03Z5Pbq/BMr7MESN8eypXAa2XNdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2EJGyu8Z5sSKFCq+4Advxe823L9WXN3DVKrfAQu0NVIFSM3EgE8PF9wBN/rjeLEE7cdvQxqaaOQitRjtN7Y6bGZOpkMuIJBrIWNbVTCgfV4nzgLRnCE9IR+cTpL/V3azAWBw8Tr9xkXqgyNQotMZEbKE1OPU+XFQxg8X1rVuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=u4LKJjnM; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1717777295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dFKzEmzfIFXqH+040GCz1074H3PC/FG49nbXpt318BQ=;
	b=u4LKJjnMrgGYf2qgIiLnWUepxK4HkkLek8QZUKsWcWBiactcmsoXPIBYqAzkDscSoD7Gm9
	HTGhNMMRzza+NJcK3rTZupVyCDp0rFbd3wP8RcZ2rAn485zMQ0TmTsl7+x/Om1FbzLM78+
	007tcxTcdEs/clafrWKvg5WWqg2L94Q=
Message-ID: <625c57a75902797952b915640e0013ad11ac8c96.camel@crapouillou.net>
Subject: Re: [PATCH 1/2] pwm: jz4740: Another few conversions to
 regmap_{set,clear}_bits()
From: Paul Cercueil <paul@crapouillou.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@baylibre.com>
Cc: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 07 Jun 2024 18:21:34 +0200
In-Reply-To: <20240606164047.534741-5-u.kleine-koenig@baylibre.com>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
	 <20240606164047.534741-5-u.kleine-koenig@baylibre.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFC
 qaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IWYXnd
 JO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN70
 62DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOt
 X0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEA
 AYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/
 Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmc
 Gu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2z
 McLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/
 7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2c
 LUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Uwe,

Le jeudi 06 juin 2024 =C3=A0 18:40 +0200, Uwe Kleine-K=C3=B6nig a =C3=A9cri=
t=C2=A0:
> Similar to commit 7d9199995412 ("pwm: jz4740: Use
> regmap_{set,clear}_bits") convert two more regmap_update_bits() calls
> to
> regmap_{set,clear}_bits() which were missed back then.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Thanks!

Cheers,
-Paul

> ---
> =C2=A0drivers/pwm/pwm-jz4740.c | 9 ++++-----
> =C2=A01 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index da4bf543d357..6bdb01619380 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -201,12 +201,11 @@ static int jz4740_pwm_apply(struct pwm_chip
> *chip, struct pwm_device *pwm,
> =C2=A0	 * state instead of its inactive state.
> =C2=A0	 */
> =C2=A0	if ((state->polarity =3D=3D PWM_POLARITY_NORMAL) ^ state-
> >enabled)
> -		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm-
> >hwpwm),
> -				=C2=A0=C2=A0 TCU_TCSR_PWM_INITL_HIGH, 0);
> +		regmap_clear_bits(jz->map, TCU_REG_TCSRc(pwm-
> >hwpwm),
> +				=C2=A0 TCU_TCSR_PWM_INITL_HIGH);
> =C2=A0	else
> -		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm-
> >hwpwm),
> -				=C2=A0=C2=A0 TCU_TCSR_PWM_INITL_HIGH,
> -				=C2=A0=C2=A0 TCU_TCSR_PWM_INITL_HIGH);
> +		regmap_set_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
> +				TCU_TCSR_PWM_INITL_HIGH);
> =C2=A0
> =C2=A0	if (state->enabled)
> =C2=A0		jz4740_pwm_enable(chip, pwm);


