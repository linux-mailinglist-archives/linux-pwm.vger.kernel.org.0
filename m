Return-Path: <linux-pwm+bounces-4066-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C189C4251
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 17:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5087D2883FE
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9C19995D;
	Mon, 11 Nov 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lnui4sA0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51465142E77
	for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341006; cv=none; b=nx4OcQA0Rv7VfS951RPI5NawP4FIhSp0/7v6QQS8mgyNDFa3T91Hk0U6HJzrxGx2mxLc+QbdAnQTWxDyr7h1CJw+uA2CBO4QgPvjKqISSI0w0aFLzOcvia3qjkFNnzYfXGFhTkKKWPWUDdkX1KGjv/1PljcCLLf5ohgBfiDwOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341006; c=relaxed/simple;
	bh=RMcY9dVuvJYHvQZXGJIyg3WpxmaCxUvAXlj08zgoK68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9fto45ycqE8DQMUOeVrG29HgXlQ/sGjFpWkOCqCYTj9es08zc/B0DwHNxwilqQvWX4sufeoZKhqf/vK6NAFOFpZDE+2/H2mftTEyk/3DLNlgyrmd7GZTFVLLMzlGynKej8FkEwifau5B15Xks8yhS4j9WpkZ3uqjXxwFm4BCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Lnui4sA0; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2689e7a941fso2695369fac.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731341003; x=1731945803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/N8FbaMperQCZPDQIvnd2hsxjkQB8NICoW/WVIIrTK0=;
        b=Lnui4sA0SdPqgX+jj232OiFg5LQJpy1v55VAzh9LzELrJeBO+uIRTmtzuqzaKZ3hAZ
         /DDAXyIeA0/uRBhqXe2IIboB3huMGBih5a+DQdr9sA0MouBcq34kyD0TNfqH29EobLh+
         TYp1+lLPW0+YneSm6R+FLrBeF5o5ARgkUI1fgSa056+jR4Mvsr8B1f0lk0QhCjSQXo3z
         /AtrjYULnpTtlNE+yZVRvx7MqZkxQN9ZJ2xFZG6pnOHZGWbod/rzXqqP0+8Y5VorkW48
         AvMxqN3FChnc1aBSSSPZSBzA8aDDsxs/aj2MkOUEOmto4YkeYZJ9C04J0DPWYuPt98ul
         OumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341003; x=1731945803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N8FbaMperQCZPDQIvnd2hsxjkQB8NICoW/WVIIrTK0=;
        b=K0eSfXA0pRZYZDRosBRkVjpw+t2msMJkMpf9t3MjtLrOSX5cLjlSRtRvC+s4IrTe6M
         zBfBw+APl7hM6UuUw2CfsIeDmF2yrG0nila4jkxhsvbiawLyn/PkyX0HuSsZ5vvZLtlC
         TkHOdz/BxxY5mWoIC93w+eg+b/MIYdqkttZo5HbIIG5bnzlmvGa30KZWXsIj3vF7+Zdh
         rVijEobzmSynxNkr/8WxRTDRMGLeFHuWpBQNQtgMHwxBTfII3t/AgBG9DWwLHr4FtrOI
         qyS3NpeQ5QXs8qMf2Rp/MRqSe/jVOf1xdcBB5tnObafBsfTyW0GVwV63wQH13Mx0yKhj
         rxyA==
X-Forwarded-Encrypted: i=1; AJvYcCXDK5eP4Y5pwBHjuGnQLfrFOsaAdIWX1YdX/A+Ma3x4MlQliNraSp+178DZF/BwsXakiCQ4oVS1e1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrU8KhdgQ/TiWXnBuky3fCsVODelkYl3TODgdIt3mzJZ3yEPv6
	sfvftDAb5VjtPZ9A6fbrYSsTZqO+6xTJSSHWej/vKE/bviaGTWEDaxeodFvhuyM=
X-Google-Smtp-Source: AGHT+IEeMYF9fjp84gVQ5HjlsLWjQNij4qGsNBDmcSGf6EKVQAKNreK+WhsXtiaTLQ9OQ1rpyf+sQA==
X-Received: by 2002:a05:6871:582a:b0:270:2c3:f362 with SMTP id 586e51a60fabf-2956027f6e9mr10361835fac.32.1731341003314;
        Mon, 11 Nov 2024 08:03:23 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546cf44cesm2825954fac.21.2024.11.11.08.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 08:03:21 -0800 (PST)
Message-ID: <182b9144-9a68-4e60-9a1b-4284731ab367@baylibre.com>
Date: Mon, 11 Nov 2024 10:03:21 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] iio: adc: ad4851: add ad485x driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-7-antoniu.miclaus@analog.com>
 <de120709-b60b-4e85-912e-b60ca18a8001@baylibre.com>
 <CY4PR03MB339993CDE9BA8DD3976CF2F29B5C2@CY4PR03MB3399.namprd03.prod.outlook.com>
 <1f2b8d91-19be-46b7-9202-824aa177dff6@baylibre.com>
 <146a24a7-d7a1-4969-98c0-f621a1709dd7@baylibre.com>
 <20241109153946.4f4df9d2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241109153946.4f4df9d2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/24 9:39 AM, Jonathan Cameron wrote:
> On Thu, 7 Nov 2024 10:47:52 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 11/7/24 10:13 AM, David Lechner wrote:
>>> On 11/7/24 4:51 AM, Miclaus, Antoniu wrote:  
>>
>>
>>>>> I'm pretty sure that calibscale and calibbias also need to take into
>>>>> account if resolution boost is enabled or not.  
>>>>
>>>> Can you please detail a bit on this topic? I am not sure what I should do.
>>>>  
>>>
>>> We haven't implemented oversampling yet in ad4695 yet, so I don't know
>>> exactly what we need to do either. ;-)
>>>
>>> But this is how I would test it to see if it is working correctly or
>>> not. We will need to test this with a 20-bit chip since that is the
>>> only one that will change the _scale attribute when oversampling is
>>> enabled.
>>>
>>> First, with oversampling disabled (_oversampling_ratio = 1), generate
>>> a constant voltage of 1V for the input. Read the _raw attribute. Let's
>>> call this value raw0. Read the _scale attribute, call it scale0 and
>>> the _offset attribute, call it offset0.
>>>
>>> Then we should have (raw0 + offset0) * scale0 = 1000 mV (+/- some
>>> noise).
>>>
>>> Then change the offset calibrate to 100 mV. To do this, we reverse
>>> the calculation 100 mV / scale0 = calibbias (raw units). Write the
>>> raw value to the _calibbias attribute. Then read the _raw
>>> attribute again, call it raw0_with_calibbias.
>>>
>>> This time, we should have (raw0_with_calibbias + offset0) * scale0
>>> = 1100 mV (+/- some noise).
>>>
>>> Then set _calibbias back to 0 and repeat the above by setting the
>>> _calibscale attribute to 0.90909 (this is 1 / 1.1, which should  
>>

After a bit more testing, I realized I was testing with a
differential channel, this math only applies to that.

For a single ended channel, applying a calibscale of 1.1 with
a generated signal of 1V will cause the measured value to change
from 1V to 1.1V as one might expect.


>> Now that I have written this, this has me second-guessing if I
>> implemented calibscale correctly on ad4695. It would seem more
>> logical that if we have an actual input voltage of 1 V and a
>> calibscale of 1.1, then the resulting processed value we read
>> should be 1100 mV.
>>
>> Jonathan, can you set me straight? The sysfs ABI docs aren't
>> clear on this point.
> 
> Deliberately vague in this case.  calibbias is kind of the wild west
> of ABI. Often we have no meaningful information on what the tweak
> register settings actually do beyond 'up vs down'.  In some cases
> the datasheets even refer to them as taps up or taps down.
> 
> I don't think we've ever said if it should be consistent as you
> change other parameters.  If you care about calibration you probably
> need to redo it for your new settings anyway and tweak the calibbias
> /calibscale till it gives the right values.
> 
> Obviously that is easier to do if you have a consistent scheme for
> a given device and if possible allow calibrating at just one setting
> but I don't think we can apply general rules.
> 

Thanks for the clarification.

> Jonathan
> 
>>
>>> add 10% to the measured raw value). Read, the _raw attribute again,
>>> call it raw0_with_caliscale.
>>>
>>> This time, we should have (raw0_with_caliscale + offset0) * scale0
>>> = 1100 mV (+/- some noise).
>>>
>>> Set _calibscale back to 0. Then set _oversampling_ratio to 2. Read
>>> _scale and _offset again, call these scale1 and offset1.
>>>
>>> Then repeat the steps above using scale1 and offset1 in the
>>> calculations. The raw values will be different but the resulting
>>> processed values (mV) should all be the same if the attributes
>>> are implemented correctly.
>>>   
> 


