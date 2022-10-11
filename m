Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346285FBC06
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJKU1T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJKU1R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:27:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB257B289
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:27:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o2so2078231qkk.10
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSwRDHLxFTKUoI2TvmoYFkHtH0EVFLeGN+Pl1oW8bZY=;
        b=Wo8sgs14q3RBpwiDOYZeh9+xNIEObV6JyU+ZjYOkUUwecagzkDhA4JQDcrrN/IVg4Q
         Yjh050zap6wE47F7lnHTS05TGuQW4sJMPcJdPA/sjNrJ5gxEZCih2hNgM8AuY6TyOb07
         VO+vColqUZ2GNK5uWq2SiryaSrmFXMJN/S/3UMegCfTqwzohSNdzpkdT9V09EjwfJ9N0
         05NFQxptWkSdUZAIKb6AATJadHZ1Mttr6qR0azpTDNVMCZWLCK6UenCcYhztRN0a+Va5
         U3ikhFxGmmAvYUbFWpK7G7tEFfUx1SBXyM2ZJysa7eqoEbDEl9NCEBx4//JUNIT6yXWl
         xxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSwRDHLxFTKUoI2TvmoYFkHtH0EVFLeGN+Pl1oW8bZY=;
        b=y8XCj5DSY2VZy5X94Z0miNn20v7T8CkzhIq3r173+Gqyc/FrKgpb0AUHUq2f+/TLaA
         1OfTfICzfI9XSTcpLfypvbcdDqNoB10+bQVjMV+edMLfTNztrGPw5RFfII3Id9oC0kXY
         7JkoJv/eHg1QuVVHuHSqCwEAcIW8nNpYkMqhDJDX3ZqjtUKmX2mf4GwuN8H+eeL//nox
         p13G/pZ5urOBN+jlbNXJ4DlaC6I1REqKld8ri9fKIy1D7TqvDjabQf59BdegAZX++Nf7
         6nJYqXr1+4NnR6TAxBJT1PPZ/sD2flfsqVX4o3BQ++oerErld9PvCYBtAGE2UWyn3FfS
         R1KA==
X-Gm-Message-State: ACrzQf2qrTcKeWggeJqEsxTDrBoyj18Iak5c8LhUJA10er6RXtZDyEXo
        3i19jSPr2lZIMUudwVQVOMf42A==
X-Google-Smtp-Source: AMsMyM7oanT8viRiS3SXpSscOEi/A2+AMpsupoWUizqwY/zYnZYLP1s/uDxfE4QtYg440V8hfNeJ5Q==
X-Received: by 2002:a05:620a:2414:b0:6ee:94fd:ac96 with SMTP id d20-20020a05620a241400b006ee94fdac96mr41697qkn.270.1665520035841;
        Tue, 11 Oct 2022 13:27:15 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006cfc01b4461sm14285486qki.118.2022.10.11.13.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 13:27:15 -0700 (PDT)
Message-ID: <f12dfcd3-ef5c-b422-c00c-35cef082a3ff@linaro.org>
Date:   Tue, 11 Oct 2022 16:27:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
 <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
 <OS0PR01MB592269EB3BAE686A2F74B48286239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB592269EB3BAE686A2F74B48286239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On 11/10/2022 16:18, Biju Das wrote:
>> Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
>>
>> On 11/10/2022 15:13, Biju Das wrote:
>>>> Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
>>>>
>>>> On 10/10/2022 10:52, Biju Das wrote:
>>>>> Add support for RZ/G2L MTU3 PWM driver. The IP supports following
>>>> PWM
>>>>> modes
>>>>>
>>>>> 1) PWM mode{1,2}
>>>>> 2) Reset-synchronized PWM mode
>>>>> 3) Complementary PWM mode{1,2,3}
>>>>>
>>>>> This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver by
>>>>> creating separate logical channels for each IOs.
>>>>>
>>>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>>> ---
>>>>> v3->v4:
>>>>>  * There is no resource associated with "rz-mtu3-pwm" compatible
>>>>>    and moved the code to mfd subsystem as it binds against "rz-
>> mtu".
>>>>>  * Removed struct platform_driver rz_mtu3_pwm_driver.
>>>>> v2->v3:
>>>>>  * No change.
>>>>> v1->v2:
>>>>>  * Modelled as a single PWM device handling multiple channles.
>>>>>  * Used PM framework to manage the clocks.
>>>>> ---
>>>>>  drivers/mfd/Kconfig       |   6 +
>>>>>  drivers/mfd/Makefile      |   2 +
>>>>>  drivers/mfd/rz-mtu3-pwm.c | 405
>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>
>>>> That's not a MFD driver. That's a PWM. Use proper subsystem and
>> email
>>>> prefix.
>>>
>>> See [1]
>>> [1]
> =03qSqax5tr5tAuDHBytn7xH%2BS6oU2xguui9mrshI
>>> tCI%3D&amp;reserved=0
>>>
>>> It is a single driver that binds against "renesas,rz-mtu3", and
>>> registers both the counter and the pwm functionalities. Just like
>> the clock driver, which registers clock, reset, and PM Domain
>> functionalities.
>>
>> No, it is not a single driver. You just added a new file - PWM.
> 
> It is a single driver rz-mtu.ko binds with "renesas,rz-mtu3"

Binding to compatible is not really related.

> 
>>
>>>
>>> It is same here, a single MFD driver which binds against
>>> ""renesas,rz-mtu3" and registers counter And pwm functionalities.
>>>
>>> rz-mtu-core is core driver which provides resources to child devices
>> like counter and pwm.
>>>
>>> I already copied PWM subsystem in the loop. Am I missing anything
>>> related to [1]
>>
>> MFD subsystem is only a wrapper/parent over actual drivers. It's not
>> meant to hold the subsystem-specific code, because relevant
>> maintainers will not look here.
>>
>> So no, here and in other files - don't put subsystem specific code
>> like PWM or timer into MFD.
> 
> Where should do we put, if there is single driver to be bind against 
> "renesas,rz-mtu3" and register functionalities for pwm and counter??

Again - how binding is related to this problem? If you have separate
drivers, e.g. counter, timer and PWM, all go to their respective
subsystems. Counter goes to counter, timer to timer, PWM to pwm.

MFD is only the glue/parent/wrapper to instantiate them.


Best regards,
Krzysztof

