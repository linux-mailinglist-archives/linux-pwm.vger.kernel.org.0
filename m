Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBC21A0B8
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgGINXW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 09:23:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54531 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGINXW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 09:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594301000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=om+Zgsnth1UycyQNd04acv9Ke50N6QVpsKjGNzz8W28=;
        b=NwoOnB3juQBdJyF4KzjxSC7KL1iXIr++S8zzCl2Gp+sYaT5F1S7aWau0YtqOWdeJNhTPX0
        7MGxP6Qm9k0jzpEDABgVJZnpnhIzmluIS1WXgl2r3zKLwbBdjKewTD4fZAuDR85liyQXcw
        kRP2geboXfpVEB22J0V5aJTKIcccA04=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-RrMW6BelPWGgrh8utR_KBw-1; Thu, 09 Jul 2020 09:23:18 -0400
X-MC-Unique: RrMW6BelPWGgrh8utR_KBw-1
Received: by mail-wr1-f71.google.com with SMTP id y18so1939453wrq.4
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2020 06:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=om+Zgsnth1UycyQNd04acv9Ke50N6QVpsKjGNzz8W28=;
        b=Snx3BmHP7wPuHcExw+yWG1MpyteXEJB/eoLV9aXuLiBLgwz5BKtrGRGH+c6GyOusIr
         cZnSa/kktIRaxml95JIglrb1towev1FrvIXqmElJfNtOYq8VueSoaNjHtXnfdfhnvGzs
         NUzG8CAchnDMUT7SXZuiDidhCe5CBwwD3gfv98vXYsKVM6VPmEb1PetsWetJ5jm5Mgrd
         KRKEN1rzKyKIsQDceKqBN76QHmcPDEdgKjpOq5j1XSfD30U/CjT6MaVjeDTRV0NfEogY
         BtX5/Y7JxB2DOVGDeAlyNY0PBx+B6OzvTHO5er7RYE1zBVXr4z3VBxTPU+9Y7PoIPD2R
         b4FQ==
X-Gm-Message-State: AOAM533fAckZZubmZtvQopoVm4w4gaEvqjTOb3pFyeuATtwJOFKUx9DA
        F6bqGRyEgMnehY7pv1hvfMdbjx241VsRMTHgThEd7OF5G2q7L3MWqgvgpFIN/EI/Vl8YsI6jAKK
        oSxu9oFHxubFaAD4O7199
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr14115597wma.89.1594300997660;
        Thu, 09 Jul 2020 06:23:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcwToreramZ9GQ8KUd+vqBEajc7P10Uh1xpRqlMze2Zrf1AIRtVAFjd73MEdJy+mt2WONPcw==
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr14115564wma.89.1594300997305;
        Thu, 09 Jul 2020 06:23:17 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id 2sm4669628wmo.44.2020.07.09.06.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:23:16 -0700 (PDT)
Subject: Re: [PATCH v4 04/16] pwm: lpss: Add range limit check for the
 base_unit register value
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
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
 <20200708211432.28612-5-hdegoede@redhat.com>
 <20200709125342.GX3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4ff9dc18-fa59-d9a3-c7bf-9f95c62fc356@redhat.com>
Date:   Thu, 9 Jul 2020 15:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709125342.GX3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/9/20 2:53 PM, Andy Shevchenko wrote:
> On Wed, Jul 08, 2020 at 11:14:20PM +0200, Hans de Goede wrote:
>> When the user requests a high enough period ns value, then the
>> calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
>>
>> But according to the data-sheet the way the PWM controller works is that
>> each input clock-cycle the base_unit gets added to a N bit counter and
>> that counter overflowing determines the PWM output frequency. Adding 0
>> to the counter is a no-op. The data-sheet even explicitly states that
>> writing 0 to the base_unit bits will result in the PWM outputting a
>> continuous 0 signal.
> 
> And I don't see how you can get duty 100% / 0% (I don't remember which one is
> equivalent to 0 in base unit) after this change. IIRC the problem here that
> base unit when non-zero is always being added to the counter and it will
> trigger the change of output at some point which is not what we want for 100% /
> 0% cases.

The base_unit controls the output frequency, not the duty-cycle. So clamping
the base_unit, as calculated from the period here, which also only configures
output-frequency does not impact the duty-cycle at all.

note that AFAICT currently no (in kernel) users actually try to set a period value
which would hit the clamp, so for existing users the clamp is a no-op. I just
added it to this patch-set for correctness sake and because userspace
(sysfs interface) users could in theory set out of range values.

As for the duty-cycle thing, first of all let me say that that is a
question / issue which is completely orthogonal to this patch, this
patch only impacts the period/output frequency NOT the duty-cycle,

With that said, the documentation is not really helpful here,
we need to set the on_time_div to 255 to get a duty-cycle close to 0
(and to 0 to get a duty cycle of 100%) but if setting this to 255 gives
us a duty-cycle of really really 0%, or just close to 0% is uncleaer.

We could do a separate patch add ing a hack where if the user asks for
0% duty-cycle we program the base_unit to 0, but that seems like a bad
idea for 2 reasons:

1. If the user really wants the output to be constantly 0 the user should
just disable the pwm

2. New base_unit values are latched and not applied until the counter
overflows, with a base_unit of 0 the counter never overflows. I have
not tested this but I would not be surprised if after programming a
base_unit value of 0, we are unable to ever change the value again
through any other means then power-cycling the PWM controller.
Even if I could test this on some revisions, we already know that
not all revisions work the same wrt the latching. So it is best to
just never set base_unit to 0, that is just a recipe asking for trouble.

>> When the user requestes a low enough period ns value, then the
>> calculations in pwm_lpss_prepare() might result in a base_unit value
>> which is bigger then base_unit_range - 1. Currently the codes for this
>> deals with this by applying a mask:
>>
>> 	base_unit &= (base_unit_range - 1);
>>
>> But this means that we let the value overflow the range, we throw away the
>> higher bits and store whatever value is left in the lower bits into the
>> register leading to a random output frequency, rather then clamping the
>> output frequency to the highest frequency which the hardware can do.
> 
> It would be nice to have an example of calculus here.
> 
>> This commit fixes both issues by clamping the base_unit value to be
>> between 1 and (base_unit_range - 1).
> 
> Eventually I sat and wrote all this on paper. I see now that the problem
> is in out of range of the period. And strongly we should clamp rather period
> to the supported range, but your solution is an equivalent.

Right, the advantage of doing the clamping on the register value is that we
avoid some tricky math with possible rounding errors and which is different
per controller revision because the number of bits in the base unit being
different per controller revision.

> Only question is about the 100% / 0% duty cycle.

See my answer to that above.

>> Fixes: 684309e5043e ("pwm: lpss: Avoid potential overflow of base_unit")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Change upper limit of clamp to (base_unit_range - 1)
>> - Add Fixes tag
>> ---
>>   drivers/pwm/pwm-lpss.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>> index 43b1fc634af1..80d0f9c64f9d 100644
>> --- a/drivers/pwm/pwm-lpss.c
>> +++ b/drivers/pwm/pwm-lpss.c
>> @@ -97,6 +97,9 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>>   	freq *= base_unit_range;
>>   
>>   	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
>> +	/* base_unit must not be 0 and we also want to avoid overflowing it */
> 
>> +	base_unit = clamp_t(unsigned long long, base_unit, 1,
>> +			    base_unit_range - 1);
> 
> A nit: one line.

Doesn't fit in 80 chars, I guess we could make this one line now with the new 100 chars
limit, but that does make it harder to read for people using standard terminal widths
and a terminal based editors. So I would prefer to keep this as is.

Regards,

Hans


> 
>>   	on_time_div = 255ULL * duty_ns;
>>   	do_div(on_time_div, period_ns);
>> @@ -105,7 +108,6 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>>   	orig_ctrl = ctrl = pwm_lpss_read(pwm);
>>   	ctrl &= ~PWM_ON_TIME_DIV_MASK;
>>   	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
>> -	base_unit &= (base_unit_range - 1);
>>   	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
>>   	ctrl |= on_time_div;
>>   
>> -- 
>> 2.26.2
>>
> 

