Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA322AB57E
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 11:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgKIKxQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 05:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729049AbgKIKxQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 05:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604919194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q9upMQCe8tamgiLJ9J28xA0oQVVfURhm/Mgs94xS44=;
        b=JdGrwIEoDDQsFiOhXpZMq4OwTT0VFR0Uoq85PwDfBMaLK2bvXO2r+zPEfK/1tk5NaOVfpU
        oCUZ2L5/aE3JJ94X19/FI/+SuiE118QHP4vRwqDbUdet7wL1QKMkgLGzIjHpv+sjLAI2A0
        hwAa4XsjyOcY0fbKMOf/MKx0rveQVfw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-1ZGb1lBcOu6gjh2K-fXakg-1; Mon, 09 Nov 2020 05:53:13 -0500
X-MC-Unique: 1ZGb1lBcOu6gjh2K-fXakg-1
Received: by mail-ed1-f72.google.com with SMTP id o2so2573907edw.1
        for <linux-pwm@vger.kernel.org>; Mon, 09 Nov 2020 02:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3q9upMQCe8tamgiLJ9J28xA0oQVVfURhm/Mgs94xS44=;
        b=VTHV9isrHXTvleUwgNAd6uZcGklABT0JfHb7t4YzCq5axMmrGdnkx8HPlGdiXW5Qna
         OL0Rz4ELgZWqlFBslwXIXg4KO88Osn01vCWWmMVdgtppTl4wEEOJ9i3u0d/1Op1YbW5H
         XXb1bqHac8ecb0PanHfOkThyVz5Fweb/7E5idRQB6Kv+R0ssa0Hq9m6emdhKKuBw7VJ0
         xiosGOnozZJsr/sdE8j1zJedMTKYnRGPqpJldvk7yZsPjaqEHzMlmwiv8bVgJshtnDpD
         0n/ryPZi1ohfkaYyRidHD7HlrW4i9aZtA6ztSgc5MUp6gsCHEbtO9h4qpm7mk4+sOBHX
         nB2A==
X-Gm-Message-State: AOAM53151B9jn82PYFwhT/k+NzQIGhnUS+Z71LLO/mnZbqlIiRAxwpyX
        nBKSjNXZwpMcNJiYHwf68zMkR3PBSX3Amv3L4Axm/cT/4+vyBPBMJsj2BHXuS6+EhDRRGrfm+Sw
        cbzVzO96NPvCjIZ4b3j2V
X-Received: by 2002:a50:b584:: with SMTP id a4mr14809495ede.301.1604919191849;
        Mon, 09 Nov 2020 02:53:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyl7X/P0PYG+7k7UcOixA8ISrfPhIkOruPOA0UmfDfPXLPZ+4K2+c9rE4qPs1S+ecOnY1R6tw==
X-Received: by 2002:a50:b584:: with SMTP id a4mr14809484ede.301.1604919191684;
        Mon, 09 Nov 2020 02:53:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id b8sm8598869edv.20.2020.11.09.02.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 02:53:10 -0800 (PST)
Subject: Re: [PATCH 3/3] pwm: lpss: Set DPM_FLAG_SMART_SUSPEND on Cherry Trail
 devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201030094832.18297-1-hdegoede@redhat.com>
 <20201030094832.18297-4-hdegoede@redhat.com>
 <CAHp75VeP4ttqXBiS3VCQJBkN=D9-vRoOKn0ZMiZdt8gvsCpRgA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0f2aba0d-1e0e-5574-9ef8-10fb54741d0d@redhat.com>
Date:   Mon, 9 Nov 2020 11:53:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeP4ttqXBiS3VCQJBkN=D9-vRoOKn0ZMiZdt8gvsCpRgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 10/30/20 1:45 PM, Andy Shevchenko wrote:
> On Fri, Oct 30, 2020 at 11:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> As the comment above the code setting the DPM_FLAG_NO_DIRECT_COMPLETE
>> flag explains:
>>
>>     /*
>>      * On Cherry Trail devices the GFX0._PS0 AML checks if the controller
>>      * is on and if it is not on it turns it on and restores what it
>>      * believes is the correct state to the PWM controller.
>>      * Because of this we must disallow direct-complete, which keeps the
>>      * controller (runtime)suspended, on resume to avoid 2 issues:
>>      * 1. The controller getting turned on without the linux-pm code
>>      *    knowing about this. On devices where the controller is unused
>>      *    this causes it to stay on during the next suspend causing high
>>      *    battery drain (because S0i3 is not reached)
>>      * 2. The state restoring code unexpectedly messing with the controller
>>      */
>>
>> The pm-core must not skip resume to avoid the GFX0._PS0 AML code messing
>> with the PWM controller behind our back. But
> 
>> leaving the controller
>> runtime-suspended (skipping runtime-resume + normal-suspend) during
>> suspend is fine.
> 
> This paragraph is good to have in the comment of the code I think.

Agreed, I've added this as comment for v2 of this patch set and I
will send out a v2 of the entire series with your reviewed-by
added.

Thanks & Regards,

Hans



> 
>> Set the DPM_FLAG_SMART_SUSPEND flag to allow this.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/pwm/pwm-lpss-platform.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
>> index ac33861edb48..38d17e2e2b4c 100644
>> --- a/drivers/pwm/pwm-lpss-platform.c
>> +++ b/drivers/pwm/pwm-lpss-platform.c
>> @@ -71,7 +71,8 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
>>          * 2. The state restoring code unexpectedly messing with the controller
>>          */
>>         if (info->other_devices_aml_touches_pwm_regs)
>> -               dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>> +               dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE|
>> +                                                   DPM_FLAG_SMART_SUSPEND);
>>
>>         pm_runtime_set_active(&pdev->dev);
>>         pm_runtime_enable(&pdev->dev);
>> --
>> 2.28.0
>>
> 
> 

