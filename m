Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F316FFD4C
	for <lists+linux-pwm@lfdr.de>; Fri, 12 May 2023 01:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbjEKXcy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 May 2023 19:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbjEKXcy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 May 2023 19:32:54 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F42170D
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 16:32:52 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F235A858D6;
        Fri, 12 May 2023 01:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683847970;
        bh=Z2lRg5npL94Lq0Ygpbzq54H9geMz6i7bPkOnbGjyhJk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=doCffZPlVjF4rKS/wZh6SFeZ0Z+7JnAnsDAZsEey+ln2tPNJlQPbEj5Vej/P8QLrf
         oe43oKlGHodc+Hj77CvTylekrkoQkXRPfslqHoIyJP1X/QX2mv35DfAvXARKV1dihX
         f/JFMbKLBYQmqwqe7YkXLm011yaYJHmhXcDy2eQe/2Ot4m3YynvzT8RLQoQt7XClo5
         jJ6iMY2BE0S8UQb3vPx5KynNJV5BkCcOCrkIt5bezzmAVwHc6c08gFpOuYh2QeJWv1
         N9WtONTMts3NiAc3QWT7OZ242BiBBISZJsEM+fpQJ/q0JGWk66x9fT/AY0g+TggYzL
         96BwQEuIvl4HQ==
Message-ID: <52131759-457b-12ba-ef05-b91eafd7d342@denx.de>
Date:   Fri, 12 May 2023 01:32:49 +0200
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
 <ZF1ZMNBMxLqNI0zh@google.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ZF1ZMNBMxLqNI0zh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/11/23 23:08, Brian Norris wrote:
> Hi,

Hi,

> On Thu, May 11, 2023 at 08:18:53PM +0200, Marek Vasut wrote:
>> In case the PWM is not enabled, the period can still be left unconfigured,
>> i.e. zero . Currently the pwm_class_apply_state() errors out in such a case.
>> This e.g. makes suspend fail on systems where pwmchip has been exported via
>> sysfs interface, but left unconfigured before suspend occurred.
>>
>> Failing case:
>> "
>> $ echo 1 > /sys/class/pwm/pwmchip4/export
>> $ echo mem > /sys/power/state
>> ...
>> pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns -22
>> pwm pwmchip4: PM: failed to suspend: error -22
>> PM: Some devices failed to suspend, or early wake event detected
>> "
>>
>> Working case:
>> "
>> $ echo 1 > /sys/class/pwm/pwmchip4/export
>> $ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
>> $ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
>> $ echo mem > /sys/power/state
>> ...
>> "
>>
>> Permit unset period in pwm_class_apply_state() in case the PWM is disabled
>> to fix this issue.
>>
>> Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: linux-pwm@vger.kernel.org
>> ---
>>   drivers/pwm/core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 3dacceaef4a9b..87252b70f1c81 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -510,8 +510,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
>>   	 */
>>   	might_sleep();
>>   
>> -	if (!pwm || !state || !state->period ||
>> -	    state->duty_cycle > state->period)
>> +	if (!pwm || !state || (state->enabled &&
>> +	    (!state->period || state->duty_cycle > state->period)))
>>   		return -EINVAL;
>>   
>>   	chip = pwm->chip;
> 
> By making the period assertions conditional, you're allowing people to
> write garbage period values via sysfs. However you fix the (legitimate)
> bug you point out, you shouldn't regress that.

I wanted to say, it might be best to fix userspace so that it wouldn't 
export pwmchip and then suspend without configuring it. But (!) this 
actually allows userspace to export pwmchip and that way, block suspend 
completely, because with pwmchip exported and not configured, the system 
just would not suspend. So, yes, this is a legitimate fix for a real 
bug, right ?

> (Now, that's sounding
> like we could use some unit tests for the PWM framework...)

Not just the PWM framework ...

> You could, for example, also add the bounds checks to
> drviers/pwm/sysfs.c's period_store().
> 
> Or perhaps you could teach the suspend/resume functions to not bother
> calling pwm_apply_state() on a disabled PWM.

Right, I think it boils down to -- should this be fixed on the sysfs ABI 
side, or in the pwm core ?
