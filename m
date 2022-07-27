Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A96582606
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Jul 2022 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiG0MCc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Jul 2022 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiG0MCb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Jul 2022 08:02:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467404B0CD
        for <linux-pwm@vger.kernel.org>; Wed, 27 Jul 2022 05:02:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y11so26614069lfs.6
        for <linux-pwm@vger.kernel.org>; Wed, 27 Jul 2022 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hR+37jRvCGMHr0+ocVsrbJ4Hg34fE3vOnHVPjPz+ERI=;
        b=YbL8VlWKs6UYr2jQP98Nys1+2TlVS2AUtrtLi/sZKHUMKkxQXit4/Lwyf2xVoQB2SI
         WnP4bStVdZDGzWZKRAmaxvuKIndL0wHlEHiOkqCSUzCspbhjDdH1fj/NGKa7onnwFpmS
         c6DmOIwj1rcGheIdzd+T6j67slkBZyvRpe/l37/Ldh6NMXUP0wEF5frWMcIXWFcAmO8x
         b3YMLAwPCa2DtyuiU81EhzTkJDI9cIWtpog8wM5hFYPpYgAPNDk6i2kNbeQ0LjIkTOuY
         DvsF3ThpJzAf8L6oCrmCWs31CbAT96mY7py7WhV0COOVBrkTaEMA6/03RN6P5WhzSYqC
         Bxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hR+37jRvCGMHr0+ocVsrbJ4Hg34fE3vOnHVPjPz+ERI=;
        b=eLKGL3bQHvZeJbTgej31ZmV9KqMM2+wg86H36ELY3x07kG0R0qGUpXRlfxymA8juzG
         sQQ31DpYRfqyH+N5cvM5dAXmLoHrSIeGnxqtfdiyLCO4Dyy69zD0UZxV92bkMjTz1fMk
         uXxaXd6G93GaK5g+upNA821o3JufDIkZTktcS7NVFV/EQTGJdFS0OsscyhsMkQzwlBTb
         SMT19c6rGvTR3BqnFYp0m9UFnfkUU5D2AzrDyqG97ga6rS8P2IS0MkZce4VbUFSSa1Z7
         VZTjDGeOYFpNtKxvTxPplzGNVBmlDkHwW863i9PF4hNDL+m3jRfQIxKZnAzyJb+1Pk7r
         2kcQ==
X-Gm-Message-State: AJIora8LMZwPER1adV8MwO81dTIPVXMoj515xjfaKv1YvO885giGzjW5
        7SHz061hgiwG5jqJNT5fgpR0EQ==
X-Google-Smtp-Source: AGRyM1uMEeS0TT5lICj8jO3goa7CBewryZUS03dNcTF1YnXiKZhaSFXsC5hVc55XonJRKJJmpry5Cg==
X-Received: by 2002:a05:6512:3983:b0:48a:83ad:5f70 with SMTP id j3-20020a056512398300b0048a83ad5f70mr6453722lfu.283.1658923348350;
        Wed, 27 Jul 2022 05:02:28 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b16-20020a196450000000b00489e011bad7sm2948033lfj.218.2022.07.27.05.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 05:02:27 -0700 (PDT)
Message-ID: <0f5f75c3-269d-a804-7a46-9fa7aec03245@linaro.org>
Date:   Wed, 27 Jul 2022 14:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
 <922628f6-cbb1-b563-6464-e57959bafbcd@linaro.org>
 <8bb5103d-803e-90d2-fd93-132bb2aac2d6@sifive.com>
 <6317212b-1fca-65b4-9bce-0b9f7408fdae@linaro.org>
 <1d4573fc-407a-13c2-b049-e7a060d7929b@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1d4573fc-407a-13c2-b049-e7a060d7929b@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 27/07/2022 12:32, Ben Dooks wrote:
> On 26/07/2022 12:05, Krzysztof Kozlowski wrote:
>> On 26/07/2022 12:12, Ben Dooks wrote:
>>> On 26/07/2022 11:05, Krzysztof Kozlowski wrote:
>>>> On 25/07/2022 23:21, Ben Dooks wrote:
>>>>> Add documentation for the bindings for Synopsys' DesignWare PWM block
>>>>> as we will be adding DT/platform support to the Linux driver soon.
>>>>>
>>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>>>> --
>>>>
>>>> This is not proper delimiter and causes the changelog to end up in commit.
>>>>
>>>> Correct also wrong formatting of subject PATCH.
>>>
>>> I realised that once sent and forgot the cover letter.
>>> Maybe I'll try some more post covid recovery.
>>>
>>>>> v2:
>>>>> - fix #pwm-cells to be 3
>>>>> - fix indentation and ordering issues
>>>>> ---
>>>>>    .../devicetree/bindings/pwm/snps,pwm.yaml     | 40 +++++++++++++++++++
>>>>>    1 file changed, 40 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..594085e5e26f
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>>> @@ -0,0 +1,40 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +# Copyright (C) 2022 SiFive, Inc.
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/pwm/snps,pwm.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Synopsys PWM controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Ben Dooks <ben.dooks@sifive.com>
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: pwm.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: snps,pwm
>>>>
>>>> This is very generic compatible. I doubt that you cover here all
>>>> Synopsys PWM designs, past and future. You need a specific compatible.
>>>
>>>   From what I can get from the documentation (2.13a) there hasn't been
>>> a huge external interface change and what has been added is all part
>>> of synthesis time options.
>>
>> But you have some specific version, right? Usually these blocks are
>> versioned, so you must include it. I would even argue that such generic
>> compatible should not be used as fallback at all, because it is simply
>> to generic (PWM is not some model name but common acronym),
> 
> I suppose dw-apb-timers is the actual document name, but that's already
> been used for the timer mode in a number of SoCs so probably isn't going
> to be useful. dw-apb-timers-pwm might be a better prefix if snps,pwm is
> not going to be acceptable. (Yes, the block can be built as either a
> PWM or a generic interrupt generating timer at IP generation time)
> 
> As for the version numbers, we could have the -v.vv suffix for these
> blocks, but the v2.xx log has 22 entries already and only one feature
> for programming (which is also a configurable one so can't be just
> enabled by default - it's the 0/100 mode flag in the control registers).
> 
> I'm not sure what the v1.xx timers had, but I don't have access to this
> information and we're getting these documents as second-generation so I
> am not sure if we can get a v1.xx at-all (I suspect this is also going
> to have a number of revisions and about 1 useful register api change
> which would be the "new mode" double counter method which we currently
> rely on having being implicitly enabled by the IP builder (again this
> feature is still something that can be configured on IP genaration))

But why would you need v1.xx documentation?

> 
> Given the configurability of the core, the version numbers might be
> usable at some point, but it does seem to be a lot of churn for what
> currently can be described by one boolean for the 0/100 feature that
> might-be available. Is there a way of saying the compatible string
> can be dw-apb-timers-pwm-2.[0-9][0-9][a-z] ?

I don't understand why. Aren't you documenting here only v2.13a version?

Best regards,
Krzysztof
