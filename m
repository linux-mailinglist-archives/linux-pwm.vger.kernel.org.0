Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E358D0B1D
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2019 11:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfJIJ1U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Oct 2019 05:27:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58290 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbfJIJ1T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Oct 2019 05:27:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DEC2228FD3C
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the last
 applied state
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20191008105417.16132-1-enric.balletbo@collabora.com>
 <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
 <4f009344-242e-19a7-6872-2c55df086044@collabora.com>
 <20191008203137.s22clq6v2om5ktio@pengutronix.de>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
Date:   Wed, 9 Oct 2019 11:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008203137.s22clq6v2om5ktio@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Adding Daniel and Lee to the discussion ...


On 8/10/19 22:31, Uwe Kleine-König wrote:
> On Tue, Oct 08, 2019 at 06:33:15PM +0200, Enric Balletbo i Serra wrote:
>> Hi Uwe,
>>
>> Thanks for the quick reply.
>>
>> On 8/10/19 16:34, Uwe Kleine-König wrote:
>>> Hello Enric,
>>>
>>> On Tue, Oct 08, 2019 at 12:54:17PM +0200, Enric Balletbo i Serra wrote:
>>>> @@ -117,17 +122,28 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
>>>>  	int ret;
>>>>  
>>>> -	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
>>>> -	if (ret < 0) {
>>>> -		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
>>>> -		return;
>>>> +	/*
>>>> +	 * As there is no way for this hardware to separate the concept of
>>>> +	 * duty cycle and enabled, but the PWM API does, let return the last
>>>> +	 * applied state when the PWM is disabled and only return the real
>>>> +	 * hardware value when the PWM is enabled. Otherwise, a user of this
>>>> +	 * driver, can get confused because won't be able to program a duty
>>>> +	 * cycle while the PWM is disabled.
>>>> +	 */
>>>> +	state->enabled = ec_pwm->state.enabled;
>>>
>>>> +	if (state->enabled) {
>>>
>>> As part of registration of the pwm .get_state is called. In this case
>>> .apply wasn't called before and so state->enabled is probably 0. So this
>>> breaks reporting the initial state ...
>>>
>>>> +		ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
>>>> +		if (ret < 0) {
>>>> +			dev_err(chip->dev, "error getting initial duty: %d\n",
>>>> +				ret);
>>>> +			return;
>>>> +		}
>>>> +		state->duty_cycle = ret;
>>>> +	} else {
>>>> +		state->duty_cycle = ec_pwm->state.duty_cycle;
>>>>  	}
>>>>  
>>>> -	state->enabled = (ret > 0);
>>>>  	state->period = EC_PWM_MAX_DUTY;
>>>> -
>>>> -	/* Note that "disabled" and "duty cycle == 0" are treated the same */
>>>> -	state->duty_cycle = ret;
>>>
>>> A few thoughts to your approach here ...:
>>>
>>>  - Would it make sense to only store duty_cycle and enabled in the
>>>    driver struct?
>>>
>>
>> Yes, in fact, my first approach (that I didn't send) was only storing enabled
>> and duty cycle. For some reason I ended storing the full pwm_state struct, but I
>> guess is not really needed.
>>
>>
>>>  - Which driver is the consumer of your pwm? If I understand correctly
>>>    the following sequence is the bad one:
>>>
>>
>> The consumer is the pwm_bl driver. Actually I'n trying to identify
>> other consumers.
> 

So far, the pwm_bl driver is the only consumer of cros-ec-pwm.

> Ah, I see why I missed to identify the problem back when I checked this
> driver. The problem is not that .duty_cycle isn't set but there .enabled
> isn't set. So maybe we just want:
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 2201b8c78641..0468c6ee4448 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -123,6 +123,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>         if (brightness > 0) {
>                 pwm_get_state(pb->pwm, &state);
>                 state.duty_cycle = compute_duty_cycle(pb, brightness);
> +               state.enabled = true;
>                 pwm_apply_state(pb->pwm, &state);
>                 pwm_backlight_power_on(pb);
>         } else
> 
> ? On a side note: It's IMHO strange that pwm_backlight_power_on
> reconfigures the PWM once more.
> 

Looking again to the pwm_bl code, now, I am not sure this is correct (although
it probably solves the problem for me).

Current behaviour is:

* If brightness > 0 and pwm_bl is disabled

   pwm_get_state(pb->pwm, &state);
   state.duty_cycle = compute_duty_cycle(pb, brightness);
   pwm_apply_state(pb->pwm, &state);
   pwm_backlight_power_on(pb);
      regulator_enable(pb->power_supply);
      state.enabled = true;
      pwm_apply_state(pb->pwm, &state);

* If brightness > 0 and pwm_bl is already enabled

   pwm_get_state(pb->pwm, &state);
   state.duty_cycle = compute_duty_cycle(pb, brightness);
   pwm_apply_state(pb->pwm, &state);

The sequence:'first' set duty_cycle and 'second' enable the PWM makes some kind
of sense because there is a regulator_enable in the middle of the power on sequence.

To work for me I need to submit state.enabled && state.duty_cycle atomically. So
I thin that solving the problem at lowlevel driver (aka cros-ec-pwm) makes more
sense. At the end, is really a problem of the lowlevel driver, and the PWM
framework is enough flexible which is fine.

Note: I did a quick look at different PWM drivers that implement .get_state()
and looks like the cros-ec-pwm is the only driver that has this restriction.

>>> 	state.period = P;
>>> 	state.duty_cycle = D;
>>> 	state.enabled = 0;
>>>    	pwm_apply_state(pwm, &state);
>>>
>>> 	...
>>>
>>> 	pwm_get_state(pwm, &state);
>>> 	state.enabled = 1;
>>>    	pwm_apply_state(pwm, &state);
>>>
>>
>> Yes that's the sequence.
>>
>>>    Before my patch there was an implicit promise in the PWM framework
>>>    that the last pwm_apply_state has .duty_cycle = D (and .period = P).
>>>    Is this worthwile, or should we instead declare this as
>>>    non-guaranteed and fix the caller?
>>>
>>
>> pwm_bl is compliant with this, the problem in the pwm-cros-ec driver is when you
>> set the duty_cycle but enable is 0.
> 
> pwm_bl *relies* on this behaviour. The question is: Is this a valid
> assumption to rely on (for consumers) resp. to guarantee (for the PWM
> framework)? I'm not sure it is because each PWM that doesn't know the
> concept of "disabled" (not sure how many there are) needs some effort to
> simulate it (by caching duty_cycle and period on disable).
> 
> Dropping this promise and fix pwm_bl (and maybe other consumers that
> rely on it) is my preferred solution.
>  
>>>  - If this is a more or less common property that hardware doesn't know
>>>    the concept of "disabled" maybe it would make sense to drop this from
>>>    the PWM framework, too. (This is a question that I discussed some
>>>    time ago already with Thierry, but without an result. The key
>>>    question is: What is the difference between "disabled" and
>>>    "duty_cycle = 0" in general and does any consumer care about it.)
>>>
>>
>> Good question, I don't really know all consumer requirements, but AFAIK, usually
>> when you want to program duty_cycle to 0 you also want to disable the PWM.
> 
> Note that hardware designers are "creative" and "disable the PWM" has
> different semantics for different PWMs. Some PWMs just stop the output
> at the level that it happens to be in, some stop in the inactive level,
> some stop at 0, some stop driving the pin. Currently the intended
> semantic of a disabled PWM is that it drives the inactive level (but it
> might be smart and stop driving if there is a pull in the right
> direction). I see no benefit of this semantic as it can also be
> accomplished by setting .duty_cycle = 0, .period = $something_small.
> Thierry doesn't agree and I fail to understand his reasoning.
> 
>> At least for the backlight case doesn't make sense program first the
>> duty_cycle and then enable the PWM, is implicit, if duty_cycle is 0
>> the PWM is disabled, if duty_cycle > 0 the PWM is enabled.
> 
> Yeah, that's my conclusion of above, too. After all the pwm_apply_state
> function is there for being able to go from one state to each other
> state with a single function call.
> 

Looking at the code again cahnged my point of view on this, see my comment above.

>>>  - A softer variant of the above: Should pwm_get_state() anticipate that
>>>    with .enabled = 0 the duty_cycle (and maybe also period) is
>>>    unreliable and cache that for callers?
>>
>> Sorry, when you say pwm_get_state(), you mean the core call or the lowlevel
>> driver call?
> 
> The suggestion is to do what you do in the driver (i.e. remember
> duty_cycle and in the general case also period) in the framework
> instead and fix the problem for all lowlevel drivers that behave similar
> to the implementation in question. i.e. don't rely on .duty_cycle and
> .period having a sensible value after .get_state() if the PWM is off.
> This is IMHO the second best option.
> 
> Best regards
> Uwe
> 
