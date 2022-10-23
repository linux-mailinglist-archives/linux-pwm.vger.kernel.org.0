Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8D6092AE
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Oct 2022 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJWMjl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Oct 2022 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJWMjk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Oct 2022 08:39:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540611AF3D
        for <linux-pwm@vger.kernel.org>; Sun, 23 Oct 2022 05:39:37 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g11so4341991qts.1
        for <linux-pwm@vger.kernel.org>; Sun, 23 Oct 2022 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtMX72KLBH/oqLRTjw6ZoQ9HphAQ86EWlsGtUM1biLY=;
        b=rR/rt3NVFszMvYLvpbh47uWTrABK35J57rG52zoILjoYOQHkbtYIQh00iQYClie0y3
         sCYb3qtKGZKKMRBPmgZo7I11CTY9vQzNiVCsddF+NJZOCexBdZTDuaF8C6m6MeDWGz2O
         84EyKhN+R+tiDg6ry5Zdvs1k+t+MXLVaym1rOFvDqXWrcWGnmUJq66oAo/+lFVTGDDMF
         spjhWPgr0OSF5/bsWCOb6rye4DPS2NfoUmaAx1gMD9nI4erOCP2ngTq0bCkfJk765ytn
         Iewy/sCoyf6ANJUcQL/6zxpYlfx24FeRknl5AUVm3MfO92mZ/01G0gFEuI71TSFYPAqw
         rVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtMX72KLBH/oqLRTjw6ZoQ9HphAQ86EWlsGtUM1biLY=;
        b=H92DemtqPpP3DwVSZLA8uYm23Koymawjrg7aQeX6XFR1953vD5lDPG8Wu/qkvNqMBU
         Bli1qDxjKRC8R2CS4Hk/sI07sTbBYNzMQuEs+bmbrdcdeanR8BXXbt1FSXiJsptwDxzQ
         Z2VMAr1Jbs8vWACakUrAShAn2LNQESsCUi6YjWC0Eb2GuQRJWgjn5NXKIPI0/hA9ozn9
         o5xbdxsL1vLgV/81X7SnArsPBu/AxScp3htSIp5ONXYLjqONx/cgTPWyc6243JoLd5VO
         zQK5rMECJp4EgXwwrFV32VcYC22hIX1/u+uG+eeja4AAlEnyWG5fyuUmdr4ebAAsVmzE
         revg==
X-Gm-Message-State: ACrzQf1EQd8yUAtZJ1kEYNF3+6uUf21x+iEUKh49s0k9XCnR0MbihZ/I
        GGwEnXHySYfIRXrpsGwJrhD5lg==
X-Google-Smtp-Source: AMsMyM5ARqNAYBYplnOqSjtUrbcf4MWsV3uP/gieV6dYA025Qv5ID/SBR6x37ttDQse4hV7lX8FXIg==
X-Received: by 2002:a05:622a:138b:b0:39c:eb5a:5c33 with SMTP id o11-20020a05622a138b00b0039ceb5a5c33mr24003935qtk.412.1666528776446;
        Sun, 23 Oct 2022 05:39:36 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u30-20020a37ab1e000000b006ef0350db8asm7299556qke.128.2022.10.23.05.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 05:39:35 -0700 (PDT)
Message-ID: <eab019f7-f801-848e-80a3-5bb526d95d53@linaro.org>
Date:   Sun, 23 Oct 2022 08:39:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: pwm: mediatek: Add compatible string for
 MT7986
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <Y1K53n7LnjoMoIfj@makrotopia.org>
 <20221021222338.GA565200-robh@kernel.org> <Y1MkIdFXrBrrv958@makrotopia.org>
 <5182e3c4-9e5e-2c36-408b-9029c65c8803@linaro.org>
 <Y1UycU0JvwyAv0x2@makrotopia.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1UycU0JvwyAv0x2@makrotopia.org>
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

On 23/10/2022 08:24, Daniel Golle wrote:
> Hi Krzysztof,
> 
> On Sat, Oct 22, 2022 at 12:35:25PM -0400, Krzysztof Kozlowski wrote:
>> On 21/10/2022 18:58, Daniel Golle wrote:
>>> On Fri, Oct 21, 2022 at 05:23:38PM -0500, Rob Herring wrote:
>>>> On Fri, Oct 21, 2022 at 04:25:18PM +0100, Daniel Golle wrote:
>>>>> Add new compatible string for MT7986 PWM.
>>>>>
>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>> index 554c96b6d0c3e0..6f4e60c9e18b81 100644
>>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>> @@ -8,6 +8,7 @@ Required properties:
>>>>>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>>>>>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>>>>>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
>>>>> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
>>>>
>>>> This version of the PWM h/w is not compatible with any of the existing 
>>>> chips? If it is, it should have a fallback compatible.
>>>
>>> No, it is unique because it comes with just 2 PWM channels.
>>> Otherwise the driver behaves just like for MT8183 (4 channels) or
>>> MT8365 (3 channels) which also got distinct compatible strings.
>>
>> Then something would be here compatible. E.g. If you bound MT8183 with
>> mt7986-pwm compatible, would you get working device with two channels?
> 
> Yes, but I'd see another 2 channels which do not work, accessing them
> may even cause problems (I haven't tried that) as it means accessing
> an undocumented memory range of the SoC which we in general we
> shouldn't be messing around with.

Why on MT8183 there would be undocumented memory? Where is undocumented
memory?

> 
> Also note that this case is the same as MT8183 vs. MT8365, they got
> distinct compatible strings and also for those two the only difference
> is the number of channels.

So why they are not made compatible?

> 
>>
>> If so, they are compatible.
> 
> By that definition you should remove the additional compatible for
> MT8365 or rather, it should have been rejected for the same argument.
> 
> I'm talking about
> commit fe00faee8060402a3d85aed95775e16838a6dad2
> commit 394b517585da9fbb2eea2f2103ff47d37321e976

This is a pattern spreading in several Mediatek bindings and we already
commented on new patches. I don't know why people working on Mediatek do
not mark pieces compatible.

Best regards,
Krzysztof

