Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278746DD30F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 08:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDKGmc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 02:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKGmb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 02:42:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D1BC
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 23:42:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so1711448wmb.3
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 23:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681195349; x=1683787349;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxmfQMLH/VjVS7JXLAMnXjMrD/h4yCDYVknbKOh9dN0=;
        b=iEeYwEz3fLD126bhL2JiW6VMqV3H0dr0SoouEtjFq6ot/PH8Vdp/xL8l3cQXdXt/bu
         hqxDmcsAwyBXatVtTo1gDVaz5dHleIlQO2fIgvMYebCmpFYDHkbucSvU23CcAjiE4nfQ
         CVb6MqgWOVYaTIKouqNiT6Q+uAXc7t8H0Aa/xbXEND5Y7ESAypqI5X9USe2zfiP6cY4P
         kxWLnfq/aGJ64LksP1g/2nBAyHQ71nCBqh2ePQI5ggQtaI/bgBKnkfA0UxHG0dnHlapE
         a8l6Kt0PYzAPJiadLmJGiLjStzWxwHNqeMylaU/rwlU+N/WOwvffjRmbpVppfqtLRnOA
         CBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195349; x=1683787349;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxmfQMLH/VjVS7JXLAMnXjMrD/h4yCDYVknbKOh9dN0=;
        b=NBNCw1xRC8sDFWAw1RqfCIvmpA57qUhmjMhBowg5NQDE9zZrsyNLOQD6/YDHhOEHbM
         pLsRzyZOMJ80tqEunT9tebIUFnCxUdf9qA01dT3+0RjM6XrCYcIAoA8kB4vVQU3pb8Wc
         FwuA8AALRE3zZibLLE9L/OzwXRtUfy6LukyXMoBZ0UU8bU1zW5rwywHdcuyUDzCZ0HMI
         RRz1ERQckXczP/+1pd+9MEcIIPUn7U0ViT4wVKc6xovSkkOZBIb52RUFruFaACX0nYuI
         EZtAID2N266Cv7AyOeaoS8iCBNXk4o9+pfhN8IsGRdoD+xURl6Brr6zVxQd1DEAtQtJ0
         oGMQ==
X-Gm-Message-State: AAQBX9dUVbdkL7IkSpk4wLxghxiDwMBeZrrx1JPPxRmmoWA1onCTlFjM
        PsgNqgaC8joxSiYE6bviGE4=
X-Google-Smtp-Source: AKy350aAHjFCe4GtWM9ORCXt8mYnVNH4rtJNyu7LM1UIzi0cd8r47yKbrJO0gVkAasiYXJhDXoqvGA==
X-Received: by 2002:a1c:770c:0:b0:3ee:3df6:e411 with SMTP id t12-20020a1c770c000000b003ee3df6e411mr8630366wmi.28.1681195348345;
        Mon, 10 Apr 2023 23:42:28 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:491f:994c:df34:b485? (dynamic-2a01-0c23-c4bb-c200-491f-994c-df34-b485.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:491f:994c:df34:b485])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b003f0548d00f1sm1289818wmo.1.2023.04.10.23.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:42:27 -0700 (PDT)
Message-ID: <fc1c841f-d93b-6510-0edd-1c96b1ce4f31@gmail.com>
Date:   Tue, 11 Apr 2023 08:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
References: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com>
 <08085ec6-0450-2477-e35f-5af19c1de857@gmail.com>
 <CAFBinCCaca-VKmxv_SaPxOzBrix98Nj+VDaD1bfqSwvDBg+eKQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] pwm: meson: make full use of common clock framework
In-Reply-To: <CAFBinCCaca-VKmxv_SaPxOzBrix98Nj+VDaD1bfqSwvDBg+eKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11.04.2023 01:27, Martin Blumenstingl wrote:
> Hi Heiner,
> 
> On Sat, Apr 8, 2023 at 10:43 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> [...]
>> +               init.name = name;
>> +               init.ops = &clk_divider_ops;
>> +               init.flags = CLK_SET_RATE_PARENT;
>> +               parent_hws[0] = &channel->mux.hw;
>> +               init.parent_hws = parent_hws;
>> +               init.num_parents = 1;
> There's a very subtle bug in this code:
> You're re-using the same struct clk_init_data for all clocks.
> The mux above sets
> - init.parent_names
> - init.num_parents
> - (amongst others)
> 
I think we should initialize clk_init_data to all NULL before each use.



> but for the divider and gate you're only overwriting init.num_parents,
> which is why I end up with:
>  xtal                                 8        8        1    24000000
>         0     0  50000         Y
>    [...]
>    c1108650.pwm#gate1                1        1        0    24000000
>        0     0  50000         Y
>    c1108650.pwm#div1                 0        0        0    24000000
>        0     0  50000         Y
>    c1108650.pwm#mux1                 0        0        0    24000000
>        0     0  50000         Y
>    c1108650.pwm#gate0                1        1        0    24000000
>        0     0  50000         Y
>    c1108650.pwm#div0                 0        0        0    24000000
>        0     0  50000         Y
>    c1108650.pwm#mux0                 0        0        0    24000000
>        0     0  50000         Y
> 
Thanks a lot for testing and for the comprehensive feedback.

> My suggestion is to switch to struct clk_parent_data entirely (for the
> mux this could be done with a separate commit before this one).
> Then keep it consistent and don't mix parent_names/parent_hws and
> parent_data (just stick to parent_data, which can manage the previous
> two and more).
> I *think* struct clk_parent_data can even be used to simplify the
> second patch (by just having an "empty" entry - with index = -1 - in
> the array).
> 
After having looked at clk_fetch_parent_index() I think so too.

clk core seems to be a little inconsistent wrt handling parent_names
vs. parent_data.name in clk_core_populate_parent_map(). It complains
about NULL entries in parent_names but accepts parent_data entries
with index == -1 and everything else being NULL (incl. name).
It might be worth a clk core patch to allow NULL parent_names.

Benefit for us would be that we can simply replace the hdmi/video
clock entries with NULL, and avoid the effort of copying the clock
names to parent_data entries.

> [...]
>> +               channel->gate.bit_idx = __ffs(meson_pwm_per_channel_data[i].clk_en_mask);
> I's the only place where clk_en_mask is now used. So I think it's
> valid to just rename clk_en_mask to clk_en_idx and pass the value
> without the BIT macro during initialization.
> 
> 
> Best regards,
> Martin

