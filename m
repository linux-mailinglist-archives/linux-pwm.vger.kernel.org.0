Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD921A22D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGIOd6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 10:33:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20689 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgGIOd5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 10:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594305235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhGLIk7C2NMc6JM40F6DvWPFT3QT/gthp+F60/ml+CQ=;
        b=Ypr7dpYWTUR45jl1MKwg4SN4TOac2h3k/1vYa8by4cFghWDU+sjMAVd4+VAx4d/X8E4cGj
        khotR+SrYu3R5XX9bZ/A1/n0V85X2p5DcwIOi5pCfhFQsp3iGmLIboNXIKAGGXQqcJN3+R
        vEXESOUlhnj3H/qK4vAYRfSd8nDKy/A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-REYzvIYcNIeqEK57kykv-w-1; Thu, 09 Jul 2020 10:33:54 -0400
X-MC-Unique: REYzvIYcNIeqEK57kykv-w-1
Received: by mail-wm1-f70.google.com with SMTP id g187so2348926wme.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2020 07:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhGLIk7C2NMc6JM40F6DvWPFT3QT/gthp+F60/ml+CQ=;
        b=oOYgZG8rNJ9g7jdaEFXDz30xlqImAhOVCW9jcpHg6h/McEgub1GgetgL+wUsp3eYuj
         zvgkmaq1E670WzKNDpj7UEdsHS/faASmwQqfj4q7f+6El8QmfVtaH+FQjWlVaYm6zqT0
         qi/Lk7Mb+5F+cUyxZHhLO+QS/owmbDyeQ73SB8drpLkMqGuYRtMYgiZnODU48znVsXcw
         oglE03+Zl5OwvADxQoF26HN116TNb0WLZ0dz9R7AabQlvT0+liXa5jexoSmSzTkdVWMd
         fUMeCCQdYS49ktn3KgXNzWqs6YZF9z2ed0YvzVBZvS8GgRkdTpoda4FDqxJvC/L99Cef
         W+AA==
X-Gm-Message-State: AOAM533f2X9oFfTr+iAH5Qpg74nKVnEwGJ0jfQkOm4JkiEeLvk7OzxkP
        HGpteh81e6awsr+H9VtCXhEhq+ZiY9ys1S05XJel23q93qBy6CVxGTm2g07xpwp8Tgp7JAW+S+2
        EOayeSbnkRH28a3ZOddiA
X-Received: by 2002:adf:f18c:: with SMTP id h12mr61184461wro.375.1594305232734;
        Thu, 09 Jul 2020 07:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGEsPZnHHhwmfS2MVpRo8wpZaIsfNr3HWz/ZZ8+t7FND0PUlyny7kubq5HJplNXnekokhZRw==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr61184441wro.375.1594305232476;
        Thu, 09 Jul 2020 07:33:52 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id o205sm5393490wme.24.2020.07.09.07.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:33:51 -0700 (PDT)
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
 <4ff9dc18-fa59-d9a3-c7bf-9f95c62fc356@redhat.com>
 <20200709142136.GZ3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c7925c63-9187-f89f-3a01-2ff252012615@redhat.com>
Date:   Thu, 9 Jul 2020 16:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709142136.GZ3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/9/20 4:21 PM, Andy Shevchenko wrote:
> On Thu, Jul 09, 2020 at 03:23:13PM +0200, Hans de Goede wrote:
>> On 7/9/20 2:53 PM, Andy Shevchenko wrote:
>>> On Wed, Jul 08, 2020 at 11:14:20PM +0200, Hans de Goede wrote:
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
>>> And I don't see how you can get duty 100% / 0% (I don't remember which one is
>>> equivalent to 0 in base unit) after this change. IIRC the problem here that
>>> base unit when non-zero is always being added to the counter and it will
>>> trigger the change of output at some point which is not what we want for 100% /
>>> 0% cases.
>>
>> The base_unit controls the output frequency, not the duty-cycle. So clamping
>> the base_unit, as calculated from the period here, which also only configures
>> output-frequency does not impact the duty-cycle at all.
>>
>> note that AFAICT currently no (in kernel) users actually try to set a period value
>> which would hit the clamp, so for existing users the clamp is a no-op. I just
>> added it to this patch-set for correctness sake and because userspace
>> (sysfs interface) users could in theory set out of range values.
>>
>> As for the duty-cycle thing, first of all let me say that that is a
>> question / issue which is completely orthogonal to this patch, this
>> patch only impacts the period/output frequency NOT the duty-cycle,
> 
> Unfortunately the base unit settings affects duty cycle.
> 
> Documentation says about integer part and fractional, where integer is
> 8 bit and this what's being compared to on time divisor. Thus, if on time
> divisor is 255 and base unit is 1 (in integer part) or 0.25, we can't get 0%.
> (It looks like if 'on time divisor MOD base unit == 0' we won't get 0%)
> 
>> With that said, the documentation is not really helpful here,
>> we need to set the on_time_div to 255 to get a duty-cycle close to 0
>> (and to 0 to get a duty cycle of 100%) but if setting this to 255 gives
>> us a duty-cycle of really really 0%, or just close to 0% is uncleaer.
> 
> It depends on base unit value.
> 
>> We could do a separate patch add ing a hack where if the user asks for
>> 0% duty-cycle we program the base_unit to 0, but that seems like a bad
>> idea for 2 reasons:
> 
>> 1. If the user really wants the output to be constantly 0 the user should
>> just disable the pwm
> 
> I can't take this as an argument. Disabling PWM is orthogonal to what duty cycle is.
> 
>> 2. New base_unit values are latched and not applied until the counter
>> overflows, with a base_unit of 0 the counter never overflows. I have
>> not tested this but I would not be surprised if after programming a
>> base_unit value of 0, we are unable to ever change the value again
>> through any other means then power-cycling the PWM controller.
>> Even if I could test this on some revisions, we already know that
>> not all revisions work the same wrt the latching. So it is best to
>> just never set base_unit to 0, that is just a recipe asking for trouble.
> 
> This what doc says about zeros:
> • Programming either the PWM_base_unit value or the PWM_on_time_divisor to ‘0’
> will generate an always zero output.
> 
> So, what I'm talking seems about correlation between base unit and on time
> divisor rather than zeros.
> 
> I agree with this patch.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

>>>> When the user requestes a low enough period ns value, then the
>>>> calculations in pwm_lpss_prepare() might result in a base_unit value
>>>> which is bigger then base_unit_range - 1. Currently the codes for this
>>>> deals with this by applying a mask:
>>>>
>>>> 	base_unit &= (base_unit_range - 1);
>>>>
>>>> But this means that we let the value overflow the range, we throw away the
>>>> higher bits and store whatever value is left in the lower bits into the
>>>> register leading to a random output frequency, rather then clamping the
>>>> output frequency to the highest frequency which the hardware can do.
>>>
>>> It would be nice to have an example of calculus here.
>>>
>>>> This commit fixes both issues by clamping the base_unit value to be
>>>> between 1 and (base_unit_range - 1).
>>>
>>> Eventually I sat and wrote all this on paper. I see now that the problem
>>> is in out of range of the period. And strongly we should clamp rather period
>>> to the supported range, but your solution is an equivalent.
>>
>> Right, the advantage of doing the clamping on the register value is that we
>> avoid some tricky math with possible rounding errors and which is different
>> per controller revision because the number of bits in the base unit being
>> different per controller revision.
> 
> ...
> 
>>>> +	base_unit = clamp_t(unsigned long long, base_unit, 1,
>>>> +			    base_unit_range - 1);
>>>
>>> A nit: one line.
>>
>> Doesn't fit in 80 chars, I guess we could make this one line now with the new 100 chars
>> limit, but that does make it harder to read for people using standard terminal widths
>> and a terminal based editors. So I would prefer to keep this as is.
> 
> You can use clamp_val().

I did not know about that, that will work nicely I will switch to clamp_val
for the next version. I assume it is ok to keep your Reviewed-by with this
very minor change?

Regards,

Hans

> 

