Return-Path: <linux-pwm+bounces-3222-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285B97665B
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748821C23216
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB819F414;
	Thu, 12 Sep 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vcwvb13z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD419EEA1
	for <linux-pwm@vger.kernel.org>; Thu, 12 Sep 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135632; cv=none; b=dnVYrI/M6Z2EPROrht1VBWYy2UYUt6ToVKC05ZVBQrcU3hNpDxBhYPstnm7gCIE6d970yscnJIxKytP0B7/q5mZBBeUSTt/oRvnBCtBNPcT1/Z68vcdTyf1UcdrlaSHw62i++UmgZTNunP9VgOunWYETnQ28ID5oQ01pWxessVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135632; c=relaxed/simple;
	bh=hlyxAfy4Uc+uk9TsozR9uY85QpFwtlx3OcP8oHDAcz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGkoxUyU0yhPfH4V5UHLZhtrGM5t/kbJr/tfNNXil+udjwcnjXtZzH0F9SjJgVHYKP6sd75Jco/O3Bfa4tQaS/Ifn4ODMh1Hv33YeY4cWfJFxX9y9h9+wQId6XNidnJUByTV6XX/JEvPajY//6MMo+gEciU6QioyaRgTnGlqk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vcwvb13z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374bd059b12so556830f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Sep 2024 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726135627; x=1726740427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5Ogzpc450UdjEe8LYlSkt0tyEEqIPEptYqyT1O089U=;
        b=Vcwvb13zNJiuNH020u323yMlHLN1b8kwm4CArYFJyYp+5eeAHMVCoiVFoCzPJwx6+K
         au9t2NaABTjK6aK3Vrr2zrjGrJwBFaSdEZeMWqOQMLh5l1RwBsAwwCTDJP19yyW4TTxK
         9cIys9mo2IwX48VSi4II/XKS1uW0EZdr0+I3CWZ6kofhmTfW+oI5O9lX9i8L1Iwo0E2q
         gP/AAkwGR12oH3QTwczMkB4sdJnCPDRLOYgWbSj5VlKLR7BLLJ34bpVA/He+v+/HF1+P
         QUeGEFnqLhrLbx2kKgY22rpjA5yIkNT5Lilt3fiePsF+DuqfRcC3oVJMUmVuuiK0b5IN
         +AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135627; x=1726740427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Ogzpc450UdjEe8LYlSkt0tyEEqIPEptYqyT1O089U=;
        b=dL7hf0GnVC8SoSdiptN2CRQlQOhCjlkg7SIu2W3ROlg+LItm1L8btRTo1umtiIwthA
         4B9e9lPVnEPQsQwps5H4zPsRyVmA2O4V1mEEHkhpumVsNa7vcPJ3NzHM3FJ95CsqKyfe
         pygsbqs0IQ2EP/QkvQA08qepR486l+0p2+pTLM29siJf7JnPcMOI5bbKFtA5cEd1T90z
         sDCmFEBRHF/+q9c7lK+lWOKCa3cec0PMWENze5tXUMXMxk6wCAbNvwIXGeXPSj620Xc7
         jD3+/rqDuiwLy+TuTO3XWT4QKLR+ZQL2xcoAKZ1k0Jgpxh8UBtfltCkQ8UQi6bmZ5O73
         R5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvLEnCWZJUvwhkamGPrzkKl9v3IslCWz4AzlIbKZiIqqYSxaSoNDo+wk9xTcmVetzfPypAFkXh+lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4PTz+zJwTLk4cxsDpwLJNTXj3bPxfnTnPVvFxcQksAoP0R/X
	mYOuaPzkP/0jZKJSOycVLDIjxreUWMCXbuGzHGusT3sJf0S9AMcUnuvExUbj9nc=
X-Google-Smtp-Source: AGHT+IHkQUS8AQd1Ygo73xrLMzGbmx1KmrOOEUHz2K5GI5K1EwJ3nsesCE8rcKc+1HmpjasqnCPNoA==
X-Received: by 2002:adf:8bd6:0:b0:374:fa0a:773c with SMTP id ffacd0b85a97d-378c2d4cb6amr1124898f8f.47.1726135626440;
        Thu, 12 Sep 2024 03:07:06 -0700 (PDT)
Received: from ?IPV6:2a02:8428:e55b:1101:a464:2bc6:7cd8:5d56? (2a02-8428-e55b-1101-a464-2bc6-7cd8-5d56.rev.sfr.net. [2a02:8428:e55b:1101:a464:2bc6:7cd8:5d56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb218d7sm170067915e9.9.2024.09.12.03.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 03:07:05 -0700 (PDT)
Message-ID: <c80170b9-a1ea-4e7a-ab9f-83236eac20f3@baylibre.com>
Date: Thu, 12 Sep 2024 12:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iio:adc:ad7606: Add iio-backend support
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Nuno Sa <nuno.sa@analog.com>, aardelean@baylibre.com
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
 <20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
 <20240817164748.30091016@jic23-huawei>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20240817164748.30091016@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/17/24 17:47, Jonathan Cameron wrote:
> On Thu, 15 Aug 2024 12:12:02 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
>
>> - Basic support for iio backend.
>> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
>> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
>>    supported if iio-backend mode is selected.
>>
>> A small correction was added to the driver's file name in the Kconfig
>> file's description.
>>
> I'm going to want Nuno's input on this.  Given it's the summer that may
> take a little while, so in meantime a few comments inline.
>
> Jonathan
>
>   
>> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>> ---
>>   drivers/iio/adc/Kconfig      |   3 +-
>>   drivers/iio/adc/ad7606.c     | 103 +++++++++++++++++++++++++++++++++++--------
>>   drivers/iio/adc/ad7606.h     |  16 +++++++
>>   drivers/iio/adc/ad7606_par.c |  98 +++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 200 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 88e8ce2e78b3..01248b6df868 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -227,9 +227,10 @@ config AD7606_IFACE_PARALLEL
>>   	help
>>   	  Say yes here to build parallel interface support for Analog Devices:
>>   	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
>> +	  It also support iio_backended devices for AD7606B.
>>   
>>   	  To compile this driver as a module, choose M here: the
>> -	  module will be called ad7606_parallel.
>> +	  module will be called ad7606_par.
> If we can avoid a rename that would be good.  Or was this always wrong?
> If so spin a fix patch before this one.

It was always wrong, will fix it with a separate patch.
>
>>   
>>   config AD7606_IFACE_SPI
>>   	tristate "Analog Devices AD7606 ADC driver with spi interface support"
>> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
>> index 99d5ca5c2348..a753d5caa9f8 100644
>> --- a/drivers/iio/adc/ad7606.c
>> +++ b/drivers/iio/adc/ad7606.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/util_macros.h>
>>   #include <linux/units.h>
>>   
>> +#include <linux/iio/backend.h>
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/buffer.h>
>>   #include <linux/iio/sysfs.h>
>> @@ -148,7 +149,15 @@ static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
>>   
>>   static int ad7606_read_samples(struct ad7606_state *st)
>>   {
>> -	unsigned int num = st->chip_info->num_channels - 1;
>> +	unsigned int num = st->chip_info->num_channels;
>> +
>> +	/*
>> +	 * Timestamp channel does not contain sample, and no timestamp channel if
>> +	 * backend is used.
>> +	 */
>> +	if (!st->back)
>> +		num--;
>> +
>>   	u16 *data = st->data;
>>   	int ret;
>>   
>> @@ -220,11 +229,15 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>>   		if (!ret)
>>   			return ret;
>>   	}
>> -	ret = wait_for_completion_timeout(&st->completion,
>> -					  msecs_to_jiffies(1000));
>> -	if (!ret) {
>> -		ret = -ETIMEDOUT;
>> -		goto error_ret;
>> +
>> +	/* backend manages interruptions by itself.*/
>> +	if (!st->back) {
>> +		ret = wait_for_completion_timeout(&st->completion,
>> +						  msecs_to_jiffies(1000));
>> +		if (!ret) {
>> +			ret = -ETIMEDOUT;
>> +			goto error_ret;
>> +		}
>>   	}
>>   
>>   	ret = ad7606_read_samples(st);
>> @@ -271,6 +284,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>>   		*val = st->oversampling;
>>   		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
>> +		/* If the PWM is swinging, return the real frequency, otherwise 0 */
> So this only exists for the pwm case. In that case can we split the channel definitions
> into versions with an without this and register just the right one.
>
> A sampling frequency of 0 usually means no sampling, not that we can tell what it
> is.  If we can't tell don't provide the file.

The file is provided only for the "backended" device 
(AD7606_BI_CHANNEL), BI being Backend Interface. This mode only works 
with PWM (and incidentally PWM is meant to be used only in conjuction 
with backend).

When the PWM is not running because e.g sampling is not enabled, or PWM 
failed to start, I return 0. Shall I always return the configured value 
instead of the real one ?

>
>
>> +		*val = ad7606_pwm_is_swinging(st) ?
>> +			DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period) : 0;
>> +		return IIO_VAL_INT;
>>   	}
>>   	return -EINVAL;
>>   }
>> @@ -360,6 +379,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>>   			return ret;
>>   
>>   		return 0;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		return ad7606_set_sampling_freq(st, val);
>>   	default:
>>   		return -EINVAL;
>>   	}
>
>>   static const struct iio_trigger_ops ad7606_trigger_ops = {
>> @@ -602,8 +660,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>>   	indio_dev->channels = st->chip_info->channels;
>>   	indio_dev->num_channels = st->chip_info->num_channels;
>>   
>> -	init_completion(&st->completion);
>> -
>>   	ret = ad7606_reset(st);
>>   	if (ret)
>>   		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>> @@ -635,7 +691,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>>   			return ret;
>>   	}
>>   
>> -	/* If convst pin is not defined, setup PWM*/
>> +	/* If convst pin is not defined, setup PWM */
> Push into earlier patch.  Check for this sort of fix being in wrong patch
> before sending a series. It just adds noise to patch and to reviews.

Will do. Sorry for that.

>
>>   	if (!st->gpio_convst) {
>>   		st->cnvst_pwm = devm_pwm_get(dev, NULL);
>>   		if (IS_ERR(st->cnvst_pwm))
> ...
>
>> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
>> index aab8fefb84be..9a098cd77812 100644
>> --- a/drivers/iio/adc/ad7606.h
>> +++ b/drivers/iio/adc/ad7606.h
>> @@ -34,6 +34,12 @@
>>   		BIT(IIO_CHAN_INFO_SCALE),		\
>>   		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>>   
>> +#define AD7606_BI_CHANNEL(num)				\
>> +	AD760X_CHANNEL(num, 0,				\
>> +		BIT(IIO_CHAN_INFO_SCALE),		\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
>> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>> +
>>   #define AD7616_CHANNEL(num)	\
>>   	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
>>   		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>> @@ -61,6 +67,7 @@ enum ad7606_supported_device_ids {
>>    * @os_req_reset	some devices require a reset to update oversampling
>>    * @init_delay_ms	required delay in miliseconds for initialization
>>    *			after a restart
>> + * @has_backend		defines if a backend is available for the given chip
> That seems to me more of a case of does the driver support it.
> Linux kernel code has no way of knowing if a backend hardware exists
> or not.  Modify the comment to speak about if we know it works.
>
> Or is there something fundamental that stops the backend approach
> working with some devices?
>
> Why does the driver need this flag?

Potentially, I think any of those parts can have a backend and moreover, 
I don't see anything preventing any ADC to have a backend.

I introduced the flag as a way to differentiate the "new" way of 
supporting parallel interface, i.e using backend, from the "old" way 
(using port I/O).

There is a concurrency between the old implementation using port I/O and 
the new one using iio-backend, because they are both "platform", so the 
initial idea was that it would not make sense and be dangerous to look 
for a backend for the parts that have no existing (i'd rather say, like 
you pointed out,  supported) backend.

Having a second thought at it, the dt bindings already permits only 
io-backend property to be populated for the parts that actually have a 
backend, hence one of these is superfluous, or maybe even both are and 
the user is responsible for setting the right value in the dts. Any advice ?

>   
>
>>    */
>>   struct ad7606_chip_info {
>>   	enum ad7606_supported_device_ids id;
>> @@ -71,6 +78,7 @@ struct ad7606_chip_info {
>>   	unsigned int			oversampling_num;
>>   	bool				os_req_reset;
>>   	unsigned long			init_delay_ms;
>> +	bool				has_backend;
>>   };
>>   
>
>> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
>> index d83c0edc1e31..5c8a04556e25 100644
>> --- a/drivers/iio/adc/ad7606_par.c
>> +++ b/drivers/iio/adc/ad7606_par.c
>> @@ -3,6 +3,8 @@
>>    * AD7606 Parallel Interface ADC driver
>>    *
>>    * Copyright 2011 Analog Devices Inc.
>> + * Copyright 2024 Analog Devices Inc.
>> + * Copyright 2024 BayLibre SAS.
>>    */
>>   
>>   #include <linux/mod_devicetable.h>
>> @@ -11,10 +13,86 @@
>>   #include <linux/types.h>
>>   #include <linux/err.h>
>>   #include <linux/io.h>
>> +#include <linux/pwm.h>
>> +#include <linux/gpio.h>
>> +#include <linux/delay.h>
> Not on any order currently but try to minimize a future series
> that might clean this up.  Preference is alphabetical though fine
> to have a trailing block of IIO headers, then driver specific
> ones after that. You can either fix the current order in a
> separate patch, or just put your new headers in approximately the write place.
np, will fix that in a separate patch.
>
>>   
>>   #include <linux/iio/iio.h>
>> +#include <linux/iio/backend.h>
>>   #include "ad7606.h"
>
>
>> +static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio_dev)
>> +{
>> +		struct ad7606_state *st = iio_priv(indio_dev);
> Why 2 tabs?
by mistake.
>> +		unsigned int ret, c;
>> +
>> +		st->back = devm_iio_backend_get(dev, NULL);
>> +		if (IS_ERR(st->back))
>> +			return PTR_ERR(st->back);
>> +
>> +		/* If the device is iio_backend powered the PWM is mandatory */
>> +		if (!st->cnvst_pwm)
>> +			return -EINVAL;
>> +
>> +		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = devm_iio_backend_enable(dev, st->back);
>> +		if (ret)
>> +			return ret;
>> +
>> +		struct iio_backend_data_fmt data = {
>> +			.sign_extend = true,
>> +			.enable = true,
>> +		};
>> +		for (c = 0; c < indio_dev->num_channels; c++) {
>> +			ret = iio_backend_data_format_set(st->back, c, &data);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +
>> +		indio_dev->channels = ad7606b_bi_channels;
>> +		indio_dev->num_channels = 8;
>> +
>> +		return 0;
>> +}
>> +
>> +static const struct ad7606_bus_ops ad7606_bi_bops = {
>> +	.iio_backend_config = ad7606_bi_setup_iio_backend,
>> +	.update_scan_mode = ad7606_bi_update_scan_mode,
>> +};
>> +#endif
>> +
>>   static int ad7606_par16_read_block(struct device *dev,
>>   				   int count, void *buf)
>>   {
>> @@ -52,7 +130,20 @@ static int ad7606_par_probe(struct platform_device *pdev)
>>   	void __iomem *addr;
>>   	resource_size_t remap_size;
>>   	int irq;
>> -
>> +#ifdef CONFIG_IIO_BACKEND
>> +	struct iio_backend *back;
>> +
>> +	/*For now, only the AD7606B is backend compatible.*/
> /* For ... ble. */
again :-/
>
>> +	if (chip_info->has_backend) {
>> +		back = devm_iio_backend_get(&pdev->dev, NULL);
>> +		if (IS_ERR(back))
>> +			return PTR_ERR(back);
>> +
>> +		return ad7606_probe(&pdev->dev, 0, NULL,
>> +				    chip_info,
>> +				    &ad7606_bi_bops);
> Short wrap. Aim for 80 char limit unless it hurts readability a lot.
ok
>
>> +	}
>> +#endif
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0)
>>   		return irq;
>> @@ -74,6 +165,7 @@ static const struct platform_device_id ad7606_driver_ids[] = {
>>   	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
>>   	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
>>   	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
>> +	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
>> @@ -83,6 +175,7 @@ static const struct of_device_id ad7606_of_match[] = {
>>   	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
>>   	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
>>   	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
>> +	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(of, ad7606_of_match);
>> @@ -102,3 +195,6 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>>   MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_IMPORT_NS(IIO_AD7606);
>> +#ifdef CONFIG_IIO_BACKEND
>> +MODULE_IMPORT_NS(IIO_BACKEND);
> I'd not bother with config guards.  Importing a namespace we don't
> use should be harmless.
OK, will remove it. According to Nuno's feedback, I could also force the 
selection of CONFIG_IIO_BACKEND with the driver, which IMHO is not a bad 
idea, as it would allow to remove all those ifdefs.
>
>> +#endif
>>

