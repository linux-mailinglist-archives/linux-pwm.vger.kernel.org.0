Return-Path: <linux-pwm+bounces-3491-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B399168F
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B201C215CD
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB414C588;
	Sat,  5 Oct 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkrbqEbu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579482B9AA;
	Sat,  5 Oct 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728129208; cv=none; b=oPcLzeJN+17Rytungy3GO9ToWNucn03c2qrWsYPtlcesFO2wITN1UfILv1na8tMmrcc3rQt+mmrKcEKtNI5tqcMGEKsb0H7/ax4PvxamQcntKiQnVGjB52Jebz/LL6d2z2GrsF1nZKXVHQ81lnTMlxTbeiNNEi+XlMag2HiDSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728129208; c=relaxed/simple;
	bh=VQJQi0+PgB45k7P56kZuRZq1YQ+ri/0leKVpZ642G6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLHUm9FQJnnvUpaPX9rgJft9LD1Rzc+8ITk16u7q4MasVtkZJheTYaDsaWrfGibvCcaCT5OUYP6XTuTQNVq7Vd6t1FkYTONfcfj/gn8CxptTiCp99Qp9aKPGEwjkoIJc3YvhFgH0x/EKLp/hHeR2OxEmaeL8I8HG/iO2tVyVY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkrbqEbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1E0C4CEC2;
	Sat,  5 Oct 2024 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728129207;
	bh=VQJQi0+PgB45k7P56kZuRZq1YQ+ri/0leKVpZ642G6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OkrbqEbub+ijJIgwizRMWx42IhCSrHMoDBHVzCJ7tYG07DHN5aQqXHgy23noKHfsJ
	 Yrug1lgDQ7RbdwMgFBjR29LE2B1/graNyAzH1I49PdvHA3U90Sgh9PLuyvnrMp3PLl
	 g2jPmVmaE39Mj2SeMT+VedGIjsXMn8C9uJDIlvkCOCulyxI//WPhMKJu+mFfH1vjK7
	 EHHKMqSpK1PpGtPm5VlIySYvdDkH9Ik2MJDp2jbWEkbWK8HSxG2FwKNcfyycZEQpC0
	 GV5yAPOHuCAiMXkfi0LPe6EIP68VTBY0rrnX8aNw8D9jfy7+fSC7IZx7Qj8HAz6Y95
	 CiRUinBBVR0Ng==
Date: Sat, 5 Oct 2024 12:53:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 09/10] iio: adc: ad7606: Add iio-backend support
Message-ID: <20241005125318.0c4a7bc8@jic23-huawei>
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-9-38757012ce82@baylibre.com>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
	<20241004-ad7606_add_iio_backend_support-v3-9-38757012ce82@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 21:48:43 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> - Basic support for iio backend.
> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
>   supported if iio-backend mode is selected.
I don't much like the trivial window between this patch and the next
where the emulated mode is still there but the sleeps aren't adapting with sampling frequency.

Maybe it's worth a dance of leaving the write_raw support
until after this one so the frequency remains fixed until after
the fsleep(2) calls are gone?

There is another bit that I'm unsure is technically correct until after
the next patch.  Maybe I'm reading the diff wrong though!

Thanks,

J

> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/Kconfig      |   2 +
>  drivers/iio/adc/ad7606.c     | 124 +++++++++++++++++++++++++++++++++++++------
>  drivers/iio/adc/ad7606.h     |  15 ++++++
>  drivers/iio/adc/ad7606_par.c |  94 +++++++++++++++++++++++++++++++-
>  4 files changed, 219 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4ab1a3092d88..9b52d5b2c592 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -224,9 +224,11 @@ config AD7606_IFACE_PARALLEL
>  	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
>  	depends on HAS_IOPORT
>  	select AD7606
> +	select IIO_BACKEND
>  	help
>  	  Say yes here to build parallel interface support for Analog Devices:
>  	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> +	  It also support iio_backended devices for AD7606B.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7606_par.
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 3666a58f8a6f..d86eb7c3e4f7 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -21,6 +21,7 @@

> @@ -737,6 +773,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < 0 && val2 != 0)
> +			return -EINVAL;
> +		return ad7606_set_sampling_freq(st, val);

Currently I think  for the !backend + pwm case this can go out of
range for which that code works (fsleep removed in next patch).
Perhaps delay adding this until after that patch.
>  	default:
>  		return -EINVAL;
>  	}

> @@ -1108,7 +1186,24 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  					       st->cnvst_pwm);
>  		if (ret)
>  			return ret;
> +	}
> +
> +	if (st->bops->iio_backend_config) {
> +		/*
> +		 * If there is a backend, the PWM should not overpass the maximum sampling
> +		 * frequency the chip supports.
> +		 */
> +		ret = ad7606_set_sampling_freq(st,
> +					       chip_info->max_samplerate ? : 2 * KILO);
> +		if (ret)
> +			return ret;
> +
> +		ret = st->bops->iio_backend_config(dev, indio_dev);
> +		if (ret)
> +			return ret;
> +		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
>  	} else {
> +		init_completion(&st->completion);
>  		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
>  						  indio_dev->name,
>  						  iio_device_id(indio_dev));
It's a little hard to unwind the patches, but this was previously in the !pwm case.
At this point in the series we still allow the pwm case to work with ! backend.
So is this now running in that case?   Do we need a temporary additional check
on !pwm


> @@ -1126,15 +1221,14 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  						      &ad7606_buffer_ops);
>  		if (ret)
>  			return ret;
> +		ret = devm_request_threaded_irq(dev, irq,
> +						NULL,
> +						&ad7606_interrupt,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						chip_info->name, indio_dev);
> +		if (ret)
> +			return ret;
>  	}
> -	ret = devm_request_threaded_irq(dev, irq,
> -					NULL,
> -					&ad7606_interrupt,
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					chip_info->name, indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);

> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index b87be2f1ca04..6042f6799272 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -2,7 +2,8 @@
> +
> +static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int ret, c;
> +	struct iio_backend_data_fmt data = {
> +		.sign_extend = true,
> +		.enable = true,
> +	};
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	/* If the device is iio_backend powered the PWM is mandatory */
> +	if (!st->cnvst_pwm)
> +		return dev_err_probe(st->dev, -EINVAL,
> +				     "A PWM is mandatory when using backend.\n");
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	for (c = 0; c < indio_dev->num_channels; c++) {
> +		ret = iio_backend_data_format_set(st->back, c, &data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	indio_dev->channels = ad7606b_bi_channels;

Ultimately this may want to move into the chip_info structures as more devices are added
but this is fine for now I suppose.

> +	indio_dev->num_channels = 8;
> +
> +	return 0;
> +}

