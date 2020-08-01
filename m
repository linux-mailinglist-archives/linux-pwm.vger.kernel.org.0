Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0518E2352BE
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Aug 2020 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHAOdf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Aug 2020 10:33:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34927 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725778AbgHAOde (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Aug 2020 10:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596292412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AffMbTZZ0aELZ/3Ad5ZjJ2PXQeVzg4uG2LtDDO4mtY=;
        b=hxYDiAwhEt+XENd//q8AvuCUzkiKO76gX2xfwB8k17kor/xpkbZQu+WF8VQjQNhdMcm33t
        VSa4ojS9L65UkXrvxwPHuPhl9YUbEwfANNVD20D1+jqXbVFDL3lT+r0YCRtKl19uTBmizj
        0BKeHrVy+0o4N+zUgHiEPyYlHfAanFY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-GP1QS09rNFOKUtuwDKBfyA-1; Sat, 01 Aug 2020 10:33:30 -0400
X-MC-Unique: GP1QS09rNFOKUtuwDKBfyA-1
Received: by mail-ed1-f72.google.com with SMTP id u3so6668981edx.18
        for <linux-pwm@vger.kernel.org>; Sat, 01 Aug 2020 07:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2AffMbTZZ0aELZ/3Ad5ZjJ2PXQeVzg4uG2LtDDO4mtY=;
        b=geiYZAYu5tusDBrkpuYnqvyHb5flFRJaicS6kLGsJztIm4ObbTi+wTdJ5BedA8EcER
         TWURYMIOP6NNxdD0nKjc2AhRCvvQXQm4ET3S1Ej1jTwGDzbexWBkpXkkTZzIYWFDReCa
         XbTvD08xAK5GZTCG2mmNp/iXayb7NLHK4+qaeovzWC0iVwXr9adAdc96M5cusbNL3NvD
         D0wLynvRO4192JExfW1S/ZdmQChfFT+gKH7/4BwIIXa03Bn6kNWryp39uR/1LGfRZ1xl
         BNmJ+E1Z0NLWFyy9jKP1KezkTXO93u9WsfIO7ZwPb12c0vTduRwY/Fh9eHfuFueEbAOS
         V1ig==
X-Gm-Message-State: AOAM531azaqr6Qn9+6QTwSgDin1se+yjJw1USJ2iEVuYnam7VHOEUWvG
        Y14Nrwq4Nj+8YN4GJ9xdr68myhi8jwXPcKQ1hFRgIekhS9YNDwiqZfPmWS7pq+jGL5o/MbNC3Wo
        cNeewnhe4tYDE4nE9yykL
X-Received: by 2002:a50:935a:: with SMTP id n26mr8506283eda.107.1596292409535;
        Sat, 01 Aug 2020 07:33:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIr5NWOJG+AluNDTd4Hf+xtn0Jb6y6EJa9qUrFaYzrqWOWWUlJfVdGJJvxCEXcVp1kWgRzbA==
X-Received: by 2002:a50:935a:: with SMTP id n26mr8506264eda.107.1596292409213;
        Sat, 01 Aug 2020 07:33:29 -0700 (PDT)
Received: from x1.localdomain ([109.38.137.213])
        by smtp.gmail.com with ESMTPSA id ce12sm11849828edb.4.2020.08.01.07.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 07:33:28 -0700 (PDT)
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 <20200727074120.GB2781612@ulmo> <20200729082305.GK3703480@smile.fi.intel.com>
 <b87c535a-022f-2894-1e38-5be035c6fbfc@redhat.com>
 <20200730092650.GA4077384@ulmo>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <36891235-95ef-5ac7-cb56-77b548d77778@redhat.com>
Date:   Sat, 1 Aug 2020 16:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730092650.GA4077384@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On 7/30/20 11:26 AM, Thierry Reding wrote:
> On Wed, Jul 29, 2020 at 11:32:28AM +0200, Hans de Goede wrote:
>> cHi,
>>
>> On 7/29/20 10:23 AM, Andy Shevchenko wrote:
>>> On Mon, Jul 27, 2020 at 09:41:20AM +0200, Thierry Reding wrote:
>>>> On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:
>>>
>>>> I've applied patches 3 through 12 to the PWM tree. I thought it was a
>>>> bit odd that only a handful of these patches had been reviewed and there
>>>> were no Tested-bys, but I'm going to trust that you know what you're
>>>> doing. =) If this breaks things for anyone I'm sure they'll complain.
>>
>> Thank you for picking up these patches, but ...
>>
>>> Can we postpone a bit?
>>
>> I have to agree with Andy here, as mentioned my plan was to push the
>> entire series through drm-intel-next-queued once the last few PWM
>> patches are reviewed.
>>
>> There are some fixes, to the pwm-crc driver which change behavior in
>> a possibly undesirable way, unless combined with the i915 changes.
>>
>> E.g. there is a fix which makes the pwm-crc driver actually honor
>> the requested output frequency (it was not doing this due to a bug)
>> and before the i915 changes, the i915 driver was hardcoding an output
>> freq, rather then looking at the video-bios-tables as it should.
>>
>> So having just the pwm-crc fix, will change the output frequency
>> which some LCD panels might not like.
>>
>> Note things are probably fine with the hardcoded output freq, but I
>> would like to play it safe here.
>>
>> Also Andy was still reviewing some of the PWM patches, and has requested
>> changes to 1 patch, nothing functional just some code-reshuffling for
>> cleaner code, so we could alternatively fix this up with a follow-up patch.
>>
>> Either way please let us know how you want to proceed.
> 
> Okay, that's fine, I'll drop them again.

Great, thank you.

>>>> That said I see that Rafael has acked patches 1-2 and Jani did so for
>>>> patches 13-16. I'm not sure if you expect me to pick those patches up as
>>>> well. As far as I can tell the ACPI, PWM and DRM parts are all
>>>> independent, so these patches could be applied to the corresponding
>>>> subsystem trees.
>>>>
>>>> Anyway, if you want me to pick those all up into the PWM tree, I suppose
>>>> that's something I can do as well.
>>
>> drm-intel-next-queued is usually seeing quite a bit of churn, so the i915
>> patches really should go upstream through that branch.
> 
> During my build tests I ran into a small issue caused by this series
> interacting with the conversion of period and duty-cycle to u64 that
> I've queued for v5.9. This causes a build failure on x86.
> 
> I have this local diff to fix that:
> 
> --- >8 ---
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 370ab826a20b..92e838797733 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -76,7 +76,9 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   
>   	if (pwm_get_duty_cycle(pwm) != state->duty_cycle ||
>   	    pwm_get_period(pwm) != state->period) {
> -		int level = state->duty_cycle * PWM_MAX_LEVEL / state->period;
> +		u64 level = state->duty_cycle * PWM_MAX_LEVEL;
> +
> +		do_div(level, state->period);
>   
>   		err = regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
>   		if (err) {
> @@ -141,10 +143,9 @@ static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   
>   	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
>   
> -	state->period =
> -		DIV_ROUND_UP(clk_div * NSEC_PER_USEC * 256, PWM_BASE_CLK_MHZ);
> -	state->duty_cycle =
> -		DIV_ROUND_UP(duty_cycle_reg * state->period, PWM_MAX_LEVEL);
> +	state->period = DIV_ROUND_UP(clk_div * NSEC_PER_USEC * 256, PWM_BASE_CLK_MHZ);
> +	state->duty_cycle = duty_cycle_reg * state->period + PWM_MAX_LEVEL - 1;
> +	do_div(state->duty_cycle, PWM_MAX_LEVEL);
>   	state->polarity = PWM_POLARITY_NORMAL;
>   	state->enabled = !!(clk_div_reg & PWM_OUTPUT_ENABLE);
>   }
> --- >8 ---
> 
> So perhaps you want to integrate that or something equivalent into your
> series.

Ack, thank you for letting me know.

> Also this could result in a tricky dependency between PWM and drm-misc,
> although if you're targetting drm-misc it's too late for v5.9 anyway. In
> that case you should be able to rebase your series on v5.9-rc1 when it's
> out and then you'll get the prerequisite PWM changes for the u64
> conversion as part of that. No need to track the dependency explicitly.

Right, I agree that this is too late for this cycle, so I will rebase it
on top of v5.9-rc1 once that is out, making sure to take the u64 changes
into account.

As said my plan is to merge this all through the drm tree, the assumption
there was that the pwm-crc and pwm-lpss drivers normally do not see a whole
lot of chsnges. Rebasing on top of 5.9-rc1 should take care of the u64
changes. So unless there are more pwm-core changes planned for the 5.10
cycle, I would like to queue this in the drm-intel tree for 5.10.
By thta time Andy and I should have also wrapped up the review process
(it is as good as wrapped up now already).

Thierry, is merging these through the drm-intel tree for 5.10 ok with
you? And if this is ok with you may I add your Acked-by to the PWM
patches to indicate this ?

Regards,

Hans


