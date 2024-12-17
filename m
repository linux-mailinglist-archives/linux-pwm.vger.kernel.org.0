Return-Path: <linux-pwm+bounces-4360-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924169F49B1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70EE16D551
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7A1E6DDD;
	Tue, 17 Dec 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNuy8cZ6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546123DE;
	Tue, 17 Dec 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434210; cv=none; b=YvIqObxjX/fhyhyZNn0OAKfMrRp02x/E8ByXpWRNcCfjDcOGxcMRYSGtJdfynloKwoEZaOh6PcIFTRTq8AFLhY3fAkJj9rMevrY9fPl4BCbpFAj03FmwOp5gmI3DGldmCqJa+P5f2aKctrZMFBbmh0AZ7A6uFtlUCoChfprF5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434210; c=relaxed/simple;
	bh=9r76uWiVsZkk0Ky6kHMv8Au9zg2l4JB+H/FhyukW4qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WmO15PkVj+MRCFfN13xJIOYCFGUPPpHh2z0sf5ACKN8ZYqFQKu+kVa9yIM8WutlSHwEG6wJ/5aOEN4UDkN+kKypmyLamwhbelfkBwNoZBrQxrW3Xuo+7Zg+f+i+IdZfsCYJMWRM5qjF/XukN6QBancdfMBRYXJyg/tUPfLbX25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNuy8cZ6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa670ffe302so958917966b.2;
        Tue, 17 Dec 2024 03:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734434206; x=1735039006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50p+vsFZuae8KuN4WuUOPCCwEFfo+4q5lFUaqo7p7Vg=;
        b=bNuy8cZ6tFeIvg6gCjlRpB5c1IRMFWcAZBE8yostE5hSD+XHw+VipNf/0K1LST/uXQ
         xEh2PsuiF12/+sqrAb9NQZzxA3AdQolvnCWev/IgMAYX2JKa++B8iqK6s1POr/F1CBXE
         AbRwqkzpsrhQrr0muOgwM7H4tmt4VvHObA/E6Fj/H4wWaZnN5E8nmfwOgJZYi6fIxHU2
         Guy5KUk/aL7VxrzW7AdWLE/4J+4FxZ3jgjCXwfzecYJPcZChamED0Vx0ygw/Raho5l+s
         LgVDo6QszEMZxiVB6dgUrdD40rGEIdR2dfh/vJPUuIrZuenNsqoxtGEc8vWrIAVTElol
         V+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434206; x=1735039006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50p+vsFZuae8KuN4WuUOPCCwEFfo+4q5lFUaqo7p7Vg=;
        b=e6WDms0exFYhR7wSBZDAkMjKrS97usT934ejLFthfdu7E+0fHKjHHzEBgSdF+5IhPb
         BhVbh6kxHmxOtid6MLXTnPyFxn7+M/I1g0m81mrpi6ZKDWrnYxqjPTq+VWmdKlKHBc7U
         W2MgRsvlWxlED4cfD+ds7a3NvY9wfnPZfcLsEOU7Qn0pTYN8d3s3pT0Yjfeav0dRc6Wf
         1sKojwGhoRkwKcd4dmbA6bk+eGQpLFk/EDei59Gru0sy/eG2HB/YgXfFWsQd3im5oekI
         G5tOvS9Ti7XPnM+Ech1oyovwZrShW35SPK+JQMdXXq5wNIqPf3T+fQIE66ZnyT4QO7U8
         6IdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgexG5No6CTMW/hOJCt2Nj89UuAfNIBtdeAF22XV1gJInH8b+rADqpPbTRnunrjLwzq+3h8BUpFGHH@vger.kernel.org, AJvYcCVBtk5fKMPmuvulIj/uBitVn5QImr2oXWklPU2P1hJ7MF07sFYv/Ee+rYA/SoL8aVjVukYVMvNydjml@vger.kernel.org, AJvYcCVStOmUNwIzyskEhaAuWxMcpcFNMXMTvbNHIYOMOf1RMUQvPemIPhH8v22knkC5pNnIg75Y8HdJuAO+uaMM@vger.kernel.org, AJvYcCVhmU3xWucChna0Ee0tBfEv2gbBzyMHtU8tbSVh9HN0w1w/ZfIi239mpFoZ4m/QBBVootYsTswBuyDA@vger.kernel.org, AJvYcCWeJfc16Zgfakwx8QXQ2Ty7vT/CHj6JA1NDdjY54Wq7L7qfvgPRQAuq4zN0LoEKN4hpd0nYAGSyIR33@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYBil7Lw4+5Np7BY9JQJ8EwiTRwE/DhzIS/sR55BDA3AuVIpl
	kpN+lwSjwAsZvCwJLrCY/O9zcW0YrCc6psq5FRP2rfhSSn2tg7yX
X-Gm-Gg: ASbGncsas5t0bq3UbH2aHqzFV5L+HV8qZUBHd88cc9OyHHoh5txWJ7Ftr0BZd/rdKXj
	/lGlNjzwELGlAkC4zhGYAWni2elJmKifnE0tyt6KMzmSYzfXhQll1jRJQB8BLiXvIQg2tMr8kYj
	j3Qo9GSc22/U4j5lqrBVCu5M/XlmL8AXTkAwOqfTufLnecQbqoqKYeGgqC1lW40BmwInh9f3LXZ
	YE0IBha27/b3ritgTT2E0551Yy/7Rrrr64s8npFDgg+SM509dK74ZiQKA4NC2OVN6NbUON9DLoW
	EW+/P11Z1kiTwRKZSUf2j9nPASrlAu79xPOe3xcSXYiOxQqvCmCOUoRyXbAIgR4xbGeynwIlxM5
	8F/LiGjOTTRRMQA==
X-Google-Smtp-Source: AGHT+IFLsihsUhxwFKxvvp9zAg7r9wpTHmvJueg4WGWyY1KrWeNTSdVJ/OyjIcucQxArLBfOMHYUfQ==
X-Received: by 2002:a17:907:9623:b0:aa6:7cf3:c6f0 with SMTP id a640c23a62f3a-aab7792d033mr1714891566b.14.1734434205836;
        Tue, 17 Dec 2024 03:16:45 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359285sm438619466b.124.2024.12.17.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:16:45 -0800 (PST)
Message-ID: <da10fb157d6706e5dbf5ac5c871d3b5f19d0efce.camel@gmail.com>
Subject: Re: [PATCH v6 01/17] spi: add basic support for SPI offloading
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
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Tue, 17 Dec 2024 12:21:16 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-1-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-1-88ee574d5d03@baylibre.com>
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
> Add the basic infrastructure to support SPI offload providers and
> consumers.
>=20
> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
>=20
> SPI controllers with offload support need to implement the get_offload
> and put_offload callbacks and can use the devm_spi_offload_alloc() to
> allocate offload instances.
>=20
> SPI peripheral drivers will call devm_spi_offload_get() to get a
> reference to the matching offload instance. This offload instance can
> then be attached to a SPI message to request offloading that message.
>=20
> It is expected that SPI controllers with offload support will check for
> the offload instance in the SPI message in the ctlr->optimize_message()
> callback and handle it accordingly.
>=20
> CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
> consumer and provider drivers should `select SPI_OFFLOAD` in their
> Kconfig to ensure that the SPI core is built with offload support.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v6 changes:
> * Drop use of PTR_ERR_OR_ZERO().
> * Split header into types.h/provider.h/consumer.h.
> * Remove unused spi_controller_offload_ops forward declaration.
>=20
> v5 changes:
> * Don't include linux/property.h (moved to later patch).
> * Only allocate single offload instance instead of array.
> * Allocate *priv separately to avoid alignment issues.
> * Add put_offload() callback instead of assuming devm semantics.
> * Drop struct spi_offload::spi. It was only being used as a flag.
> * Don't get/put struct spi_offload::provider_dev.
> * Add MAINTAINERS entry for me as reviewer for anything related to
> =C2=A0 SPI offload.
>=20
> v4 changes:
> * SPI offload functions moved to a separate file instead of spi.c
> =C2=A0 (spi.c is already too long).
> * struct spi_offload and devm_spi_offload_get() are back, similar to
> =C2=A0 but improved over v1. This avoids having to pass the function ID
> =C2=A0 string to every function call and re-lookup the offload instance.
> * offload message prepare/unprepare functions are removed. Instead the
> =C2=A0 existing optimize/unoptimize functions should be used. Setting
> =C2=A0 spi_message::offload pointer is used as a flag to differentiate
> =C2=A0 between an offloaded message and a regular message.
>=20
> v3 changes:
> * Minor changes to doc comments.
> * Changed to use phandle array for spi-offloads.
> * Changed id to string to make use of spi-offload-names.
>=20
> v2 changes:
> * This is a rework of "spi: add core support for controllers with offload
> =C2=A0 capabilities" from v1.
> * The spi_offload_get() function that Nuno didn't like is gone. Instead,
> =C2=A0 there is now a mapping callback that uses the new generic devicetr=
ee
> =C2=A0 binding to request resources automatically when a SPI device is pr=
obed.
> * The spi_offload_enable/disable() functions for dealing with hardware
> =C2=A0 triggers are deferred to a separate patch.
> * This leaves adding spi_offload_prepare/unprepare() which have been
> =C2=A0 reworked to be a bit more robust.
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 ++
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 114
> +++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/spi/offload/consumer.h |=C2=A0 22 +++++++
> =C2=A0include/linux/spi/offload/provider.h |=C2=A0 19 ++++++
> =C2=A0include/linux/spi/offload/types.h=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++++=
+++++++++
> =C2=A0include/linux/spi/spi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 17 ++++++
> =C2=A08 files changed, 225 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index
> bf2dcd4e0261785add520b5eac747ceac523e112..9284a257607a740ab7f6fd960c2bcdc=
34ead
> 7586 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22129,6 +22129,12 @@
> F:	Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> =C2=A0F:	drivers/mtd/spi-nor/
> =C2=A0F:	include/linux/mtd/spi-nor.h
> =C2=A0
> +SPI OFFLOAD
> +R:	David Lechner <dlechner@baylibre.com>
> +F:	drivers/spi/spi-offload.c
> +F:	include/linux/spi/spi-offload.h
> +K:	spi_offload
> +
> =C2=A0SPI SUBSYSTEM
> =C2=A0M:	Mark Brown <broonie@kernel.org>
> =C2=A0L:	linux-spi@vger.kernel.org
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index
> ea8a310329274bb2701e265cd152a56fb4e0f3a7..02064a4e292815ec0213e2e446b4f90=
ed885
> 5a52 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -55,6 +55,9 @@ config SPI_MEM
> =C2=A0	=C2=A0 This extension is meant to simplify interaction with SPI me=
mories
> =C2=A0	=C2=A0 by providing a high-level interface to send memory-like com=
mands.
> =C2=A0
> +config SPI_OFFLOAD
> +	bool
> +
> =C2=A0comment "SPI Master Controller Drivers"
> =C2=A0
> =C2=A0config SPI_AIROHA_SNFI
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index
> 9db7554c1864bf9b37dcf59c16eb76f5af03a7e8..bb5fc20df21332232533c2e70c0cc23=
0f6bc
> f27f 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -10,6 +10,7 @@ ccflags-$(CONFIG_SPI_DEBUG) :=3D -DDEBUG
> =C2=A0obj-$(CONFIG_SPI_MASTER)		+=3D spi.o
> =C2=A0obj-$(CONFIG_SPI_MEM)			+=3D spi-mem.o
> =C2=A0obj-$(CONFIG_SPI_MUX)			+=3D spi-mux.o
> +obj-$(CONFIG_SPI_OFFLOAD)		+=3D spi-offload.o
> =C2=A0obj-$(CONFIG_SPI_SPIDEV)		+=3D spidev.o
> =C2=A0obj-$(CONFIG_SPI_LOOPBACK_TEST)		+=3D spi-loopback-test.o
> =C2=A0
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..3a40ef30debf09c6fd7b2c14526f3e5=
976e2
> b21f
> --- /dev/null
> +++ b/drivers/spi/spi-offload.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + */
> +
> +/*
> + * SPI Offloading support.
> + *
> + * Some SPI controllers support offloading of SPI transfers. Essentially=
,
> this
> + * is the ability for a SPI controller to perform SPI transfers with min=
imal
> + * or even no CPU intervention, e.g. via a specialized SPI controller wi=
th a
> + * hardware trigger or via a conventional SPI controller using a non-Lin=
ux
> MCU
> + * processor core to offload the work.
> + */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE "SPI_OFFLOAD"
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/mutex.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>
> +#include <linux/spi/offload/types.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +struct spi_controller_and_offload {
> +	struct spi_controller *controller;
> +	struct spi_offload *offload;
> +};
> +
> +/**
> + * devm_spi_offload_alloc() - Allocate offload instance
> + * @dev: Device for devm purposes and assigned to &struct
> spi_offload.provider_dev
> + * @priv_size: Size of private data to allocate
> + *
> + * Offload providers should use this to allocate offload instances.
> + *
> + * Return: Pointer to new offload instance or error on failure.
> + */
> +struct spi_offload *devm_spi_offload_alloc(struct device *dev,
> +					=C2=A0=C2=A0 size_t priv_size)
> +{
> +	struct spi_offload *offload;
> +	void *priv;
> +
> +	offload =3D devm_kzalloc(dev, sizeof(*offload), GFP_KERNEL);
> +	if (!offload)
> +		return ERR_PTR(-ENOMEM);
> +
> +	priv =3D devm_kzalloc(dev, priv_size, GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	offload->provider_dev =3D dev;
> +	offload->priv =3D priv;
> +
> +	return offload;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_alloc);
> +
> +static void spi_offload_put(void *data)
> +{
> +	struct spi_controller_and_offload *resource =3D data;
> +
> +	resource->controller->put_offload(resource->offload);
> +	kfree(resource);
> +}
> +
> +/**
> + * devm_spi_offload_get() - Get an offload instance
> + * @dev: Device for devm purposes
> + * @spi: SPI device to use for the transfers
> + * @config: Offload configuration
> + *
> + * Peripheral drivers call this function to get an offload instance that
> meets
> + * the requirements specified in @config. If no suitable offload instanc=
e is
> + * available, -ENODEV is returned.
> + *
> + * Return: Offload instance or error on failure.
> + */
> +struct spi_offload *devm_spi_offload_get(struct device *dev,
> +					 struct spi_device *spi,
> +					 const struct spi_offload_config
> *config)
> +{
> +	struct spi_controller_and_offload *resource;
> +	int ret;
> +
> +	if (!spi || !config)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!spi->controller->get_offload)
> +		return ERR_PTR(-ENODEV);
> +
> +	resource =3D kzalloc(sizeof(*resource), GFP_KERNEL);
> +	if (!resource)
> +		return ERR_PTR(-ENOMEM);
> +
> +	resource->controller =3D spi->controller;
> +	resource->offload =3D spi->controller->get_offload(spi, config);
> +	if (IS_ERR(resource->offload)) {
> +		kfree(resource);
> +		return resource->offload;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, spi_offload_put, resource);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return resource->offload;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_get);
> diff --git a/include/linux/spi/offload/consumer.h
> b/include/linux/spi/offload/consumer.h
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..05543dbedf3086fb4befcd149cff3c8=
c70a8
> 8825
> --- /dev/null
> +++ b/include/linux/spi/offload/consumer.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + */
> +
> +#ifndef __LINUX_SPI_OFFLOAD_CONSUMER_H
> +#define __LINUX_SPI_OFFLOAD_CONSUMER_H
> +
> +#include <linux/module.h>
> +#include <linux/spi/offload/types.h>
> +#include <linux/types.h>
> +
> +MODULE_IMPORT_NS("SPI_OFFLOAD");
> +
> +struct device;
> +struct spi_device;
> +
> +struct spi_offload *devm_spi_offload_get(struct device *dev, struct
> spi_device *spi,
> +					 const struct spi_offload_config
> *config);
> +
> +#endif /* __LINUX_SPI_OFFLOAD_CONSUMER_H */
> diff --git a/include/linux/spi/offload/provider.h
> b/include/linux/spi/offload/provider.h
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..278c4edfcdb7b1f43870ca99d2ba252=
bf282
> 0576
> --- /dev/null
> +++ b/include/linux/spi/offload/provider.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + */
> +
> +#ifndef __LINUX_SPI_OFFLOAD_PROVIDER_H
> +#define __LINUX_SPI_OFFLOAD_PROVIDER_H
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +MODULE_IMPORT_NS("SPI_OFFLOAD");
> +
> +struct device;
> +
> +struct spi_offload *devm_spi_offload_alloc(struct device *dev, size_t
> priv_size);
> +
> +#endif /* __LINUX_SPI_OFFLOAD_PROVIDER_H */
> diff --git a/include/linux/spi/offload/types.h
> b/include/linux/spi/offload/types.h
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..a74f8d84541b10062353e81a638f056=
28b69
> 6394
> --- /dev/null
> +++ b/include/linux/spi/offload/types.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + */
> +
> +#ifndef __LINUX_SPI_OFFLOAD_TYPES_H
> +#define __LINUX_SPI_OFFLOAD_TYPES_H
> +
> +#include <linux/types.h>
> +
> +struct device;
> +
> +/* Offload can be triggered by external hardware event. */
> +#define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
> +/* Offload can record and then play back TX data when triggered. */
> +#define SPI_OFFLOAD_CAP_TX_STATIC_DATA		BIT(1)
> +/* Offload can get TX data from an external stream source. */
> +#define SPI_OFFLOAD_CAP_TX_STREAM_DMA		BIT(2)
> +/* Offload can send RX data to an external stream sink. */
> +#define SPI_OFFLOAD_CAP_RX_STREAM_DMA		BIT(3)
> +
> +/**
> + * struct spi_offload_config - offload configuration
> + *
> + * This is used to request an offload with specific configuration.
> + */
> +struct spi_offload_config {
> +	/** @capability_flags: required capabilities. See %SPI_OFFLOAD_CAP_*
> */
> +	u32 capability_flags;
> +};
> +
> +/**
> + * struct spi_offload - offload instance
> + */
> +struct spi_offload {
> +	/** @provider_dev: for get/put reference counting */
> +	struct device *provider_dev;
> +	/** @priv: provider driver private data */
> +	void *priv;
> +};
> +
> +#endif /* __LINUX_SPI_OFFLOAD_TYPES_H */
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index
> 8497f4747e24d4ecd85b74f49609ac1c82c73535..98bdc8c16c20521c0a94e5f72f5e71c=
4f6d7
> d11e 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -31,6 +31,8 @@ struct spi_transfer;
> =C2=A0struct spi_controller_mem_ops;
> =C2=A0struct spi_controller_mem_caps;
> =C2=A0struct spi_message;
> +struct spi_offload;
> +struct spi_offload_config;
> =C2=A0
> =C2=A0/*
> =C2=A0 * INTERFACES between SPI master-side drivers and SPI slave protoco=
l
> handlers,
> @@ -496,6 +498,10 @@ extern struct spi_device *spi_new_ancillary_device(s=
truct
> spi_device *spi, u8 ch
> =C2=A0 * @mem_ops: optimized/dedicated operations for interactions with S=
PI memory.
> =C2=A0 *	=C2=A0=C2=A0=C2=A0=C2=A0 This field is optional and should only =
be implemented if the
> =C2=A0 *	=C2=A0=C2=A0=C2=A0=C2=A0 controller has native support for memor=
y like operations.
> + * @get_offload: callback for controllers with offload support to get
> matching
> + *	offload instance. Implementations should return -ENODEV if no match
> is
> + *	found.
> + * @put_offload: release the offload instance acquired by @get_offload.
> =C2=A0 * @mem_caps: controller capabilities for the handling of memory op=
erations.
> =C2=A0 * @unprepare_message: undo any work done by prepare_message().
> =C2=A0 * @target_abort: abort the ongoing transfer request on an SPI targ=
et
> controller
> @@ -740,6 +746,10 @@ struct spi_controller {
> =C2=A0	const struct spi_controller_mem_ops *mem_ops;
> =C2=A0	const struct spi_controller_mem_caps *mem_caps;
> =C2=A0
> +	struct spi_offload *(*get_offload)(struct spi_device *spi,
> +					=C2=A0=C2=A0 const struct spi_offload_config
> *config);
> +	void (*put_offload)(struct spi_offload *offload);
> +
> =C2=A0	/* GPIO chip select */
> =C2=A0	struct gpio_desc	**cs_gpiods;
> =C2=A0	bool			use_gpio_descriptors;
> @@ -1108,6 +1118,7 @@ struct spi_transfer {
> =C2=A0 * @state: for use by whichever driver currently owns the message
> =C2=A0 * @opt_state: for use by whichever driver currently owns the messa=
ge
> =C2=A0 * @resources: for resource management when the SPI message is proc=
essed
> + * @offload: (optional) offload instance used by this message
> =C2=A0 *
> =C2=A0 * A @spi_message is used to execute an atomic sequence of data tra=
nsfers,
> =C2=A0 * each represented by a struct spi_transfer.=C2=A0 The sequence is=
 "atomic"
> @@ -1168,6 +1179,12 @@ struct spi_message {
> =C2=A0	 */
> =C2=A0	void			*opt_state;
> =C2=A0
> +	/*
> +	 * Optional offload instance used by this message. This must be set
> +	 * by the peripheral driver before calling spi_optimize_message().
> +	 */
> +	struct spi_offload	*offload;
> +
> =C2=A0	/* List of spi_res resources when the SPI message is processed */
> =C2=A0	struct list_head=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resourc=
es;
> =C2=A0};
>=20


