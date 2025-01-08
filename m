Return-Path: <linux-pwm+bounces-4554-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CEAA0628B
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80E3A4B66
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3AD1FF7C3;
	Wed,  8 Jan 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d9ABVYhL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B22594BC
	for <linux-pwm@vger.kernel.org>; Wed,  8 Jan 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354906; cv=none; b=ljTaPGrg1sq2ZRAgC5Atzoec8ZA73nvS08Q71Qr8xcK+k0VUIO+ByX3CJdTuDpzvpZ+JBE64wdQ9AZ/WGraoNeQIh3Dx8CYUMK8l/SMWw7dv6ZXy0Mn8x652ghztl1tDFzehYVifKRj/udLnQ+CP/EE0992OM8BlzajkJA1zshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354906; c=relaxed/simple;
	bh=XPKx6pwqHeZAfQbv4Dj1kdEFP8M1og0QDIj1AX/CnW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwfyG1jG4KrXMFqFTLcBCBispdJa9QAZ/okmsnb7VR0rL2kR5to48DsKyfbhXpxHWj5hjruCjU4km2hSuV55FLixAxxiKgk8rtTAFeKwU1DnlLIt8UYK8keX5f1cTNv3teaZJsYGftMr2RlCDSARzuQymUwgnEG+oBH8AWpevZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d9ABVYhL; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e2a32297dso1106a34.0
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jan 2025 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736354902; x=1736959702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9d73tRObAGN5BNE9biuTjeLMSgHxGDZ3+RKn5a9A0M=;
        b=d9ABVYhLbbQtzNXIaPeZ5HYaNPOIotU+JFg69ENsbXAh13m3JHW8XNNW+iLuku4+qd
         aYfjterm+NYT9Qt9vGw8Eri8ClaXFp8xAhgdjA4evr0evhUTDnJdlEH/rtJ/R0dfrLQ2
         euw5l0uXEU6cyTP8ht2Y/T/evdqrp65kEyw9DYw5WCQDkcGb5pIoS7Kwhv3NOfDyzIme
         yquVYKjVkKa6Zau50dmE7fzU7KWIpjr8WFdksIJIqv8ueIwcvzcr1mAbo7R7STGC5ACu
         3BvfHZDqSwZrSaIrZCTJupAI5LBEm2CA65lK/J/1t2bAatKr3CpgRTuNGjl7IGKmqcaC
         OQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354902; x=1736959702;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9d73tRObAGN5BNE9biuTjeLMSgHxGDZ3+RKn5a9A0M=;
        b=vQKnfUerJxdcnJxpcmqU4X5/uHOp0g63E9CLxtpqR5zP2c9jNfRnM7bFIdYNMBV15j
         zNKV5qV95uMtMaQQF0FHUXgV7Ij1l1Qiucy8tLd88Cs2lu2/OSm0r9o9dWtXdxSFWI7O
         jTYxA+ppI4ji3W5JKu3AHlSKI2r3NOUXHm+Fy9ZScdC9H6QQF52YfSjSunPysDkiI30R
         Q8iiZR6P4QMytRJ+tnY939+2MBsozN6dgPLlYptMWDmWo0FEzINvidAVKFwyHPaO0oGo
         2lhd/IRwfyo1lM94/eg5Je/7lDNNiwJ6Osv/g62VJOSgdReRNZObIlfk60NOTJm8MF4e
         9dBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlzAxASNyeAIJa+/825f8KX6Fug6R+JqG+ynthp5+HahIOwoXkeBNfoZLktgrn1J7syZ++8IgATbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEO+MAp9/PVhgsinoDLTh9YnEHfV2qmiQa7/eByOdxC0yIpLhZ
	zRbFq4QyjGQZuASrs7sj+Ead6VyDjCk3fH6jYzSAbXTuih2funpuit/tnGyL95c=
X-Gm-Gg: ASbGncuIy2bidzK87llaiQkSjFoOH4QTv5PoH3XDQfkngMSM9mbimwPiw0xmnakSOZr
	vKge0GvGTaqkYv6sK3lbdzrdv+HIEBD2qSvyTOhXFsYAqFypGnsSl3jU628Hc956CsUoRG0ufjn
	j8G1FVOe/9D+FbfjN+f0y0zp5lJawArjL/9OgWo9GBbvL/fJfcNh0rIqvzFnBGZtkkMFGKaz6jR
	O+QvTb2sVfvpDh3LGm1s3SHGxW4sKgKGmS+OaplfYGX6OitlT1Cb+JavfUJZGlPCJ+KHoIBgXPO
	By7XnbwVTge1JGz07Q==
X-Google-Smtp-Source: AGHT+IHQCHpXwWe2WUYcdoU/HlAsqT58kq3vmmB7qJG8C07naoC9qJvmIA8o/WlVXQK90bBqeIVaow==
X-Received: by 2002:a05:6830:1b70:b0:71d:51a4:ed48 with SMTP id 46e09a7af769-721d569f12bmr3665511a34.8.1736354901977;
        Wed, 08 Jan 2025 08:48:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc99d0b90sm11309518a34.63.2025.01.08.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:48:20 -0800 (PST)
Message-ID: <e1e38f64-4cf4-4f12-bf9d-e7520d4e5721@baylibre.com>
Date: Wed, 8 Jan 2025 10:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/8] dt-bindings: iio: adc: add ad4851
To: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
 <20241220120134.42760-7-antoniu.miclaus@analog.com>
 <20241223114008.71e00bee@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20241223114008.71e00bee@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/24 5:40 AM, Jonathan Cameron wrote:
> On Fri, 20 Dec 2024 14:01:33 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
>> Add devicetree bindings for ad485x family.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Mixed single end and differential channel devices that have per channel
> child nodes need a more complex description to avoid reg have different
> and possibly clashing meanings for the two types of channel.
> 
> See inline.
> 

...

>> +patternProperties:
>> +  "^channel(@[0-7])?$":
>> +    $ref: adc.yaml
>> +    type: object
>> +    description: Represents the channels which are connected to the ADC.
>> +
>> +    properties:
>> +      reg:
>> +        description: The channel number in single-ended mode.
> 
> And what is it in differential mode?  (usually just an index).
> Which is a problem if you have a mix.  That's why we added
> single-channel.

This chip isn't a mix-and match like many chips with muxes that use this binding
so I think it should just be diff-channels = <0 0>; similar to adi,ad7606. The
pins on the chip are labeled IN0+ and IN0- so it makes sense that both the
positive and negative inputs to be 0.

So, this should be fine with or without a single-channel property since reg
should always have the same number as diff-channels and single-channel.

> 
> So for devices where reg isn't enough, you can use:
> reg: index of channel, not real meaning just makes them unique.
> single-channel: The channel number for single ended.
> diff-channels: The channel numbers for differential channels.
> 
>> +        minimum: 0
>> +        maximum: 7
>> +
>> +      diff-channels: true
> 
> Should be constraints / information on the values possible.
> I've no idea what the 8 is in your example for instance.
> 

