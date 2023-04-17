Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4340B6E455F
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Apr 2023 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDQKjM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Apr 2023 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDQKjL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Apr 2023 06:39:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E0559FE
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 03:38:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fw30so10027121ejc.5
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681727821; x=1684319821;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkXKEQvULxKzfD58u+R7FM0H9NpEQGqvZoPv/ny3gvg=;
        b=OWxl665j+6s9ydZX1q5Tp7Idn6Moa/Lhb9I5atGuU6wBfUJndb7YhmvQ75diuKxRG9
         e2krshP5jTSdSFMf/Y7BF/6HicJ3L5qY36hcFnRpo4eZNEiNmN87PCebn30JTv3GU5ET
         P/NRObDq4PJPiBIcrJILHFY1JvJmke+E6FDoeplAOstMavIQmOT1BWJflW5UQlw//oP7
         0oV/NnYM+aJ+2HxTb+AG7DiZ3wPI4YIGa/Oq6N1oHCRg3s+ORQXbNfQikg0tvJgwuWAI
         5wKUEYqNkWNN+P+n9uJi+tcmkcJtdKobtCLgOoW6XhAjaRNttjEYDXMtpiHrjFz2QE6Y
         oSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727821; x=1684319821;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkXKEQvULxKzfD58u+R7FM0H9NpEQGqvZoPv/ny3gvg=;
        b=f1ITqv5YuXwcmKFMkqn26qZrXEhaKmXuNRqrzw39O1qcaX03iTGilPkGlTYLuQ2FN5
         chbLprRlsm6xK1lJDKw9YbEgLbzYXfeSR4eDvO4W/T5bZhLEcO38Mc+r1nxykTEPP6e6
         QhuU3B2i4jMAftdqcmo2qqtU+Pod8Hsey/q425H3qK6ST0X8eYL3jLClEAHhfel1xvbT
         Htwba8Q/5LBHiX+KOTeyeYwT/be//yyIcCAobwC9njIW6C+xgGg0Pi1hpTfWyPxejR/x
         YdgM7RjiR4DInNNkrSa6fbmzU3B9vWWHIeKPa2wh47VtyG0uF8y27JEpmq/JMbZJ9+pr
         xdbQ==
X-Gm-Message-State: AAQBX9fm+FiehxpI16mrGJnGHO7IaH/R1ivfQ8SYMCfu5TSEab+zIKln
        +8EXWKHpbREpgm2IQ0aLIBs=
X-Google-Smtp-Source: AKy350Zo8XAGyX6yT+BuwV2uXPmcvBPlNmJ8H+1hryWR1o4sMwfsyBfdJQJ7UeewxWYJFRo2LMNS1Q==
X-Received: by 2002:a17:907:844:b0:94f:61f5:9ef7 with SMTP id ww4-20020a170907084400b0094f61f59ef7mr3870612ejb.44.1681727820663;
        Mon, 17 Apr 2023 03:37:00 -0700 (PDT)
Received: from ?IPV6:2a01:c22:770d:1c00:59f1:1548:39fc:ccd5? (dynamic-2a01-0c22-770d-1c00-59f1-1548-39fc-ccd5.c22.pool.telefonica.de. [2a01:c22:770d:1c00:59f1:1548:39fc:ccd5])
        by smtp.googlemail.com with ESMTPSA id tg4-20020a1709078dc400b0094ea3a32694sm6265513ejc.190.2023.04.17.03.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 03:37:00 -0700 (PDT)
Message-ID: <872b3270-8319-6b4d-9d52-1da0b58d4e19@gmail.com>
Date:   Mon, 17 Apr 2023 12:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     neil.armstrong@linaro.org, Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
 <ca531c1a-3c62-5fb1-6765-68ec1e541483@linaro.org>
 <73a52391-b380-e491-0e96-5c51c7be487c@gmail.com>
 <22b6f870-8dfd-c01b-a7cd-383a9d9ece20@linaro.org>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
In-Reply-To: <22b6f870-8dfd-c01b-a7cd-383a9d9ece20@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17.04.2023 11:59, neil.armstrong@linaro.org wrote:
> On 17/04/2023 11:53, Heiner Kallweit wrote:
>> On 17.04.2023 09:23, Neil Armstrong wrote:
>>> On 13/04/2023 07:54, Heiner Kallweit wrote:
>>>> Newer versions of the PWM block use a core clock with external mux,
>>>> divider, and gate. These components either don't exist any longer in
>>>> the PWM block, or they are bypassed.
>>>> To minimize needed changes for supporting the new version, the internal
>>>> divider and gate should be handled by CCF too.
>>>>
>>>> I didn't see a good way to split the patch, therefore it's somewhat
>>>> bigger. What it does:
>>>>
>>>> - The internal mux is handled by CCF already. Register also internal
>>>>     divider and gate with CCF, so that we have one representation of the
>>>>     input clock: [mux] parent of [divider] parent of [gate]
>>>>     - Now that CCF selects an appropriate mux parent, we don't need the
>>>>     DT-provided default parent any longer. Accordingly we can also omit
>>>>     setting the mux parent directly in the driver.
>>>>     - Instead of manually handling the pre-div divider value, let CCF
>>>>     set the input clock. Targeted input clock frequency is
>>>>     0xffff * 1/period for best precision.
>>>>     - For the "inverted pwm disabled" scenario target an input clock
>>>>     frequency of 1GHz. This ensures that the remaining low pulses
>>>>     have minimum length.
>>>>
>>>> I don't have hw with the old PWM block, therefore I couldn't test this
>>>> patch. With the not yet included extension for the new PWM block
>>>> (channel->clk coming directly from get_clk(external_clk)) I didn't
>>>> notice any problem. My system uses PWM for the CPU voltage regulator
>>>> and for the SDIO 32kHz clock.
>>>>
>>>> Note: The clock gate in the old PWM block is permanently disabled.
>>>> This seems to indicate that it's not used by the new PWM block.
>>>>
>>>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>> Changes to RFT/RFC version:
>>>> - use parent_hws instead of parent_names for div/gate clock
>>>> - use devm_clk_hw_register where the struct clk * returned by
>>>>     devm_clk_register isn't needed
>>>>
>>>> v2:
>>>> - add patch 1
>>>> - add patch 3
>>>> - switch to using clk_parent_data in all relevant places
>>>> v3:
>>>> - add flag CLK_IGNORE_UNUSED
>>>> v4:
>>>> - remove variable tmp in meson_pwm_get_state
>>>> - don't use deprecated function devm_clk_register
>>>> ---
>>>>    drivers/pwm/pwm-meson.c | 142 +++++++++++++++++++++++-----------------
>>>>    1 file changed, 83 insertions(+), 59 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>>> index 40a8709ff..80ac71cbc 100644
>>>> --- a/drivers/pwm/pwm-meson.c
>>>> +++ b/drivers/pwm/pwm-meson.c
>>>> @@ -51,7 +51,7 @@
>>>>    #define REG_MISC_AB        0x8
>>>>    #define MISC_B_CLK_EN        23
>>>>    #define MISC_A_CLK_EN        15
>>>> -#define MISC_CLK_DIV_MASK    0x7f
>>>> +#define MISC_CLK_DIV_WIDTH    7
>>>>    #define MISC_B_CLK_DIV_SHIFT    16
>>>>    #define MISC_A_CLK_DIV_SHIFT    8
>>>>    #define MISC_B_CLK_SEL_SHIFT    6
>>>> @@ -87,12 +87,13 @@ static struct meson_pwm_channel_data {
>>>>    };
>>>>      struct meson_pwm_channel {
>>>> +    unsigned long rate;
>>>>        unsigned int hi;
>>>>        unsigned int lo;
>>>> -    u8 pre_div;
>>>>    -    struct clk *clk_parent;
>>>>        struct clk_mux mux;
>>>> +    struct clk_divider div;
>>>> +    struct clk_gate gate;
>>>>        struct clk *clk;
>>>>    };
>>>>    @@ -125,16 +126,6 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>>>>        struct device *dev = chip->dev;
>>>>        int err;
>>>>    -    if (channel->clk_parent) {
>>>> -        err = clk_set_parent(channel->clk, channel->clk_parent);
>>>> -        if (err < 0) {
>>>> -            dev_err(dev, "failed to set parent %s for %s: %d\n",
>>>> -                __clk_get_name(channel->clk_parent),
>>>> -                __clk_get_name(channel->clk), err);
>>>> -            return err;
>>>> -        }
>>>> -    }
>>>> -
>>>>        err = clk_prepare_enable(channel->clk);
>>>>        if (err < 0) {
>>>>            dev_err(dev, "failed to enable clock %s: %d\n",
>>>> @@ -157,8 +148,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>>>                  const struct pwm_state *state)
>>>>    {
>>>>        struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
>>>> -    unsigned int duty, period, pre_div, cnt, duty_cnt;
>>>> +    unsigned int duty, period, cnt, duty_cnt;
>>>>        unsigned long fin_freq;
>>>> +    u64 freq;
>>>>          duty = state->duty_cycle;
>>>>        period = state->period;
>>>> @@ -166,7 +158,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>>>        if (state->polarity == PWM_POLARITY_INVERSED)
>>>>            duty = period - duty;
>>>>    -    fin_freq = clk_get_rate(channel->clk);
>>>> +    freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
>>>> +    if (freq > ULONG_MAX)
>>>> +        freq = ULONG_MAX;
>>>> +
>>>> +    fin_freq = clk_round_rate(channel->clk, freq);
>>>>        if (fin_freq == 0) {
>>>>            dev_err(meson->chip.dev, "invalid source clock frequency\n");
>>>>            return -EINVAL;
>>>> @@ -174,46 +170,35 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>>>          dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
>>>>    -    pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>>>> -    if (pre_div > MISC_CLK_DIV_MASK) {
>>>> -        dev_err(meson->chip.dev, "unable to get period pre_div\n");
>>>> -        return -EINVAL;
>>>> -    }
>>>> -
>>>> -    cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
>>>> +    cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC);
>>>>        if (cnt > 0xffff) {
>>>>            dev_err(meson->chip.dev, "unable to get period cnt\n");
>>>>            return -EINVAL;
>>>>        }
>>>>    -    dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
>>>> -        pre_div, cnt);
>>>> +    dev_dbg(meson->chip.dev, "period=%u cnt=%u\n", period, cnt);
>>>>          if (duty == period) {
>>>> -        channel->pre_div = pre_div;
>>>>            channel->hi = cnt;
>>>>            channel->lo = 0;
>>>>        } else if (duty == 0) {
>>>> -        channel->pre_div = pre_div;
>>>>            channel->hi = 0;
>>>>            channel->lo = cnt;
>>>>        } else {
>>>> -        /* Then check is we can have the duty with the same pre_div */
>>>> -        duty_cnt = div64_u64(fin_freq * (u64)duty,
>>>> -                     NSEC_PER_SEC * (pre_div + 1));
>>>> +        duty_cnt = div64_u64(fin_freq * (u64)duty, NSEC_PER_SEC);
>>>>            if (duty_cnt > 0xffff) {
>>>>                dev_err(meson->chip.dev, "unable to get duty cycle\n");
>>>>                return -EINVAL;
>>>>            }
>>>>    -        dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
>>>> -            duty, pre_div, duty_cnt);
>>>> +        dev_dbg(meson->chip.dev, "duty=%u duty_cnt=%u\n", duty, duty_cnt);
>>>>    -        channel->pre_div = pre_div;
>>>>            channel->hi = duty_cnt;
>>>>            channel->lo = cnt - duty_cnt;
>>>>        }
>>>>    +    channel->rate = fin_freq;
>>>> +
>>>>        return 0;
>>>>    }
>>>>    @@ -223,16 +208,15 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>>>>        struct meson_pwm_channel_data *channel_data;
>>>>        unsigned long flags;
>>>>        u32 value;
>>>> +    int err;
>>>>          channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
>>>>    -    spin_lock_irqsave(&meson->lock, flags);
>>>> +    err = clk_set_rate(channel->clk, channel->rate);
>>>> +    if (err)
>>>> +        dev_err(meson->chip.dev, "setting clock rate failed\n");
>>>>    -    value = readl(meson->base + REG_MISC_AB);
>>>> -    value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
>>>> -    value |= channel->pre_div << channel_data->clk_div_shift;
>>>> -    value |= BIT(channel_data->clk_en_bit);
>>>> -    writel(value, meson->base + REG_MISC_AB);
>>>> +    spin_lock_irqsave(&meson->lock, flags);
>>>>          value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
>>>>            FIELD_PREP(PWM_LOW_MASK, channel->lo);
>>>> @@ -271,16 +255,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>                /*
>>>>                 * This IP block revision doesn't have an "always high"
>>>>                 * setting which we can use for "inverted disabled".
>>>> -             * Instead we achieve this using the same settings
>>>> -             * that we use a pre_div of 0 (to get the shortest
>>>> -             * possible duration for one "count") and
>>>> +             * Instead we achieve this by setting an arbitrary,
>>>> +             * very high frequency, resulting in the shortest
>>>> +             * possible duration for one "count" and
>>>>                 * "period == duty_cycle". This results in a signal
>>>>                 * which is LOW for one "count", while being HIGH for
>>>>                 * the rest of the (so the signal is HIGH for slightly
>>>>                 * less than 100% of the period, but this is the best
>>>>                 * we can achieve).
>>>>                 */
>>>> -            channel->pre_div = 0;
>>>> +            channel->rate = 1000000000;
>>>>                channel->hi = ~0;
>>>>                channel->lo = 0;
>>>
>>> This looks like a really bad idea... please don't do that and instead introduce
>>> some pinctrl states where we set the PWM pin as GPIO mode high/low state like we
>>> did for SPI:
>>> https://lore.kernel.org/r/20221004-up-aml-fix-spi-v4-2-0342d8e10c49@baylibre.com
>>>
>>
>> There's no behavior change in this patch set. So my understanding is that you'd
>> like to change the current behavior independent of the CCF-related changes.
> 
> There's a behavior change since you change the calculation with a radically different
> algorithm.
> 
Setting an input clock rate of 1GHz will result in pre_div = 0 with (where available)
mux parent fdiv3 (850MHz). So it's the same duty cycle as before, just with a different
period. The applied logic is the same as before and as described in the comment
"get the shortest possible duration for one count"

> Neil
> 
>>
>> For the updated PWM block (at least for S905X3, not sure with which family Amlogic
>> extended the PWM block) we have an integrated option to achieve constant low/high
>> output. It's just not implemented yet, it's something I may do as next step.
>> The extended PWM block added new bits pwm_A/B_constant_en that prevent the default
>> increment of the hi/lo period. By supporting these bits we can achieve value 0
>> for hi/lo.
>> IMO that's easier than adding pinctrl handling. The remaining question would be
>> whether it's worth it to add pinctrl handling just for the legacy version of the
>> PWM block.
>>
> 

