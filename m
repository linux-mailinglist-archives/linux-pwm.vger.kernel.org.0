Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58DA6E0135
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDLVvj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 17:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLVvi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 17:51:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06F76B6
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 14:51:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d9so12394679wrb.11
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336295; x=1683928295;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym52jQCPNqJCSId057dBztHUHrCsma88sgI3he60CTI=;
        b=OgthBYRKtfnqJEEoEkfgB1IYjWnjUO7e5EgHK7DKwgF0fSlD48ByaTdrXouOhCBsWX
         XEXMSmkCbj8r64jnU2bsr1EZbFOntmy4wwX6zDGsM1gyY9SxXkIasmH9bbdnYMekQoSC
         iZigIwguiSA0CLFOzgmoB4jqSdbWvIVPGLcIyPt0Z6O2i8izOf1jwOQ85DJq1Oc8M33R
         M/wNNSAASPuJ3cat45tgrLZhTVEfTtPByoiMI26JajjiFoppltE4AXprU10pMJ8Bw1kD
         dmNnteuMoKaZ9NCpJuakzPSpzsFYgOpZBHLYi7bcblD0GRakcPZg+c15A7z9rXZsOw3a
         f6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336295; x=1683928295;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym52jQCPNqJCSId057dBztHUHrCsma88sgI3he60CTI=;
        b=VMFv1TimVvbasBuagtYSVNN890N40YEg7wUJwQMECCBvbzcpQxD29ajDrW4MpRtbg2
         kpGhZKmPUliwRV5GXmDsP4VJzGWLiQKh/zXWTCKqfjABme8+LdM5+69CfIHtDcFFV+xi
         fpoHaEQmSu5AaarKtbauH263skBInq9by9KV6J0iT6KnmpHrGLOmDpoXErFND1RIAi4y
         9HuUvo+AO/Apy+giN6wDaMfjxq8PANWQqvu4ACm0BTjbP+4+QH0glWLilITs6DbEODhH
         zOne0bcpwXbf9AakV13Rtutya03vez46XD5EU+/mQhGBm+2Dn9q9T7bcjx4677wtgt1a
         f92w==
X-Gm-Message-State: AAQBX9c4sBcARIqa37EaryyUudg3y6NjwS1+WBcPiJdSt742GGoI18ia
        QcVSqCg6YCBVtQPepJ6SLcayLPqhRrM=
X-Google-Smtp-Source: AKy350bEHRko6Jy1RmF/saLkGukHWHGUkk6YNNTTBkWjBqb+i5X4bRuwzGbjTgoR678oaHiwqxjkMA==
X-Received: by 2002:a05:6000:11c1:b0:2f4:48c9:495f with SMTP id i1-20020a05600011c100b002f448c9495fmr2786464wrx.48.1681336295039;
        Wed, 12 Apr 2023 14:51:35 -0700 (PDT)
Received: from ?IPV6:2a02:3100:903d:3d00:b0e7:6bd7:f613:784b? (dynamic-2a02-3100-903d-3d00-b0e7-6bd7-f613-784b.310.pool.telefonica.de. [2a02:3100:903d:3d00:b0e7:6bd7:f613:784b])
        by smtp.googlemail.com with ESMTPSA id iv8-20020a05600c548800b003f09e294d5esm3450301wmb.6.2023.04.12.14.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 14:51:34 -0700 (PDT)
Message-ID: <0dcc6c3a-5a77-68a0-e115-f28ad5f44496@gmail.com>
Date:   Wed, 12 Apr 2023 23:51:33 +0200
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
If acceptable this could be done as a follow-up patch.

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
As of today this pattern just creates overhead because clk_hw_register()
builds on top of __clk_register() and therefore creates a consumer,
and devm_clk_hw_get_clk() creates a second consumer. But I see the point.

Situation may change once clk_hw_register() is re-implemented and doesn't
create a consumer any longer.

> 
> Best regards,
> Martin

Heiner
