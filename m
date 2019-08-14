Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F198D599
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfHNOHY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 10:07:24 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:54974 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfHNOHY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 14 Aug 2019 10:07:24 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id AEBD0A5445;
        Wed, 14 Aug 2019 16:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1565791641;
        bh=1KDHAEVLeAzyxuvhgFrcUkQxVky/Kb+EijlReZ8Th8c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HJsqsAdgoV9M7OsXgAlii8PY6K04J108K92He7M7VcpjCx43lCav0h3ml00nZddSk
         AsfHxuCop3jZpKzQacqSh6lE2m9TkF/HmRmoAwvlujC8XOJ9ZUEhvGGq719EMah3v3
         koBxTWngpxIcYHI0DCxXEuB0cTuDUHFOxrLtxbLs=
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
 <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
 <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <3181509c-a167-28c8-fb8b-947b7c72a65c@ysoft.com>
Date:   Wed, 14 Aug 2019 16:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 14. 08. 19 11:23, Uwe Kleine-König wrote:
> Hello Baolin,
> 
> On Wed, Aug 14, 2019 at 04:42:28PM +0800, Baolin Wang wrote:
>> On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-König
>> <u.kleine-koenig@pengutronix.de> wrote:
>>> On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
>>> [...]
>> Not really, our hardware's method is, when you changed a new
>> configuration (MOD or duty is changed) , the hardware will wait for a
>> while to complete current period, then change to the new period.
> 
> Can you describe that in more detail? This doesn't explain why MOD must be
> configured before DUTY. Is there another reason for that?
> 
>>>> +static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>> +                       struct pwm_state *state)
>>>> +{
>>>> +     struct sprd_pwm_chip *spc =
>>>> +             container_of(chip, struct sprd_pwm_chip, chip);
>>>> +     struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
>>>> +     struct pwm_state cstate;
>>>> +     int ret;
>>>> +
>>>> +     pwm_get_state(pwm, &cstate);
>>>
>>> I don't like it when pwm drivers call pwm_get_state(). If ever
>>> pwm_get_state would take a lock, this would deadlock as the lock is
>>> probably already taken when your .apply() callback is running. Moreover
>>> the (expensive) calculations are not used appropriately. See below.
>>
>> I do not think so, see:
>>
>> static inline void pwm_get_state(const struct pwm_device *pwm, struct
>> pwm_state *state)
>> {
>>          *state = pwm->state;
>> }
> 
> OK, the PWM framework currently caches this for you. Still I would
> prefer if you didn't call PWM API functions in your lowlevel driver.
> There is (up to now) nothing bad that will happen if you do it anyhow,
> but when the PWM framework evolves it might (and I want to work on such
> an evolution). You must not call clk_get_rate() in a .set_rate()
> callback of a clock either.
>   
>>>> +     if (state->enabled) {
>>>> +             if (!cstate.enabled) {
>>>
>>> To just know the value of cstate.enabled you only need to read the
>>> register with the ENABLE flag. That is cheaper than calling get_state.
>>>
>>>> +                     /*
>>>> +                      * The clocks to PWM channel has to be enabled first
>>>> +                      * before writing to the registers.
>>>> +                      */
>>>> +                     ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS,
>>>> +                                                   chn->clks);
>>>> +                     if (ret) {
>>>> +                             dev_err(spc->dev,
>>>> +                                     "failed to enable pwm%u clocks\n",
>>>> +                                     pwm->hwpwm);
>>>> +                             return ret;
>>>> +                     }
>>>> +             }
>>>> +
>>>> +             if (state->period != cstate.period ||
>>>> +                 state->duty_cycle != cstate.duty_cycle) {
>>>
>>> This is a coarse check. If state->period and cstate.period only differ
>>> by one calling sprd_pwm_config(spc, pwm, state->duty_cycle,
>>> state->period) probably results in a noop. So you're doing an expensive
>>> division to get an unreliable check. It would be better to calculate the
>>> register values from the requested state and compare the register
>>> values. The costs are more or less the same than calling .get_state and
>>> the check is reliable. And you don't need to spend another division to
>>> calculate the new register values.
>>
>> Same as above comment.
> 
> When taking the caching into account (which I wouldn't) the check is
> still incomplete. OK, you could argue avoiding the recalculation in 90%
> (to just say some number) of the cases where it is unnecessary is good.
>   
>>>
>>>> +                     ret = sprd_pwm_config(spc, pwm, state->duty_cycle,
>>>> +                                           state->period);
>>>> +                     if (ret)
>>>> +                             return ret;
>>>> +             }
>>>> +
>>>> +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
>>>> +     } else if (cstate.enabled) {
>>>> +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 0);
>>>> +
>>>> +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
>>>
>>> Assuming writing SPRD_PWM_ENABLE = 0 to the hardware completes the
>>> currently running period and the write doesn't block that long: Does
>>> disabling the clocks interfere with completing the period?
>>
>> Writing SPRD_PWM_ENABLE = 0 will stop the PWM immediately, will not
>> waiting for completing the currently period.
> 
> The currently active period is supposed to be completed. If you cannot
> implement this please point this out as limitation at the top of the
> driver.
> 
> Honestly I think most pwm users won't mind and they should get the
> possibility to tell they prefer pwm_apply_state to return immediately
> even if this could result in a spike. But we're not there yet.
> (Actually there are three things a PWM consumer might want:
> 
>   a) stop immediately;
>   b) complete the currently running period, then stop and return only
>      when the period is completed; or
>   c) complete the currently running period and then stop, return immediately if
>      possible.
> 
> Currently the expected semantic is b).

Hi Uwe et all,

I am sorry for interrupting your discussion. From my (last year or so)
observation of the PWM mailing list I see this as a common pattern in
almost every submission of a new PWM driver. That is PWM driver authors
keep submitting solution a) and you tell them the expected behavior
is b).

Why is that? I hope that the fact that implementing a) is simpler
than b) is not the main reason. I believe that people think a)
is the correct solution.

I agree that smooth transition from one period/duty setting to
different setting makes sense. But I also believe the expected
behavior of setting enabled=0 is different. That is to stop
immediately the technology that is fed by the PWM signal.
Otherwise the concept of enabled/disabled does not make sense
because setting duty=0 would have the same effect.

So I still wonder where the expectation for b) is coming from.
What would be the physical/electrical reasoning for b)?
Why/how it can be dangerous/harmful for any device to stop the
PWM signal immediately?

Would be great to finally reach consensus on that so the expected
behavior can be documented. I know you already attempted that [1].
I think you have done a great job but I still consider the part
about state changes little controversial and unresolved.

Best regards,
Michal

[1] http://patchwork.ozlabs.org/patch/1021566/

