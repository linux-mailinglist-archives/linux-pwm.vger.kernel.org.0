Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B32DC12D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2019 11:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfJRJgk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Oct 2019 05:36:40 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:57622 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfJRJgj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 18 Oct 2019 05:36:39 -0400
Received: from [10.0.9.70] (unknown [10.0.9.70])
        by uho.ysoft.cz (Postfix) with ESMTP id 3CC95A0587;
        Fri, 18 Oct 2019 11:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571391396;
        bh=7ltV0wSIfqWQOqYh0T3uoa+KZD0GEcY8+ZiANCcyd6Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OuPKOJg1BgU+7ub9bgW1WfMeZPqQs8y8SS3duznr/SWuEQBJ86UPFFvbRucqcKuJ5
         R3bGz7eqz326VuX9/2B/EobZCNEdqGbuV1mRgLQcJthHyx3gh66Fh9rC3SE0R2zjB8
         ePes7k2RHIv9fOdlSTEjGDYuvd02AEVmgaY9NYaU=
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Adam Ford <aford173@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
 <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo>
 <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo>
 <aa73b430-527c-8066-ad9c-edab62a05fc9@ysoft.com>
 <20191017151437.GA85210@ulmo>
 <CAHCN7xJduG9yxAhuW6D1_kpd5=p7LhO_YCWjVxcCoW5bmSEJGQ@mail.gmail.com>
 <20191017171326.GA531411@ulmo>
 <CAHCN7xJWco5gTdjmJZRbNqi1aO+ytor5XMJWQX8a38tfGbz+xg@mail.gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <f6d2427d-21fe-e89c-0bfe-572bc1d00863@ysoft.com>
Date:   Fri, 18 Oct 2019 11:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xJWco5gTdjmJZRbNqi1aO+ytor5XMJWQX8a38tfGbz+xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17. 10. 19 19:44, Adam Ford wrote:
> On Thu, Oct 17, 2019 at 12:13 PM Thierry Reding
> <thierry.reding@gmail.com> wrote:
>>
>> On Thu, Oct 17, 2019 at 12:07:21PM -0500, Adam Ford wrote:
>>> On Thu, Oct 17, 2019 at 10:14 AM Thierry Reding
>>> <thierry.reding@gmail.com> wrote:
>>>>
>>>> On Thu, Oct 17, 2019 at 03:58:25PM +0200, Michal Vokáč wrote:
>>>>> On 17. 10. 19 14:59, Thierry Reding wrote:
>>>>>> On Thu, Oct 17, 2019 at 02:09:17PM +0200, Uwe Kleine-König wrote:
>>>>>>> On Thu, Oct 17, 2019 at 01:11:31PM +0200, Thierry Reding wrote:
>>>>>>>> On Thu, Oct 17, 2019 at 12:11:16PM +0200, Uwe Kleine-König wrote:
>>>>>>>>> On Thu, Oct 17, 2019 at 11:48:08AM +0200, Michal Vokáč wrote:
>>>>>>>>>> On 17. 10. 19 10:10, Uwe Kleine-König wrote:
>>>>>>>>>>> A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
>>>>>>>>>>> pwm_get_state() return the last implemented state")) changed the
>>>>>>>>>>> semantic of pwm_get_state() and disclosed an (as it seems) common
>>>>>>>>>>> problem in lowlevel PWM drivers. By not relying on the period and duty
>>>>>>>>>>> cycle being retrievable from a disabled PWM this type of problem is
>>>>>>>>>>> worked around.
>>>>>>>>>>>
>>>>>>>>>>> Apart from this issue only calling the pwm_get_state/pwm_apply_state
>>>>>>>>>>> combo once is also more effective.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>>>>>>>>> ---
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> There are now two reports about 01ccf903edd6 breaking a backlight. As
>>>>>>>>>>> far as I understand the problem this is a combination of the backend pwm
>>>>>>>>>>> driver yielding surprising results and the pwm-bl driver doing things
>>>>>>>>>>> more complicated than necessary.
>>>>>>>>>>>
>>>>>>>>>>> So I guess this patch works around these problems. Still it would be
>>>>>>>>>>> interesting to find out the details in the imx driver that triggers the
>>>>>>>>>>> problem. So Adam, can you please instrument the pwm-imx27 driver to
>>>>>>>>>>> print *state at the beginning of pwm_imx27_apply() and the end of
>>>>>>>>>>> pwm_imx27_get_state() and provide the results?
>>>>>>>>>>>
>>>>>>>>>>> Note I only compile tested this change.
>>>>>>>>>>
>>>>>>>>>> Hi Uwe,
>>>>>>>>>> I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
>>>>>>>>>> thread that I have a similar problem when you submitted this patch.
>>>>>>>>>>
>>>>>>>>>> So here are my few cents:
>>>>>>>>>>
>>>>>>>>>> My setup is as follows:
>>>>>>>>>>    - imx6dl-yapp4-draco with i.MX6Solo
>>>>>>>>>>    - backlight is controlled with inverted PWM signal
>>>>>>>>>>    - max brightness level = 32, default brightness level set to 32 in DT.
>>>>>>>>>>
>>>>>>>>>> 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
>>>>>>>>>>      pwm_get_state() return the last implemented state):
>>>>>>>>>>
>>>>>>>>>>    - System boots to userspace and backlight is enabled all the time from
>>>>>>>>>>      power up.
>>>>>>>>>>
>>>>>>>>>>      $ dmesg | grep state
>>>>>>>>>>      [    1.763381] get state end: -1811360608, enabled: 0
>>>>>>>>>
>>>>>>>>> What is -1811360608? When I wrote "print *state" above, I thought about
>>>>>>>>> something like:
>>>>>>>>>
>>>>>>>>>        pr_info("%s: period: %u, duty: %u, polarity: %d, enabled: %d",
>>>>>>>>>                __func__, state->period, state->duty_cycle, state->polarity, state->enabled);
>>>>>>>>>
>>>>>>>>> A quick look into drivers/pwm/pwm-imx27.c shows that this is another
>>>>>>>>> driver that yields duty_cycle = 0 when the hardware is off.
>>>>>>>>
>>>>>>>> It seems to me like the best recourse to fix this for now would be to
>>>>>>>> patch up the drivers that return 0 when the hardware is off by caching
>>>>>>>> the currently configured duty cycle.
>>>>>>>>
>>>>>>>> How about the patch below?
>>>>>>>>
>>>>>>>> Thierry
>>>>>>>>
>>>>>>>> --- >8 ---
>>>>>>>>   From 15a52a7f1b910804fabd74a5882befd3f9d6bb37 Mon Sep 17 00:00:00 2001
>>>>>>>> From: Thierry Reding <thierry.reding@gmail.com>
>>>>>>>> Date: Thu, 17 Oct 2019 12:56:00 +0200
>>>>>>>> Subject: [PATCH] pwm: imx27: Cache duty cycle register value
>>>>>>>>
>>>>>>>> The hardware register containing the duty cycle value cannot be accessed
>>>>>>>> when the PWM is disabled. This causes the ->get_state() callback to read
>>>>>>>> back a duty cycle value of 0, which can confuse consumer drivers.
>>>>>>>>
>>>>>>>> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>>>>>>>> ---
>>>>>>>>    drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++-------
>>>>>>>>    1 file changed, 24 insertions(+), 7 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>>>>>>>> index ae11d8577f18..4113d5cd4c62 100644
>>>>>>>> --- a/drivers/pwm/pwm-imx27.c
>>>>>>>> +++ b/drivers/pwm/pwm-imx27.c
>>>>>>>> @@ -85,6 +85,13 @@ struct pwm_imx27_chip {
>>>>>>>>          struct clk      *clk_per;
>>>>>>>>          void __iomem    *mmio_base;
>>>>>>>>          struct pwm_chip chip;
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * The driver cannot read the current duty cycle from the hardware if
>>>>>>>> +        * the hardware is disabled. Cache the last programmed duty cycle
>>>>>>>> +        * value to return in that case.
>>>>>>>> +        */
>>>>>>>> +       unsigned int duty_cycle;
>>>>>>>>    };
>>>>>>>>    #define to_pwm_imx27_chip(chip)       container_of(chip, struct pwm_imx27_chip, chip)
>>>>>>>> @@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
>>>>>>>>          tmp = NSEC_PER_SEC * (u64)(period + 2);
>>>>>>>>          state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>>>>>>>> -       /* PWMSAR can be read only if PWM is enabled */
>>>>>>>> -       if (state->enabled) {
>>>>>>>> +       /*
>>>>>>>> +        * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
>>>>>>>> +        * use the cached value.
>>>>>>>> +        */
>>>>>>>> +       if (state->enabled)
>>>>>>>>                  val = readl(imx->mmio_base + MX3_PWMSAR);
>>>>>>>> -               tmp = NSEC_PER_SEC * (u64)(val);
>>>>>>>> -               state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>>>>>>>> -       } else {
>>>>>>>> -               state->duty_cycle = 0;
>>>>>>>> -       }
>>>>>>>> +       else
>>>>>>>> +               val = imx->duty_cycle;
>>>>>>>> +
>>>>>>>> +       tmp = NSEC_PER_SEC * (u64)(val);
>>>>>>>> +       state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>>>>>>>>          if (!state->enabled)
>>>>>>>>                  pwm_imx27_clk_disable_unprepare(chip);
>>>>>>>> @@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>>>>>                  writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>>>>>>>                  writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>>>>>>>> +               /*
>>>>>>>> +                * Store the duty cycle for future reference in cases where
>>>>>>>> +                * the MX3_PWMSAR register can't be read (i.e. when the PWM
>>>>>>>> +                * is disabled).
>>>>>>>> +                */
>>>>>>>> +               imx->duty_cycle = duty_cycles;
>>>>>>>> +
>>>>>>>
>>>>>>> I wonder if it would be more sensible to do this in the pwm core
>>>>>>> instead. Currently there are two drivers known with this problem. I
>>>>>>> wouldn't be surprised if there were more.
>>>>>>
>>>>>> I've inspected all the drivers and didn't spot any beyond cros-ec and
>>>>>> i.MX that have this problem. There's also no good way to do this in the
>>>>>> core, because the core doesn't know whether or not the driver is capable
>>>>>> of returning the correct duty cycle on hardare readout. So the core
>>>>>> would have to rely on state->duty_cycle that is passed in, but then the
>>>>>> offending commit becomes useless because the whole point was to return
>>>>>> the state as written to hardware (rather than the software state which
>>>>>> was being returned before that patch).
>>>>>>
>>>>>>> If we want to move clients to not rely on .period and .duty_cycle for a
>>>>>>> disabled PWM (do we?) a single change in the core is also beneficial
>>>>>>> compared to fixing several lowlevel drivers.
>>>>>>
>>>>>> These are really two orthogonal problems. We don't currently consider
>>>>>> enabled = 0 to be equivalent to duty_cycle = 0 at an API level. I'm not
>>>>>> prepared to do that at this point in the release cycle either.
>>>>>>
>>>>>> What this here has shown is that we have at least two drivers that don't
>>>>>> behave the way they are supposed to according to the API and they break
>>>>>> consumers. If they break for pwm-backlight, it's possible that they will
>>>>>> break for other consumers as well. So the right thing to do is fix the
>>>>>> two drivers that are broken.
>>>>>>
>>>>>> After -rc1 we no longer experiment. Instead we clean up the messes we've
>>>>>> made. We can revisit the other points once mainline is fixed.
>>>>>
>>>>> Hi Thierry,
>>>>> I just tried your patch with v5.4-rc3 with this result:
>>>>>
>>>>> root@hydraco:~# dmesg | grep pwm_
>>>>> [    1.772089] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>>>>> [    4.938759] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
>>>>> [    4.947431] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>>>>
>>>> Okay... this is interesting. If I understand correctly, that first line
>>>> here is where the initial hardware readout happens. The second one is
>>>> the first time when the backlight is configured, so it sets period and
>>>> polarity. But then for some reason when we read out after that to read
>>>> what state was written... we see that actually nothing was written at
>>>> all.
>>>>
>>>> And we can see why in pwm_imx27_apply(): If the PWM is not enabled, we
>>>> don't actually program any of the registers, so it's not a surprise that
>>>> things fall apart.
>>>>
>>>>> [    4.956484] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 0
>>>>> [    4.965473] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
>>>>> [    4.974410] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 1
>>>>> [    4.988617] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 1
>>>>>
>>>>> Backlight is on with full brightness at this stage.
>>>>>
>>>>> root@hydraco:/sys/class/backlight/backlight# cat brightness
>>>>> 32
>>>>>
>>>>> root@hydraco:/sys/class/backlight/backlight# echo 32 > brightness
>>>>> [  153.386391] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 1
>>>>> [  153.398311] pwm_imx27_get_state: period: 992970, duty: 992970, polarity: 0, enabled: 1
>>>>>
>>>>> Backlight goes down.
>>>>>
>>>>> root@hydraco:/sys/class/backlight/backlight# echo 1 > brightness
>>>>> [  168.506261] pwm_imx27_apply: period: 992970, duty: 15576, polarity: 0, enabled: 1
>>>>> [  168.518064] pwm_imx27_get_state: period: 992970, duty: 15576, polarity: 0, enabled: 1
>>>>>
>>>>> Backlight goes up to almost full brightness.
>>>>>
>>>>> root@hydraco:/sys/class/backlight/backlight# echo 0 > brightness
>>>>> [  177.496265] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 0
>>>>> [  177.507602] pwm_imx27_get_state: period: 496485, duty: 7788, polarity: 0, enabled: 0
>>>>>
>>>>> Backlight goes up to full brightness.
>>>>>
>>>>> So your patch does not solve my issue.
>>>>>
>>>>> The main problem I see is incorrect polarity setting. In my DT
>>>>> the pwm-backlight consumer requests PWM_POLARITY_INVERTED and
>>>>> period 500000ns. Though after reset the PWM HW registers are
>>>>> configured to normal polarity. This initial setting is read out
>>>>> and used by the consumer instead of the DT configuration.
>>>>
>>>> So the problem with the i.MX driver is that it doesn't actually write
>>>> the full state to the hardware and therefore the patch that caused these
>>>> things to break reads back an incomplete state. So we've basically got
>>>> two options: 1) make sure the hardware state is fully written or 2) make
>>>> sure that we return the cached state.
>>>>
>>>> I think 2) doesn't really make sense because it is conflicts with the
>>>> purpose of the ->get_state() callback. The only time where we should be
>>>> returning cached data is if the hardware registers don't contain the
>>>> information (as in the case of the cros-ec driver) or if we can't access
>>>> it for other reasons (such as in the case of i.MX's duty cycle).
>>>>
>>>> Does the attached patch help with your issue? The idea is to always
>>>> write the full state to the hardware, even if period and duty cycle are
>>>> unused when the PWM is disabled. That's really the kind of contract that
>>>> we have added with the offending patch in the core.
>>>>
>>>> It looks like all other drivers handle this more or less correctly, so
>>>> if we only need to fix up cros-ec and i.MX this seems like a realistic
>>>> way to fix things up. If other drivers are problematic in this regard,
>>>> we should probably revert and then fix the drivers before we can apply
>>>> that patch again.
>>>
>>> This patch combined with your previous patch appears to have worked.
>>> If you end up sending a patch series to fix this, go ahead and add
>>>
>>> Tested-by: Adam Ford <aford173@gmail.com> #imx6q-logicpd
>>
>> Excellent! Thanks for testing this. I'll wait until tomorrow to see if
>> there's some feedback from Enric for the cros-ec change. I'll send out
>> the total of three patches again in the hopes that those are really
>> the only two cases that are broken.
> 
> When you do, can you mark it with the Fixes note?  I am hoping the
> maintainers can hopefully incorporate this into 5.4 since it fixes a
> regression.

Hi Thierry,

I can confirm that the combination of your two patches:
  - ("pwm: imx27: Unconditionally write state to hardware")
  - ("pwm: imx27: Cache duty cycle register value")

works OK and solve my problem as well.

root@hydraco:~# dmesg | grep pwm_
[    1.695306] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
[    5.387271] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
[    5.396433] pwm_imx27_get_state: period: 500000, duty: 0, polarity: 1, enabled: 0
[    5.405500] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 0
[    5.418802] pwm_imx27_get_state: period: 500000, duty: 500000, polarity: 1, enabled: 0
[    5.428208] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 1
[    5.442633] pwm_imx27_get_state: period: 500000, duty: 500000, polarity: 1, enabled: 1

Backlight is on from power up to userspace.

root@hydraco:~# cd /sys/class/backlight/backlight/
root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# cat brightness
32

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 32 > brightness

Nothing happens.

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 1 > brightness
[  513.629043] pwm_imx27_apply: period: 500000, duty: 7843, polarity: 1, enabled: 1
[  513.639899] pwm_imx27_get_state: period: 500000, duty: 7833, polarity: 1, enabled: 1

Backlight goes to low brightness.

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 0 > brightness
[  519.677088] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
[  519.687733] pwm_imx27_get_state: period: 500000, duty: 0, polarity: 1, enabled: 0

Backlight goes to max brightness, unresolved i.MX6 limitation.

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 32 > brightness
[  923.921292] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 0
[  923.933331] pwm_imx27_get_state: period: 500000, duty: 500000, polarity: 1, enabled: 0
[  923.944546] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 1
[  923.963931] pwm_imx27_get_state: period: 500000, duty: 500000, polarity: 1, enabled: 1

Backlight remains at max brightness, OK.

If I apply the patch from Uwe ("backlight: pwm_bl: configure pwm only once
per backlight toggle") on top of that, it still works and I do not see
any change in the behavior.

root@hydraco:~# dmesg | grep pwm_
[    1.687461] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
[    4.875087] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
[    4.884796] pwm_imx27_get_state: period: 500000, duty: 0, polarity: 1, enabled: 0
[    4.893922] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 1
[    4.908473] pwm_imx27_get_state: period: 500000, duty: 500000, polarity: 1, enabled: 1

root@hydraco:~# cd /sys/class/backlight/backlight/
root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# cat brightness
32

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 32 > brightness

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 1 > brightness
[  110.775650] pwm_imx27_apply: period: 500000, duty: 7843, polarity: 1, enabled: 1
[  110.786512] pwm_imx27_get_state: period: 500000, duty: 7833, polarity: 1, enabled: 1

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 0 > brightness
[  128.224036] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
[  128.234675] pwm_imx27_get_state: period: 500000, duty: 0, polarity: 1, enabled: 0

root@hydraco:/sys/devices/soc0/backlight/backlight/backlight# echo 32 > brightness
[  138.208072] pwm_imx27_apply: period: 500000, duty: 500000, polarity: 1, enabled: 1
[  138.220271] pwm_imx27_get_state: period: 500000, duty: 500000, polarity: 1, enabled: 1

The only difference is here when the state is changed from enabled=0
to enabled=1. The apply/get_state combo is called only once.

So this looks good to me.

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

Thank you all for the very prompt reaction!
Michal

>>>> --- >8 ---
>>>>  From 7040f0038e04a1caa6dda5b6f675a9fdee0271f4 Mon Sep 17 00:00:00 2001
>>>> From: Thierry Reding <thierry.reding@gmail.com>
>>>> Date: Thu, 17 Oct 2019 17:11:41 +0200
>>>> Subject: [PATCH] pwm: imx27: Unconditionally write state to hardware
>>>>
>>>> The i.MX driver currently uses a shortcut and doesn't write all of the
>>>> state through to the hardware when the PWM is disabled. This causes an
>>>> inconsistent state to be read back by consumers with the result of them
>>>> malfunctioning.
>>>>
>>>> Fix this by always writing the full state through to the hardware
>>>> registers so that the correct state can always be read back.
>>>>
>>>> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>>>> ---
>>>>   drivers/pwm/pwm-imx27.c | 120 ++++++++++++++++++++--------------------
>>>>   1 file changed, 59 insertions(+), 61 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>>>> index 4113d5cd4c62..59d8b1289808 100644
>>>> --- a/drivers/pwm/pwm-imx27.c
>>>> +++ b/drivers/pwm/pwm-imx27.c
>>>> @@ -230,70 +230,68 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>
>>>>          pwm_get_state(pwm, &cstate);
>>>>
>>>> -       if (state->enabled) {
>>>> -               c = clk_get_rate(imx->clk_per);
>>>> -               c *= state->period;
>>>> -
>>>> -               do_div(c, 1000000000);
>>>> -               period_cycles = c;
>>>> -
>>>> -               prescale = period_cycles / 0x10000 + 1;
>>>> -
>>>> -               period_cycles /= prescale;
>>>> -               c = (unsigned long long)period_cycles * state->duty_cycle;
>>>> -               do_div(c, state->period);
>>>> -               duty_cycles = c;
>>>> -
>>>> -               /*
>>>> -                * according to imx pwm RM, the real period value should be
>>>> -                * PERIOD value in PWMPR plus 2.
>>>> -                */
>>>> -               if (period_cycles > 2)
>>>> -                       period_cycles -= 2;
>>>> -               else
>>>> -                       period_cycles = 0;
>>>> -
>>>> -               /*
>>>> -                * Wait for a free FIFO slot if the PWM is already enabled, and
>>>> -                * flush the FIFO if the PWM was disabled and is about to be
>>>> -                * enabled.
>>>> -                */
>>>> -               if (cstate.enabled) {
>>>> -                       pwm_imx27_wait_fifo_slot(chip, pwm);
>>>> -               } else {
>>>> -                       ret = pwm_imx27_clk_prepare_enable(chip);
>>>> -                       if (ret)
>>>> -                               return ret;
>>>> -
>>>> -                       pwm_imx27_sw_reset(chip);
>>>> -               }
>>>> -
>>>> -               writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>>> -               writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>>>> -
>>>> -               /*
>>>> -                * Store the duty cycle for future reference in cases where
>>>> -                * the MX3_PWMSAR register can't be read (i.e. when the PWM
>>>> -                * is disabled).
>>>> -                */
>>>> -               imx->duty_cycle = duty_cycles;
>>>> -
>>>> -               cr = MX3_PWMCR_PRESCALER_SET(prescale) |
>>>> -                    MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
>>>> -                    FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
>>>> -                    MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
>>>> -
>>>> -               if (state->polarity == PWM_POLARITY_INVERSED)
>>>> -                       cr |= FIELD_PREP(MX3_PWMCR_POUTC,
>>>> -                                       MX3_PWMCR_POUTC_INVERTED);
>>>> -
>>>> -               writel(cr, imx->mmio_base + MX3_PWMCR);
>>>> -       } else if (cstate.enabled) {
>>>> -               writel(0, imx->mmio_base + MX3_PWMCR);
>>>> +       c = clk_get_rate(imx->clk_per);
>>>> +       c *= state->period;
>>>>
>>>> -               pwm_imx27_clk_disable_unprepare(chip);
>>>> +       do_div(c, 1000000000);
>>>> +       period_cycles = c;
>>>> +
>>>> +       prescale = period_cycles / 0x10000 + 1;
>>>> +
>>>> +       period_cycles /= prescale;
>>>> +       c = (unsigned long long)period_cycles * state->duty_cycle;
>>>> +       do_div(c, state->period);
>>>> +       duty_cycles = c;
>>>> +
>>>> +       /*
>>>> +        * according to imx pwm RM, the real period value should be PERIOD
>>>> +        * value in PWMPR plus 2.
>>>> +        */
>>>> +       if (period_cycles > 2)
>>>> +               period_cycles -= 2;
>>>> +       else
>>>> +               period_cycles = 0;
>>>> +
>>>> +       /*
>>>> +        * Wait for a free FIFO slot if the PWM is already enabled, and flush
>>>> +        * the FIFO if the PWM was disabled and is about to be enabled.
>>>> +        */
>>>> +       if (cstate.enabled) {
>>>> +               pwm_imx27_wait_fifo_slot(chip, pwm);
>>>> +       } else {
>>>> +               ret = pwm_imx27_clk_prepare_enable(chip);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +
>>>> +               pwm_imx27_sw_reset(chip);
>>>>          }
>>>>
>>>> +       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>>> +       writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>>>> +
>>>> +       /*
>>>> +        * Store the duty cycle for future reference in cases where the
>>>> +        * MX3_PWMSAR register can't be read (i.e. when the PWM is disabled).
>>>> +        */
>>>> +       imx->duty_cycle = duty_cycles;
>>>> +
>>>> +       cr = MX3_PWMCR_PRESCALER_SET(prescale) |
>>>> +            MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
>>>> +            FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
>>>> +            MX3_PWMCR_DBGEN;
>>>> +
>>>> +       if (state->polarity == PWM_POLARITY_INVERSED)
>>>> +               cr |= FIELD_PREP(MX3_PWMCR_POUTC,
>>>> +                               MX3_PWMCR_POUTC_INVERTED);
>>>> +
>>>> +       if (state->enabled)
>>>> +               cr |= MX3_PWMCR_EN;
>>>> +
>>>> +       writel(cr, imx->mmio_base + MX3_PWMCR);
>>>> +
>>>> +       if (!state->enabled && cstate.enabled)
>>>> +               pwm_imx27_clk_disable_unprepare(chip);
>>>> +
>>>>          return 0;
>>>>   }
>>>>
>>>> --
>>>> 2.23.0
>>>>

