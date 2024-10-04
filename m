Return-Path: <linux-pwm+bounces-3468-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF9C99072E
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10B6281010
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998041AA7A7;
	Fri,  4 Oct 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QIYX5U97"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4814A4F0
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054628; cv=none; b=loTfMnarWJuWtzyA/vUSW7vUB5ww49i2vz3IDxPkO23bwgrmPiBAWOFzuuY51I+EQuMNMnTHr/cFoqtPyjNthKB4Jborkbflixs8I1wUyHJW+VPtT0d1pWrhFjE1SJMjtV1lqrM8PcWrk7XQwfTg4q0RT3QpG2JkcCRGYo4/xDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054628; c=relaxed/simple;
	bh=DsbWuseV+5Cr5RbOfN8uYeZ29UZNhc9bAL+m0ZBhGl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLWKJfxmMw5WW0NtnZLunoRwaoPlamuDqVQY/zM4EZ23+NfOaiABAeKlOmSuh3zbRjEugKJKYHfKUK7xgvJG5KSw9//6ZKVdGqdcZ6bMPf9ab+DOJ+c0OBn7cPS/QR6S57kc/iXsuhzexrmSo+MD4UxH6FVMN/7fdDqE65tN4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QIYX5U97; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d04b32ea6so1535888f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2024 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728054623; x=1728659423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbD5QQI9fbRtagD02Hd9rPEf77aWQGn5Irx05NL1xCE=;
        b=QIYX5U97f5Zt06TQls1TmUgQ78qypZ893F6tw8UMqluR+VAGahNqsKUxSsddpkTRdF
         SiC28zKG3mXfclseL5vs/QESnJN1BIOSrFcc8Zjlvi1QMdb4mqFdzVW/pDx93WG/WdX9
         FVt/gN5AnehD2zrZQTHBN1amCSTUjP60uACwTJcVL+885iYaTomjCIecpo+38t9FOvo9
         /7jyVuphEx+xdNKUcw7BfvuCkidsXKlKozPhnKWawO3YbzSfh31Jb5bbuNnwKkGDbBQ7
         xyGVL2CVrqygXM9pqtlmb2vsuGEF+L3tDimyKStMIYIQMefbAYI80qD58k6YOCz2kMH1
         CALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054623; x=1728659423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbD5QQI9fbRtagD02Hd9rPEf77aWQGn5Irx05NL1xCE=;
        b=Ko3ORnKK2b148INRyUbocRKak5hBixHqQh3t368j8v89w5OHnY3NoHZo8e1a9e3Yco
         ylfmNiGKsyfWsEkPWfZ9gTTWiAtv7RjprWcERwT9NplsIdGqZDTbgguYIoBK3Hh9UkHD
         jSDXD/n228kOj9wVnwj7vhnV5Uvt2CLWDJ5d0kpE9R7ar2K+zbSDPPzG4q7f64AcO0j8
         oX6D3P/9pXAU4Gk85djMS1hnt00pbZujFNFYzFjGZrYc6n2qMxQUsqKz/5Ugkdn7cQ3L
         Xld8SBYIgrjL8aHzGCXgC7NsljHRYO9BKvKkpRZlGqqocalY1HFQP4fekMAS+GUwIjMt
         RD+g==
X-Forwarded-Encrypted: i=1; AJvYcCUQO7Vy5nKXMS5wIlkSB4iRxHF+E4zQ2T16K2k7SpvhoZSS4GCiIW5Iw04n4DQ7kTAwQKHG/7wSzlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGpN9yfCebKVZPM7hGJ4a2AAK4FxAuXrJUwA6gWMMYK4Xk0cS
	m6BUX1HR2mVd3jN1ehjbeGE7BFQ0e28dAlZr1CmBWdTcsDr/bubK15lu/oXxpAQ=
X-Google-Smtp-Source: AGHT+IHNkf+LyQDdbKVSXX5yZtwIGL87SsecooipYEPpbuU+08MHwf7aO/KarDzbVlgyUdnAiBWh8A==
X-Received: by 2002:adf:b181:0:b0:37c:d299:b5f0 with SMTP id ffacd0b85a97d-37d0eb20122mr1730224f8f.59.1728054623038;
        Fri, 04 Oct 2024 08:10:23 -0700 (PDT)
Received: from ?IPV6:2a02:8428:e55b:1101:d506:c29c:99b9:6f15? (2a02-8428-e55b-1101-d506-c29c-99b9-6f15.rev.sfr.net. [2a02:8428:e55b:1101:d506:c29c:99b9:6f15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0824504esm3404206f8f.54.2024.10.04.08.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 08:10:22 -0700 (PDT)
Message-ID: <0d2df826-1503-42f7-8f60-1025cc641e2c@baylibre.com>
Date: Fri, 4 Oct 2024 17:10:21 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] iio: adc: ad7606: Add compatibility to fw_nodes
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michal Marek <mmarek@suse.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, aardelean@baylibre.com, dlechner@baylibre.com,
 jstephan@baylibre.com
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
 <20240929134412.506998db@jic23-huawei>
 <57c5d8b1-295a-492f-b17c-b44caf8aeb2d@baylibre.com>
 <20241004152551.00000813@Huawei.com>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20241004152551.00000813@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/4/24 16:25, Jonathan Cameron wrote:
> On Wed, 2 Oct 2024 02:12:28 +0200
> Guillaume Stols <gstols@baylibre.com> wrote:
>
>> On 9/29/24 14:44, Jonathan Cameron wrote:
>>> On Fri, 20 Sep 2024 17:33:27 +0000
>>> Guillaume Stols <gstols@baylibre.com> wrote:
>>>   
>>>> On the parallel version, the current implementation is only compatible
>>>> with id tables and won't work with fw_nodes, this commit intends to fix
>>>> it.
>>>>
>>>> Also, chip info is moved in the .h file so to be accessible to all the
>>> chip info is not moved (I was going to say no to that) but an
>>> extern is used to make it available. So say that rather than moved here.
>>>   
>>>> driver files that can set a pointer to the corresponding chip as the
>>>> driver data.
>>>>
>>>>    
>>>> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
>>>> index c13dda444526..18c87fe9a41a 100644
>>>> --- a/drivers/iio/adc/ad7606.h
>>>> +++ b/drivers/iio/adc/ad7606.h
>>>> @@ -38,8 +38,19 @@
>>>>    	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
>>>>    		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>>>>    
>>>> +enum ad7606_supported_device_ids {
>>>> +	ID_AD7605_4,
>>>> +	ID_AD7606_8,
>>>> +	ID_AD7606_6,
>>>> +	ID_AD7606_4,
>>>> +	ID_AD7606B,
>>>> +	ID_AD7616,
>>>> +};
>>>> +
>>>>    /**
>>>>     * struct ad7606_chip_info - chip specific information
>>>> + * @name		device name
>>>> + * @id			device id
>>> ID in chip info normally indicates something bad in the design. In that somewhere
>>> we have code that is ID dependent rather than all such code / data being
>>> found directly in this structure (or callbacks found from here).
>>> Can we avoid it here?
>> Hi Jonathan,
>>
>> chip_info has to describe the chip hardwarewise, but there are different
>> bops depending on the wiring (interface used, and backend/no backend).
> Normal solution to this is multiple chip specific structures so they
> become specific to a chip + some wiring option. Then you just
> pick between static const structures.
>
> Does that work here?
>
> You will need them exposed (extern) from your header but that's
> not too bad.
>
> Aim is to pick just one structure that describes all the 'specific'
> stuff for the driver.  That brings all that stuff into one place and
> provides an easy way to extend to new combinations of options for
> other devices.
>
> Jonathan

I finally wrote a structure containing the couple chip_info/bops

/**
  * struct ad7606_bus_info - agregate ad7606_chip_info and ad7606_bus_ops
  * @chip_info        entry in the table of chips that describes this device
  * @bops        bus operations (SPI or parallel)
  */
struct ad7606_bus_info {
     const struct ad7606_chip_info    *chip_info;
     const struct ad7606_bus_ops    *bops;
};

and declared the following way

const struct ad7606_bus_info ad7606b_bus_info = {
     .chip_info = &ad7606b_info,
     .bops = &ad7606b_spi_bops,
};

const struct ad7606_bus_info ad7606c_16_bus_info = {
     .chip_info = &ad7606c_16_info,
     .bops = &ad7606b_spi_bops,

etc...

Will send the series later today, just doing some last checks.

>
>
>> The easiest way I found was to use the ID in a switch/case to
>> determinate which bops I should take (well it was only needed in the spi
>> version since it is the one supporting almost all the chips while the
>> other ones still support only one). For instance, the ad7606B will use
>> ad7606_bi_bops if it has a backend and ad7606B_spi_bops for spi version.
>>
>> If I can't use the ID, the only way I see is creating 3 fields in
>> chip_info (spi_ops, par_ops, backend_ops) and to initialize every
>> chip_info structure with its associated op(s) for the associated
>> interface. This would also lead to declare the different instances of
>> ad7606_bus_ops directly in ad7606.h  (I dont like it very much but see
>> no other option).
>>
>> Do you think it's better that way ? Or do you have any other idea ?
>>
>> Regards,
>>
>> Guillaume
>>
>>>   
>>>>     * @channels:		channel specification
>>>>     * @num_channels:	number of channels
>>>>     * @oversampling_avail	pointer to the array which stores the available
>>>> @@ -50,6 +61,8 @@
>>> ...
>>>   
>>>> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
>>>> index d651639c45eb..7bac39033955 100644
>>>> --- a/drivers/iio/adc/ad7606_par.c
>>>> +++ b/drivers/iio/adc/ad7606_par.c
>>>> @@ -11,6 +11,7 @@
>>>>    #include <linux/mod_devicetable.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/platform_device.h>
>>>> +#include <linux/property.h>
>>>>    #include <linux/types.h>
>>>>    
>>>>    #include <linux/iio/iio.h>
>>>> @@ -89,12 +90,20 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
>>>>    
>>>>    static int ad7606_par_probe(struct platform_device *pdev)
>>>>    {
>>>> -	const struct platform_device_id *id = platform_get_device_id(pdev);
>>>> +	const struct ad7606_chip_info *chip_info;
>>>> +	const struct platform_device_id *id;
>>>>    	struct resource *res;
>>>>    	void __iomem *addr;
>>>>    	resource_size_t remap_size;
>>>>    	int irq;
>>>>    
>>>> +	if (dev_fwnode(&pdev->dev)) {
>>>> +		chip_info = device_get_match_data(&pdev->dev);
>>>> +	} else {
>>>> +		id = platform_get_device_id(pdev);
>>>> +		chip_info = (const struct ad7606_chip_info *)id->driver_data;
>>>> +	}
>>>> +
>>>>    	irq = platform_get_irq(pdev, 0);
>>>>    	if (irq < 0)
>>>>    		return irq;
>>>> @@ -106,25 +115,25 @@ static int ad7606_par_probe(struct platform_device *pdev)
>>>>    	remap_size = resource_size(res);
>>>>    
>>>>    	return ad7606_probe(&pdev->dev, irq, addr,
>>>> -			    id->name, id->driver_data,
>>> Rewrap to move chip_info up a line perhaps.
>>>   
>>>> +			    chip_info,
>>>>    			    remap_size > 1 ? &ad7606_par16_bops :
>>>>    			    &ad7606_par8_bops);

