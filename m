Return-Path: <linux-pwm+bounces-4355-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE19F2002
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502841887E28
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136A43166;
	Sat, 14 Dec 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ1SezrG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A012940D;
	Sat, 14 Dec 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734196331; cv=none; b=eSvGinOveWDInYQn3bPXDUpFTj9iQDgzO5Piz2OE/INdtgmtMwaoGVYOQm4H6LuYxl5iqJemH7QGTDYlqlBF5vuQbfddXNIvhTHO63VPecbTAgy/kG+nSD7asYMkvnZqB3jSq/ysd3feVRZ7k326P2xpn8h1U1kNYKoFyYyPNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734196331; c=relaxed/simple;
	bh=OX/8JikVy9D7wArDSU50MyIeKFbcedP/Ztft4uhLWcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWoKIda/K6TPmJLPwmPkr75UP8B5nzTH626rTQ2ev2Ms4GPdyNS6UkkGSTaDAYIbO10twlDjWsEOLcoTqOBXlfHn/YMulAMB3RTVDDm0WdUDzNcDeFFk+/k0QObmRG7xcgE4QNOObcSGiUMvpqvX9utx27X5VUgxIc7EnR8s5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ1SezrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF4C4CED1;
	Sat, 14 Dec 2024 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734196331;
	bh=OX/8JikVy9D7wArDSU50MyIeKFbcedP/Ztft4uhLWcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZ1SezrGdosbitshG6XfFnPYhiXE1XHyslryKnszw0ix11nEwWV4rBqy3C/EyxBWg
	 xXgutVxu4+XypzKZaLoCgvIczf+zP8naHEjyMKJqiH/6SBRgSIIrUqkTe184b9pW3a
	 Ro6CS958Z23WBoPj61AMuWCTFPq9FPQhXigGzLWYYIU52paPOyCIEGtImdcncnNv/g
	 gk1G1WsbqQ0sVgSHJXKFKJ9VolOzR59EEI3Sb8d+BjLzD+vJ4q3R2cWqpZqUmBKLsS
	 PJqaVl44RpAQUhETP2geovwclZwuQmti/mPUt86pisFqhpQd0cNW1rECJ/bB/ktaVU
	 8eMltqBWClS6g==
Date: Sat, 14 Dec 2024 17:12:01 +0000
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
 linux-pwm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v6 17/17] iio: dac: ad5791: Add offload support
Message-ID: <20241214171201.35b166d5@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-17-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-17-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:54 -0600
David Lechner <dlechner@baylibre.com> wrote:

> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add SPI offload support to stream TX buffers using DMA.
> This allows loading samples to the DAC with a rate of 1 MSPS.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v6 changes: new patch in v6

Nice.   A few formatting micro comments inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

For merging this ultimately I'm kind of assuming Mark Brown (or I) will
spin an immutable branch with the SPI parts and then I'll pull that into the
IIO tree and apply patch 8 onwards on top.

Before that point we need DT folk and Mark to be happy of course.

Thanks,

Jonathan


> @@ -299,6 +336,24 @@ static const struct ad5791_chip_info _name##_chip_info = {		\
>  			},						\
>  			.ext_info = ad5791_ext_info,			\
>  	},								\
> +	.channel_offload = {						\
> +			.type = IIO_VOLTAGE,				\

Reduce indent by 1 tab for these.

> +			.output = 1,					\
> +			.indexed = 1,					\
> +			.address = AD5791_ADDR_DAC0,			\
> +			.channel = 0,					\
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),		\
> +			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +			.scan_type = {					\
> +				.sign = 'u',				\
> +				.realbits = (bits),			\
> +				.storagebits = 32,			\
> +				.shift = (_shift),			\
> +			},						\
> +			.ext_info = ad5791_ext_info,			\
> +	},								\
>  }
>  
>  AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
> @@ -322,16 +377,95 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
>  
>  		return ad5791_spi_write(st, chan->address, val);
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < 0 || val2 < 0)

Given you ignore val2, is val2 != 0 more appropriate?

> +			return -EINVAL;
> +		return ad5791_set_sample_freq(st, val);
>  	default:
>  		return -EINVAL;
>  	}
>  }

>  static int ad5791_probe(struct spi_device *spi)
>  {
>  	const struct ad5791_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -416,6 +550,21 @@ static int ad5791_probe(struct spi_device *spi)
>  	indio_dev->channels = &st->chip_info->channel;
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = st->chip_info->name;
> +
> +	st->offload = devm_spi_offload_get(&spi->dev, spi, &ad5791_offload_config);
> +	ret = PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get offload\n");
> +
> +	if (ret != -ENODEV) {
> +		indio_dev->channels = &st->chip_info->channel_offload;
> +		indio_dev->setup_ops = &ad5791_buffer_setup_ops;
> +		ret =  ad5791_offload_setup(indio_dev);

bonus space after =

> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "fail to setup offload\n");
> +	}
> +
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> @@ -452,3 +601,4 @@ module_spi_driver(ad5791_driver);
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
> 


