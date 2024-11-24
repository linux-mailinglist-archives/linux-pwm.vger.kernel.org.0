Return-Path: <linux-pwm+bounces-4133-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FA9D76A2
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 18:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08641B2414F
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6027468;
	Sun, 24 Nov 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8lnCvsP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB62500D9;
	Sun, 24 Nov 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467741; cv=none; b=aekGmiR6QgtDIq4qb+qnF67xU7GimytgyP/C0bi8DFlvCPPfBF39bjrYsoDW6dWlgbuwESFTXxQhTxJZNd2HXKUWF0sDWHlzLtt1xUPi5tvAAqzJOd3tpeXMCrCQChdvZvVCk8A6WgIWoIV+0AiwjgyEHfHn7exSIR4d8B63rA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467741; c=relaxed/simple;
	bh=1UjHRbFyt68AMF7+/li2CNlJtirJ7ciD3zGvJqmW/EU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpFh9kQmzxBktPL6ny6VYDXvCIBIpau7+7hy25hqx1nbdzeltyzRVxIg1ZflWS8JNhNNGpBtNRzoIyo/aE6bkTSqORj1vzVTSIDJFIeMKzYsVwPG1KwLvw0REq3oSCEPZnLqRWihLFs3sxPgnwRfrfCdk4axWawkqaeg9A2KndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8lnCvsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD7EC4CECC;
	Sun, 24 Nov 2024 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732467741;
	bh=1UjHRbFyt68AMF7+/li2CNlJtirJ7ciD3zGvJqmW/EU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P8lnCvsPjn7XzUnqlOXZdL5/VM2Oyx1owyyKxpYp2ah1m46OTeyCWHL2IBdkwaZBu
	 JiT4k/vxnTRhCXGuGZiZlaVMzfQQAGAX8VHMnltLHZwFz+CqGS3TPD/sFvtKXaU6B8
	 p/4fb62Y5W2RMQbEN2Y+i/Sxpp89x6t6LCjgToe54Arfy93kBuHZef6qTfb7+Ep7J8
	 TH71dwVdXqHT7FFKCRS9Hkbnvb7rwYMaCUNFuTufiIt1Pm2Vz2cyKewdBJDTlj6bcn
	 lc8qH4vcEPckMveJwjYO98TFyKbi8lK2jhQqZFZ+FZrniUXJQ29fiAsklJZzNtOPMP
	 YSX7DBdmgR1iw==
Date: Sun, 24 Nov 2024 17:02:12 +0000
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
Subject: Re: [PATCH v5 08/16] spi: axi-spi-engine: implement offload support
Message-ID: <20241124170212.21442c3e@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-8-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-8-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:47 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Implement SPI offload support for the AXI SPI Engine. Currently, the
> hardware only supports triggering offload transfers with a hardware
> trigger so attempting to use an offload message in the regular SPI
> message queue will fail. Also, only allows streaming rx data to an
> external sink, so attempts to use a rx_buf in the offload message will
> fail.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Locally this patch is fine, but it has made me wonder if the allocation
strategy for priv makes sense. It's not wrong, but perhaps more complex
than it needs to be.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 9386ddc4714e..172a9f1f1ead 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c



>  static void spi_engine_release_hw(void *p)
>  {
>  	struct spi_engine *spi_engine = p;
> @@ -675,8 +921,7 @@ static int spi_engine_probe(struct platform_device *pdev)
>  	struct spi_engine *spi_engine;
>  	struct spi_controller *host;
>  	unsigned int version;
> -	int irq;
> -	int ret;
> +	int irq, ret;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -691,6 +936,46 @@ static int spi_engine_probe(struct platform_device *pdev)
>  	spin_lock_init(&spi_engine->lock);
>  	init_completion(&spi_engine->msg_complete);
>  
> +	/*
> +	 * REVISIT: for now, all SPI Engines only have one offload. In the
> +	 * future, this should be read from a memory mapped register to
> +	 * determine the number of offloads enabled at HDL compile time. For
> +	 * now, we can tell if an offload is present if there is a trigger
> +	 * source wired up to it.
> +	 */
> +	if (device_property_present(&pdev->dev, "trigger-sources")) {
> +		struct spi_engine_offload *priv;
> +
> +		spi_engine->offload =
> +			devm_spi_offload_alloc(&pdev->dev,
> +					       sizeof(struct spi_engine_offload));
> +		if (IS_ERR(spi_engine->offload))
> +			return PTR_ERR(spi_engine->offload);
> +
> +		priv = spi_engine->offload->priv;

With the separate allocations of offlaod and priv back in patch 1 this
all feels more complex than it should be.  Maybe we should just alloate
priv here and set it up via spi_engine->offload->priv = ...
Other elements of spi_engine->offloads have to be set directly here
for it to work so setting priv as well seems sensible.

 
> +		priv->spi_engine = spi_engine;
> +		priv->offload_num = 0;
> +
> +		spi_engine->offload->ops = &spi_engine_offload_ops;
> +		spi_engine->offload_caps = SPI_OFFLOAD_CAP_TRIGGER;
> +
> +		if (device_property_match_string(&pdev->dev, "dma-names", "offload0-rx") >= 0) {
> +			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_RX_STREAM_DMA;
> +			spi_engine->offload->xfer_flags |= SPI_OFFLOAD_XFER_RX_STREAM;
> +		}
> +
> +		if (device_property_match_string(&pdev->dev, "dma-names", "offload0-tx") >= 0) {
> +			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_TX_STREAM_DMA;
> +			spi_engine->offload->xfer_flags |= SPI_OFFLOAD_XFER_TX_STREAM;
> +		} else {
> +			/*
> +			 * HDL compile option to enable TX DMA stream also disables
> +			 * the SDO memory, so can't do both at the same time.
> +			 */
> +			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_TX_STATIC_DATA;
> +		}
> +	}
> +

