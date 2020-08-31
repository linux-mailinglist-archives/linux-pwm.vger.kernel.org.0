Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EB2578B1
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaLuw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:50:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47160 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726292AbgHaLuv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598874649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WjU6ksiFY5rNC2vk4k2IBWzscUFIhhky8xaIdyl+5Yo=;
        b=MnTfSn43jEy3KdVh4l23PM5TQiK0eBnybE4PkDw6GopGbJmgGKO2YhWIVGufmfX3YUiTnD
        AShKj2G01qe2jKzsrI+F+KUpzszZCA/H9Jr1b7t+WuUbilKPh8pQskg7EA+iPtge0bYXpe
        vCJ1vlqedZKq1MLIwux+QJEyqUaJ6/Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-plZBoHwWN7yAtszl9o3ynQ-1; Mon, 31 Aug 2020 07:50:47 -0400
X-MC-Unique: plZBoHwWN7yAtszl9o3ynQ-1
Received: by mail-ej1-f69.google.com with SMTP id w17so388934eja.10
        for <linux-pwm@vger.kernel.org>; Mon, 31 Aug 2020 04:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WjU6ksiFY5rNC2vk4k2IBWzscUFIhhky8xaIdyl+5Yo=;
        b=Azb1flBnBotuWKJ8vqBTV51aemyPw8JOhlQPRD3IG3sCYZGlLgP8xcCh5UhQhUCUTO
         5g+AIiAOEn71DKLgZ7YqbjY+vnKdDstrmzgFUY3BBcThSTlD9QJrfSKmA9qDKw5nH3o9
         KDMHB5NR/cxosK1V7C8V3xXc0GZfDOtZt5HgvChTxKt6cNEjtPRPseIxzXdjtLpQMKFl
         dK6u0zt6BfXW0ygDnPaDJ6mk5xAHbZYtcPrAg7vZedL/U1egUpHLIsRvm9xa/wBVvIk9
         MCEn1kSQ0FGSR2VogGStvxYLExYu5fNxErcrpjU4d+lqf37017whJv5UrC4DKpDAUKKc
         mdrg==
X-Gm-Message-State: AOAM530esLefMCRAWFhVKOIlh2JmnxEuyqNDNukOhZ59Pjw8E2IJZi/w
        5dNxlxeDDwvv7jemV5W6/BgXpw1jxKGcEzRp7LzxglEKZlx8OVzOBFiDqB6enAd4k9u6Vjsskk6
        xdRpXdTQMXsvGSKMubN5x
X-Received: by 2002:a17:906:3b4b:: with SMTP id h11mr749791ejf.381.1598874646448;
        Mon, 31 Aug 2020 04:50:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSUQxbJrReB/0fm2S5MeNHKixC/oEmL76NSUvi2tbHRKtKnHqLT4ULpWLMlBxAnYXO6QA3GQ==
X-Received: by 2002:a17:906:3b4b:: with SMTP id h11mr749763ejf.381.1598874646249;
        Mon, 31 Aug 2020 04:50:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y8sm7967538ejd.57.2020.08.31.04.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:50:45 -0700 (PDT)
Subject: Re: [PATCH v8 07/17] pwm: lpss: Always update state and set update
 bit
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
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-8-hdegoede@redhat.com>
 <20200831085649.GB1891694@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6afd6bc-52b3-8712-ae39-f2c0511a096b@redhat.com>
Date:   Mon, 31 Aug 2020 13:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831085649.GB1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 8/31/20 10:56 AM, Andy Shevchenko wrote:
> On Sun, Aug 30, 2020 at 02:57:43PM +0200, Hans de Goede wrote:
>> This commit removes a check where we would skip writing the ctrl register
>> and then setting the update bit in case the ctrl register already contains
>> the correct values.
>>
>> In a perfect world skipping the update should be fine in these cases, but
>> on Cherry Trail devices the AML code in the GFX0 devices' PS0 and PS3
>> methods messes with the PWM controller.
>>
>> The "ACPI / LPSS: Resume Cherry Trail PWM controller in no-irq phase" patch
>> earlier in this series stops the GFX0._PS0 method from messing with the PWM
>> controller and on the DSDT-s inspected sofar the _PS3 method only reads
>> from the PWM controller (and turns it off before we get a change to do so):
>>
>>      {
>>          PWMB = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          PSAT |= 0x03
>>          Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>>      }
>>
>> The PWM controller getting turning off before we do this ourselves is
>> a bit annoying but not really an issue.
>>
>> The problem this patch fixes comes from a new variant of the GFX0._PS3 code
>> messing with the PWM controller found on the Acer One 10 S1003 (1):
>>
>>      {
>>          PWMB = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          PWMT = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          PWMT &= 0xFF0000FF
>>          PWMT |= 0xC0000000
>>          PWMC = PWMT /* \_SB_.PCI0.GFX0.PWMT */
>>          PWMT = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          Sleep (0x64)
>>          PWMB &= 0x3FFFFFFF
>>          PWMC = PWMB /* \_SB_.PCI0.GFX0.PWMB */
>>          PSAT |= 0x03
>>          Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>>      }
>>
>> This "beautiful" piece of code clears the base-unit part of the ctrl-reg,
>> which effectively disables the controller, and it sets the update flag
>> to apply this change. Then after this it restores the original ctrl-reg
>> value, so we do not see it has mucked with the controller.
>>
>> *But* it does not set the update flag when restoring the original value.
>> So the check to see if we can skip writing the ctrl register succeeds
>> but since the update flag was not set, the old base-unit value of 0 is
>> still in use and the PWM controller is effectively disabled.
>>
>> IOW this PWM controller poking means that we cannot trust the base-unit /
>> on-time-div value we read back from the PWM controller since it may not
>> have been applied/committed. Thus we must always update the ctrl-register
>> and set the update bit.
>>
>> 1) And once I knew what to look for also in a bunch of other devices
>> including the popular Lenovo Ideapad Miix 310 and 320 models and
>> various Medion models.
> 
> Despite the above mentioned issue I'm always in favour of not micro-optimizing I/O.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

Regards,

Hans



> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v8:
>> - New patch in v8 of this patch-set
>> ---
>>   drivers/pwm/pwm-lpss.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>> index 9a7400c6fb6e..20f6b6d6f874 100644
>> --- a/drivers/pwm/pwm-lpss.c
>> +++ b/drivers/pwm/pwm-lpss.c
>> @@ -85,7 +85,7 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>>   	unsigned long long on_time_div;
>>   	unsigned long c = lpwm->info->clk_rate, base_unit_range;
>>   	unsigned long long base_unit, freq = NSEC_PER_SEC;
>> -	u32 orig_ctrl, ctrl;
>> +	u32 ctrl;
>>   
>>   	do_div(freq, period_ns);
>>   
>> @@ -104,16 +104,14 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>>   	do_div(on_time_div, period_ns);
>>   	on_time_div = 255ULL - on_time_div;
>>   
>> -	orig_ctrl = ctrl = pwm_lpss_read(pwm);
>> +	ctrl = pwm_lpss_read(pwm);
>>   	ctrl &= ~PWM_ON_TIME_DIV_MASK;
>>   	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
>>   	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
>>   	ctrl |= on_time_div;
>>   
>> -	if (orig_ctrl != ctrl) {
>> -		pwm_lpss_write(pwm, ctrl);
>> -		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
>> -	}
>> +	pwm_lpss_write(pwm, ctrl);
>> +	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
>>   }
>>   
>>   static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
>> -- 
>> 2.28.0
>>
> 

