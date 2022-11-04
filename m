Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85EC619E2D
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Nov 2022 18:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKDRKp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Nov 2022 13:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiKDRKo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Nov 2022 13:10:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985AB3F06C
        for <linux-pwm@vger.kernel.org>; Fri,  4 Nov 2022 10:10:43 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w4so3446721qts.0
        for <linux-pwm@vger.kernel.org>; Fri, 04 Nov 2022 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id/m4PJka4ak4GkQ5lhsmXVKkGfCwtyssjK4t6uoVVs=;
        b=YpYUlOVpQsjVYotS+k/BFPz+cRTPQ5vTloCHMLkCjHLIfGt1sRcorDcdKrTfPQEiqk
         tC2r7PFLRgUCwyg1yxnLs8A+9AIKQOcEOYgfr9Y+fSccJ8E33COJ0Wjy9lAcAOJvCvMX
         loB9GS6Ij+dwj4Cx2LQrL7d14cRjVhkpy278zCiILi3y39khCqrq3MjXNlHREjjYIYnp
         a1a3fSrFoD0I8zrZ0aYVEMBlWH+OVySQK2urEgSOpF/+5CXZhLmJxTfew+OHQNpw19jr
         poS+XzDuYc/wZ8HPTLLkOvGfAoJYfWk64T9HxQJxZVkRKsXejYO5WnBGpiKXbFLObkOv
         ERoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=id/m4PJka4ak4GkQ5lhsmXVKkGfCwtyssjK4t6uoVVs=;
        b=DZDm8IvqZfYsuiY7C6mukTx64SdMyhGKPB81iP1XWmjt0RYknugMXU4HLpaiipEsx1
         GdrueQikKwrNe2tU0zEUcUgJuWcfn0OSwcOzyI4so/8WDkAUQgbRDPheTFEXeD7Q81uH
         oPw5fAbDTIkDgkmnTzk/dOKm4CAyB86gIbZIOkMuU3bmbk0ddJOnsB2hWd++W3YHx9Ir
         LF8RSsR/zBKee0YRaiiEk/Sf8nA8mm7W50c06Aep1jxDZfVJnCSQUU9eIHTm9nGdzf7z
         2MfIwswr9TSdUH4YQhnKuXp4uui0HGxZqXsvMm7g/8WH6e2zpyVFgx4T0zIJDyVR3btr
         T5aw==
X-Gm-Message-State: ACrzQf1FV6B3z6vvTqZUvjbHSoRCYTKpA26tv7vYPqdQVi/x1K1IT+NZ
        6ahjZOcrgIQ54fMIVJyXSuwE/g==
X-Google-Smtp-Source: AMsMyM48TwKakdoi9XI56ZSm+s+EMx3vzp3w+5I2ovZFXE5AyQzdRvdUY24WMzPQKglZPH02FN/pCA==
X-Received: by 2002:a05:622a:196:b0:3a5:40ab:592c with SMTP id s22-20020a05622a019600b003a540ab592cmr15386971qtw.103.1667581842757;
        Fri, 04 Nov 2022 10:10:42 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a29c900b006cec8001bf4sm3282124qkp.26.2022.11.04.10.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:10:42 -0700 (PDT)
Message-ID: <c0a6a3a1-c12d-75b4-fe1d-026ab0740b58@linaro.org>
Date:   Fri, 4 Nov 2022 13:10:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs
 property
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <20221104145938.1782464-1-biju.das.jz@bp.renesas.com>
 <20221104145938.1782464-3-biju.das.jz@bp.renesas.com>
 <dea44f32-e10f-0164-0175-4fe2e5d053a2@linaro.org>
 <OS0PR01MB5922D1D1143BB6F83A894D0E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB5922D1D1143BB6F83A894D0E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On 04/11/2022 12:52, Biju Das wrote:
> Hi Krzysztof Kozlowski,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Subject: Re: [PATCH 2/3] dt-bindings: pwm: rzg2l-gpt: Document
>> renesas,poegs property
>>
>> On 04/11/2022 10:59, Biju Das wrote:
>>> RZ/G2L GPT IP supports output pin disable function by dead time
>> error
>>> and detecting short-circuits between output pins.
>>>
>>> Add documentation for the optional property renesas,poegs to link a
>>> pair of GPT IOs with POEG.
>>>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 19
>> +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
>>> b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
>>> index 620d5ae4ae30..32f9deae89e5 100644
>>> --- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
>>> @@ -245,6 +245,24 @@ properties:
>>>    resets:
>>>      maxItems: 1
>>>
>>> +  renesas,poegs:
>>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
>>
>> No need for quotes.
>>
>>> +    items:
>>
>> You miss here maxItems... but if you have just one item, then below
>> "items" should be " - items"
>>
>>> +      items:
>>> +        - description: phandle to POEG instance that serves the
>> output disable
>>> +        - description: An index identifying pair of GPT channels.
>>> +                       <0> - GPT channels 0 and 1
>>> +                       <1> - GPT channels 2 and 3
>>> +                       <2> - GPT channels 4 and 5
>>> +                       <3> - GPT channels 6 and 7
>>> +                       <4> - GPT channels 8 and 9
>>> +                       <5> - GPT channels 10 and 11
>>> +                       <6> - GPT channels 12 and 13
>>> +                       <7> - GPT channels 14 and 15
>>
>> then this could bave enum or minimum/maximum. Can you try if these
>> work?
> 
> Yes, checks are passing with below changes.
> Will send V2 later once I get feedback for driver changes/ from other reviewers.
> 
> renesas,poegs:
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> +      maxItems: 8

and it might also require minItems: 1

Thank you for changes.

Best regards,
Krzysztof

