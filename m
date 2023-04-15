Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8396E2F4B
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Apr 2023 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjDOGjZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Apr 2023 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDOGjZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Apr 2023 02:39:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F64205
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 23:39:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ud9so50821075ejc.7
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681540762; x=1684132762;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBQSN+fAxZoAVm5Rkojym6pn+56SmKTpupeGE0Al3bY=;
        b=Minq1Rmt2+PdKP7THoyit0oHLfDmeGI7SUXx2ipKJ4KER2HxM3M5Ktgr8f7XK36Wr7
         dvfmrVCBxn4VYYk5VGQoZFv+sp1L66XMOTHB0BtyPrimh4AA1TEKWurmpr9mii+qTYag
         DT+CoJwvl7zancRMboxxGDLEwf0FxOKWi0FUBfEJajKhaA2FI1fwNTASVfvZSS9bEvv4
         IlBc+iOFNCXlV67bQyYandhhLViU2OvicX53NP2oP9HqX6WqegAQYyxpJ2SsC+BrFSGu
         +koMJFEDXLZFifLLRM6gWexouv7iR5hceQ9Avv0HEirVBp142yNvicIkd4eWF7kBDmmM
         lLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681540762; x=1684132762;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBQSN+fAxZoAVm5Rkojym6pn+56SmKTpupeGE0Al3bY=;
        b=O6zM5kMWo1KxaNk/lB5xEadyu/v5jGS4iXXH33r8Ub1oytP30usFV3OEQG+avuIWlU
         cM7bOnFh+Auck5qJ+fXZXFaBy/yflILq11e2VozQXhsqYvyJZaLenshw8NKywM/XYlSw
         q4UzB1pbhJSVZyiwhI6ahd4fDE+LTrBLXGkJfSnVXTnIIusNm9CCyLBIzLymyyDE/IOF
         5KrbIvrp3pT3wkHeSJqG5KhzbpzGqf7cQzGZItfrL68H7cdqxP4kNIxHSGFDe+TnB0WB
         tNywMQBCz2VyK0uhoFQVdt/fuf8COYr+JrdAHLjm75tKcsOTWt5ssmy26TTqZQ1QE+Xk
         jNug==
X-Gm-Message-State: AAQBX9cJI3hedZAUDIxxmf5Fshuedws+Mqu835IaQcbibLOSxm1pygLC
        SxkldySyeSkoJohlQ0oVrWM=
X-Google-Smtp-Source: AKy350bN9gMdbrkdLPw7CLCEb1iIMSs6wuuJRE1Z+JNcoAXk1VKW+sKTr4TflNn4I0DxTpkMZoBfzw==
X-Received: by 2002:a17:906:d8a9:b0:947:72bd:f72a with SMTP id qc9-20020a170906d8a900b0094772bdf72amr1171861ejb.72.1681540761989;
        Fri, 14 Apr 2023 23:39:21 -0700 (PDT)
Received: from ?IPV6:2a01:c22:76c9:5300:c449:604e:39a7:3bce? (dynamic-2a01-0c22-76c9-5300-c449-604e-39a7-3bce.c22.pool.telefonica.de. [2a01:c22:76c9:5300:c449:604e:39a7:3bce])
        by smtp.googlemail.com with ESMTPSA id lv25-20020a170906bc9900b0094a77168584sm3310109ejb.125.2023.04.14.23.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 23:39:21 -0700 (PDT)
Message-ID: <4b328dab-5f96-e5d0-3181-ce059d11b04b@gmail.com>
Date:   Sat, 15 Apr 2023 08:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
 <CAFBinCCzMdQZ4mDF7SEZKHc01MPSepxdzYa+j7G-qDXe5-kBVA@mail.gmail.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
In-Reply-To: <CAFBinCCzMdQZ4mDF7SEZKHc01MPSepxdzYa+j7G-qDXe5-kBVA@mail.gmail.com>
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

On 14.04.2023 21:39, Martin Blumenstingl wrote:
> Hello Heiner,
> 
> On Thu, Apr 13, 2023 at 7:55 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> [...]
>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Unfortunately I have some bad news and I need to take back my Tested-by :-(
> Previously my test was: cycle through all available CPU frequencies
> while stressing the CPU.
> My assumption was: if the system doesn't lock up everything's fine
> because we have a high enough voltage.
> 
> This evening however I got a memory corruption error while trying to
> log in via UART - which I thought was strange.
> So I connected my logic analyzer to my Odroid-C1 and did some experiments:
> 
> period = 30518, duty cycle = 15259 (typically used for the 32kHz
> output to the SDIO wifi chip)
> before your patches / after applying your patches:
> PWM: duty cycle: 50.000000% / 50.000000%
> PWM: period: 30.6 µs / 30.5 µs
> Timing: Time: 15.292 µs (65.395 kHz) / 15.250 µs (65.574 kHz)
> Timing: Average: 15.296 µs (65.377 kHz) / 15.264 µs (65.513 kHz)
> driver debug messages with your patches applied:
> fin_freq: 850000000 Hz
> period=30518 cnt=25940
> duty=15259 duty_cnt=12970
> 
> Then I tried period = 12218, duty cycle = 0 (typically used for the
> highest CPU voltage):
> before your patches / after applying your patches:
> PWM: duty cycle: 0.338983% / n/a (constant low output)
> PWM: period: 12.3 µs / n/a
> Timing: Time: 12.250 µs (81.633 kHz) / n/a
> Timing: Average: 6.148 µs (162.668 kHz) / n/a
> driver debug messages with your patches applied:
> fin_freq: 850000000 Hz
> period=12218 cnt=10385
> 
With a 850MHz input clock we should see a 0.01% duty cycle with 1.2ns
clock pulses. Can we rule out an issue with the measuring equipment?
Is your logic analyzer able to display such short clock pulses?

> Finally I tried period = 12218, duty cycle = 12218 (typically used for
> the lowest CPU voltage):
> before your patches / after applying your patches:
> PWM: duty cycle: 99.661017% / n/a (constant low output)
> PWM: period: 12.3 µs / n/a
> Timing: Time: 12.250 µs (81.633 kHz) / n/a
> Timing: Average: 6.148 µs (162.668 kHz) / n/a
> driver debug messages with your patches applied:
> fin_freq: 850000000 Hz
> period=12218 cnt=10385
> 
Here I have no idea yet.

> After seeing the constant low output with period 12218 I realized that
> my previous test was no good: the CPU was fed the highest possible
> voltage all the time.
> It's not clear to me why period 12218 would give no PWM output at all
> while period 30518 works fine.
> I did an experiment by removing CLK_SET_RATE_PARENT from the divider's
> init.flags -> now XTAL (24MHz) is the only possible clock (it's the
> hardware default). It does indeed bring back the exact same results as
> before (where the XTAL clock was also used; with the changes from this
> series FCLK_DIV3 is now chosen, which runs at 850MHz).
> 
> Do you have any idea what could cause this?
> The FCLK_DIV3 input seems to work as otherwise period 30518 would also not work.
> The calculated values also look sane, so it's not that we have some
> 32-bit overflow (as I'm testing on a 32-bit Meson8b SoC).
> 
At first I'd like to verify that the registers have the expected values.
Can you provide the values of PWM_A/B (depending on which channel is used in your
case) and PWM_MISC_AB at the end of meson_pwm_enable()? Thanks!

> 
> Best regards,
> Martin

Heiner

