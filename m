Return-Path: <linux-pwm+bounces-3570-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23900996E50
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EBC1C219FF
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E0192B7A;
	Wed,  9 Oct 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfBJzSBP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3E126C18;
	Wed,  9 Oct 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484860; cv=none; b=IYqg+gt3UTb9BPO500jfvGdjSmCdaVpB1vC1XdprbajHCzzIsBFNSfERTQ3TJC8Hr/IX/jdV28hch/qhvMUjrrBrZ66BfNCsPk2GImHsgMfxs4btAUMxJ1+2hv7a6XcM0kFYvVZ1M8Ott+ktQgiZMAkWAIfJZxOuewEQMI+vMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484860; c=relaxed/simple;
	bh=/XnS0agL73Cd5qo94QHc+MEgH7XmUZJwP2CiaOZL1qY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDAFi5yDFm3CyS6iQD7PfiK9tfiNWWOwPyK/WDPEQXVm3xLhiOP/z6jyks4Ii2ywLeFSBmqOxwzTWCe4W+aKH1+UUKcV8lIiIbWq/FFNLNxbiR28HYsap2tiR70vU87EuL36NgcmAVCqYIJOxfAi3xb4WYFS5BTKBxBAwoUQR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfBJzSBP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso9041438a12.2;
        Wed, 09 Oct 2024 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484857; x=1729089657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ApsqAnX3z1ZU96iruPCj6VZEIgtDVVKioYQY5eV5sZQ=;
        b=bfBJzSBPqaeK1Vkd6bWgXsQTK4+wb8c/KDhLyr/lZN15Z6JRXRLtG4bE6TmmgjC6Si
         dRvab5F0cO+PTcaQwuRVBYGhlGJl9/q/RsYXS54BbZ47ebSPTxFgECZEdr80HzcDprLN
         CdwkHNgJ0Cyo31c/q03YHkEaBHODLS4VN+PnlnvhKSbe+wjt/CxApWke2slMonCwuDHQ
         eAhLaPErNuaYHQc+nmKKe4C2Mikv+AhEa/1VtmkspVRoRnfzyOF0eR4ccfF/H7CbY4S7
         EtJP9P8gW5fvCaPmRbqQHbUCh1p2NKAJFPgFZYdk6wkK4CHP6ZN1MFRoHxFDsO8zv+Ns
         +ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484857; x=1729089657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApsqAnX3z1ZU96iruPCj6VZEIgtDVVKioYQY5eV5sZQ=;
        b=B1b/Bp1CPHgw6uShP37cuVhbab5ufQXKPv/xVrM3V5t9rSscRy1LpAPCyIujgYvD0M
         v3b6Jt1xv3kP57CNO2ry5q2H9dXxxxcWJZ2yaljeU7rRedpaSmaiGg2RG3OoUKNK9rZG
         qqDNgZoov8O2Xa2K9FlN80oBnX/Oys5X0OMxIf8COkSL4Pb/x+4FLzNOp4vuEMzqyNMV
         bWkNXvkjh377LtjYQlFCSZjaE6G6Q4bW+9fqfObpb/BSmVezZj+W67Je8aAU0JL6Uke/
         /l7IEF3UrjpzMiqf+vv90WAbv4WN+aavfK5tKqQD+EgP7pexKPN6xnwH69D2qKWPzANs
         8soQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDf65nKfTOKfnQ9qqwF/4V/gaf/Jo1cQXzZz0C0tdaTyO8sp/qfbGpnD4IN5qgGKUfsqowzKiBLciF@vger.kernel.org, AJvYcCUlX/aX5lDECQu8rY0aM/WdUMRfaGGgnvg7oSU0qmDrHdsZ16ZHVXm4psHocjGeS17UxVxZQbd17sjl@vger.kernel.org, AJvYcCWOjBKr5du9tRFJCjctIyV4vz1J8WoTKLzfnaM3MyWg3KF4HMmyVjH4EcgzPiYOD+PcYjtw0FQiYBb0oDeB@vger.kernel.org, AJvYcCWvg4OvXR4DWDemNNipUg40ByAIKJbt8/JFQRDExs7wSn9D2/PYdWcitw/khwxJOA863baIVIu6UPc4x4E=@vger.kernel.org, AJvYcCX5n6c7S1NMPY2+ZAI8FtRx4SpEhu8UhegCGC5/Q/Pko5KpxAINyOqUW9SVbuivynhqnEc1EHFN13+E@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/nw3IN7J6A4jeivnF3GMAhcYptCBwBVoJ34KVVb8UGmHzgVR
	0YYHAxliJ4b4UbXzShIMcOTvyYoA9J+P4D/3Zzmqd6VBSCM8YfMj
X-Google-Smtp-Source: AGHT+IHpeKwPD2a1ETWFP4AbLN7gFEg+DpTsEdP6wB55y155VqtzOeFZY5xXgG90TBiTlQ61QlYRkQ==
X-Received: by 2002:a05:6402:1ed3:b0:5c5:b679:cf29 with SMTP id 4fb4d7f45d1cf-5c91d54cacbmr2195866a12.1.1728484856730;
        Wed, 09 Oct 2024 07:40:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c91d0be1fbsm1009970a12.3.2024.10.09.07.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:40:56 -0700 (PDT)
Message-ID: <02f14fc6b7c7d35ef6a01cfc30164ddc75ee53ed.camel@gmail.com>
Subject: Re: [PATCH v4 6/8] iio: adc: ad7606: Introduce num_adc_channels
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com,  dlechner@baylibre.com, jstephan@baylibre.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 09 Oct 2024 16:40:55 +0200
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-6-6971a8c0f1d5@baylibre.com>
References: 
	<20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
	 <20241009-ad7606_add_iio_backend_support-v4-6-6971a8c0f1d5@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
> This variable determines how many hardware channels has the chip,
> oppositely to the num_channels that can contain more channels, e.g a
> timestamp channel in our case. Introducing this variable avoids
> decreasing the former num_channels variable when reading the ADC's
> channels, and clarifies a bit the code.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7606.c | 10 +++++++++-
> =C2=A0drivers/iio/adc/ad7606.h |=C2=A0 2 ++
> =C2=A02 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index dfbdea8c28ba..ec902b268388 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -150,6 +150,7 @@ static int ad7606_16bit_chan_scale_setup(struct ad760=
6_state
> *st,
> =C2=A0const struct ad7606_chip_info ad7605_4_info =3D {
> =C2=A0	.channels =3D ad7605_channels,
> =C2=A0	.name =3D "ad7605-4",
> +	.num_adc_channels =3D 4,
> =C2=A0	.num_channels =3D 5,
> =C2=A0	.scale_setup_cb =3D ad7606_16bit_chan_scale_setup,
> =C2=A0};
> @@ -158,6 +159,7 @@ EXPORT_SYMBOL_NS_GPL(ad7605_4_info, IIO_AD7606);
> =C2=A0const struct ad7606_chip_info ad7606_8_info =3D {
> =C2=A0	.channels =3D ad7606_channels_16bit,
> =C2=A0	.name =3D "ad7606-8",
> +	.num_adc_channels =3D 8,
> =C2=A0	.num_channels =3D 9,
> =C2=A0	.oversampling_avail =3D ad7606_oversampling_avail,
> =C2=A0	.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
> @@ -168,6 +170,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_8_info, IIO_AD7606);
> =C2=A0const struct ad7606_chip_info ad7606_6_info =3D {
> =C2=A0	.channels =3D ad7606_channels_16bit,
> =C2=A0	.name =3D "ad7606-6",
> +	.num_adc_channels =3D 6,
> =C2=A0	.num_channels =3D 7,
> =C2=A0	.oversampling_avail =3D ad7606_oversampling_avail,
> =C2=A0	.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
> @@ -178,6 +181,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_6_info, IIO_AD7606);
> =C2=A0const struct ad7606_chip_info ad7606_4_info =3D {
> =C2=A0	.channels =3D ad7606_channels_16bit,
> =C2=A0	.name =3D "ad7606-4",
> +	.num_adc_channels =3D 4,
> =C2=A0	.num_channels =3D 5,
> =C2=A0	.oversampling_avail =3D ad7606_oversampling_avail,
> =C2=A0	.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
> @@ -188,6 +192,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_4_info, IIO_AD7606);
> =C2=A0const struct ad7606_chip_info ad7606b_info =3D {
> =C2=A0	.channels =3D ad7606_channels_16bit,
> =C2=A0	.name =3D "ad7606b",
> +	.num_adc_channels =3D 8,
> =C2=A0	.num_channels =3D 9,
> =C2=A0	.oversampling_avail =3D ad7606_oversampling_avail,
> =C2=A0	.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
> @@ -198,6 +203,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606b_info, IIO_AD7606);
> =C2=A0const struct ad7606_chip_info ad7606c_16_info =3D {
> =C2=A0	.channels =3D ad7606_channels_16bit,
> =C2=A0	.name =3D "ad7606c16",
> +	.num_adc_channels =3D 8,
> =C2=A0	.num_channels =3D 9,
> =C2=A0	.oversampling_avail =3D ad7606_oversampling_avail,
> =C2=A0	.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
> @@ -208,6 +214,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, IIO_AD7606);
> =C2=A0const struct ad7606_chip_info ad7606c_18_info =3D {
> =C2=A0	.channels =3D ad7606_channels_18bit,
> =C2=A0	.name =3D "ad7606c18",
> +	.num_adc_channels =3D 8,
> =C2=A0	.num_channels =3D 9,
> =C2=A0	.oversampling_avail =3D ad7606_oversampling_avail,
> =C2=A0	.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
> @@ -219,6 +226,7 @@ const struct ad7606_chip_info ad7616_info =3D {
> =C2=A0	.channels =3D ad7616_channels,
> =C2=A0	.init_delay_ms =3D 15,
> =C2=A0	.name =3D "ad7616",
> +	.num_adc_channels =3D 16,
> =C2=A0	.num_channels =3D 17,
> =C2=A0	.oversampling_avail =3D ad7616_oversampling_avail,
> =C2=A0	.oversampling_num =3D ARRAY_SIZE(ad7616_oversampling_avail),
> @@ -528,7 +536,7 @@ static int ad7606_set_sampling_freq(struct ad7606_sta=
te *st,
> unsigned long freq)
> =C2=A0
> =C2=A0static int ad7606_read_samples(struct ad7606_state *st)
> =C2=A0{
> -	unsigned int num =3D st->chip_info->num_channels - 1;
> +	unsigned int num =3D st->chip_info->num_adc_channels;
> =C2=A0
> =C2=A0	return st->bops->read_block(st->dev, num, &st->data);
> =C2=A0}
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index d401d3ab37e0..b26a11b2eba1 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -71,6 +71,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_st=
ate *st,
> =C2=A0 * @channels:		channel specification
> =C2=A0 * @name		device name
> =C2=A0 * @num_channels:	number of channels
> + * @num_adc_channels	the number of channels the ADC actually inputs.
> =C2=A0 * @scale_setup_cb:	callback to setup the scales for each channel
> =C2=A0 * @oversampling_avail	pointer to the array which stores the availa=
ble
> =C2=A0 *			oversampling ratios.
> @@ -82,6 +83,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_st=
ate *st,
> =C2=A0struct ad7606_chip_info {
> =C2=A0	const struct iio_chan_spec	*channels;
> =C2=A0	const char			*name;
> +	unsigned int			num_adc_channels;
> =C2=A0	unsigned int			num_channels;
> =C2=A0	ad7606_scale_setup_cb_t		scale_setup_cb;
> =C2=A0	const unsigned int		*oversampling_avail;
>=20


