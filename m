Return-Path: <linux-pwm+bounces-3889-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2552E9B03F7
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5FD1F22673
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27D51FB894;
	Fri, 25 Oct 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ORAz4F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CA70830;
	Fri, 25 Oct 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862703; cv=none; b=ZhPqJ42kIUMdU76p/BCBrp/VoCrBilpVblZcTAB4rPuX0STbPRImZ2OHDZVMz/OWbc4fNGxudb5hZJa8iOuOCo80Bz+CjIcR6EHy0Mczz9eDAMdt2UG1Uvezj9kHY/kN6vpShPDMjI10Dxlw7my9KtBRqXHGUxf5omZb5koGPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862703; c=relaxed/simple;
	bh=gQI8AnluPQVjf5h9lbIkR64rIZxE+qdCSb0pvD97Q9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8mmlK9K/jPCeL5HjA/Xsq6s9dY2LyJmjNf3xfZMatwqo0ukyintLcUxz+Yx7TDKFs6U4cQEDs7TZt6ChbDoLWs45ktomGEWV0YFXp1+eynGzBr3taTjRy9aIeCQxUBUOfC8z/3JmoEr08baiLFdqJYxU/61xCtmNUU1pQREEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/ORAz4F; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43152b79d25so18856215e9.1;
        Fri, 25 Oct 2024 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729862700; x=1730467500; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QG7Ws+6+SNR9ioREvh/7ICHjVTNzGhU7yaZq8M3HQ4=;
        b=O/ORAz4FnSJLjL3QUDEqLPryBDlOwuYrGdgpcnIBqihcYlOWcZPLGqTl6t12x6iB7d
         k/rvfJobgqeEHz3/1euOzjRT7jdcF8NQPxdp4tEb9YgzyQQtnhU1UPXpzXKec8Qv1Xzi
         EK5WZQI+6ZAOQuLkQiYnq+UFJNciYs/F5K5XE0XIktCVcnZk0zWInGUwJeuoyMDpHq1+
         4K1a9IiWQT3/FxsHSTANotkZBqjxcQVBalVVY6vgcVccdto0qPDdzQLu1NpssWueggOd
         DYgC2axNWeDaPmvwDiN/4cyhyjf973w4fCeGxexpJbHyzSlL0QDwn2pZe+GRn0UtU6Ul
         BQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862700; x=1730467500;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QG7Ws+6+SNR9ioREvh/7ICHjVTNzGhU7yaZq8M3HQ4=;
        b=bzs8OxEx11H3Aoibsj5vK6eKdgpbNp2S1thxHwqc1Phu6VJTMHlljsvLxZu2OnmyEA
         nPWdDtGcmRkQA4EoQemKM8ac+W3/vZRd6/c4oBdQtyjpXQLbM4hQrrlp9bPCB0L5RpmP
         SAy0viGXjB5SYOUAx7pngV5UH8MX2T+oW82Wu2FeHvuJPVt1/u7nVsLyO+epMK+3UgZG
         q+weJirLnbvZFAwQVfgolZTDsTkHj4floO9aGXheqJMuzn1/IU6rzGMY9qZSRqxxhml0
         maJD7eGHx07ohT611aZN5RQitKBTWqJ5TRh1PlM3egpcbyUmqgLRhD1Oki2OgZBCD7wd
         9PJA==
X-Forwarded-Encrypted: i=1; AJvYcCUdpCoIHLvY6dyKAY0WhrGZsaljMyhk3AxYGwen6Q+/GWKpghHcNW3McDitDIKvom9SVlh9eXzKmux7C71k@vger.kernel.org, AJvYcCUqtj4cgD7PONt4k63eb7qV9YuHtQUPHfi3CzjQIUzgL7kG/5OKxHXfkoZTOdDnUjrhB3GKC2jbzLxn@vger.kernel.org, AJvYcCVRtG4EZeA5GuENCT4JKRREqv5RNbxCnly2cAtRsLtHL8kVdZSCuWy47R4YAOSv5LzOfX6rL+YqKdYJ@vger.kernel.org, AJvYcCWfaz29KHUngZjynUKbnDK3zp5zPMVe5lahCDt53wJfAejcW03aSvUkM1RBy/cgkYi2gfl/Nr11ujGu@vger.kernel.org, AJvYcCXcQ7wX6pAnx43dt4Q8QjI6OqxJ/5EuHZ7Ax3IlZskwnDtQFtZViHW8J8NfemIM6zOl+3JkntQyE7iu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4v2kfXQMKzQrfZPn1LDiD0G1gHa40evQy65IMSBKq4hI4umW
	Y0Z4vRb4pbTavgrDcg9tLMOjSAS7WGuHMRJjsVyNE7eYJtpISCgb
X-Google-Smtp-Source: AGHT+IF1i/8pAlv114ybh4HJ+3sr/T3dg6DbQ/nVTN+F6FLTDerxqpIrM0OKiBQlHItNSqGIpLa1ig==
X-Received: by 2002:a05:600c:35cd:b0:430:52ec:1e41 with SMTP id 5b1f17b1804b1-4318415c0acmr96593995e9.17.1729862699565;
        Fri, 25 Oct 2024 06:24:59 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a4c0esm17805085e9.27.2024.10.25.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:24:59 -0700 (PDT)
Message-ID: <1f4156e8c6c4da09fc5d72661d1e002ae6ee4f31.camel@gmail.com>
Subject: Re: [PATCH RFC v4 11/15] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 25 Oct 2024 15:24:58 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-11-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-11-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I still need to look better at this but I do have one though already :)

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
> cases where the DMA channel is managed by the caller rather than being
> requested and released by the iio_dmaengine module.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v4 changes:
> * This replaces "iio: buffer-dmaengine: generalize requesting DMA channel=
"
> ---
> =C2=A0drivers/iio/buffer/industrialio-buffer-dmaengine.c | 107 ++++++++++=
+++++------
> =C2=A0include/linux/iio/buffer-dmaengine.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A02 files changed, 81 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 054af21dfa65..602cb2e147a6 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -33,6 +33,7 @@ struct dmaengine_buffer {
> =C2=A0	struct iio_dma_buffer_queue queue;
> =C2=A0
> =C2=A0	struct dma_chan *chan;
> +	bool owns_chan;
> =C2=A0	struct list_head active;
> =C2=A0
> =C2=A0	size_t align;
> @@ -216,28 +217,23 @@ static const struct iio_dev_attr
> *iio_dmaengine_buffer_attrs[] =3D {
> =C2=A0 * Once done using the buffer iio_dmaengine_buffer_free() should be=
 used to
> =C2=A0 * release it.
> =C2=A0 */
> -static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> -	const char *channel)
> +static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *ch=
an,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 bool owns_chan)
> =C2=A0{
> =C2=A0	struct dmaengine_buffer *dmaengine_buffer;
> =C2=A0	unsigned int width, src_width, dest_width;
> =C2=A0	struct dma_slave_caps caps;
> -	struct dma_chan *chan;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	dmaengine_buffer =3D kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL=
);
> -	if (!dmaengine_buffer)
> -		return ERR_PTR(-ENOMEM);
> -
> -	chan =3D dma_request_chan(dev, channel);
> -	if (IS_ERR(chan)) {
> -		ret =3D PTR_ERR(chan);
> -		goto err_free;
> +	if (!dmaengine_buffer) {
> +		ret =3D -ENOMEM;
> +		goto err_release;
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D dma_get_slave_caps(chan, &caps);
> =C2=A0	if (ret < 0)
> -		goto err_release;
> +		goto err_free;
> =C2=A0
> =C2=A0	/* Needs to be aligned to the maximum of the minimums */
> =C2=A0	if (caps.src_addr_widths)
> @@ -252,6 +248,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(=
struct
> device *dev,
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&dmaengine_buffer->active);
> =C2=A0	dmaengine_buffer->chan =3D chan;
> +	dmaengine_buffer->owns_chan =3D owns_chan;
> =C2=A0	dmaengine_buffer->align =3D width;
> =C2=A0	dmaengine_buffer->max_size =3D dma_get_max_seg_size(chan->device->=
dev);
> =C2=A0
> @@ -263,10 +260,12 @@ static struct iio_buffer *iio_dmaengine_buffer_allo=
c(struct
> device *dev,
> =C2=A0
> =C2=A0	return &dmaengine_buffer->queue.buffer;
> =C2=A0
> -err_release:
> -	dma_release_channel(chan);
> =C2=A0err_free:
> =C2=A0	kfree(dmaengine_buffer);
> +err_release:
> +	if (owns_chan)
> +		dma_release_channel(chan);
> +
> =C2=A0	return ERR_PTR(ret);
> =C2=A0}
> =C2=A0
> @@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct iio_buffer *b=
uffer)
> =C2=A0		iio_buffer_to_dmaengine_buffer(buffer);
> =C2=A0
> =C2=A0	iio_dma_buffer_exit(&dmaengine_buffer->queue);
> -	dma_release_channel(dmaengine_buffer->chan);
> -
> =C2=A0	iio_buffer_put(buffer);
> +
> +	if (dmaengine_buffer->owns_chan)
> +		dma_release_channel(dmaengine_buffer->chan);

Not sure if I agree much with this owns_chan flag. The way I see it, we sho=
uld always
handover the lifetime of the DMA channel to the IIO DMA framework. Note tha=
t even the
device you pass in for both requesting the channel of the spi_offload  and =
for
setting up the DMA buffer is the same (and i suspect it will always be) so =
I would
not go with the trouble. And with this assumption we could simplify a bit m=
ore the
spi implementation.

And not even related but I even suspect the current implementation could be
problematic. Basically I'm suspecting that the lifetime of the DMA channel =
should be
attached to the lifetime of the iio_buffer. IOW, we should only release the=
 channel
in iio_dmaengine_buffer_release() - in which case the current implementatio=
n with the
spi_offload would also be buggy.

But bah, the second point is completely theoretical and likely very hard to=
 reproduce
in real life (if reproducible at all - for now it's only something I suspec=
t)

- Nuno S=C3=A1=20



