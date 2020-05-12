Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654A81CFF91
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2020 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgELUjR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 May 2020 16:39:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47495 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731204AbgELUjR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 May 2020 16:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589315955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ4CzMcj7kPytMmHh2xDynyGWXnqvMBKo+bYVaOC3mc=;
        b=hNPPWWRjc9RYsJAmognDChtoSiC6Y2wgHS1cJvDEM50i4bM8bRanSDYXSHRvGARGEy+30z
        /nbmN8hBZbP3bSV9FJEk564/I8hkUzKx/C1HGi1jeYsGTPFntqJ14M7WbmtvJAvWRk7qES
        554RacZefTXwo8r8CUJjgVE7GjQBF8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-HYissSFmMFCOZAGa2-0_qQ-1; Tue, 12 May 2020 16:39:13 -0400
X-MC-Unique: HYissSFmMFCOZAGa2-0_qQ-1
Received: by mail-wr1-f70.google.com with SMTP id 30so7475567wrq.15
        for <linux-pwm@vger.kernel.org>; Tue, 12 May 2020 13:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJ4CzMcj7kPytMmHh2xDynyGWXnqvMBKo+bYVaOC3mc=;
        b=Fue5Sjs8jK4zv9g8QqEqGJTSii570cEG76Q0AC2T3Xp7QKsocBDSkKB6gBS54qFHoB
         RF3mBfLlp11jnyEu/PlgDJJOAd1MTpC+aoOkY9Pzvtwzp5YfIeqp9/UkkpEYmp7kNTWW
         yciRILGnU7fT+0ikAJyH8yC4Pk9yGlDvUrJNj5/uNqbFDskmbocPCOnS9/WmJsrkwC+K
         eqT1Pi+hsCQzKW9k6urPg980qLYSiufknlSOHPkCRdSTjKXkFF8rCddt3m9DBTBmy70v
         jw5ps/+xXUYZW8sIWi4qaVlM/w/2QY+C3//DBT5TZ8YILn1sXw8EuqLjSZKeB03xEW1y
         82Dw==
X-Gm-Message-State: AGi0PuZ/tZr7R0wshv7qbPUd1nIxWdXrjg/7IYGdLemBj6CT1sjtRNte
        z2e9nrwTMZkZEwUii7h0/pMUlve0TU3phh8eIFQs7baM3xnVHRKZH7JkFpFS35Sw4hggd2yAEPc
        LSR6sCYt5Kg9LMbX+p08V
X-Received: by 2002:a1c:f416:: with SMTP id z22mr39270753wma.32.1589315952286;
        Tue, 12 May 2020 13:39:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypIyQ90UenVDbmKhZjTeBaYLoLs531oux0Vh9tjzCmBcWKsb4+HnTwGNdTmx5kWy5ymmk0HX0g==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr39270729wma.32.1589315951952;
        Tue, 12 May 2020 13:39:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id w15sm23346843wrl.73.2020.05.12.13.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 13:39:11 -0700 (PDT)
Subject: Re: [PATCH] pwm: lpss: Fix get_state runtime-pm reference handling
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org
References: <20200512110044.95984-1-hdegoede@redhat.com>
 <20200512190101.GF185537@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5f15f6bc-8650-d86e-893f-0d41557c57c7@redhat.com>
Date:   Tue, 12 May 2020 22:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512190101.GF185537@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 5/12/20 9:01 PM, Andy Shevchenko wrote:
> On Tue, May 12, 2020 at 01:00:44PM +0200, Hans de Goede wrote:
>> Before commit cfc4c189bc70 ("pwm: Read initial hardware state at request
>> time"), a driver's get_state callback would get called once per PWM from
>> pwmchip_add().
>>
>> pwm-lpss' runtime-pm code was relying on this, getting a runtime-pm ref for
>> PWMs which are enabled at probe time from within its get_state callback,
>> before enabling runtime-pm.
>>
>> The change to calling get_state at request time causes a number of
>> problems:
>>
>> 1. PWMs enabled at probe time may get runtime suspended before they are
>> requested, causing e.g. a LCD backlight controlled by the PWM to turn off.
>>
>> 2. When the request happens when the PWM has been runtime suspended, the
>> ctrl register will read all 1 / 0xffffffff, causing get_state to store
>> bogus values in the pwm_state.
>>
>> 3. get_state was using an async pm_runtime_get() call, because it assumed
>> that runtime-pm has not been enabled yet. If shortly after the request an
>> apply call is made, then the pwm_lpss_is_updating() check may trigger
>> because the resume triggered by the pm_runtime_get() call is not complete
>> yet, so the ctrl register still reads all 1 / 0xffffffff.
>>
>> This commit fixes these issues by moving the initial pm_runtime_get() call
>> for PWMs which are enabled at probe time to the pwm_lpss_probe() function;
>> and by making get_state take a runtime-pm ref before reading the ctrl reg.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

> One thing to consider below.
> 
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1828927
>> Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pwm/pwm-lpss.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>> index 75bbfe5f3bc2..9d965ffe66d1 100644
>> --- a/drivers/pwm/pwm-lpss.c
>> +++ b/drivers/pwm/pwm-lpss.c
>> @@ -158,7 +158,6 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	return 0;
>>   }
>>   
>> -/* This function gets called once from pwmchip_add to get the initial state */
>>   static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   			       struct pwm_state *state)
>>   {
>> @@ -167,6 +166,8 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	unsigned long long base_unit, freq, on_time_div;
>>   	u32 ctrl;
>>   
>> +	pm_runtime_get_sync(chip->dev);
>> +
>>   	base_unit_range = BIT(lpwm->info->base_unit_bits);
>>   
>>   	ctrl = pwm_lpss_read(pwm);
>> @@ -187,8 +188,7 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	state->polarity = PWM_POLARITY_NORMAL;
>>   	state->enabled = !!(ctrl & PWM_ENABLE);
>>   
>> -	if (state->enabled)
>> -		pm_runtime_get(chip->dev);
>> +	pm_runtime_put(chip->dev);
>>   }
>>   
>>   static const struct pwm_ops pwm_lpss_ops = {
>> @@ -202,7 +202,8 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>>   {
>>   	struct pwm_lpss_chip *lpwm;
>>   	unsigned long c;
>> -	int ret;
>> +	int i, ret;
>> +	u32 ctrl;
>>   
>>   	if (WARN_ON(info->npwm > MAX_PWMS))
>>   		return ERR_PTR(-ENODEV);
>> @@ -232,6 +233,12 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>>   		return ERR_PTR(ret);
>>   	}
>>   
>> +	for (i = 0; i < lpwm->info->npwm; i++) {
> 
>> +		ctrl = pwm_lpss_read(&lpwm->chip.pwms[i]);
>> +		if (ctrl & PWM_ENABLE)
> 
> I would create a helper for this as opposite to pwm_lpss_cond_enable(),
> something like pwm_lpss_is_enabled().

pwm_lpss_cond_enable() is used in multiple places, this check
we only need once, so I would prefer to just keep it as is.

Regards,

Hans




> 
>> +			pm_runtime_get(dev);
>> +	}
>> +
>>   	return lpwm;
>>   }
>>   EXPORT_SYMBOL_GPL(pwm_lpss_probe);
>> -- 
>> 2.26.0
>>
> 

