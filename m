Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41F1700D5A
	for <lists+linux-pwm@lfdr.de>; Fri, 12 May 2023 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjELQu1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 May 2023 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbjELQuX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2023 12:50:23 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A235A4
        for <linux-pwm@vger.kernel.org>; Fri, 12 May 2023 09:50:22 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BD5CF86222;
        Fri, 12 May 2023 18:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683910221;
        bh=ynccEUqnU7I0m3kbJrGEj5e2BFO8JJurpbwdyoTcntw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pXuGEedQXg5k1jMw0wJkauF5My3zn5TdRUlvBl8lpyaiZ1W6ea4L5SR6htYV58dzX
         zuEvdwpLvDbQoEXlF7IMP+OlAOAYyWg4WotAbqIOJPj+ex0EDwXUiNvfp9Y2taiKSI
         N37pM+rHbPLqsMUFW2VAAAXg71rnjeYsulgE+7IQdYeQYq8iL9XT/ID4AV5jujqoyR
         F9i7HST7sYaffqS46WDebsAc/J2Ca+1p/JfsPp/t3v2XYcLn3bD0iL6vl1Yo2FqTen
         GJjvPzQi2rloMLY0YJ7+0MQixL/zAXCGKLho+KS0NgUB9+FTXOoLsDULtMvgLTXQn5
         Anf/kj/w7BtDg==
Message-ID: <1b875480-19c7-4a6b-3777-3f23513ae1be@denx.de>
Date:   Fri, 12 May 2023 18:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pwm: core: Permit unset period when applying
 configuration of disabled PWMs
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-pwm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230511181853.185685-1-marex@denx.de>
 <ZF1ZMNBMxLqNI0zh@google.com> <52131759-457b-12ba-ef05-b91eafd7d342@denx.de>
 <ZF2Nfbx+/aKJOk3v@google.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ZF2Nfbx+/aKJOk3v@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/12/23 02:51, Brian Norris wrote:
> On Fri, May 12, 2023 at 01:32:49AM +0200, Marek Vasut wrote:
>> On 5/11/23 23:08, Brian Norris wrote:
>>> On Thu, May 11, 2023 at 08:18:53PM +0200, Marek Vasut wrote:
>>>> Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Brian Norris <briannorris@chromium.org>
>>>> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>> Cc: linux-pwm@vger.kernel.org
>>>> ---
>>>>    drivers/pwm/core.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>>> index 3dacceaef4a9b..87252b70f1c81 100644
>>>> --- a/drivers/pwm/core.c
>>>> +++ b/drivers/pwm/core.c
>>>> @@ -510,8 +510,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
>>>>    	 */
>>>>    	might_sleep();
>>>> -	if (!pwm || !state || !state->period ||
>>>> -	    state->duty_cycle > state->period)
>>>> +	if (!pwm || !state || (state->enabled &&
>>>> +	    (!state->period || state->duty_cycle > state->period)))
>>>>    		return -EINVAL;
>>>>    	chip = pwm->chip;
>>>
>>> By making the period assertions conditional, you're allowing people to
>>> write garbage period values via sysfs. However you fix the (legitimate)
>>> bug you point out, you shouldn't regress that.
>>
>> I wanted to say, it might be best to fix userspace so that it wouldn't
>> export pwmchip and then suspend without configuring it. But (!) this
>> actually allows userspace to export pwmchip and that way, block suspend
>> completely, because with pwmchip exported and not configured, the system
>> just would not suspend. So, yes, this is a legitimate fix for a real bug,
>> right ?
> 
> It's a real bug, yes. (Quoting myself, "(legitimate) bug you point
> out".)
> 
> But you're introducing the old one again, so I wouldn't call it a
> "legitimate fix."
> 
> commit ef2bf4997f7da6efa8540d9cf726c44bf2b863af
> [...]
>      In particular, I noted that we are now allowing invalid period
>      selections, e.g.:
> 
>        # echo 1 > /sys/class/pwm/pwmchip0/export
>        # cat /sys/class/pwm/pwmchip0/pwm1/period
>        100
>        # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
>        [... driver may or may not reject the value, or trigger some logic bug ...]
> 
> The only difference is that we'll still *eventually* reject it somewhere
> (probably when we try to enable the PWM), but just not at the
> "echo 101 > .../duty_cycle" phase.
> 
>>> (Now, that's sounding
>>> like we could use some unit tests for the PWM framework...)
>>
>> Not just the PWM framework ...
>>
>>> You could, for example, also add the bounds checks to
>>> drviers/pwm/sysfs.c's period_store().
>>>
>>> Or perhaps you could teach the suspend/resume functions to not bother
>>> calling pwm_apply_state() on a disabled PWM.
>>
>> Right, I think it boils down to -- should this be fixed on the sysfs ABI
>> side, or in the pwm core ?
> 
> I don't know if I have a strong preference (I haven't tried to write it
> out to see what looks cleaner / has the fewest holes), I just would
> prefer that this isn't allowed:
> 
>        # echo 1 > /sys/class/pwm/pwmchip0/export
>        # echo 100 > /sys/class/pwm/pwmchip0/pwm1/period
>        ### Should fail with EINVAL:
>        # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle

So, I sent the sysfs variant of this patch just now. I think maybe that 
is the better option.
