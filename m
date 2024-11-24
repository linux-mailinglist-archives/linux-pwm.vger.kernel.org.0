Return-Path: <linux-pwm+bounces-4134-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CC9D7651
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB76165363
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FE842AA0;
	Sun, 24 Nov 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I63cvkl/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05652AF0E;
	Sun, 24 Nov 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467854; cv=none; b=jQ3KOBuFVWrjl5duEWnoHe/SPd9dmrlLbaZMsBQVFNTwFWmTtJuwWcMfXr9ERk9Blj8KQGbYxBy2ySvO+O+FlS+Rb+MaprzJdWMxwK5zpZuT4ivm4DOWOKJoNujbrTpV4Hokx4yHI7HsqFh3D+J2WG8i3Kk8kegRJ4K1Nwgb2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467854; c=relaxed/simple;
	bh=ebK/u7XSkMKmYHFOHv85R8sBCHIqb3iUA0ffhU4di2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuMFL2KHSctEOsKu8wDlj6a5tnw7hxnPF22Vt8W51gZmxZ02yeADJQOvzxxJV3XCyrPhV1C+EuW5E/YsP5NQyJmKfVO5Z+v6DltUxdGfaOzM/IQKmEo5LOohK1BeWrOrxgcv7Dr1xuZRVhohm0RwyXnvlw6inhPs8p6RWgQhCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I63cvkl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB8EC4CED6;
	Sun, 24 Nov 2024 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732467853;
	bh=ebK/u7XSkMKmYHFOHv85R8sBCHIqb3iUA0ffhU4di2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I63cvkl/tzeqeDdSLx6idOBGw+J2ueXcQSm6LkgNECIMQaIrrSTfkQgs5esReQk0g
	 4q8u1bBzxKyqw4VaYv7agh6hv/3Zk4dPK00XTI0TTy1BhCGiPFk8F6mW16ayQNWDzQ
	 BOFM9VD2Q06wOvL2pIB6Lrj6CPZUtueSClScMlNk988otUsinrUgoVhhIj4nOLjGRo
	 4BW3NyJY2cgbPFR63MYHZBiKQhY19bPnZIokSzvUpof+RTaFn4HSsEIdvGf4r7+w42
	 qoDnAdtH4sirioyUGRzR5AMzlUiq6iqHtarfwvEJHRNEmOXea6CTmKCHB4oiju8vbG
	 eYvAcFu46jPoA==
Date: Sun, 24 Nov 2024 17:04:03 +0000
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
Subject: Re: [PATCH v5 09/16] iio: buffer-dmaengine: document
 iio_dmaengine_buffer_setup_ext
Message-ID: <20241124170403.2dba7a42@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-9-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-9-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:48 -0600
David Lechner <dlechner@baylibre.com> wrote:

> The iio_dmaengine_buffer_setup_ext() function is public and should be
> documented. Also, while touching this, fix the description of @dev in
> related functions. @dev does not strictly have to be the parent of the
> IIO device. It is only passed to dma_request_chan() so strictly
> speaking, it can be any device that is a valid DMA channel consumer.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes: none
> 
> v4 changes:
> * This patch is new in v4.
> 
> Jonathan, I think this patch stands on its own if you want to take it
> earlier than the rest of this series.
Fair enough. Patch looks good to me.

Applied.



> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 19af1caf14cd..054af21dfa65 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -206,7 +206,7 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
>  
>  /**
>   * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
> - * @dev: Parent device for the buffer
> + * @dev: DMA channel consumer device
>   * @channel: DMA channel name, typically "rx".
>   *
>   * This allocates a new IIO buffer which internally uses the DMAengine framework
> @@ -288,6 +288,21 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
>  
> +/**
> + * iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
> + * @dev: DMA channel consumer device
> + * @indio_dev: IIO device to which to attach this buffer.
> + * @channel: DMA channel name, typically "rx".
> + * @dir: Direction of buffer (in or out)
> + *
> + * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
> + * and attaches it to an IIO device with iio_device_attach_buffer().
> + * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
> + * IIO device.
> + *
> + * Once done using the buffer iio_dmaengine_buffer_free() should be used to
> + * release it.
> + */
>  struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
>  						  struct iio_dev *indio_dev,
>  						  const char *channel,
> @@ -321,7 +336,7 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
>  
>  /**
>   * devm_iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
> - * @dev: Parent device for the buffer
> + * @dev: Device for devm ownership and DMA channel consumer device
>   * @indio_dev: IIO device to which to attach this buffer.
>   * @channel: DMA channel name, typically "rx".
>   * @dir: Direction of buffer (in or out)
> 


