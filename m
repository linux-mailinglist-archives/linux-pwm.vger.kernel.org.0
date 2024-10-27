Return-Path: <linux-pwm+bounces-3925-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D49B1FF1
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 20:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC23B20D10
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647FC17C230;
	Sun, 27 Oct 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nzxP9hJW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD617A924
	for <linux-pwm@vger.kernel.org>; Sun, 27 Oct 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730058743; cv=none; b=EJ9VFrSB6vcuG1HVELHhWuSk0fHB4f8Bmet8itNsD+MzJb7NDOiJBA0XlTHEoXU8TY7X0zgYCsVylFdF+HifYjadwCrft+XJ6J5F2op6LVIJN/BvhQUQXfqbOp7PMIhccqRzPHEhvKM4rFiHxHUwx+A73OXobKw4ntGb3C11lRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730058743; c=relaxed/simple;
	bh=ueiLs+nLh8dmTHigot/Hj12sD7IB5HdWNU888qp/+8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8my53V36ryU65D6/2T373YfHQTAGFmpWK7FPCK2qSGEzoNxj+ZTWTRQCkFD2aaFmPCgBCgZRJPJ4J2e2gJINdOlqDNH8oGVuZJrMAPKfLA82pKuOIh7taSfZfgvFDOsUNCIWLNINTdF6I1EeGg5iBi4Tl4iCeuWPBAl7mojcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nzxP9hJW; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-288916b7fceso1974403fac.3
        for <linux-pwm@vger.kernel.org>; Sun, 27 Oct 2024 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730058740; x=1730663540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9de6YcBQ4CAkrMC7sV/+iMopqKB6hodYcK4fGhfmxw=;
        b=nzxP9hJWDi5WtCVyPod3kCMQJH0dWdV2ypIrCpHez1mgBjgyqBA41St91MngZ2miRV
         tnRyY+Nbd6V1Tp5UzRa2UFa90JD0szKVZsJrP8ZW+4RZc0zikMNj1xHroFzHdDUvb/zZ
         LZzTHDQ3cJ5zixqcvndUIrOleSGmGApK8OyYy/0gJrJoCjxKDZGeXrEj4lm1RyqEjKa3
         UzK+wF0YQIOBNPE4j+sNfXP2DEdudP1AmupHT26gofd2Trfe/jN7NbG3Tsl+ysUJMv8P
         bhYtTt4ISLYzzKzueRLVsoj8xmMI+12a0WnmucqF3+yuCb4z45hlXE1gg9hrp7z++0+v
         uRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730058740; x=1730663540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9de6YcBQ4CAkrMC7sV/+iMopqKB6hodYcK4fGhfmxw=;
        b=sERSecaTucrMknXdA/+HKXwc8Psaoy0mwzoZEKERg8Ok7ZlDBRMCPYfMnfv84+S1Kw
         CND8XF1PuGxIaGlUZlQRVner9BOMp7vOdyjfDKm5VMzdoHxEDrgCS8+s2Y8iI3xPohPO
         4cpVocY/ddsNDkRRlWArMs1Ffqrd7pOtCK9zzQRC2WcqQEHK0epRbZpvP+MDKk5A67qm
         9QSwWph8gerhUtw8JJf0Ta7rwxPTgNGTMGhgmWlH0xwCUyLIT63huajtylPwREEHqHLb
         +WmeRspny/rMgTA96S0dJSgMEP9skFxRxPJ8mSvLh5D1Zi9ajl3V8RmoYtnn8duvKu+7
         hW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbndfF0PY0z6344we9uLBn+mxDTVzRAOteJUSUJQik+h9OGA1jTbIVrnlLS87sFa5H+vJTIQYJTu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33EExIQg2uvLcEfUv9/ycblEh4Gx4l+vJk/eKwffBGVl+a1bm
	sHMzoDWFGF7kFJZ0tk9CCdNIM3avZoiOcnFF2b21wwzkcci4gLpnalzbPTqUqPA=
X-Google-Smtp-Source: AGHT+IFepVB2QqdqP+C+Q8M8uASn8/LF4xicUTp5DH6V9fqU0SsmPYBPQioFgC1LGcXGMjTtSzGTeg==
X-Received: by 2002:a05:6870:15d5:b0:278:978:9e9 with SMTP id 586e51a60fabf-29051e0360bmr4809398fac.44.1730058740066;
        Sun, 27 Oct 2024 12:52:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-290380f4bdasm1563675fac.46.2024.10.27.12.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 12:52:18 -0700 (PDT)
Message-ID: <2679570d-6255-467b-8312-117e553a52b4@baylibre.com>
Date: Sun, 27 Oct 2024 14:52:17 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI
 offload
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
 <20241026170038.4b629cff@jic23-huawei>
 <5a090847-ee53-41be-ad28-b7604cf9020a@baylibre.com>
 <20241027091244.2fe3c0ad@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241027091244.2fe3c0ad@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/24 4:12 AM, Jonathan Cameron wrote:
> On Sat, 26 Oct 2024 19:01:53 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 10/26/24 11:00 AM, Jonathan Cameron wrote:
>>> On Wed, 23 Oct 2024 15:59:22 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   

...

>>>   
>>>>  static int ad4695_probe(struct spi_device *spi)
>>>>  {
>>>>  	struct device *dev = &spi->dev;
>>>>  	struct ad4695_state *st;
>>>>  	struct iio_dev *indio_dev;
>>>> -	struct gpio_desc *cnv_gpio;
>>>>  	bool use_internal_ldo_supply;
>>>>  	bool use_internal_ref_buffer;
>>>>  	int ret;
>>>>  
>>>> -	cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
>>>> -	if (IS_ERR(cnv_gpio))
>>>> -		return dev_err_probe(dev, PTR_ERR(cnv_gpio),
>>>> -				     "Failed to get CNV GPIO\n");
>>>> -
>>>> -	/* Driver currently requires CNV pin to be connected to SPI CS */
>>>> -	if (cnv_gpio)
>>>> -		return dev_err_probe(dev, -ENODEV,
>>>> -				     "CNV GPIO is not supported\n");
>>>> -
>>>>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>>>>  	if (!indio_dev)
>>>>  		return -ENOMEM;
>>>> @@ -1002,8 +1374,13 @@ static int ad4695_probe(struct spi_device *spi)
>>>>  		return -EINVAL;
>>>>  
>>>>  	/* Registers cannot be read at the max allowable speed */
>>>> +	st->spi_max_speed_hz = spi->max_speed_hz;
>>>>  	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
>>>>  
>>>> +	ret = devm_add_action_or_reset(dev, ad4695_restore_spi_max_speed_hz, st);  
>>>
>>> Why do you need to put it back in devm? What happens after this but without
>>> a driver restart that uses that faster rate?
>>>   
>> I should have added a comment here as this was a weird bug to trace.
>>
>> The core SPI framework sets the initial value of spi->max_speed_hz
>> to the minimum of the controller max rate and the max rate specified
>> by the devicetree.
>>
>> The SPI device lives beyond this driver, so if we bind the driver
>> and set spi->max_speed_hz to something other than what the SPI core
>> set it, then the next time we bind the driver, we don't get the
>> the max rate from the SPI core, but rather we changed it to when
>> the driver unbound.
>>
>> So on the second bind, the max rate would be the slow register
>> read rate instead of the actual max allowable rate.
>>
>> So we need to reset spi->max_speed_hz to what it was originally
>> on driver unbind so that everything works as expected on the
>> next bind.
>>
>> (Or we call this a SPI core bug and fix it there instead).
> Definitely a question to ask.  Directly accessing spi_max_speed_hz may
> be the fundamental issue as I don't think the driver is generally
> expected to touch that in a dynamic fashion.  Should we be instead setting it
> per transfer for the ones that need it controlled?
> 
> Jonathan
> 

The problem is that we are using regmap and that doesn't have
a way to specify the max frequency for register reads that is
different from other uses of the SPI bus (i.e. reading sample
data). So we could fix it in the generic SPI regmap (not exactly
trivial) or we could write our own regmap read/write callbacks
in this driver that properly sets the per-transfer max speed.


