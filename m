Return-Path: <linux-pwm+bounces-4296-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1C59E9D47
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE4B18889EA
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC3155C8A;
	Mon,  9 Dec 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0eMW83n5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987911552EB
	for <linux-pwm@vger.kernel.org>; Mon,  9 Dec 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766261; cv=none; b=cw7DvLZ13lzEQlqF8qlctWvh2LM77Rb7oyAo6eWDBzrTtwpvgMC11k8mP9EKhDKYsKp5JlxkNBTZBEGU6rykepnCCF/+XyBVw//bPpPXzB1x2xHcg6ZcGyjPsrEOrl5xqkaSWbmozZC2AIvgmKCvINTf5z24poEL/nrRbaN/6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766261; c=relaxed/simple;
	bh=T8VsNOEm3fdtOz4g+8Npq3QFd9DXTd9hJ4Mx+0kU1Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxu73aU5DA0FLSNAy/w7rWBKnun63sKwB5Z9Mz0LszA+ycEcU15ZhiobPE3ZKR8azPDYJwPTVqMKg+Xp2lH1OAd3DX+3SKwxRrzJlU7cXSfp8ClZoltkx+ZGPAj0Ev8uBRlIagpX4e7YRnuOOyBegpYanjUM7vIR09XXp1YpCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0eMW83n5; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb441c2f28so339029b6e.2
        for <linux-pwm@vger.kernel.org>; Mon, 09 Dec 2024 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733766256; x=1734371056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQaHY150Yps34xQsPyk4V8n2PV48YCsChjwMePfbEZc=;
        b=0eMW83n5rJvm3Z1VPKBQr0LAAEimjThUcIhFCLXzYmgRdNvLfmjCrkiD/xkEybgWLZ
         EBI1dbbFooV6lFkfmj+F/exE60/f2wwlfSf1aiJY2DGHnZ0kNIhIvmHe9XZs66DASfYF
         67twLwgEE2pf1i9ULMP/IaQYLIrwOOfuI0/w8WoBE7cBuFwUDTlM0DF8tc4TeD2pfaZx
         Jlm3ymiPR6CtNqIa5yGHXJI6t8EefPNZsAQ5gg51kmsHcCYJmrt8V0y9NEFRQL9J39Mm
         a/k87wdGm/9Pib0+1l29XsxUwD4KybFXgVpwKDrEGdgZytWnNMNKfc2DH95hBmXP0U8D
         0AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766256; x=1734371056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQaHY150Yps34xQsPyk4V8n2PV48YCsChjwMePfbEZc=;
        b=aoU7b8rOsuZ8b5C2t4odrCOQstNronavRU6bIC2mMUH/2AzIyuz1Cmf5xepA4JgXPT
         rnbZo0U5IVdzo3QN1zvQbYcOpGZ7J24j5ulI6fO9YzgfB0gYyGHJ37HpTUFnGDCzTJKR
         kNJ6UecAJh57lc67OOtp+GLLuJ6Dy9hABNB290Q19w78ueeL2vwXoRqJoCtWa9SKjW8v
         guvW6BpULV35Ah59IuKlXywg1MCrQ5B70ajwWTmaJmhX5jqASWsswS7z9jg5YxHc8C6Z
         OVVj7rVqoFsF8Z8Itk/grmPg58SpNMZG5jklU2gMgs3Fl6inc22ebRdKgIjIWCfWO2Yg
         /Xsg==
X-Forwarded-Encrypted: i=1; AJvYcCUnxCsOqcO1L+tBjnJXjiUup08maKRSVMknAth5ds5y+N6SkX1JOaanSi5yMY2qEN3lDC9sBJlupkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHpLNGsmjy3c/8lqGjGVOBZOhh67OJNZiicPhenjQ5g8FJ3AJ
	VWU9c2AR00hNooFrgb3s9pgtEsv8YPiRMW4CTkNxZ/2V2Or/kTbXWtio3R5IJ6U=
X-Gm-Gg: ASbGncsdaS6OVyafQlOrCIe4L4PyBqYwKsjYE4mPY8DkGUzwTvUHT6xZJrGPbpVXXjg
	ODxWQKw/n3izT6fKd5NXJ66egflLLwVaTpfuP7Vz3XmN2y3/bgsQjlEuXL6Ui3f2fO1EU6Q9W0M
	WGOPObjmyc4cRpTZkyOxfGNpHO/zsRzcVNYaRCqWGL6zwdBhIjeZ7CwNF9MbYcfDELSBpFGxc95
	fGnwB5V4kiCWOObrM+RDp+1lWUfX4ZF+XWzjycYAmhEYVHbzCh7jk3NIz13BZeiYOiwIfrlnqj8
	rujFhQj6R44=
X-Google-Smtp-Source: AGHT+IFb81lytRSGzGy7brox5UjxhmObKKJPioRXNthRoTofZyWXpYB3n+qfmyKwwp6491Ja7RrpNg==
X-Received: by 2002:a05:6808:1883:b0:3ea:57cf:7c26 with SMTP id 5614622812f47-3eb66e12187mr1006950b6e.19.1733766256635;
        Mon, 09 Dec 2024 09:44:16 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3eb57b69471sm551260b6e.45.2024.12.09.09.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 09:44:16 -0800 (PST)
Message-ID: <4be8bebb-7db3-43e5-b00e-95ebf7114d80@baylibre.com>
Date: Mon, 9 Dec 2024 11:44:14 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-8-antoniu.miclaus@analog.com>
 <2d760894-bda5-4000-9598-914b830333a7@baylibre.com>
 <CY4PR03MB3399F17206B01006467B602F9B3C2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB3399F17206B01006467B602F9B3C2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/9/24 8:02 AM, Miclaus, Antoniu wrote:
> 
> 
> --
> Antoniu Miclăuş
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Thursday, December 5, 2024 2:46 AM
>> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; jic23@kernel.org;
>> robh@kernel.org; conor+dt@kernel.org; linux-iio@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> pwm@vger.kernel.org
>> Cc: Conor Dooley <conor.dooley@microchip.com>
>> Subject: Re: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
>>
>> [External]
>>
>> On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
>>> Add devicetree bindings for ad485x family.
>>>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> ---
>>> changes in v7:
>>>  - add adc channels support
>>
>> What is the reason for this change? In a previous version of this series,
>> you explained that we didn't want to specify diff-channels in the DT
>> because there was a use case to use channels as both single-ended and
>> differential at runtime. So I am surprised to see this being added now.
>>
> We had a discussion and we decided to go for the dt approach for specifying
> the channels configuration, even though in the first place we wanted to avoid this.
> Overall it makes more sense.

OK, in that case we will also want to make use of the standard "bipolar"
property from adc.yaml as well since the chip differentiates between
unipolar and bipolar inputs.

Also, might want to drop Conor's review tag and give an explanation in
the next revision since adding these channel properties is a bit of
a big change compared to the version he reviewed.

> 
>>> +patternProperties:
>>> +  "^channel(@[0-7])?$":
>>> +    $ref: adc.yaml
>>> +    type: object
>>> +    description: Represents the channels which are connected to the ADC.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: The channel number in single-ended mode.
>>> +        minimum: 0
>>> +        maximum: 7
>>> +
>>> +      diff-channels: true
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>> +    additionalProperties: false
>>> +


