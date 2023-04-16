Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB26E3C30
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Apr 2023 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDPVfB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Apr 2023 17:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPVfA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 16 Apr 2023 17:35:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE941FEB
        for <linux-pwm@vger.kernel.org>; Sun, 16 Apr 2023 14:34:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fw30so6507827ejc.5
        for <linux-pwm@vger.kernel.org>; Sun, 16 Apr 2023 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681680898; x=1684272898;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTEJ3SvEYPG4oDgombjMYM3ak7OFgJ8uVwxrQoFD3j8=;
        b=gLkBwiPccZS4UsdOCU9uPEB6aUoWFnQQl9b7LgB2cA3/Bmt7wbBXCDlAIj8FSZo7IZ
         m0OMGOwfMiXGEXb4a19+pU41BNWz/hPlp5BFOIdDkzYE0k9f9H9hqk5dBmkDXRDLd492
         /h9c0z+FlhGlAdU/MC3sjNL+grY2GDCsl8imp9OJQydqVZ6T+56SLuVyvyoMCU6seoV7
         JMWEZUVoHY6ZJBb6pXLViX0c2ASCucpU2hLIxtUqTpVU9JuGttjPoZcHSOr+kPglDK+I
         895e+ufuuXQ82Bj4tscXHCC11Am4nXflBR45meDqgqTZTyBSYwSH/uHEX6K6KlGL9pD3
         VbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681680898; x=1684272898;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTEJ3SvEYPG4oDgombjMYM3ak7OFgJ8uVwxrQoFD3j8=;
        b=D9bz2JZjZY8NtjTeQbsqseYQtRx6SdFk7TvSnZlgt1fNGV3YJuSMMQwrfBBLevbBl7
         zSfULVBiCauSaTIupa9R6XPJ1pcMHaLEOoMAcFleKa0kEzn5BPUVfDDXMxcRgE9PQe2d
         RQTrf643WDhve78njLnGbE/3VRGd2caMtb+rqXWnPJB0EsdUhyVgBYFBzwM41MimhboS
         U7ITbdvk5JgGcMQXyja2jZWi38mAJSNtRSTBKmKKD9HTp++FW2OIbC1bWY+faffw6Re+
         EnmwH84Y0jiTEVR0/ObEQcWQzQYK8/+CdCDe1Grpvl+mShDx0yUvnHH5gSjVoFKe5zm3
         fM3A==
X-Gm-Message-State: AAQBX9flm2DV6aYorR18hqdEdjrw8lt0oZ3t4ju4zBGvmZMAKn7Fws2g
        LWeqbOGZSb8hMkuen02uAIQ=
X-Google-Smtp-Source: AKy350bLoctHyHIvPipBGZToinGdo4hBHvgY5kHFq+s6rSGIJaHmSJfye+mLUzxvMEYeQHbzktqvgA==
X-Received: by 2002:a17:906:c455:b0:94f:17b7:5db3 with SMTP id ck21-20020a170906c45500b0094f17b75db3mr4760508ejb.20.1681680897728;
        Sun, 16 Apr 2023 14:34:57 -0700 (PDT)
Received: from ?IPV6:2a02:3100:90eb:5c00:c072:8c2c:2c92:c192? (dynamic-2a02-3100-90eb-5c00-c072-8c2c-2c92-c192.310.pool.telefonica.de. [2a02:3100:90eb:5c00:c072:8c2c:2c92:c192])
        by smtp.googlemail.com with ESMTPSA id d15-20020a170906c20f00b0094f3b18044bsm1864890ejz.218.2023.04.16.14.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 14:34:57 -0700 (PDT)
Message-ID: <7601c976-3195-a35d-236c-9bd386dfe8e0@gmail.com>
Date:   Sun, 16 Apr 2023 23:34:56 +0200
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
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
 <CAFBinCCzMdQZ4mDF7SEZKHc01MPSepxdzYa+j7G-qDXe5-kBVA@mail.gmail.com>
 <4b328dab-5f96-e5d0-3181-ce059d11b04b@gmail.com>
 <CAFBinCCxQvB_fY0r4jkwy7zW1F9s2vrxmcRaTs6hG5ay_Gf8mw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
In-Reply-To: <CAFBinCCxQvB_fY0r4jkwy7zW1F9s2vrxmcRaTs6hG5ay_Gf8mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 16.04.2023 21:26, Martin Blumenstingl wrote:
> Hi Heiner,
> 
> On Sat, Apr 15, 2023 at 8:39 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 14.04.2023 21:39, Martin Blumenstingl wrote:
>>> Hello Heiner,
>>>
>>> On Thu, Apr 13, 2023 at 7:55 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> [...]
>>>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Unfortunately I have some bad news and I need to take back my Tested-by :-(
>>> Previously my test was: cycle through all available CPU frequencies
>>> while stressing the CPU.
>>> My assumption was: if the system doesn't lock up everything's fine
>>> because we have a high enough voltage.
>>>
>>> This evening however I got a memory corruption error while trying to
>>> log in via UART - which I thought was strange.
>>> So I connected my logic analyzer to my Odroid-C1 and did some experiments:
>>>
>>> period = 30518, duty cycle = 15259 (typically used for the 32kHz
>>> output to the SDIO wifi chip)
>>> before your patches / after applying your patches:
>>> PWM: duty cycle: 50.000000% / 50.000000%
>>> PWM: period: 30.6 µs / 30.5 µs
>>> Timing: Time: 15.292 µs (65.395 kHz) / 15.250 µs (65.574 kHz)
>>> Timing: Average: 15.296 µs (65.377 kHz) / 15.264 µs (65.513 kHz)
>>> driver debug messages with your patches applied:
>>> fin_freq: 850000000 Hz
>>> period=30518 cnt=25940
>>> duty=15259 duty_cnt=12970
>>>
>>> Then I tried period = 12218, duty cycle = 0 (typically used for the
>>> highest CPU voltage):
>>> before your patches / after applying your patches:
>>> PWM: duty cycle: 0.338983% / n/a (constant low output)
>>> PWM: period: 12.3 µs / n/a
>>> Timing: Time: 12.250 µs (81.633 kHz) / n/a
>>> Timing: Average: 6.148 µs (162.668 kHz) / n/a
>>> driver debug messages with your patches applied:
>>> fin_freq: 850000000 Hz
>>> period=12218 cnt=10385
>>>
>> With a 850MHz input clock we should see a 0.01% duty cycle with 1.2ns
>> clock pulses. Can we rule out an issue with the measuring equipment?
>> Is your logic analyzer able to display such short clock pulses?
> Oh, you're right: my logic analyzer maxes out at 24MHz (~42ns).
> So we can ignore this case.
> 
>>> Finally I tried period = 12218, duty cycle = 12218 (typically used for
>>> the lowest CPU voltage):
>>> before your patches / after applying your patches:
>>> PWM: duty cycle: 99.661017% / n/a (constant low output)
> I have to correct myself: for this case my logic analyzer sees a:
> constant high signal
> 
So conclusion is that the PWM output is as expected? If yes, then the
memory corruption you saw supposedly had another root cause?
Eventually your Tested-by could be re-instantiated?

>>> PWM: period: 12.3 µs / n/a
>>> Timing: Time: 12.250 µs (81.633 kHz) / n/a
>>> Timing: Average: 6.148 µs (162.668 kHz) / n/a
>>> driver debug messages with your patches applied:
>>> fin_freq: 850000000 Hz
>>> period=12218 cnt=10385
>>>
>> Here I have no idea yet.
> [...]
>> At first I'd like to verify that the registers have the expected values.
>> Can you provide the values of PWM_A/B (depending on which channel is used in your
>> case) and PWM_MISC_AB at the end of meson_pwm_enable()? Thanks!
> I'm testing with PWM_B and I get:
>   REG_MISC_AB = 0x008000c2, channel reg = 0x28910000
> 
> This register value looks correct to me.
> 
To me as well.

> This is now my last line in meson_pwm_enable() in case you want to
> sanity-check what I did:
> dev_err(meson->chip.dev, "REG_MISC_AB = 0x%08x, channel reg = 0x%08x",
> value, readl(meson->base + channel_data->reg_offset));
> 
> 
> Best regards,
> Martin

Heiner
