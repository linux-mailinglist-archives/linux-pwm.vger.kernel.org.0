Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0756CAB2F
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Mar 2023 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC0RAo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Mar 2023 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjC0RAn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2023 13:00:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD1C30E3
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 10:00:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so39066498edo.2
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679936441;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPebmcGvKPuiIF1WigjecPK4Lynxv5uNfa44AS9EEuI=;
        b=Jg8AalIJn5rXKUDX5zwt+3bVouPsFckGcO+hxwbeXCqYTnlIXYre29u0UG6NXcMNea
         6YbbPiv48FTGByPKduZ3y6BxTwn9oHOLNi5Dlgs8wzQrieKkXz0X7rqR6dhK/5LS0tyl
         IX6gEd95zh4Zv2SbtlKdM9UK5UI7RCGWMz4Hl32btFZwOvOhNWVBs6eO3Z3x52jHQBQ8
         cwlhTqi/BrN4OnjTflZ1ZOxS/Ggv+JYYfbPiIXu08aEwEvwbad9AvSJNoNiDbCK+TmXy
         e11HJlTkZFk7NzWs2xZLNu2rCwNDBjujBxLvxdTp1m9PO+FrJV6CPpHLe/u7cmdSs/9q
         cpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936441;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPebmcGvKPuiIF1WigjecPK4Lynxv5uNfa44AS9EEuI=;
        b=b6R0ohVWsCo8xCcQMVVykYlPf/HujxNtZIbeJMulDdxQ4nPd1T5DY0KuJfREi2YKZM
         yIuw/zqkO32ZuzLWtyKTFTJ4asJuvWhq2P/KZXf4mZbbhUgPhJC9YmcbIAeyNJRXmZLX
         +ZCtuhMLdLmTWKRuaNZjwCIUFLNu+Mtra0/7F96daZNjCqOxmgqpg4PkrMs8JeC3fiSt
         vPkMpuB0Y3ZRnprA9mdobXyGDhgmDS7l5xig1+xS37g4ahv9yMl9xp0D6hdjxYlzVxCm
         ttGgN9YqGte714ZRm8CH2v6IzWJuVw33aKElnNP8F/Gxoc+n36FIETxhwW83ybQfKWN/
         VHFQ==
X-Gm-Message-State: AAQBX9dsU0QPnjvyLBpne7qkS7vAiw3fdpHpbHihEiOm6eRlYx5GaPEJ
        xMGKchNqS9psHY8sT73IceE=
X-Google-Smtp-Source: AKy350aYlCm+pZrAYFjmv/DHFHxv9TEvq+ezeh0Z7s6CilpjJ/IyOtB/DMAoIxvTtDhf34zNaPWbGg==
X-Received: by 2002:a17:906:e8c:b0:8b2:7564:dfd5 with SMTP id p12-20020a1709060e8c00b008b27564dfd5mr12765360ejf.60.1679936440657;
        Mon, 27 Mar 2023 10:00:40 -0700 (PDT)
Received: from ?IPV6:2a02:3100:91f1:2a00:c022:d3da:60a9:9c00? (dynamic-2a02-3100-91f1-2a00-c022-d3da-60a9-9c00.310.pool.telefonica.de. [2a02:3100:91f1:2a00:c022:d3da:60a9:9c00])
        by smtp.googlemail.com with ESMTPSA id h25-20020a1709063c1900b008e8e975e185sm14192054ejg.32.2023.03.27.10.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 10:00:40 -0700 (PDT)
Message-ID: <45dbd1d4-a2b8-af33-beec-64906c0e98da@gmail.com>
Date:   Mon, 27 Mar 2023 19:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
 <3492657f-6cc2-5828-b153-30c609a92783@linaro.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
In-Reply-To: <3492657f-6cc2-5828-b153-30c609a92783@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 27.03.2023 09:33, Neil Armstrong wrote:
> On 24/03/2023 23:23, Heiner Kallweit wrote:
>> This adds pwm support for (at least) the s4 chip family. The extension
>> is based on the vendor driver that can be found at [0]. There the
>> version with the new clock handling is called meson-v2-pwm.
>> Central change is that the clock is now fully provided by the SoC clock
>> core. The multiplexer isn't any longer part of the pwm block.
>>
>> This was tested on a sc2-based system that uses the same pwm block.
>>
>> [0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pwm-meson.c
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> Adding the amlogic,meson-s4-pwm compatible to the documentation was part
>> of the yaml conversion already.
>> ---
>>   drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++++++++++++++----
>>   1 file changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 16d79ca5d..7a93fdada 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -98,6 +98,7 @@ struct meson_pwm_channel {
>>   struct meson_pwm_data {
>>       const char * const *parent_names;
>>       unsigned int num_parents;
>> +    unsigned int ext_clk:1;
> 
> Drop the :1, the compiler will align the struct size to the register size, so simply use unsigned int or bool.
> 
Having one flag only it doesn't really make a difference, right.
I chose this single bit because in future there may come another flag,
then having them in one bitfield would be advantageous.

Also https://www.kernel.org/doc/Documentation/process/coding-style.rst
Part "17) Using bool" prefers bits for bool values in structs, even though
the mentioned use cases like multiple flags don't apply here.

> I'd use a better name for that, like: no_mux_blk, pwm_clk_input....
> 
OK

>>   };
>>     struct meson_pwm {
>> @@ -158,6 +159,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>       struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
>>       unsigned int duty, period, pre_div, cnt, duty_cnt;
>>       unsigned long fin_freq;
>> +    int err;
>>         duty = state->duty_cycle;
>>       period = state->period;
>> @@ -165,6 +167,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>       if (state->polarity == PWM_POLARITY_INVERSED)
>>           duty = period - duty;
>>   +    if (meson->data->ext_clk) {
>> +        err = clk_set_rate(channel->clk, 0xffffUL * NSEC_PER_SEC / period);
>> +        if (err) {
>> +            dev_err(meson->chip.dev, "failed to set pwm clock rate\n");
>> +            return err;
>> +        }
> 
> If the same MUX architecture has been moved out of the PWM registers, then why would you call
> set_rate ? we don't call set_rate today, so why should we ?
> 
> Today the MUX selection is static depending on the clk names specified in the bindings (yes it's
> really not the good way to do that,....) but now the MUX is outside the PWM registers block
> we should stick to the same architecture and mark the MUX as NO_REPARENT and instead of using
> a bad bindings specify the MUX parent & rate in dt using assigned-clk-parent/rate.
> 
> So please drop this set_rate().
> 
Implicitly there's a set_rate() also today, by setting the pre_div divider value.
By the way: Not sure why the divider isn't handled via CCF, like e.g. in meson-gx-mmc.

The best (for achieving best precision) input frequency is 0xffff / period.
So we should do our best to come as close as possible to this frequency.
By using set_rate() CCF will choose the optimal mux input and divider value.
Not sure why we should restrict ourselves to one mux parent only.
E.g. for a very low duty cycle a higher input frequency than the xtal 24MHz may be preferable.

Not only the mux is outside the PWM block now, also the divider (8 bit wide instead of 7 bit
as of today). So we need a set_rate() anyway to set the divider value.
What I can't say is whether the internal divider still exists (then external and internal
divider would be cascaded) or is removed or bypassed.
It seems like when adding the external PWM clock feature Amlogic forgot to update
the PWM block documentation, as there's no reference at all to the now external input clock
(except in the clocks section).

>> +    }
>> +
>>       fin_freq = clk_get_rate(channel->clk);
>>       if (fin_freq == 0) {
>>           dev_err(meson->chip.dev, "invalid source clock frequency\n");
>> @@ -173,10 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>         dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
>>   -    pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>> -    if (pre_div > MISC_CLK_DIV_MASK) {
>> -        dev_err(meson->chip.dev, "unable to get period pre_div\n");
>> -        return -EINVAL;
>> +    if (meson->data->ext_clk) {
>> +        pre_div = 0;
>> +    } else {
>> +        pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>> +        if (pre_div > MISC_CLK_DIV_MASK) {
>> +            dev_err(meson->chip.dev, "unable to get period pre_div\n");
>> +            return -EINVAL;
>> +        }
>>       }
>>         cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
>> @@ -445,6 +459,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
>>       .num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>>   };
>>   +static const struct meson_pwm_data pwm_s4_data = {
>> +    .ext_clk = 1,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>       {
>>           .compatible = "amlogic,meson8b-pwm",
>> @@ -478,6 +496,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>           .compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>           .data = &pwm_g12a_ao_cd_data
>>       },
>> +    {
>> +        .compatible = "amlogic,meson-s4-pwm",
> 
> This deserved a bindings update, and we should perhaps start a new bindings by using
> new clock-names (!= clkin0/1) to differentiate from the old buggy bindings.
> 
We could simply name the clocks pwm_a, pwm_b. If you think this could be confusing
for pwm PWM_C/PWM_D, then we may use pwm0 and pwm1.

The changed binding would have to reflect that now both input clocks for a pwm
are required.

> Neil
> 
>> +        .data = &pwm_s4_data
>> +    },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>> @@ -493,6 +515,14 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>>       for (i = 0; i < meson->chip.npwm; i++) {
>>           struct meson_pwm_channel *channel = &meson->channels[i];
>>   +        if (meson->data->ext_clk) {
>> +            snprintf(name, sizeof(name), "clkin%u", i);
>> +            channel->clk = devm_clk_get(dev, name);
>> +            if (IS_ERR(channel->clk))
>> +                return PTR_ERR(channel->clk);
>> +            continue;
>> +        }
>> +
>>           snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>>             init.name = name;
> 

