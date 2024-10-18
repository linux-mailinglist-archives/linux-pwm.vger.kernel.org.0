Return-Path: <linux-pwm+bounces-3726-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAC9A40B0
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4951C245DA
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934871D5AC7;
	Fri, 18 Oct 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WtQ8jY8e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E45137C37
	for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260446; cv=none; b=Hz4KiihDwMd6/mo1SwGlaJOKpFVcAAd4hfv/Tuz+bYiDmq1rAsfXaSZvzgf8E06QePXTAYuIo/PkmI424sWYj7m7MneFm+2nhUb85j+Or1pD60ngJI4ocR/xfYGqPIM5YGVNPbL8OIR+y5qv7j4iDHYoZPOFyTTHxp0zkaWkCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260446; c=relaxed/simple;
	bh=hTmOoeYkkKr1yWGiWUboixw3ZBG3rEt3g84e+t5hILY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcZZBHhDmrK6IT/tm62uTUHrLVxSktJ+LFfrXh+lIHD/YxHwmwDY3vTjiJbGDjRZjA7nBgM5kglPGzy/BoYCTsYpyDI9DrzWqBWmju0XlueEB7r2CYs+I/lRg3+jQjb5LcCsgKy+WFmekMwQAPnWvnqNDorVKo09RYcyFLIhKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WtQ8jY8e; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso24215041fa.0
        for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729260441; x=1729865241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSbRbtCh9+74ZMgaCPUKCrhIAEqMl+1p0/E2aSxWAUI=;
        b=WtQ8jY8exNokgCUqn48Co6hTajk44zw7le1JdR/+eA6c4Ds/KCh+zSEsGBmYAEnyWN
         CUXLTaznkEhy5Tewze8wRaV3SnUuiSlrSpGBAbKEUi53PA8dpY+Z98B+cZOFbrQMjvZD
         QNmYgaYbh9xA2ti5e93BFcfOSlYp8GCDkMtB0vpvs4FXaDMvn/QLJeh5ICNwgIR2iN16
         cmBPJz2TncigEPPkABJLBkS+gGBEyWd7HPmsPmW8a6gfsTES7crqDb/QjXZLmuyrngyk
         RPBy+WyscL17VpZoK4rv2weH+f7NtFrL35wAMIYNxd6Kb5HhqYJJNaqgKEMSrvmcf01Z
         4gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729260441; x=1729865241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSbRbtCh9+74ZMgaCPUKCrhIAEqMl+1p0/E2aSxWAUI=;
        b=Tbej9vQUZR+6zw8XiS6L/kIxG1MatRi62YhJZa0C28GZqMxeN7Pl5Fp9EGoonrDMds
         ZiNiLBviXC+bNt5wJ3Bhua59z6lsuqeMC+SYZsIkjAu5avmMrMoE2xYa0Lf4UV/c7Tz7
         A7pYs95u4j/jouhAx53Y85sPiXslkjlos1Xuv6PrN7yVVwRo1PxVX1Ib9oqAbW9P+5EI
         jqDn0s7eKv8NY6Uq9wgdDSGLE7298Ce7Ctk3yV9Hs8I5L40mL8ZFd13NCyaxPN5ip4pU
         WkgS1jYXfEvfsx8mfQW0QCkNzIgZcg+ahoXk7CiW/l50rDfV0OobIwN7v5qyZBSVQ9ao
         iogQ==
X-Gm-Message-State: AOJu0YxkKjYulP/3TpcRErw36lNNUx0BHVOV/JR2Uzoc/gPRNmZeDvYg
	YqgPfpSvZevV0vG/2hHaGFxYWCiX4ac2PRIFkK2sxojd2e5H/rHvxRxG697gvTItXW4mDkHjiud
	g
X-Google-Smtp-Source: AGHT+IFWUujOYEHq4+rtVWMxZSQ9eS6rTnMd1FQFgPH9KP4HZ7SzmQUqy/+j0iM5qa2rPYDlF17HwQ==
X-Received: by 2002:a05:651c:551:b0:2fa:d4ef:f222 with SMTP id 38308e7fff4ca-2fb8320b662mr12970311fa.38.1729260440215;
        Fri, 18 Oct 2024 07:07:20 -0700 (PDT)
Received: from ?IPV6:2a02:8428:e55b:1101:f480:6186:20d4:668a? (2a02-8428-e55b-1101-f480-6186-20d4-668a.rev.sfr.net. [2a02:8428:e55b:1101:f480:6186:20d4:668a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e4f7a6sm25067775e9.42.2024.10.18.07.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:07:19 -0700 (PDT)
Message-ID: <a6bee0f1-3b06-44d6-9592-ab7f04a3ffcd@baylibre.com>
Date: Fri, 18 Oct 2024 16:07:18 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] iio: adc: ad7606: Add iio-backend support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com,
 nuno.sa@analog.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
 <20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c@baylibre.com>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/15/24 15:56, Guillaume Stols wrote:
> - Basic support for iio backend.
> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
>    supported if iio-backend mode is selected.
>
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>   drivers/iio/adc/Kconfig      |   2 +
>   drivers/iio/adc/ad7606.c     | 154 ++++++++++++++++++++++++++++++++++---------
>   drivers/iio/adc/ad7606.h     |  15 +++++
>   drivers/iio/adc/ad7606_par.c |  92 +++++++++++++++++++++++++-
>   4 files changed, 231 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 91873f60322d..a57b5f0bc070 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -224,9 +224,11 @@ config AD7606_IFACE_PARALLEL
>   	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
>   	depends on HAS_IOPORT
>   	select AD7606
> +	select IIO_BACKEND
>   	help
>   	  Say yes here to build parallel interface support for Analog Devices:
>   	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> +	  It also support iio_backended devices for AD7606B.
>   
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called ad7606_par.
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 34d377e9ac79..7871552ce5ac 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -21,6 +21,7 @@
>   #include <linux/units.h>
>   #include <linux/util_macros.h>
>   
> +#include <linux/iio/backend.h>
>   #include <linux/iio/buffer.h>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
> @@ -191,6 +192,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_4_info, IIO_AD7606);
>   
>   const struct ad7606_chip_info ad7606b_info = {
>   	.channels = ad7606_channels_16bit,
> +	.max_samplerate = 800 * KILO,
>   	.name = "ad7606b",
>   	.num_adc_channels = 8,
>   	.num_channels = 9,
> @@ -490,6 +492,17 @@ static int ad7606_pwm_set_low(struct ad7606_state *st)
>   	return ret;
>   }
>   
> +static int ad7606_pwm_set_swing(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	cnvst_pwm_state.enabled = true;
> +	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
> +
> +	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +}
> +
>   static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
>   {
>   	struct pwm_state cnvst_pwm_state;
> @@ -576,11 +589,22 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
>   		if (ret < 0)
>   			return ret;
>   	}
> -	ret = wait_for_completion_timeout(&st->completion,
> -					  msecs_to_jiffies(1000));
> -	if (!ret) {
> -		ret = -ETIMEDOUT;
> -		goto error_ret;
> +
> +	/*
> +	 * If no backend, wait for the interruption on busy pin, otherwise just add
> +	 * a delay to leave time for the data to be available. For now, the latter
> +	 * will not happen because IIO_CHAN_INFO_RAW is not supported for the backend.
> +	 * TODO: Add support for reading a single value when the backend is used.
> +	 */
> +	if (!st->back) {
> +		ret = wait_for_completion_timeout(&st->completion,
> +						  msecs_to_jiffies(1000));
> +		if (!ret) {
> +			ret = -ETIMEDOUT;
> +			goto error_ret;
> +		}
> +	} else {
> +		fsleep(1);
>   	}
>   
>   	ret = ad7606_read_samples(st);
> @@ -620,6 +644,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>   	int ret, ch = 0;
>   	struct ad7606_state *st = iio_priv(indio_dev);
>   	struct ad7606_chan_scale *cs;
> +	struct pwm_state cnvst_pwm_state;
>   
>   	switch (m) {
>   	case IIO_CHAN_INFO_RAW:
> @@ -640,6 +665,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>   		*val = st->oversampling;
>   		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/*
> +		 * TODO: return the real frequency intead of the requested one once
> +		 * pwm_get_state_hw comes upstream.
> +		 */
> +		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
> +		return IIO_VAL_INT;
>   	}
>   	return -EINVAL;
>   }
> @@ -732,6 +765,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>   			return ret;
>   
>   		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < 0 && val2 != 0)
> +			return -EINVAL;
> +		return ad7606_set_sampling_freq(st, val);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -914,14 +951,50 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
>   	return -EINVAL;
>   }
>   
> +static int ad7606_backend_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_pwm_set_swing(st);
> +}
> +
> +static int ad7606_backend_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_pwm_set_low(st);
> +}
> +
> +static int ad7606_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * The update scan mode is only for iio backend compatible drivers.
> +	 * If the specific update_scan_mode is not defined in the bus ops,
> +	 * just do nothing and return 0.
> +	 */
> +	if (!st->bops->update_scan_mode)
> +		return 0;
> +
> +	return st->bops->update_scan_mode(indio_dev, scan_mask);
> +}
> +
>   static const struct iio_buffer_setup_ops ad7606_buffer_ops = {
>   	.postenable = &ad7606_buffer_postenable,
>   	.predisable = &ad7606_buffer_predisable,
>   };
>   
> +static const struct iio_buffer_setup_ops ad7606_backend_buffer_ops = {
> +	.postenable = &ad7606_backend_buffer_postenable,
> +	.predisable = &ad7606_backend_buffer_predisable,
> +};
> +
>   static const struct iio_info ad7606_info_no_os_or_range = {
>   	.read_raw = &ad7606_read_raw,
>   	.validate_trigger = &ad7606_validate_trigger,
> +	.update_scan_mode = &ad7606_update_scan_mode,
>   };
>   
>   static const struct iio_info ad7606_info_os_and_range = {
> @@ -929,6 +1002,7 @@ static const struct iio_info ad7606_info_os_and_range = {
>   	.write_raw = &ad7606_write_raw,
>   	.attrs = &ad7606_attribute_group_os_and_range,
>   	.validate_trigger = &ad7606_validate_trigger,
> +	.update_scan_mode = &ad7606_update_scan_mode,
>   };
>   
>   static const struct iio_info ad7606_info_sw_mode = {
> @@ -937,6 +1011,7 @@ static const struct iio_info ad7606_info_sw_mode = {
>   	.read_avail = &ad7606_read_avail,
>   	.debugfs_reg_access = &ad7606_reg_access,
>   	.validate_trigger = &ad7606_validate_trigger,
> +	.update_scan_mode = &ad7606_update_scan_mode,
>   };
>   
>   static const struct iio_info ad7606_info_os = {
> @@ -944,6 +1019,7 @@ static const struct iio_info ad7606_info_os = {
>   	.write_raw = &ad7606_write_raw,
>   	.attrs = &ad7606_attribute_group_os,
>   	.validate_trigger = &ad7606_validate_trigger,
> +	.update_scan_mode = &ad7606_update_scan_mode,
>   };
>   
>   static const struct iio_info ad7606_info_range = {
> @@ -951,6 +1027,7 @@ static const struct iio_info ad7606_info_range = {
>   	.write_raw = &ad7606_write_raw,
>   	.attrs = &ad7606_attribute_group_range,
>   	.validate_trigger = &ad7606_validate_trigger,
> +	.update_scan_mode = &ad7606_update_scan_mode,
>   };
>   
>   static const struct iio_trigger_ops ad7606_trigger_ops = {
> @@ -1070,8 +1147,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>   	indio_dev->channels = st->chip_info->channels;
>   	indio_dev->num_channels = st->chip_info->num_channels;
>   
> -	init_completion(&st->completion);
> -
>   	ret = ad7606_reset(st);
>   	if (ret)
>   		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
> @@ -1118,34 +1193,51 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>   		if (ret)
>   			return ret;
>   	}
> -	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> -					  indio_dev->name,
> -					  iio_device_id(indio_dev));
> -	if (!st->trig)
> -		return -ENOMEM;
>   
> -	st->trig->ops = &ad7606_trigger_ops;
> -	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	ret = devm_iio_trigger_register(dev, st->trig);
> -	if (ret)
> -		return ret;
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
>   
> -	indio_dev->trig = iio_trigger_get(st->trig);
> +		indio_dev->setup_ops = &ad7606_backend_buffer_ops;
> +	} else {
> +		init_completion(&st->completion);
> +		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						  indio_dev->name,
> +						  iio_device_id(indio_dev));
> +		if (!st->trig)
> +			return -ENOMEM;
> +
> +		st->trig->ops = &ad7606_trigger_ops;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +		ret = devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return ret;
>   
> -	ret = devm_request_threaded_irq(dev, irq,
> -					NULL,
> -					&ad7606_interrupt,
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					chip_info->name, indio_dev);
> -	if (ret)
> -		return ret;
> +		indio_dev->trig = iio_trigger_get(st->trig);
>   
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7606_trigger_handler,
> -					      &ad7606_buffer_ops);
> -	if (ret)
> -		return ret;
> +		ret = devm_request_threaded_irq(dev, irq, NULL, &ad7606_interrupt,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						chip_info->name, indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      &iio_pollfunc_store_time,
> +						      &ad7606_trigger_handler,
> +						      &ad7606_buffer_ops);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return devm_iio_device_register(dev, indio_dev);
>   }
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index b26a11b2eba1..2c629a15cc33 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -61,6 +61,12 @@
>   
>   #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
>   
> +#define AD7606_BI_CHANNEL(num)				\
> +	AD760X_CHANNEL(num, 0,				\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), 16)
> +
>   struct ad7606_state;
>   
>   typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
> @@ -69,6 +75,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
>   /**
>    * struct ad7606_chip_info - chip specific information
>    * @channels:		channel specification
> + * @max_samplerate:	maximum supported samplerate
>    * @name		device name
>    * @num_channels:	number of channels
>    * @num_adc_channels	the number of channels the ADC actually inputs.
> @@ -82,6 +89,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
>    */
>   struct ad7606_chip_info {
>   	const struct iio_chan_spec	*channels;
> +	unsigned int			max_samplerate;
>   	const char			*name;
>   	unsigned int			num_adc_channels;
>   	unsigned int			num_channels;
> @@ -152,6 +160,7 @@ struct ad7606_state {
>   	bool				sw_mode_en;
>   	const unsigned int		*oversampling_avail;
>   	unsigned int			num_os_ratios;
> +	struct iio_backend		*back;
>   	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
>   	int (*write_os)(struct iio_dev *indio_dev, int val);
>   
> @@ -180,16 +189,21 @@ struct ad7606_state {
>   
>   /**
>    * struct ad7606_bus_ops - driver bus operations
> + * @iio_backend_config	function pointer for configuring the iio_backend for
> + *			the compatibles that use it
>    * @read_block		function pointer for reading blocks of data
>    * @sw_mode_config:	pointer to a function which configured the device
>    *			for software mode
>    * @reg_read	function pointer for reading spi register
>    * @reg_write	function pointer for writing spi register
>    * @write_mask	function pointer for write spi register with mask
> + * @update_scan_mode	function pointer for handling the calls to iio_info's update_scan
> + *			mode when enabling/disabling channels.
>    * @rd_wr_cmd	pointer to the function which calculates the spi address
>    */
>   struct ad7606_bus_ops {
>   	/* more methods added in future? */
> +	int (*iio_backend_config)(struct device *dev, struct iio_dev *indio_dev);
>   	int (*read_block)(struct device *dev, int num, void *data);
>   	int (*sw_mode_config)(struct iio_dev *indio_dev);
>   	int (*reg_read)(struct ad7606_state *st, unsigned int addr);
> @@ -200,6 +214,7 @@ struct ad7606_bus_ops {
>   				 unsigned int addr,
>   				 unsigned long mask,
>   				 unsigned int val);
> +	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
>   	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
>   };
>   
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index b87be2f1ca04..6946ff00e4cb 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -2,7 +2,8 @@
>   /*
>    * AD7606 Parallel Interface ADC driver
>    *
> - * Copyright 2011 Analog Devices Inc.
> + * Copyright 2011 - 2024 Analog Devices Inc.
> + * Copyright 2024 BayLibre SAS.
>    */
>   
>   #include <linux/err.h>
> @@ -14,9 +15,82 @@
>   #include <linux/property.h>
>   #include <linux/types.h>
>   
> +#include <linux/iio/backend.h>
>   #include <linux/iio/iio.h>
> +
>   #include "ad7606.h"
>   
> +static const struct iio_chan_spec ad7606b_bi_channels[] = {
> +	AD7606_BI_CHANNEL(0),
> +	AD7606_BI_CHANNEL(1),
> +	AD7606_BI_CHANNEL(2),
> +	AD7606_BI_CHANNEL(3),
> +	AD7606_BI_CHANNEL(4),
> +	AD7606_BI_CHANNEL(5),
> +	AD7606_BI_CHANNEL(6),
> +	AD7606_BI_CHANNEL(7),
> +};
> +
> +static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int c, ret;
> +
> +	for (c = 0; c < indio_dev->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
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
> +	indio_dev->num_channels = 8;
> +
> +	return 0;
> +}
> +
> +static const struct ad7606_bus_ops ad7606_bi_bops = {
> +	.iio_backend_config = ad7606_bi_setup_iio_backend,
> +	.update_scan_mode = ad7606_bi_update_scan_mode,
> +};
> +
>   static int ad7606_par16_read_block(struct device *dev,
>   				   int count, void *buf)
>   {
> @@ -96,9 +170,22 @@ static int ad7606_par_probe(struct platform_device *pdev)
>   	void __iomem *addr;
>   	resource_size_t remap_size;
>   	int irq;
> +	struct iio_backend *back;

Just spotted that I forgot to remove the declaration. Shall I send 
another series with this correction ?

>   
> +	/*
> +	 * If a firmware node is available (ACPI or DT), platform_device_id is null
> +	 * and we must use get_match_data.
> +	 */
>   	if (dev_fwnode(&pdev->dev)) {
>   		chip_info = device_get_match_data(&pdev->dev);
> +		if (device_property_present(&pdev->dev, "io-backends"))
> +			/*
> +			 * If a backend is available ,call the core probe with backend
> +			 * bops, otherwise use the former bops.
> +			 */
> +			return ad7606_probe(&pdev->dev, 0, NULL,
> +					    chip_info,
> +					    &ad7606_bi_bops);
>   	} else {
>   		id = platform_get_device_id(pdev);
>   		chip_info = (const struct ad7606_chip_info *)id->driver_data;
> @@ -124,6 +211,7 @@ static const struct platform_device_id ad7606_driver_ids[] = {
>   	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
>   	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
>   	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
> +	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
> @@ -133,6 +221,7 @@ static const struct of_device_id ad7606_of_match[] = {
>   	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
>   	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
>   	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
> +	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, ad7606_of_match);
> @@ -152,3 +241,4 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>   MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
>   MODULE_LICENSE("GPL v2");
>   MODULE_IMPORT_NS(IIO_AD7606);
> +MODULE_IMPORT_NS(IIO_BACKEND);
>

