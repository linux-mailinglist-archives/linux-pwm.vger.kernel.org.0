Return-Path: <linux-pwm+bounces-3223-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880C97668B
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD41C2266D
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0B19F423;
	Thu, 12 Sep 2024 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JokuuGst"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3F188587
	for <linux-pwm@vger.kernel.org>; Thu, 12 Sep 2024 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136038; cv=none; b=UqhtZZpEfm5+p1Gy38ZlGqCR6EjeayS7Fnp1/Xu/HpUMKi2O2EgDLGvMFQbmcOtDcbGiNgJ2RroWkUtEFBnVqmqAQM7O2Q4jlj2IEpsaUUPf/ASG/WkIqY9Cfi+ddykJP73L5tCyL6aJPWhvIEhuV/AM3zi3imOL3tuWOt2xfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136038; c=relaxed/simple;
	bh=pWuYnZdetnnnu+3BlcUE/4gNPjsDaaKXpqGIDigZmfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeWeWSgUJ8oiYox2q4IC5KjcvjL6jxA06b7viGTjxEyIf94JdP4PtuAsN2vsq8XZC69byOjURQ23Jo8S/TuADjTcQvTImPai4psHvT79GpBukOHgAq4NqFpiFklEpVf3T7WwJAdHdP76TejafjYxXdF4Fq1n14eQ4s7u9vyP574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JokuuGst; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso8517375e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Sep 2024 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726136034; x=1726740834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ax7dbBbCuzQUcfZcqCi06hx4jCIx6kiT7TrMLm6qkD0=;
        b=JokuuGstRYcrSol6rHF/9RQNn64YhBGHUl6S/EZTgWdA0EUDqUwl5diQvGkE/vF2Nc
         T3u05t7H5HchK7hV25w6vwUI0ouqHTdRtzTvxX07VXCnuFAiIXcMnnYJdF0SHOWCQGlG
         jDr2rdFU42Tqu6t5If0wksq7yOIUHem0WyegHbgR+8Y/7qGVwVAPmZrU6JhVhWGzQCzF
         +DQtswEyex8LsMsaJN941rUO6bGfYB7NiXxio+TY0vtuuSFvcD7v1S/8rc7To4IH1K38
         ml+8+Z8NCZIXWpCAHPgRKv5Kq0I636kKbZjaLJGFZgqjF4cckmNKTaPVTuvQOHjSxJ8E
         74gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136034; x=1726740834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax7dbBbCuzQUcfZcqCi06hx4jCIx6kiT7TrMLm6qkD0=;
        b=RQSKO1GtjSe0biQLZtFjJPSJ5Y0Eo9akYVO7csaneBWxjFEttoMCVZjE9q98UIJdCF
         ceGqrrAMgDJHyP4EI6TzXPmqzJGULH0w7joooxi4tcs/Kfv4FyXh4TUMimAtf3jSmptW
         ssS05WoAaXleQ4i4cTD3rrz/+rdZi+f9CwDHvYstX6seZ8OLPBd+NvPNNQ1WmGLYOxL/
         1dcRzgiKvDKKviHUb+37MyJ/3CcYiKh77gE6MXR3P7RObabHO/fmmvbEs81ppw5a17Gg
         eJP57LjlLb4olfz3Lpsmtb0A2zfi6DP3+aRfQDsYSkjWIJE2LySE5HbS5l8fIF+U9Mfu
         wdyQ==
X-Gm-Message-State: AOJu0YwcJjFaxnDq6RGMOR8Y6yDX+LgQsj2jv8sIBQjkAhwFHYQXS/DM
	EiP1NvNQqfTlFIBs7bNeBi2WP5ccTR20q0hD4GOtb67gm474Tv4HzrDopZcjKSY=
X-Google-Smtp-Source: AGHT+IGupFXKL8Oc6nvWjZJWcoxASYjloZVWY9tJWtiOtX2e41F+Jn5Rq4bbYQ4F3WiAHGg87siCJA==
X-Received: by 2002:adf:eec5:0:b0:374:c231:a5ea with SMTP id ffacd0b85a97d-378c2cd39f8mr1794861f8f.5.1726136033785;
        Thu, 12 Sep 2024 03:13:53 -0700 (PDT)
Received: from ?IPV6:2a02:8428:e55b:1101:a464:2bc6:7cd8:5d56? (2a02-8428-e55b-1101-a464-2bc6-7cd8-5d56.rev.sfr.net. [2a02:8428:e55b:1101:a464:2bc6:7cd8:5d56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3941sm13981214f8f.84.2024.09.12.03.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 03:13:53 -0700 (PDT)
Message-ID: <31a1dfeb-2d72-44bc-b3ca-36b4115c3010@baylibre.com>
Date: Thu, 12 Sep 2024 12:13:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iio:adc:ad7606: Add iio-backend support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com,
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com,
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
 <20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
 <5dedf51d8ec19b7b3bd0c6cb136048344f1c1007.camel@gmail.com>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <5dedf51d8ec19b7b3bd0c6cb136048344f1c1007.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/24 10:40, Nuno Sá wrote:
> On Thu, 2024-08-15 at 12:12 +0000, Guillaume Stols wrote:
>> - Basic support for iio backend.
>> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
>> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
>>    supported if iio-backend mode is selected.
>>
>> A small correction was added to the driver's file name in the Kconfig
>> file's description.
>>
>> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>> ---
> Hi Guillaume,
>
> Some initial feedback from me...
>
>>   drivers/iio/adc/Kconfig      |   3 +-
>>   drivers/iio/adc/ad7606.c     | 103 +++++++++++++++++++++++++++++++++++-------
>> -
>>   drivers/iio/adc/ad7606.h     |  16 +++++++
>>   drivers/iio/adc/ad7606_par.c |  98 +++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 200 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 88e8ce2e78b3..01248b6df868 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -227,9 +227,10 @@ config AD7606_IFACE_PARALLEL
>>   	help
>>   	  Say yes here to build parallel interface support for Analog
>> Devices:
>>   	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters
>> (ADC).
>> +	  It also support iio_backended devices for AD7606B.
>>   
>>   	  To compile this driver as a module, choose M here: the
>> -	  module will be called ad7606_parallel.
>> +	  module will be called ad7606_par.
>>   
>>   config AD7606_IFACE_SPI
>>   	tristate "Analog Devices AD7606 ADC driver with spi interface
>> support"
>> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
>> index 99d5ca5c2348..a753d5caa9f8 100644
>> --- a/drivers/iio/adc/ad7606.c
>> +++ b/drivers/iio/adc/ad7606.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/util_macros.h>
>>   #include <linux/units.h>
>> +
>> +	/* backend manages interruptions by itself.*/
> missing space before closing the comment (also not sure the comments adds much)


thx, will check again


>
>> +	if (!st->back) {
>> +		ret = wait_for_completion_timeout(&st->completion,
>> +						  msecs_to_jiffies(1000));
>> +		if (!ret) {
>> +			ret = -ETIMEDOUT;
>> +			goto error_ret;
>> +		}
>>   	}
>>   
>>   	ret = ad7606_read_samples(st);
>> @@ -271,6 +284,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>>   		*val = st->oversampling;
>>   		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
>> +		/* If the PWM is swinging, return the real frequency,
>> otherwise 0 */
>> +		*val = ad7606_pwm_is_swinging(st) ?
>> +			DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
>> cnvst_pwm_state.period) : 0;
>> +		return IIO_VAL_INT;
>>   	}
>>   	return -EINVAL;
>>   }
>> @@ -360,6 +379,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>>   			return ret;
>>   
>>   		return 0;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		return ad7606_set_sampling_freq(st, val);
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -482,7 +503,6 @@ static int ad7606_buffer_postenable(struct iio_dev
>> *indio_dev)
>>   	struct ad7606_state *st = iio_priv(indio_dev);
>>   
>>   	gpiod_set_value(st->gpio_convst, 1);
>> -	ad7606_pwm_set_swing(st);
>>   
>>   	return 0;
>>   }
>> @@ -492,19 +512,53 @@ static int ad7606_buffer_predisable(struct iio_dev
>> *indio_dev)
>>   	struct ad7606_state *st = iio_priv(indio_dev);
>>   
>>   	gpiod_set_value(st->gpio_convst, 0);
>> -	ad7606_pwm_set_low(st);
>>   
>>   	return 0;
>>   }
>>   
>> +static int ad7606_pwm_buffer_postenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ad7606_state *st = iio_priv(indio_dev);
>> +
>> +	return ad7606_pwm_set_swing(st);
>> +}
>> +
>> +static int ad7606_pwm_buffer_predisable(struct iio_dev *indio_dev)
>> +{
>> +	struct ad7606_state *st = iio_priv(indio_dev);
>> +
>> +	return ad7606_pwm_set_low(st);
>> +}
> Maybe I'm missing something but are we removing the gpiod calls?


Well actually the pwm is meant to be used only with backend. Though it 
could be used without it, I dont think it is a very good idea because 
interrupt handling + transmission init takes quite some time, and a new 
rising edge could happen before the current samples are effectively 
transferred. However, since PWM and backend are two separate things, I 
wanted to show an usage for the PWM when introducing it, and one way to 
do it was to use it to emulate a GPIO by setting the duty cycle 100% for 
having a 1 (set_high) and 0% for having a 0 (set_low). Then on this 
patch, since we introduce iio-backend, I removed this 'mock' usage of it.

But I think that I should separate the removal into an additional patch 
to avoid confusions. Or shall I just remove the mock usage from the PWM 
patch ?


>> +
>> +static int ad7606_update_scan_mode(struct iio_dev *indio_dev,
>> +				   const unsigned long *scan_mask)
>> +{
>> +	struct ad7606_state *st = iio_priv(indio_dev);
>> +
>> +	/* The update scan mode is only for iio backend compatible drivers.
>> +	 * If the specific update_scan_mode is not defined in the bus ops,
>> +	 * just do nothing and return 0.
>> +	 */
>> +	if (st->bops->update_scan_mode)
>> +		return st->bops->update_scan_mode(indio_dev, scan_mask);
>> +	else
>> +		return 0;
> Redundant else


ack

>> -	if (ret)
>> -		return ret;
>>   
>> +	if (st->bops->iio_backend_config) {
>> +		st->bops->iio_backend_config(dev, indio_dev);
>> +		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
> Ignoring error code


will handle


>
>> +	} else {
>> +		/* Reserve the PWM use only for backend (force gpio_convst
>> definition)*/
>> +		if (!st->gpio_convst)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "Convst pin must be defined when
>> not in backend mode");
>> +
>> +		init_completion(&st->completion);
>> +		ret = devm_request_threaded_irq(dev, irq,
>> +						NULL,
>> +						&ad7606_interrupt,
>> +						IRQF_TRIGGER_FALLING |
>> IRQF_ONESHOT,
>> +						chip_info->name, indio_dev);
>> +		if (ret)
>> +			return ret;
>> +	}
> Are we still calling devm_iio_triggered_buffer_setup() in case we have a backend
> device?


No, this portion of code is only executed if convst is defined 
(conversion trigger GPIO), which is not the case if there is a backend.


>
>>   	return devm_iio_device_register(dev, indio_dev);
>>   }
> ...
>
>> +#ifdef CONFIG_IIO_BACKEND
> Not a fan of this #ifef... It's not that much code so I would just select
> IIO_BACKEND for this driver. In fact, I don't think we can separately enable
> IIO_BACKEND in the menuconfig menu?


OK I can do it that way.

>> +static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev
>> *indio_dev)
>> +{
>> +		struct ad7606_state *st = iio_priv(indio_dev);
>> +		unsigned int ret, c;
>> +
>> +		st->back = devm_iio_backend_get(dev, NULL);
>> +		if (IS_ERR(st->back))
>> +			return PTR_ERR(st->back);
>> +
>> +		/* If the device is iio_backend powered the PWM is mandatory
>> */
>> +		if (!st->cnvst_pwm)
>> +			return -EINVAL;
>> +
>> +		ret = devm_iio_backend_request_buffer(dev, st->back,
>> indio_dev);
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
> I would follow typical kernel coding style and have this declared at the
> beginning of the function.


aouch, yes !


>> -
>> +#ifdef CONFIG_IIO_BACKEND
>> +	struct iio_backend *back;
>> +
>> +	/*For now, only the AD7606B is backend compatible.*/
>> +	if (chip_info->has_backend) {
>> +		back = devm_iio_backend_get(&pdev->dev, NULL);
>> +		if (IS_ERR(back))
>> +			return PTR_ERR(back);
>> +
>> +		return ad7606_probe(&pdev->dev, 0, NULL,
>> +				    chip_info,
>> +				    &ad7606_bi_bops);
>> +	}
>> +#endif
> Not sure I follow the above? You also get the backend in
> ad7606_bi_setup_iio_backend()? So it seems to be that the has_backend flag is
> not really needed?


The first call to devm_iio_backend_get checks if there is a backend 
available, and if so the backend bops (ad7606_bi_bops)are passed to the 
generic probe function.

At this stage, the backend cannot be stored in the ad7606_state 
structure because it is not initialized yet, it will be in the generic 
probe function, hence the second call.

The has_backend flag is discussed in my answer to Jonathan's comment, 
and will probably be removed.

>
> - Nuno Sá
>
>

