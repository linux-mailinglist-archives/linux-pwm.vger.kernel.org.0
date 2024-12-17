Return-Path: <linux-pwm+bounces-4363-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D049F4A08
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E830916BA52
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C01EC4EE;
	Tue, 17 Dec 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViFIv6EI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F11EE7CD;
	Tue, 17 Dec 2024 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435535; cv=none; b=aWqUgO4SGP+9E9lNyt7fNlIgf8EIJQ5rgnPC/30keNJ4Y/LCdgF0sX0CwLhqEeCS8bxqIf6MSNuo5rao0li+yx/aVuByJWbyu3C+KOzfFJRa643BCdNP0bQVJTF5DwSH3h5JU/KuuIzndaVdpDSzG51uEA0wJxrEyIxKdJ3HWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435535; c=relaxed/simple;
	bh=KvnTYxI8YUX12FeEY3Y1xj00f/dNNiG+vcVSvSoFUzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=io1LlzB0xEk0YTT7FFsLfhbonjZOOMe5mGfL74hBWqIyzp0Ck4ILW41uLJXTWpM8kZ3/w2G2g9zQZa6mtCcgi90DGOllWBq+UIHZ3bR1HudPZ/cQjmx2pLB6W4vxQ5RhhJzlReo1GiMQuCBWEr5XpM8v0c+u56GZ7VF//NPgdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViFIv6EI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so11647254a12.1;
        Tue, 17 Dec 2024 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734435530; x=1735040330; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s9QD7dqpdYUL8soJqVW92nzK/D4CicxOcT6272SeH60=;
        b=ViFIv6EIdfhpZPEzLwKQcXAIXU/Sh+HXzmv08kiqFA1/yjF3/iaQDqUJbRzLK3gnov
         XGiF3qq2Unvflcuy1JW23OfRq8DT6hRAwe+S0Xl41TquUO8hCGQBUh1V/clG7XPji7Oh
         RZ16TMUftD/UJoX3mIp3fTQQj++H2KeSS/g4Arkr0pQTg94rBtpy5TiYJZY53VY6E9RN
         m8lOHH/Fav2/Z6XceborJxZ2ALHCMhlDaYywT3jPLYWjGTv0Qr53A00qzienAvYlqNvb
         yTcTEiTR/jqY6KObpUmWVbZ1Vgu1SST8ZaLfvliKIspfzYzu8bK6hzRBXYUR+xAV74e/
         uW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435530; x=1735040330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9QD7dqpdYUL8soJqVW92nzK/D4CicxOcT6272SeH60=;
        b=lh78xqr6uXe3IUo6qBm8gYDMIg4bagncrt8/A7WrgEazRBFBHzv5gWTehlZ0Zk91mI
         BfsUglGKcpT3ALVNY+ytn9LNWP+Pk5BWsBOPcQB3CG5+/+SvklOYgpB8/AVu1dxdEu+M
         tIkWg4G7hoHoGfhQM3+0vGy/OHojYkyEsTe+eqryub/RVMA7vqRcihYgcH5bhSFv2xtS
         J644aXB6ASsWaafIqY0fINRFRKTfwLXqbv5+3XRVy9ZYlk+P7yzDznvUkNiK5IjKTJNr
         9L6PUhCv/gqE9rdjlyd0XSRv7n6QvH50i9EueSqgzCJ9QwicvyHvZaIjOrCmV9ws2jh1
         bV8g==
X-Forwarded-Encrypted: i=1; AJvYcCU88A6XpvTW3BXogWy3Fq986O6JC3Zz6pmyMnUg+vE70OabDoZSO2HxxHo1cdVfo3FDGU90XimJQSP3@vger.kernel.org, AJvYcCVjyQX/PkVMFI6TTWj42zhWmb+D0321G8wdicDhGKdNBvHS9gfXR2/kqcZSsRWUwNpg/P9mD37CNDWg@vger.kernel.org, AJvYcCW9ZKNQUIkTUNATEAaeAdNaPYjB15bF2YtHM8oKLqjNrDtRDYHyDfUez2+GCL+/AmltCqpFBChMGEH6@vger.kernel.org, AJvYcCWm4sPoayMJ2SdwvF4LCQrNZW8YN6T7VqoQbhIrd/6ZJu/C3KB3w1P+s0OcQeWYvtC/+7h9kaF4mAwS@vger.kernel.org, AJvYcCXuKia277XsQ9XlavG8q88Ue+Ok5WFhaMe6F0rD+TekMYQr1uKQzWfjTO0LkZShzITK1MObJrH5IAQPahVV@vger.kernel.org
X-Gm-Message-State: AOJu0YwKY2B/1KSVQ61T5x+2s8S//6WJm2JmDw7FgTMvVauIuz9Kn01a
	cYudCKIyqHOZY2rjWm+sx4fOmxWsYG6ID6VljveiRs1ic/G31Txa
X-Gm-Gg: ASbGncvPAu7vYBK0efJ4xNrzhaiFkbaVG+R88Wduzal7esP44+qLH6sUTqOpjMHVUzw
	lCtGNauYhad4UJKGHfrowUAQtmAbMMoNqYDn2hAx5B3RDB/J73WpyavOtpU4fpq/0PfUH6qqjFU
	29vFZZ9/srA1Sq5R2M2XnAwrmS+sb4UKO6ahlCaNPBG8zbrA6kgWeQ/bBFFFOHrSzqqjp5qe2lU
	Co1zXcp4w4E04XHIZhc/erut6mZ/W1FCVdcwqxFgKVLtIR0uk/h/vsdKsbSMXX0yVSMMfbYOhb6
	sGm1gneyASQ635SKCHba7qoq05l74UjCaxQMiTgMrEouvljxCaN++FlcFC458HvPBI10s3q1mbO
	HM2Ng4jjvpo5viA==
X-Google-Smtp-Source: AGHT+IHI2uSoRd4nv38/UiT7z1RDJI76U0j9ufGggNp6XehIwkcjGObzp/kYZGv9uLlqM5HAgwVtGw==
X-Received: by 2002:a17:907:1c01:b0:aa6:bcc2:3f02 with SMTP id a640c23a62f3a-aabdcb7fddamr248157266b.29.1734435529455;
        Tue, 17 Dec 2024 03:38:49 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96069d06sm435064866b.77.2024.12.17.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:38:49 -0800 (PST)
Message-ID: <b5b454acec976a6fe2dece85191cda941d0d0cb3.camel@gmail.com>
Subject: Re: [PATCH v6 05/17] spi: add offload TX/RX streaming APIs
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
Date: Tue, 17 Dec 2024 12:43:20 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-5-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-5-88ee574d5d03@baylibre.com>
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
> Most configuration of SPI offloads is handled opaquely using the offload
> pointer that is passed to the various offload functions. However, there
> are some offload features that need to be controlled on a per transfer
> basis.
>=20
> This patch adds a flag field to struct spi_transfer to allow specifying
> such features. The first feature to be added is the ability to stream
> data to/from a hardware sink/source rather than using a tx or rx buffer.
> Additional flags can be added in the future as needed.
>=20
> A flags field is also added to the offload struct for providers to
> indicate which flags are supported. This allows for generic checking of
> offload capabilities during __spi_validate() so that each offload
> provider doesn't have to implement their own validation.
>=20
> As a first users of this streaming capability, getter functions are
> added to get a DMA channel that is directly connected to the offload.
> Peripheral drivers will use this to get a DMA channel and configure it
> to suit their needs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---


Still not sure about releasing the channel. But I guess this might be also =
a
problem today with "plain" IIO DMA buffering. So...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v6 changes:
> * Update for header file split.
> * Fix wrong kernel-doc comments.
>=20
> v5 change:
> * Remove incorrect comment about caller needing to release DMA channels.
>=20
> v4 changes:
> * DMA API's now automatically release DMA channels instead of leaving
> =C2=A0 it up to the caller.
>=20
> v3 changes:
> * Added spi_offload_{tx,rx}_stream_get_dma_chan() functions.
>=20
> v2 changes:
> * This is also split out from "spi: add core support for controllers with
> =C2=A0 offload capabilities".
> * In the previous version, we were using (void *)-1 as a sentinel value
> =C2=A0 that could be assigned, e.g. to rx_buf. But this was naive since t=
here
> =C2=A0 is core code that would try to dereference this pointer. So instea=
d,
> =C2=A0 we've added a new flags field to the spi_transfer structure for th=
is
> =C2=A0 sort of thing. This also has the advantage of being able to be use=
d in
> =C2=A0 the future for other arbitrary features.
> ---
> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 70
> ++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++=
+++
> =C2=A0include/linux/spi/offload/consumer.h |=C2=A0 5 +++
> =C2=A0include/linux/spi/offload/types.h=C2=A0=C2=A0=C2=A0 | 19 ++++++++++
> =C2=A0include/linux/spi/spi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> =C2=A05 files changed, 107 insertions(+)
>=20
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index
> 43582e50e279c4b1b958765fec556aaa91180e55..df5e963d5ee29d37833559595536a46=
0c530
> bc81 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -18,6 +18,7 @@
> =C2=A0
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/device.h>
> +#include <linux/dmaengine.h>
> =C2=A0#include <linux/export.h>
> =C2=A0#include <linux/kref.h>
> =C2=A0#include <linux/list.h>
> @@ -332,6 +333,75 @@ void spi_offload_trigger_disable(struct spi_offload
> *offload,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
> =C2=A0
> +static void spi_offload_release_dma_chan(void *chan)
> +{
> +	dma_release_channel(chan);
> +}
> +
> +/**
> + * devm_spi_offload_tx_stream_request_dma_chan - Get the DMA channel inf=
o for
> the TX stream
> + * @dev: Device for devm purposes.
> + * @offload: Offload instance
> + *
> + * This is the DMA channel that will provide data to transfers that use =
the
> + * %SPI_OFFLOAD_XFER_TX_STREAM offload flag.
> + *
> + * Return: Pointer to DMA channel info, or negative error code
> + */
> +struct dma_chan
> +*devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload *offload)
> +{
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	if (!offload->ops || !offload->ops->tx_stream_request_dma_chan)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	chan =3D offload->ops->tx_stream_request_dma_chan(offload);
> +	if (IS_ERR(chan))
> +		return chan;
> +
> +	ret =3D devm_add_action_or_reset(dev, spi_offload_release_dma_chan,
> chan);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_tx_stream_request_dma_chan);
> +
> +/**
> + * devm_spi_offload_rx_stream_request_dma_chan - Get the DMA channel inf=
o for
> the RX stream
> + * @dev: Device for devm purposes.
> + * @offload: Offload instance
> + *
> + * This is the DMA channel that will receive data from transfers that us=
e the
> + * %SPI_OFFLOAD_XFER_RX_STREAM offload flag.
> + *
> + * Return: Pointer to DMA channel info, or negative error code
> + */
> +struct dma_chan
> +*devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload *offload)
> +{
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	if (!offload->ops || !offload->ops->rx_stream_request_dma_chan)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	chan =3D offload->ops->rx_stream_request_dma_chan(offload);
> +	if (IS_ERR(chan))
> +		return chan;
> +
> +	ret =3D devm_add_action_or_reset(dev, spi_offload_release_dma_chan,
> chan);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_rx_stream_request_dma_chan);
> +
> =C2=A0/* Triggers providers */
> =C2=A0
> =C2=A0static void spi_offload_trigger_unregister(void *data)
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index
> ff1add2ecb91f18cf82e6f1e9595584c11adf9d8..4a871db9ee636aba64c866ebdd8bb1d=
bf82e
> 0f42 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -31,6 +31,7 @@
> =C2=A0#include <linux/ptp_clock_kernel.h>
> =C2=A0#include <linux/sched/rt.h>
> =C2=A0#include <linux/slab.h>
> +#include <linux/spi/offload/types.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/spi/spi-mem.h>
> =C2=A0#include <uapi/linux/sched/types.h>
> @@ -4163,6 +4164,15 @@ static int __spi_validate(struct spi_device *spi,
> struct spi_message *message)
> =C2=A0
> =C2=A0		if (_spi_xfer_word_delay_update(xfer, spi))
> =C2=A0			return -EINVAL;
> +
> +		/* make sure controller supports required offload features */
> +		if (xfer->offload_flags) {
> +			if (!message->offload)
> +				return -EINVAL;
> +
> +			if (xfer->offload_flags & ~message->offload-
> >xfer_flags)
> +				return -EINVAL;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	message->status =3D -EINPROGRESS;
> diff --git a/include/linux/spi/offload/consumer.h
> b/include/linux/spi/offload/consumer.h
> index
> 5a0ec5303d600728959594bcdbd0cb2baeba7c77..cd7d5daa21e69b61c16eba6c10c8553=
45a4f
> 3297 100644
> --- a/include/linux/spi/offload/consumer.h
> +++ b/include/linux/spi/offload/consumer.h
> @@ -31,4 +31,9 @@ int spi_offload_trigger_enable(struct spi_offload *offl=
oad,
> =C2=A0void spi_offload_trigger_disable(struct spi_offload *offload,
> =C2=A0				 struct spi_offload_trigger *trigger);
> =C2=A0
> +struct dma_chan *devm_spi_offload_tx_stream_request_dma_chan(struct devi=
ce
> *dev,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 struct
> spi_offload *offload);
> +struct dma_chan *devm_spi_offload_rx_stream_request_dma_chan(struct devi=
ce
> *dev,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 struct
> spi_offload *offload);
> +
> =C2=A0#endif /* __LINUX_SPI_OFFLOAD_CONSUMER_H */
> diff --git a/include/linux/spi/offload/types.h
> b/include/linux/spi/offload/types.h
> index
> 7476f2073b02ee0f9edd3ae75e587b075746fa92..86d0e8cb9495bb43e177378b2041067=
de8ea
> 8786 100644
> --- a/include/linux/spi/offload/types.h
> +++ b/include/linux/spi/offload/types.h
> @@ -11,6 +11,11 @@
> =C2=A0
> =C2=A0struct device;
> =C2=A0
> +/* This is write xfer but TX uses external data stream rather than tx_bu=
f. */
> +#define SPI_OFFLOAD_XFER_TX_STREAM	BIT(0)
> +/* This is read xfer but RX uses external data stream rather than rx_buf=
. */
> +#define SPI_OFFLOAD_XFER_RX_STREAM	BIT(1)
> +
> =C2=A0/* Offload can be triggered by external hardware event. */
> =C2=A0#define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
> =C2=A0/* Offload can record and then play back TX data when triggered. */
> @@ -40,6 +45,8 @@ struct spi_offload {
> =C2=A0	void *priv;
> =C2=A0	/** @ops: callbacks for offload support */
> =C2=A0	const struct spi_offload_ops *ops;
> +	/** @xfer_flags: %SPI_OFFLOAD_XFER_* flags supported by provider */
> +	u32 xfer_flags;
> =C2=A0};
> =C2=A0
> =C2=A0enum spi_offload_trigger_type {
> @@ -75,6 +82,18 @@ struct spi_offload_ops {
> =C2=A0	 * given offload instance.
> =C2=A0	 */
> =C2=A0	void (*trigger_disable)(struct spi_offload *offload);
> +	/**
> +	 * @tx_stream_request_dma_chan: Optional callback for controllers
> that
> +	 * have an offload where the TX data stream is connected directly to
> a
> +	 * DMA channel.
> +	 */
> +	struct dma_chan *(*tx_stream_request_dma_chan)(struct spi_offload
> *offload);
> +	/**
> +	 * @rx_stream_request_dma_chan: Optional callback for controllers
> that
> +	 * have an offload where the RX data stream is connected directly to
> a
> +	 * DMA channel.
> +	 */
> +	struct dma_chan *(*rx_stream_request_dma_chan)(struct spi_offload
> *offload);
> =C2=A0};
> =C2=A0
> =C2=A0#endif /* __LINUX_SPI_OFFLOAD_TYPES_H */
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index
> 98bdc8c16c20521c0a94e5f72f5e71c4f6d7d11e..4c087009cf974595f23036b1b7a030a=
45913
> 420c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1093,6 +1093,9 @@ struct spi_transfer {
> =C2=A0
> =C2=A0	u32		effective_speed_hz;
> =C2=A0
> +	/* Use %SPI_OFFLOAD_XFER_* from spi-offload.h */
> +	unsigned int	offload_flags;
> +
> =C2=A0	unsigned int	ptp_sts_word_pre;
> =C2=A0	unsigned int	ptp_sts_word_post;
> =C2=A0
>=20


