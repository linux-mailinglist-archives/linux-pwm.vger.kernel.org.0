Return-Path: <linux-pwm+bounces-4349-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 503039F1F4B
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E9E162392
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DC192B75;
	Sat, 14 Dec 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4tBSIt1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA555169397;
	Sat, 14 Dec 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186493; cv=none; b=RxSQ7nrzgcC5B9Lq3Yakc+GJao+WGfKbi0e9KoqcrW+R//FWaSD2t6F1XxcdcmjMIt7Mz2HNOkfM89H7h1m/Ls6yNIJ6I2VPrF+1USbmOhSCajdaxHD89YFem6KjpDQVA2tY43k6HsCM1uoKjaZ3D7S5PJfNTxiuw9HHoeM/SoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186493; c=relaxed/simple;
	bh=jfUsgmfO8W/XTSJOD8xrRqTYt4meYFV3MQOac5EhdOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdlUkFGt2zMR7iYMDK/9gQsZ2PEIw3LZ9loVXqMFtdrTFsipPhfpW2LtmdmAE6jU+DcAVU3OUsa6c+iSNANbeyWB1veqx8R2hcChGuLDs4XYegO17fDBfXyz/O5kFMkTd45uwlUyxUw6hpOnp5slwQAiKRvWBm1btfssK95ZPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4tBSIt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD0C4CED1;
	Sat, 14 Dec 2024 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734186492;
	bh=jfUsgmfO8W/XTSJOD8xrRqTYt4meYFV3MQOac5EhdOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4tBSIt1Tm8AQjP8JTFQq3oGeS5Kyv7hi+uShVZ9cUAPOjU/tCL1/9clexhn9jZvE
	 w2zVCm59s1stBrsBNQ0Hsy2MCKph+e0pu1fAkQc3hjD0bP8hlTaSY3K0Zpug3gfLe3
	 KSilOiXJDwWNCYRkYDsGgdMw2fkujb+8Yvm73m8D7f9kLgtknuz1TwgJls3aOhALLw
	 7VS3/YdI75GubRbup0Ncv7OMX7aysfueBbqLZTpNM9gJWQXZcp77dCHBOxNHMEi6MP
	 Hf6QDb4h0HxUhw65GD4Ng9tiZI0hfbUtoqL/7rEwUrKQEXWIQbCG89qyKz6LCCKbC5
	 s3kNzV/LgTAuQ==
Date: Sat, 14 Dec 2024 14:28:02 +0000
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
Subject: Re: [PATCH v6 05/17] spi: add offload TX/RX streaming APIs
Message-ID: <20241214142802.27bd774d@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-5-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-5-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:42 -0600
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

Really really minor comment inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ff1add2ecb91f18cf82e6f1e9595584c11adf9d8..4a871db9ee636aba64c866ebdd8bb1dbf82e0f42 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -31,6 +31,7 @@
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/sched/rt.h>
>  #include <linux/slab.h>
> +#include <linux/spi/offload/types.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>  #include <uapi/linux/sched/types.h>
> @@ -4163,6 +4164,15 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>  
>  		if (_spi_xfer_word_delay_update(xfer, spi))
>  			return -EINVAL;
> +
> +		/* make sure controller supports required offload features */
Comment syntax seems inconsistent with local code. 

		/* Make sure controller supports required offload features. */

> +		if (xfer->offload_flags) {
> +			if (!message->offload)
> +				return -EINVAL;
> +
> +			if (xfer->offload_flags & ~message->offload->xfer_flags)
> +				return -EINVAL;
> +		}
>  	}
>  
>  	message->status = -EINPROGRESS;

