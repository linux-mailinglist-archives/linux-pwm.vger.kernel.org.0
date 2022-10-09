Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40605F8BEF
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Oct 2022 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJIPSp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Oct 2022 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiJIPSp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Oct 2022 11:18:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE32A417
        for <linux-pwm@vger.kernel.org>; Sun,  9 Oct 2022 08:18:43 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s7so1554248qkj.1
        for <linux-pwm@vger.kernel.org>; Sun, 09 Oct 2022 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akrQmjJ5ANNV9oJ9U081ngxumiXjo/3S9Mc5SAIBAo4=;
        b=zY2GkVGgwwzE6TzX4K9RcSkWVEvq1t01CH68PG0NUS2gh/e9MkdC2BH9pkwJKNczCR
         HhT8beTnLqIeI+++qrQYlklUCPXaD0kgfp13PQwzuYedG3pYjg6dT2pLNMXatzYzSCjk
         d+03YtbjJIKR5WsSTLsQHFneqyhW7Dnm6+a0xRCCJDCBdVeoCY53Ak8wO20XD/meqBrL
         x8Wvhsq38xtA5uPh786ACn11NfkuITyp1dym/4Q1NUEnRiFZ3AIOIemsnHavcclGovom
         qDWnXC/gG6fKQjGY7iwX9gnUm+AFJ3IsNY3hKlgrnQOOkdJCx3ehcaJaS91CsJAhztnA
         3yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akrQmjJ5ANNV9oJ9U081ngxumiXjo/3S9Mc5SAIBAo4=;
        b=af0s/4VKwVVRxUAHw2UskMCsb6Zg4e44U8M1LEZ9UxlVOFFzyzS3KjgJBwyVNmTG9Z
         Nt9Ugsxk1lRbcPS3TdyFoytDUJqHAWpYS1SZUATWIxTzFd+/1GaY5bRh4SYHAkEArTXE
         CP+x79mIF0kwRLDJWt0sL0kn4nx/4Zaqg8O6H8Jxe7iJjvjnc1jW3DBAx+dtGSU2JAaC
         wVRT78KBQO8bt+gL/5REEpLwrtGFNuYaRIgRWQkils62TG2gD+KxgZi1V8WqDhwWb6Vc
         gy1zbg/kXzHH4+5WuB8JQpibDYsu/kkskxJhyWBrspkelOYPDNSagajsrsVcMoAxUieH
         9GWA==
X-Gm-Message-State: ACrzQf1hErTER4J1ebhbTaWa82RcCiimBBqwekCfmkdg0H0DfKYhTqt5
        0+NzMZs+gxgUvWtQAs5h26uPmw==
X-Google-Smtp-Source: AMsMyM7wkO+uNHublLqxbJQRkrkJLB4Tdfxa8dNbZoat2NF6x6vAN9JwuDKqfO3jpnBNaKGD+syWqg==
X-Received: by 2002:a05:620a:a03:b0:6ec:bf65:d0fc with SMTP id i3-20020a05620a0a0300b006ecbf65d0fcmr864584qka.381.1665328723009;
        Sun, 09 Oct 2022 08:18:43 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id t28-20020a37ea1c000000b006cdd0939ffbsm7756178qkj.86.2022.10.09.08.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 08:18:42 -0700 (PDT)
Message-ID: <8b4a2bfd-ce7f-6bb9-4e50-ecd9bda881a2@linaro.org>
Date:   Sun, 9 Oct 2022 17:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
 <20221006201746.GA93297-robh@kernel.org>
 <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/10/2022 09:42, Biju Das wrote:

>>>> +                        "tgia8", "tgib8", "tgic8", "tgid8",
>>> "tgiv8", "tgiu8";
>>>> +      clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
>>>> +      power-domains = <&cpg>;
>>>> +      resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
>>>> +
>>>> +      counter {
>>>> +        compatible = "renesas,rz-mtu3-counter";
>>>
>>> You don't have any resources for the counter in DT, so you don't
>> even
>>> need a node here. Just have the parent driver instaniate the counter
>>> driver.
>>
> 
> If I remove "renesas,rz-mtu3-counter" and "renesas,rz-mtu3-pwm" then instantiating 
> the counter and pwm driver from parent driver by directly calling probe function is
> giving cyclic dependency error[1].

How is this related to DT? Purpose of DT is not to solve your probe
problems.

> 
> So looks like either we need to use compatible "renesas,rz-mtu3-counter" and 
> "renesas,rz-mtu3-pwm" if these functionalities to be in respective subsystem tree
> 

No, you don't need. Your driver implementation is not really related to
the bindings.


Best regards,
Krzysztof

