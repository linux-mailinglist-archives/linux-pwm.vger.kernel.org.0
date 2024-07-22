Return-Path: <linux-pwm+bounces-2886-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F3938813
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 06:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D805C2812C3
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 04:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1F15E86;
	Mon, 22 Jul 2024 04:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqysGY1I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDF134B2;
	Mon, 22 Jul 2024 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721622479; cv=none; b=fGHRiHlzIx8mLH4Sc6mKkRA584huRwGy48Y6HS6atB9pkiAz1PXzoG0oXZEMBvXyJJ4mpKr4FRym0aWl/Auvi97WxOsPLFgyHvV65L3E7oeLawG3Lk0hYKG7txIg/e/setE08gjT8xWxPX4cRBHO5z4jg2sFZgDswhXLymLwlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721622479; c=relaxed/simple;
	bh=K8JWcAkS4a4liaNBpSRVd5qQrnIj7BxckMCwh1u91hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvW/vxdviC4/oc4dD2+uuiXh5P1ieFQCmfiOHCN+xknBxlSA7NUu7uy7D5434Ihg7M4gwKdUn2AbtnZRp6UzSPaLoJ92kE/yC/RonCWclBCqJkKGYHTU1QK31xX+43uEwoKO57Tjbi8HCMSTPJEgLoZyttVEkWWH/paZkqdp/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqysGY1I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc569440e1so31226155ad.3;
        Sun, 21 Jul 2024 21:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721622477; x=1722227277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o8ZTrvUyb7a00X6v0/4Q9nPa7JlF0Pt0DDiwaLxc7V0=;
        b=nqysGY1I3J089wXrZ2AcSqJDlTJLszRNSpczT8Sk6bsBQwX6szlSB/FLtXxUJFOi/O
         rGprnneL9KKc3YRSi06qVnUXwbEBPp+nrUkqiFkoVGF91ctF4qh6fHN2hYY5mFTz3mPu
         JKgklzi0PXDs0gmtuOym6LZ1swNb5tYtPw6Gh0KBtHyTGQ10RQHO9MSC9EpYzBIxzC6G
         Vio/HbT8ul5gFVqOJ9oHpfmQvvXGKVbDVghUkSDMcN2uwZOR1dMFBUxiWZwAD/b+BN7Z
         IqMKI0GQ8A8p4B53SuUg9N3L3/5E5120KkOcGoIi+NaCxanNCQbGjHJBVYOqCQBEwBdl
         TL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721622477; x=1722227277;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8ZTrvUyb7a00X6v0/4Q9nPa7JlF0Pt0DDiwaLxc7V0=;
        b=VGyHi9v+ShSrk5XmyH52JnJ7mw+/BWqCi6TNTFFthAFaG51IbWSoIdjOxUi9Z9Q/ae
         sI1tvhk6aCfkPIhhXZT48ByQeJgOhv0PmTQBskQZlWiV4v0NCUMkcRuOaW1vx2Z/zQxw
         M/LfOIhoDzhFMfjFymlkOsY81dthKWgSqsiFKalP8cqnqwDCjvqURfozwQm5psV2iKHT
         nDLlSV5yYTMIA6MgbSZ4OZbHKsvBaebq2FMgvUERW750DN71w4Ob7MHnyMYo2L9wlu7/
         Ev5BgfvrFf4fw7GMir27tMueo9sRYHRXDgYpcs/IBj6fP+FgsDB29VAzLlLsRvXqeOij
         xHeA==
X-Forwarded-Encrypted: i=1; AJvYcCUG8aObHx7mbkpzCggL07j0Gajzhe8vDZrDruKhqCxtRlnbp4ZOdgi3///meTus7EX9hzGjohlgmHhGNq5XJaBH1UPiZvxbMzxLvJb2NI7JH1tXDcWr6SPmPj5rvcPoWqASNMIauv6Lho1UAUKjGwfmNvbHzyC4oDaDofG1rAIbcfjpKw==
X-Gm-Message-State: AOJu0YwiGS2Q78+9b6231NwNOLNm3BTSwDi66IJDfqTt83ZQf+BGW8Kh
	m6IQuMDydYzXOdPHze1aeg58bUlgX+z9mq20MjmT/XWXqJVAtvZe
X-Google-Smtp-Source: AGHT+IFFAOebhIiytgdnqRaEc/t69UnHbGRcN2PED+JI2D/d663/6m7itP5I9AIglNcqreMqnHVGqw==
X-Received: by 2002:a17:902:fb4d:b0:1fc:6c23:8a3b with SMTP id d9443c01a7336-1fd74561d13mr57572865ad.17.1721622476663;
        Sun, 21 Jul 2024 21:27:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f433e87sm44390545ad.195.2024.07.21.21.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 21:27:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ed179848-2c8c-41ef-acca-a53d958a30b6@roeck-us.net>
Date: Sun, 21 Jul 2024 21:27:53 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
 <20240722005825.1800403-4-chris.packham@alliedtelesis.co.nz>
 <15f4c51c-3f7d-4e93-9c3a-71ac1d626463@roeck-us.net>
 <c261c74f-6829-4888-9836-6f27ba87dc25@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c261c74f-6829-4888-9836-6f27ba87dc25@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/24 21:09, Chris Packham wrote:
> 
> On 22/07/24 15:53, Guenter Roeck wrote:
>> On 7/21/24 17:58, Chris Packham wrote:
>>> By default the PWM duty cycle in hardware is 100%. On some systems this
>>> can cause unwanted fan noise. Add the ability to specify the fan
>>> connections and initial state of the PWMs via device properties.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>      Changes in v6:
>>>      - Use do_div() instead of plain /
>>>      - Use a helper function to avoid repetition between the of and non-of
>>>        code paths.
>>>      Changes in v5:
>>>      - Deal with PWM frequency and duty cycle being specified in nanoseconds
>>>      Changes in v4:
>>>      - Support DT and ACPI fwnodes
>>>      - Put PWM into manual mode
>>>      Changes in v3:
>>>      - Use the pwm provider/consumer bindings
>>>      Changes in v2:
>>>      - Use correct device property string for frequency
>>>      - Allow -EINVAL and only warn on error
>>>      - Use a frequency of 0 to indicate that the hardware should be left as-is
>>>
>>>   drivers/hwmon/adt7475.c | 130 ++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 130 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
>>> index 4224ffb30483..fc5605d34f36 100644
>>> --- a/drivers/hwmon/adt7475.c
>>> +++ b/drivers/hwmon/adt7475.c
>>> @@ -21,6 +21,8 @@
>>>   #include <linux/of.h>
>>>   #include <linux/util_macros.h>
>>>   +#include <dt-bindings/pwm/pwm.h>
>>> +
>>>   /* Indexes for the sysfs hooks */
>>>     #define INPUT        0
>>> @@ -1662,6 +1664,130 @@ static int adt7475_set_pwm_polarity(struct i2c_client *client)
>>>       return 0;
>>>   }
>>>   +struct adt7475_pwm_config {
>>> +    int index;
>>> +    int freq;
>>> +    int flags;
>>> +    int duty;
>>> +};
>>> +
>>> +static int _adt7475_pwm_properties_parse_args(u32 args[4], struct adt7475_pwm_config *cfg)
>>> +{
>>> +    unsigned long freq_hz;
>>> +    unsigned long duty;
>>> +
>>> +    if (args[1] == 0)
>>> +        return -EINVAL;
>>> +
>>> +    freq_hz = 1000000000UL;
>>> +    do_div(freq_hz, args[1]);
>>> +    duty = 255 * args[3];
>>> +    do_div(duty, args[1]);
>>> +
>>
>> Gues I am a bit at loss here, just as 0-day. Why use do_div ? It is only needed
>> for 64-bit divide operations.
> 
> Mainly because of Uwe's comment on v5. I think I've avoided the original u64 issue now that I'm converting fwnode_reference_args::args to a u32 array. I can probably get away with plain division, although 255 * args[3] / args[1] might overflow in theory but shouldn't in practice.
> 
> I'll let the earth turn and send out a v7 that uses plain division unless someone has a strong opinion that I should sprinkle some more u64s around.
> 

You lost me, sorry. Neither duty nor freq_hz are u64. What u64 variables
are you talking about ? Using so_div doesn't make those variables u64.

Guenter

>>
>> Thanks,
>> Guenter
>>


