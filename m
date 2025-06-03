Return-Path: <linux-pwm+bounces-6240-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8364ACC7C1
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B49C1747CA
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FECE231A51;
	Tue,  3 Jun 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fOZPGoWq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDF230D1E
	for <linux-pwm@vger.kernel.org>; Tue,  3 Jun 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957248; cv=none; b=aghgU9WoWpbxiMfwrF1Cnpri+uMk9PzdcbHpBxcGLiJeAXaSkynG14KTEq6UBDDWW3KtJISOlf0OiDb/+Tpck7OVnSg+vaUOW+IbJm6n/iehliaCfkP0qbrgCeL92BGRK8nTCmNqA7bv8x5yauOYrSVnB8wsNTzFmkyaS2stxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957248; c=relaxed/simple;
	bh=Q7lOCrXXTUcctEEqD89lwjdgZQTT45XkhavsJH1ojUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjIsIAdnPzqGbEBUWcT7ARpRTyaJ+NUGMBsJKb6THtYIS1Sktjj9Y7lfYb1UbPdH/8f85CQLHjaUQ/c7pR0vu3DUEsR7Ld9wlAW0WqAVwO1x20PakRp8E8XQMfhGIuakuQ5XbvqpFiSHxp6tqVLp/WJPaelX8hw27x0rvTzJBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fOZPGoWq; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2e3e58edab5so2142072fac.3
        for <linux-pwm@vger.kernel.org>; Tue, 03 Jun 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748957245; x=1749562045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzG5/6FfYNA5sX3NTsG/Wy+wkRCs94Vw4PYEh9eg6hA=;
        b=fOZPGoWq4qGBLqEejDpUtbN9VrCaWw7VDlC75lWIE8Sz5W39bAOAR2XMky4Z+xkdQg
         AGmS4TZJ4mq4nswv3qiRyYUqes+yRBduhrnVOos/0jNpq9beBuVqZssO7tFOOSY5K76i
         8dfxhYevl9KpEjH43umT/uHoGgCC9jBipjLH5IysXhnGYfwlu8tOrSHZ6G6mdScsZzd3
         Fk9Qhyu7TtU20kOn4z7unbavYiyUeIeJMBWZo2UiK1/sitxljbeFSKkGPJd/veDzNJPu
         8XDn/Qatlt3elwyAy5WL+c1WSp7CbYLbBl7L6M0lxSws4hsIIrnBZx05NlabdWfwhGIQ
         NIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957245; x=1749562045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzG5/6FfYNA5sX3NTsG/Wy+wkRCs94Vw4PYEh9eg6hA=;
        b=B6bYmoGpUQ4eTlZyF7gvBjIr1jPDdrAZoszBXDIYDpFgC/za08qnXAqhLkVAx9GuCQ
         tJ95Dtp8rTn20FwLkmpO+l9hqdpPRGRD/UpIHefm1iaUToHyzffjGuFYt3a1ov7bPHxr
         kQ25YKaHi5yQ2KgAs0KN6J3Gt8uve+tjuc/HxHPZGH+T6mxSmbrN0WGuZDaGi2PW4v5X
         7BcCHwIj+jfDaHBiZSEamuN+MYj8mG4rV/Ee+OTezud4uBJbSP8XzSke4UYsIUsv6a0Y
         qhf9PgrK0wNzpg7PBKpXRWEIS7TTIx0q8Zp+xZT9NZn+uS3oFReDv+BES49bhz6DNOMR
         +zxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT7xc3XR70jiJB0Fp5zCayWlseXSv0JEJq7MmQSasxEerQJi52frMJWnueZqDPZSEMFS39klAjpHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIElUjI9a4FDh3jzg6dlV4lxe3sZIT/Og+BUMnGF5g/bCWDoN
	+9dAKT6HheH7zhE3xLgHUkAXGouizAFUvdE9JZclfxnplfyh9WKRHw+IuC7L5OHl5qA=
X-Gm-Gg: ASbGncupwRbtAkoNVg+KXLaN9yliSk+b9xOMaHfxc0ehmnXJKctiqPr+cRAwCwErWuO
	xs3Z+ilpwoMssTAPxEtS1OpS47GJN6WATbmDrFZbvf4icVY4qYR3pLkyAgK6hL325m6lzYy6+sr
	+vt6zlTraHNwx3cjryR/zhJtCLEJs2+X+8L+cQMLZ4Z9OZ7mhjQjadISwd1Bw6BrdZoh2vmP/dp
	+173t/+H047fk3TKo/n7evaNDUDLmaLQQSqrrndj3x3w6LO18I3PPOhFoNBeWV568gyXE8OlRKh
	Ka1a8AlpDfQgGrHSF253dDFvRyuTZ8xQrzBhDPR5qwKyfAQSG74K2QuhBEQvW7zdglzLRPqs4j/
	jDklaGcZWrwKqOFEzEWE1UX4HTA==
X-Google-Smtp-Source: AGHT+IHR/oHIMtB0y186dpEHP2nRW08u7roI6RQa16TTsA0Xefsv43qM8XH/KFxicsxXV1pI4ADRhg==
X-Received: by 2002:a05:6870:ebc6:b0:29e:766d:e969 with SMTP id 586e51a60fabf-2e92a1623ecmr9541391fac.10.1748957245083;
        Tue, 03 Jun 2025 06:27:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:e835:af77:41c:3a1f? ([2600:8803:e7e4:1d00:e835:af77:41c:3a1f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e906b7f8f7sm2222601fac.38.2025.06.03.06.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 06:27:24 -0700 (PDT)
Message-ID: <4f09fa4e-704f-4a2b-abc3-e8f275d0e7bf@baylibre.com>
Date: Tue, 3 Jun 2025 08:27:22 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: Add adi,ad4052
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
 <88a326e7-3910-4e02-b4ba-7afe06402871@baylibre.com>
 <hvexchm2ozsto5s2o6n5j2z3odrkbcamgmg67umd4aehwzmgie@dvtx6anioasq>
 <1b0e9003-7322-46fa-b2ba-518a142616dc@baylibre.com>
 <vchomz3iazgdmotcs3jskrugi2qmdxyo74t4ruo2fsc7cjwtqb@7rtdmdkxobvg>
 <a6f62963-5776-47e4-bdac-78e921a6e476@baylibre.com>
 <a6cguahvrbqjv2wtisvgg2wvm2tj3awmn7omo6ebfpts6v546o@4xzpj353vlsx>
 <fca1e8c7-2c1c-4244-a109-f674940d6030@baylibre.com>
 <65m4itn5xp3ytc7hvpskuk4kmu54wznk4m2odt7d5a5k35vy26@ekjxegpjy5wq>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <65m4itn5xp3ytc7hvpskuk4kmu54wznk4m2odt7d5a5k35vy26@ekjxegpjy5wq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 2:29 AM, Jorge Marques wrote:
> On Mon, Jun 02, 2025 at 12:23:40PM -0500, David Lechner wrote:
>> On 6/2/25 11:32 AM, Jorge Marques wrote:
>>> Hi David,
>>>
>>> On Mon, Jun 02, 2025 at 10:17:18AM -0500, David Lechner wrote:
>>>> On 6/2/25 4:17 AM, Jorge Marques wrote:
>>>>> On Tue, Apr 29, 2025 at 10:45:20AM -0500, David Lechner wrote:
>>>>>> On 4/29/25 8:48 AM, Jorge Marques wrote:
>>>>>>> Hi David, 
>>>>>>>
>>>>>>> I didn't went through your's and Jonathan's ad4052.c review yet,
>>>>>>> but for the trigger-source-cells I need to dig deeper and make
>>>>>>> considerable changes to the driver, as well as hardware tests.
>>>>>>> My idea was to have a less customizable driver, but I get that it is
>>>>>>> more interesting to make it user-definable.
>>>>>>
>>>>>> We don't need to make the driver support all possibilities, but the devicetree
>>>>>> needs to be as complete as possible since it can't be as easily changed in the
>>>>>> future.
>>>>>>
>>>>>
>>>>> Ack.
>>>>>
>>>>> I see that the node goes in the spi controller (the parent). To use the
>>>>> same information in the driver I need to look-up the parent node, then
>>>>> the node. I don't plan to do that in the version of the driver, just an
>>>>> observation.
>>>>>
>>>>> There is something else I want to discuss on the dt-bindings actually.
>>>>> According to the schema, the spi-max-frequency is:
>>>>>
>>>>>   > Maximum SPI clocking speed of the device in Hz.
>>>>>
>>>>> The ad4052 has 2 maximum speeds: Configuration mode (lower) and ADC Mode
>>>>> (higher, depends on VIO). The solution I came up, to not require a
>>>>> custom regmap spi bus, is to have spi-max-frequency bound the
>>>>> Configuration mode speed,
>>>>
>>>> The purpose of spi-max-frequency in the devicetree is that sometimes
>>>> the wiring of a complete system makes the effective max frequency
>>>> lower than what is allowed by the datasheet. So this really needs
>>>> to be the absolute highest frequency allowed.
>>>>
>>>>> and have ADC Mode set by VIO regulator
>>>>> voltage, through spi_transfer.speed_hz. At the end of the day, both are
>>>>> bounded by the spi controller maximum speed.
>>>>
>>>> If spi_transfer.speed_hz > spi-max-frequency, then the core SPI code
>>>> uses spi-max-frequency. So I don't think this would actually work.
>>>>
>>> Ok, so that's something that may be worth some attention.
>>>
>>> At spi/spi.c#2472
>>> 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
>>> 		spi->max_speed_hz = value;
>>>
>>> At spi/spi.c#4090
>>> 	if (!xfer->speed_hz)
>>> 		xfer->speed_hz = spi->max_speed_hz;
>>>
>>> So, speed_hz is max-spi-frequency only if xfer->speed_hz is 0 and
>>> not bounded by it.
>>
>> Ah, OK, my memory was wrong. It is only bound by the controller max
>> speed, not the device max speed.
>>
>> 	if (ctlr->max_speed_hz && xfer->speed_hz > ctlr->max_speed_hz)
>> 		xfer->speed_hz = ctlr->max_speed_hz;
>>
>> It does seem odd that it would allow setting an individual xfer
>> speed higher than than the given device max speed. I suppose we
>> could submit a patch adding that check to the SPI core code and
>> see what Mark has to say.
>>
> 
> Agreed, the patch itself would be simple:
> 
>  	if (!xfer->speed_hz || xfer->speed_hz > spi->max_speed_hz)
>  		xfer->speed_hz = spi->max_speed_hz;
> 
> But I wonder how many drivers rely on this behaviour

Only one way to find out. Try it. :-)

>>>
>>> Then at spi-axi-spi-engine.c:
>>>
>>> 	static int spi_engine_precompile_message(struct spi_message *msg)
>>> 	{
>>>   		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
>>> 		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
>>> 	}
>>>
>>> Where max_hz is set only by the IP spi_clk. If at the driver I set
>>> xfer.speed_hz, it won't be bounded by max-spi-frequency.
>>>
>>> The only that seems to bound as described is the layer for flash memory
>>> at spi-mem.c@spi_mem_adjust_op_freq.
>>>
>>> For the adc driver, I will then consider your behavioral description and
>>> create a custom regmap bus to limit set the reg access speed (fixed),
>>> and keep adc mode speed set by VIO. And consider spi-max-frequency can
>>> further reduce both speeds.
>>> (or should instead be handled at the driver like spi-mem.c ?)
>>
>> It would be more work, but if it is common enough, we could generalize this
>> in the core code. For example add a spi-register-max-frequency binding (or
>> even a more general spi-max-freqency-map to map operations to max frequencies).
>> Then we could bake it into the regmap_spi code to handle this property
>> and not have to make a separate bus.
>>
>> FWIW, there are also some SPI TFT displays that use a different frequency
>> for register access compared to framebuffer data that could potentially
>> use this too. Right now, these just have a hard-coded register access
>> frequency of e.g. 10 MHz.
>>
> 
> I implemented the custom regmap bus for this series.

Good plan.

> With a `spi-max-frequency-map`, the regmap bus can be removed.
> I don't want to include this regmap spi patch to this series.
> As I see it, struct regmap_but first need to be extended to add
> a max_speed, e.g.
>   
>    @max_speed: Max transfer speed that can be used on the bus.
> 
> regmap_spi.c would then look for the devicetree node to fill the value
> and on regmap_write/read fill speed_hz.
> In this case, it could be called "register-frequency" or
> "regmap-frequency"
> If instead it is up to spi.c to read the devicetree node, then a way to
> differentiate "regular" transfers from "regmap" transfers would be
> necessary.
> 
> About submitting v3, should I submit only up-to the base driver, or can
> I submit also the add offload support and add event support commits?

I wouldn't add anything new at this point. Being able to spread out
the review a bit will lead to better reviews.


