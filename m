Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4A231311
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgG1Ttm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 15:49:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33498 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728186AbgG1Ttm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 15:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595965780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGvTzT8NM7IHgswr1ardDnnF8Kc5Lio2kQPzsmWgHR8=;
        b=B8CmtYfEc94X1H0UxG5Hp74e+NQSHc4X8+dRUL36we3aBRIJeQP/+0BQp47OZWlHuwrBd6
        0QxnHlEMH4robhwxS5+BGKCX6jMswLOZZ9bEPL6wYWtEdxn5yrqsBG1/20kZff/dBx53f3
        Xp2Z+77lBFT80YBM0lIZcGtPL6KI8xM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-ssXWWNZzP1qAZh5mLrqscQ-1; Tue, 28 Jul 2020 15:49:38 -0400
X-MC-Unique: ssXWWNZzP1qAZh5mLrqscQ-1
Received: by mail-ed1-f70.google.com with SMTP id w19so7464093edx.0
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 12:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qGvTzT8NM7IHgswr1ardDnnF8Kc5Lio2kQPzsmWgHR8=;
        b=DPp1Mo8LFWUkYyjFug2ilm0z/FKOHWVbbyWuR7DEtqgS/PtviNtsqM7zdFhiAd2hhB
         uL+J74ydzTbmapHYnfw6qYA1axizK9c7JOOh4gtSDtmz//h4R1/jnmGnxtICrHkrka3I
         7AjajlVp+556gIW1nhksCTvzr1DOTIMYXipQee2nlSJkbFT11ZT8pRzgLxnlHYzM5PB0
         FGShk+X5LCAd9BhlTv+sfppANNPysXowwI0Txw/AJ4whhrebi27eCeEvqDRK+v8YiTQq
         u1zFT1hC/g52BAhOKXf7sBtnENhwp3qiGWYyX4+Ch/Ehkvzz5Oc8M8HmBc1sjOqr0w77
         Jktg==
X-Gm-Message-State: AOAM531zZj+SeEucYSaBzIxTcu9vpQqsZgRH2QJRm7bjOjTnwpN7ybAB
        kQu7VD5BUPY2k1/0APhQlv8UH/JBHAGRmEzYonWfA6t74SO1nTMY76RcwtrRzY7UFGqT000af7b
        v83+1ELZHe32MuL7ksrre
X-Received: by 2002:a17:906:2816:: with SMTP id r22mr3236525ejc.215.1595965777423;
        Tue, 28 Jul 2020 12:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyST52qxA4L/r7rRNNQhsCVnQBD9xfOfW4Zv8ngTpgqQ7I6PmsbCzOTgI7uEiR84fie460aPA==
X-Received: by 2002:a17:906:2816:: with SMTP id r22mr3236509ejc.215.1595965777212;
        Tue, 28 Jul 2020 12:49:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id yj16sm9921523ejb.122.2020.07.28.12.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 12:49:36 -0700 (PDT)
Subject: Re: [PATCH v5 05/16] pwm: lpss: Add pwm_lpss_prepare_enable() helper
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
 <20200717133753.127282-6-hdegoede@redhat.com>
 <20200728184553.GZ3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e4517382-b294-c7ab-b587-21ed67b5dde9@redhat.com>
Date:   Tue, 28 Jul 2020 21:49:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728184553.GZ3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/28/20 8:45 PM, Andy Shevchenko wrote:
> On Fri, Jul 17, 2020 at 03:37:42PM +0200, Hans de Goede wrote:
>> In the not-enabled -> enabled path pwm_lpss_apply() needs to get a
>> runtime-pm reference; and then on any errors it needs to release it
>> again.
>>
>> This leads to somewhat hard to read code. This commit introduces a new
>> pwm_lpss_prepare_enable() helper and moves all the steps necessary for
>> the not-enabled -> enabled transition there, so that we can error check
>> the entire transition in a single place and only have one pm_runtime_put()
>> on failure call site.
>>
>> While working on this I noticed that the enabled -> enabled (update
>> settings) path was quite similar, so I've added an enable parameter to
>> the new pwm_lpss_prepare_enable() helper, which allows using it in that
>> path too.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> But see below.
> 
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pwm/pwm-lpss.c | 45 ++++++++++++++++++++++++------------------
>>   1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>> index da9bc3d10104..8a136ba2a583 100644
>> --- a/drivers/pwm/pwm-lpss.c
>> +++ b/drivers/pwm/pwm-lpss.c
>> @@ -122,41 +122,48 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
>>   		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
>>   }
>>   
>> +static int pwm_lpss_prepare_enable(struct pwm_lpss_chip *lpwm,
>> +				   struct pwm_device *pwm,
>> +				   const struct pwm_state *state,
>> +				   bool enable)
>> +{
>> +	int ret;
>> +
>> +	ret = pwm_lpss_is_updating(pwm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>> +	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == false);
>> +	ret = pwm_lpss_wait_for_update(pwm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == true);
>> +	return 0;
>> +}
>> +
>>   static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   			  const struct pwm_state *state)
>>   {
>>   	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>> -	int ret;
> 
>> +	int ret = 0;
> 
> We can avoid this change...
> 
>>   	if (state->enabled) {
>>   		if (!pwm_is_enabled(pwm)) {
>>   			pm_runtime_get_sync(chip->dev);
>> -			ret = pwm_lpss_is_updating(pwm);
>> -			if (ret) {
>> -				pm_runtime_put(chip->dev);
>> -				return ret;
>> -			}
>> -			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>> -			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
>> -			ret = pwm_lpss_wait_for_update(pwm);
>> -			if (ret) {
>> +			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
>> +			if (ret)
>>   				pm_runtime_put(chip->dev);
>> -				return ret;
>> -			}
>> -			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
>>   		} else {
>> -			ret = pwm_lpss_is_updating(pwm);
>> -			if (ret)
>> -				return ret;
>> -			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>> -			return pwm_lpss_wait_for_update(pwm);
> 
>> +			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);
> 
> ...by simple return directly from here. But I admit I haven't seen the next patch yet.

True, but I'm not a big fan of earlier returns except for errors.

Regards,

Hans


> 
>>   		}
>>   	} else if (pwm_is_enabled(pwm)) {
>>   		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
>>   		pm_runtime_put(chip->dev);
>>   	}
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> -- 
>> 2.26.2
>>
> 

