Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9ACDAEE5
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437367AbfJQN62 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 09:58:28 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:33654 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbfJQN62 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Oct 2019 09:58:28 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id D2720A26AC;
        Thu, 17 Oct 2019 15:58:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571320706;
        bh=ljjkwK/8e9jRsR32mW86pi7ML7v+E082ZabF3B7LTHw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hg+zlye3q2td6PvoaGZzz7xrLRA3gF2ZclgR5tdHgpnEUasp2NW6dnOLfqPMfG9fT
         jW3VnHJpFOLoam9tmdIgH4oFDzkyekLxzjb7JXCzsFmD4NdBr+28V+kwdeLhedcGAt
         UrhzBMIZbLED6rNjsCSX/Rd/hiJ7dTTr2+2nUDSc=
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        Jingoo Han <jingoohan1@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Adam Ford <aford173@gmail.com>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
 <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo>
 <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <aa73b430-527c-8066-ad9c-edab62a05fc9@ysoft.com>
Date:   Thu, 17 Oct 2019 15:58:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017125932.GB3768303@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17. 10. 19 14:59, Thierry Reding wrote:
> On Thu, Oct 17, 2019 at 02:09:17PM +0200, Uwe Kleine-König wrote:
>> On Thu, Oct 17, 2019 at 01:11:31PM +0200, Thierry Reding wrote:
>>> On Thu, Oct 17, 2019 at 12:11:16PM +0200, Uwe Kleine-König wrote:
>>>> On Thu, Oct 17, 2019 at 11:48:08AM +0200, Michal Vokáč wrote:
>>>>> On 17. 10. 19 10:10, Uwe Kleine-König wrote:
>>>>>> A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
>>>>>> pwm_get_state() return the last implemented state")) changed the
>>>>>> semantic of pwm_get_state() and disclosed an (as it seems) common
>>>>>> problem in lowlevel PWM drivers. By not relying on the period and duty
>>>>>> cycle being retrievable from a disabled PWM this type of problem is
>>>>>> worked around.
>>>>>>
>>>>>> Apart from this issue only calling the pwm_get_state/pwm_apply_state
>>>>>> combo once is also more effective.
>>>>>>
>>>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>>>> ---
>>>>>> Hello,
>>>>>>
>>>>>> There are now two reports about 01ccf903edd6 breaking a backlight. As
>>>>>> far as I understand the problem this is a combination of the backend pwm
>>>>>> driver yielding surprising results and the pwm-bl driver doing things
>>>>>> more complicated than necessary.
>>>>>>
>>>>>> So I guess this patch works around these problems. Still it would be
>>>>>> interesting to find out the details in the imx driver that triggers the
>>>>>> problem. So Adam, can you please instrument the pwm-imx27 driver to
>>>>>> print *state at the beginning of pwm_imx27_apply() and the end of
>>>>>> pwm_imx27_get_state() and provide the results?
>>>>>>
>>>>>> Note I only compile tested this change.
>>>>>
>>>>> Hi Uwe,
>>>>> I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
>>>>> thread that I have a similar problem when you submitted this patch.
>>>>>
>>>>> So here are my few cents:
>>>>>
>>>>> My setup is as follows:
>>>>>   - imx6dl-yapp4-draco with i.MX6Solo
>>>>>   - backlight is controlled with inverted PWM signal
>>>>>   - max brightness level = 32, default brightness level set to 32 in DT.
>>>>>
>>>>> 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
>>>>>     pwm_get_state() return the last implemented state):
>>>>>
>>>>>   - System boots to userspace and backlight is enabled all the time from
>>>>>     power up.
>>>>>
>>>>>     $ dmesg | grep state
>>>>>     [    1.763381] get state end: -1811360608, enabled: 0
>>>>
>>>> What is -1811360608? When I wrote "print *state" above, I thought about
>>>> something like:
>>>>
>>>> 	pr_info("%s: period: %u, duty: %u, polarity: %d, enabled: %d",
>>>> 		__func__, state->period, state->duty_cycle, state->polarity, state->enabled);
>>>>
>>>> A quick look into drivers/pwm/pwm-imx27.c shows that this is another
>>>> driver that yields duty_cycle = 0 when the hardware is off.
>>>
>>> It seems to me like the best recourse to fix this for now would be to
>>> patch up the drivers that return 0 when the hardware is off by caching
>>> the currently configured duty cycle.
>>>
>>> How about the patch below?
>>>
>>> Thierry
>>>
>>> --- >8 ---
>>>  From 15a52a7f1b910804fabd74a5882befd3f9d6bb37 Mon Sep 17 00:00:00 2001
>>> From: Thierry Reding <thierry.reding@gmail.com>
>>> Date: Thu, 17 Oct 2019 12:56:00 +0200
>>> Subject: [PATCH] pwm: imx27: Cache duty cycle register value
>>>
>>> The hardware register containing the duty cycle value cannot be accessed
>>> when the PWM is disabled. This causes the ->get_state() callback to read
>>> back a duty cycle value of 0, which can confuse consumer drivers.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>>> ---
>>>   drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++-------
>>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>>> index ae11d8577f18..4113d5cd4c62 100644
>>> --- a/drivers/pwm/pwm-imx27.c
>>> +++ b/drivers/pwm/pwm-imx27.c
>>> @@ -85,6 +85,13 @@ struct pwm_imx27_chip {
>>>   	struct clk	*clk_per;
>>>   	void __iomem	*mmio_base;
>>>   	struct pwm_chip	chip;
>>> +
>>> +	/*
>>> +	 * The driver cannot read the current duty cycle from the hardware if
>>> +	 * the hardware is disabled. Cache the last programmed duty cycle
>>> +	 * value to return in that case.
>>> +	 */
>>> +	unsigned int duty_cycle;
>>>   };
>>>   
>>>   #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
>>> @@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
>>>   	tmp = NSEC_PER_SEC * (u64)(period + 2);
>>>   	state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>>>   
>>> -	/* PWMSAR can be read only if PWM is enabled */
>>> -	if (state->enabled) {
>>> +	/*
>>> +	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
>>> +	 * use the cached value.
>>> +	 */
>>> +	if (state->enabled)
>>>   		val = readl(imx->mmio_base + MX3_PWMSAR);
>>> -		tmp = NSEC_PER_SEC * (u64)(val);
>>> -		state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>>> -	} else {
>>> -		state->duty_cycle = 0;
>>> -	}
>>> +	else
>>> +		val = imx->duty_cycle;
>>> +
>>> +	tmp = NSEC_PER_SEC * (u64)(val);
>>> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>>>   
>>>   	if (!state->enabled)
>>>   		pwm_imx27_clk_disable_unprepare(chip);
>>> @@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>   		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>>   		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>>>   
>>> +		/*
>>> +		 * Store the duty cycle for future reference in cases where
>>> +		 * the MX3_PWMSAR register can't be read (i.e. when the PWM
>>> +		 * is disabled).
>>> +		 */
>>> +		imx->duty_cycle = duty_cycles;
>>> +
>>
>> I wonder if it would be more sensible to do this in the pwm core
>> instead. Currently there are two drivers known with this problem. I
>> wouldn't be surprised if there were more.
> 
> I've inspected all the drivers and didn't spot any beyond cros-ec and
> i.MX that have this problem. There's also no good way to do this in the
> core, because the core doesn't know whether or not the driver is capable
> of returning the correct duty cycle on hardare readout. So the core
> would have to rely on state->duty_cycle that is passed in, but then the
> offending commit becomes useless because the whole point was to return
> the state as written to hardware (rather than the software state which
> was being returned before that patch).
> 
>> If we want to move clients to not rely on .period and .duty_cycle for a
>> disabled PWM (do we?) a single change in the core is also beneficial
>> compared to fixing several lowlevel drivers.
> 
> These are really two orthogonal problems. We don't currently consider
> enabled = 0 to be equivalent to duty_cycle = 0 at an API level. I'm not
> prepared to do that at this point in the release cycle either.
> 
> What this here has shown is that we have at least two drivers that don't
> behave the way they are supposed to according to the API and they break
> consumers. If they break for pwm-backlight, it's possible that they will
> break for other consumers as well. So the right thing to do is fix the
> two drivers that are broken.
> 
> After -rc1 we no longer experiment. Instead we clean up the messes we've
> made. We can revisit the other points once mainline is fixed.

Hi Thierry,
I just tried your patch with v5.4-rc3 with this result:

root@hydraco:~# dmesg | grep pwm_
[    1.772089] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
[    4.938759] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
[    4.947431] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
[    4.956484] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 0
[    4.965473] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
[    4.974410] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 1
[    4.988617] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 1

Backlight is on with full brightness at this stage.

root@hydraco:/sys/class/backlight/backlight# cat brightness
32

root@hydraco:/sys/class/backlight/backlight# echo 32 > brightness
[  153.386391] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 1
[  153.398311] pwm_imx27_get_state: period: 992970, duty: 992970, polarity: 0, enabled: 1

Backlight goes down.

root@hydraco:/sys/class/backlight/backlight# echo 1 > brightness
[  168.506261] pwm_imx27_apply: period: 992970, duty: 15576, polarity: 0, enabled: 1
[  168.518064] pwm_imx27_get_state: period: 992970, duty: 15576, polarity: 0, enabled: 1

Backlight goes up to almost full brightness.

root@hydraco:/sys/class/backlight/backlight# echo 0 > brightness
[  177.496265] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 0
[  177.507602] pwm_imx27_get_state: period: 496485, duty: 7788, polarity: 0, enabled: 0

Backlight goes up to full brightness.

So your patch does not solve my issue.

The main problem I see is incorrect polarity setting. In my DT
the pwm-backlight consumer requests PWM_POLARITY_INVERTED and
period 500000ns. Though after reset the PWM HW registers are
configured to normal polarity. This initial setting is read out
and used by the consumer instead of the DT configuration.

Michal
