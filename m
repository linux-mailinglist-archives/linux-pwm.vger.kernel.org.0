Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5D598E1A
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Aug 2022 22:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbiHRUeO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Aug 2022 16:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345577AbiHRUeN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Aug 2022 16:34:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FF47BA9;
        Thu, 18 Aug 2022 13:34:10 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 830566601B46;
        Thu, 18 Aug 2022 21:34:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660854849;
        bh=3McgXyA2V1HlrJJ8k6J3er3Mn2T7ge7Jotci/sbzqxw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f6/YMyW1rN0mrl48pL0EhtaCJcSwmXUxUje8WhpYKxH9Qhc+rr5SN7bCO/D5wr2mp
         npvXcUasTAyW967dIba/t+ZVISrSCKgKslBSUce0ie1zuaJTIqyOe2E2CSB3kNa76Z
         UH01rXSV0WZIs1Adx2hdGzJTwSpZ/fLn/YQL9MHDksvuRH+c1qaV/3SHpycsUgkwUy
         mMqxFeHbxF/hLZzUNFIFI4IL56RQNrDFkh+DqrJfR84ENh9OREJ97H50YhwkbsJumX
         mBs6k13HLZcQnOixJO5baQxenyiVjC9vT/NK1ygOO+QgLM1iVL16JqYc4UQ7RzmP2H
         qI6t9JePt+fug==
Message-ID: <8ba9431b-b2bf-9fb0-9ba7-afeb2c3bce94@collabora.com>
Date:   Thu, 18 Aug 2022 23:34:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-tegra@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Graichen <thomas.graichen@gmail.com>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
 <20220818075401.wguqvcbhzj5ttnio@pengutronix.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220818075401.wguqvcbhzj5ttnio@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 8/18/22 10:54, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Aug 15, 2022 at 09:09:35AM +0200, Uwe Kleine-König wrote:
>> On Mon, Aug 15, 2022 at 03:28:25AM +0300, Dmitry Osipenko wrote:
>>> 25.04.2022 16:22, Uwe Kleine-König пишет:
>>>> Dividing by the result of a division looses precision because the result is
>>>> rounded twice. E.g. with clk_rate = 48000000 and period = 32760033 the
>>>> following numbers result:
>>>>
>>>> 	rate = pc->clk_rate >> PWM_DUTY_WIDTH = 187500
>>>> 	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) = 3052
>>>> 	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) = 6144
>>>>
>>>> The exact result would be 6142.5061875 and (apart from rounding) this is
>>>> found by using a single division. As a side effect is also a tad
>>>> cheaper to calculate.
>>>>
>>>> Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
>>>> example clk_rate = 47999999 and period = 106667:
>>>>
>>>> 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
>>>> 			    NSEC_PER_SEC) = 19
>>>>
>>>> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
>>>> 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) = 20
>>>>
>>>> (The exact result is 20.000062083332033.)
>>>>
>>>> With this optimizations also switch from round-closest to round-down for
>>>> the period calculation. Given that the calculations were non-optimal for
>>>> quite some time now with variations in both directions which nobody
>>>> reported as a problem, this is the opportunity to align the driver's
>>>> behavior to the requirements of new drivers. This has several upsides:
>>>>
>>>>  - Implementation is easier as there are no round-nearest variants of
>>>>    mul_u64_u64_div_u64().
>>>>  - Requests for too small periods are now consistently refused. This was
>>>>    kind of arbitrary before, where period_ns < min_period_ns was
>>>>    refused, but in some cases min_period_ns isn't actually implementable
>>>>    and then values between min_period_ns and the actual minimum were
>>>>    rounded up to the actual minimum.
>>>>
>>>> Note that the duty_cycle calculation isn't using the usual round-down
>>>> approach yet.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> ---
>>>> Hello,
>>>>
>>>> changes since (implicit) v1: Updated changelog to explain why rate = 0
>>>> is refused now.
>>>>
>>>> Best regards
>>>> Uwe
>>>>
>>>>  drivers/pwm/pwm-tegra.c | 10 +++++-----
>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
>>>> index e5a9ffef4a71..7fc03a9ec154 100644
>>>> --- a/drivers/pwm/pwm-tegra.c
>>>> +++ b/drivers/pwm/pwm-tegra.c
>>>> @@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>  			    int duty_ns, int period_ns)
>>>>  {
>>>>  	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
>>>> -	unsigned long long c = duty_ns, hz;
>>>> +	unsigned long long c = duty_ns;
>>>>  	unsigned long rate, required_clk_rate;
>>>>  	u32 val = 0;
>>>>  	int err;
>>>> @@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>  		pc->clk_rate = clk_get_rate(pc->clk);
>>>>  	}
>>>>  
>>>> -	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
>>>> -
>>>>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
>>>> -	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
>>>> -	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
>>>> +	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
>>>> +				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
>>>>  
>>>>  	/*
>>>>  	 * Since the actual PWM divider is the register's frequency divider
>>>> @@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>  	 */
>>>>  	if (rate > 0)
>>>>  		rate--;
>>>> +	else
>>>> +		return -EINVAL;
>>>
>>> This patch broke backlight on Asus Transformer tablets, they are now
>>> getting this -EINVAL. The root of the problem is under investigation.
>>
>> This means that you requested a period that is smaller than the minimal
>> period the hardware can implement.
>>
>> What is the clk rate of the PWM clk (i.e. pc->clk_rate?). Looking at
>> arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi I guess period is
>> 4000000. That in turn would mean that
>>
>> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns, (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH)
>>
>> returned 0 which (with the assumption period_ns = 4000000) would imply
>> the clk rate is less than 64000.
>>
>> I don't know the machine, but some more information would be good: What
>> is the actual clock rate? Can you please enable PWM_DEBUG (at compile
>> time) and tracing (at runtime) (i.e.
>>
>> 	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
>>
>> ), reproduce the problem and provide the trace (i.e.
>>
>> 	cat /sys/kernel/debug/tracing/trace
>>
>> )?
>>
>>> Should we revert this patch meantime or maybe you (Uwe/Thierry) have an
>>> idea about what actually has gone wrong here? Thanks in advance.
>>
>> I'd like to understand if the problem is indeed that the backlight
>> driver requests a too small period. In this case I'd prefer to adapt the
>> backlight device to use better pwm settings. If there is a problem in
>> my change, this needs to be fixed. If you provide the above data, I can
>> check the details.
> 
> I'd like to get this regression fixed and so a feedback from your side
> would be highly appreciated. Without further input I'm unable to debug
> this and a revert would be a sad outcome. Can you at least work out the
> clk rate, which might be possible by looking into
> /sys/kernel/debug/clk/clk_summary.

+ Thomas Graichen, who reported on irc that it also broke backlight on
Nyan Big Chromebook

-- 
Best regards,
Dmitry
