Return-Path: <linux-pwm+bounces-3915-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCF9B191C
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DCB21489
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059EC25776;
	Sat, 26 Oct 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi50FkTA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC412E4A;
	Sat, 26 Oct 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956619; cv=none; b=PnVJnMu3XuOExf+x4tSJ0XrQpjhqnzVih+kKeNeSWYPvNSeM96sPR+Ao4KizFCSAuAoS0wPS1Yfo7sD6EEaFi8QPaDiqdFDLPnDWQ/ERfpzQaFwxH7H5NP2t16YcV4cf2S+paeYBf7eWL62qYWeeWyFbGIIi9p+uSFCW94HLIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956619; c=relaxed/simple;
	bh=JTyEKqZtPPx4SJlBOyY6fc+rEPd0RkxMnqkabI0F+5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQ3CuSpJmJTC5k9wm2Gt/zU/+ugvqQkIMkGY4Up7X4ket5OVW+ZI2WECyGNrq1W/DWdUg3kI8mU0Wmj3Qc2KTVeWWWgDT2RWyvWP+TTXSsD9q+s8096B3AXQrC+/SlOAG7zFiktlrUsNneDPHn3Z81h6/SfPw0NlT4NgRI/cqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi50FkTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50550C4CECC;
	Sat, 26 Oct 2024 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729956619;
	bh=JTyEKqZtPPx4SJlBOyY6fc+rEPd0RkxMnqkabI0F+5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pi50FkTA3YDR302HawnJpraGdtgzRbWH+yPvbzZGr0PktKdBwqG3eek67mOVWs6D8
	 JUaQVVlPS8/dUPG4OG9T28JGWL6IWJeqTcsUgboAeK6Eca66ywq5ane31w7kHHUu9j
	 pb3hpA3UqEMIck2QR4NJK8ooJcgeXYGft4/CcWYNM06FmUamK6cgIchNNbc07s/l4A
	 Dksw1ieA+9E31ASxgs4wGYHQRE+OwhtharUyKbxPWaOuU1N1kOrPyM/5UJxseiqLcp
	 M6qvVsMx8y4PhWlXfwITnOFfgLWoW3lfFKYneBoDFBh+dwD6m2vUdkgoeIEK8Bw+N1
	 5+EFvr8dCmOxg==
Date: Sat, 26 Oct 2024 16:29:24 +0100
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
Subject: Re: [PATCH RFC v4 10/15] iio: buffer-dmaengine: document
 iio_dmaengine_buffer_setup_ext
Message-ID: <20241026162924.2d7c8edc@jic23-huawei>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-10-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-10-f8125b99f5a1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 15:59:17 -0500
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
> v4 changes:
> * This patch is new in v4.
> 
> Jonathan, I think this patch stands on its own if you want to take it
> earlier than the rest of this series.
I may do at some point, but want a few more eyes on it first so let's leave
it here for now.

Seems fine to me.


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


