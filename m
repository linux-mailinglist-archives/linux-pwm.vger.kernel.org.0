Return-Path: <linux-pwm+bounces-4135-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77529D7682
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 18:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418C31642B6
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4404D9FB;
	Sun, 24 Nov 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOeOsLwM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304242F26;
	Sun, 24 Nov 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468580; cv=none; b=k/8Go08miSVscLUE8iE8pjshI0uMTCR7TQkaV9CvsJrN5lZhkpnedaWBWhu3BYZwHYRZv8HMLK1tt/JB1g4bNVfKapH+p8AQrZ8HrnYo40KK46E+Ij2BcQuYSNtm3uY/XMJSgI1k04ZKjTNPFUK2CrZrRQStQuQBKahNO5tfKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468580; c=relaxed/simple;
	bh=VRP7CbA7NftH98hfcv3UFTbJShvhcpRDqJgwqEKPEaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7s6Krm3gx8T3hMdJELmuNczjG40SlNBQKquOv8FN0uEgyQpZWQBKcKKoaYws4nGynyzPfg2EQJTcfsmwDZK5xuY7E+NfVw8TJ8xbyuevke1DTFASvAnkZ6pxB/8OiTUjKBm0Q5ek4SwX4eGSWaJCfM28cE9blsLHcj4bdFSX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOeOsLwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7570C4CECC;
	Sun, 24 Nov 2024 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732468579;
	bh=VRP7CbA7NftH98hfcv3UFTbJShvhcpRDqJgwqEKPEaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kOeOsLwMcN0E9LYE02V7ufeiLLI5molVXJSa0EQyDk93g7czMp4fEaEbqxVwntzCw
	 vC7qYRgY6hxufrUSaZA4UjKcjwJ93APFW4tCq+arF7fRTyeAzV3KjN9stnZeQq3jip
	 MPANV4R0n8Up5e2TxpSyvnOe6Xr4+x0F+9rVL26d6NdEwTmWrTwGFWj3B5BNln5cx3
	 k3l3NYnWJRDHdDXLDyO1Ao8t8x0NtCzj7tiwOOrevfXlKhnncgkp0bcgFI2MKBF+2y
	 7srRfAnXkF+Qt7FeB/EF8KUfyrdOZOUumnjp/7+BAMfP/ctWwP1VVO7KDynmsHrjsJ
	 2HGHxDBhZpNTg==
Date: Sun, 24 Nov 2024 17:16:09 +0000
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
Subject: Re: [PATCH v5 10/16] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
Message-ID: <20241124171609.50c6c3a8@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-10-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-10-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:49 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
> cases where the DMA channel is managed by the caller rather than being
> requested and released by the iio_dmaengine module.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Fresh read and I'm wondering if the lifetimes in here can be managed
more simply either by pushing the DMA channel get down, or dragging
the release up.   Basically I'd like to see them at the same level
of nesting in the code.  If it ends up being necessary to duplicate
more code that is fine if it makes this easier to reason about.

Jonathan

> ---
> 
> v5 changes: none
> 
> v4 changes:
> * This replaces "iio: buffer-dmaengine: generalize requesting DMA channel"
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 107 +++++++++++++++------
>  include/linux/iio/buffer-dmaengine.h               |   5 +
>  2 files changed, 81 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 054af21dfa65..602cb2e147a6 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -33,6 +33,7 @@ struct dmaengine_buffer {
>  	struct iio_dma_buffer_queue queue;
>  
>  	struct dma_chan *chan;
> +	bool owns_chan;
>  	struct list_head active;
>  
>  	size_t align;
> @@ -216,28 +217,23 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
>   * Once done using the buffer iio_dmaengine_buffer_free() should be used to
>   * release it.
>   */
> -static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> -	const char *channel)
> +static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan,
> +						     bool owns_chan)
>  {
>  	struct dmaengine_buffer *dmaengine_buffer;
>  	unsigned int width, src_width, dest_width;
>  	struct dma_slave_caps caps;
> -	struct dma_chan *chan;
>  	int ret;
>  
>  	dmaengine_buffer = kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL);
> -	if (!dmaengine_buffer)
> -		return ERR_PTR(-ENOMEM);
> -
> -	chan = dma_request_chan(dev, channel);
> -	if (IS_ERR(chan)) {
> -		ret = PTR_ERR(chan);
> -		goto err_free;
> +	if (!dmaengine_buffer) {
> +		ret = -ENOMEM;
> +		goto err_release;
>  	}
>  
>  	ret = dma_get_slave_caps(chan, &caps);
>  	if (ret < 0)
> -		goto err_release;
> +		goto err_free;
>  
>  	/* Needs to be aligned to the maximum of the minimums */
>  	if (caps.src_addr_widths)
> @@ -252,6 +248,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  
>  	INIT_LIST_HEAD(&dmaengine_buffer->active);
>  	dmaengine_buffer->chan = chan;
> +	dmaengine_buffer->owns_chan = owns_chan;
>  	dmaengine_buffer->align = width;
>  	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
>  
> @@ -263,10 +260,12 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  
>  	return &dmaengine_buffer->queue.buffer;
>  
> -err_release:
> -	dma_release_channel(chan);
>  err_free:
>  	kfree(dmaengine_buffer);
> +err_release:
This ends up oddly miss balanced.  If you get an error here, why
not just do the release at the caller instead?

> +	if (owns_chan)
> +		dma_release_channel(chan);
> +
>  	return ERR_PTR(ret);
>  }
>  
> @@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  		iio_buffer_to_dmaengine_buffer(buffer);
>  
>  	iio_dma_buffer_exit(&dmaengine_buffer->queue);
> -	dma_release_channel(dmaengine_buffer->chan);
> -
>  	iio_buffer_put(buffer);
> +
> +	if (dmaengine_buffer->owns_chan)
> +		dma_release_channel(dmaengine_buffer->chan);
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
>  
> +static struct iio_buffer
> +*__iio_dmaengine_buffer_setup_ext(struct iio_dev *indio_dev,
> +				  struct dma_chan *chan, bool owns_chan,
> +				  enum iio_buffer_direction dir)
> +{
> +	struct iio_buffer *buffer;
> +	int ret;
> +
> +	buffer = iio_dmaengine_buffer_alloc(chan, owns_chan);
> +	if (IS_ERR(buffer))
> +		return ERR_CAST(buffer);
> +
> +	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> +
> +	buffer->direction = dir;
> +
> +	ret = iio_device_attach_buffer(indio_dev, buffer);
> +	if (ret) {
> +		iio_dmaengine_buffer_free(buffer);
Note that if you did push the free out to the caller for owns_chan
as suggested above this would need to never free the buffer as
that would be done if necessary at the caller for this...

> +		return ERR_PTR(ret);
> +	}
> +
> +	return buffer;
> +}
> +
>  /**
>   * iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
>   * @dev: DMA channel consumer device
> @@ -308,24 +333,13 @@ struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
>  						  const char *channel,
>  						  enum iio_buffer_direction dir)
>  {
> -	struct iio_buffer *buffer;
> -	int ret;
> -
> -	buffer = iio_dmaengine_buffer_alloc(dev, channel);
> -	if (IS_ERR(buffer))
> -		return ERR_CAST(buffer);
> -
> -	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> -
> -	buffer->direction = dir;
> +	struct dma_chan *chan;
>  
> -	ret = iio_device_attach_buffer(indio_dev, buffer);
> -	if (ret) {
> -		iio_dmaengine_buffer_free(buffer);
> -		return ERR_PTR(ret);
> -	}
> +	chan = dma_request_chan(dev, channel);
> +	if (IS_ERR(chan))
> +		return ERR_CAST(chan);
>  
> -	return buffer;
> +	return __iio_dmaengine_buffer_setup_ext(indio_dev, chan, true, dir);
As above, why not just free the channel here if this fails? Thus matching
the dma_request_chan just above.


>  }
>  EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
>  
> @@ -362,6 +376,37 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
>  
> +/**
> + * devm_iio_dmaengine_buffer_setup_ext2() - Setup a DMA buffer for an IIO device
> + * @dev: Device for devm ownership
> + * @indio_dev: IIO device to which to attach this buffer.
> + * @chan: DMA channel
> + * @dir: Direction of buffer (in or out)
> + *
> + * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
> + * and attaches it to an IIO device with iio_device_attach_buffer().
> + * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
> + * IIO device.
> + *
> + * This is the same as devm_iio_dmaengine_buffer_setup_ext() except that the
> + * caller manages requesting and releasing the DMA channel.

I'd like the name to make that clearer.  ext2 is too vague.

> + */
> +int devm_iio_dmaengine_buffer_setup_ext2(struct device *dev,
> +					 struct iio_dev *indio_dev,
> +					 struct dma_chan *chan,
> +					 enum iio_buffer_direction dir)
> +{
> +	struct iio_buffer *buffer;
> +
> +	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, false, dir);
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
> +
> +	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
> +					buffer);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext2, IIO_DMAENGINE_BUFFER);
> +
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("DMA buffer for the IIO framework");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
> index 81d9a19aeb91..7bdb979b59f2 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -11,6 +11,7 @@
>  
>  struct iio_dev;
>  struct device;
> +struct dma_chan;
>  
>  void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
>  struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
> @@ -26,6 +27,10 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
>  					struct iio_dev *indio_dev,
>  					const char *channel,
>  					enum iio_buffer_direction dir);
> +int devm_iio_dmaengine_buffer_setup_ext2(struct device *dev,
> +					 struct iio_dev *indio_dev,
> +					 struct dma_chan *chan,
> +					 enum iio_buffer_direction dir);
>  
>  #define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
>  	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
> 


