Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7470E549
	for <lists+linux-pwm@lfdr.de>; Tue, 23 May 2023 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjEWTWm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 May 2023 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEWTWl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 May 2023 15:22:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D081AFA
        for <linux-pwm@vger.kernel.org>; Tue, 23 May 2023 12:22:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-970028cfb6cso458506866b.1
        for <linux-pwm@vger.kernel.org>; Tue, 23 May 2023 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684869758; x=1687461758;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQvOP1To6uswMsOAgX+wydziU3ikh32rg406MHCEJvQ=;
        b=Imt/heBbPK5enzJ/+uQOpGPSBetOiAG4vxIoP7VWVsv1C/PC9qc6zOU8YxnmYrL1Aa
         BH42vxAiOPPpvWmMvmI8LztQX+Eg2VPuAdFJJr9a4jXBNB2alTvX3p0phJjSpD/tavIK
         70bdQ6msZg3rNNr3JqGR/ZRO9xMMXy5Gm1VFXbJaKOy/YdJFbO8fArFkXDXq36Gp/l8g
         fi2EfjcutU2f1yVkCyjdcFStdNpmaPFB1qI2Y/ZHwKvpsiPaP6vTzM+3lepWtost4H/F
         p2x6+1vidRKv2tUNVLgCYz0uiJgBPrz1xq3t9jU4jsAhtI/+4+mrQ+sVbXN8SU4fhoCu
         2e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684869758; x=1687461758;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQvOP1To6uswMsOAgX+wydziU3ikh32rg406MHCEJvQ=;
        b=kV5bc0LN8m4sMQrLVmE0PCiERa8fVkSXGsfCxN59Xq5/SUs0ynplFthEeVvPvXB2Vp
         QKcnPp0VbgOsSI4l4/o8UvfQw+J4k6ljwZxXdtAztAMz1rtOidCknDsrjsBL+LUf3PYE
         fQov+KrxpCKmVC4VNR4SXXrjRFrjxl+I/b6PuMaPhUCvEloYDAWGneRfBwnmBCXNIj7l
         YR82LtlOJS7wCMU/xwb2kUu+PFf8HeZ1WhUc/mwR4ozrQXkqoG5cmPHTApGmYKa2j1NX
         WK0gct4jgh0ut7yvYtBwPnYvYOVZ4mcwIJToWxdwJ8JGKCbjZYfDNiRPWK+0wUpz2dED
         7bVA==
X-Gm-Message-State: AC+VfDyRZ35v14nmU34oQQmlMiL063vxS8WbIUILprI54rGDCwFFj5+b
        SZXYOjKPfSPTfYzaCMe6FhE=
X-Google-Smtp-Source: ACHHUZ5OYQM2FnvzBTQuZ3h0GRuxk+SoC9XF5awTAAP97yY5Qs/4wBk7ez84pB3bxdqzARK+qjt5MQ==
X-Received: by 2002:a17:907:3e24:b0:96a:5bdd:7557 with SMTP id hp36-20020a1709073e2400b0096a5bdd7557mr15607406ejc.70.1684869758106;
        Tue, 23 May 2023 12:22:38 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4b9:3000:6c58:d026:2a46:c9d0? (dynamic-2a01-0c23-c4b9-3000-6c58-d026-2a46-c9d0.c23.pool.telefonica.de. [2a01:c23:c4b9:3000:6c58:d026:2a46:c9d0])
        by smtp.googlemail.com with ESMTPSA id ja26-20020a170907989a00b0096b55be592asm4745291ejc.92.2023.05.23.12.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 12:22:37 -0700 (PDT)
Message-ID: <97bac3d9-b497-c54b-05dd-da8d09166f70@gmail.com>
Date:   Tue, 23 May 2023 21:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "rockosov@gmail.com" <rockosov@gmail.com>,
        kernel <kernel@sberdevices.ru>
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
 <tyuyderm7i6otsgrntw2wj4k4ii5xwp2vngfa76eaguki7yuqa@322cjuotnr6q>
 <29961a2e-5367-0685-0f3a-1910328ad3ab@gmail.com>
 <20230522133739.7tc35zr2npsysopd@CAB-WSD-L081021>
 <2ae9890d-9118-ba5a-0fbf-0b657c8b7be4@gmail.com>
 <20230523102848.32prkwhqvm7v53ps@CAB-WSD-L081021>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
In-Reply-To: <20230523102848.32prkwhqvm7v53ps@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23.05.2023 12:28, Dmitry Rokosov wrote:
> Heiner,
> 
> On Mon, May 22, 2023 at 10:10:41PM +0200, Heiner Kallweit wrote:
>> On 22.05.2023 15:37, Dmitry Rokosov wrote:
>>> Heiner,
>>>
>>> On Fri, May 19, 2023 at 06:53:30PM +0200, Heiner Kallweit wrote:
>>>> On 19.05.2023 17:30, Dmitry Rokosov wrote:
>>>>> Hello Heiner,
>>>>>
>>>>> Thank you for the patch series!
>>>>>
>>>>> I am currently working on the Amlogic A1 clock driver and other
>>>>> peripheral devices, including PWM. During a discussion about the clock
>>>>> driver with Martin Blumenstingl, we found an intersection between the
>>>>> clock driver and your PWM CCF support patch series. Please see my
>>>>> comments below.
>>>>>
>>>>> On Thu, Apr 13, 2023 at 07:54:46AM +0200, Heiner Kallweit wrote:
>>>>>> Newer versions of the PWM block use a core clock with external mux,
>>>>>> divider, and gate. These components either don't exist any longer in
>>>>>> the PWM block, or they are bypassed.
>>>>>> To minimize needed changes for supporting the new version, the internal
>>>>>> divider and gate should be handled by CCF too.
>>>>>>
>>>>>> I didn't see a good way to split the patch, therefore it's somewhat
>>>>>> bigger. What it does:
>>>>>>
>>>>>> - The internal mux is handled by CCF already. Register also internal
>>>>>>   divider and gate with CCF, so that we have one representation of the
>>>>>>   input clock: [mux] parent of [divider] parent of [gate]
>>>>>>   
>>>>>> - Now that CCF selects an appropriate mux parent, we don't need the
>>>>>>   DT-provided default parent any longer. Accordingly we can also omit
>>>>>>   setting the mux parent directly in the driver.
>>>>>>   
>>>>>> - Instead of manually handling the pre-div divider value, let CCF
>>>>>>   set the input clock. Targeted input clock frequency is
>>>>>>   0xffff * 1/period for best precision.
>>>>>>   
>>>>>> - For the "inverted pwm disabled" scenario target an input clock
>>>>>>   frequency of 1GHz. This ensures that the remaining low pulses
>>>>>>   have minimum length.
>>>>>>
>>>>>> I don't have hw with the old PWM block, therefore I couldn't test this
>>>>>> patch. With the not yet included extension for the new PWM block
>>>>>> (channel->clk coming directly from get_clk(external_clk)) I didn't
>>>>>> notice any problem. My system uses PWM for the CPU voltage regulator
>>>>>> and for the SDIO 32kHz clock.
>>>>>>
>>>>>> Note: The clock gate in the old PWM block is permanently disabled.
>>>>>> This seems to indicate that it's not used by the new PWM block.
>>>>>>
>>>>>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>> ---
>>>>>> Changes to RFT/RFC version:
>>>>>> - use parent_hws instead of parent_names for div/gate clock
>>>>>> - use devm_clk_hw_register where the struct clk * returned by
>>>>>>   devm_clk_register isn't needed
>>>>>>
>>>>>> v2:
>>>>>> - add patch 1
>>>>>> - add patch 3
>>>>>> - switch to using clk_parent_data in all relevant places
>>>>>> v3:
>>>>>> - add flag CLK_IGNORE_UNUSED
>>>>>> v4:
>>>>>> - remove variable tmp in meson_pwm_get_state
>>>>>> - don't use deprecated function devm_clk_register
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -166,7 +158,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>>>>>  	if (state->polarity == PWM_POLARITY_INVERSED)
>>>>>>  		duty = period - duty;
>>>>>>  
>>>>>> -	fin_freq = clk_get_rate(channel->clk);
>>>>>> +	freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
>>>>>> +	if (freq > ULONG_MAX)
>>>>>> +		freq = ULONG_MAX;
>>>>>> +
>>>>>> +	fin_freq = clk_round_rate(channel->clk, freq);
>>>>>>  	if (fin_freq == 0) {
>>>>>>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
>>>>>>  		return -EINVAL;
>>>>>
>>>>> As mentioned previously, we have discussed one optimization for PWM
>>>>> parent clock calculation. Many modern Amlogic SoCs include an RTC clock
>>>>> within the clock tree. This clock provides a stable and efficient 32kHz
>>>>> input for several clock objects that can be inherited through the muxes
>>>>> from the RTC clock.
>>>>>
>>>>> In short, we aim to use the RTC clock parent directly for PWM to
>>>>> generate a 32kHz clock on the PWM lines. Martin has suggested one way to
>>>>> do so, which is described in [0]. You can also refer to our IRC
>>>>> discussion in [1].
>>>>>
>>>>> I would appreciate your thoughts on this. Please let me know what you
>>>>> think.
>>>>>
>>>>
>>>> Requesting a frequency of (NSEC_PER_SEC * 0xffffULL / period) is based
>>>> on the assumption that the highest possible input frequency always
>>>> allows to generate a period that is close enough to the requested period.
>>>>
>>>> To find the best parent you'd need a somewhat more complex logic outside CCF.
>>>> What you want is the parent where (f_parent * period / NSEC_PER_SEC) is
>>>> closest to an integer in the range 1 .. 0xffff.
>>>> IOW: max(abs((f_parent * period) % 10^9 - 5 * 10^8))
>>>>
>>>> This can be done, question is whether it's needed and worth the effort.
>>>>
>>>> This would be the generic solution. If you just want to handle the case
>>>> that period 1/32.768Hz is requested, an adjusted version of Martins's
>>>> pseudo-code formula should do.
>>>> Best I think as follow-up to my series.
>>>>
>>>
>>> Certainly, if possible, please include this special case in the next
>>> version of your series. Appreciate it!
>>>
>>
>> The currently supported SoC generations don't support the RTC PWM mux
>> input. Changes for not yet supported SoC generations I'd like to keep
>> outside the scope of the CCF conversion patch series.
>> Such a change could be part of a series adding A1 support.
>> However it's good that that the type of needed change is being discussed
>> now, better than potentially finding out later that the CCF conversion
>> is incompatible with what's needed to support newer SoC generations.
>>
>> For my understanding:
>> A1 like S4 and SC2 has the PWM clock handling removed from the PWM block?
>>
> 
> Yes, that's correct. PWM clocks are external to A1 and S4 pwm block, and
> they are currently located in the Peripherals clock controller. We made
> some changes to the PWM driver to support this behavior in the current
> version, which is very similar to your 'ext_clk' patchset. However, we
> did not send it because of your patch series with fully CCF support.
> 

Once CCF is fully supported, the extension needed to support an external
PWM input clock is very small.
Before submitting the (hopefully) final version of the CCF conversion
patch set, few pending patches should have been applied, however this
seems to take some time.

