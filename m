Return-Path: <linux-pwm+bounces-4129-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D99D771D
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 19:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6981B23459
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906A188015;
	Sun, 24 Nov 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEvyY+us"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DF2500AF;
	Sun, 24 Nov 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732465971; cv=none; b=PoHYPUZVspo1ErZ/F7Wuf559WXvrAqt94oozOHUGkodE5/fKkPAaOQsevvU41jSVYFTCAr4cl+5/x6U5t03KvwYfcnnNRPuZ2tJfr8spbXEFU3Z4B0w0yyOTSCcEYwYVAiP6D0vWpuoUjI6FMutxrWiB/AK/ST2X8xwm8lbqx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732465971; c=relaxed/simple;
	bh=f6MqTaThXHiv7ctzSpq6dEgS0E7d2u5IGehjqemBuFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2Y0bNSEe77udwLB7j9qFUwBFmSlJx01ZbHBYAf/UtpAl9CAzPYmiqPwleiHntGQZ7aodSwGbGxpy49mim2eqTa1xjExL8LZr38Gy+kSa0H4qgo6LGJIvA5IW1AoXuB7yKdwzkkUSMuzC5WqTlxzaQr0XpDY/AXQHj47nEY2bpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEvyY+us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F4DC4CECC;
	Sun, 24 Nov 2024 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732465970;
	bh=f6MqTaThXHiv7ctzSpq6dEgS0E7d2u5IGehjqemBuFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JEvyY+us/11p4rR5ISmZ+PWPjfbyV2+x7g86iySrXAClfh8WjY1MY9lp7BBCZe091
	 HiFC8luDJfDPX4MEG+L/9K7YbSXRmupKPn+fE8b+9c6YrR9syKdmqBY8sjdFsr751r
	 n9XB+gXqlakEwSw9lNX8xh55QjcswhgCex0gnE6DDbZUeAmbIkI5YbG5dFFNFiWyxm
	 dvogF+BjrwhWgYe0h2/riVPhhUxcnkd5XZ7+06+taLzGd/j1O0fLzBm0L255V31nip
	 pgCNZllEfJnbanw7kLG9iAFYzqBNyy6t+Whl5UWzwGVco7ELjacw0jemrTj5TNbBcC
	 of0KnvkAH6ueA==
Date: Sun, 24 Nov 2024 16:32:41 +0000
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
Subject: Re: [PATCH v5 01/16] spi: add basic support for SPI offloading
Message-ID: <20241124163241.4699161f@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-1-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-1-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:40 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add the basic infrastructure to support SPI offload providers and
> consumers.
> 
> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
> 
> SPI controllers with offload support need to implement the get_offload
> and put_offload callbacks and can use the devm_spi_offload_alloc() to
> allocate offload instances.
> 
> SPI peripheral drivers will call devm_spi_offload_get() to get a
> reference to the matching offload instance. This offload instance can
> then be attached to a SPI message to request offloading that message.
> 
> It is expected that SPI controllers with offload support will check for
> the offload instance in the SPI message in the ctlr->optimize_message()
> callback and handle it accordingly.
> 
> CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
> consumer and provider drivers should `select SPI_OFFLOAD` in their
> Kconfig to ensure that the SPI core is built with offload support.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

A few additional comments, but basically fine.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> new file mode 100644
> index 000000000000..5ded7aecf9fc
> --- /dev/null
> +++ b/drivers/spi/spi-offload.c

...

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
> +	struct spi_controller_and_offload *resource;
> +	int ret;
> +
> +	if (!spi || !config)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!spi->controller->get_offload)
> +		return ERR_PTR(-ENODEV);
> +
> +	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
> +	if (!resource)
> +		return ERR_PTR(-ENOMEM);
> +
> +	resource->controller = spi->controller;
> +	resource->offload = spi->controller->get_offload(spi, config);
> +	ret = PTR_ERR_OR_ZERO(resource->offload);
> +	if (ret) {
Why not simply
	if (IS_ERR(resource->offload) {
		kfree(resource);
		return resource->offload;
	}
> +		kfree(resource);
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return resource->offload;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_get);

> diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
> new file mode 100644
> index 000000000000..81b115fc89bf
> --- /dev/null
> +++ b/include/linux/spi/spi-offload.h

> +
> +MODULE_IMPORT_NS(SPI_OFFLOAD);

This is rarely done in headers. (only pwm.h does it I think)
I'd push it down into code that uses this.

It might be worth splitting the header into a spi-offload-provider.h
and spi-offload-consumer.h with a common spi-offload-types.h included
by both.


> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 8497f4747e24..c2b24a0909ea 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -31,6 +31,9 @@ struct spi_transfer;
>  struct spi_controller_mem_ops;
>  struct spi_controller_mem_caps;
>  struct spi_message;
> +struct spi_controller_offload_ops;

Not used so introduce it only when needed (I guess in a later patch).






