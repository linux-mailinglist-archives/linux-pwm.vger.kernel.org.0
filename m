Return-Path: <linux-pwm+bounces-3823-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BB9AE686
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3637289716
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EAF1F76CD;
	Thu, 24 Oct 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD8d0D6J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623F1BBBEB;
	Thu, 24 Oct 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776442; cv=none; b=ReGCdo8LozE9iJVWzwCe7IsmPIyyxgsN8X1xMP7I8cE/jwIdoPbtCo6T2fEJ83hOUSJ25nuaTqn1wre4vWS0zXXpGSUhi8OFYcsS34MaU2dKRD59h8mg/8H1dwziQvj09P7YlaqsFW/rjC420iLUulIkzGPQXjv7do7YyfLBHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776442; c=relaxed/simple;
	bh=YqJofZ36BW/TRJuXv7SdP08LIVcE0smc5fN4el3bLKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQNoOChkSxiEKYAe/e5g25Vx7hb6Z3csdy6VY3sjgdOlZkI2IymMC1YGmPrIkQgHkDdyLTllwBXbZ9JJTSJs6vc6/KWuY/JZz4YfaZRISmo75zM2mU0Wjlg5yDOM89jEkjkfMomAgH3sQY6hMoJa21vb1SxNp1z7Z/i8CmW6aJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD8d0D6J; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so628503f8f.3;
        Thu, 24 Oct 2024 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729776438; x=1730381238; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lh/Aemo/gwLUT93xOhFMFPtYx/PANCkObOqWYsHf0oU=;
        b=lD8d0D6JzKgS6avhOD2Y8kCIaAWZwBC4r58OCH7ZXsmKtPlnZwWQW51D35axwB2ezm
         G3lzBk+obpvKKkrb8+RfYvHXjhgtuD+A1a+Km0PZjgVMia3skSU35+vk9jyPL8qyA7fx
         Cp6M5ZR3K8clBokpMEbtB0Uri0PN68m6GKRz1a/37gGFPCoNwLmxuAktcv4yTJRe5S/W
         01ljBeE0UqkbqOsW3WiaXpa+bG4ucyKyXD+uwyOcMwNOkmS+BIP1/YUYSLDWrdTKUdGK
         c8kDxAG/S2dBDX75V8peiCeO/lX5Q610fBUUhMc9Wk3l9C9dXopoYTZepuZiZsfkQ2SG
         kiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776438; x=1730381238;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lh/Aemo/gwLUT93xOhFMFPtYx/PANCkObOqWYsHf0oU=;
        b=QDaO1UHncYcmlkn89F0FWonzV6A72R+CVMc98kCeniBSVtLNMTY/A+8lw5sVfDORVR
         TDpw4FahKIhbmggOipquanE06U/Z9UqtGmXDWiT+/L7n96dR9gwR8RKgMn7gURmWtlbv
         WHbvfF/mb7n926AfRVl2SwK+uo2LhPv1b3N4rt4qPNe+SQlcvy/NbczETUjSimzxJ4Oz
         aehpoL8THnLNbOg7P1Qce9DvX18R/U98wVs+P7uc6+yMBs1Q5tg74UON5xotwnZiI9gw
         Bild6HTR19HuWOWfdT5j5V9BJGyOOfJQ9E0WtdK+SnOSbr1P42LicgFzyB6F1LkOQ7GF
         3ZCg==
X-Forwarded-Encrypted: i=1; AJvYcCU8msp3eoYJ8BP7vFe1eKv5tvVZ29j2DuJxddNM/XG5CTusxHQbIrJff8RDKCGLWIHNQgAR0ctAkaU0@vger.kernel.org, AJvYcCVE1Y/u9F7sxwHlyb5u4sFj7tADxCQ1syW31WnZF+Dp+1/0Qowg1vSOPC8IlVF13KgpX9WuRTzr9LgP@vger.kernel.org, AJvYcCVaQxmXqnY35rStocCRKvGXxSnBANU3qkRgcNx2Qh3A7Vaks46d5w+jZxfP2Mn47nUPGkzjSip6dDUu/FNK@vger.kernel.org, AJvYcCX+E5TzQ3WDto6RWgbF2PYix4t/8Vdh4fUq39uEHVifyQdBHj3gQBNYTv3r1VmOSxmAjyGvUjxTaNS2@vger.kernel.org, AJvYcCXwE0b3wpMfAD2UuCasTgdvpXg38MIchddg4oDGtwgJXm7NioBJEQ8akrDqKtVahSaYGRuicRhVZ5QB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kkk6VoHqJ+v4+sjbB8NjzO2z+JDC3Map1xg6AZFuHjgHiLmU
	wGbMCS58wGtvrH9SdlbYXs05i7sPv0nRCX59i2Wjbj0p5ytvDn8l
X-Google-Smtp-Source: AGHT+IF9o4FDi/qZPAdyapVJFH/1h0r+fDXv1zwkewBYzgCtc4WAQVTBFq7r/5rH6N5woWxjtXTKvA==
X-Received: by 2002:adf:e54b:0:b0:37d:4d80:34ae with SMTP id ffacd0b85a97d-37efcf00d4amr4051647f8f.4.1729776437276;
        Thu, 24 Oct 2024 06:27:17 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd6a52sm47556215e9.8.2024.10.24.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:27:17 -0700 (PDT)
Message-ID: <ba3eed090e29deda797b0dea8162949c82743ccf.camel@gmail.com>
Subject: Re: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
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
Date: Thu, 24 Oct 2024 15:27:15 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> Add the basic infrastructure to support SPI offload providers and
> consumers.
>=20
> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
>=20
> SPI controllers with offload support need to implement the get_offload
> callback and can use the devm_spi_offload_alloc() to allocate offload
> instances.
>=20
> SPI peripheral drivers will call devm_spi_offload_get() to get a
> reference to the matching offload instance. This offload instance can
> then be attached to a SPI message to request offloading that message.
>=20
> It is expected that SPI controllers with offload support will check for
> the offload instance in the SPI message in the optimize_message()
> callback and handle it accordingly.
>=20
> CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
> consumer and provider drivers should `select SPI_OFFLOAD` in their
> Kconfig to ensure that the SPI core is built with offload support.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Hi David,

Just one minor comment...

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
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 ++
> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 104=
 ++++++++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/spi/spi-offload.h |=C2=A0 64 ++++++++++++++++++++++++=
+
> =C2=A0include/linux/spi/spi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 16 +++++++
> =C2=A05 files changed, 188 insertions(+)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 823797217404..d65074b85f62 100644
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
> index a9b1bc259b68..6a470eb475a2 100644
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
> index 000000000000..c344cbf50bdb
> --- /dev/null
> +++ b/drivers/spi/spi-offload.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE SPI_OFFLOAD

Cool, was not aware of this :)
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi-offload.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +/**
> + * devm_spi_offload_alloc() - Allocate offload instances
> + * @dev: Device for devm purposes
> + * @num_offloads: Number of offloads to allocate
> + * @priv_size: Size of private data to allocate for each offload
> + *
> + * Offload providers should use this to allocate offload instances.
> + *
> + * Return: Pointer to array of offloads or error on failure.
> + */
> +struct spi_offload *devm_spi_offload_alloc(struct device *dev,
> +					=C2=A0=C2=A0 size_t num_offloads,
> +					=C2=A0=C2=A0 size_t priv_size)
> +{
> +	struct spi_offload *offloads;
> +	void *privs;
> +	size_t i;
> +
> +	offloads =3D devm_kcalloc(dev, num_offloads, sizeof(*offloads) + priv_s=
ize,
> +				GFP_KERNEL);
> +	if (!offloads)
> +		return ERR_PTR(-ENOMEM);
> +
> +	privs =3D (void *)(offloads + num_offloads);
> +
> +	for (i =3D 0; i < num_offloads; i++) {
> +		struct spi_offload *offload =3D offloads + i;
> +		void *priv =3D privs + i * priv_size;
> +
> +		offload->provider_dev =3D dev;
> +		offload->priv =3D priv;
> +	}
> +
> +	return offloads;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_alloc);
> +
> +static void spi_offload_put(void *data)
> +{
> +	struct spi_offload *offload =3D data;
> +
> +	offload->spi =3D NULL;
> +	put_device(offload->provider_dev);
> +}
> +
> +/**
> + * devm_spi_offload_get() - Get an offload instance
> + * @dev: Device for devm purposes
> + * @spi: SPI device to use for the transfers
> + * @config: Offload configuration
> + *
> + * Peripheral drivers call this function to get an offload instance that=
 meets
> + * the requirements specified in @config. If no suitable offload instanc=
e is
> + * available, -ENODEV is returned.
> + *
> + * Return: Offload instance or error on failure.
> + */
> +struct spi_offload *devm_spi_offload_get(struct device *dev,
> +					 struct spi_device *spi,
> +					 const struct spi_offload_config *config)
> +{
> +	struct spi_offload *offload;
> +	int ret;
> +
> +	if (!spi || !config)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!spi->controller->get_offload)
> +		return ERR_PTR(-ENODEV);
> +
> +	offload =3D spi->controller->get_offload(spi, config);
> +	if (IS_ERR(offload))
> +		return offload;
> +
> +	if (offload->spi)
> +		return ERR_PTR(-EBUSY);
> +
> +	offload->spi =3D spi;
> +	get_device(offload->provider_dev);

Isn't this redundant? From what I can tell, we're assuming that the spi con=
troller
(of the spi device) is the offload provider. Therefore, getting an extra re=
ference
for it does not really seems necessary. The device cannot go away without u=
nder the
spi_device feet. If that could happen, then we would also need to take care=
 about
callback access and things like that. Going this way, it would also be argu=
able to
have a try_module_get().

- Nuno S=C3=A1



