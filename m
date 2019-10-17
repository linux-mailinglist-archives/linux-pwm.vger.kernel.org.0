Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A2DAAA9
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409178AbfJQK7Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 06:59:25 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:58584 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409037AbfJQK7Z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Oct 2019 06:59:25 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 75D1DA385F;
        Thu, 17 Oct 2019 12:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571309960;
        bh=AGv9vLAQlMiuhqBtdNcQ+30BcWRtQ9ivxHwKeF48j3Q=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=g+WlJfxqcYbuHCYObhZx9jvRSkN2vuxQuhY7VH5jFH0j49rluRQUQv8Qvom4NJmak
         BinlPrb79MSGbhX5QtWfHCLBzTBeTjS4fzsAgtWfdCYbYoPswi2Rc0ynshZ+EoAc00
         Dobwc56CJO9LjflCpcjNjYjUujbwzpwzT5lqPyyo=
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
Message-ID: <4f9594e5-f99b-f17d-531a-37d4c4161203@ysoft.com>
Date:   Thu, 17 Oct 2019 12:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17. 10. 19 11:48, Michal Vokáč wrote:
> On 17. 10. 19 10:10, Uwe Kleine-König wrote:
>> A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
>> pwm_get_state() return the last implemented state")) changed the
>> semantic of pwm_get_state() and disclosed an (as it seems) common
>> problem in lowlevel PWM drivers. By not relying on the period and duty
>> cycle being retrievable from a disabled PWM this type of problem is
>> worked around.
>>
>> Apart from this issue only calling the pwm_get_state/pwm_apply_state
>> combo once is also more effective.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
>> Hello,
>>
>> There are now two reports about 01ccf903edd6 breaking a backlight. As
>> far as I understand the problem this is a combination of the backend pwm
>> driver yielding surprising results and the pwm-bl driver doing things
>> more complicated than necessary.
>>
>> So I guess this patch works around these problems. Still it would be
>> interesting to find out the details in the imx driver that triggers the
>> problem. So Adam, can you please instrument the pwm-imx27 driver to
>> print *state at the beginning of pwm_imx27_apply() and the end of
>> pwm_imx27_get_state() and provide the results?
>>
>> Note I only compile tested this change.
> 
> Hi Uwe,
> I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
> thread that I have a similar problem when you submitted this patch.
> 
> So here are my few cents:

Once again with updated and more detailed debug messages.

> My setup is as follows:
>   - imx6dl-yapp4-draco with i.MX6Solo
>   - backlight is controlled with inverted PWM signal
>   - max brightness level = 32, default brightness level set to 32 in DT.
> 
> 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
>     pwm_get_state() return the last implemented state):
> 
>   - System boots to userspace and backlight is enabled all the time from
>     power up.
> 
     -  $ dmesg | grep pwm_
       [    1.761546] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
       [    5.012352] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
       [    5.021143] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 0
       [    5.030182] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 1
> 
>   - $ cat brightness
>     32
> 
>   - $ echo 32 > brightness # nothing happens, max. brightness
> 
>   - $ echo 1 > brightness # backlight goes down to lowest level
       [   93.976354] pwm_imx27_apply: period: 500000, duty: 7843, polarity: 1, enabled: 1
> 
>   - $ echo 0 > brightness # backlight goes up to max. level, this is
>                           # problem of the inverted PWM on i.MX we attempted
>                           # to solve some time ago.
       [  115.496350] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
>
> 2. Backlight behavior on v5.4-rc3:
> 
>   - System boots to userspace and backlight is enabled all the time from
>     power up.
> 
     - $ dmesg | grep pwm_
       [    1.774071] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
       [    5.003961] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
       [    5.012649] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
       [    5.021694] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 0
       [    5.030732] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
       [    5.039643] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 1
       [    5.049605] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 1
> 
>   - $ cat brightness
>     32
> 
>   - $ echo 32 > brightness # backlight goes down
       [  707.946970] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 1
       [  707.958551] pwm_imx27_get_state: period: 992970, duty: 992970, polarity: 0, enabled: 1
> 
>   - $ echo 1 > brightness # backlight goes up to high level
       [  757.516845] pwm_imx27_apply: period: 992970, duty: 15576, polarity: 0, enabled: 1
       [  757.528438] pwm_imx27_get_state: period: 992970, duty: 15576, polarity: 0, enabled: 1
> 
>   - $ echo 0 > brightness # backlight goes up to highest level
       [  783.386838] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 0
       [  783.398025] pwm_imx27_get_state: period: 496485, duty: 0, polarity: 0, enabled: 0
> 
> So the behavior is clearly inverted to how it worked prior to 01ccf903edd6
> with the weird exception that the initial brightness level 32 is
> not applied.
> 
> 3. Backlight behavior on v5.4-rc3 + this patch:
> 
>   - System boots with backlight enabled. In the middle of kernel boot
>     backlight is disabled.
> 
>   - $ dmesg | grep state
       [    1.773099] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
       [    5.002532] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
       [    5.011263] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
       [    5.020307] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 1
       [    5.031066] pwm_imx27_get_state: period: 992970, duty: 992970, polarity: 0, enabled: 1
> 
>   - $ cat brightness
>     32
> 
>   - $ echo 32 > brightness # nothing happens, backlight is down
> 
>   - $ echo 1 > brightness # backlight goes to high level
       [   73.786926] pwm_imx27_apply: period: 992970, duty: 15576, polarity: 0, enabled: 1
       [   73.798469] pwm_imx27_get_state: period: 992970, duty: 15576, polarity: 0, enabled: 1
> 
>   - $ echo 0 > brightness # backlight goes to max brightness
       [  104.636908] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 0
       [  104.648093] pwm_imx27_get_state: period: 496485, duty: 0, polarity: 0, enabled: 0
> 
> Same behavior as (2) but the default state from DT is apparently applied.
> 
> I only did this experiments. I did not delve into the code to track what is
> going on in there yet.
> 
> Hopefully this helps you a bit and feel free to request other experiments,
> Michal
> 
>>   drivers/video/backlight/pwm_bl.c | 34 +++++++++++---------------------
>>   1 file changed, 12 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index 746eebc411df..ddebd62b3978 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -42,10 +42,8 @@ struct pwm_bl_data {
>>   static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>>   {
>> -    struct pwm_state state;
>>       int err;
>> -    pwm_get_state(pb->pwm, &state);
>>       if (pb->enabled)
>>           return;
>> @@ -53,9 +51,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>>       if (err < 0)
>>           dev_err(pb->dev, "failed to enable power supply\n");
>> -    state.enabled = true;
>> -    pwm_apply_state(pb->pwm, &state);
>> -
>>       if (pb->post_pwm_on_delay)
>>           msleep(pb->post_pwm_on_delay);
>> @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>>   static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>   {
>> -    struct pwm_state state;
>> -
>> -    pwm_get_state(pb->pwm, &state);
>> -    if (!pb->enabled)
>> -        return;
>> -
>>       if (pb->enable_gpio)
>>           gpiod_set_value_cansleep(pb->enable_gpio, 0);
>>       if (pb->pwm_off_delay)
>>           msleep(pb->pwm_off_delay);
>> -    state.enabled = false;
>> -    state.duty_cycle = 0;
>> -    pwm_apply_state(pb->pwm, &state);
>> -
>>       regulator_disable(pb->power_supply);
>>       pb->enabled = false;
>>   }
>> -static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
>> +static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness, struct pwm_state *state)
>>   {
>>       unsigned int lth = pb->lth_brightness;
>> -    struct pwm_state state;
>>       u64 duty_cycle;
>> -    pwm_get_state(pb->pwm, &state);
>> -
>>       if (pb->levels)
>>           duty_cycle = pb->levels[brightness];
>>       else
>>           duty_cycle = brightness;
>> -    duty_cycle *= state.period - lth;
>> +    duty_cycle *= state->period - lth;
>>       do_div(duty_cycle, pb->scale);
>>       return duty_cycle + lth;
>> @@ -122,12 +104,20 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>>       if (brightness > 0) {
>>           pwm_get_state(pb->pwm, &state);
>> -        state.duty_cycle = compute_duty_cycle(pb, brightness);
>> +        state.duty_cycle = compute_duty_cycle(pb, brightness, &state);
>> +        state.enabled = true;
>>           pwm_apply_state(pb->pwm, &state);
>> +
>>           pwm_backlight_power_on(pb);
>> -    } else
>> +    } else {
>>           pwm_backlight_power_off(pb);
>> +        pwm_get_state(pb->pwm, &state);
>> +        state.enabled = false;
>> +        state.duty_cycle = 0;
>> +        pwm_apply_state(pb->pwm, &state);
>> +    }
>> +
>>       if (pb->notify_after)
>>           pb->notify_after(pb->dev, brightness);
>>
> 

