Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FB700789
	for <lists+linux-pwm@lfdr.de>; Fri, 12 May 2023 14:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbjELMUV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 May 2023 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjELMUT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2023 08:20:19 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AEB8A7F
        for <linux-pwm@vger.kernel.org>; Fri, 12 May 2023 05:20:17 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C7E3286264;
        Fri, 12 May 2023 14:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683894014;
        bh=BeGeS8DBXTksYwfDvNe1aijrHzlpxr0LEW8RN3dfa4E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s2slS/Kbty5NtqIXcNd+SxnNWZhTvj6APmUVJpvxDzTJbhZrL4SDvxWnoxRrjfKy4
         DpLzejHCt9eI93jyaZsD8nPbvppMh52cTorNcbaffqCbyMVBVy+i2pyTkeK1JwNm5u
         fvnF+pG23W6BKqIET4n13JNZsLEhOu01/8Jul1uPTC1AIi0lltb68wHaTTNzvlDsAG
         6uk7LHqdiw57ptidiMMXnOVrw+hXWKnWIijlyEsCrPmrKUYTSQ/Z+d4Udv7yhMcimv
         5Tx+EQRENzczJdrS2TL2C5qmpm8wBMR+z9NvR+BTZWw4sEYhVWDF+4zWHTyqZOVul1
         pAbxO0Dxz68Tg==
Message-ID: <d33a20a5-33e3-16a0-6b7c-7b0ec44fc3b3@denx.de>
Date:   Fri, 12 May 2023 14:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pwm: core: Permit unset period when applying
 configuration of disabled PWMs
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230511181853.185685-1-marex@denx.de>
 <20230512062227.5buu6mhgxajvjhqf@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230512062227.5buu6mhgxajvjhqf@pengutronix.de>
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

On 5/12/23 08:22, Uwe Kleine-König wrote:
> Hello Marek,
> 
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
> 
> While I tend to agree that the checks about period and duty_cycle are
> (somewhat) irrelevant if enabled == false, I fear we'd break assumptions
> here as some drivers configure duty_cycle/period in hardware even with
> .enabled == false, and so proably rely on period > 0 and duty_cycle <=
> period.
> 
> Another approach would be to skip pwm_apply_state() in
> pwm_class_suspend() if the state is already disabled. That one sounds
> safer.

I am not convinced that would be identical behavior.

If we skip apply_state call on PWMs exported via sysfs interface which 
are enabled=false , then the drivers wouldn't have their apply_state 
callback called to disable the PWM before suspend ... I think ... which 
seems like a problem to me ?
