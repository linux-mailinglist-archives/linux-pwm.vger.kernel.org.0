Return-Path: <linux-pwm+bounces-3952-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC5B9B43B9
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 09:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5676B2175B
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660D2036E6;
	Tue, 29 Oct 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vfalQd62"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC21D1854
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189127; cv=none; b=GoMtLUYJoKrrXo897lMC+5qDMmqPClwDWvIj+4NHGHqJq+YW755xWD9AQjYruVBY27EDMOmwIsgJiBQXWxX+2ESe0IqlAOxxnw+TY1fr6DREjkxFWdw7+KL03+YryJS4M4jZ2TR6u3mgZheU0ygG0keLC5xWaHnNZEu8QLc84ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189127; c=relaxed/simple;
	bh=Wgu4Q3YZ64aWSqvWoqqloTsZbrePlNg2P6R61VqI7S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9PYVXkc77Uyea1bDoXv0HT42SF6XheyfF7NgylgbMjldpLHukYrRYgu4wOTGqCzZsyVPsvSFFyOdiQMQ/B1O6K1vq4j+FmkhAsrybjllHdDlYrx8GtQGcZ7JlgGd6NhQDE1MnaS5AqIRKslBuX4ykqoMEBKywRB/mGLEPkdtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vfalQd62; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso50118905e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730189123; x=1730793923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lN2eRb6bl0eRsqhdld34k6abaNSa22uP0f7TfgqVgM=;
        b=vfalQd62VFx9TyfFbm23aog8MWNlyilO7c+TXVpv/WyeQiZc5C1AddMIV8VL5J5sEx
         qg/0DpK2AsAMon+bogO1Ez2RgCe+VOerS0m8Z9uLqgb2NB45VV6mP4vEVZsUiovcalBQ
         3dJPiUCP+h8meYBsDjK29m4JXEjVwhvSIMxrpub6ERXJy1bLxhMzAa/sSWufKKGQhYBL
         wTgx7o+wvbIjJSesxRcmgflIdH6RQOgm1QDif+sODDobRFWtwroXLPgVirLcJB+W38h9
         NGa4Se6XB1nllE/e1useaOv8R0S+6wlJjUMTjCjZ7P3cyT99MjCazMDmESEdyyiuiQ9A
         Fh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189123; x=1730793923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lN2eRb6bl0eRsqhdld34k6abaNSa22uP0f7TfgqVgM=;
        b=wWfPNHc2dZLXoOyea+h3TLRDsk7bRKaWa1IHWS1WiF3xTC4VLk/35HPxBwAesjf3Nc
         qDebu8qS4DEyAPStgagdgOGI3/Bd7coVM1ragNE8HyUHtXFwE1YSh2wmh48miNY8P9qD
         enG8q2rSfleyXNRHGyE/I62OgESANMJa6bU1lbbS4QgConPtrWRemX81tketFTgRR/Ii
         330jjnl6t8olLFrz3AkLyVf2yjWiISVVzYMBYQlo9Ze9fgQKZrD86TemrP0x5f+3el9K
         QyIWQHpNF8Wb6DYLvE+D9ZWegw5hwyLRURLFywFULs96BprMXwP8Cmk7DP3S2J/TgNPa
         3ZgA==
X-Forwarded-Encrypted: i=1; AJvYcCWaOc0aYiZ3/hnVK3UtuM15zIYXHG5GhR/fbkbtZDRzPdB6UXG6uzgVhz3kRutcWg6otmiaL5igFK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHvXn3piAK6tOw7lrwojntUTQKSQFld4ua33sQXTR+8GiOzcL
	j2qDxJolCUOrBJbNVQiLxE0F6uz4mnEG+PQclGZTRP4uatOQXiOfyn0iEGPW5N0=
X-Google-Smtp-Source: AGHT+IFSjfQXCa5GW1Npbhe93OduAXI4SGUOVExv2PPgkmuE8+77dW4spir8TRXtu2Ia2kzTS2IFQA==
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-4319ad049a8mr79735435e9.27.1730189123296;
        Tue, 29 Oct 2024 01:05:23 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5433f2sm167003775e9.1.2024.10.29.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:05:22 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:05:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 01/15] pwm: core: export pwm_get_state_hw()
Message-ID: <mavlxxjza7ud7ylgoewz6fz3chtuwljvcjjf6o3kcv555iolwa@wdnrsiow5u5w>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-1-f8125b99f5a1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j43zmgztsm2qmibl"
Content-Disposition: inline
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-1-f8125b99f5a1@baylibre.com>


--j43zmgztsm2qmibl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v4 01/15] pwm: core: export pwm_get_state_hw()
MIME-Version: 1.0

Hello David,

On Wed, Oct 23, 2024 at 03:59:08PM -0500, David Lechner wrote:
> Export the pwm_get_state_hw() function. This is useful in cases where
> we want to know what the hardware is actually doing, rather than what
> what we requested it should do.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v4 changes: new patch in v4
>=20
> And FYI for Uwe and Jonathan, there are a couple of other series
> introducing PWM conversion triggers that could make use of this
> so that the sampling_frequency attribute can return the actual rate
> rather than the requested rate.
>=20
> Already applied:
> https://lore.kernel.org/linux-iio/20241015-ad7606_add_iio_backend_support=
-v5-4-654faf1ae08c@baylibre.com/
>=20
> Under review:
> https://lore.kernel.org/linux-iio/aea7f92b-3d12-4ced-b1c8-90bcf1d992d3@ba=
ylibre.com/T/#m1377d5acd7e996acd1f59038bdd09f0742d3ac35
> ---
>  drivers/pwm/core.c  | 55 +++++++++++++++++++++++++++++++++++++----------=
------
>  include/linux/pwm.h |  1 +
>  2 files changed, 40 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 634be56e204b..a214d0165d09 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -718,7 +718,7 @@ int pwm_apply_atomic(struct pwm_device *pwm, const st=
ruct pwm_state *state)
>  }
>  EXPORT_SYMBOL_GPL(pwm_apply_atomic);
> =20
> -static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *st=
ate)
> +static int __pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *=
state)
>  {
>  	struct pwm_chip *chip =3D pwm->chip;
>  	const struct pwm_ops *ops =3D chip->ops;
> @@ -730,29 +730,50 @@ static int pwm_get_state_hw(struct pwm_device *pwm,=
 struct pwm_state *state)
> =20
>  		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> =20
> -		scoped_guard(pwmchip, chip) {
> -
> -			ret =3D __pwm_read_waveform(chip, pwm, &wfhw);
> -			if (ret)
> -				return ret;
> +		ret =3D __pwm_read_waveform(chip, pwm, &wfhw);
> +		if (ret)
> +			return ret;
> =20
> -			ret =3D __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
> -			if (ret)
> -				return ret;
> -		}
> +		ret =3D __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
> +		if (ret)
> +			return ret;
> =20
>  		pwm_wf2state(&wf, state);
> =20
>  	} else if (ops->get_state) {
> -		scoped_guard(pwmchip, chip)
> -			ret =3D ops->get_state(chip, pwm, state);
> -
> +		ret =3D ops->get_state(chip, pwm, state);
>  		trace_pwm_get(pwm, state, ret);
>  	}
> =20
>  	return ret;
>  }

I don't understand why you introduce __pwm_get_state_hw() (a variant of
pwm_get_state_hw() that expects the caller to hold the chip lock) when the
single caller (apart from plain pwm_get_state_hw()) could just continue
to use pwm_get_state_hw().

In principle I'm open to such a patch and wonder if there is already a
merge plan for this series. If you send a simpler patch soon with the
same objective, I'll make sure it goes into v6.13-rc1 in the assumption
that it's to late for the whole series to go in then. Or do you still
target 6.13-rc1 for the spi bits? Then it would probably better to let
this patch go in with the rest via the spi tree.

Best regards
Uwe

--j43zmgztsm2qmibl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcglz8ACgkQj4D7WH0S
/k4VNgf/SnQ3FDnC2c7bg2CyahKuEnbI1V+Mh1n4mLdEhbjuD3kDrXmP8S8QoYN3
UPKt/DB95LNR4rW23vH6A/VwT0Z2pxGUFkWUc+rph/XLlHGSlTHA24wqcAUFmv9U
LrdFn6se1JD/0iqekbIgSw4Z1wmMUyDgVf5qPhCr0T8q/5xMfRnOnDRot9OLxHAE
2wthItMXrD74GNxg7hYr+Egp9RNtEj+V8CUqOriJuHx3HDEgx+tPFT5zaBKAFOnf
tNIEHM9s2IYxsbR97SmlSVnOdVHutuGAEsgaPGjzynuoLYqT5Wi39UbZc0Z4wCoP
RnMNIRjxMCTHTibMjVPASVQRLwvN6g==
=MQGh
-----END PGP SIGNATURE-----

--j43zmgztsm2qmibl--

