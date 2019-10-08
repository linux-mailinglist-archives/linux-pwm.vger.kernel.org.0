Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2DECFEF6
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2019 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfJHQdV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 12:33:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48474 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJHQdV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 12:33:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C352228FC0D
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the last
 applied state
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org
References: <20191008105417.16132-1-enric.balletbo@collabora.com>
 <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <4f009344-242e-19a7-6872-2c55df086044@collabora.com>
Date:   Tue, 8 Oct 2019 18:33:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the quick reply.

On 8/10/19 16:34, Uwe Kleine-König wrote:
> Hello Enric,
> 
> On Tue, Oct 08, 2019 at 12:54:17PM +0200, Enric Balletbo i Serra wrote:
>> @@ -117,17 +122,28 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
>>  	int ret;
>>  
>> -	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
>> -	if (ret < 0) {
>> -		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
>> -		return;
>> +	/*
>> +	 * As there is no way for this hardware to separate the concept of
>> +	 * duty cycle and enabled, but the PWM API does, let return the last
>> +	 * applied state when the PWM is disabled and only return the real
>> +	 * hardware value when the PWM is enabled. Otherwise, a user of this
>> +	 * driver, can get confused because won't be able to program a duty
>> +	 * cycle while the PWM is disabled.
>> +	 */
>> +	state->enabled = ec_pwm->state.enabled;
> 
>> +	if (state->enabled) {
> 
> As part of registration of the pwm .get_state is called. In this case
> .apply wasn't called before and so state->enabled is probably 0. So this
> breaks reporting the initial state ...
> 
>> +		ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
>> +		if (ret < 0) {
>> +			dev_err(chip->dev, "error getting initial duty: %d\n",
>> +				ret);
>> +			return;
>> +		}
>> +		state->duty_cycle = ret;
>> +	} else {
>> +		state->duty_cycle = ec_pwm->state.duty_cycle;
>>  	}
>>  
>> -	state->enabled = (ret > 0);
>>  	state->period = EC_PWM_MAX_DUTY;
>> -
>> -	/* Note that "disabled" and "duty cycle == 0" are treated the same */
>> -	state->duty_cycle = ret;
> 
> A few thoughts to your approach here ...:
> 
>  - Would it make sense to only store duty_cycle and enabled in the
>    driver struct?
> 

Yes, in fact, my first approach (that I didn't send) was only storing enabled
and duty cycle. For some reason I ended storing the full pwm_state struct, but I
guess is not really needed.


>  - Which driver is the consumer of your pwm? If I understand correctly
>    the following sequence is the bad one:
> 

The consumer is the pwm_bl driver. Actually I'n trying to identify other consumers.

> 	state.period = P;
> 	state.duty_cycle = D;
> 	state.enabled = 0;
>    	pwm_apply_state(pwm, &state);
> 
> 	...
> 
> 	pwm_get_state(pwm, &state);
> 	state.enabled = 1;
>    	pwm_apply_state(pwm, &state);
> 

Yes that's the sequence.

>    Before my patch there was an implicit promise in the PWM framework
>    that the last pwm_apply_state has .duty_cycle = D (and .period = P).
>    Is this worthwile, or should we instead declare this as
>    non-guaranteed and fix the caller?
> 

pwm_bl is compliant with this, the problem in the pwm-cros-ec driver is when you
set the duty_cycle but enable is 0.

>  - If this is a more or less common property that hardware doesn't know
>    the concept of "disabled" maybe it would make sense to drop this from
>    the PWM framework, too. (This is a question that I discussed some
>    time ago already with Thierry, but without an result. The key
>    question is: What is the difference between "disabled" and
>    "duty_cycle = 0" in general and does any consumer care about it.)
> 

Good question, I don't really know all consumer requirements, but AFAIK, usually
when you want to program duty_cycle to 0 you also want to disable the PWM. At
least for the backlight case doesn't make sense program first the duty_cycle and
then enable the PWM, is implicit, if duty_cycle is 0 the PWM is disabled, if
duty_cycle > 0 the PWM is enabled.

>  - A softer variant of the above: Should pwm_get_state() anticipate that
>    with .enabled = 0 the duty_cycle (and maybe also period) is
>    unreliable and cache that for callers?
> 

Sorry, when you say pwm_get_state(), you mean the core call or the lowlevel
driver call?

> Unrelated to the patch in question I noticed that the cros-ec-pwm driver
> doesn't handle polarity. We need
> 
> 	state->polarity = PWM_POLARITY_NORMAL;
> 
> in cros_ec_pwm_get_state() and
> 
> 	if (state->polarity != PWM_POLARITY_NORMAL)
> 		return -ERANGE;
> 
> in cros_ec_pwm_apply(). (Not sure -ERANGE is the right value, I think
> there is no global rule in force that tells the right value though.)
> 

Nice catch, thanks, I'll send a patch to fix this.

Thanks,
 Enric

> Best regards
> Uwe
> 
