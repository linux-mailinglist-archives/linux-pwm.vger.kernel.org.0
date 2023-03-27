Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446A76CB06B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Mar 2023 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC0VOY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Mar 2023 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0VOX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2023 17:14:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB0D1703
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 14:14:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ew6so41625378edb.7
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679951660;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfAWnu/HdNhG59VBhfDGl+NVjd1Z3ukfdoF0dEk/N1I=;
        b=HWbF9w1mZ2QP9tY6RqiY9yqRFJ6NaxVzXcS/UFEKXSlDiZpErLlMb7BRK6BkbQM/yK
         BOTDO0cs4rrE9kXE5j6GCN29lHVAWepUTRrikmBmgXQ2iMhny2pD4rhzxrDjro6mGHCd
         7x3wml4rZYR00ijP634qc8A6eRj/TzhhPAqCYtRYfJ2GxEyrH5+TyDXhQB0rX6P4RZkB
         BgftATo5IAwYCjNxdKCZd5MqCyq6GdbnS9WQR/O7XfIwF+Amg+txiAAzHVDFV0R2JYyG
         dlekFWV6bS6zTgGvL6pQC5Ml3HPQNIs9hdSmifJx1l0IYp5+Nq51A3tnsIfM04QKPFxp
         opSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679951660;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfAWnu/HdNhG59VBhfDGl+NVjd1Z3ukfdoF0dEk/N1I=;
        b=uauJUZNff9Zx3XGBPV0neYHYYldtgpDNEdeZ51v3vOl34nuwco5R44DIV+ZkhFFswf
         vjWgTnDHYPvv7CO0V7S9EztnyqLxvCL598+j/DesCHn1Bn9jrUeqjjDWyw9My8ldVvpX
         upsoO1SamuwPRSMDcDSR3SwZ2rubLVsSmg6QxHIntEaCeMaOkZmapv5cbhkW/dkzI8lw
         crsbvKdJkkYo+8ke2J4fhZLjti8/CS5dsY2PsOw+g0ZQse/80CCxGVGIPZD/C0WAm/8T
         6TYEXalOKgHE1zk70XK10bTDyjWiNkJ/nmjrY7RRgrkEMAyudfQG7SIZpYeU7jbcHTWU
         FJwA==
X-Gm-Message-State: AAQBX9elo6yjkFLWyr7x+3x6La/VG2nW53V7eSq5VBKHbguxW0pr67Fd
        MSHfn2xSEf54khq7WYm2BHI=
X-Google-Smtp-Source: AKy350bS6pzWTlVbxsSwTwiREma9tvBEdcF4ls6GPCSegZ3MZVId9oBZGpZfEhKAhtO5arHhdCH2hQ==
X-Received: by 2002:a50:fe94:0:b0:4f9:9e56:84bf with SMTP id d20-20020a50fe94000000b004f99e5684bfmr12458082edt.10.1679951660257;
        Mon, 27 Mar 2023 14:14:20 -0700 (PDT)
Received: from ?IPV6:2a02:3100:91f1:2a00:c022:d3da:60a9:9c00? (dynamic-2a02-3100-91f1-2a00-c022-d3da-60a9-9c00.310.pool.telefonica.de. [2a02:3100:91f1:2a00:c022:d3da:60a9:9c00])
        by smtp.googlemail.com with ESMTPSA id u6-20020a50d506000000b004fd2aab4953sm15126055edi.45.2023.03.27.14.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 14:14:19 -0700 (PDT)
Message-ID: <fc607b9a-baed-daf5-5b2a-3b69d36b8d17@gmail.com>
Date:   Mon, 27 Mar 2023 23:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     neil.armstrong@linaro.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
 <3492657f-6cc2-5828-b153-30c609a92783@linaro.org>
 <45dbd1d4-a2b8-af33-beec-64906c0e98da@gmail.com>
 <20230327175027.z7as4fybzgx7zhuq@pengutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
In-Reply-To: <20230327175027.z7as4fybzgx7zhuq@pengutronix.de>
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

On 27.03.2023 19:50, Uwe Kleine-König wrote:
> On Mon, Mar 27, 2023 at 07:00:35PM +0200, Heiner Kallweit wrote:
>> The best (for achieving best precision) input frequency is 0xffff / period.
>> So we should do our best to come as close as possible to this frequency.
>> By using set_rate() CCF will choose the optimal mux input and divider value.
> 
> Just for the record: Here might be a misconception. There is (AFAIK) no
> reason to believe that set_rate would pick an optimal configuration. And
> if it's only because there is no objective definition of "optimal". For
> example if a driver for an SD card requests 400MHz, it might not want
> anything faster and so probably prefers 202 MHz over 404 MHz. However a
> driver for a UART would prefer the 404 MHz in this case. IMHO we'd need
> something like
> 
Right, I wasn't precise enough. In my case optimal is "fastest rate <= requested rate".
This seems to be the behavior of clk core default implementations like
clk_mux_determine_rate_flags() an divider_determine_rate(), used by the meson
clock drivers.
However in general clock providers can provide their own determine_rate()
implementations. And, as a disclaimer, I have to admit that I'm no expert in CCF.

> 	clk_rounddown_rate();
> 	clk_roundnear_rate(); and maybe
> 	clk_roundup_rate()
> 
> to please all drivers. But that sounds like a bigger quest.
> 
> If your clk can provide (say) 1000000 Hz and 2000000 Hz (and nothing in
> between) there is no rule in the CCF that tells you which of the two to
> pick if you request 1000001 Hz or 1999999 Hz. (The only thing I would
> not expect is that you get 1000000 Hz when requesting 1999999 Hz *and*
> 2000000 Hz when requesting 1000001 Hz.)
> 
>> Not sure why we should restrict ourselves to one mux parent only.
>> E.g. for a very low duty cycle a higher input frequency than the xtal 24MHz may be preferable.
>>
>> Not only the mux is outside the PWM block now, also the divider (8 bit wide instead of 7 bit
>> as of today). So we need a set_rate() anyway to set the divider value.
>> What I can't say is whether the internal divider still exists (then external and internal
>> divider would be cascaded) or is removed or bypassed.
>> It seems like when adding the external PWM clock feature Amlogic forgot to update
>> the PWM block documentation, as there's no reference at all to the now external input clock
>> (except in the clocks section).
> 
> It would be great to test (or ask?) if the internal divider still exists
> and do the right thing then.
> 
> Having said that, I wonder if it would make sense to rework the driver
> for the variants with the internal mux to also abstract the divider as a
> proper clk.
> 
I think this would make sense. Then we could ignore the mux parent set in DT
and let CCF select the mux parent and divider value. And we could use one
pwm calc logic and get rid of most if(ext_clk).


> Best regards
> Uwe
> 

