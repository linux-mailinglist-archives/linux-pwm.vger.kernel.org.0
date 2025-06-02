Return-Path: <linux-pwm+bounces-6229-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E7AACBA2B
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 19:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD51176D6B
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629D226D0E;
	Mon,  2 Jun 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OvwwslSn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAB226861
	for <linux-pwm@vger.kernel.org>; Mon,  2 Jun 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885025; cv=none; b=g7QDXCXaW1mSi7kCTcKEqjUhM6Qy0isF97fgp3O3D6qXXA+0XF7D/fCQWcIyKBeIMj/56c8dmTwLZ4x/lfcTJlHm/iBhZDU0u+EHjtVeOqApGy22e1SLb2UgLh8PdKeoDRnxtJA8nAiHbNTW/HhR4DHiNU6QpxqQuVPnmw4Cbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885025; c=relaxed/simple;
	bh=r0Srhe/ZFSlTd2d/RdFpJIbbLWqeYqSSyXCuK8RILNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvxwyvVAMOEfRrBljr18FugChLOGyawFcKitemtGU88NsLYS/5xS4zqwzVB7W/FZ4ZxKspcXykCirumnHYMDgyFjtyjsAZrD1p3hs3VbBp564v6OX7beDK4IvXZo85bnh5deRy42Oj/35D7EfjHue3VFfb1mOxtqPu9rjl0ec1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OvwwslSn; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-407a3c10d03so1721829b6e.2
        for <linux-pwm@vger.kernel.org>; Mon, 02 Jun 2025 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748885023; x=1749489823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzFNRbVnIR8z38r4bV92OVe26qdtExOhHTzdvqaLzx4=;
        b=OvwwslSnr3J7Lu7JN8KIS+UGohilB0jebW/fZ4RiB+EAnFdRMtQUZQk8PUcCvktr90
         wDkLdX0ryDTlwHnpLQ4VJue5pVJxmiKR+2f6jamo3OyoMBJjWK0BeaHMQKKmcG81GNAg
         HC2+0xYOQFQaMReRW21j8RnO3+FUOLHSQhmn0zdiLLueyuTRIR2UmENkjhwXjJR3kKUv
         6en/qa9BKG6+9JWn+btdzTXPBkYPp/NwR2CZWNLC6723Unp/Xh8QcIhktAdCtEQUVAWm
         nKX9PVnVvRMjgPjr4EN5WgC88F6tgmyI0bu7GZtHp8TyG4Oj7ZJ6ka+tTQLZGSKrTmtv
         spTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748885023; x=1749489823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzFNRbVnIR8z38r4bV92OVe26qdtExOhHTzdvqaLzx4=;
        b=PQxkbezm4iG6KnR4cv+L549mkGsuHEQKYz7GpdD8SPmiG4ZakH5M9rvIZnORHKLz7Q
         PxH9JHnMBTGwwDJ82FjZupPQG01OonbF1Z87kgvN+wgx507Tvk768eqvtFrmUd2Lay+7
         JTE/QyHuXmNrwSs79fz7mYe5ITktIwp/8TydBengMsaOSsTv9KzMuqfPn8gEDopxYBVL
         ed6lfxeKzvWmBK411Whyt25FajG33u0LTihdMjemgOCghfE9Wo+r+oUc6LVlEMEjfmg6
         RTAzMrx0TLE4ZNUHZACiUrF34fShETgU5ZfT9+m5mNM3OgIAxb7ceIE5B32wh5n5ca+c
         JAyA==
X-Forwarded-Encrypted: i=1; AJvYcCWDLwPY7DRiFl3XuioMaXkRLw0HT+FP5GeGYPLCXziNnzs4MuWQFoJK3sqq3drp8GqBPWPDmposRhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNE9seyVdsKbDQ4vQA2tOqXOnj2WCEp5HQG0fhbM1axSeRm2rD
	v19W01uqOrDiXgaH6EbF7qXsmliyQYNLgNEH0/mM8jqsGHkY/L+qK7zsFUgxjcCwCx8=
X-Gm-Gg: ASbGncsVbtLIFZOw+CatmvxaU08xzydnevcUzOD2s7b7lJVnyTDRTTRw9PCOpuPBZ8i
	F2iUWhNw4oxPk3ziQeqN1i0DMvaJKwPeAt+qHtKuYUS/aCuQtOQWtSifMVLL3E4amng+i6cjxgS
	BsKLjXkkLXO9vo33YXDB44uUGZUIHWgbBpLYcQyBwyEePYtXJt2pd5ZHJVW61raTSffFz7zKXe0
	UP6owK4KGXY8mIlU5T0/Zs8qNeWCBZ2eV3uI4B+qZWSd9Y5Fn3p0Jb7r1JX8kd92VlyTiRrq6T0
	dVY6Rrn20HhREZn3U97f+eBA1P07kTZFjpOhsmxu+JgE/KMk14UcA0bspu/mZfhQmGSJNOnp4U0
	l8MyyRT4kp5sGCc/tGX4dfqjnfrMV/KgZTeo64TY=
X-Google-Smtp-Source: AGHT+IF/xPy2n8rJ6168kLQsxv7ffSrx4BuuXj2i7ygSF4TQfB25Gz7EO+g2oYAOQ65OBubji4r0aw==
X-Received: by 2002:a05:6808:3307:b0:406:755a:9352 with SMTP id 5614622812f47-407a665402dmr5823437b6e.38.1748885022856;
        Mon, 02 Jun 2025 10:23:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf? ([2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40678ce8480sm1507195b6e.36.2025.06.02.10.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:23:42 -0700 (PDT)
Message-ID: <fca1e8c7-2c1c-4244-a109-f674940d6030@baylibre.com>
Date: Mon, 2 Jun 2025 12:23:40 -0500
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a6cguahvrbqjv2wtisvgg2wvm2tj3awmn7omo6ebfpts6v546o@4xzpj353vlsx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 11:32 AM, Jorge Marques wrote:
> Hi David,
> 
> On Mon, Jun 02, 2025 at 10:17:18AM -0500, David Lechner wrote:
>> On 6/2/25 4:17 AM, Jorge Marques wrote:
>>> On Tue, Apr 29, 2025 at 10:45:20AM -0500, David Lechner wrote:
>>>> On 4/29/25 8:48 AM, Jorge Marques wrote:
>>>>> Hi David, 
>>>>>
>>>>> I didn't went through your's and Jonathan's ad4052.c review yet,
>>>>> but for the trigger-source-cells I need to dig deeper and make
>>>>> considerable changes to the driver, as well as hardware tests.
>>>>> My idea was to have a less customizable driver, but I get that it is
>>>>> more interesting to make it user-definable.
>>>>
>>>> We don't need to make the driver support all possibilities, but the devicetree
>>>> needs to be as complete as possible since it can't be as easily changed in the
>>>> future.
>>>>
>>>
>>> Ack.
>>>
>>> I see that the node goes in the spi controller (the parent). To use the
>>> same information in the driver I need to look-up the parent node, then
>>> the node. I don't plan to do that in the version of the driver, just an
>>> observation.
>>>
>>> There is something else I want to discuss on the dt-bindings actually.
>>> According to the schema, the spi-max-frequency is:
>>>
>>>   > Maximum SPI clocking speed of the device in Hz.
>>>
>>> The ad4052 has 2 maximum speeds: Configuration mode (lower) and ADC Mode
>>> (higher, depends on VIO). The solution I came up, to not require a
>>> custom regmap spi bus, is to have spi-max-frequency bound the
>>> Configuration mode speed,
>>
>> The purpose of spi-max-frequency in the devicetree is that sometimes
>> the wiring of a complete system makes the effective max frequency
>> lower than what is allowed by the datasheet. So this really needs
>> to be the absolute highest frequency allowed.
>>
>>> and have ADC Mode set by VIO regulator
>>> voltage, through spi_transfer.speed_hz. At the end of the day, both are
>>> bounded by the spi controller maximum speed.
>>
>> If spi_transfer.speed_hz > spi-max-frequency, then the core SPI code
>> uses spi-max-frequency. So I don't think this would actually work.
>>
> Ok, so that's something that may be worth some attention.
> 
> At spi/spi.c#2472
> 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> 		spi->max_speed_hz = value;
> 
> At spi/spi.c#4090
> 	if (!xfer->speed_hz)
> 		xfer->speed_hz = spi->max_speed_hz;
> 
> So, speed_hz is max-spi-frequency only if xfer->speed_hz is 0 and
> not bounded by it.

Ah, OK, my memory was wrong. It is only bound by the controller max
speed, not the device max speed.

	if (ctlr->max_speed_hz && xfer->speed_hz > ctlr->max_speed_hz)
		xfer->speed_hz = ctlr->max_speed_hz;

It does seem odd that it would allow setting an individual xfer
speed higher than than the given device max speed. I suppose we
could submit a patch adding that check to the SPI core code and
see what Mark has to say.

> 
> Then at spi-axi-spi-engine.c:
> 
> 	static int spi_engine_precompile_message(struct spi_message *msg)
> 	{
>   		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
> 		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
> 	}
> 
> Where max_hz is set only by the IP spi_clk. If at the driver I set
> xfer.speed_hz, it won't be bounded by max-spi-frequency.
> 
> The only that seems to bound as described is the layer for flash memory
> at spi-mem.c@spi_mem_adjust_op_freq.
> 
> For the adc driver, I will then consider your behavioral description and
> create a custom regmap bus to limit set the reg access speed (fixed),
> and keep adc mode speed set by VIO. And consider spi-max-frequency can
> further reduce both speeds.
> (or should instead be handled at the driver like spi-mem.c ?)

It would be more work, but if it is common enough, we could generalize this
in the core code. For example add a spi-register-max-frequency binding (or
even a more general spi-max-freqency-map to map operations to max frequencies).
Then we could bake it into the regmap_spi code to handle this property
and not have to make a separate bus.

FWIW, there are also some SPI TFT displays that use a different frequency
for register access compared to framebuffer data that could potentially
use this too. Right now, these just have a hard-coded register access
frequency of e.g. 10 MHz.

> 
> Thanks for the quick reply!
> Jorge


