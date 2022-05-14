Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25965273F5
	for <lists+linux-pwm@lfdr.de>; Sat, 14 May 2022 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiENU2S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 14 May 2022 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiENU2R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 14 May 2022 16:28:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE328718
        for <linux-pwm@vger.kernel.org>; Sat, 14 May 2022 13:28:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f4so7020049lfu.12
        for <linux-pwm@vger.kernel.org>; Sat, 14 May 2022 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oU8cEi9RGKI5PeHOuabBwBx8PODfLAO6JbRmPjOYsQc=;
        b=UE5bV8SixnycPe242NT4unpuYuLs0IT3V/Lvwh7LTJhOmbejnDYbrPIsKrgTWgGAlW
         9BLRS6VcSfONQ6/rP4mfhrEkpk3M11Nzl4YlCHiqI9cP1IglVd6S6Vfjo7pX45msSqrV
         S3Ww5hQZYqN4ES4N6A9n3aHSoKDPdaFfygzW14Q1yqmqPoVXqt/CgEhctUEdRGOCNwY2
         +ceKeyMdqX8RECrqnCcKBgMYKBYSjppskrTD6M2+AZDhAG6iEPF9L3d3HZDnOWnVRvBc
         yjg64VPwRi5vYGloOWg7EAN1RW4JFkrYN5KrB097+QCrK/PQTD7HyDTz+futzCkZXbin
         reng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oU8cEi9RGKI5PeHOuabBwBx8PODfLAO6JbRmPjOYsQc=;
        b=EknyamlpTD41Olcd4mjo5tvQ+ul1cEKIljGxOyr075ePOtrGdsUJ+SkPGmvB1qrYjo
         I0UO6DMpz0JX/3JyIhysDmC0tpnwwbbJDCYTffB0IM85Yv387SgFPDWfTwwVwb6Ph/Y4
         kL0xtwMF6CuxWzlF9NVb/2iDuaa5bsd5BO1MWfQfgLzyFoscrwSmBgdn3t372crTKJVU
         t1BllRzuAT3N8qSm/HEdMuiICHWlN9VGsceX818gBTxuGuizI5a0uLuCvzJL9M0r9b/l
         VTQj3uxeLhc+aqu9q/w7J0PCRw83LisexvSHbesG/Nj5KbcbWMT5JOHcq6rZ52MeFHMl
         WfIQ==
X-Gm-Message-State: AOAM532U6ypZ/R5WP17dhqlJA54WE7QVIvwktBG5A+RaAJBeHGmoCOnQ
        9gPF9xYBKIvH2pwDOLg4jQXRrg==
X-Google-Smtp-Source: ABdhPJx00h31Y+JHjm9zszBh0Ce/1DU3I4eUQBWnozuMVemJIxolb+XGt/gBmwRvE9PJp3/pDzhWpQ==
X-Received: by 2002:a05:6512:3a84:b0:472:6384:4de0 with SMTP id q4-20020a0565123a8400b0047263844de0mr7685091lfu.456.1652560093711;
        Sat, 14 May 2022 13:28:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f19-20020a19ae13000000b0047255d211b4sm799894lfc.227.2022.05.14.13.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 13:28:13 -0700 (PDT)
Message-ID: <4714c388-47ec-776a-7a50-362b258ffc25@linaro.org>
Date:   Sat, 14 May 2022 22:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: gpio-mvebu: convert txt binding
 to YAML
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "enachman@marvell.com" <enachman@marvell.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
 <32aab734-5890-99b2-09c9-8ec7418c7649@linaro.org>
 <e87482cb-20b1-fe09-7233-d56786d5eda6@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e87482cb-20b1-fe09-7233-d56786d5eda6@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 14/05/2022 04:20, Chris Packham wrote:
> 
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: marvell,armada-8k-gpio
>>> +    then:
>>> +      required:
>>> +        - offset
>>> +    else:
>>> +      required:
>>> +        - reg
>> one blank line please
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: marvell,armadaxp-gpio
>> Original bindings are saying that second reg is optional for
>> marvell,armada-370-gpio. What about other cases, e.g. mv78200-gpio? Is
>> it also allowed (and optional) there?
> This is where things get interesting. The armadaxp (and only the 
> armadaxp) requires a second register value for some per-cpu registers. 
> All of the other SoCs can have an optional 2nd register value if they 
> want to use the PWM function. I guess that implies that the armadaxp 
> can't do PWM.
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 2
>> Then you also should require two reg-names.
> 
> Simple enough to add. But currently we've said that the reg-names are 
> "gpio" and "pwm" but on the armadaxp the 2nd one is not "pwm" but 
> something else ("per-cpu" perhaps?)

In such case they would be failing with current bindings, because they
expect "pwm" as second name, right?

> 
> On the other hand this is all completely moot because the 
> armada-xp-mv78*.dtsi actually use the "marvell,armada-370-gpio" 
> compatible so this appears to be documenting something that is no longer 
> used. Indeed it appears that the armadaxp specific usage was remove in 
> 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on Armada XP").
> 
> So perhaps the best course of action is to drop marvell,armadaxp-gpio 
> from the new binding (noting that we've done so in the commit message).


That's fine, maybe in a separate patch (2nd one)?


Best regards,
Krzysztof
