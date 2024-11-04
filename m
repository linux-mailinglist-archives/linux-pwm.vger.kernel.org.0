Return-Path: <linux-pwm+bounces-4026-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3E9BAF1C
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A377EB2399D
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A01AB6FF;
	Mon,  4 Nov 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gPrdysaw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AE1AE00B
	for <linux-pwm@vger.kernel.org>; Mon,  4 Nov 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711292; cv=none; b=su/3346FuqDE/xqmynapPhEPGLcsZ85dGMP6dlr8ha11vsJxYaE/VhyucZgRk68jSbX7rraPssSQY2E7X+D7nRQtkKBdlB3exCHq6XLr92n9TJ6P6RU9FioekHyqYfpfFQFRdYa543+EHuZzqJOFdkouD1SWXELxhi/+AmoECSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711292; c=relaxed/simple;
	bh=TdUwawy+SxSRobT90coWOPO+PHUjgZdJup23l0G+qB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAlEV6myfmyeNoDeJtR9mbd4W2GHwS7oFKg0Vz12GRJ1LBF/w7Jf50R9JeRP1QMrDFEAQOIkxuSw0MWTIT6kca/RHvdXpmdNyt66WsNlS1q7qiW7Ruy8+ZgqOnGWQyMfa0xNcWVrXOnb7HVnpRNAjRbMritOtTm1cGlV0y251jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gPrdysaw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a850270e2so662751366b.0
        for <linux-pwm@vger.kernel.org>; Mon, 04 Nov 2024 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730711284; x=1731316084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeinyN/5Nec/44C5dTybhhrHH4wmAkP5DqVHdTtI3c8=;
        b=gPrdysawRi0IIgzQYDg+C3mCBH5FVmasPxuXkKYaSuw+hzhopTi6A0djs5w60UcDDE
         DJNMsoSrH3j/qQkRwkfAQqfJWRQte5LAas1j/jvgVB4J3WiMxLGAxWOxkWwXC66jZdBm
         V2mzCt5pUN3MVfHFbmSFT4IrZ2gga3EvdUfPXR+ItnKT9lk6VhhmwAd84pEtCjie755B
         m/iwEwaAxKGyxDbvomGOxXCxvzW7Ie000dV9iKiMdl+NqhzklzLDY2vJI2qLWMdGG3Iw
         QyU2qX1ZZfwwcjhaZ00fvEEt7t4OpXiyHMlAtw3vZcNIYL9paP01xOdEkYTolKZc7IoH
         6AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711284; x=1731316084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeinyN/5Nec/44C5dTybhhrHH4wmAkP5DqVHdTtI3c8=;
        b=E8KisFHTmrebufLg5ivlzWZL8JfGsgPZbc7J+D7+3t6av2P+4oxBohj2c3WHaDf6y9
         GG9rC+Vw6fTh5KmmYr7BeF7rHK7KXW7qs912NUZr4FOqLe4zYgFTZF4Wz70ORm/h7lGY
         gE80HCoKoM8tAK6QUeNV+73n8CH9sdx6i01ACW+4zhfgZUkK9TQLDZLL9b7XANZ+1rrw
         Cd3STWtzmotD3y0DKumLSxCjbrHQnnjtOGkaNLi27SmeaqZYDBW41+LWYjsEcrALTQcb
         PK8T1MO6VLdQJ84PfROBuW4pgrWDlKdoXWAQRmXjvn/JNayEaAeE3EN9tXMV1idXaBSc
         VAbg==
X-Forwarded-Encrypted: i=1; AJvYcCXEADoZI00tL2pMFAT/skktD3k76Fe2i6ItPPnxuH7pAbbFpkj3FdbdYOAVIVjyq3d/xGmlv1NtEmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKFNWmFk5tYtCrNwETBAdxL852Rv57sOsRRuCELk4ntnFg1go
	7bJ+pJm886MaA+bvAzW6dxfzpL/k2TmwxLqpSKSXkBp8RsSu4aIZ1cOT/oPClGo=
X-Google-Smtp-Source: AGHT+IHbjqQG3EbTVZChskg4oJ3EPibMoamir516XriRk8GBfxJS4NEjIPq5u7GVGdstesR3PRimKA==
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9e652c179emr1170000866b.0.1730711283666;
        Mon, 04 Nov 2024 01:08:03 -0800 (PST)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e563093e5sm523477966b.0.2024.11.04.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:08:03 -0800 (PST)
Date: Mon, 4 Nov 2024 10:08:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v2 1/4] pwm: meson: Simplify get_state() callback
Message-ID: <ll3i664yuojtueo5c5uzclduylbrjxf3r672jjb5hgtbslx6jj@fvcefnjftqmq>
References: <20241016152553.2321992-1-gnstark@salutedevices.com>
 <20241016152553.2321992-2-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gvh7qusglqyop6c6"
Content-Disposition: inline
In-Reply-To: <20241016152553.2321992-2-gnstark@salutedevices.com>


--gvh7qusglqyop6c6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/4] pwm: meson: Simplify get_state() callback
MIME-Version: 1.0

On Wed, Oct 16, 2024 at 06:25:50PM +0300, George Stark wrote:
> In .get_state() callback meson_pwm_channel struct are used to store
> lo and hi reg values but they are never reused after that so
> for clearness use local variable instead.
>=20
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>  drivers/pwm/pwm-meson.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 98e6c1533312..2ef632caebcc 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -310,6 +310,7 @@ static int meson_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	struct meson_pwm *meson =3D to_meson_pwm(chip);
>  	struct meson_pwm_channel_data *channel_data;
>  	struct meson_pwm_channel *channel;
> +	unsigned int hi, lo;
>  	u32 value;
> =20
>  	channel =3D &meson->channels[pwm->hwpwm];
> @@ -319,11 +320,11 @@ static int meson_pwm_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  	state->enabled =3D value & channel_data->pwm_en_mask;
> =20
>  	value =3D readl(meson->base + channel_data->reg_offset);
> -	channel->lo =3D FIELD_GET(PWM_LOW_MASK, value);
> -	channel->hi =3D FIELD_GET(PWM_HIGH_MASK, value);
> +	lo =3D FIELD_GET(PWM_LOW_MASK, value);
> +	hi =3D FIELD_GET(PWM_HIGH_MASK, value);
> =20
> -	state->period =3D meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel-=
>hi);
> -	state->duty_cycle =3D meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> +	state->period =3D meson_pwm_cnt_to_ns(chip, pwm, lo + hi);
> +	state->duty_cycle =3D meson_pwm_cnt_to_ns(chip, pwm, hi);
> =20
>  	state->polarity =3D PWM_POLARITY_NORMAL;

Fine for me if you drop the local variable channel as found by the build
bot.

Best regards
Uwe

--gvh7qusglqyop6c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcoju8ACgkQj4D7WH0S
/k7vqQf9EAur5SOfIWCiCkCZxW/Scb5JUD1k+pcoodOq/QAeYaAQXNkffAIjVnkU
Z4y1vJ8j6gQr/WXYQdbOQ4Qj7G5m9DJQmxyYdv0Cog9PKmAmVyHGLmi+zxGJ+kZb
Dq8JuERY7/Le7vPFWFwOhpq/1n5gnsg9Dd7ZlA/hN55VL3cWXft9eVBj5e8DGBym
qN4tnX3Hz494Bm/71xJM3D311Vaq6HYYvXdoY9HzFaNXh3mvJHqgB3ysekBRMt3f
RCyuCe0yQcwKsGqKLJmNJOzxPgx0Wpmdv+qcYKv50Ubr0sTs4HPhSnYYEFksu3IC
IuJjdsPpo1Ts5mAkwLAFdXzdAR9pXA==
=NrRk
-----END PGP SIGNATURE-----

--gvh7qusglqyop6c6--

