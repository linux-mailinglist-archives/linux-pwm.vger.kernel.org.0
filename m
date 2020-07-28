Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD1231358
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgG1UAb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 16:00:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728755AbgG1UAb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 16:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595966429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSzFFDyUfAnXvkkVJ84iprpsx2ZHjX86onKI2woEOHU=;
        b=D+T8/GpaDWT//rJYg/LyqSwyeSOkVS/wypRYQhSzq/kMGOYiaIgYrIA7ohoe3GNksyAg9H
        mn9irEOBaUwFWLyXcvjaNihuzriqwxuM7K0rkFKndHHOCAzMHOOIl4mOalNrSerc31N8PP
        KhC+dQrPw31hRkGa8fnCVTEd41GA36U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-QLr0lUKKNQ-jsgy8TKCCEA-1; Tue, 28 Jul 2020 16:00:27 -0400
X-MC-Unique: QLr0lUKKNQ-jsgy8TKCCEA-1
Received: by mail-ed1-f70.google.com with SMTP id y4so7364740edv.17
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 13:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSzFFDyUfAnXvkkVJ84iprpsx2ZHjX86onKI2woEOHU=;
        b=IJu1a9DXUXCe6Jp5KSDGqd/i++CN+QUM4MFd12Q3lHE00csd5qqmBPlg+T4+b2rwKs
         kMRIizD9NhgjlxmnY6d0ZZGjNWYX2NGBnHFUro8c5Iod8c3eJQAP7Css0nqgE6QgO7Hh
         KEhgFKxQWSVxfTZbHVcaYRMfTGdBQkRk6IlHj6GDw5EfbDQ4GAdVjxIxuyhPI8swcdKn
         n5RUk6w8CeiZFWRGoI0goZa94G21XGcm0Sd33a5IW/q6svaZsP8Okhs10QmsvKUnYXuB
         E8YyH99+cBItoWxQm2MD1G5hNWoWiLQm/jaJV0res9bIGAHvWhEZ7MOkjDoB2pNENbRm
         29RQ==
X-Gm-Message-State: AOAM533/G0O/Kf4EtJ953iZEITVaSC5htxJbDMoy+JW214TBLTy4ijDo
        82fqhrtGx5KAOube8dMyBCt8C/kTPJOi0KLPnED0ZSnFZzsCT9a9CloFiBa0hGf6DF05pycDhS9
        gbU9rn5hPPXupiCPEREoT
X-Received: by 2002:a17:906:e46:: with SMTP id q6mr25991243eji.234.1595966425300;
        Tue, 28 Jul 2020 13:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV14O9arRYB6XE8+8IFKAQO6S/91DQBaJNDTc1IjVEOlhbwsAm5kcJXeUo4rgsWkPdUP3wYw==
X-Received: by 2002:a17:906:e46:: with SMTP id q6mr25991222eji.234.1595966425063;
        Tue, 28 Jul 2020 13:00:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y22sm9846217ejf.108.2020.07.28.13.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:00:24 -0700 (PDT)
Subject: Re: [PATCH v5 07/16] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
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
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-8-hdegoede@redhat.com>
 <20200728193634.GD3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a05f24ec-3be5-42c7-38b8-69e8a3a2b330@redhat.com>
Date:   Tue, 28 Jul 2020 22:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728193634.GD3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/28/20 9:36 PM, Andy Shevchenko wrote:
> On Fri, Jul 17, 2020 at 03:37:44PM +0200, Hans de Goede wrote:
>> While looking into adding atomic-pwm support to the pwm-crc driver I
>> noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
>> there is a clock-divider which divides this with a value between 1-128,
>> and there are 256 duty-cycle steps.
>>
>> The pwm-crc code before this commit assumed that a clock-divider
>> setting of 1 means that the PWM output is running at 6 MHZ, if that
>> is true, where do these 256 duty-cycle steps come from?
>>
>> This would require an internal frequency of 256 * 6 MHz = 1.5 GHz, that
>> seems unlikely for a PMIC which is using a silicon process optimized for
>> power-switching transistors. It is way more likely that there is an 8
>> bit counter for the duty cycle which acts as an extra fixed divider
>> wrt the PWM output frequency.
>>
>> The main user of the pwm-crc driver is the i915 GPU driver which uses it
>> for backlight control. Lets compare the PWM register values set by the
>> video-BIOS (the GOP), assuming the extra fixed divider is present versus
>> the PWM frequency specified in the Video-BIOS-Tables:
>>
>> Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
>> Asus T100TA 	200			200
>> Asus T100HA 	200			200
>> Lenovo Miix 2 8	23437			20000
>> Toshiba WT8-A	23437			20000
>>
>> So as we can see if we assume the extra division by 256 then the register
>> values set by the GOP are an exact match for the VBT values, where as
>> otherwise the values would be of by a factor of 256.
>>
>> This commit fixes the period / duty_cycle calculations to take the
>> extra division by 256 into account.
> 
> So, base clock is 6MHz, then 7 bit divisor. That's what original values
> were for. On top of that there is 8-bit duty cycle control ("divide by 256"
> whatever it means) with the output range 23.437kHz..183Hz.

Right, so that range matches with a clock div of 1*256 (6 MHz/256 = 23437.5KHz)
to 128*256 (6 MHz/(128*256) = 183.1Hz) IOW this patch is correct.

Before this patch the code assumed a clkdiv of 1-128 (*), which leads to a
very different output frequency range.

Regards,

Hans


*) 0-127 really, that is fixed in a followup patch



> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Use NSEC_PER_USEC instead of adding a new (non-sensical) NSEC_PER_MHZ define
>> ---
>>   drivers/pwm/pwm-crc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
>> index 272eeb071147..c056eb9b858c 100644
>> --- a/drivers/pwm/pwm-crc.c
>> +++ b/drivers/pwm/pwm-crc.c
>> @@ -21,8 +21,8 @@
>>   
>>   #define PWM_MAX_LEVEL		0xFF
>>   
>> -#define PWM_BASE_CLK		6000000  /* 6 MHz */
>> -#define PWM_MAX_PERIOD_NS	21333    /* 46.875KHz */
>> +#define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
>> +#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
>>   
>>   /**
>>    * struct crystalcove_pwm - Crystal Cove PWM controller
>> @@ -72,7 +72,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
>>   
>>   		/* changing the clk divisor, need to disable fisrt */
>>   		crc_pwm_disable(c, pwm);
>> -		clk_div = PWM_BASE_CLK * period_ns / NSEC_PER_SEC;
>> +		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
>>   
>>   		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
>>   					clk_div | PWM_OUTPUT_ENABLE);
>> -- 
>> 2.26.2
>>
> 

