Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19761F1AD4
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgFHOTR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 10:19:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49324 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729553AbgFHOTQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 10:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591625955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmWs5xiKNyhpgW0opzKEta80LNVnO/dXhPhvbslqD2U=;
        b=DFvv4EiLGkDAvLcP3rU/GZTMDGZXLvb9vU1SjzggxRCKDS5bDsrpBHFfAuwaxV1hQQZZB2
        D1L/2sKeVvoc8PSZdVQ9BSbE1zbbNvttSm0BcvrHlYw7lMnouWXr2pzxwUChGwR7JUJPh9
        a+dcHtvuNsCjjLoSyT8Lr5XBHx6UeZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-FbB9q2NXOEycnpcBejkyLg-1; Mon, 08 Jun 2020 10:19:13 -0400
X-MC-Unique: FbB9q2NXOEycnpcBejkyLg-1
Received: by mail-wr1-f70.google.com with SMTP id r5so7241834wrt.9
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jun 2020 07:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gmWs5xiKNyhpgW0opzKEta80LNVnO/dXhPhvbslqD2U=;
        b=lIQ7ly9JZhMcNDY9437+uIQb+tASKandWQSXH08B7IQF1O+ovuCS+M2DI6yVonMgAX
         ONQ8mGRDjCIn6MKnLe67DAywwUjvKx5P7dZuHZCNDkgHrFSt7aeCi5FYrk15cco1nr8l
         684yJybg5VhrQ1Ix4+/je8uLwuJREhgfA0oZG+ZBXCFR+JpJHjKSgwbv3t62v7lC73xa
         PMgdk+dcrcaMO7TAvBrz5CWihrCkcCNS4KNVPBCcyiLePtBTzgKefPjMYhJky1b7Hts4
         vGgGgZRncD5zwMX4jRxdHyXR/EAhPcTKVCejdRjX3VrfY+Z1Ag++/2+0aQ04tC+QFOFd
         3ItQ==
X-Gm-Message-State: AOAM5327Vz2HyFGan13029WvQKkAmVScCOrSeRiABeZMeke32Nnl3p2C
        D1dX4rafw+GXNQmrivvmaqqoe9xP4jedqbWztcEHj56h3usbuWEUYFAiFy4KMWU7thrbsliVsgo
        u6pRtlMdGdXYp/PavHG0j
X-Received: by 2002:a5d:684d:: with SMTP id o13mr23663882wrw.364.1591625950524;
        Mon, 08 Jun 2020 07:19:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjPaCr/8TnJQQDekq/pLvjYLG6035xMzBgU5hUdaugwjW4iDPp5TeNz9CgVwCa8rpiGmFfHQ==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr23663857wrw.364.1591625950241;
        Mon, 08 Jun 2020 07:19:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id c206sm24041161wmf.36.2020.06.08.07.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:19:09 -0700 (PDT)
Subject: Re: [PATCH v2 03/15] pwm: lpss: Add range limit check for the
 base_unit register value
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
 <20200608035023.GZ2428291@smile.fi.intel.com>
 <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
 <20200608125156.GL2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ecb5ca16-91eb-d7b9-dbaf-ee18cb85d9f3@redhat.com>
Date:   Mon, 8 Jun 2020 16:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608125156.GL2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/8/20 2:51 PM, Andy Shevchenko wrote:
> On Mon, Jun 08, 2020 at 01:07:12PM +0200, Hans de Goede wrote:
>> On 6/8/20 5:50 AM, Andy Shevchenko wrote:
>>> On Sun, Jun 07, 2020 at 08:18:28PM +0200, Hans de Goede wrote:
>>>> When the user requests a high enough period ns value, then the
>>>> calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
>>>>
>>>> But according to the data-sheet the way the PWM controller works is that
>>>> each input clock-cycle the base_unit gets added to a N bit counter and
>>>> that counter overflowing determines the PWM output frequency. Adding 0
>>>> to the counter is a no-op. The data-sheet even explicitly states that
>>>> writing 0 to the base_unit bits will result in the PWM outputting a
>>>> continuous 0 signal.
>>>
>>> So, and why it's a problem?
>>
>> Lets sya the user requests a PWM output frequency of 100Hz on Cherry Trail
>> which has a 19200000 Hz clock this will result in 100 * 65536 / 19200000 =
>> 0.3 -> 0 as base-unit value. So instead of getting 100 Hz the user will
>> now get a pin which is always outputting low.
>>
>> OTOH if we clamp to 1 as lowest value, the user will get 192000000 / 65536
>> = 292 Hz as output frequency which is as close to the requested value as
>> we can get while actually still working as a PWM controller.
> 
> So, we should basically divide and round up, no?

Yes, that will work for the low limit of base_unit but it will make
all the other requested period values less accurate.

> At least for 0 we will get 0.

We're dealing with frequency here, but the API is dealing with period,
so to get 0 HZ the API user would have to request a period of > 1s e.g.
request 2s / 0.5 Hz but then the user is still not really requesting 0Hz
(that would correspond with a period of infinity which integers cannot
represent.

>>>> base_unit values > (base_unit_range / 256), or iow base_unit values using
>>>> the 8 most significant bits, cause loss of resolution of the duty-cycle.
>>>> E.g. assuming a base_unit_range of 65536 steps, then a base_unit value of
>>>> 768 (256 * 3), limits the duty-cycle resolution to 65536 / 768 = 85 steps.
>>>> Clamp the max base_unit value to base_unit_range / 32 to ensure a
>>>> duty-cycle resolution of at least 32 steps. This limits the maximum
>>>> output frequency to 600 KHz / 780 KHz depending on the base clock.
>>>
>>> This part I don't understand. Why we limiting base unit? I seems like a
>>> deliberate regression.
>>
>> The way the PWM controller works is that the base-unit gets added to
>> say a 16 bit (on CHT) counter each input clock and then the highest 8
>> bits of that counter get compared to the value programmed into the
>> ON_TIME_DIV bits.
>>
>> Lets say we do not clamp and allow any value and lets say the user
>> selects an output frequency of half the input clock, so base-unit
>> value is 32768, then the counter will only have 2 values:
>> 0 and 32768 after that it will wrap around again. So any on time-div
>> value < 128 will result in the output being always high and any
>> value > 128 will result in the output being high/low 50% of the time
>> and a value of 255 will make the output always low.
>>
>> So in essence we now only have 3 duty cycle levels, which seems like
>> a bad idea to me / not what a pwm controller is supposed to do.
> 
> It's exactly what is written in the documentation. I can't buy base unit clamp.
> Though, I can buy, perhaps, on time divisor granularity, i.e.
>    1/	0% - 25%-1 (0%)
>    2/	25% - 50% - 75% (50%)
>    3/	75%+1 - 100% (100%)
> And so on till we got a maximum resolution (8 bits).

Note that the PWM API does not expose the granularity to the API user,
which is why I went with just putting a minimum on it of 32 steps.

Anyways I don't have a strong opinion on this, so I'm fine with not clamping
the base-unit to preserve granularity. We should still clamp it to avoid
overflow if the user us requesting a really high frequency though!

The old code had:

	base_unit &= base_unit_range;

Which means that if the user requests a too high value, then we first
overflow base_unit and then truncate it to fit leading to a random
frequency.

So if we forget my minimal granularity argument, then at a minimum
we need to replace the above line with:

	base_unit = clamp_t(unsigned long long, base_unit, 1, base_unit_range - 1);

And since we need the clamp anyways we can then keep the current round-closest
behavior.

Regards,

Hans

