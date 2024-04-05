Return-Path: <linux-pwm+bounces-1866-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE475899F6A
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3AD1F268DE
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0016EC11;
	Fri,  5 Apr 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="snkmYQmH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F616F287
	for <linux-pwm@vger.kernel.org>; Fri,  5 Apr 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326767; cv=none; b=j7aHvMHl8iy/9h0BArrr6xFIhwnX+K+FSs5Cz2aykalcmMfUH9arknutKHIv/OXupOCChf0zR38ZYAuX4/0/65QpLhX4Lmh3rTTaX3PyhjsA+Ks2GyTIjWVXJJyHBxSiMe0hKjjvc7cuYl9HP5/Z0mGQWRG8SgxGL0bLWbJmDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326767; c=relaxed/simple;
	bh=GtC0XbiBrZa/B4r/7Htvb9UrPAe6iDI2Za/Fy3NSIfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNUhxnJRtVc/QlhHt7iOh/4qmbVbmBV7mSZpVuNUdRZ28NX9pwsff8kZ5TICsXM5dHS1eGOS2GA8POHAmAnOlBanv5MpraKv2dfXTVhl0i7ALmycV2ADMednUa9kmCnJOYfe79CrjgggyXDLIwBiMa4ivRJqgjq+ZFzp6MXnloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=snkmYQmH; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a46abf093cso1268859eaf.2
        for <linux-pwm@vger.kernel.org>; Fri, 05 Apr 2024 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712326762; x=1712931562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrV/f7nikTYr7uJsU2LLbggB6FZ9wB2rmWaAwVpSG+w=;
        b=snkmYQmHlP9LKSI3UKIBUxkP1ctk6icZsRLL1yXCm9vtOxyimv2XKnp7U5Aq1JZU2f
         vTdPrfstVnTsWU/iRpV07svAq8XI9wUjpxJUbM5BaxwJaZeObM3UCzCOew7NPfjboMra
         Uy20WA1ERpKvY3RozbHLm0sLu/sES2PIdBK1RKNwkThcuCLP+aFdF+ZLIyIfN+YM7+le
         goGNfOQI4Dhkw0B4hArPgrxnKUHo/3rmxZ33P5V1qJEHMOYRBa7UHgXcw1WMPYUUdojo
         TbBMXiwwW1P0jopampKsky8anNGSvFagmRBC7wWdp4t67H8EEQBu7/GN4ZuF3SqSN+Ws
         pm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326762; x=1712931562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrV/f7nikTYr7uJsU2LLbggB6FZ9wB2rmWaAwVpSG+w=;
        b=vJWTbPQVQiaHYJHizIjU7suyZDTVdInTQe13WKfPL/1aiIWDgho87ILL5c0zwDe/U/
         PRtie10axXLPEpJXAh7DNo1hZblscJpaY5Gx4a1MYNi5lpHjUDbI/2EjppN1cWvOVxAb
         n9G99jFmT6iPPfxCb+lsQk6RPNeNOfM5qwud4FfxVmsjmjLyKkwM05/4IEg3X4DpMSy1
         ZTdLPoe1a4Rg7MwQiGHWVcCeCkl1emLe+KeyJLF+LGIM3Pn5RoiW7FS+Mbx6dQ/WutX0
         i2WNvG/9y0fix614WwWK7eyK3HDPBQchHPTgbzgplJlz9qnkwG71enLOui5HzNjLPvOd
         O14Q==
X-Gm-Message-State: AOJu0YwTStDX3ul6W8CurrO/k2YFXDD36Lsy6t0kuTHf4edho7GB9eFI
	SnLTNauiVCXLR5aFa97acSfKH+qy7S8+WguZemDL+B2/cUbCmJ+UPyJkruPapRk=
X-Google-Smtp-Source: AGHT+IEfOsARdaOTsm95hHsI4nHAz7smazObv2UyX6oVfv9HmVQkQR/tziju0Iumk/YkSUZaQZNhqw==
X-Received: by 2002:a05:6870:558f:b0:229:e689:7c1b with SMTP id qj15-20020a056870558f00b00229e6897c1bmr1920573oac.7.1712326762528;
        Fri, 05 Apr 2024 07:19:22 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id dy6-20020a05620a60c600b0078d43da0be3sm666257qkb.5.2024.04.05.07.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:19:22 -0700 (PDT)
Message-ID: <9b2bab7a-24a7-49da-8cb8-f58e28baf065@baylibre.com>
Date: Fri, 5 Apr 2024 10:19:20 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] pwm: add support for duty_offset
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
References: <20240405003025.739603-1-tgamblin@baylibre.com>
 <fhrderkiwqzc7fw2hptz2la3aco72wlossqbrr4m42qllcpcpw@vhxflah2ex2a>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <fhrderkiwqzc7fw2hptz2la3aco72wlossqbrr4m42qllcpcpw@vhxflah2ex2a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-04-05 08:23, Uwe Kleine-König wrote:
> Hello Trevor,
>
> In general I really like your effort to generalize the pwm framework.
> Thanks a lot!
Thanks! I'm glad that it (mostly) fits.
>
> On Thu, Apr 04, 2024 at 08:30:22PM -0400, Trevor Gamblin wrote:
>> This series extends the PWM subsystem to support the duty_offset feature
>> found on some PWM devices. It includes a patch to enable this feature
>> for the axi-pwmgen driver, which can also serve as an example of how to
>> implement it for other devices. It also contains a patch adding a new
>> pwm_config_full() function mirroring the behavior of pwm_config() but
> Please don't. pwm_config() is a function I want to get rid of in the
> long term. Consumers that want to make use of it should use
> pwm_apply_*().
Okay, I'll drop this patch.
>
>> with duty_offset included, to help maintain compatibility for drivers
>> that don't support the feature.
>>
>> The series was tested on actual hardware using a Zedboard. An
>> oscilloscope was used to validate that the generated PWM signals matched
>> the requested ones. The libpwm [1] tool was also used for testing the
>> char device functionality.
>>
>> The series is marked RFC as there are some outstanding questions about
>> implementation:
>>
>> 1. In drivers/pwm/core.c, __pwm_apply() was modified to check that the
>> sum of state->duty_offset + state->duty_cycle does not exceed
>> state->period, but in the character device section these values are
>> being checked separately. Is this intentional? What is the intended
>> behavior?
> state->duty_offset + state->duty_cycle doesn't necessarily need to be
> less or equal to state->period. Consider this waveform, where ^ marks
> the start of a period.
>
>
>          ___       _________       __...
>             \_____/         \_____/
>          ^               ^
>
> This one has duty_offset = 9 and duty_cycle = 10 while
> period = 16 < 10 + 9.
Alright, I'll make a change here.
>
>> 2. Should __pwm_apply() explicitly disallow PWM_POLARITY_INVERSED and
>> duty_offset together?
> While there is no technical need for that, a configuration with both
> PWM_POLARITY_INVERSED and duty_offset > 0 is irritating. So I'd say yes,
> it should be disallowed. When I created the cdev API I even considered
> dropping .polarity for lowlevel drivers and convert them all to
> .duty_offset.
Will do.
>
> Having said that I don't like the addition of .supports_offset to
> struct pwm_chip, which only signals a new incomplete evolution of the
> pwm framework. Better adapt all drivers and then assume all of them
> support it.
Can you clarify what you mean here - is the intent to put basic handling 
of duty_offset (even if that means simply setting it to 0) in each driver?
>
>> 3. Are there other places that would need duty_offset handling which
>> have been missed?
> I'm happy you adapted the tracing stuff. I didn't look closely, but I
> don't think something important was missed.
>
>> Note that in addition to the other patches in this series, the changes
>> to the axi-pwmgen driver rely on [2] and [3], which haven't been picked
>> up yet.
> Best regards
> Uwe
>

