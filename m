Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2321A123
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGINsS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 09:48:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726340AbgGINsS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 09:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594302497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZs9AErY+eQgpCGxcTsul8XzFzR2Qfr+Xb/wqEYukpw=;
        b=eELWqoGsdfhV4D36rD6Uao4WoImME9c/AXHlJL78GaUvgDOV9CIcS5WBzCKiw10TI6BGMF
        JhMmXNAiCd3Ygsr9h08gGFDuSTQo3z4FxLpTsW/hmy837qs32DY6tzSRgoxuwQPfDZI0ip
        yvlAoKxfeI75Z7FBjYYXGS5TTCWajJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-gT5ItSxUPROyJRNedTKYLQ-1; Thu, 09 Jul 2020 09:48:15 -0400
X-MC-Unique: gT5ItSxUPROyJRNedTKYLQ-1
Received: by mail-wm1-f70.google.com with SMTP id y204so2218559wmd.2
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2020 06:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZs9AErY+eQgpCGxcTsul8XzFzR2Qfr+Xb/wqEYukpw=;
        b=HkEVshAGXRFppBjb755oajcloqtSfexZtgkxUoJ3LiPRDZ5lvhXyQm2JFdntKeRFLk
         t6L1QfZDlpQ2d7jCU9PVpwLvI31WRs9j382x44FG/DZ2V3MEYtQQsb6GtEwrjDlifZ6r
         R6RXWzdATOobJb5GIKgu9YJ3Un20gWwOc+R5C2FubIbRg4E4L+hMFdVal2JDqyy2NJ4R
         1xxwNB3nj01pQhn4Mhc4xC5A8fmYv/R4YVHfKkGVrSSuDZ5vv1OyzcrJDyvT26PhMGR5
         iCtN22zMbbxzU3LY7j8+uihtWbTcm/W7HYs+wzeuTDQzibbLOkayJ1CPTidw6+UCnu7r
         4XPQ==
X-Gm-Message-State: AOAM5332DmrDs8B+1ACmKQ6HTgGUWlISq03CmKYhDQJzE3SNk8lW0839
        s3w/5bKThM/SBIUOMUKa860LYeO42QzPDppNaz3vK8sjiXj1wNLsC0QUzcjnidjaPIWPshKNcnr
        eQJ1Ct2a3nJkzEAyjDFlZ
X-Received: by 2002:a1c:449:: with SMTP id 70mr44231wme.149.1594302494647;
        Thu, 09 Jul 2020 06:48:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuuC+JM9A1gKl2XR85+WZwwYVCoVivUZyp1H46ayENTaqORebNvPr++i1WNeaEEEcapYMsTg==
X-Received: by 2002:a1c:449:: with SMTP id 70mr44190wme.149.1594302494345;
        Thu, 09 Jul 2020 06:48:14 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id v12sm5532702wrt.31.2020.07.09.06.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:48:13 -0700 (PDT)
Subject: Re: [PATCH v4 05/16] pwm: lpss: Use pwm_lpss_apply() when restoring
 state on resume
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
 <20200708211432.28612-6-hdegoede@redhat.com>
 <20200709133609.GY3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a003c79c-abe5-b812-1da8-3e67bfc31eb3@redhat.com>
Date:   Thu, 9 Jul 2020 15:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709133609.GY3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/9/20 3:36 PM, Andy Shevchenko wrote:
> On Wed, Jul 08, 2020 at 11:14:21PM +0200, Hans de Goede wrote:
>> Before this commit a suspend + resume of the LPSS PWM controller
>> would result in the controller being reset to its defaults of
>> output-freq = clock/256, duty-cycle=100%, until someone changes
>> to the output-freq and/or duty-cycle are made.
>>
>> This problem has been masked so far because the main consumer
>> (the i915 driver) was always making duty-cycle changes on resume.
>> With the conversion of the i915 driver to the atomic PWM API the
>> driver now only disables/enables the PWM on suspend/resume leaving
>> the output-freq and duty as is, triggering this problem.
>>
>> The LPSS PWM controller has a mechanism where the ctrl register value
>> and the actual base-unit and on-time-div values used are latched. When
>> software sets the SW_UPDATE bit then at the end of the current PWM cycle,
>> the new values from the ctrl-register will be latched into the actual
>> registers, and the SW_UPDATE bit will be cleared.
>>
>> The problem is that before this commit our suspend/resume handling
>> consisted of simply saving the PWM ctrl register on suspend and
>> restoring it on resume, without setting the PWM_SW_UPDATE bit.
>> When the controller has lost its state over a suspend/resume and thus
>> has been reset to the defaults, just restoring the register is not
>> enough. We must also set the SW_UPDATE bit to tell the controller to
>> latch the restored values into the actual registers.
>>
>> Fixing this problem is not as simple as just or-ing in the value which
>> is being restored with SW_UPDATE. If the PWM was enabled before we must
>> write the new settings + PWM_SW_UPDATE before setting PWM_ENABLE.
>> We must also wait for PWM_SW_UPDATE to become 0 again and depending on the
>> model we must do this either before or after the setting of PWM_ENABLE.
>>
>> All the necessary logic for doing this is already present inside
>> pwm_lpss_apply(), so instead of duplicating this inside the resume
>> handler, this commit makes the resume handler use pwm_lpss_apply() to
>> restore the settings when necessary. This fixes the output-freq and
>> duty-cycle being reset to their defaults on resume.
> 
> ...
> 
>> +static int __pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			    const struct pwm_state *state, bool from_resume)
>>   {
>>   	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>>   	int ret;
>>   
>>   	if (state->enabled) {
>>   		if (!pwm_is_enabled(pwm)) {
>> -			pm_runtime_get_sync(chip->dev);
>> +			if (!from_resume)
>> +				pm_runtime_get_sync(chip->dev);
>> +
>>   			ret = pwm_lpss_is_updating(pwm);
>>   			if (ret) {
>> -				pm_runtime_put(chip->dev);
>> +				if (!from_resume)
>> +					pm_runtime_put(chip->dev);
>> +
>>   				return ret;
>>   			}
>>   			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>>   			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
>>   			ret = pwm_lpss_wait_for_update(pwm);
>>   			if (ret) {
>> -				pm_runtime_put(chip->dev);
>> +				if (!from_resume)
>> +					pm_runtime_put(chip->dev);
>> +
>>   				return ret;
>>   			}
>>   			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
> 
>>   		}
>>   	} else if (pwm_is_enabled(pwm)) {
>>   		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
>> -		pm_runtime_put(chip->dev);
>> +
>> +		if (!from_resume)
>> +			pm_runtime_put(chip->dev);
>>   	}
> 
> I'm wondering if splitting more will make this look better, like:
> 
> 	...
> 	if (from_resume) {
> 		ret = pwm_lpss_prepare_enable(...); // whatever name you think suits better
> 	} else {
> 		pm_runtime_get_sync(...);
> 		ret = pwm_lpss_prepare_enable(...);
> 		if (ret)
> 			pm_runtime_put(...);
> 	}
> 	...
> 

That is a good idea, I like it. We already had multiple pm_runtime_put() calls
before for the error handlig and this patch did not make it any better.

So adding a pwm_lpss_prepare_enable() helper (the name works for)
will also cleanup the original code. I will add this helper as
a separate preparation patch for this one in v5 of the patch-set.

Regards,

Hans

