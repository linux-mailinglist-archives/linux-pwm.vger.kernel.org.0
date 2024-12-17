Return-Path: <linux-pwm+bounces-4367-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD29F4A43
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3F0163A77
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BC1EF0BE;
	Tue, 17 Dec 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFKSWLf0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090E1DD87D;
	Tue, 17 Dec 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436088; cv=none; b=RgqCaJdRl4/DP2gl1h9UPCCuDAPe9hILXixoSIA/u1cjmaAT65ZyL7TeGJ49ie9v8CSYLH4bG4ri+QaQYehokrqJhe7p9rh6WKkUNGHdpqQJ6EMxGCLy0SiEdThYnmxuqCUMJV/YoSrhwzDQw1fnrIc936uwkEeu6TKrp4fZ1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436088; c=relaxed/simple;
	bh=8cUwwjxrd3gHpInQY9WHjrJke/ysO12iYLDp0ATqas4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxyFXfBgRd54f08+0b90fgHOzam3Xku5KwPFQSB2/F4x43k5I8CLsZnrOzufIeUwS1OZzkvWRYyzwyXUDBLa6UZafoA5JfTm8Fnrx8NHgKop75Nyb6XZFO4OhB1/AqGruKwz7poLrm1hnwE8Bgc/rg4phLQL05F7DK8AbmaC1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFKSWLf0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so700171366b.3;
        Tue, 17 Dec 2024 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734436084; x=1735040884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TgPLNt6L5dfACZwwNJeFif8N+XzazwpAPkZQoHYaBOE=;
        b=jFKSWLf0K3d/+8/S8GRIpmJpSc7XR0LqPrhpKI8a+VQn1qfhfGe8CmoK5/gED2df2O
         JWvrkUwxAkyXrovVu4Z1CY4CMt5yQyWgWa5AWSuZXV5D7gy+AYg49Y7ulT5plzagAjKE
         bVEEa3Aw0sy2Rklr1qaBJyvf1lDTJd8Sy42J8nHcBoSkoeSco9n1BRE1J+BK33rQx3It
         VY2T4f907zWxe6TyZWD5fymkc2XM1UmO0TxNBZnSW8W3vYTRKOUHThP+BK5y8GE+a3Rc
         FKZtyfubVyfdDhP69wb32i9kDqeEMJH0Ctz3ayTNMbV3P+olELNU1cwPi0OP4rP52HJM
         6tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436084; x=1735040884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TgPLNt6L5dfACZwwNJeFif8N+XzazwpAPkZQoHYaBOE=;
        b=awWiSyRAsnJG5WZMrUZUPdmJAXOm4at7H7DR4LNLmdjsAGckYCMvuIRSdWe8gV/U6S
         6I0Vk9WYsu4+5T2g5fSg2sRVnWdzyT9vIiWLdNmQbfYGPIR9QrKdWUM3iKLawCjzsSt/
         /OXwGSDPZiFE6xiPPpXauCGKYt+XeeI9V+MGN6qACD7WN30QXOPhJ94hpVkWV2MfazDC
         gh5BJcarHPIicoYb+pKshy/CCqhf0Zx43lfXW3qWRP3YMRKBFP9PzJmBW3B+Fvf9cW+0
         SNNsazTvBJCnqIK/wWLG7rXaBWcQFrBGJulU7KdUVKct9KvcySeoBTPBveF/Ee8cEn7l
         4bBg==
X-Forwarded-Encrypted: i=1; AJvYcCUdA8t8SStS6WsdQc+7MtnaXrJ8ytWBvQb6Dv9ypUm2sV0/Pv6osKoTCNMEdAR3Wzc3lOmaferXF/Y0@vger.kernel.org, AJvYcCV5Nb5M78UUuT170ZWBFbslJIbh19SnY/2VLUNXj6uvoQABv8QgUw/xSq0+1CCnx7rwe5nD2ywfGoO4@vger.kernel.org, AJvYcCVDTqJDh44D40yd+P05BuCGfTlobiuU8MwLeC/ORIniSv/E/ODOUN3abBNxRRxhD9LUGjXs9zdDQj4X@vger.kernel.org, AJvYcCVpTIcuGzvclX+uopMez+2RmWPwJZDkCUuj9MhonE/ZLn8yMGLdO/3/8Wk9dJ78tyjhdOCP3Rh4U/6r@vger.kernel.org, AJvYcCXd1OLlO8Urce1TXN9r6WgBmgZiAqGBcuJUOUwe/yY+br0Pxs7RfcPt5uVfHPKsFhLVYdyh9qmiuKt/6ZbY@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRQlgVk36RZd84pTPQqKJwtfAIDRI+WHrrMfuu6GB19yf43DV
	gvrmi5Ug2w14SH+G9m69P1StswGWLdARD7MPRvslAB7WzGawtLlO
X-Gm-Gg: ASbGncs/bYOcglOwiQmZMVLg90J1I4o6JRrMbb4Ny4p5KALqYuOa+nOVsKwg8ZN9Eaj
	zNClE8Mkr6Y/yX6nBOk9lZS3cDZCA419J54ih9mnIOxrc/FYSCgDcLIgxQoIKH9Jy8d/JQPxq44
	oxVdnWn3vm7Hpt9Rfch6lapV6wQF+N06BGhor1E64jiRHOEr/P2K7zvM4o2VAj9mlM5YVsbTc9A
	rLqMmCjlRpybCzOWfHQbEhBjtv0k5lThR23TzkPswI82nJO4jaWVdN/ocij8iXRKFzQaDk9/Z1w
	6Y1+FtUeK7AFsASEmTM4gYwZ+AnlQ7sPXE0DbYJrsFSi/xcicMn8YVc1n2NaMgUPTcaJjVzclvq
	srvYMCmigT0kssg==
X-Google-Smtp-Source: AGHT+IEF6QcpZ2p7ADD57VCyJYUSCW81QUwTkzveHe8ErRkCWfSDWm1pGsP1JcA21NSgaDSm0tur6A==
X-Received: by 2002:a05:6402:5214:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5d63c3421f4mr34893683a12.19.1734436084354;
        Tue, 17 Dec 2024 03:48:04 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad17d7sm4193524a12.25.2024.12.17.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:48:04 -0800 (PST)
Message-ID: <27a8b987881eedc538afb6eaf300bc7909fb85b9.camel@gmail.com>
Subject: Re: [PATCH v6 10/17] iio: adc: ad7944: don't use storagebits for
 sizing
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander	 <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, 	linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org
Date: Tue, 17 Dec 2024 12:52:35 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-10-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-10-88ee574d5d03@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
> Replace use of storagebits with realbits for determining the number of
> bytes needed for SPI transfers.
>=20
> When adding SPI offload support, storagebits will no longer be
> guaranteed to be the "best fit" for 16-bit chips so we can no longer
> rely on storagebits being the correct size expected by the SPI
> framework. Instead, derive the correct size from realbits since it will
> always be correct even when SPI offloads are used.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-vy: Nuno Sa <nuno.sa@analog.com>

> v6 changes: none
>=20
> v5 changes: none
>=20
> v4 changes: new patch in v4
> ---
> =C2=A0drivers/iio/adc/ad7944.c | 16 +++++++++-------
> =C2=A01 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index
> a5aea4e9f1a7bdd8ca10f9f4580ad3216ddcdfcb..6d1202bd55a013b092ff803f2065fd1=
28dfa
> 9bdd 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -98,6 +98,9 @@ struct ad7944_chip_info {
> =C2=A0	const struct iio_chan_spec channels[2];
> =C2=A0};
> =C2=A0
> +/* get number of bytes for SPI xfer */
> +#define AD7944_SPI_BYTES(scan_type) ((scan_type).realbits > 16 ? 4 : 2)
> +
> =C2=A0/*
> =C2=A0 * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a spe=
cific chip
> =C2=A0 * @_name: The name of the chip
> @@ -164,7 +167,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct devic=
e
> *dev, struct ad7944_adc *
> =C2=A0
> =C2=A0	/* Then we can read the data during the acquisition phase */
> =C2=A0	xfers[2].rx_buf =3D &adc->sample.raw;
> -	xfers[2].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[2].len =3D AD7944_SPI_BYTES(chan->scan_type);
> =C2=A0	xfers[2].bits_per_word =3D chan->scan_type.realbits;
> =C2=A0
> =C2=A0	spi_message_init_with_transfers(&adc->msg, xfers, 3);
> @@ -193,7 +196,7 @@ static int ad7944_4wire_mode_init_msg(struct device *=
dev,
> struct ad7944_adc *adc
> =C2=A0	xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> =C2=A0
> =C2=A0	xfers[1].rx_buf =3D &adc->sample.raw;
> -	xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[1].len =3D AD7944_SPI_BYTES(chan->scan_type);
> =C2=A0	xfers[1].bits_per_word =3D chan->scan_type.realbits;
> =C2=A0
> =C2=A0	spi_message_init_with_transfers(&adc->msg, xfers, 2);
> @@ -228,7 +231,7 @@ static int ad7944_chain_mode_init_msg(struct device *=
dev,
> struct ad7944_adc *adc
> =C2=A0	xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> =C2=A0
> =C2=A0	xfers[1].rx_buf =3D adc->chain_mode_buf;
> -	xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits) *
> n_chain_dev;
> +	xfers[1].len =3D AD7944_SPI_BYTES(chan->scan_type) * n_chain_dev;
> =C2=A0	xfers[1].bits_per_word =3D chan->scan_type.realbits;
> =C2=A0
> =C2=A0	spi_message_init_with_transfers(&adc->msg, xfers, 2);
> @@ -274,12 +277,12 @@ static int ad7944_single_conversion(struct ad7944_a=
dc
> *adc,
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	if (adc->spi_mode =3D=3D AD7944_SPI_MODE_CHAIN) {
> -		if (chan->scan_type.storagebits > 16)
> +		if (chan->scan_type.realbits > 16)
> =C2=A0			*val =3D ((u32 *)adc->chain_mode_buf)[chan-
> >scan_index];
> =C2=A0		else
> =C2=A0			*val =3D ((u16 *)adc->chain_mode_buf)[chan-
> >scan_index];
> =C2=A0	} else {
> -		if (chan->scan_type.storagebits > 16)
> +		if (chan->scan_type.realbits > 16)
> =C2=A0			*val =3D adc->sample.raw.u32;
> =C2=A0		else
> =C2=A0			*val =3D adc->sample.raw.u16;
> @@ -409,8 +412,7 @@ static int ad7944_chain_mode_alloc(struct device *dev=
,
> =C2=A0	/* 1 word for each voltage channel + aligned u64 for timestamp */
> =C2=A0
> =C2=A0	chain_mode_buf_size =3D ALIGN(n_chain_dev *
> -		BITS_TO_BYTES(chan[0].scan_type.storagebits), sizeof(u64))
> -		+ sizeof(u64);
> +		AD7944_SPI_BYTES(chan[0].scan_type), sizeof(u64)) +
> sizeof(u64);
> =C2=A0	buf =3D devm_kzalloc(dev, chain_mode_buf_size, GFP_KERNEL);
> =C2=A0	if (!buf)
> =C2=A0		return -ENOMEM;
>=20


