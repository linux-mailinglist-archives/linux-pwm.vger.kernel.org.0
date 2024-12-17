Return-Path: <linux-pwm+bounces-4365-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0709F4A31
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A348167C53
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865F1F03D6;
	Tue, 17 Dec 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHudjG2M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53E1EE003;
	Tue, 17 Dec 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435938; cv=none; b=UQ/W5Ow0/LClf67WiTy+JJoOxAhathFLS/J0gYFOHiVsNMJtOxAhNfaHzeCPE85HVxFgi3xMJXMZ7ttipJDvzH93kbgOwRwV0BFi5FiT5p1xr4B/xIG4TgBw9tDuL/BhGSTcHvGrlwukYRGw8Ye+aEx9sC4Y5yGKUl6XddaXpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435938; c=relaxed/simple;
	bh=1QxA0ThG8Hw/1mobveKnYq2CQQTmC/zl76MgmO+RnKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brvwU5yw+oDN0dLi3hR5gv6yGAsT4uQRYGAAZ4kulbUT0AJvxHUJ9666/V9+TWqap4DgzeR84JlDh+ax8PbA7CK618BpqzxwHlFOBZRYc+1tApizUUvE0+6YC1ygiY/XQ/sZJvDYPKMdMyecXuRws0D43pgJBm7hFD4JboGAeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHudjG2M; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa67ac42819so841605666b.0;
        Tue, 17 Dec 2024 03:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734435935; x=1735040735; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3qYGMEZiXFK4S9hZLiH6C2uez+qDlZm9RyZiRWpHn0o=;
        b=hHudjG2MHgqyIioSWsqraEaOSUUFq3JE7QbcE4X9x6a3pXBkQDLgZKNThCdR7anl6t
         mgUr4eegKlxcCE7aTPaUpj85ausjExb9j7Ias4co7S4L0KaMJ8jEEfDyZNItrz0XWXQP
         KKXryhWffIqV41yK471SCjA/9DK1bkiXm/AJqDXhE0TAvQDRYUpGoYPIzsbqwJ2g+Wbg
         Uu3U6jDrVaYstTTZTiTL8sTLkr6xUA2BRmIYmlUgeYr7rXkEACsH92nSlZzeC3bvwZRh
         b03Mc7tR2iaN+2/bLB0yG/8FOXH/ryKdRkVdvdd10X+cG/ICYULmzo453xXtIA2azJ3k
         9AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435935; x=1735040735;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qYGMEZiXFK4S9hZLiH6C2uez+qDlZm9RyZiRWpHn0o=;
        b=wPowStnP8pJY9hoUvFequckDBkIk13s20QyUqnMLx2wvfOCfjfMb6npD7f0FkBEG0z
         i0kR96IMIwDxULEoq8Sr6aYviay+ZwqhYXyYfZIFt3cnTPb5iP3VuE3uAMqCHFN0BLzq
         0R4V/aznvo6B/LI8QqejcGhrNL4uqiL+EMXlW+3N+cqYzvWGZwA5Nmtnd4bJlKVO9IYg
         P0M323+Heo2FzKlT3OvbZGIL5rvsuBgn0nCIq0wpK5wNu+HyEmv6jNgbW2z2NXcaGp1x
         BFVRAH5NAVnJmMvGxQ7wcoHUZhCVm0MtGuTMaRdq2jHWjdQr29miG1yXaiqCSTkl8Hd1
         HBbg==
X-Forwarded-Encrypted: i=1; AJvYcCUA58n4f+fpTE0XCTWDSIiFAlRPcK1kaZBPNukwcCw8wWyx2KVNyuR2KB3QJ4/HMON7ehr86Rn1fr6S@vger.kernel.org, AJvYcCVmhPSmANhc7/rmxZh7jj21CSMeKsMIz9Zx5Kp4lg0XVr7b6p+Vd7dMFG2BN/xBdKA/EbcX0VS2iD1+@vger.kernel.org, AJvYcCW0SChBQansqoq0yebAbKkWMLyP8F/r7uxBsWiE8C+25DLwkvmzNXp0GTHUC76dpzow1RnQmcCIduXa@vger.kernel.org, AJvYcCWZsjsIvK5whPHzGAJpA0R+x7TAfIcmhsVf7NNE0AeDDHEXYzvqYPQDGpE8O3N11m7rebpgh2in5li4@vger.kernel.org, AJvYcCXNXyLUYCTFdXPNYEbmkWWJl80HChqs28BSvDa+3OhN4391sZusyhrmhfVc+FQ/+ZDYlqH9EBdMlguwsp9L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51Z1PupWLvLryztBB8CQfkpnnejPQsnzNJ75R6GPSeEp35JZ/
	AxIdKczsgXzKnJVHQnal8+BSp6ToCpRzfzQLycy4JUaUhW+3vcvL
X-Gm-Gg: ASbGncuEsI7PwjvRCzeQ/RPlpZHXto2gSwefwIGJRShc50nG6e82gIYoWhBRbIZI8N3
	cI8NCyRDHtdxJuVMcCaz1dyGqplpNDGFpe2p8zOSrOVwViZPi4oKaARmxYXodpV3flCrjDZjUX+
	KItkqIQ+XrNJ/lu9pkcfneh0Yr7UCrhWGYjONDXvi2Gb3zt9OjV9mFGv/8y1fAh/aYH87RqEglL
	lMC7nTK0Dso+1Y06wr0V4nQZ0PRCZS1DDQoanvmShVav+mqq5Q0NYJp8i3JlJ36hxi62Xtp6VH2
	2CSB70ErmHWt9LJtKfSK99xoFSKbMhHpHqA1i/KVBTZzjR0Jn835gCeh02nS0dVv9Bo83Nygv2r
	LVh+a9XrxhzYShQ==
X-Google-Smtp-Source: AGHT+IE/FtUjdgpst2Q5XCntLrVxameEZ0fydRC7Td2ArB40IA4+yVPKXYsZigOHyazemE2vGhN0HQ==
X-Received: by 2002:a17:907:60d6:b0:aa6:730c:acd with SMTP id a640c23a62f3a-aab7792c704mr1723001766b.16.1734435934367;
        Tue, 17 Dec 2024 03:45:34 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068933sm438077366b.79.2024.12.17.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:45:34 -0800 (PST)
Message-ID: <1538e69e5d36405d8d27de1140f5c9197c91e0d6.camel@gmail.com>
Subject: Re: [PATCH v6 08/17] iio: buffer-dmaengine: split requesting DMA
 channel from allocating buffer
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
Date: Tue, 17 Dec 2024 12:50:05 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-8-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-8-88ee574d5d03@baylibre.com>
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
> Refactor the IIO dmaengine buffer code to split requesting the DMA
> channel from allocating the buffer. We want to be able to add a new
> function where the IIO device driver manages the DMA channel, so these
> two actions need to be separate.
>=20
> To do this, calling dma_request_chan() is moved from
> iio_dmaengine_buffer_alloc() to iio_dmaengine_buffer_setup_ext(). A new
> __iio_dmaengine_buffer_setup_ext() helper function is added to simplify
> error unwinding and will also be used by a new function in a later
> patch.
>=20
> iio_dmaengine_buffer_free() now only frees the buffer and does not
> release the DMA channel. A new iio_dmaengine_buffer_teardown() function
> is added to unwind everything done in iio_dmaengine_buffer_setup_ext().
> This keeps things more symmetrical with obvious pairs alloc/free and
> setup/teardown.
>=20
> Calling dma_get_slave_caps() in iio_dmaengine_buffer_alloc() is moved so
> that we can avoid any gotos for error unwinding.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v6 changes:
> * Split out from patch that adds the new function
> * Dropped owns_chan flag
> * Introduced iio_dmaengine_buffer_teardown() so that
> =C2=A0 iio_dmaengine_buffer_free() doesn't have to manage the DMA channel
> ---
> =C2=A0drivers/iio/adc/adi-axi-adc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/iio/buffer/industrialio-buffer-dmaengine.c | 106 ++++++++++=
++--------
> -
> =C2=A0drivers/iio/dac/adi-axi-dac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0include/linux/iio/buffer-dmaengine.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A04 files changed, 65 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index
> c7357601f0f869e57636f00bb1e26c059c3ab15c..a55db308baabf7b26ea98431cab1e6a=
f7fe2
> a5f3 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -305,7 +305,7 @@ static struct iio_buffer *axi_adc_request_buffer(stru=
ct
> iio_backend *back,
> =C2=A0static void axi_adc_free_buffer(struct iio_backend *back,
> =C2=A0				struct iio_buffer *buffer)
> =C2=A0{
> -	iio_dmaengine_buffer_free(buffer);
> +	iio_dmaengine_buffer_teardown(buffer);
> =C2=A0}
> =C2=A0
> =C2=A0static int axi_adc_reg_access(struct iio_backend *back, unsigned in=
t reg,
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index
> 614e1c4189a9cdd5a8d9d8c5ef91566983032951..02847d3962fcbb43ec76167db6482ab=
951f2
> 0942 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -206,39 +206,29 @@ static const struct iio_dev_attr
> *iio_dmaengine_buffer_attrs[] =3D {
> =C2=A0
> =C2=A0/**
> =C2=A0 * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DM=
Aengine
> - * @dev: DMA channel consumer device
> - * @channel: DMA channel name, typically "rx".
> + * @chan: DMA channel.
> =C2=A0 *
> =C2=A0 * This allocates a new IIO buffer which internally uses the DMAeng=
ine
> framework
> - * to perform its transfers. The parent device will be used to request t=
he
> DMA
> - * channel.
> + * to perform its transfers.
> =C2=A0 *
> =C2=A0 * Once done using the buffer iio_dmaengine_buffer_free() should be=
 used to
> =C2=A0 * release it.
> =C2=A0 */
> -static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> -	const char *channel)
> +static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *ch=
an)
> =C2=A0{
> =C2=A0	struct dmaengine_buffer *dmaengine_buffer;
> =C2=A0	unsigned int width, src_width, dest_width;
> =C2=A0	struct dma_slave_caps caps;
> -	struct dma_chan *chan;
> =C2=A0	int ret;
> =C2=A0
> +	ret =3D dma_get_slave_caps(chan, &caps);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> =C2=A0	dmaengine_buffer =3D kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL=
);
> =C2=A0	if (!dmaengine_buffer)
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0
> -	chan =3D dma_request_chan(dev, channel);
> -	if (IS_ERR(chan)) {
> -		ret =3D PTR_ERR(chan);
> -		goto err_free;
> -	}
> -
> -	ret =3D dma_get_slave_caps(chan, &caps);
> -	if (ret < 0)
> -		goto err_release;
> -
> =C2=A0	/* Needs to be aligned to the maximum of the minimums */
> =C2=A0	if (caps.src_addr_widths)
> =C2=A0		src_width =3D __ffs(caps.src_addr_widths);
> @@ -262,12 +252,6 @@ static struct iio_buffer
> *iio_dmaengine_buffer_alloc(struct device *dev,
> =C2=A0	dmaengine_buffer->queue.buffer.access =3D &iio_dmaengine_buffer_op=
s;
> =C2=A0
> =C2=A0	return &dmaengine_buffer->queue.buffer;
> -
> -err_release:
> -	dma_release_channel(chan);
> -err_free:
> -	kfree(dmaengine_buffer);
> -	return ERR_PTR(ret);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -276,17 +260,57 @@ static struct iio_buffer
> *iio_dmaengine_buffer_alloc(struct device *dev,
> =C2=A0 *
> =C2=A0 * Frees a buffer previously allocated with iio_dmaengine_buffer_al=
loc().
> =C2=A0 */
> -void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
> +static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
> =C2=A0{
> =C2=A0	struct dmaengine_buffer *dmaengine_buffer =3D
> =C2=A0		iio_buffer_to_dmaengine_buffer(buffer);
> =C2=A0
> =C2=A0	iio_dma_buffer_exit(&dmaengine_buffer->queue);
> -	dma_release_channel(dmaengine_buffer->chan);
> -
> =C2=A0	iio_buffer_put(buffer);
> =C2=A0}
> -EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, "IIO_DMAENGINE_BUFFER");
> +
> +/**
> + * iio_dmaengine_buffer_teardown() - Releases DMA channel and frees buff=
er
> + * @buffer: Buffer to free
> + *
> + * Releases the DMA channel and frees the buffer previously setup with
> + * iio_dmaengine_buffer_setup_ext().
> + */
> +void iio_dmaengine_buffer_teardown(struct iio_buffer *buffer)
> +{
> +	struct dmaengine_buffer *dmaengine_buffer =3D
> +		iio_buffer_to_dmaengine_buffer(buffer);
> +	struct dma_chan *chan =3D dmaengine_buffer->chan;
> +
> +	iio_dmaengine_buffer_free(buffer);
> +	dma_release_channel(chan);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_teardown, "IIO_DMAENGINE_BUFFE=
R");
> +
> +static struct iio_buffer
> +*__iio_dmaengine_buffer_setup_ext(struct iio_dev *indio_dev,
> +				=C2=A0 struct dma_chan *chan,
> +				=C2=A0 enum iio_buffer_direction dir)
> +{
> +	struct iio_buffer *buffer;
> +	int ret;
> +
> +	buffer =3D iio_dmaengine_buffer_alloc(chan);
> +	if (IS_ERR(buffer))
> +		return ERR_CAST(buffer);
> +
> +	indio_dev->modes |=3D INDIO_BUFFER_HARDWARE;
> +
> +	buffer->direction =3D dir;
> +
> +	ret =3D iio_device_attach_buffer(indio_dev, buffer);
> +	if (ret) {
> +		iio_dmaengine_buffer_free(buffer);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return buffer;
> +}
> =C2=A0
> =C2=A0/**
> =C2=A0 * iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO=
 device
> @@ -300,7 +324,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free,
> "IIO_DMAENGINE_BUFFER");
> =C2=A0 * It also appends the INDIO_BUFFER_HARDWARE mode to the supported =
modes of
> the
> =C2=A0 * IIO device.
> =C2=A0 *
> - * Once done using the buffer iio_dmaengine_buffer_free() should be used=
 to
> + * Once done using the buffer iio_dmaengine_buffer_teardown() should be =
used
> to
> =C2=A0 * release it.
> =C2=A0 */
> =C2=A0struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *de=
v,
> @@ -308,30 +332,24 @@ struct iio_buffer *iio_dmaengine_buffer_setup_ext(s=
truct
> device *dev,
> =C2=A0						=C2=A0 const char *channel,
> =C2=A0						=C2=A0 enum iio_buffer_direction
> dir)
> =C2=A0{
> +	struct dma_chan *chan;
> =C2=A0	struct iio_buffer *buffer;
> -	int ret;
> -
> -	buffer =3D iio_dmaengine_buffer_alloc(dev, channel);
> -	if (IS_ERR(buffer))
> -		return ERR_CAST(buffer);
> -
> -	indio_dev->modes |=3D INDIO_BUFFER_HARDWARE;
> =C2=A0
> -	buffer->direction =3D dir;
> +	chan =3D dma_request_chan(dev, channel);
> +	if (IS_ERR(chan))
> +		return ERR_CAST(chan);
> =C2=A0
> -	ret =3D iio_device_attach_buffer(indio_dev, buffer);
> -	if (ret) {
> -		iio_dmaengine_buffer_free(buffer);
> -		return ERR_PTR(ret);
> -	}
> +	buffer =3D __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir);
> +	if (IS_ERR(buffer))
> +		dma_release_channel(chan);
> =C2=A0
> =C2=A0	return buffer;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup_ext, "IIO_DMAENGINE=
_BUFFER");
> =C2=A0
> -static void __devm_iio_dmaengine_buffer_free(void *buffer)
> +static void devm_iio_dmaengine_buffer_teardown(void *buffer)
> =C2=A0{
> -	iio_dmaengine_buffer_free(buffer);
> +	iio_dmaengine_buffer_teardown(buffer);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -357,7 +375,7 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device
> *dev,
> =C2=A0	if (IS_ERR(buffer))
> =C2=A0		return PTR_ERR(buffer);
> =C2=A0
> -	return devm_add_action_or_reset(dev,
> __devm_iio_dmaengine_buffer_free,
> +	return devm_add_action_or_reset(dev,
> devm_iio_dmaengine_buffer_teardown,
> =C2=A0					buffer);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext,
> "IIO_DMAENGINE_BUFFER");
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index
> b143f7ed6847277aeb49094627d90e5d95eed71c..5d5157af0a233143daff906b699bdae=
10f36
> 8867 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -168,7 +168,7 @@ static struct iio_buffer *axi_dac_request_buffer(stru=
ct
> iio_backend *back,
> =C2=A0static void axi_dac_free_buffer(struct iio_backend *back,
> =C2=A0				struct iio_buffer *buffer)
> =C2=A0{
> -	iio_dmaengine_buffer_free(buffer);
> +	iio_dmaengine_buffer_teardown(buffer);
> =C2=A0}
> =C2=A0
> =C2=A0enum {
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buf=
fer-
> dmaengine.h
> index
> 81d9a19aeb9199dd58bb9d35a91f0ec4b00846df..72a2e3fd8a5bf5e8f27ee226ddd9297=
9d233
> 754b 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -12,7 +12,7 @@
> =C2=A0struct iio_dev;
> =C2=A0struct device;
> =C2=A0
> -void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
> +void iio_dmaengine_buffer_teardown(struct iio_buffer *buffer);
> =C2=A0struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *de=
v,
> =C2=A0						=C2=A0 struct iio_dev *indio_dev,
> =C2=A0						=C2=A0 const char *channel,
>=20


