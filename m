Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3385FBBDE
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJKUKK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJKUKI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:10:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB925C72
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:10:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hh9so8977274qtb.13
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZz9ocI0cTzvlLV35buvAxBk16f5CU04y+HjLJSlep4=;
        b=J70B2JHMLBIeQZqsBJFXdwiWyWntkUjWFpaaJZpri7M6aQrIplpMOwg/ZOk0TTrAAj
         gP13WZwH+JnUekULqB+l9zX7GTy+8lp7X9eLkiIWDNFD8ZwQN9g8SDWY6nzP1ic2XzZE
         8KjcWXFsaAMeZ7Gr9IqKxERAZKlmWZTF9GaFPXr08tga9KBM08txiNOoC5A+PZ1/xxiU
         x5rjuwlIfkhg7vpOI61NSupyjKIK4SmzeEfubhsQB+qDYaeQXk6BTpbc03f9Bv5Sctsz
         +ZY+KMZDz7N+MCVZZc/mdnMozxTROBHDkQ2ZYBCbzfcPnTobDXj5WPG4LD/winzgJbkC
         7lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZz9ocI0cTzvlLV35buvAxBk16f5CU04y+HjLJSlep4=;
        b=bAXV8qBfBRs4hHyIi7KdTNtq3DvARm3dq/okBomw9+6dABEDtqxdL2dQTCiuw7KnHx
         tytL4DNWvdvyquA4OjmJYqqHfblYW81HR0X/rMfTPRI5WWWJy4dsoxIJHbuiiNUC/Ep/
         acxLDZ7A8XPo7ZsoFXH9dpZxjbKkHDYqsISOnH/T+AsE43suFYkn+v2Slp4/TrAmXrNE
         c9KHz0oTbBt6PDdgDfi6TJZWka1zbL74MibAapR1VlmkUEtOvdMb2uYV6uBLFPSUpVbj
         e77AxE04ywvVozKQDnUBuFYr9AqPwUy2tHB2QggDzPI1Mi6pRkPWKWa+892xtK8ce9rx
         OOpw==
X-Gm-Message-State: ACrzQf13tIyQ8jvXI2u1Knfgo6JO2VRB1hwlA1UFQwkpevn4gzNRZ9DG
        pfiVinpSuqlyWDzwTL56foUiAw==
X-Google-Smtp-Source: AMsMyM4v33eRCwVeduyVQ2U84yGx1PL5zJh12myHi0Qt/86ArPoLL2H22mjUawD5+4UC/ZExgDzwdQ==
X-Received: by 2002:ac8:5a45:0:b0:39b:ef52:ac1d with SMTP id o5-20020ac85a45000000b0039bef52ac1dmr5488309qta.419.1665519006330;
        Tue, 11 Oct 2022 13:10:06 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id r9-20020a05620a298900b006b953a7929csm4665512qkp.73.2022.10.11.13.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 13:10:05 -0700 (PDT)
Message-ID: <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
Date:   Tue, 11 Oct 2022 16:10:04 -0400
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On 11/10/2022 15:13, Biju Das wrote:
>> Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
>>
>> On 10/10/2022 10:52, Biju Das wrote:
>>> Add support for RZ/G2L MTU3 PWM driver. The IP supports following
>> PWM
>>> modes
>>>
>>> 1) PWM mode{1,2}
>>> 2) Reset-synchronized PWM mode
>>> 3) Complementary PWM mode{1,2,3}
>>>
>>> This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver by
>>> creating separate logical channels for each IOs.
>>>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>> v3->v4:
>>>  * There is no resource associated with "rz-mtu3-pwm" compatible
>>>    and moved the code to mfd subsystem as it binds against "rz-mtu".
>>>  * Removed struct platform_driver rz_mtu3_pwm_driver.
>>> v2->v3:
>>>  * No change.
>>> v1->v2:
>>>  * Modelled as a single PWM device handling multiple channles.
>>>  * Used PM framework to manage the clocks.
>>> ---
>>>  drivers/mfd/Kconfig       |   6 +
>>>  drivers/mfd/Makefile      |   2 +
>>>  drivers/mfd/rz-mtu3-pwm.c | 405
>>> ++++++++++++++++++++++++++++++++++++++
>>
>> That's not a MFD driver. That's a PWM. Use proper subsystem and email
>> prefix.
> 
> See [1]
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221006135717.1748560-2-biju.das.jz@bp.renesas.com/
> 
> It is a single driver that binds against "renesas,rz-mtu3", and registers both the counter and the pwm
> functionalities. Just like the clock driver, which registers clock, reset, and PM Domain functionalities.

No, it is not a single driver. You just added a new file - PWM.

> 
> It is same here, a single MFD driver which binds against ""renesas,rz-mtu3" and registers counter 
> And pwm functionalities.
> 
> rz-mtu-core is core driver which provides resources to child devices like counter and pwm.
> 
> I already copied PWM subsystem in the loop. Am I missing anything related to [1]

MFD subsystem is only a wrapper/parent over actual drivers. It's not
meant to hold the subsystem-specific code, because relevant maintainers
will not look here.

So no, here and in other files - don't put subsystem specific code like
PWM or timer into MFD.

Best regards,
Krzysztof

