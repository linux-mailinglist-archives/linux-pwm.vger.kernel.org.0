Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A66E06C9
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDMGMB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 02:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMGMB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 02:12:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF95FC6
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 23:11:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id he13so12801060wmb.2
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681366318; x=1683958318;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awOm9muSY38mDgU9YNhlhDcoLFSx4493kH/RGeG3QLA=;
        b=Lh/ncrEBpXTUpaccGXNfGHsXix7yWcntwG084k9e5GjA45WCjfU7gD1bdGYuX1Q1Me
         /NerKj4eJgD+47lsCS52i80X1kLndjrbLQs5c2it8RpWvtNYPHXTlsPGP7je1xu23p82
         BeHh2CdVICQz0u0kT0eiu6XoITcys/TUdjGeR4YDBynj560ib8vriCS2htv3mJWNjEs7
         gNuFMDbR6xceaIjT1M8HxkDkBxXOIM8qQx6vCM0zUi4Mb34wXsSR/zTARO54Tf/iVm/y
         PTpcndwh/WVyHL6nBvPp9VpCnRO6WFp72cXYlBStzkeGHcX6vKY6d2LkrRodxPCX52PF
         YhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681366318; x=1683958318;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awOm9muSY38mDgU9YNhlhDcoLFSx4493kH/RGeG3QLA=;
        b=GuIK2KphKixBDKhmxa0LU49C8Vprq90/6Aj47PTZwZeJTQSa851L06+UonwzWw55PM
         l5bepwR9xhoHETHjVUiwR2cdIhvao6lEeiOIS8dOVamMSv4yY3kiA+HLpixU7VCB21K/
         qamq3+KQIz9zyesV8toUOHnaxisoKzB0O/NQ0ZRN5vs9bIWQIGB814O628mO16HSxa/L
         GbSa7xrhdEVfIRyCWk/deaJpp4PoujJIw4v4HwVeIcsdi4r0sQjqoe5mE3aNHge3GmrL
         q4d9zLxeZdDGk11VcmdhCX5j80CoJHAUr2izXPrnSzWYGLzZ1eOVabQxcX/FVIIhW1SA
         Qz4Q==
X-Gm-Message-State: AAQBX9e9G9+qnr2pMO7giNvSBhycLWi0qmq5/iqgGy5kLmyN11P/g8xn
        1ZXuwjVvjdztjAVKfRtS3eU=
X-Google-Smtp-Source: AKy350ZZtYeOpLr4TXMpC/6XFO5t2jSa5vvndPYNxpSRFPZMMtr3r9fvyXO/3/JqvwteOd2ONcfeEA==
X-Received: by 2002:a7b:c40a:0:b0:3dc:4b87:a570 with SMTP id k10-20020a7bc40a000000b003dc4b87a570mr443880wmi.35.1681366318162;
        Wed, 12 Apr 2023 23:11:58 -0700 (PDT)
Received: from ?IPV6:2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8? (dynamic-2a01-0c22-738e-4400-9dd0-adc5-d6d8-61d8.c22.pool.telefonica.de. [2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8])
        by smtp.googlemail.com with ESMTPSA id c8-20020a05600c0a4800b003ee5fa61f45sm4535912wmq.3.2023.04.12.23.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 23:11:57 -0700 (PDT)
Message-ID: <b32bf46e-432f-22f0-63fd-123853d787e5@gmail.com>
Date:   Thu, 13 Apr 2023 08:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
 <12d4fbc1-8ed4-637e-32ca-2c09d25d60a6@gmail.com>
 <CAFBinCDME3=3dUx6K5iZHcr=tu6nh-Xm2NMn_VAiTcM_uZD_qQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 4/4] pwm: meson: make full use of common clock
 framework
In-Reply-To: <CAFBinCDME3=3dUx6K5iZHcr=tu6nh-Xm2NMn_VAiTcM_uZD_qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12.04.2023 23:05, Martin Blumenstingl wrote:
> Hi Heiner,
> 
> On Wed, Apr 12, 2023 at 9:23 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Newer versions of the PWM block use a core clock with external mux,
>> divider, and gate. These components either don't exist any longer in
>> the PWM block, or they are bypassed.
>> To minimize needed changes for supporting the new version, the internal
>> divider and gate should be handled by CCF too.
>>
>> I didn't see a good way to split the patch, therefore it's somewhat
>> bigger. What it does:
>>
>> - The internal mux is handled by CCF already. Register also internal
>>   divider and gate with CCF, so that we have one representation of the
>>   input clock: [mux] parent of [divider] parent of [gate]
>>
>> - Now that CCF selects an appropriate mux parent, we don't need the
>>   DT-provided default parent any longer. Accordingly we can also omit
>>   setting the mux parent directly in the driver.
>>
>> - Instead of manually handling the pre-div divider value, let CCF
>>   set the input clock. Targeted input clock frequency is
>>   0xffff * 1/period for best precision.
>>
>> - For the "inverted pwm disabled" scenario target an input clock
>>   frequency of 1GHz. This ensures that the remaining low pulses
>>   have minimum length.
>>
>> I don't have hw with the old PWM block, therefore I couldn't test this
>> patch. With the not yet included extension for the new PWM block
>> (channel->clock directly coming from get_clk(external_clk)) I didn't
>> notice any problem. My system uses PWM for the CPU voltage regulator
>> and for the SDIO 32kHz clock.
>>
>> Note: The clock gate in the old PWM block is permanently disabled.
>> This seems to indicate that it's not used by the new PWM block.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
> meson8b-odroidc1, sm1-x96-air
> 
> Generally I'm very happy with this - only a few small questions/comments below.
> 
> [...]
>> +       state->enabled = __clk_is_enabled(channel->clk) && (value & tmp) == tmp;
> I was about to suggest that clk_hw_is_enabled() should be used instead
> of __clk_is_enabled()
> That would be easy for SoCs where the gate is part of the PWM IP. But
> it would not work (at least I don't think that it would) work for the
> newer IP that Heiner's described where the gate is part of the SoC's
> clock controller (and thus outside the PWM controller registers). To
> me this means that we need to keep __clk_is_enabled() here unless
> somebody knows of a better approach.
> 
> The "(value & tmp) == tmp" can now be simplified to !!(value &
> BIT(channel_data->pwm_en_bit)) as we're now only checking a single bit
> (previously we were checking two bits in one statement, so that more
> complex check was needed).
> 
> [...]
>> +               channel->gate.reg = meson->base + REG_MISC_AB;
>> +               channel->gate.bit_idx = meson_pwm_per_channel_data[i].clk_en_bit;
>> +               channel->gate.hw.init = &init;
>> +               channel->gate.flags = 0;
>> +               channel->gate.lock = &meson->lock;
>> +
>> +               channel->clk = devm_clk_register(dev, &channel->gate.hw);
> If I recall correctly Jerome previously suggested that I should use:
> - devm_clk_hw_register() to initially register the clock
> - then use (for example) channel->clk = devm_clk_hw_get_clk(dev,
> &channel->gate.hw, "pwm0")
> 
> It's not the most common pattern (yet) but if I recall correctly this
> is also what the CCF maintainers agreed to be the way forward.
> 
One more remark/question on this pattern. In __clk_register() there's
the following comment:
/*
* Don't call clk_hw_create_clk() here because that would pin the
* provider module to itself and prevent it from ever being removed.
*/
I think we have the same situation here when calling devm_clk_hw_register()
and devm_clk_hw_get_clk() both from pwm-meson. So we may not be able to
remove module pwm-meson. Shouldn't be really relevant for us because we
need pwm for the CPU voltage regulator and therefore have it built-in.
But it wouldn't be nice.

> 
> Best regards,
> Martin

