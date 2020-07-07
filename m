Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECB4217536
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2020 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGGRbg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jul 2020 13:31:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728391AbgGGRbg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 13:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594143094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkpZ9ksQd7iWxIlvtNfzO9EHx1DMJN1+3vOo10sqsHI=;
        b=cnyB561Ys/RCn2KSHg7wRh0qba2UJ1jh6efDLauT7IeuGE8FgoyzvnZwIA2UKn6RZBpgws
        7APm7MZ9oRzLyQi3Qz3ZAiBrE5MpXW19gdeRLMBgwuUi4U0X4UpJ5TZVEVsN2oVAvNH7kD
        VxD07I7jCwurzJsijVQa0P+T3IWiW2Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-EAzFls8yPmq2niKQfces8g-1; Tue, 07 Jul 2020 13:31:32 -0400
X-MC-Unique: EAzFls8yPmq2niKQfces8g-1
Received: by mail-ej1-f72.google.com with SMTP id op28so39074602ejb.15
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2020 10:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZkpZ9ksQd7iWxIlvtNfzO9EHx1DMJN1+3vOo10sqsHI=;
        b=AHajNySe0/UVNNTzugqLOXPOTKwDAHB0K8c8rLN28Haq4pAGQ5Gq0tYNETGxpCI+Kz
         sW7Jn1NSPi3SkRIvKR6ojz65yrW/MJ5WhY89P4d3gd9SXmERIPKOb06lkw8HLgeBnEuc
         I6gQdH8tO5tIJiRr2m43MqRURnlht1ZIOUjAnrFwRkDqHMgIVHS3sgZJgYGJ2nYo0m7S
         mN5vmOhwkWvOkQONS3KOINDQXOJOMlbqEDfLMkrXvd2ZkZgH7m0G8EijcrNkESHF9cr5
         w9YQHuLC55bHl3IYwC9fma/4drn4Kvh/mTJxRBldoHS28vwkDxqNdoPkhMrdrxxhKzNc
         Xi9w==
X-Gm-Message-State: AOAM532L92dHJkhPcRbADSuRrvVXJTbb6/Kf9RzZJoL9nnVs5U01MD6G
        YYXgatbAwyhqo+cVJ9nX+GLFXJWowZqmaDmbcPS3d4LCdcv6PPY5B7Q3bQG4QNNSONBK54Q7V5K
        QhsSIBgGNUS1+G1cg8dP+
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr61480138edb.260.1594143091311;
        Tue, 07 Jul 2020 10:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9VwVc3j4Gj9BryDzoyTih9enqH0U2nPjxRT5SbM/g3/dUXuTaZu6s6ggKNVhBmkisFGZCNA==
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr61480119edb.260.1594143091129;
        Tue, 07 Jul 2020 10:31:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n16sm650173ejo.54.2020.07.07.10.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 10:31:30 -0700 (PDT)
Subject: Re: [PATCH v3 04/15] pwm: lpss: Add range limit check for the
 base_unit register value
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-5-hdegoede@redhat.com>
 <20200622073554.wf3smq3tvnr6t2xy@taurus.defre.kleine-koenig.org>
 <e07a7dd6-c361-32b8-c4e7-91e022f9c21d@redhat.com>
 <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1496178b-ce39-9285-ff75-cd39bc0e9aa7@redhat.com>
Date:   Tue, 7 Jul 2020 19:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/7/20 9:34 AM, Uwe Kleine-König wrote:
> On Mon, Jul 06, 2020 at 10:53:08PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for your review and sorry for the slow reply.
> 
> No problem for me, I didn't hold my breath :-)
>   
>>>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>>>> index 43b1fc634af1..80d0f9c64f9d 100644
>>>> --- a/drivers/pwm/pwm-lpss.c
>>>> +++ b/drivers/pwm/pwm-lpss.c
>>>> @@ -97,6 +97,9 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>>>>    	freq *= base_unit_range;
>>>>    	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
>>>
>>> DIV_ROUND_CLOSEST_ULL is most probably wrong, too. But I didn't spend
>>> the time to actually confirm that.
>>
>> Yes I saw your comment elsewhere that the PWM API defines rounding
>> in a certain direction, but fixing that falls outside of this patch.
> 
> Yeah, sure.
> 
>> [...]
>> I hope this helps to explain what is going on a bit.
> 
> I will try to make sense of that and reply to the patch directly when I
> succeeded.
> 
>> ###
>>
>> As for the behavior on base_unit==0 in the get_state method,
>> as mentioned above I wrote that when I did not fully understood
>> how the controller works.
>>
>> We really should never encounter this.
>>
>> But if we do then I think closest to the truth would be:
>>
>> state->period     = UINT_MAX;
>> state->duty_cycle = 0;
> 
> I'd say state->period = 1 & state->duty_cycle = 0 is a better
> representation.

But that would suggest the output is configured for an
infinitely high output frequency, but the frequency is
actually 0, the reason why get_state needs to treat a
base_unit val of 0 special at all is to avoid a division
by 0, and in math dividing by 0 gives infinite, isn't
UINT_MAX a better way to represent infinity ?

Regards,

Hans

