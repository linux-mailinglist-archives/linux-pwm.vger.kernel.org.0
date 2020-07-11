Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B521C48D
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2020 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgGKN6L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Jul 2020 09:58:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53816 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbgGKN6J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Jul 2020 09:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594475886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6J6T6hNE9yvLEROStKfnmk4k6OpGMdc4beepe1jo0w=;
        b=UBUnQHs3sdOqr5TA0mUle0IK4ge0npJd6gWsUxzr3CrsOZb/shZfDCQRwtm+O0T2qFhUte
        cNoyTl62YRBGJJpX5UHzcK0jC4lEduVzp6QMHv/MoPWolqeCKRXu3ETSx2YHNBVw2NKICC
        N9uNTeB6q6JYbyGIv0aOejh9xGZT91c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-RTmI-De4M0iBWw16v7Dpcw-1; Sat, 11 Jul 2020 09:58:05 -0400
X-MC-Unique: RTmI-De4M0iBWw16v7Dpcw-1
Received: by mail-ed1-f69.google.com with SMTP id a4so11400591edr.18
        for <linux-pwm@vger.kernel.org>; Sat, 11 Jul 2020 06:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6J6T6hNE9yvLEROStKfnmk4k6OpGMdc4beepe1jo0w=;
        b=spDA7/dBO/wrqje8b5QmpL7edMG0//ZOPWtatG2FgwAAdqUaZhN3TbtucHCPhmLHCO
         OWIixoql4uSXLAlPy1QJTXzKSNKj+JXRRN1gpNGHiHc/rqQZ0rSCWlDfPyjmlTs12GGz
         48zhLDRaJjuFwI+0JZccA+AB5Tp+AJHm6+Zr55GrErv+kNKGvM/3J4VnTjaCCSJuOJp3
         mljmJTI30pH8Laq8Ti2di4Ostb2HKwjKIwlu9pjxJHWnq+EMs8S0SJnWBn2Zu794ir58
         Z8W3iZYgROKIzXKuMmV6j4SvVmXnE1pLTqrac9mLtxraksj+wHINu0iYKnjs6uYKTaVR
         z1Hw==
X-Gm-Message-State: AOAM530V9tDghBXWJ1VenwfJuONsXAgWGLDtsEDqFdAIzFaaMCK9ZhFJ
        76KqPPInaHC8BQYvnHAFW8sxgF/5meCUaTpdKM+zF6P6X9BKySACaxhkqBTsT+DRaqgPs+1o8ty
        JvGn7uB921HLRLwTJGyc6
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr62206012ejf.398.1594475884053;
        Sat, 11 Jul 2020 06:58:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV4+j4+MFepvD2IOQF0qSRfySKoiQJW2DpkPXYqNJOhV5/QUkfGAppFHknge4Oh4ffuHn1Aw==
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr62205990ejf.398.1594475883843;
        Sat, 11 Jul 2020 06:58:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g21sm6868328edr.45.2020.07.11.06.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 06:58:03 -0700 (PDT)
Subject: Re: [PATCH v4 06/16] pwm: lpss: Correct get_state result for
 base_unit == 0
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-7-hdegoede@redhat.com>
 <20200709145013.GA3703480@smile.fi.intel.com>
 <af7158c5-02bb-38ce-4b22-e469079dcccf@redhat.com>
 <20200711061120.di53sk5utjerb72q@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d98c758b-711d-baae-e752-1b32040128a4@redhat.com>
Date:   Sat, 11 Jul 2020 15:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200711061120.di53sk5utjerb72q@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/11/20 8:11 AM, Uwe Kleine-König wrote:
> On Thu, Jul 09, 2020 at 05:47:59PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 7/9/20 4:50 PM, Andy Shevchenko wrote:
>>> On Wed, Jul 08, 2020 at 11:14:22PM +0200, Hans de Goede wrote:
>>>> The datasheet specifies that programming the base_unit part of the
>>>> ctrl register to 0 results in a contineous low signal.
>>>>
>>>> Adjust the get_state method to reflect this by setting pwm_state.period
>>>> to 1 and duty_cycle to 0.
>>>
>>> ...
>>>
>>>> +	if (freq == 0) {
>>>> +		/* In this case the PWM outputs a continous low signal */
>>>
>>>> +		state->period = 1;
>>>
>>> I guess this should be something like half of the range (so base unit calc
>>> will give 128). Because with period = 1 (too small) it will give too small
>>> base unit (if apply) and as a result we get high frequency pulses.
>>
>> You are right, that if after this the user only changes the duty-cycle
>> things will work very poorly, we will end up with a base_unit value of
>> e.g 65535 and then have almost no duty-cycle resolution at all.
> 
> Is this a problem of the consumer that we don't need to solve? Are there
> known consumers running into this problem?

AFAICT we never ever actually see freq == 0 here, this is just a code-path
to avoid a divide by 0 in case we somehow mysteriously do get freq == 0
here.

On boot the PWM controller is either not used and then the default freq =
input-clock / 256, or it is used and programmed to same sane value.

> pwm_lpss_prepare() is buggy here, a request for a too low period should be
> refused.

So instead of clamping as is done in an earlier patch, we should return
-EINVAL ?  Only for too low periods, or also for too high periods ?

I must say this does worry me a bit, the VBT may request 200Hz output
frequency and some revisions of the PWM controller can do 283Hz as
lowest output freq. ATM we just give the i915 code the 283 Hz if it
request 200, that seems more sane then to give it -EINVAL, since -EINVAL
would require the i915 driver to know the exact limits of each PWM
controller and then to clamp the VBT value before passing it to the
PWM driver, that means moving knowledge out of the PWM driver into
the i915 code.

I believe that without first amending the PWM API too allow a consumer
to query the period min/max values, returning -EINVAL is not the right
thing to do here.

Regards,

Hans

