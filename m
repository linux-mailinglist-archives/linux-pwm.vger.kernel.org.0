Return-Path: <linux-pwm+bounces-4366-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF29F4A3A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FD57A5675
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13E1E3DF7;
	Tue, 17 Dec 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK+5vHrX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE801B85C9;
	Tue, 17 Dec 2024 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436007; cv=none; b=fhAl1oDfJC8NfDNCCww7weJ6kL42BsKZUDjpF8XMd2eBqfeW4qVY46PC28IcBJwgjxJUSZ7yrvMr39i3dcrOZzcKgu+ML36GYRVHWrDys3CO1olH/nMyR+mSdE7Ook6OvTDS4H/ws/AHcb2AoQMXyi7WuyMWUUjHeqCkQ19FEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436007; c=relaxed/simple;
	bh=DcwhLdayocm1dJtgnVH3atRL7cU6op1EVsTx66Cy5DE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c1uLYVFvtsvd7NEtp0uJrAxj1aluEDHUGLqqEkl+OdQA0ElQYkYA8iO1bVMs0+NURpSU9pECC+jyIU3H/7hOTaJKg0vruzqZ1EoAt5TZTBEPsGKN7DiKhZPvKlQ3AabmxsZenUKtFRelCKbtNa7pzDyd0vWoCf07TRvWltQQ26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK+5vHrX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso841202166b.2;
        Tue, 17 Dec 2024 03:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734436004; x=1735040804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZUreiN7LpBkXAYVfioSRllXEbXxZXGq0WUvwJIHnG4=;
        b=FK+5vHrXKyeO56FtmaNu+ncBLkjrIWznVGsgiJ74RuoY+ffX9q/pWj6s07T/WDFUYv
         cu4NpthK9H7YvsFcd9O8BSxxHsv4bTDGv/H1rRI78lKYTM3l1v90SrAfZAluvYYRLici
         yFXqnz89+7/kWfQuiBBaxqH+5mtCXKVlyQx3YlBQiztyOw0ToUnhyGUztz9r0C/DtW/8
         tt0LEki+6YhkQUXsmdrTDiHRJmivEELcULQc2z/NWSS7ngvKrDf2frLG4n9VPfG7fkpN
         tx/M8Gp/28zS2/aCuMwzdsscX6iR6SnVqONQYhKUiaxmSOmsYZyyHgCYNcVcLv6+s6Mi
         0bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436004; x=1735040804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZUreiN7LpBkXAYVfioSRllXEbXxZXGq0WUvwJIHnG4=;
        b=hO1Y9dBqPBYj5WWYl+wfKGsSI6gdFaNGQ06eykw1HVlTxp9QBYHHlJHeZZXNvkJg1H
         XtodyVudG6OzGn2WU3lZSF0WQYVrJWjpSR/MTGb4fCcbq8sjVsafnGnxZM1Eiim2THQf
         sn8fMLGXjsgslFjKwgo3S0XQTolKAopWXUDloZUDJdt0VYV+JB/YUWt0dbLS6mpru4Ne
         n/KSWOEwE2liP8APFleqoXfcr211P96yiT4PyBipihOjl+YKpe5bDzrR11xlEQKCgiqh
         U65qZSfuUH5m0ndCBxPu7ZR629uJ/lbcs//CtdxaxWTTTSgl8iXshwQtF6ieTlnJBiRy
         FTAg==
X-Forwarded-Encrypted: i=1; AJvYcCUP0s7SUwKcYixrMO1mvR53UAPwuwMDIsWaaJyAN8GUc9x3r7Ujx181OscwZztUSBB7XwqYel1ahv3ks7QY@vger.kernel.org, AJvYcCUja5+wKSa5/7cD2Zl/L0ChUE7Xse6H81xNnOgUKduW7T4WvJhhOBNdFnMNi03VE/aX2jgobLZOj9ye@vger.kernel.org, AJvYcCVBeSaoDnFFx/WRUwdPe0c4QCXJutSHSgNdgXmm4LdIBwhKKMeC9nLQw3gygkueC7CQhEuQ7kdun4Fw@vger.kernel.org, AJvYcCWPX8Fk1o2d8kS23YgElQaQFxA+mjmdxKEThAP0Q7jdCZV3RO8bsQgeqFIBj7nVebyBAUB4Lmjsn9ib@vger.kernel.org, AJvYcCXjsRVoQVd0NXXEm4G9gwOWUT9+ySPhlYziboyK1URai7/69h3Rf98Ukw3DtTT9fTdRFMeWg5yFuai0@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmWNRlbL+9W94cfldItN0ccmg/9YmXCkABnVbnvzNEoT8b6bH
	7IX4MXOax/EsqrjZ6Pnmp8tiIJm56dvUpFNHo4wtRgX7oRxqDFHQ
X-Gm-Gg: ASbGncv+X2nYMVFCnjoKXhfDREXC66PXMfnt53fRkrKGuvFMqYLoA/zepe3OB9CmHYs
	nVpOuA0hF1Whs6Mytb8dVYX1KmAXxNGpzEIPxr2g7vnaukGWzKm1nFolMmN0AoJq++x+ZVegvhd
	cv7shpoecF26EO1wPAEisG/Xy4Lc0mRvn2roZRYYTG31qhi79/gCXPGR8ZuDnLiY1WDpd84qwDS
	0mPjTdewFF2DhOonNa9jCv4ZK1Tv9DPc+p46DlcNZcSGO50EK1m0TH5BGJXZXpZFaSejWcm+YoQ
	tf8rfK2qzIWo9fGs0nbi9uQqEQKNCG2y1xKOnxDq1lU5BIjIDfq0R7uuoT3TqB6NdF623Bl7Jku
	n7uDSuc29r2sdsA==
X-Google-Smtp-Source: AGHT+IHNR1jJfNC0KKIY4ncroA8HHq6nL8yve/1Su3mja9fvefTmP+mLSeLbLMChDPf/FmCUE/GTfw==
X-Received: by 2002:a17:907:3da7:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-aab778c3266mr1614148566b.5.1734436003813;
        Tue, 17 Dec 2024 03:46:43 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9c3eb5e0sm413842366b.44.2024.12.17.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:46:43 -0800 (PST)
Message-ID: <9312344a10247b8ab4d6fabfe305a56976aab650.camel@gmail.com>
Subject: Re: [PATCH v6 09/17] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_with_handle()
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
Date: Tue, 17 Dec 2024 12:51:14 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-9-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-9-88ee574d5d03@baylibre.com>
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
> Add a new devm_iio_dmaengine_buffer_setup_with_handle() function to
> handle cases where the DMA channel is managed by the caller rather than
> being requested and released by the iio_dmaengine module.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v6 changes:
> * Rename from devm_iio_dmaengine_buffer_setup_ext2()
> * This patch now just adds the new function - prep work was split out
> =C2=A0 to a separate patch
>=20
> v5 changes: none
>=20
> v4 changes:
> * This replaces "iio: buffer-dmaengine: generalize requesting DMA channel=
"
> ---
> =C2=A0drivers/iio/buffer/industrialio-buffer-dmaengine.c | 38
> ++++++++++++++++++++++
> =C2=A0include/linux/iio/buffer-dmaengine.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++
> =C2=A02 files changed, 43 insertions(+)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index
> 02847d3962fcbb43ec76167db6482ab951f20942..e9d9a7d39fe191c2b6e8c196a08cdd2=
6cd3a
> 8d4b 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -380,6 +380,44 @@ int devm_iio_dmaengine_buffer_setup_ext(struct devic=
e
> *dev,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext,
> "IIO_DMAENGINE_BUFFER");
> =C2=A0
> +static void devm_iio_dmaengine_buffer_free(void *buffer)
> +{
> +	iio_dmaengine_buffer_free(buffer);
> +}
> +
> +/**
> + * devm_iio_dmaengine_buffer_setup_with_handle() - Setup a DMA buffer fo=
r an
> + *						=C2=A0=C2=A0 IIO device
> + * @dev: Device for devm ownership
> + * @indio_dev: IIO device to which to attach this buffer.
> + * @chan: DMA channel
> + * @dir: Direction of buffer (in or out)
> + *
> + * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc(=
)
> + * and attaches it to an IIO device with iio_device_attach_buffer().
> + * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes=
 of
> the
> + * IIO device.
> + *
> + * This is the same as devm_iio_dmaengine_buffer_setup_ext() except that=
 the
> + * caller manages requesting and releasing the DMA channel handle.
> + */
> +int devm_iio_dmaengine_buffer_setup_with_handle(struct device *dev,
> +						struct iio_dev *indio_dev,
> +						struct dma_chan *chan,
> +						enum iio_buffer_direction
> dir)
> +{
> +	struct iio_buffer *buffer;
> +
> +	buffer =3D __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir);
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
> +
> +	return devm_add_action_or_reset(dev, devm_iio_dmaengine_buffer_free,
> +					buffer);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_with_handle,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 "IIO_DMAENGINE_BUFFER");
> +
> =C2=A0MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> =C2=A0MODULE_DESCRIPTION("DMA buffer for the IIO framework");
> =C2=A0MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buf=
fer-
> dmaengine.h
> index
> 72a2e3fd8a5bf5e8f27ee226ddd92979d233754b..37f27545f69f761c3327c307cc6311b=
02a75
> 1096 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -11,6 +11,7 @@
> =C2=A0
> =C2=A0struct iio_dev;
> =C2=A0struct device;
> +struct dma_chan;
> =C2=A0
> =C2=A0void iio_dmaengine_buffer_teardown(struct iio_buffer *buffer);
> =C2=A0struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *de=
v,
> @@ -26,6 +27,10 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device =
*dev,
> =C2=A0					struct iio_dev *indio_dev,
> =C2=A0					const char *channel,
> =C2=A0					enum iio_buffer_direction dir);
> +int devm_iio_dmaengine_buffer_setup_with_handle(struct device *dev,
> +						struct iio_dev *indio_dev,
> +						struct dma_chan *chan,
> +						enum iio_buffer_direction
> dir);
> =C2=A0
> =C2=A0#define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
> =C2=A0	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
>=20


