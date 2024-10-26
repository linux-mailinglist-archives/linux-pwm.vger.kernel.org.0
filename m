Return-Path: <linux-pwm+bounces-3912-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2859B18ED
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE22C28275C
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344520314;
	Sat, 26 Oct 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol1vw3xI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901B125A9;
	Sat, 26 Oct 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955180; cv=none; b=JckEwg9LkJwrVbYd6p4/5/4UeJtVeqIkimt0iu104Rj92kXAU1E3pNbXYtGEUuON43h+TfG11EYxK2hnsq8u7u31K8RwTDqmYD0J+ZCORaXRrbdiuSQeUHOh+8GSheO6CX1GvDMwlfBvHmmpoKO3Lv4aUo+mBjDirBvWy8TVdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955180; c=relaxed/simple;
	bh=AjFU2n0mS+GoL062AAzmBcSlZNEuG+C9Nk0pMIZQcUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9525ru4hBQzC2IIkMMWrGspZL0z0g0CQLmAY61P9yyhHPO7aB8OsixOqiuWgWF4NPefY9xhfVeywtaVZoO8qeOMoWC3/udq0Sryy1oW9AcCLlRhcEvj2H0ZIMBthn3NbPybn1OpdDPM6hYmJL2QFLyFFEwSfyHYKmOKIyu1ohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol1vw3xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6A6C4CEC6;
	Sat, 26 Oct 2024 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729955179;
	bh=AjFU2n0mS+GoL062AAzmBcSlZNEuG+C9Nk0pMIZQcUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ol1vw3xIRHJfwiLPHH9C3+12qYx0Eo8/LKiNWfPufsB83cRBMf7XeNmpdZrV4IMp7
	 G424Bu6R4aqB7aK43uGM9yfY++f3rMIT/Y8fqPLd+aeIcUwI6jGItc9LCvN1xe/lI6
	 Reu7C8UXeatj0SAx1Z+MWs5pQDxyP0e+hr3FMP7fH+Ajdlyq6bjC0F2DMy0WdooJ7O
	 egIPC10pL2GdKmW98Xxq8CAwCrt76DCU8Mdn41DeqiiUkTeEKr812fwe28OUOIcykK
	 73/PBjAO5XOr8Rr3VFCxNHWWf8Bj40yPt32uGZmkdmJIAkxB63KikLgxJKo2DiGtgC
	 TB2tc2WXSsMsg==
Date: Sat, 26 Oct 2024 16:05:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
Message-ID: <20241026160521.52205cb0@jic23-huawei>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 15:59:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add the basic infrastructure to support SPI offload providers and
> consumers.
> 
> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
> 
> SPI controllers with offload support need to implement the get_offload
> callback and can use the devm_spi_offload_alloc() to allocate offload
> instances.
> 
> SPI peripheral drivers will call devm_spi_offload_get() to get a
> reference to the matching offload instance. This offload instance can
> then be attached to a SPI message to request offloading that message.
> 
> It is expected that SPI controllers with offload support will check for
> the offload instance in the SPI message in the optimize_message()
> callback and handle it accordingly.
> 
> CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
> consumer and provider drivers should `select SPI_OFFLOAD` in their
> Kconfig to ensure that the SPI core is built with offload support.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
A few minor additions to what has already been raised.

Jonathan

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
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
?  If it is needed for later patch bring it in then.


> +#include <linux/spi/spi-offload.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
>
> +
> +/**
> + * devm_spi_offload_get() - Get an offload instance
> + * @dev: Device for devm purposes
> + * @spi: SPI device to use for the transfers
> + * @config: Offload configuration
> + *
> + * Peripheral drivers call this function to get an offload instance that meets
> + * the requirements specified in @config. If no suitable offload instance is
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
> +	offload = spi->controller->get_offload(spi, config);

Why let this return an offload that is already in use?
Maybe make that a problem for the spi controller
Seems odd to pass it spi then set it later.

I.e. have this return ERR_PTR(-EBUSY);


> +	if (IS_ERR(offload))
> +		return offload;
> +
> +	if (offload->spi)
> +		return ERR_PTR(-EBUSY);
> +
> +	offload->spi = spi;
> +	get_device(offload->provider_dev);
> +
> +	ret = devm_add_action_or_reset(dev, spi_offload_put, offload);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return offload;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_get);

