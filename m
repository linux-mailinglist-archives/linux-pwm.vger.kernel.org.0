Return-Path: <linux-pwm+bounces-4027-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAD9BAFAE
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 10:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA52E1C217C7
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08301AF0A3;
	Mon,  4 Nov 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LmAnGfsA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAE1AE850
	for <linux-pwm@vger.kernel.org>; Mon,  4 Nov 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712733; cv=none; b=JxtSc43Wiawkdt0TV9KwrCBK4hSeuehM1zWqlNMiYIcxZxVQDSoOm2STdBO7YSl8Wo5UagDdXLot1cU+21dTBRl28DuMUQDVWHsCz2NaVy/UTaMxPbJkXAy2qG5fLnzqq/NgRRa/kJYttSXon9G7SNO/Tk/77ezTfg6lkRnm58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712733; c=relaxed/simple;
	bh=TEkDXrS8YIglkAk6IOTynHBlviIaMox5IezVFdA6KO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWj/8bcyyLEmwPrdg/JHWpVt3emLs7SsSNPntvcifFt54tAMYHdc7U73bAJNN0fv45P6vLaL0iXm1+rfDWX1Ud52y9867hf+FhPhat1imy70YCnYWz3XHfBg3JYrvttK5qkLAnblA/IOaOVowX4XfWU53bYM3oTz+kAH94JrFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LmAnGfsA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99ebb390a5so913452366b.1
        for <linux-pwm@vger.kernel.org>; Mon, 04 Nov 2024 01:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730712728; x=1731317528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBT4omu7lVco4BMm5XUNG7vIgR1mZZtpzsVwZM90Y7U=;
        b=LmAnGfsAbFLPvy20FN7ubJ8Cjl9BaH7TqBYYtj7EIOrhVzRS9bAQIhuQJxbQHpeeQZ
         W99U5yF1FRD/NNo5Jxyezfh6TSrHE/qsTkXIsyURT7WR66YEWLNypPM9EGzgtlOhBWwT
         iALgR1HikB21AYOWXm+jV47U/IEnHm9B+TjG+pjMjtjnqNNnnHZ8RNorNnKmML4ksAx+
         kTYsi2wpXpVYpCKJsW8+6CT1JbdGCOlgKWxe91vQoOf7Yw2yPbJdwmFSOFdvwfaDnDB+
         3Wh1o6WKXS8+r/3jP5lN+/fLa7sCHbEARuSHyXiDDZ3uxT4DiH719LsetluZW/oUZrjy
         h4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712728; x=1731317528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBT4omu7lVco4BMm5XUNG7vIgR1mZZtpzsVwZM90Y7U=;
        b=nU0YRa+1/VdqyJkNxI5MaMfHV+HUMSNYoQRcpoDICO844oji1+6+vfEe61SZNy3FE4
         YYrIJfnwNg7nXogi/bUqbBGv6U1mz6X6wuOeYFVL+ZUnToUl4QaAzWd8RYISfbetPq8W
         xFi+9X1JIdzYsWO0yM3OpkrBlW51G9wHE/wpxQE/tfqmg/gtIrLReMcyjGUqQGeQVRd2
         91OxF3tl+0aMeIdWJou4jXy69eiB50rY9LS0y2o0pZgo3Me+snBKZ3fKyj29vOTa5sYC
         sXDtzcoDiAjQoMy0InwKrXaI5MSCi1AOsu5gGszfLKenX/G8Sme3wTIAwNyrePP9sR0E
         sAmA==
X-Forwarded-Encrypted: i=1; AJvYcCWReZndnYRkEbysYNwTpLMXJOQQHIdf5K8eAhh8VnUbgO+W/vbYuRdsiKJ49L4r9gtRI+S4p9AIumo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0uO8BWn5XJu0ql92m62gPkpGnepKTaQyaLqVaQrE9Iqhr8wua
	8dK/zqpOOOhMx7G37oDI0aNjV3LrRz2GJZqf492rz62MWkVooM65TdgnpX3VH+4=
X-Google-Smtp-Source: AGHT+IFP7uDPMOtcJPWpn+z+rM3OxxIslWfpFco2yog0FSQmlxVhhiL3Isz0ruKyu2Q9v3QrVvfTVw==
X-Received: by 2002:a17:907:86a6:b0:a9a:bbd1:aa5 with SMTP id a640c23a62f3a-a9e65499cdfmr911473866b.31.1730712728095;
        Mon, 04 Nov 2024 01:32:08 -0800 (PST)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c53d6sm530652866b.68.2024.11.04.01.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:32:07 -0800 (PST)
Date: Mon, 4 Nov 2024 10:32:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v2 2/4] pwm: meson: Support constant and polarity bits
Message-ID: <w3igi2jmva6mfa7anlieyp3iiwfzhsvi3t37wwcqqtzdy42fqn@btmdsfsmpw7r>
References: <20241016152553.2321992-1-gnstark@salutedevices.com>
 <20241016152553.2321992-3-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rn6i6zl2o5dcpxg"
Content-Disposition: inline
In-Reply-To: <20241016152553.2321992-3-gnstark@salutedevices.com>


--3rn6i6zl2o5dcpxg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] pwm: meson: Support constant and polarity bits
MIME-Version: 1.0

Hello George,

there are two minor things I dislike in this patch/driver. But I'm not
sure the alternatives are objectively considerably better. See below and
judge yourself.

On Wed, Oct 16, 2024 at 06:25:51PM +0300, George Stark wrote:
> Newer meson PWM IPs support constant and polarity bits. Support them to
> correctly implement constant and inverted output levels.
>=20
> Using constant bit allows to have truly stable low or high output level.
> Since hi and low regs internally increment its values by 1 just writing
> zero to any of them gives 1 clock count impulse. If constant bit is set
> zero value in hi and low regs is not incremented.
>=20
> Using polarity bit instead of swapping hi and low reg values allows to
> correctly identify inversion in .get_state().
>=20
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>  drivers/pwm/pwm-meson.c | 63 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 2ef632caebcc..974c3c74768c 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -6,7 +6,7 @@
>   * PWM output is achieved by calculating a clock that permits calculating
>   * two periods (low and high). The counter then has to be set to switch =
after
>   * N cycles for the first half period.
> - * The hardware has no "polarity" setting. This driver reverses the peri=
od
> + * Partly the hardware has no "polarity" setting. This driver reverses t=
he period
>   * cycles (the low length is inverted with the high length) for
>   * PWM_POLARITY_INVERSED. This means that .get_state cannot read the pol=
arity
>   * from the hardware.
> @@ -56,6 +56,10 @@
>  #define MISC_B_CLK_SEL_SHIFT	6
>  #define MISC_A_CLK_SEL_SHIFT	4
>  #define MISC_CLK_SEL_MASK	0x3
> +#define MISC_B_CONSTANT_EN	BIT(29)
> +#define MISC_A_CONSTANT_EN	BIT(28)
> +#define MISC_B_INVERT_EN	BIT(27)
> +#define MISC_A_INVERT_EN	BIT(26)
>  #define MISC_B_EN		BIT(1)
>  #define MISC_A_EN		BIT(0)
> =20
> @@ -68,6 +72,8 @@ static struct meson_pwm_channel_data {
>  	u8		clk_div_shift;
>  	u8		clk_en_shift;
>  	u32		pwm_en_mask;
> +	u32		const_en_mask;
> +	u32		inv_en_mask;
>  } meson_pwm_per_channel_data[MESON_NUM_PWMS] =3D {
>  	{
>  		.reg_offset	=3D REG_PWM_A,
> @@ -75,6 +81,8 @@ static struct meson_pwm_channel_data {
>  		.clk_div_shift	=3D MISC_A_CLK_DIV_SHIFT,
>  		.clk_en_shift	=3D MISC_A_CLK_EN_SHIFT,
>  		.pwm_en_mask	=3D MISC_A_EN,
> +		.const_en_mask	=3D MISC_A_CONSTANT_EN,
> +		.inv_en_mask	=3D MISC_A_INVERT_EN,
>  	},
>  	{
>  		.reg_offset	=3D REG_PWM_B,
> @@ -82,6 +90,8 @@ static struct meson_pwm_channel_data {
>  		.clk_div_shift	=3D MISC_B_CLK_DIV_SHIFT,
>  		.clk_en_shift	=3D MISC_B_CLK_EN_SHIFT,
>  		.pwm_en_mask	=3D MISC_B_EN,
> +		.const_en_mask	=3D MISC_B_CONSTANT_EN,
> +		.inv_en_mask	=3D MISC_B_INVERT_EN,
>  	}
>  };

So the generic register description describes the const and invert bits,
but it doesn't apply to all IPs. Thinking about that, I wonder why this
struct exists at all. I would have done this as follows:

	#define MESON_PWM_REG_PWM(chan)		(0 + 4 * (chan))

	#define MESON_PWM_REG_MISC		(8)
	#define MESON_PWM_REG_MISC_EN(chan)		BIT(chan)
	#define MESON_PWM_REG_MISC_CLK_SEL(chan)	GENMASK(5 + 2 * (chan), 4 + 2 * (=
chan))
	....

and then use these constants directly (with pwm->hwpwm as parameter if
needed) in the code. I would expect this to result in more efficient and
smaller code.

> @@ -227,6 +252,15 @@ static void meson_pwm_enable(struct pwm_chip *chip, =
struct pwm_device *pwm)
> =20
>  	value =3D readl(meson->base + REG_MISC_AB);
>  	value |=3D channel_data->pwm_en_mask;
> +
> +	if (meson->data->has_constant)
> +		meson_pwm_assign_bit(&value, channel_data->const_en_mask,
> +				     channel->constant);

Personally I'd prefer:

	value &=3D ~MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
	if (meson->data->has_constant && channel->constant)
		value |=3D MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);

even though your variant only mentions the mask once. While it has this
repetition, it's clear what happens without having to know what
meson_pwm_assign_bit() does. Maybe that's subjective?

Best regards
Uwe

--3rn6i6zl2o5dcpxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcolJMACgkQj4D7WH0S
/k5SmQf5AVHb+2560do8K6cpJeSamFxUb+0mKHgotG6R/mQStG7hRiLWlR3PAVOF
iYSCZjorNJU44x/PBKG/mxlUJB5WiIy00ONqhivhr7Gh6n+KtyJBWMCcVZHiVktp
6NcUGOCN/j7e1VjzGgL3oVaMk+eir+so5qsQ5Ptg7bD20YGkv1zQAAAF/Z/MkVBP
CtV24+C5MHYn2a2BLcKcJ6+d6t+JAK6t4LQszmhYSaCq+cutcQ58rfXtx2zGLa10
jBmyA3FYtcsQsv5gVLQxi5RxZSCuF+BwyMt0tdVubF3PF0Ba+3Mi5LgRIE2MdLW1
r5YAWOH6z+iQA7gJhobnVcBh0QSpsQ==
=217M
-----END PGP SIGNATURE-----

--3rn6i6zl2o5dcpxg--

