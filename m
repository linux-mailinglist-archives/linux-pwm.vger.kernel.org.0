Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2322C5FBBF6
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJKURs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJKURp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:17:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2076E9D52D
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:17:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g11so4366367qts.1
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66Gg3fB6AGJqXHBgHf/Kizm7fLphcrpXJZ+rXt0aU3Q=;
        b=WOEW8WqYRiPuZP76b9PiKeGtpZK6R7ctRw2I9zeRjbqt/RtQRYDGQq/WojYcmuugcE
         14/l62x/GSD14uEkgYrfcNqTVqKNBFblU/5zj73pWHrQgt2srrisNh/NpbyVpqzpHhLo
         z1u6wg6/9XqV2lGi7veugSn6GlxTxl4nBDN6odo8nSsVyx1OxMur4M/AoPxEUq4KQbZI
         rBsht7lKmVJEhCm6eR8U5EInIgNYiol+BMIUcdlw701ld2ggnRQ+DHiakYhHiHxrL7MC
         YKHOJAGWfU0Weh3wVpkALvseHhRdLWDDScbTmAhdAL4q8XKH6jGR7jBrQyDCMcKRyGWc
         k+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66Gg3fB6AGJqXHBgHf/Kizm7fLphcrpXJZ+rXt0aU3Q=;
        b=vHIA9e/KvMLqmgXEV1t3tACBIvP4HST2tnBzveQ94BIvENTavBzn/LoEMEdeRSTR7G
         FzBt4hDKm1wL0D0ab2cfJiHbBfsM14Y/GmweEbBh4UFX1CBoBkxx/QvrC5vJnz/+KCPp
         lMXqtGxLQaDekVrNwPE6aHMM0U1SuchjDgENHSWFrzn6O7Rl0JhT2dsvFE1DBUO0UQfl
         1g7QHs2kYvMVxBH5p2kXB3T5GGwDyn0jobJULduEOLtx8qwkqvvB/mgbxzmhp/RNjdh8
         1KfPVo2pzxKSJptHYh8fpEUeUzBCVt+F5hTiVJzqvCnh9a1wqSWvE9HD8X8nBZvyLMgY
         on1w==
X-Gm-Message-State: ACrzQf1l7ufVgvXYYM5zMoiUFoT501o6CyYCl0rf+NkenZNgUCrprYFk
        o1KQaJs8UWnb+6jyQLSou8NnRg==
X-Google-Smtp-Source: AMsMyM7SIQGjk2g601WbU5/RwqYAzpSncQbKZwlXkoa10Y/N82T7XYFTt0mSlEyrX5u2PFS2gtDGpg==
X-Received: by 2002:ac8:5c0b:0:b0:35c:e066:998d with SMTP id i11-20020ac85c0b000000b0035ce066998dmr20552686qti.336.1665519460506;
        Tue, 11 Oct 2022 13:17:40 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id k15-20020a05620a414f00b006e6a7c2a269sm13678904qko.22.2022.10.11.13.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 13:17:39 -0700 (PDT)
Message-ID: <17fc9f27-03ad-7663-db21-2f14c7ff4312@linaro.org>
Date:   Tue, 11 Oct 2022 16:17:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
 <OS0PR01MB59228146DE05231586212FE886239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB59228146DE05231586212FE886239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/10/2022 15:23, Biju Das wrote:
>> Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
>> bindings
>>
>> On 11/10/2022 10:55, Biju Das wrote:
>>>
>>>>>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305
>>>> ++++++++++++++++++
>>>>>  1 file changed, 305 insertions(+)
>>>>>  create mode 100644
>>>>> Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
>>>>
>>>> This should not be in MFD. Just because some device has few
>> features,
>>>> does not mean it should go to MFD... Choose either timer or pwm.
>>>
>>> MFD is for multifunction device. This IP supports multiple functions
>>> like timer, pwm, clock source/events. That is the reason I have
>> added
>>> here. MFD is core which provides register access for client devices.
>>>
>>> For me moving it to pwm or counter is not a big problem.
>>> Why do you think it cannot be MFD?
>>
>>
>> Because it makes MFD a dump for everything where author did not want
>> to think about real device aspects, but instead represented driver
>> design (MFD driver).
> 
> Core driver is MFD, just provides resources to child devices
> and is not aware of any real device aspects.
> 
>>
>> MFDs are pretty often combining unrelated features, e.g. PMICs which
>> have wakeup and system power control, regulator, 32 kHz clocks, RTC
>> and some USB connector.
> 
> Here also same right? pwm, counter and clock are 3 unrelated features.
> That is the reason we have separate subsystems for these features.

These are quite similar features of a similar piece of hardware.
Sometimes called timer.

> 
>>
>> Just because you will have clocksource driver, PWM driver and timer
>> driver does not make it a MFD.
> 
> MFD is multi function device.

No. MFD is a Linux subsystem name. Not a device type. The bindings are
located in respective type.

> So are are you agreeing Clock source, PWM and
> timer are different functionalities or not? If not, why do we have 3 subsystems,
> if it is same?

Linux subsystems? We can have millions of them and it is not related to
bindings.


> Where do keep these bindings as there is only single "rz_mtu" bindings for these 3 different functionalities?

Again, focus on hardware not on Linux drivers. Hardware is called MTU -
Multi-Function TIMER Unit. Timer.

> pwm or counter or mfd?

Not MFD. I already proposed where to put it. Other Timer/PWM/Counter
units are also in timer.

Renesas is not special to get some exceptions.

Best regards,
Krzysztof

