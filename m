Return-Path: <linux-pwm+bounces-4138-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C59D76C2
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 18:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770E7164C3D
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F46F06D;
	Sun, 24 Nov 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUrQwHEW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9BB5336E;
	Sun, 24 Nov 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469734; cv=none; b=eNXob5Dx7bYywOjYiDtnQchxDSC3UTi17GjeoACdOfFTVa2I8ybK3/PcvvXbZ5WGDatkvbjXIuqnn2Z/bNxgE0P/NN4J+/Zy1sV8wMNmgx3jvg2Esh/0ZRtWCTdioUTtajV8lGSUg1+bHMwZo3hXHdjQU6tQwid8iNwr6aj9P0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469734; c=relaxed/simple;
	bh=NNO1v8uI0g1RI6kvrfdYdEVsM8AQmZbR6prCbj8eSic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+pnR9Ct5DK79kRGr8uQfqgFH5XfysVFTgU1AQNhqSeL2d0Ywulrnj+WigldNSnYDoWLQZygQxTa74AQSncis0p/Uh/WORDIbIxvqN8zCd6VBB5qPITNsTKll5K2Xp4MCVG4HAP/O2/z22Vv2BfM4M9kRVlPRXEnu/m6P3NE5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUrQwHEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DB0C4CECC;
	Sun, 24 Nov 2024 17:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732469733;
	bh=NNO1v8uI0g1RI6kvrfdYdEVsM8AQmZbR6prCbj8eSic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FUrQwHEWxb97oW0wQYfVAvlCjJ+KEXeX6AkB6U128P8jhmlmjjEsERWpFdp84rxh0
	 SA/SrhxhIkR2Dc9xzZVGeK5Uzbe8Prv7PFBaYonboBS8GlAjxASMbl08vY53TWqHoL
	 YPDWGcXNttkB3A8u0DYrLV6DfvCKRAwIYJsrHaABncrlt5FnjjEcCeQLn1nIXlUKW+
	 KqHOinu7xTckExo1SJ8wq2ttW2rWfidAUERM12p0hy+Y6NVzBdJ/WBzZ2KgnXVlbck
	 kH8thAxTi7mCZ7Urz1ic6fZZoo9LdX2+ePnoxqS0m1jaXg4oD7VRiKAscoaMfojaZR
	 hbIw/07+5t73w==
Date: Sun, 24 Nov 2024 17:35:23 +0000
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
Subject: Re: [PATCH v5 15/16] iio: adc: ad4695: Add support for SPI offload
Message-ID: <20241124173523.1fc48f25@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-15-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-15-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:54 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add support for SPI offload to the ad4695 driver. SPI offload allows
> sampling data at the max sample rate (500kSPS or 1MSPS).
> 
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
> 
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

A few minor formatting type comments inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> +static bool ad4695_offload_trigger_match(struct spi_offload_trigger *trigger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{
> +	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return false;
> +
> +	// args[0] is the trigger event.
> +	// args[1] is the GPIO pin number.
/*
 * args[0] etc

> +	if (nargs != 2 || args[0] != AD4695_TRIGGER_EVENT_BUSY)
> +		return false;
> +
> +	return true;
> +}



> @@ -1260,12 +1639,36 @@ static int ad4695_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = st->iio_chan;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      iio_pollfunc_store_time,
> -					      ad4695_trigger_handler,
> -					      &ad4695_buffer_setup_ops);
> -	if (ret)
> -		return ret;
> +	static const struct spi_offload_config ad4695_offload_config = {

Whilst we do allow declarations other than at the top for use with things
like __free() there is no strong reason for this one. So move it up to the
top of the function.

> +		.capability_flags = SPI_OFFLOAD_CAP_TRIGGER
> +				  | SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +	};
> +
> +	st->offload = devm_spi_offload_get(dev, spi, &ad4695_offload_config);
>

