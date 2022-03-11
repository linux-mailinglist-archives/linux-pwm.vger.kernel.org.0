Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689E54D5C62
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Mar 2022 08:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCKHfE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Mar 2022 02:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347179AbiCKHfD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Mar 2022 02:35:03 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5EC1B7198
        for <linux-pwm@vger.kernel.org>; Thu, 10 Mar 2022 23:34:00 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 947AE405A8
        for <linux-pwm@vger.kernel.org>; Fri, 11 Mar 2022 07:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646984039;
        bh=FwIsaa6346BnNKKT5tvMxkFu/0GEn2QQ2fVNeegANkg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ShhO7QVpj2/qqVow6bIhgZNzFEqbMy2QEJjLd8Xwd1rNOpCsy55FfvM8CUu6XtvUW
         tmVBg1XcMlqhPHM7+QS66DMFy/S4G6a6F3S6Bilr8tvqPhq8q37iLbYa8sJ5c6jsAI
         fb9vCzNRO95GTApYtTgkNuyDA36Splp/Mca55Db0vWhTXrcVQRTR7Qu152Xl+o6qjf
         XxpnnjmCmEfb8a4oDwfo4JrylNI2lKlE/e1WOgKuQ6+fhkv9z6fb7xpY9UvWG78/SY
         lei90kTq0xg1oLC0ifJWXbnAfAOJN1A93xBxkQsZFE44p7ASPdXRkZ/ja94svoR3rM
         emJ1iWECDfjsg==
Received: by mail-ed1-f71.google.com with SMTP id n11-20020aa7c68b000000b0041641550e11so4426628edq.8
        for <linux-pwm@vger.kernel.org>; Thu, 10 Mar 2022 23:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FwIsaa6346BnNKKT5tvMxkFu/0GEn2QQ2fVNeegANkg=;
        b=1Yften7TntkaAyfu5wI5K+H4zKj+dOLRfxPE/G50bHQZVqmgUWvcIcmz0fkTlGXxUb
         lJ7DJFQoER+lq+jyPWHAMXbyUB/w8mZ9tYmsjeTLqIPMkg9nmJYetABMjcTGu3S0rVDn
         5WWse9tAA/rL4eS4JnVl3RQ1mkV7jOlS+XPND3WV0SB57l+8DaOZAFHSWPNh43znMIHx
         eYdW/09/1ytNCoOIv+D9j5/VQvtZoUmJpV2ul0c3QYC+kqNJrRr4RERQy5Nb+YHAy95Y
         EL6y0C1X2QmVRkBYQ7GYXt6tCzlqToreBq5BIYroUToOUDhnw6c0xugklzz42P4bWU9J
         NhSg==
X-Gm-Message-State: AOAM5339toImMADt1MdFypDK/aQfvIPP4M1A+6e2P5jvIXY11ji4FpDB
        lcSvfv6y3eg0gXR0MIA/9gu/6UBuaR48KnFvIpJ0Kifa/n1ddBY6/mSIA9alTlGN898SYw3Z3D2
        OoU4z8MguBL8RhzOa5mLBJAGsy3LXiF6nMs5zHQ==
X-Received: by 2002:a17:907:72ce:b0:6db:aed5:833e with SMTP id du14-20020a17090772ce00b006dbaed5833emr400586ejc.420.1646984036606;
        Thu, 10 Mar 2022 23:33:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHSkeNxfQPFajgsgZR2Yv3RA/WJuoMeMF7qYuAnmerumRUXFThKxmJtDF/IuTUkeXY1Sj4WA==
X-Received: by 2002:a17:907:72ce:b0:6db:aed5:833e with SMTP id du14-20020a17090772ce00b006dbaed5833emr400571ejc.420.1646984036392;
        Thu, 10 Mar 2022 23:33:56 -0800 (PST)
Received: from [192.168.0.147] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm2908347edt.3.2022.03.10.23.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 23:33:55 -0800 (PST)
Message-ID: <ef965982-0c21-9cc7-1e5a-69726671ba1f@canonical.com>
Date:   Fri, 11 Mar 2022 08:33:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MAINTAINERS: sifive: drop Yash Shah
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, aou@eecs.berkeley.edu,
        p.zabel@pengutronix.de, sagar.kadam@sifive.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <mhng-b01b9acc-de77-4d1d-9cdc-f3830a6c569a@palmer-ri-x1c9>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <mhng-b01b9acc-de77-4d1d-9cdc-f3830a6c569a@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/03/2022 04:14, Palmer Dabbelt wrote:
> On Mon, 14 Feb 2022 00:23:49 PST (-0800), krzysztof.kozlowski@canonical.com wrote:
>> Emails to Yash Shah bounce with "The email account that you tried to
>> reach does not exist.", so drop him from all maintainer entries.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  Documentation/devicetree/bindings/gpio/sifive,gpio.yaml     | 1 -
>>  Documentation/devicetree/bindings/pwm/pwm-sifive.yaml       | 1 -
>>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml          | 1 -
>>  MAINTAINERS                                                 | 6 ------
>>  4 files changed, 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
>> index e04349567eeb..427c5873f96a 100644
>> --- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
>> +++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
>> @@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  title: SiFive GPIO controller
>>
>>  maintainers:
>> -  - Yash Shah <yash.shah@sifive.com>
>>    - Paul Walmsley <paul.walmsley@sifive.com>
>>
>>  properties:
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
>> index 676b2160bada..605c1766dba8 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
>> @@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  title: SiFive PWM controller
>>
>>  maintainers:
>> -  - Yash Shah <yash.shah@sifive.com>
>>    - Sagar Kadam <sagar.kadam@sifive.com>
>>    - Paul Walmsley <paul.walmsley@sifive.com>
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>> index 2b1f91603897..e2d330bd4608 100644
>> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>> @@ -9,7 +9,6 @@ title: SiFive L2 Cache Controller
>>
>>  maintainers:
>>    - Sagar Kadam <sagar.kadam@sifive.com>
>> -  - Yash Shah <yash.shah@sifive.com>
>>    - Paul Walmsley  <paul.walmsley@sifive.com>
>>
>>  description:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ebf7a75a6bec..87eeac970ca2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7090,12 +7090,6 @@ L:	linux-edac@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/edac/sb_edac.c
>>
>> -EDAC-SIFIVE
>> -M:	Yash Shah <yash.shah@sifive.com>
>> -L:	linux-edac@vger.kernel.org
>> -S:	Supported
>> -F:	drivers/edac/sifive_edac.c
> 
> Looks like that leaves this unmaintained?  I'm happy to volunteer, I've 
> got the boards lying around somewhere and sort of feel on the hook to 
> keep this stuff alive given that whatever's in there is partially my 
> fault.  That said, I'm happy to stay out of it so if it's OK to have 
> otherwise unmaintained EDAC drivers that works for me so
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

The patch was already merged. EDAC SiFive is now covered by generic EDAC
and SIFIVE entries. Feel free to restore the entry with yourself.

Best regards,
Krzysztof
