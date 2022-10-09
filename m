Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22E5F8BEA
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Oct 2022 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJIPRZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Oct 2022 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJIPRY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Oct 2022 11:17:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F72A257
        for <linux-pwm@vger.kernel.org>; Sun,  9 Oct 2022 08:17:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a18so2601298qko.0
        for <linux-pwm@vger.kernel.org>; Sun, 09 Oct 2022 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDVjDN2hc5vVTSMOAggOEb9m9ZtapX9IIDMEqTOQ1x0=;
        b=H4fbn1j172SCEsklqsllZtM7rSDPVd5FUWsOhxH9xbYqpPHriCab5ihAYa2Q9fKu6z
         IDIn0N0/5LMSBL+/OuOwDL/LA3QV4Z773rwjCI/P4LLFSv4eBrwhA1hQi5/fbBNN6Iku
         r/RCbbWXyqP/AKMADXbfGAf6hzZc/o7AXCrU0SIJf+5T11stQZCN5Eto70/D/R9exCgV
         W+vwb7EhixEc/i1rD34aofVCEvv+vRH0/eZeV/OlvAxNUgSgwWe526Fzax82Wgg8YVJQ
         wTFiqx7msLcS28GnASVnbBI+1hMfJrYciO+U51U5UtqjHRfJ6YR0gZhzlG6/G946eFN4
         ohWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDVjDN2hc5vVTSMOAggOEb9m9ZtapX9IIDMEqTOQ1x0=;
        b=PXvvroEVg01H/PfjGVk0FJuYROKCXwbY5GRaHu2VtCz/P5OEfbuz8n7Uo1/AlwJo88
         pG9j4HG4yiCEZ+E/XkNVDC5cot1AOJfE9WNZ0aWl2b6idvJWzIIE6NUWFGTp1X22tyof
         j/2+pUkbf9IvpJY8nN8pVHQ23hKbv9e4fNteM+na36ZGAnuDFeqE/0zm8eCUo5UcpBbF
         PWT88X2UcK9oEbrCeiFa73gvM73Qxbg3nC6H+B/d++AcBKu2xfLqAKFzmFwWZN7LhrrP
         aJwrJAfwJO0FDISrPw8PRd60jIY11D4SzPdI7F+FT2DqmVvSfCTwstiPQNGPiwwW7rpS
         6P1g==
X-Gm-Message-State: ACrzQf1uALhvkAh6qUtxy5dzhM9BcqUrG5HOEu1IxtKtKHicaz6NCpbs
        +X4p8B77U3FMu2o26LCQwxyivQ==
X-Google-Smtp-Source: AMsMyM5H7ETuErdfaJFeaTLUbSUaCy8+VQoEIqBBNI74zcH3Wxju3S2Fw9m2ZAQSz7lAiVeGqrXMWA==
X-Received: by 2002:a05:620a:284b:b0:6b4:8685:2aa6 with SMTP id h11-20020a05620a284b00b006b486852aa6mr10190525qkp.780.1665328643416;
        Sun, 09 Oct 2022 08:17:23 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id m8-20020ac84448000000b0039a1146e0e1sm649509qtn.33.2022.10.09.08.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 08:17:22 -0700 (PDT)
Message-ID: <2961c272-52af-9f77-0ff3-105b81438316@linaro.org>
Date:   Sun, 9 Oct 2022 17:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
 <CAMuHMdWmT7+8ow4-P-gbPb6gt221B51RN3vGXafmpeVwi4rbkA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWmT7+8ow4-P-gbPb6gt221B51RN3vGXafmpeVwi4rbkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09/10/2022 16:38, Geert Uytterhoeven wrote:
>>
>> So looks like either we need to use compatible "renesas,rz-mtu3-counter" and
>> "renesas,rz-mtu3-pwm" if these functionalities to be in respective subsystem tree
>>
>> or
>>
>> squash counter and pwm functionalities to MFD subsystem.
>>
>> Please share your views on this. Is there any better way to handle this?
> 
> I think what Rob means is that you can have a single driver that binds
> against "renesas,rz-mtu3", and registers both the counter and the pwm
> functionalities. Just like the clock driver, which registers clock,
> reset, and PM Domain functionalities.  I.e. no mfd would be involved
> anymore.
> You can still split the driver functionality across multiple source
> files (core, counter, pwm).

Yes.

Bindings design is independent of driver design (e.g. still MFD framework).

Best regards,
Krzysztof

