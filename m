Return-Path: <linux-pwm+bounces-4132-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CA9D7622
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945082842D8
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997118B463;
	Sun, 24 Nov 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBxC9suO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC03A268;
	Sun, 24 Nov 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467050; cv=none; b=QCGyG6Wp2p9M5vZiEwGwliprnoXJp3AFxB4pGX1TCRrGHZp8sf/vIb+cL+KemZSRUEcQhXYe12CAD7k4Bgy5aQHPqPjUdxyKgkBCCfrRnvNMia/R4sSJbdbeCOYd6QlXQs1nBB3V6sWPVvb6uYWJXlnEl/EyqcqqrPgKO4c4vNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467050; c=relaxed/simple;
	bh=p+7fvZaMBVAV7TlCOhok6MWd10/1G8Mu+ZfdfRXfnYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4B94EOrAzaley0dYJIZ1g0L7RE+ivI+EUABjy1TvXyzFwR+raabd8mMRr6uOPsrSGBJUNPYguotmLFx633H99J0sJVAjta+CkelxjVlNEpqpjeO8g5FYChXmvsvwI21CmHofdZw0xK9gS13knYn+OQsn3utZzfVsawQzshgn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBxC9suO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F054EC4CECC;
	Sun, 24 Nov 2024 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732467049;
	bh=p+7fvZaMBVAV7TlCOhok6MWd10/1G8Mu+ZfdfRXfnYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OBxC9suOAZzl7df9dBD333MPlskw5F+/wLwbgyieBhrqKcGvdoZwizxSuDoRsLVNH
	 Ob/xTEMx473CcHFVgHC9OiqzHtmPk/iPK2gvCpF2ctWzTaUk94efcSQvquqwx+QX1k
	 Yytcodwod2KKxG20QxSASOmiGChl7A80WEGqIFbiA3NysXP4+6lMAZUtJcwRC6+klA
	 lC1cTam7sRkaXWMlO70Kx96Kn8K30ruHXeR5/jszM66srUKuFcu62F3jgHbddXiKhr
	 WK+YWm3McZ2bGA+rgcvrfybaUQgaoerbG1HnFz2y06+b7vudQub2GLYIQec2Bi0zyt
	 68DyQuTiIf4EA==
Date: Sun, 24 Nov 2024 16:50:39 +0000
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
Subject: Re: [PATCH v5 06/16] spi: add offload TX/RX streaming APIs
Message-ID: <20241124165039.206dc994@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-6-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-6-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Most configuration of SPI offloads is handled opaquely using the offload
> pointer that is passed to the various offload functions. However, there
> are some offload features that need to be controlled on a per transfer
> basis.
> 
> This patch adds a flag field to struct spi_transfer to allow specifying
> such features. The first feature to be added is the ability to stream
> data to/from a hardware sink/source rather than using a tx or rx buffer.
> Additional flags can be added in the future as needed.
> 
> A flags field is also added to the offload struct for providers to
> indicate which flags are supported. This allows for generic checking of
> offload capabilities during __spi_validate() so that each offload
> provider doesn't have to implement their own validation.
> 
> As a first users of this streaming capability, getter functions are
> added to get a DMA channel that is directly connected to the offload.
> Peripheral drivers will use this to get a DMA channel and configure it
> to suit their needs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Some docs that need updating.  Otherwise I wonder if we should delay
the _tx variants until there is a driver using them.

I'm sure you have one on the way and there is an argument that it makes
sense to review rx and tx together, but still good to only add code
when it's used.

Jonathan

> ---
> 
> v5 change:
> * Remove incorrect comment about caller needing to release DMA channels.
> 
> v4 changes:
> * DMA API's now automatically release DMA channels instead of leaving
>   it up to the caller.
> 
> v3 changes:
> * Added spi_offload_{tx,rx}_stream_get_dma_chan() functions.
> 
> v2 changes:
> * This is also split out from "spi: add core support for controllers with
>   offload capabilities".
> * In the previous version, we were using (void *)-1 as a sentinel value
>   that could be assigned, e.g. to rx_buf. But this was naive since there
>   is core code that would try to dereference this pointer. So instead,
>   we've added a new flags field to the spi_transfer structure for this
>   sort of thing. This also has the advantage of being able to be used in
>   the future for other arbitrary features.
> ---
>  drivers/spi/spi-offload.c       | 70 +++++++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi.c               | 10 ++++++
>  include/linux/spi/spi-offload.h | 24 ++++++++++++++
>  include/linux/spi/spi.h         |  3 ++
>  4 files changed, 107 insertions(+)
> 
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index 01d7b632d109..7b3e20ad9e4f 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/dmaengine.h>
>  #include <linux/export.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -319,6 +320,75 @@ void spi_offload_trigger_disable(struct spi_offload *offload,
>  }
>  EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
>  
> +static void spi_offload_release_dma_chan(void *chan)
> +{
> +	dma_release_channel(chan);
> +}
> +
> +/**
> + * spi_offload_tx_stream_request_dma_chan_info - Get the DMA channel info for the TX stream
> + * @spi: SPI device
> + * @id: Function ID if SPI device uses more than one offload or NULL.
As below.  Code is ahead of the docs.
> + *
> + * This is the DMA channel that will provide data to transfers that use the
> + * %SPI_OFFLOAD_XFER_TX_STREAM offload flag.
> + *
> + * Return: Pointer to DMA channel info, or negative error code
> + */
> +struct dma_chan
> +*devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
> +					     struct spi_offload *offload)
> +{
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	if (!offload->ops || !offload->ops->tx_stream_request_dma_chan)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	chan = offload->ops->tx_stream_request_dma_chan(offload);
> +	if (IS_ERR(chan))
> +		return chan;
> +
> +	ret = devm_add_action_or_reset(dev, spi_offload_release_dma_chan, chan);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_tx_stream_request_dma_chan);
> +
> +/**
> + * spi_offload_rx_stream_request_dma_chan_info - Get the DMA channel info for the RX stream
> + * @spi: SPI device

Run kernel-doc over these. There is no spi here.


> + * @id: Function ID if SPI device uses more than one offload or NULL.
or indeed ID...
> + *
> + * This is the DMA channel that will receive data from transfers that use the
> + * %SPI_OFFLOAD_XFER_RX_STREAM offload flag.
> + *
> + * Return: Pointer to DMA channel info, or negative error code
> + */
> +struct dma_chan
> +*devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
> +					     struct spi_offload *offload)
> +{
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	if (!offload->ops || !offload->ops->rx_stream_request_dma_chan)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	chan = offload->ops->rx_stream_request_dma_chan(offload);
> +	if (IS_ERR(chan))
> +		return chan;
> +
> +	ret = devm_add_action_or_reset(dev, spi_offload_release_dma_chan, chan);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_rx_stream_request_dma_chan);
> +
>  /* Triggers providers */
>  
>  static void spi_offload_trigger_unregister(void *data)

>  
>  struct spi_offload *devm_spi_offload_alloc(struct device *dev, size_t priv_size);
> @@ -107,6 +126,11 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
>  void spi_offload_trigger_disable(struct spi_offload *offload,
>  				 struct spi_offload_trigger *trigger);
>  
> +struct dma_chan *devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
> +							     struct spi_offload *offload);
Would be better supported by actual driver code using it.  Maybe it is better to bring
in TX only with the first user?


> +struct dma_chan *devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
> +							     struct spi_offload *offload);
> +
>  /* Trigger providers */


