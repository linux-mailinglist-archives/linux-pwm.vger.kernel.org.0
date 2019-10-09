Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1DD0CAA
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2019 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJIKTp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Oct 2019 06:19:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58898 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIKTo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Oct 2019 06:19:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3236C28F6C7
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the last
 applied state
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
References: <20191008105417.16132-1-enric.balletbo@collabora.com>
 <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
 <4f009344-242e-19a7-6872-2c55df086044@collabora.com>
 <20191008203137.s22clq6v2om5ktio@pengutronix.de>
 <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
 <20191009095635.yysr33lnwldicyng@holly.lan>
 <20191009101637.gmvghwdvcmfw4yyk@pengutronix.de>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2b24df87-10fb-f590-3643-ffca5f180f5d@collabora.com>
Date:   Wed, 9 Oct 2019 12:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009101637.gmvghwdvcmfw4yyk@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 9/10/19 12:16, Uwe Kleine-König wrote:
> On Wed, Oct 09, 2019 at 10:56:35AM +0100, Daniel Thompson wrote:
>> On Wed, Oct 09, 2019 at 11:27:13AM +0200, Enric Balletbo i Serra wrote:
>>> Hi Uwe,
>>>
>>> Adding Daniel and Lee to the discussion ...
>>
>> Thanks!
>>
>>> On 8/10/19 22:31, Uwe Kleine-König wrote:
>>>> On Tue, Oct 08, 2019 at 06:33:15PM +0200, Enric Balletbo i Serra wrote:
>>>>>> A few thoughts to your approach here ...:
>>>>>>
>>>>>>  - Would it make sense to only store duty_cycle and enabled in the
>>>>>>    driver struct?
>>>>>>
>>>>>
>>>>> Yes, in fact, my first approach (that I didn't send) was only storing enabled
>>>>> and duty cycle. For some reason I ended storing the full pwm_state struct, but I
>>>>> guess is not really needed.
>>>>>
>>>>>
>>>>>>  - Which driver is the consumer of your pwm? If I understand correctly
>>>>>>    the following sequence is the bad one:
>>>>>>
>>>>>
>>>>> The consumer is the pwm_bl driver. Actually I'n trying to identify
>>>>> other consumers.
>>>>
>>>
>>> So far, the pwm_bl driver is the only consumer of cros-ec-pwm.
>>>
>>>> Ah, I see why I missed to identify the problem back when I checked this
>>>> driver. The problem is not that .duty_cycle isn't set but there .enabled
>>>> isn't set. So maybe we just want:
>>>>
>>>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>>>> index 2201b8c78641..0468c6ee4448 100644
>>>> --- a/drivers/video/backlight/pwm_bl.c
>>>> +++ b/drivers/video/backlight/pwm_bl.c
>>>> @@ -123,6 +123,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>>>>         if (brightness > 0) {
>>>>                 pwm_get_state(pb->pwm, &state);
>>>>                 state.duty_cycle = compute_duty_cycle(pb, brightness);
>>>> +               state.enabled = true;
>>>>                 pwm_apply_state(pb->pwm, &state);
>>>>                 pwm_backlight_power_on(pb);
>>>>         } else
>>>>
>>>> ? On a side note: It's IMHO strange that pwm_backlight_power_on
>>>> reconfigures the PWM once more.
>>>>
>>>
>>> Looking again to the pwm_bl code, now, I am not sure this is correct (although
>>> it probably solves the problem for me).
>>
>> Looking at the pwm_bl code I wouldn't accept the above as it is but I'd
>> almost certainly accept a patch to pwm_bl to move the PWM enable/disable
>> out of both the power on/off functions so the duty-cycle/enable or
>> disable can happen in one go within the update_status function. I don't
>> think such a change would interfere with the power and enable sequencing
>> needed by panels and it would therefore be a nice continuation of the
>> work to convert over to the pwm_apply_state() API.
> 
> OK for me. Enric, do you care enough to come up with a patch for pwm_bl?
> I'd expect that this alone should already fix your issue.
>  

Yes, I'll work on a proposal and send. Thanks you all.

Regards,
 Enric

>> None of the above has anything to do with what is right or wrong for
>> the PWM API evolution. Of course, if this thread does conclude that it
>> is OK the duty cycle of a disabled PWM to be retained for some drivers
>> and not others then I'd hope to see some WARN_ON()s added to the PWM
>> framework to help bring problems to the surface with all drivers.
> 
> I think it's not possible to add a reliable WARN_ON for that issue. It
> is quite expected that .get_state returns something that doesn't
> completely match the requested configuration. So if a consumer requests
> 
> 	.duty_cycle = 1
> 	.period = 100000000
> 	.enabled = false
> 
> pwm_get_state possibly returns .duty_cycle = 0 even for drivers/hardware
> that has a concept of duty_cycle for disabled hardware.
> 
> A bit this is addressed in https://patchwork.ozlabs.org/patch/1147517/.
> 
> Best regards
> Uwe
> 
